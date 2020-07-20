//
//  ZKRichTextImageNode.h
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/20.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import "ZKRichTextNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZKRichTextImageNode : ZKRichTextNode

@property (nullable, nonatomic, strong) UIImage *image;
@property (nullable, nonatomic, copy) NSString *imageURL;

@property (nonatomic, assign) CGRect imageRect;

- (instancetype)initWithImage:(nullable UIImage *)image NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
