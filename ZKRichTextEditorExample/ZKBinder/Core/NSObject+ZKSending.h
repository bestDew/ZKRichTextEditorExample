//
//  NSObject+ZKSending.h
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/16.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ZKSignal;

@interface NSObject (ZKSending)

/// 观察者模式，生成一个信号量
/// @param keyPath 被观察的 keyPath
- (nullable ZKSignal *)signalForKeyPath:(NSString *)keyPath;

/// 解除对 keyPath 的观察，当前 keyPath下不再发送信号
- (void)disabledSignalForKeyPath:(NSString *)keyPath;

/// 解除对当前对象所有的观察，该对象不再发送任何信号
- (void)disabledSignals;

@end

NS_ASSUME_NONNULL_END
