//
//  ZKRichTextHelper.h
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/20.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZKRichTextHelper : NSObject

/// 计算 textView 中文本高度
/// @param text 要计算高度的文本
/// @param font 文本字体
/// @param width textView 宽度
+ (CGFloat)heightForText:(nullable NSString *)text
                   font:(UIFont *)font
              fixedWidth:(CGFloat)width;

/// 计算固定宽度下图片的大小
/// @param image 要计算大小的图片
/// @param width 图片宽度
+ (CGRect)rectForImage:(nullable UIImage *)image fixedWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
