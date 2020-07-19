//
//  UITextField+ZKSignal.m
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/16.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import "UITextField+ZKSignal.h"
#import "ZKSignal.h"
#import "UIControl+ZKSignal.h"

@implementation UITextField (ZKSignal)

- (ZKSignal *)textSignal {
    return [self signalForControlEvents:UIControlEventEditingChanged];
}

- (void)_action:(id)sender {
    [self.textSignal transmit:self.text];
}

@end
