//
//  NSObject+YBCategory.m
//  testRun
//
//  Created by 王迎博 on 16/7/15.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import "NSObject+YBCategory.h"
#import <objc/runtime.h>


char nameKey;

@implementation NSObject (YBCategory)


/**
     set方法，将值value 跟对象object 关联起来（将值value 存储到对象object 中）
     参数 object：给哪个对象设置属性
     参数 key：一个属性对应一个Key，将来可以通过key取出这个存储的值，key 可以是任何类型：double、int 等，建议用char 可以节省字节
     参数 value：给属性设置的值
     参数policy：存储策略 （assign 、copy 、 retain就是strong）
     void objc_setAssociatedObject(id object , const void *key ,id value ,objc_AssociationPolicy policy)
 */
- (void)setName:(NSString *)name

{
    //将耨个值跟某个对象关联起来，将某个值存储到某个对象中
    objc_setAssociatedObject(self, &nameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


/**
 *  利用参数key 将对象object中存储的对应值取出来
 */
- (NSString *)name
{
    //id objc_getAssociatedObject(id object , const void *key)
    return objc_getAssociatedObject(self, &nameKey);
}

@end
