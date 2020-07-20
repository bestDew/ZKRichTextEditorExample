//
//  UITableView+ZKUpdates.h
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/20.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (ZKUpdates)

- (void)updates:(nullable dispatch_block_t)block completion:(void (^ _Nullable)(BOOL finished))completion;

- (void)updatesWithoutAnimation:(nullable dispatch_block_t)block completion:(void (^ _Nullable)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END
