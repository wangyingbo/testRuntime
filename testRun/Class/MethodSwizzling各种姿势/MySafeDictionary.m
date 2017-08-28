//
//  MySafeDictionary.m
//  testRun
//
//  Created by 王迎博 on 16/8/29.
//  Copyright © 2016年 王迎博. All rights reserved.

//一个简单的示例通过交换NSMutableDictionary的setObject:forKey:方法,让调用这个方法时当参数object或key为空的不会抛出异常:

#import "MySafeDictionary.h"
#import <objc/runtime.h>


@implementation MySafeDictionary


+ (void)load {
    Class originalClass = NSClassFromString(@"__NSDictionaryM");
    Class swizzledClass = [self class];
    SEL originalSelector = @selector(setObject:forKey:);
    SEL swizzledSelector = @selector(safe_setObject:forKey:);
    Method originalMethod = class_getInstanceMethod(originalClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(swizzledClass, swizzledSelector);
    
    IMP originalIMP = method_getImplementation(originalMethod);
    IMP swizzledIMP = method_getImplementation(swizzledMethod);
    const char *originalType = method_getTypeEncoding(originalMethod);
    const char *swizzledType = method_getTypeEncoding(swizzledMethod);
    
    class_replaceMethod(originalClass,swizzledSelector,originalIMP,originalType);
    class_replaceMethod(originalClass,originalSelector,swizzledIMP,swizzledType);
}

- (void)safe_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (anObject && aKey) {
        [self safe_setObject:anObject forKey:aKey];
        //NSLog(@"更新了方法");
    }
    else if (aKey) {
        [(NSMutableDictionary *)self removeObjectForKey:aKey];
    }
}



#pragma mark - 在Method Swizzling之后如何恢复
/**  在Method Swizzling之后如何恢复
 
 static NSLock *kMySafeLock = nil;
 static IMP kMySafeOriginalIMP = NULL;
 static IMP kMySafeSwizzledIMP = NULL;
 
 @implementation MySafeDictionary
 
 + (void)swizzlling {
 static dispatch_once_t onceToken;
 dispatch_once(&onceToken, ^{
 kMySafeLock = [[NSLock alloc] init];
 });
 
 [kMySafeLock lock];
 
 do {
 if (kMySafeOriginalIMP || kMySafeSwizzledIMP) break;
 
 Class originalClass = NSClassFromString(@"__NSDictionaryM");
 if (!originalClass) break;
 
 Class swizzledClass = [self class];
 SEL originalSelector = @selector(setObject:forKey:);
 SEL swizzledSelector = @selector(safe_setObject:forKey:);
 Method originalMethod = class_getInstanceMethod(originalClass, originalSelector);
 Method swizzledMethod = class_getInstanceMethod(swizzledClass, swizzledSelector);
 if (!originalMethod || !swizzledMethod) break;
 
 IMP originalIMP = method_getImplementation(originalMethod);
 IMP swizzledIMP = method_getImplementation(swizzledMethod);
 const char *originalType = method_getTypeEncoding(originalMethod);
 const char *swizzledType = method_getTypeEncoding(swizzledMethod);
 
 kMySafeOriginalIMP = originalIMP;
 kMySafeSwizzledIMP = swizzledIMP;
 
 class_replaceMethod(originalClass,swizzledSelector,originalIMP,originalType);
 class_replaceMethod(originalClass,originalSelector,swizzledIMP,swizzledType);
 } while (NO);
 
 [kMySafeLock unlock];
 }
 
 + (void)restore {
 [kMySafeLock lock];
 
 do {
 if (!kMySafeOriginalIMP || !kMySafeSwizzledIMP) break;
 
 Class originalClass = NSClassFromString(@"__NSDictionaryM");
 if (!originalClass) break;
 
 Method originalMethod = NULL;
 Method swizzledMethod = NULL;
 unsigned int outCount = 0;
 Method *methodList = class_copyMethodList(originalClass, &outCount);
 for (unsigned int idx=0; idx < outCount; idx++) {
 Method aMethod = methodList[idx];
 IMP aIMP = method_getImplementation(aMethod);
 if (aIMP == kMySafeSwizzledIMP) {
 originalMethod = aMethod;
 }
 else if (aIMP == kMySafeOriginalIMP) {
 swizzledMethod = aMethod;
 }
 }
 // 尽可能使用exchange,因为它是atomic的
 if (originalMethod && swizzledMethod) {
 method_exchangeImplementations(originalMethod, swizzledMethod);
 }
 else if (originalMethod) {
 method_setImplementation(originalMethod, kMySafeOriginalIMP);
 }
 else if (swizzledMethod) {
 method_setImplementation(swizzledMethod, kMySafeSwizzledIMP);
 }
 kMySafeOriginalIMP = NULL;
 kMySafeSwizzledIMP = NULL;
 } while (NO);
 
 [kMySafeLock unlock];
 }
 
 - (void)safe_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
 if (anObject && aKey) {
 [self safe_setObject:anObject forKey:aKey];
 }
 else if (aKey) {
 [(NSMutableDictionary *)self removeObjectForKey:aKey];
 }
 }
 @end
 
 */




@end
