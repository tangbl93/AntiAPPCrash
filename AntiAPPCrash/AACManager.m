//
//  AACManager.m
//  AntiAPPCrash
//
//  Created by tangbl93 on 2017/12/8.
//  Copyright © 2017年 songguo. All rights reserved.
//

#import "AACManager.h"

#import <objc/runtime.h>

@interface AACManager ()

@end

@implementation AACManager

+ (instancetype)sharedInstance {
    static AACManager *instance=nil;
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        instance = [[AACManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.enableType = AACTypeNone;
    }
    return self;
}

+ (BOOL)enableForType:(AACType)type {
    if (AACTypeAll == type) {
        return YES;
    }
    return [AACManager sharedInstance].enableType & type;
}

+ (void)recordCrashLogWithInstance:(id)instance type:(AACType)type reason:(NSString *)reason{
    if ([AACManager sharedInstance].recordCrashBlock) {
        [AACManager sharedInstance].recordCrashBlock(instance, type, reason);
    }
}

// 替换实例方法
+ (void)exchangeInstanceMethodWithClass:(Class)clazz originalSel:(SEL)originalSel swizzledSel:(SEL)swizzledSel {
    
    NSAssert(clazz && originalSel && swizzledSel, @"Class and Selector Can't be nil!!!");
    
    Method originalMethod = class_getInstanceMethod(clazz, originalSel);
    Method swizzledMethod = class_getInstanceMethod(clazz, swizzledSel);
    
    BOOL didAddMethod = class_addMethod(clazz, originalSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(clazz, swizzledSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
// 替换类方法
+ (void)exchangeClassMethodWithClass:(Class)clazz originalSel:(SEL)originalSel  swizzledSel:(SEL)swizzledSel {
    
    NSAssert(clazz && originalSel && swizzledSel, @"Class and Selector Can't be nil!!!");
    
    Method originalMethod = class_getClassMethod(clazz, originalSel);
    Method swizzledMethod = class_getClassMethod(clazz, swizzledSel);
    
    BOOL didAddMethod = class_addMethod(clazz, originalSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(clazz, swizzledSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
