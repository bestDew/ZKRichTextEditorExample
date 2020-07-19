//
//  ZKMacros.h
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/15.
//  Copyright © 2020 bestdew. All rights reserved.
//

#ifndef ZKMacros_h
#define ZKMacros_h

#define ZKSend(TARGET, KEYPATH) \
    [TARGET signalForKeyPath:KeyPath(TARGET, KEYPATH)]

#define ZKReceive(OBJECT, KEYPATH, NILVALUE) \
    [[ZKBindProxy alloc] initWithObject:OBJECT nilValue:NILVALUE][KeyPath(OBJECT, KEYPATH)]

#define KeyPath(OBJECT, KEYPATH) \
    @(((void)(NO && ((void)(OBJECT.KEYPATH), NO)), #KEYPATH))

#define GetIvarName(ivar) \
    @(((void)(NO && ((void)ivar, NO)), \
    ({ const char *str = strchr(#ivar, '_'); (str ? (str + 1) : #ivar); })))

#define _Weakify(obj) \
    __weak __typeof__(obj) obj##_weak_ = obj;

#define _Strongify(obj) \
    __strong __typeof__(obj##_weak_) obj = obj##_weak_;

#define NullSafe(value) \
    [value isKindOfClass:[NSNull class]] ? nil : value

#endif /* ZKMacros_h */
