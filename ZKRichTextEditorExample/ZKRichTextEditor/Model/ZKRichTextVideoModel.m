//
//  ZKRichTextVideoModel.m
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/8/18.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import "ZKRichTextVideoModel.h"
#import "ZKRichTextDefines.h"

@implementation ZKRichTextVideoModel

@synthesize editing;

- (CGFloat)contentHeight {
    return ZKDefaultContentHeight;
}

- (NSString *)contentType {
    return ZKRichTextVideoKey;
}

@end
