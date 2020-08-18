//
//  ZKObserveCenter.m
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/15.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import "ZKObserveCenter.h"
#import "ZKSignal.h"
#import <pthread/pthread.h>

@interface _ZKObserveInfo : NSObject
{
    @public
    NSString *_keyPath;
    ZKSignal *_signal;
}
@end

@implementation _ZKObserveInfo

- (instancetype)initWithKeyPath:(NSString *)keyPath {
    if (self = [super init]) {
        _keyPath = [keyPath copy];
    }
    return self;
}

- (NSUInteger)hash {
    return [_keyPath hash];
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
    return [_keyPath isEqualToString:((_ZKObserveInfo *)object)->_keyPath];
}

@end

@implementation ZKObserveCenter
{
    pthread_mutex_t _lock;
    NSMapTable<id, NSHashTable<_ZKObserveInfo *> *> *_map;
}

+ (instancetype)defaultCenter {
    static ZKObserveCenter *center = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center = [[ZKObserveCenter alloc] init];
    });
    return center;
}

- (instancetype)init {
    if (self = [super init]) {
        _map = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsOpaqueMemory valueOptions:NSPointerFunctionsStrongMemory capacity:0];
        pthread_mutex_init(&_lock, NULL);
    }
    return self;
}

- (void)dealloc {
    pthread_mutex_destroy(&_lock);
}

- (ZKSignal *)observe:(id)object keyPath:(NSString *)keyPath {
    NSAssert(keyPath.length != 0, @"Observe missing required parameters object:%@ keyPath:%@", object, keyPath);
    if (object == nil || keyPath.length == 0) {
        return nil;
    }
    
    _ZKObserveInfo *info = [[_ZKObserveInfo alloc] initWithKeyPath:keyPath];

    pthread_mutex_lock(&_lock);
    NSHashTable *table = [_map objectForKey:object];
    if (table) {
        _ZKObserveInfo *existing = [table member:info];
        if (existing) {
            pthread_mutex_unlock(&_lock);
            return existing->_signal;
        }
        info->_signal = [[ZKSignal alloc] init];
        [table addObject:info];
    } else {
        table = [[NSHashTable alloc] initWithOptions:(NSPointerFunctionsStrongMemory | NSPointerFunctionsObjectPersonality) capacity:0];
        info->_signal = [[ZKSignal alloc] init];
        [table addObject:info];
        [_map setObject:table forKey:object];
    }
    pthread_mutex_unlock(&_lock);

    [object addObserver:self forKeyPath:keyPath options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial) context:(void *)info];
    
    return info->_signal;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSAssert(context, @"Observe missing context keyPath:%@ object:%@ change:%@", keyPath, object, change);
    
    _ZKObserveInfo *info;
    {
        pthread_mutex_lock(&_lock);
        info = (__bridge _ZKObserveInfo *)context;
        pthread_mutex_unlock(&_lock);
    }
    
    if (info == nil || info->_signal == nil) {
        return;
    }
    
    id value = change[NSKeyValueChangeNewKey];
    [info->_signal transmit:value];
}

- (void)unobserve:(id)object keyPath:(NSString *)keyPath {
    NSAssert(object != nil && keyPath.length != 0, @"Unobserve missing required parameters unobserve:%@ keyPath:%@", object, keyPath);
    if (object == nil || keyPath.length == 0) {
        return;
    }
    
    _ZKObserveInfo *info = [[_ZKObserveInfo alloc] initWithKeyPath:keyPath];
    
    pthread_mutex_lock(&_lock);
    NSHashTable *table = [_map objectForKey:object];
    _ZKObserveInfo *existing = [table member:info];
    if (existing == nil) {
        pthread_mutex_unlock(&_lock);
        return;
    }
    [table removeObject:info];
    if (table.count == 0) {
        [_map removeObjectForKey:object];
    }
    pthread_mutex_unlock(&_lock);

    [object removeObserver:self forKeyPath:keyPath];
}

- (void)unobserve:(id)object {
    NSAssert(object != nil, @"Unobserve missing required parameters unobserve:%@", object);
    if (object == nil) {
        return;
    }
    
    pthread_mutex_lock(&_lock);
    NSHashTable *table = [_map objectForKey:object];
    if (table == nil) {
        pthread_mutex_unlock(&_lock);
        return;
    }
    _ZKObserveInfo *info;
    NSEnumerator *enumerator = [table objectEnumerator];
    while (info = [enumerator nextObject]) {
        [object removeObserver:self forKeyPath:info->_keyPath];
    }
    [_map removeObjectForKey:object];
    pthread_mutex_unlock(&_lock);
}

- (void)unobserveAll {
    id object;
    pthread_mutex_lock(&_lock);
    NSEnumerator *enumerator = [_map keyEnumerator];
    while (object = [enumerator nextObject]) {
        NSHashTable *table = [_map objectForKey:object];
        _ZKObserveInfo *info;
        NSEnumerator *enumerator = [table objectEnumerator];
        while (info = [enumerator nextObject]) {
            [object removeObserver:self forKeyPath:info->_keyPath];
        }
    }
    [_map removeAllObjects];
    pthread_mutex_unlock(&_lock);
}

@end
