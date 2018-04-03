//
//  ViewController.m
//  AntiAPPCrashDemo
//
//  Created by tangbl93 on 2018/4/3.
//  Copyright © 2018年 songguo. All rights reserved.
//

#import "ViewController.h"

#import <AntiAPPCrash/AntiAPPCrash.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // setup
    AACManager.sharedInstance.enableType = AACTypeUIKitError | AACTypeUnrecognizedSelector | AACTypeObjectTypeError;
    [AACManager sharedInstance].recordCrashBlock = ^(id instance, AACType type, NSString *reason) {
        NSLog(@"AACManager recordCrashBlock class = %@,type = %ld, reason = %@",instance,type,reason);
    };
    
    // uikit error
    UIView *view = [UIView new];
    [view addSubview:view];

    // objectType error
    NSArray *a1 = @[];
    id val1 = a1[1];

    // UnrecognizedSelector
    [self performSelectorOnMainThread:@selector(notFound) withObject:nil waitUntilDone:NO];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle: nil message: nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *saveButton = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:saveButton];
    [alertController addAction:cancel];
    
    UIPopoverPresentationController *popover = alertController.popoverPresentationController;
    
    if (popover) {
//        popover.barButtonItem = self.bookmark;
        popover.sourceView = self.view;
        popover.permittedArrowDirections = 0;
        popover.sourceRect = CGRectMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds),0,0);
    }
    
    [self presentViewController:alertController animated: YES completion: nil];
}

@end
