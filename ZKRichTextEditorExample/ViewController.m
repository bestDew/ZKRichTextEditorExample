//
//  ViewController.m
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/15.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import "ViewController.h"
#import "ZKRichTextEditor.h"

@interface ViewController () <ZKTextViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZKTextView *textView = [[ZKTextView alloc] initWithFrame:CGRectMake(0.f, 0.f, 300.f, 36.f)];
    textView.center = self.view.center;
    textView.scrollEnabled = NO;
    textView.delegate = self;
    textView.font = [UIFont systemFontOfSize:17.f];
    textView.placeholder = @"请输入文字";
//    textView.maximumTextLength = 10;
    textView.layer.borderWidth = 1.f;
    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:textView];
}

- (void)textViewDidDeleteBackward:(ZKTextView *)textView {
    NSLog(@"点击了键盘删除键：%@", textView.text);
}

- (void)textViewDidExceedMaximumTextLength:(ZKTextView *)textView {
    NSLog(@"超出文本最大限制");
}

- (void)textViewDidReturn:(ZKTextView *)textView {
    NSLog(@"点击了键盘 Return 键");
}

- (void)textView:(ZKTextView *)textView didChangeContentHeight:(CGFloat)height {
    CGRect rect = textView.frame;
    rect.size.height = height;
    textView.frame = rect;
}

@end
