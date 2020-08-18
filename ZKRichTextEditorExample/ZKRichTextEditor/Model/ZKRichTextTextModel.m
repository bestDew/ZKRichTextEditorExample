//
//  ZKRichTextTextModel.m
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/8/18.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import "ZKRichTextTextModel.h"
#import "ZKRichTextDefines.h"
#import "ZKRichTextHelper.h"

@implementation ZKRichTextTextModel
{
    CGFloat _textHeight;
}

#pragma mark -- ZKRichTextModel

@synthesize editing;

- (CGFloat)contentHeight {
    return MAX(ZKDefaultContentHeight, _textHeight);
}

- (NSString *)contentType {
    return ZKRichTextTextKey;
}

#pragma mark -- API
- (instancetype)initWithText:(NSString *)text placeholder:(NSString *)placeholder {
    if (self = [super init]) {
        self.text = [text copy];
        self.placeholder = [placeholder copy];
    }
    return self;
}

+ (instancetype)modelWithText:(NSString *)text placeholder:(NSString *)placeholder {
    return [[self alloc] initWithText:text placeholder:placeholder];
}

- (instancetype)init {
    return [self initWithText:nil placeholder:nil];
}

- (void)setText:(NSString *)text {
    _text = text;
    //_textHeight = [ZKRichTextHelper heightForText:text font:<#(nonnull UIFont *)#> fixedWidth:<#(CGFloat)#>];
}

@end
