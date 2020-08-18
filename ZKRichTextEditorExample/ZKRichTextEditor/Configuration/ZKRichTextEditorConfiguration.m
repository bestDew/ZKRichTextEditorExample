//
//  ZKRichTextEditorConfiguration.m
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/8/18.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import "ZKRichTextEditorConfiguration.h"

@implementation ZKRichTextEditorConfiguration

+ (instancetype)defaultConfiguration {
    static ZKRichTextEditorConfiguration *configuration = nil;
    if (configuration == nil) {
        configuration = [[self alloc] init];
        [configuration configDefaultValue];
    }
    return configuration;
}

- (void)configDefaultValue {
    _font = [UIFont systemFontOfSize:15.f];
    _tintColor = [UIColor blueColor];
    
    _maximumTextLength = 1000;
    _maximumImageCount = 9;
    _maximumVideoCount = 3;
    
    _contentInsets = UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f);
}

- (void)setFont:(UIFont *)font {
    if (font == nil) {
        font = [UIFont systemFontOfSize:15.f];
    }
    _font = font;
}

- (void)setTintColor:(UIColor *)tintColor {
    if (tintColor == nil) {
        tintColor = [UIColor blueColor];
    }
    _tintColor = tintColor;
}

@end
