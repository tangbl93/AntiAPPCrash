//
//  UIViewController+aac_accessing_cachedSystemAnimationFence.h
//  AntiAPPCrash
//
//  Created by tangbl93 on 2017/12/11.
//  Copyright © 2017年 songguo. All rights reserved.
//

#import <UIKit/UIKit.h>

// #1. accessing _cachedSystemAnimationFence requires the main thread
// #2. Application tried to present modally an active controller
@interface UIViewController (aac_accessing_cachedSystemAnimationFence)

@end
