//
//  ZKRichTextEditorConfiguration.h
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/8/18.
//  Copyright © 2020 bestdew. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface ZKRichTextEditorConfiguration : NSObject

/// 文本字体（默认：[UIFont systemFontOfSize:15.f]）
@property (null_resettable, nonatomic, strong) UIFont *font;

/// 决定了：光标颜色、图片及视频选中边框颜色（默认：[UIColor blueColor]）
@property (null_resettable, nonatomic, strong) UIColor *tintColor;

/// 可输入的最大文本字数，设置为：NSUIntegerMax，表示不限制（默认：1000）
@property (nonatomic, assign) NSUInteger maximumTextLength;

/// 可插入的最大图片数量，设置为：NSUIntegerMax，表示不限制（默认：9）
@property (nonatomic, assign) NSUInteger maximumImageCount;

/// 可插入的最大视频数量，设置为：NSUIntegerMax，表示不限制（默认：3）
@property (nonatomic, assign) NSUInteger maximumVideoCount;

/// 内容边缘留白（默认：UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f)）
@property (nonatomic, assign) UIEdgeInsets contentInsets;

+ (instancetype)defaultConfiguration;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
