//
//  ZKRichTextTextModel.h
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/8/18.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZKRichTextModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZKRichTextTextModel : NSObject <ZKRichTextModel>

@property (nullable, nonatomic, copy) NSString *text;
@property (nullable, nonatomic, copy) NSString *placeholder;

@property (nonatomic, assign) NSRange selectedRange;

- (instancetype)initWithText:(nullable NSString *)text placeholder:(nullable NSString *)placeholder NS_DESIGNATED_INITIALIZER;
+ (instancetype)modelWithText:(nullable NSString *)text placeholder:(nullable NSString *)placeholder;

@end

NS_ASSUME_NONNULL_END
