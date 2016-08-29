//
//  UIViewController+Tracking.m
//  testRun
//
//  Created by 王迎博 on 16/8/29.
//  Copyright © 2016年 王迎博. All rights reserved.

//  原链：http://www.tanhao.me/code/160723.html/#more
//  博主：http://www.tanhao.me


#import "UIViewController+Tracking.h"
#import <objc/runtime.h>


@implementation UIViewController (Tracking)


+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = [self class];
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(yb_viewWillAppear:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
    });
}

#pragma mark - Method Swizzling

- (void)yb_viewWillAppear:(BOOL)animated {
    [self yb_viewWillAppear:animated];
    NSLog(@"viewWillAppear: %@", self);
}



/** 以上的代码也可以简写为以下
 
 Class class = [self class];
 
 SEL originalSelector = @selector(viewWillAppear:);
 SEL swizzledSelector = @selector(xxx_viewWillAppear:);
 Method originalMethod = class_getInstanceMethod(class, originalSelector);
 Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
 if (!originalMethod || !swizzledMethod) {
 return;
 }
 
 IMP originalIMP = method_getImplementation(originalMethod);
 IMP swizzledIMP = method_getImplementation(swizzledMethod);
 const char *originalType = method_getTypeEncoding(originalMethod);
 const char *swizzledType = method_getTypeEncoding(swizzledMethod);
 
 class_replaceMethod(class,originalSelector,swizzledIMP,swizzledType);
 class_replaceMethod(class,swizzledSelector,originalIMP,originalType);
 */








@end
