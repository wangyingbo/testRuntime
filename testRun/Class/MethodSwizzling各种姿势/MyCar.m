//
//  MyCar.m
//  testRun
//
//  Created by 王迎博 on 16/8/29.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import "MyCar.h"
#import <objc/runtime.h>


@implementation MyCar

+ (void)load {
    Class originalClass = NSClassFromString(@"Car");
    Class swizzledClass = [self class];
    SEL originalSelector = NSSelectorFromString(@"run:");
    SEL swizzledSelector = @selector(xxx_run:);
    Method originalMethod = class_getInstanceMethod(originalClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(swizzledClass, swizzledSelector);
    
    // 向Car类中新添加一个xxx_run:的方法
    BOOL registerMethod = class_addMethod(originalClass,
                                          swizzledSelector,
                                          method_getImplementation(swizzledMethod),
                                          method_getTypeEncoding(swizzledMethod));
    if (!registerMethod) {
        return;
    }
    
    // 需要更新swizzledMethod变量,获取当前Car类中xxx_run:的Method指针
    swizzledMethod = class_getInstanceMethod(originalClass, swizzledSelector);
    if (!swizzledMethod) {
        return;
    }
    
    // 后续流程与之前的一致
    BOOL didAddMethod = class_addMethod(originalClass,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(originalClass,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)xxx_run:(double)speed {
    if (speed < 120) {
        [self xxx_run:speed];
    }
    NSLog(@"更新了xxx_run方法");
}


/** 以上所有的逻辑也可以合并简化为以下:
 
 + (void)load {
 Class originalClass = NSClassFromString(@"Car");
 Class swizzledClass = [self class];
 SEL originalSelector = NSSelectorFromString(@"run:");
 SEL swizzledSelector = @selector(xxx_run:);
 Method originalMethod = class_getInstanceMethod(originalClass, originalSelector);
 Method swizzledMethod = class_getInstanceMethod(swizzledClass, swizzledSelector);
 
 IMP originalIMP = method_getImplementation(originalMethod);
 IMP swizzledIMP = method_getImplementation(swizzledMethod);
 const char *originalType = method_getTypeEncoding(originalMethod);
 const char *swizzledType = method_getTypeEncoding(swizzledMethod);
 
 class_replaceMethod(originalClass,swizzledSelector,originalIMP,originalType);
 class_replaceMethod(originalClass,originalSelector,swizzledIMP,swizzledType);
 }
 */

@end
