//
//  ViewController.m
//  testRun
//
//  Created by 王迎博 on 16/7/14.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cat.h"

@interface User : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) double height;
@property (nonatomic,assign) int age;

// 属性是一个对象
@property (nonatomic,strong) Cat*cat;
// 属性是一个数组
@property (nonatomic,strong) NSArray *books;

@end
