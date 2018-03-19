//
//  UIViewController+aac_accessing_cachedSystemAnimationFence.m
//  AntiAPPCrash
//
//  Created by tangbl93 on 2017/12/11.
//  Copyright © 2017年 songguo. All rights reserved.
//

#import "UIViewController+UIKitError.h"

#import "AACManager.h"

@implementation UIViewController (UIKitError)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [AACManager exchangeInstanceMethodWithClass:[self class]
                                        originalSel:@selector(presentViewController:animated:completion:) swizzledSel:@selector(aac_presentViewController:animated:completion:)];
    });
}

- (void)aac_presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ __nullable)(void))completion {
    
    if (![AACManager enableForType:AACTypeUIKitError]) {
        [self aac_presentViewController:viewControllerToPresent animated:flag completion:completion];
        return;
    }
    
    // Application tried to present a nil modal view controller on target
    if (!viewControllerToPresent) {
        NSString *crashReason = [NSString stringWithFormat:@"NSInvalidArgumentException Application tried to present a nil modal view controller on target: %@",self];
        [AACManager recordCrashLogWithInstance:self type:AACTypeUIKitError reason:crashReason];
        return;
    }
    
    // Application tried to present modally an active controller
    if (viewControllerToPresent && viewControllerToPresent.presentingViewController) {
        NSString *crashReason = [NSString stringWithFormat:@"NSInvalidArgumentException Application tried to present modally an active controller: %@",self];
        [AACManager recordCrashLogWithInstance:self type:AACTypeUIKitError reason:crashReason];
        return;
    }
    
    // NSInternalInconsistencyException accessing _cachedSystemAnimationFence requires the main thread
    if ([NSThread isMainThread]) {
        [self aac_presentViewController:viewControllerToPresent animated:flag completion:completion];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *crashReason = [NSString stringWithFormat:@"NSInternalInconsistencyException accessing _cachedSystemAnimationFence requires the main thread: %@",self];
            [AACManager recordCrashLogWithInstance:self type:AACTypeUIKitError reason:crashReason];
            [self aac_presentViewController:viewControllerToPresent animated:flag completion:completion];
        });
    }
}

@end