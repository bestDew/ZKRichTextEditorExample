//
//  NSObject+ZKSwizzling.m
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/15.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import "NSObject+ZKSwizzling.h"
#import <objc/runtime.h>

@implementation NSObject (ZKSwizzling)

+ (BOOL)swizzleInstanceMethod:(SEL)origSel withInstanceMethod:(SEL)altSel {
    Method origMethod = class_getInstanceMethod(self, origSel);
    Method altMethod = class_getInstanceMethod(self, altSel);
    if (!origMethod || !altMethod) {
        return NO;
    }
    class_addMethod(self,
                    origSel,
                    class_getMethodImplementation(self, origSel),
                    method_getTypeEncoding(origMethod));
    class_addMethod(self,
                    altSel,
                    class_getMethodImplementation(self, altSel),
                    method_getTypeEncoding(altMethod));
    method_exchangeImplementations(class_getInstanceMethod(self, origSel),
                                   class_getInstanceMethod(self, altSel));
    return YES;
}

@end
