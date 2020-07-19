//
//  ZKTextView.h
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/16.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZKTextView;

@protocol ZKTextViewDelegate <UITextViewDelegate>

@optional
/// 当点击键盘上的 return 按钮时会触发此回调
- (void)textViewDidReturn:(ZKTextView *)textView;
/// 当点击键盘上的删除按钮时会触发此回调
- (void)textViewDidDeleteBackward:(ZKTextView *)textView;
/// 当输出超过最大字数限制时会触发此回调
- (void)textViewDidExceedMaximumTextLength:(ZKTextView *)textView;
/// 当内容高度发生变化时会触发此回调
- (void)textView:(ZKTextView *)textView didChangeContentHeight:(CGFloat)height;

@end

@interface ZKTextView : UITextView

@property(nonatomic, weak) id<ZKTextViewDelegate> delegate;
/// 占位文字
@property(nonatomic, copy) IBInspectable NSString *placeholder;
/// 占位文字颜色
@property(nonatomic, strong) IBInspectable UIColor *placeholderColor;
/// 输入的最大字数，默认 NSUIntegerMax，即不限制字数
@property(nonatomic, assign) IBInspectable NSUInteger maximumTextLength;

@end

NS_ASSUME_NONNULL_END
