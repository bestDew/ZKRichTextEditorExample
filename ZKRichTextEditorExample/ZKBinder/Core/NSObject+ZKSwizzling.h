//
//  NSObject+ZKSwizzling.h
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/15.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ZKSwizzling)

+ (BOOL)swizzleInstanceMethod:(SEL)origSel withInstanceMethod:(SEL)altSel;

@end

NS_ASSUME_NONNULL_END
