//
//  UIViewController+YBSwizzling.m
//  testRun
//
//  Created by 王迎博 on 16/11/23.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import "UIViewController+YBSwizzling.h"
#import "NSObject+YBSwizzling.h"
#import <objc/runtime.h>

@implementation UIViewController (YBSwizzling)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(viewWillDisappear:) bySwizzledSelector:@selector(sure_viewWillDisappear:)];
    });
}

- (void)sure_viewWillDisappear:(BOOL)animated {
    [self sure_viewWillDisappear:animated];
    NSLog(@"可以再次操作");
}
@end
