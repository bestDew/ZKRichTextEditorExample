//
//  UIControl+ZKSignal.m
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/16.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import "UIControl+ZKSignal.h"
#import "ZKSignal.h"
#import <objc/runtime.h>

static void *UIControlSignalKey = &UIControlSignalKey;

@implementation UIControl (ZKSignal)

- (ZKSignal *)signalForControlEvents:(UIControlEvents)controlEvents {
    ZKSignal *signal = objc_getAssociatedObject(self, UIControlSignalKey);
    if (signal == nil) {
        signal = [[ZKSignal alloc] init];
        objc_setAssociatedObject(self, UIControlSignalKey, signal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    [self addTarget:self action:@selector(_action:) forControlEvents:controlEvents];
    
    return signal;
}

- (void)_action:(id)sender {
    ZKSignal *signal = objc_getAssociatedObject(self, UIControlSignalKey);
    if (signal == nil) {
        return;
    }
    [signal transmit:self];
}

@end
