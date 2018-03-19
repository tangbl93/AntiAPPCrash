//
//  UIView+add_self_as_subview.m
//  AntiAPPCrash
//
//  Created by tangbl93 on 2018/1/3.
//  Copyright © 2018年 songguo. All rights reserved.
//

#import "UIView+UIKitError.h"

#import "AACManager.h"

@implementation UIView (UIKitError)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [AACManager exchangeInstanceMethodWithClass:[self class]
                                        originalSel:@selector(addSubview:) swizzledSel:@selector(aac_addSubview:)];
    });
}

- (void)aac_addSubview:(UIView *)view {
    if ([view isEqual:self] && [AACManager enableForType:AACTypeUIKitError]) {
        NSString *crashReason = [NSString stringWithFormat:@"NSInvalidArgumentException 'Can't add self as subview'"];
        [AACManager recordCrashLogWithInstance:self type:AACTypeUIKitError reason:crashReason];
        return;
    }
    [self aac_addSubview:view];
}
    

@end
