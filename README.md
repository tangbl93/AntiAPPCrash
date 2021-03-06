# AntiAPPCrash

[正在开发中] 防止APP运行时崩溃

# 导入到项目

`pod 'AntiAPPCrash', :git => 'https://gitee.com/gongguo/AntiAPPCrash.git'`

# 如何触发崩溃

目前支持的崩溃基本都会在 `ViewController.m` 中会编写一个触发的例子

# 思路

1. 基本会让原有的崩溃保留一个崩溃信息，但是因为方法替换所以导致调用栈获取到的不是需要的，因而得到的信息也远没有原有的详细。
2. 其次是能正常走完设计的逻辑就让正常走完，实在没办法的就不处理。
3. 所有的崩溃原因都尽可能带上异常名称，如 NSInvalidArgumentException，NSRangeException等等
4. 再其次，目前的打算是基本只对用户暴露出一个 `AACManager` 类，崩溃的类型也在这里定义，错误的处理也在其中，案例如下：

```objc
[AACManager sharedInstance].recordCrashBlock = ^(id instance, AACCrashType type, NSString *reason) {
    NSLog(@"AACManager recordCrashBlock class = %@,type = %ld, reason = %@",instance,type,reason);
};
```

5. 设置开关，通过  `[AACManager sharedInstance].enable = NO;` , 默认开启

# 目前支持的类型

- unrecognized selector
- accessing _cachedSystemAnimationFence requires the main thread
- Application tried to present modally an active controller
- Application tried to present a nil modal view controller on target
- index beyond bounds
- add self as subview
- Your application has presented a UIAlertController of style UIAlertControllerStyleActionSheet
- UIAlertController must have a title, a message or an action to display

# 参考的案例

- [Dr.Light](https://github.com/zanyfly/Dr.Light)
- [AvoidCrash](https://github.com/chenfanfang/AvoidCrash)
