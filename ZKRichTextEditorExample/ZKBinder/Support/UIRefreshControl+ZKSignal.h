//
//  UIRefreshControl+ZKSignal.h
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/16.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZKSignal;

@interface UIRefreshControl (ZKSignal)

- (ZKSignal *)refreshSignal;

@end

NS_ASSUME_NONNULL_END
