//
//  ZKBindCenter.h
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/16.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ZKSignal;

@interface ZKBindCenter<ZKReceiver: id> : NSObject

+ (instancetype)defaultCenter;

- (void)bindReceiver:(ZKReceiver)receiver forSignal:(ZKSignal *)signal;

- (void)unbindReceiver:(ZKReceiver)receiver forSignal:(ZKSignal *)signal;
- (void)unbindReceiversForSignal:(ZKSignal *)signal;
- (void)unbindAllReceivers;

- (nullable NSSet *)receiversForSignal:(ZKSignal *)signal;

@end

NS_ASSUME_NONNULL_END
