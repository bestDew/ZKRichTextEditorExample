//
//  NSObject+ZKSending.m
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/16.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import "NSObject+ZKSending.h"
#import "ZKSignal.h"
#import "ZKObserveCenter.h"
#import "NSObject+ZKSwizzling.h"
#import <objc/runtime.h>

static void *ZKObjectObservedKey = &ZKObjectObservedKey;

@interface NSObject ()

@property (nonatomic, assign) BOOL isObserved;

@end

@implementation NSObject (ZKSending)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:NSSelectorFromString(@"dealloc") withInstanceMethod:@selector(zk_dealloc)];
    });
}

- (void)zk_dealloc {
    if (self.isObserved) {
        [[ZKObserveCenter defaultCenter] unobserve:self];
    }
    [self zk_dealloc];
}

- (ZKSignal *)signalForKeyPath:(NSString *)keyPath {
    NSAssert(![self isKindOfClass:[ZKSignal class]], @"This method should not be called with a signal.");
    if ([self isKindOfClass:[ZKSignal class]]) {
        return nil;
    }
    self.isObserved = YES;
    return [[ZKObserveCenter defaultCenter] observe:self keyPath:keyPath];
}

- (void)disabledSignalForKeyPath:(NSString *)keyPath {
    NSAssert(![self isKindOfClass:[ZKSignal class]], @"This method should not be called with a signal. If you want to stop sending, you should use the sender of the signal to call this method.");
    if ([self isKindOfClass:[ZKSignal class]]) {
        return;
    }
    [[ZKObserveCenter defaultCenter] unobserve:self keyPath:keyPath];
}

- (void)disabledSignals {
    NSAssert(![self isKindOfClass:[ZKSignal class]], @"This method should not be called with a signal. If you want to stop sending, you should use the sender of the signal to call this method.");
    if ([self isKindOfClass:[ZKSignal class]]) {
        return;
    }
    [[ZKObserveCenter defaultCenter] unobserve:self];
}

- (BOOL)isObserved {
    return [objc_getAssociatedObject(self, ZKObjectObservedKey) boolValue];
}

- (void)setIsObserved:(BOOL)isObserved {
    objc_setAssociatedObject(self, ZKObjectObservedKey, @(isObserved), OBJC_ASSOCIATION_ASSIGN);
}

@end
