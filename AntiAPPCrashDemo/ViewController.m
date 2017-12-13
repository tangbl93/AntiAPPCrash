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
    
    [AACManager sharedInstance].recordCrashBlock = ^(id instance, AACCrashType type, NSString *reason) {
        NSLog(@"AACManager recordCrashBlock class = %@,type = %ld, reason = %@",instance,type,reason);
    };
    
//    [self testchuyi0];
//    [self testsetobjectforkey];
    [self testunrecognized_selector];
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:tf];
    [tf becomeFirstResponder];
    
    [self testpresent];
}

//// 除以0
//- (void)testchuyi0 {
//    int x = 0;
//    int y = 10 / x;
//    y = y;
//}

// setObject:forKey
- (void)testsetobjectforkey {
    NSMutableDictionary *tmp = [NSMutableDictionary dictionary];
    [tmp setObject:nil forKey:@"key"];
}

// unrecognized selector
//- (void)unrecognized_selector{}
- (void)testunrecognized_selector {
    NSObject *xx = [[NSObject alloc] init];
    [self performSelector:@selector(yyyyyyyyyyyyyyyyyyyyyyyy) withObject:nil afterDelay:0];
}

- (void)testpresent {
    
    UIViewController *vc = [UIViewController new];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        [self presentViewController:vc animated:YES completion:^{
            
            [self presentViewController:vc animated:YES completion:^{}];
            
        }];
    });
    
}

@end
