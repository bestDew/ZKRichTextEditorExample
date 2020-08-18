//
//  ZKRichTextImageModel.m
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/8/18.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import "ZKRichTextImageModel.h"
#import "ZKRichTextDefines.h"

@implementation ZKRichTextImageModel

@synthesize editing;

- (CGFloat)contentHeight {
    return ZKDefaultContentHeight;
}

- (NSString *)contentType {
    return ZKRichTextImageKey;
}

@end
