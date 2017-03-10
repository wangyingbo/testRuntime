//
//  UILabel+YBSwizzling.h
//  testRun
//
//  Created by 王迎博 on 16/11/23.
//  Copyright © 2016年 王迎博. All rights reserved.
//  全局更换控件初始效果,以UILabel为例，在项目比较成熟的基础上，应用中需要引入新的字体，需要更换所有Label的默认字体

#import <UIKit/UIKit.h>
#import "NSObject+YBSwizzling.h"
#import <objc/runtime.h>

@interface UILabel (YBSwizzling)

@end
