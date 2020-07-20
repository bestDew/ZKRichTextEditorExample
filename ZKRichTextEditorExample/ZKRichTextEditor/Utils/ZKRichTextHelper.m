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

+ (CGFloat)heightForText:(NSString *)text font:(UIFont *)font fixedWidth:(CGFloat)width {
    if (text.length == 0) {
        return 0.f;
    }
    
    static ZKTextView *textView;
    if (textView == nil) {
        textView = [[ZKTextView alloc] init];
        textView.scrollEnabled = NO;
    }
    textView.font = font;
    textView.text = text;

    CGFloat height = flat([textView sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)].height);
    
    textView.font = nil;
    textView.text = nil;
    
    return height;
}

+ (CGRect)rectForImage:(UIImage *)image fixedWidth:(CGFloat)width {
    if (image == nil) {
        return CGRectZero;
    }
    CGFloat imageWidth = MIN(width, image.size.width);
    CGFloat imageHeight = imageWidth * image.size.width / image.size.height;
    CGFloat imageX = (width - imageWidth) / 2;
    
    return CGRectMake(imageX, 0.f, imageWidth, imageHeight);
}

@end
