//
//  ZKRichTextTextNode.h
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/20.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import "ZKRichTextNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZKRichTextTextNode : ZKRichTextNode

@property (nullable, nonatomic, copy) NSString *text;
@property (nullable, nonatomic, copy) NSString *placeholder;

@property (nonatomic, assign) NSRange selectedRange;

- (instancetype)initWithText:(nullable NSString *)text NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
