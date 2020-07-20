//
//  ZKRichTextImageNode.m
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/20.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import "ZKRichTextImageNode.h"

@implementation ZKRichTextImageNode

- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super init]) {
        _image = image;
        _imageRect = CGRectZero;
    }
    return self;
}

- (instancetype)init {
    return [self initWithImage:nil];
}

- (NSString *)type {
    return ZKRichTextImageKey;
}

@end
