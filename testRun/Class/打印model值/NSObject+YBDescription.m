//
//  NSObject+YBDescription.m
//  testRun
//
//  Created by 王迎博 on 16/8/1.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import "NSObject+YBDescription.h"
#import <objc/runtime.h>

@implementation NSObject (YBDescription)
+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(debugDescription)), class_getInstanceMethod([self class], @selector(zxp_swizzleDebugDescription)));
}

- (NSString *)zxp_swizzleDebugDescription {
    
    //一把情况下,如果不是entity或者model的子类就不需要打印属性, 比如系统的class.~. 这个按照个人需求而定
//    if (![self isKindOfClass:[ZXPBaseEntity class]] || ![self isKindOfClass:[ZXPBaseModel class]]) {
//        return [self zxp_swizzleDebugDescription];
//    }
    // 以上代码是判断是否model或者entity
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    uint count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i<count; i++) {
        objc_property_t property = properties[i];
        NSString *name = @(property_getName(property));
        id value = [self valueForKey:name]?:@"nil";
        [dictionary setObject:value forKey:name];
    }
    
    free(properties);
    
    return [NSString stringWithFormat:@"<%@: %p> -- %@",[self class],self,dictionary];
}


@end
