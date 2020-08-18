//
//  UITableView+ZKUpdates.m
//  ZKRichTextEditorExample
//
//  Created by 张日奎 on 2020/7/20.
//  Copyright © 2020 bestdew. All rights reserved.
//

#import "UITableView+ZKUpdates.h"

@implementation UITableView (ZKUpdates)

- (void)updates:(dispatch_block_t)block completion:(void (^)(BOOL))completion {
    if (@available(iOS 11.0, *)) {
        [self performBatchUpdates:block completion:completion];
    } else {
        [self beginUpdates];
        if (block) {
            block();
        }
        [self endUpdates];
        if (completion == nil) {
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(YES);
        });
    }
}

- (void)updatesWithoutAnimation:(dispatch_block_t)block completion:(void (^)(BOOL))completion {
    if (@available(iOS 11.0, *)) {
        [UIView performWithoutAnimation:^{
            [self performBatchUpdates:block completion:completion];
        }];
    } else {
        [UIView performWithoutAnimation:^{
            [self beginUpdates];
            if (block) {
                block();
            }
            [self endUpdates];
        }];
        
        if (completion == nil) {
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(YES);
        });
    }
}

@end
