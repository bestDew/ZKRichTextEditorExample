//
//  ZKObserveCenter.h
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/15.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ZKSignal;

@interface ZKObserveCenter : NSObject

+ (instancetype)defaultCenter;

- (nullable ZKSignal *)observe:(id)object keyPath:(NSString *)keyPath;

- (void)unobserve:(id)object keyPath:(NSString *)keyPath;
- (void)unobserve:(id)object;
- (void)unobserveAll;

@end

NS_ASSUME_NONNULL_END
