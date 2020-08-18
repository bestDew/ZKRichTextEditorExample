//
//  ZKRichTextDefines.h
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/19.
//  Copyright © 2020 bestdew. All rights reserved.
//

#ifndef ZKRichTextDefines_h
#define ZKRichTextDefines_h

#define ZK_SCREEN_SCALE  ([[UIScreen mainScreen] scale])
#define ZK_SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define ZK_SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#import <UIKit/UIKit.h>

static CGFloat const ZKDefaultContentHeight = 36.f;

static NSString * const ZKRichTextTextKey  = @"ZKRichTextTextKey";
static NSString * const ZKRichTextImageKey = @"ZKRichTextImageKey";
static NSString * const ZKRichTextVideoKey = @"ZKRichTextVideoKey";

CG_INLINE CGFloat
flat(CGFloat floatValue) {
    floatValue = (floatValue == CGFLOAT_MIN) ? 0.f : floatValue;
    CGFloat flattedValue = ceil(floatValue * ZK_SCREEN_SCALE) / ZK_SCREEN_SCALE;
    return flattedValue;
}

#endif /* ZKRichTextDefines_h */
