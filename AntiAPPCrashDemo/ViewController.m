//
//  ViewController.m
//  AntiAPPCrashDemo
//
//  Created by tangbl93 on 2017/12/8.
//  Copyright © 2017年 songguo. All rights reserved.
//

#import "ViewController.h"
#import "AntiAPPCrash.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self testchuyi0];
//    [self testsetobjectforkey];
    [self testunrecognized_selector];
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:tf];
    [tf becomeFirstResponder];
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
//- (void)unrecognized_selector{}
- (void)testunrecognized_selector {
    NSObject *xx = [[NSObject alloc] init];
    [self performSelector:@selector(unrecognized_selector) withObject:nil afterDelay:0];
}

@end
