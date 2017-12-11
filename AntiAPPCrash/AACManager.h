//
//  AACManager.h
//  AntiAPPCrash
//
//  Created by tangbl93 on 2017/12/8.
//  Copyright © 2017年 songguo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,AACCrashType) {
    /** 未识别的方法，找不到方法实现 */
    AACCrashTypeUnrecognizedSelector = 0,
    /** 未在主线程 Present 控制器*/
    AACCrashTypeAccessingCachedSystemAnimationFence,
    /** Present 一个已经被 Present 的控制器 */
    AACCrashTypePresentModallyActiveController,
};
typedef void(^AACManagerRecordCrashBlock)(id instance,AACCrashType type,NSString *reason);

@interface AACManager : NSObject

/**
 记录崩溃信息
 */
@property(nonatomic,copy) AACManagerRecordCrashBlock recordCrashBlock;

/**
 未识别的方法需要过滤的类类型
 */
@property(nonatomic,copy,readonly) NSArray<NSString *> *ignoreClassesForUnrecognizedSelector;

+ (instancetype)sharedInstance;

#pragma mark - 记录方法失败

+ (void)recordCrashLogWithInstance:(id)instance type:(AACCrashType)type reason:(NSString *)reason;

#pragma mark - 替换方法实现

/**
 替换实例方法

 @param clazz 类
 @param originalSel  原始的实现
 @param swizzledSel 替换的实现
 */
+ (void)exchangeInstanceMethodWithClass:(Class)clazz originalSel:(SEL)originalSel swizzledSel:(SEL)swizzledSel;

/**
 替换类方法

 @param clazz 类
 @param originalSel 原始的实现
 @param swizzledSel 替换的实现
 */
+ (void)exchangeClassMethodWithClass:(Class)clazz originalSel:(SEL)originalSel  swizzledSel:(SEL)swizzledSel;

@end
