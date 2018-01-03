//
//  NSArray+index_beyond_bounds.m
//  AntiAPPCrash
//
//  Created by tangbl93 on 2018/1/3.
//  Copyright © 2018年 songguo. All rights reserved.
//

#import "NSArray+index_beyond_bounds.h"

#import "AACManager.h"
#import <objc/runtime.h>

static NSString *__NSArrayMClassName = @"__NSArrayM";
static NSString *__NSArrayIClassName = @"__NSArrayI";
static NSString *__NSSingleObjectArrayIClassName = @"__NSSingleObjectArrayI";
static NSString *__NSArray0ClassName = @"__NSArray0";

static NSString *__objectAtIndexSelectorName    = @"objectAtIndex:";
static NSString *__objectAtIndexedSubscriptSelectorName    = @"objectAtIndexedSubscript:";

// Private Methods
void _report_index_beyond_bounds(NSArray *array,NSUInteger index,NSString *className, NSString *selectorName) {
    NSString *bounds = nil;
    NSUInteger count = array.count;
    if (count == 0) {
        bounds = @"for empty array";
    } else {
        bounds = [NSString stringWithFormat:@"[0 .. %ld]",array.count];
    }
    NSString *crashReason = [NSString stringWithFormat:@"NSRangeException -[%@ %@]: index %ld beyond bounds %@",className,selectorName,index,bounds];
    [AACManager recordCrashLogWithInstance:array type:AACCrashTypeIndexBeyondBounds reason:crashReason];
}

#pragma mark - NSArray
@implementation NSArray (index_beyond_bounds)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 有2个元素以上的  __NSArrayI
        Class __NSArrayI = objc_getClass([__NSArrayIClassName UTF8String]);
        [AACManager exchangeInstanceMethodWithClass:__NSArrayI originalSel:@selector(objectAtIndex:) swizzledSel:@selector(aac_NSArrayI_objectAtIndex:)];
        [AACManager exchangeInstanceMethodWithClass:__NSArrayI originalSel:@selector(objectAtIndexedSubscript:) swizzledSel:@selector(aac_NSArrayI_objectAtIndexedSubscript:)];
        
        // 仅一个元素的        __NSSingleObjectArrayI
        Class __NSSingleObjectArrayI = objc_getClass([__NSSingleObjectArrayIClassName UTF8String]);
        [AACManager exchangeInstanceMethodWithClass:__NSSingleObjectArrayI originalSel:@selector(objectAtIndex:) swizzledSel:@selector(aac_NSSingleObjectArrayI_objectAtIndex:)];
        [AACManager exchangeInstanceMethodWithClass:__NSSingleObjectArrayI originalSel:@selector(objectAtIndexedSubscript:) swizzledSel:@selector(aac_NSSingleObjectArrayI_objectAtIndexedSubscript:)];
        
        // 无元素的                __NSArray0
        Class __NSArray0 = objc_getClass([__NSArray0ClassName UTF8String]);
        [AACManager exchangeInstanceMethodWithClass:__NSArray0 originalSel:@selector(objectAtIndex:) swizzledSel:@selector(aac_NSArray0_objectAtIndex:)];
        [AACManager exchangeInstanceMethodWithClass:__NSArray0 originalSel:@selector(objectAtIndexedSubscript:) swizzledSel:@selector(aac_NSArray0_objectAtIndexedSubscript:)];
    });
}

// __NSArrayI
- (id)aac_NSArrayI_objectAtIndex:(NSUInteger)index {
    if (index >= self.count && [AACManager sharedInstance].enable) {
        _report_index_beyond_bounds(self,index, __NSArrayIClassName, __objectAtIndexSelectorName);
        return nil;
    }
    return [self aac_NSArrayI_objectAtIndex:index];
}
- (id)aac_NSArrayI_objectAtIndexedSubscript:(NSUInteger)idx {
    if (idx >= self.count && [AACManager sharedInstance].enable) {
        _report_index_beyond_bounds(self,idx, __NSArrayIClassName, __objectAtIndexedSubscriptSelectorName);
        return nil;
    }
    return [self aac_NSArrayI_objectAtIndexedSubscript:idx];
}

// __NSSingleObjectArrayI
- (id)aac_NSSingleObjectArrayI_objectAtIndex:(NSUInteger)index {
    if (index > 0 && [AACManager sharedInstance].enable) {
        _report_index_beyond_bounds(self,index, __NSSingleObjectArrayIClassName, __objectAtIndexSelectorName);
        return nil;
    }
    return [self aac_NSSingleObjectArrayI_objectAtIndex:index];
}
- (id)aac_NSSingleObjectArrayI_objectAtIndexedSubscript:(NSUInteger)idx {
    if (idx > 0 && [AACManager sharedInstance].enable) {
        _report_index_beyond_bounds(self,idx, __NSSingleObjectArrayIClassName, __objectAtIndexedSubscriptSelectorName);
        return nil;
    }
    return [self aac_NSSingleObjectArrayI_objectAtIndexedSubscript:idx];
}

// __NSArray0
- (id)aac_NSArray0_objectAtIndex:(NSUInteger)index {
    if ([AACManager sharedInstance].enable) {
        _report_index_beyond_bounds(self,index, __NSArray0ClassName, __objectAtIndexSelectorName);
        return nil;
    }
    return [self aac_NSArray0_objectAtIndex:index];
}
- (id)aac_NSArray0_objectAtIndexedSubscript:(NSUInteger)idx {
    if ([AACManager sharedInstance].enable) {
        _report_index_beyond_bounds(self,idx, __NSArray0ClassName, __objectAtIndexedSubscriptSelectorName);
        return nil;
    }
    return [self aac_NSArray0_objectAtIndexedSubscript:idx];
}

@end

#pragma mark - NSMutableArray
@implementation NSMutableArray (index_beyond_bounds)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 有2个元素以上的  __NSArrayI
        Class __NSArrayM = objc_getClass([__NSArrayMClassName UTF8String]);
        [AACManager exchangeInstanceMethodWithClass:__NSArrayM originalSel:@selector(objectAtIndex:) swizzledSel:@selector(aac_NSArrayM_objectAtIndex:)];
        [AACManager exchangeInstanceMethodWithClass:__NSArrayM originalSel:@selector(objectAtIndexedSubscript:) swizzledSel:@selector(aac_NSArrayM_objectAtIndexedSubscript:)];
    });
}

// __NSArrayM
- (id)aac_NSArrayM_objectAtIndex:(NSUInteger)index {
    if (index >= self.count && [AACManager sharedInstance].enable) {
        _report_index_beyond_bounds(self,index, __NSArrayMClassName, __objectAtIndexSelectorName);
        return nil;
    }
    return [self aac_NSArrayM_objectAtIndex:index];
}
- (id)aac_NSArrayM_objectAtIndexedSubscript:(NSUInteger)idx {
    if (idx >= self.count && [AACManager sharedInstance].enable) {
        _report_index_beyond_bounds(self,idx, __NSArrayMClassName, __objectAtIndexedSubscriptSelectorName);
        return nil;
    }
    return [self aac_NSArrayM_objectAtIndexedSubscript:idx];
}

@end
