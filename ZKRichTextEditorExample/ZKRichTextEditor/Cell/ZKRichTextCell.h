//
//  ZKRichTextCell.h
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/19.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKTextView.h"
#import "ZKRichTextNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZKRichTextCell : UITableViewCell

@property (nullable, nonatomic, strong) ZKRichTextNode *node;
@property (nonatomic, readonly, strong) ZKTextView *textView;

- (void)setup NS_REQUIRES_SUPER; 

- (void)beginActive;
- (void)endActive;

@end

NS_ASSUME_NONNULL_END
