//
//  ZKRichTextHelper.m
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/20.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import "ZKRichTextHelper.h"
#import "ZKTextView.h"
#import "ZKRichTextDefines.h"

@implementation ZKRichTextHelper

+ (CGFloat)precomputeTextHeight:(NSString *)text {
    return 0;
}

+ (ZKTextView *)textView {
    static ZKTextView *textView;
    if (textView == nil) {
        textView = [[ZKTextView alloc] init];
    }
    return textView;
}

@end
