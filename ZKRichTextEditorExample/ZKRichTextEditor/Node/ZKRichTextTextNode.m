//
//  ZKRichTextTextNode.m
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/20.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import "ZKRichTextTextNode.h"

@implementation ZKRichTextTextNode

- (instancetype)initWithText:(NSString *)text {
    if (self = [super init]) {
        _text = text;
    }
    return self;
}

- (instancetype)init {
    return [self initWithText:nil];
}

- (void)setTextHeight:(CGFloat)textHeight {
    _textHeight = MAX(ZKDefaultContentHeight, textHeight);
}

- (CGFloat)contentHeight {
    return _textHeight;
}

- (NSString *)type {
    return ZKRichTextTextKey;
}

@end
