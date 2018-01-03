//
//  ViewController.m
//  AntiAPPCrashDemo
//
//  Created by tangbl93 on 2017/12/8.
//  Copyright © 2017年 songguo. All rights reserved.
//

#import "ViewController.h"

#import <AntiAPPCrash/AntiAPPCrash.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [AACManager sharedInstance].enable = NO;
    [AACManager sharedInstance].recordCrashBlock = ^(id instance, AACCrashType type, NSString *reason) {
        NSLog(@"AACManager recordCrashBlock class = %@,type = %ld, reason = %@",instance,type,reason);
    };
    
//    [self testchuyi0];
//    [self testsetobjectforkey];
    [self testunrecognized_selector];
//
//    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    [self.view addSubview:tf];
//    [tf becomeFirstResponder];
//
//    [self testpresent];
    
    
//    [self testindexbeyondbounds];
}

- (void)testindexbeyondbounds {
    // 有多个item __NSArrayI
    // Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[__NSArrayI objectAtIndexedSubscript:]: index 2 beyond bounds [0 .. 1]'
    //  Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[__NSArrayI objectAtIndex:]: index 2 beyond bounds [0 .. 1]'
    // 仅一个item __NSSingleObjectArrayI
    // Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[__NSSingleObjectArrayI objectAtIndex:]: index 2 beyond bounds [0 .. 0]'
    // 无item __NSArray0
    // Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[__NSArray0 objectAtIndex:]: index 2 beyond bounds for empty NSArray'

    NSArray *arr1 = @[];
    NSNumber *v1 = arr1[2];
    NSNumber *v2 = [arr1 objectAtIndex:2];
    
    // Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[__NSArrayM objectAtIndexedSubscript:]: index 2 beyond bounds [0 .. 1]'
    //  Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[__NSArrayM objectAtIndex:]: index 2 beyond bounds [0 .. 1]'
    NSMutableArray *arr2 = [arr1 mutableCopy];
    NSNumber *v3 = arr2[2];
    NSNumber *v4 = [arr2 objectAtIndex:2];
}

//// 除以0
//- (void)testchuyi0 {
//    int x = 0;
//    int y = 10 / x;
//    y = y;
//}

// setObject:forKey
//- (void)testsetobjectforkey {
//    NSMutableDictionary *tmp = [NSMutableDictionary dictionary];
//    [tmp setObject:nil forKey:@"key"];
//}

// unrecognized selector
- (void)unrecognized_selector{}
- (void)testunrecognized_selector {
    NSObject *xx = [[NSObject alloc] init];
    [self performSelector:@selector(yyyyyyyyyyyyyyyyyyyyyyyy) withObject:nil afterDelay:0];
}

- (void)testpresent {

    UIViewController *vc = [UIViewController new];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        [self presentViewController:vc animated:YES completion:^{

            [self presentViewController:nil animated:YES completion:^{}];

        }];
    });

}

@end
