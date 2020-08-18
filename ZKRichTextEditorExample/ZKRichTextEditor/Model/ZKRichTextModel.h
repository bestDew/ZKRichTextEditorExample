//
//  ZKRichTextModel.h
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/8/18.
//  Copyright © 2020 bestdew. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@protocol ZKRichTextModel <NSObject>

@property (nonatomic, assign, getter=isEditing) BOOL editing;

- (CGFloat)contentHeight;

- (NSString *)contentType;

@end

NS_ASSUME_NONNULL_END
