//
//  ZKSignal.m
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/15.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import "ZKSignal.h"
#import "ZKMacros.h"
#import "ZKBindCenter.h"

@interface _ZKReceiveObjectInfo : NSObject <NSCopying>
{
    @public
    id _nilValue;
    NSString *_keyPath;
    ZKFilterBlock _filterBlock;
    __unsafe_unretained NSObject *_object;
}
@end

@implementation _ZKReceiveObjectInfo

- (instancetype)initWithObject:(NSObject *)object keyPath:(nullable NSString *)keyPath nilValue:(nullable id)nilValue {
    if (self = [super init]) {
        _object = object;
        _keyPath = [keyPath copy];
        _nilValue = nilValue;
    }
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    _ZKReceiveObjectInfo *objectInfo = [[_ZKReceiveObjectInfo allocWithZone:zone] initWithObject:_object keyPath:_keyPath nilValue:_nilValue];
    objectInfo->_filterBlock = _filterBlock;
    return objectInfo;
}

- (NSUInteger)hash {
    return [_object hash] ^ [_keyPath hash];
}

- (BOOL)isEqual:(id)object {
    if (object == nil) {
        return NO;
    }
    if (object == self) {
        return YES;
    }
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    BOOL isSameObject = (((_ZKReceiveObjectInfo *)object)->_object == _object);
    BOOL isSameKeyPath = [_keyPath isEqualToString:((_ZKReceiveObjectInfo *)object)->_keyPath];
    
    return isSameObject && isSameKeyPath;
}

@end

@interface _ZKReceiveBlockInfo : NSObject <NSCopying>
{
    @public
    ZKFilterBlock _filterBlock;
    ZKReceiveBlock _receiveBlock;
}
@end

@implementation _ZKReceiveBlockInfo

- (instancetype)initWithReceiveBlock:(ZKReceiveBlock)block {
    if (self = [super init]) {
        _receiveBlock = [block copy];
    }
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    _ZKReceiveBlockInfo *blockInfo = [[_ZKReceiveBlockInfo allocWithZone:zone] initWithReceiveBlock:_receiveBlock];
    blockInfo->_filterBlock = _filterBlock;
    return blockInfo;
}

- (NSUInteger)hash {
    return [_receiveBlock hash];
}

- (BOOL)isEqual:(id)object {
    if (object == nil) {
        return NO;
    }
    if (object == self) {
        return YES;
    }
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return (((_ZKReceiveBlockInfo *)object)->_receiveBlock == _receiveBlock);
}

@end

@implementation ZKSignal
{
    ZKFilterBlock _filter;
}

- (id)copyWithZone:(NSZone *)zone {
    ZKSignal *signal = [[ZKSignal allocWithZone:zone] init];
    signal->_filter = _filter;
    return signal;
}

- (void)dealloc {
    [[ZKBindCenter defaultCenter] unbindReceiversForSignal:self];
}

- (void)transmit:(id)value {
    id object;
    id safeValue = NullSafe(value);
    
    NSSet *receivers = [[ZKBindCenter defaultCenter] receiversForSignal:self];
    NSEnumerator *enumerator = [receivers objectEnumerator];
    
    while (object = [enumerator nextObject]) {
        if ([object isKindOfClass:[_ZKReceiveObjectInfo class]]) {
            BOOL noFiltering = YES;
            _ZKReceiveObjectInfo *objectInfo = object;
            if (objectInfo->_filterBlock) {
                noFiltering = (objectInfo->_filterBlock)(safeValue);
            }
            if (!noFiltering) {
                continue;
            }
            if (objectInfo->_nilValue && safeValue == nil) {
                safeValue = objectInfo->_nilValue;
            }
            [objectInfo->_object setValue:safeValue forKeyPath:objectInfo->_keyPath];
        } else {
            BOOL noFiltering = YES;
            _ZKReceiveBlockInfo *blockInfo = object;
            if (blockInfo->_filterBlock) {
                noFiltering = (blockInfo->_filterBlock)(safeValue);
            }
            if (!noFiltering) {
                continue;
            }
            (blockInfo->_receiveBlock)(safeValue);
        }
    }
}

