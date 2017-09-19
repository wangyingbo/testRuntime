//
//  UIButton+YBEventInterval.h
//  testRun
//
//  Created by 王迎博 on 2017/9/19.
//  Copyright © 2017年 王迎博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (YBEventInterval)

/**
 *  为按钮添加点击间隔 eventTimeInterval秒
 */
@property (nonatomic, assign) NSTimeInterval eventTimeInterval;

@end
