//
//  UIViewController+aac_accessing_cachedSystemAnimationFence.h
//  AntiAPPCrash
//
//  Created by tangbl93 on 2017/12/11.
//  Copyright © 2017年 songguo. All rights reserved.
//

#import <UIKit/UIKit.h>

// # accessing _cachedSystemAnimationFence requires the main thread
// # Application tried to present modally an active controller
// # Application tried to present a nil modal view controller on target
@interface UIViewController (UIKitError)

@end
