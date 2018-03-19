//
//  AACManager.h
//  AntiAPPCrash
//
//  Created by tangbl93 on 2017/12/8.
//  Copyright © 2017年 songguo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 崩溃类型

 - AACTypeNone: 无
 - AACTypeAll: 全部崩溃类型
 - AACTypeUIKitError: 布局控件操作错误
 - AACTypeObjectTypeError: 数组/字典等集合类型错误
 - AACTypeUnrecognizedSelector: 找不到方法实现
 */
typedef NS_OPTIONS(NSUInteger, AACType) {
    AACTypeUIKitError = 1 << 0,
    AACTypeObjectTypeError = 1 << 1,
    AACTypeUnrecognizedSelector = 1 << 2,
    
    AACTypeNone = 0,
    AACTypeAll = ~0UL
};
typedef void(^AACManagerRecordCrashBlock)(id instance,AACType type,NSString *reason);

@interface AACManager : NSObject

/**
 开关,默认关闭
 */
@property(nonatomic,assign) AACType enableType;

/**
 记录崩溃信息
 */
@property(nonatomic,copy) AACManagerRecordCrashBlock recordCrashBlock;

+ (instancetype)sharedInstance;

/**
 检测是否支持防止该类型
 */
+ (BOOL)enableForType:(AACType)type;

/**
 在全局记录崩溃
 */

+ (void)recordCrashLogWithInstance:(id)instance type:(AACType)type reason:(NSString *)reason;

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
