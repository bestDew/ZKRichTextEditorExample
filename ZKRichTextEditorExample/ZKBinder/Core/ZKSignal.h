//
//  ZKSignal.h
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/15.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ZKReceiveBlock)(id _Nullable value);

@interface ZKSignal : NSObject <NSCopying>

/// 绑定一个接收者对象
/// @param object 对象实例
/// @param keyPath 需要绑定的 keyPath
/// @param nilValue 当信号量传递 nil 时，接收者对象会接收到这个值
- (void)bindObject:(id)object forKeyPayh:(NSString *)keyPath nilValue:(nullable id)nilValue;

/// 解绑一个接收者对象
/// @param object 对象实例
/// @param keyPath 需要解绑的 keyPath
- (void)unbindObject:(id)object forKeyPath:(nullable NSString *)keyPath;

/// 解绑接收者对象
/// 当绑定了该接收者的多个 keyPath 时，会全部解绑
/// @param object 对象实例
- (void)unbindObject:(id)object;

/// 解绑全部接收者对象
- (void)unbindAllObjects;

/// 传输一个值
- (void)transmit:(nullable id)value;

/// 接收信号量
- (void)receive:(ZKReceiveBlock)block;

@end

typedef BOOL (^ZKFilterBlock)(id _Nullable value);

@interface ZKSignal (Operations)

/// 对信号量传输的值进行过滤
/// @param block 该 block 返回一个 BOOL 值，当返回 YES 时，接收者对象会接收到值，反之，则不能。
- (ZKSignal *)filter:(ZKFilterBlock)block;

/// 将两个信号量进行合并
/// @param signal 需要合并的信号量
/// @param block value1：调用者信号量传输的值，value2：合并者信号量传输的值
- (void)combine:(ZKSignal *)signal reduce:(void (^)(id _Nullable value1, id _Nullable value2))block;

@end

@interface ZKSignal (Description)

/// 判断当前信号量是否是无用的
/// 当该信号量没有绑定任何接收者，则视为无用
- (BOOL)isUseless;

@end

NS_ASSUME_NONNULL_END
