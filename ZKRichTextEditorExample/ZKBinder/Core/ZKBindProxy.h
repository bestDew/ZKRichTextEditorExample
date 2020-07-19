//
//  ZKBindProxy.h
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/16.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ZKSignal;

@interface ZKBindProxy : NSObject

- (instancetype)initWithObject:(id)object nilValue:(nullable id)nilValue;

- (void)setObject:(nullable ZKSignal *)signal forKeyedSubscript:(NSString *)keyPath;

@end

NS_ASSUME_NONNULL_END
