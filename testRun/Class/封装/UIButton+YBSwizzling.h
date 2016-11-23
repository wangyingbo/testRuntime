//
//  UIButton+YBSwizzling.h
//  testRun
//
//  Created by 王迎博 on 16/11/23.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+YBSwizzling.h"
#import <objc/runtime.h>

//默认时间间隔
#define defaultInterval 1

@interface UIButton (YBSwizzling)
//点击间隔
@property (nonatomic, assign) NSTimeInterval timeInterval;
//用于设置单个按钮不需要被hook
@property (nonatomic, assign) BOOL isIgnore;
@end
