//
//  Person.m
//  testRun
//
//  Created by 王迎博 on 16/7/14.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person

#pragma mark - 实现归解档
// 设置不需要归解档的属性
- (NSArray *)ignoredNames
{
    return @[@"_aaa",@"_bbb",@"_ccc"];
}

// 解档方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        // 获取所有的成员变量
        unsigned int outCount = 0;
        //返回值：存放所有获取到的属性，通过下面两个方法可以调出名字和类型
        Ivar *ivars = class_copyIvarList([self class], &outCount);
        
        for (int i = 0; i < outCount; i++)
        {
            Ivar ivar = ivars[i];
            // 将每个成员变量名转换为NSString对象类型
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            // 忽略不需要解档的属性
            if ([[self ignoredNames] containsObject:key])
            {
                continue;
            }
            
            // 根据变量名解档取值，无论是什么类型
            id value = [aDecoder decodeObjectForKey:key];
            // 取出的值再设置给属性
            [self setValue:value forKey:key];
            // 这两步就相当于以前的 self.age = [aDecoder decodeObjectForKey:@"_age"];
        }
        free(ivars);
    }
    return self;
}


// 归档调用方法
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    // 获取所有成员变量
    unsigned int outCount = 0;
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    for (int i = 0; i < outCount; i++)
    {
        Ivar ivar = ivars[i];
        // 将每个成员变量名转换为NSString对象类型
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        // 忽略不需要归档的属性
        if ([[self ignoredNames] containsObject:key])
        {
            continue;
        }
        
        // 通过成员变量名，取出成员变量的值
        id value = [self valueForKeyPath:key];
        // 再将值归档
        [aCoder encodeObject:value forKey:key];
        // 这两步就相当于 [aCoder encodeObject:@(self.age) forKey:@"_age"];
    }
    
    free(ivars);
}


#pragma mark - runtime实现方法交换
+ (void)Run
{
    NSLog(@"跑");
}


+ (void)Study
{
    NSLog(@"学习");
}

@end
