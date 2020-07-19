//
//  UIRefreshControl+ZKSignal.m
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/16.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import "UIRefreshControl+ZKSignal.h"
#import "ZKSignal.h"
#import "UIControl+ZKSignal.h"
#import "NSObject+ZKSwizzling.h"
#import <objc/message.h>

@implementation UIRefreshControl (ZKSignal)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:@selector(beginRefreshing) withInstanceMethod:@selector(zk_beginRefreshing)];
    });
}

- (void)zk_beginRefreshing {
    [self zk_beginRefreshing];
    
    SEL sel = NSSelectorFromString(@"_action:");
    objc_msgSend(self, sel, self);
}

- (ZKSignal *)refreshSignal {
    return [self signalForControlEvents:UIControlEventValueChanged];
}

@end
