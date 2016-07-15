//
//  people.m
//  testRun
//
//  Created by 王迎博 on 16/7/15.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import "Dog.h"
#import "NSObject+YBExtension.h"
#import "decode.h"


@interface Dog()
@end

@implementation Dog

CodingImplementation

// 设置需要忽略的属性
- (NSArray *)ignoredNames {
    return @[@"bone"];
}



//// 在系统方法内来调用我们的方法
//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    if (self = [super init]) {
//        [self decode:aDecoder];
//    }
//    return self;
//}
//
//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [self encode:aCoder];
//}


@end
