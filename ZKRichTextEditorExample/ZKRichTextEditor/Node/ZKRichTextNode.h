//
//  ZKRichTextNode.h
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/19.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZKRichTextDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZKRichTextNode : NSObject

@property (nonatomic, assign, getter=isActive) BOOL active;
@property (nonatomic, readonly, assign) CGFloat contentHeight;

- (nullable NSString *)type;

@end

NS_ASSUME_NONNULL_END
