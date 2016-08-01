//
//  UIViewController+YBBlock.h
//  testRun
//
//  Created by 王迎博 on 16/8/1.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (YBBlock)
#pragma mark - block
@property (nonatomic, copy) void (^viewControllerActionBlock)(UIViewController *vc, NSUInteger type, NSDictionary *dict);

#pragma mark - viewControllerAction

/**
 *  View 事件的block回调
 *
 *  @param viewControllerActionBlock block的参数有view本身，状态码，键值对。
 */
- (void)viewControllerAction:(void (^)(UIViewController *vc, NSUInteger type, NSDictionary *dict))viewControllerActionBlock;

@end
