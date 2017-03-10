//
//  UIViewController+YBBlock.m
//  testRun
//
//  Created by 王迎博 on 16/8/1.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import "UIViewController+YBBlock.h"
#import <objc/runtime.h>


@implementation UIViewController (YBBlock)

#pragma mark - runtime associate

- (void)setViewControllerActionBlock:(void (^)(UIViewController *vc, NSUInteger type, NSDictionary *dict))viewControllerActionBlock {
    objc_setAssociatedObject(self, @selector(viewControllerActionBlock), viewControllerActionBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UIViewController *, NSUInteger, NSDictionary *))viewControllerActionBlock {
    return objc_getAssociatedObject(self, @selector(viewControllerActionBlock));
}

#pragma mark - block

- (void)viewControllerAction:(void (^)(UIViewController *vc, NSUInteger type, NSDictionary *dict))viewControllerActionBlock {
    self.viewControllerActionBlock = nil;
    self.viewControllerActionBlock = [viewControllerActionBlock copy];
}


@end