- (void)bindObject:(id)object forKeyPayh:(NSString *)keyPath nilValue:(id)nilValue {
    _ZKReceiveObjectInfo *objectInfo = [[_ZKReceiveObjectInfo alloc] initWithObject:object keyPath:keyPath nilValue:nilValue];
    if (_filter) {
        objectInfo->_filterBlock = [_filter copy];
        _filter = nil;
    }
    [[ZKBindCenter defaultCenter] bindReceiver:objectInfo forSignal:self];
}

- (void)unbindObject:(id)object forKeyPath:(nullable NSString *)keyPath {
    id receiver = object;
    if ([receiver isKindOfClass:[_ZKReceiveObjectInfo class]]) {
        receiver = [[_ZKReceiveObjectInfo alloc] initWithObject:object keyPath:keyPath nilValue:nil];
    } else {
        receiver = [[_ZKReceiveBlockInfo alloc] initWithReceiveBlock:object];
    }
    [[ZKBindCenter defaultCenter] unbindReceiver:receiver forSignal:self];
}

- (void)unbindObject:(id)object {
    id receiver = object;
    if ([receiver isKindOfClass:[_ZKReceiveObjectInfo class]]) {
        id element;
        NSSet *receivers = [[ZKBindCenter defaultCenter] receiversForSignal:self];
        NSEnumerator *enumerator = [receivers objectEnumerator];
        while (element = [enumerator nextObject]) {
            if ([element isKindOfClass:[_ZKReceiveObjectInfo class]]) {
                [[ZKBindCenter defaultCenter] unbindReceiver:element forSignal:self];
            }
        }
    } else {
        receiver = [[_ZKReceiveBlockInfo alloc] initWithReceiveBlock:object];
        [[ZKBindCenter defaultCenter] unbindReceiver:receiver forSignal:self];
    }
}

- (void)unbindAllObjects {
    [[ZKBindCenter defaultCenter] unbindReceiversForSignal:self];
}

- (void)receive:(ZKReceiveBlock)block {
    NSAssert(block != nil, @"unbind missing required parameters block:%@", block);
    if (block == nil) {
        return;
    }
    _ZKReceiveBlockInfo *blockInfo = [[_ZKReceiveBlockInfo alloc] initWithReceiveBlock:block];
    if (_filter) {
        blockInfo->_filterBlock = [_filter copy];
        _filter = nil;
    }
    [[ZKBindCenter defaultCenter] bindReceiver:blockInfo forSignal:self];
}

@end

@implementation ZKSignal (Operations)

- (instancetype)filter:(ZKFilterBlock)block {
    NSAssert(block != nil, @"filter missing required parameters block:%@", block);
    if (block) {
        _filter = [block copy];
    }
    return self;
}

- (void)combine:(ZKSignal *)signal reduce:(void (^)(id _Nullable value1, id _Nullable value2))block {
    NSAssert(signal != nil && block != nil, @"combine missing required parameters signal:%@, block:%@", signal, block);
    if (block == nil) {
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:2];
    
    @synchronized (self) {
        [dict setObject:[NSNull null] forKey:@"1"];
        [dict setObject:[NSNull null] forKey:@"2"];
        
        [self receive:^(id  _Nullable value) {
            id value1 = value ?: [NSNull null];
            id value2 = NullSafe(dict[@"2"]);
            [dict setObject:value1 forKey:@"1"];
            block(value1, value2);
        }];
        [signal receive:^(id  _Nullable value) {
            id value1 = NullSafe(dict[@"1"]);
            id value2 = value ?: [NSNull null];
            [dict setObject:value2 forKey:@"2"];
            block(value1, value2);
        }];
    }
}

@end

@implementation ZKSignal (Description)

- (BOOL)isUseless {
    return ([[ZKBindCenter defaultCenter] receiversForSignal:self].count == 0);
}

@end
