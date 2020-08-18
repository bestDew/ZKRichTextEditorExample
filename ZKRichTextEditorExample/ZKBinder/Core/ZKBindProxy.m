//
//  ZKBindProxy.m
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/16.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import "ZKBindProxy.h"
#import "ZKSignal.h"

@interface ZKBindProxy ()

@property (nonatomic, strong) id object;
@property (nonatomic, strong) id nilValue;

@end

@implementation ZKBindProxy

- (instancetype)initWithObject:(id)object nilValue:(id)nilValue {
    if (object == nil) {
        return nil;
    }
    if (self = [super init]) {
        _object = object;
        _nilValue = nilValue;
    }
    return self;
}

- (void)setObject:(ZKSignal *)signal forKeyedSubscript:(NSString *)keyPath {
    [signal bindObject:_object forKeyPayh:keyPath nilValue:_nilValue];
}

@end
