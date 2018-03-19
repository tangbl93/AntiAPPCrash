//
//  AppDelegate.m
//  AntiAPPCrashDemo
//
//  Created by tangbl93 on 2018/3/19.
//  Copyright © 2018年 songguo. All rights reserved.
//

#import "AppDelegate.h"

#import <AntiAPPCrash/AntiAPPCrash.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window.rootViewController = [UIViewController new];
    [self.window makeKeyAndVisible];
    
    // setup
    AACManager.sharedInstance.enableType = AACTypeUIKitError | AACTypeUnrecognizedSelector;
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
    [self performSelectorOnMainThread:@selector(viewDidLoad) withObject:nil waitUntilDone:NO];
    
    return YES;
}


@end
