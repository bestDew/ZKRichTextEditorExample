//
//  UIButton+ZKSignal.m
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/16.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import "UIButton+ZKSignal.h"
#import "ZKSignal.h"
#import "UIControl+ZKSignal.h"


@implementation UIButton (ZKSignal)

- (ZKSignal *)clickedSignal {
    return [self signalForControlEvents:UIControlEventTouchUpInside];
}

@end
