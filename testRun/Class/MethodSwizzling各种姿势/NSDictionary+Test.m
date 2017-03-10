//
//  NSDictionary+Test.m
//  testRun
//
//  Created by 王迎博 on 16/8/29.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import "NSDictionary+Test.h"
#import <objc/runtime.h>

@implementation NSDictionary (Test)
+ (void)load {
    Class cls = [self class];
    SEL originalSelector = @selector(dictionary);
    SEL swizzledSelector = @selector(xxx_dictionary);
    
    // 使用class_getClassMethod来获取类方法的Method
    Method originalMethod = class_getClassMethod(cls, originalSelector);
    Method swizzledMethod = class_getClassMethod(cls, swizzledSelector);
    if (!originalMethod || !swizzledMethod) {
        return;
    }
    
    IMP originalIMP = method_getImplementation(originalMethod);
    IMP swizzledIMP = method_getImplementation(swizzledMethod);
    const char *originalType = method_getTypeEncoding(originalMethod);
    const char *swizzledType = method_getTypeEncoding(swizzledMethod);
    
    // 类方法添加,需要将方法添加到MetaClass中
    Class metaClass = objc_getMetaClass(class_getName(cls));
    class_replaceMethod(metaClass,swizzledSelector,originalIMP,originalType);
    class_replaceMethod(metaClass,originalSelector,swizzledIMP,swizzledType);
}

+ (id)xxx_dictionary {
    id result = [self xxx_dictionary];
    NSLog(@"替换系统的dictionary方法");
    return result;
}

@end
