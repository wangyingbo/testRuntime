//
//  ViewController.m
//  testRun
//
//  Created by 王迎博 on 16/7/14.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fish.h"

@interface Cat : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) double price;
// 属性是一个对象
@property (nonatomic,strong) Fish *fish;

@end
