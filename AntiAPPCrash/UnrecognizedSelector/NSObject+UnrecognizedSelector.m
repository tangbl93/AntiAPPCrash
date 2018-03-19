//
//  NSObject+aac_unrecognized_selector.m
//  AntiAPPCrash
//
//  Created by tangbl93 on 2017/12/10.
//  Copyright © 2017年 songguo. All rights reserved.
//

#import "NSObject+UnrecognizedSelector.h"

#import <objc/runtime.h>
#import "AACManager.h"

#pragma mark - _UnrecognizedSelectorProxy 消息转发代理
@interface _UnrecognizedSelectorProxy : NSObject
+ (instancetype)sharedInstance;
@end

@implementation _UnrecognizedSelectorProxy
+ (instancetype)sharedInstance {

    static _UnrecognizedSelectorProxy *instance=nil;
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        instance = [[_UnrecognizedSelectorProxy alloc] init];
    });
    return instance;
}

-(instancetype)init {
    self = [super init];
    return self;
}

+ (BOOL)resolveInstanceMethod:(SEL)selector {
    class_addMethod([self class], selector,(IMP)emptyMethodIMP,"v@:");
    return YES;
}
void emptyMethodIMP(){}

@end

#pragma mark - 分类实现：替换消息 & 方法转发
@implementation NSObject (UnrecognizedSelector)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [AACManager exchangeInstanceMethodWithClass:self
                                     originalSel:@selector(methodSignatureForSelector:)
                                     swizzledSel:@selector(aac_methodSignatureForSelector:)];
        [AACManager exchangeInstanceMethodWithClass:self
                                        originalSel:@selector(forwardInvocation:)
                                        swizzledSel:@selector(aac_forwardInvocation:)];
    });
}

- (NSMethodSignature *)aac_methodSignatureForSelector:(SEL)aSelector {
    // 获取默认的方法,判断默认的方法是否可以调用
    NSMethodSignature *methodSignature;
    methodSignature = [self aac_methodSignatureForSelector:aSelector];
    if (methodSignature || ![AACManager enableForType:AACTypeUnrecognizedSelector]) {
        return methodSignature;
    }

    // 过滤列表
    NSArray *ignoreClassesForUnrecognizedSelector = @[@"UIKeyboard"];
    for (NSString *ignoreClass in ignoreClassesForUnrecognizedSelector) {
        if ([NSStringFromClass([self class]) containsString:ignoreClass]) {
            return [self aac_methodSignatureForSelector:aSelector];
        }
    }

    // 如果不可以，就进行转发
    methodSignature = [[_UnrecognizedSelectorProxy sharedInstance] aac_methodSignatureForSelector:aSelector];
    if (methodSignature) {
        return methodSignature;
    }

    // 如果转发也不行，就蹦了吧
    return nil;
}
- (void)aac_forwardInvocation:(NSInvocation *)anInvocation {
    @try {
        [self aac_forwardInvocation:anInvocation];
    }
    @catch (NSException *exception) {
        [anInvocation invokeWithTarget:[_UnrecognizedSelectorProxy sharedInstance]];
        NSString *reason = [NSString stringWithFormat:@"%@ %@",exception.name,exception.reason];
        [AACManager recordCrashLogWithInstance:self type:AACTypeUnrecognizedSelector reason:reason];
    }
    @finally {

    }
}

@end
