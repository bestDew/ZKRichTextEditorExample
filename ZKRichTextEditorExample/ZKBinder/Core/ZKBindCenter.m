//
//  ZKBindCenter.m
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/16.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import "ZKBindCenter.h"
#import "ZKSignal.h"
#import <pthread/pthread.h>

@implementation ZKBindCenter
{
    pthread_mutex_t _lock;
    NSMapTable<ZKSignal *, NSHashTable *> *_map;
}

+ (instancetype)defaultCenter {
    static ZKBindCenter *center = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center = [[ZKBindCenter alloc] init];
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

- (void)bindReceiver:(id)receiver forSignal:(ZKSignal *)signal {
    NSAssert(receiver != nil && signal != nil, @"Bind missing required parameters receiver:%@, signal:%@", receiver, signal);
    if (receiver == nil || signal == nil) {
        return;
    }
    
    id recCopy = [receiver copy];
    
    pthread_mutex_lock(&_lock);
    NSHashTable *table = [_map objectForKey:signal];
    if (table) {
        id existing = [table member:recCopy];
        if (existing) {
            pthread_mutex_unlock(&_lock);
            return;
        }
        [table addObject:recCopy];
    } else {
        table = [[NSHashTable alloc] initWithOptions:(NSPointerFunctionsStrongMemory | NSPointerFunctionsObjectPersonality) capacity:0];
        [table addObject:recCopy];
        [_map setObject:table forKey:signal];
    }
    pthread_mutex_unlock(&_lock);
}

- (void)unbindReceiver:(id)receiver forSignal:(ZKSignal *)signal {
    NSAssert(receiver != nil && signal != nil, @"Unbind missing required parameters receiver:%@, signal:%@", receiver, signal);
    if (receiver == nil || signal == nil) {
        return;
    }
    
    id recCopy = [receiver copy];
    
    pthread_mutex_lock(&_lock);
    NSHashTable *table = [_map objectForKey:signal];
    if (table == nil) {
        pthread_mutex_unlock(&_lock);
        return;
    }
    id element;
    NSEnumerator *enumerator = [table objectEnumerator];
    while (element = [enumerator nextObject]) {
        if ([element isEqual:recCopy]) {
            [table removeObject:recCopy];
            break;
        }
    }
    if (table.count == 0) {
        [_map removeObjectForKey:signal];
    }
    pthread_mutex_unlock(&_lock);
}

- (void)unbindReceiversForSignal:(ZKSignal *)signal {
    NSAssert(signal != nil, @"Unbind missing required parameters signal:%@", signal);
    if (signal == nil) {
        return;
    }
    
    pthread_mutex_lock(&_lock);
    [_map removeObjectForKey:signal];
    pthread_mutex_unlock(&_lock);
}

- (void)unbindAllReceivers {
    pthread_mutex_lock(&_lock);
    [_map removeAllObjects];
    pthread_mutex_unlock(&_lock);
}

- (NSSet *)receiversForSignal:(ZKSignal *)signal {
    NSAssert(signal != nil, @"Get objects missing required parameters signal:%@", signal);
    if (signal == nil) {
        return nil;
    }
    
    NSSet *objects;
    {
        pthread_mutex_lock(&_lock);
        objects = [[_map objectForKey:signal] setRepresentation];
        pthread_mutex_unlock(&_lock);
    }
    
    return objects;
}

@end
