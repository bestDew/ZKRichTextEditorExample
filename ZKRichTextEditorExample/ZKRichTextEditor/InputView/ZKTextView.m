//
//  ZKTextView.m
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/16.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import "ZKTextView.h"
#import "ZKRichTextDefines.h"

@interface ZKTextView ()

@property (nonatomic, copy) NSString *previousText;
@property (nonatomic, strong) UILabel *placeholderLabel;

@end

@implementation ZKTextView

@dynamic delegate;

#pragma mark -- Override
- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        
        [self _defaultConfig];
        [self _setupPlaceholderLabel];
        [self _addTextDidChangeNotification];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer {
    if (self = [super initWithFrame:frame textContainer:textContainer]) {
        
        [self _defaultConfig];
        [self _setupPlaceholderLabel];
        [self _addTextDidChangeNotification];
    }
    return self;
}
    
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self _resetPlaceholerFrame];
}

- (void)deleteBackward {
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(textViewDidDeleteBackward:)]) {
        [self.delegate textViewDidDeleteBackward:self];
    }
    [super deleteBackward];
}

#pragma mark -- Private
- (void)_defaultConfig {
    _maximumTextLength = NSUIntegerMax;
    _placeholderColor = [UIColor lightGrayColor];
    self.scrollsToTop = NO;
    if (@available(iOS 11, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

- (void)_setupPlaceholderLabel {
    _placeholderLabel = [[UILabel alloc] init];
    _placeholderLabel.textColor = _placeholderColor;
    _placeholderLabel.font = [UIFont systemFontOfSize:12.f];
    [self addSubview:_placeholderLabel];
}

- (void)_addTextDidChangeNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_textDidChange:) name:UITextViewTextDidChangeNotification object:self];
}

- (void)_resetPlaceholerFrame {
    _placeholderLabel.frame = ({
        UIEdgeInsets insets = self.textContainerInset;
        CGFloat x = insets.left + 5.f;
        CGFloat y = insets.top - 1.f;
        CGFloat width = self.bounds.size.width - insets.left - insets.right;
        CGFloat height = _placeholderLabel.font.lineHeight + 2.f;
        CGRectMake(x, y, width, height);
    });
}

- (void)_textDidChange:(NSNotification *)notification {
    NSString *toBeString = self.text;
    _placeholderLabel.alpha = (toBeString.length == 0);
    
    if ([toBeString isEqualToString:_previousText] ||
        (toBeString.length == 0 && _previousText.length == 0)) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(textView:didChangeContentHeight:)]) {
        CGFloat height = flat([self sizeThatFits:CGSizeMake(CGRectGetWidth(self.bounds), CGFLOAT_MAX)].height);
        if (height != flat(CGRectGetHeight(self.bounds))) {
            [self.delegate textView:self didChangeContentHeight:height];
        }
    }
    NSString *primaryLanguage = self.textInputMode.primaryLanguage;
    if ([primaryLanguage isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = self.markedTextRange;
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        if (position != nil) {
            return;
        }
    }
    NSString *addedText;
    if (toBeString.length > _previousText.length) { // 说明在输入
        addedText = [toBeString substringFromIndex:_previousText.length];
        if ([addedText isEqualToString:@"\n"]) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(textViewDidReturn:)]) {
                [self.delegate textViewDidReturn:self];
            }
        }
    }
    _previousText = self.text;
    
    if (toBeString.length <= _maximumTextLength) {
        return;
    }
    NSRange range = [toBeString rangeOfComposedCharacterSequenceAtIndex:_maximumTextLength];
    self.text = [toBeString substringToIndex:range.location];
    if (self.delegate && [self.delegate respondsToSelector:@selector(textViewDidExceedMaximumTextLength:)]) {
        [self.delegate textViewDidExceedMaximumTextLength:self];
    }
}

#pragma mark -- Setter
- (void)setText:(NSString *)text {
    NSString *textBeforeChange = self.text;
    if ([textBeforeChange isEqualToString:text] ||
        (textBeforeChange.length == 0 && text == nil)) {
        [super setText:text];
        return;
    }
    BOOL shouldChangeText = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        shouldChangeText = [self.delegate textView:self shouldChangeTextInRange:NSMakeRange(0, textBeforeChange.length) replacementText:text];
    }
    if (!shouldChangeText) {
        return; // 不应该改变文字，所以连 super 都不调用，直接结束方法
    }
    
    [super setText:text];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.delegate textViewDidChange:self];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    NSString *textBeforeChange = self.attributedText.string;
    if ([textBeforeChange isEqualToString:attributedText.string] ||
        (textBeforeChange.length == 0 && attributedText.string == nil)) {
        [super setAttributedText:attributedText];
        return;
    }
    BOOL shouldChangeText = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        shouldChangeText = [self.delegate textView:self shouldChangeTextInRange:NSMakeRange(0, textBeforeChange.length) replacementText:attributedText.string];
    }
    if (!shouldChangeText) {
        return; // 不应该改变文字，所以连 super 都不调用，直接结束方法
    }
    
    [super setAttributedText:attributedText];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.delegate textViewDidChange:self];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    _placeholderLabel.font = font;
    [self setNeedsLayout];
}

- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset {
    [super setTextContainerInset:textContainerInset];
    [self setNeedsLayout];
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    _placeholderLabel.text = placeholder;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    _placeholderLabel.textColor = placeholderColor;
}

@end
