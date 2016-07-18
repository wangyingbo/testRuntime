//
//  UIImage+YBExtension.h
//  testRun
//
//  Created by 王迎博 on 16/7/15.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import "NSArray+YBExtension.h"
#import <objc/runtime.h>

//自定义高效率的 NSLog
#ifdef DEBUG
#define YB_Log(...) NSLog(@"打印：\n%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define YB_Log(...)
#endif

@implementation NSArray (YBExtension)


+ (void)load {
    
    SEL safeSel   = @selector(safeObjectAtIndex:);
    SEL unsafeSel = @selector(objectAtIndex:);
    
    Class class = NSClassFromString(@"__NSArrayI");
    
    Method safeMethod   = class_getInstanceMethod(class, safeSel);
    Method unsafeMethod = class_getInstanceMethod(class, unsafeSel);
    
    method_exchangeImplementations(unsafeMethod, safeMethod);
}

- (id)safeObjectAtIndex:(NSUInteger)index {
    
    if (index > (self.count - 1)) {
        //NSAssert(NO, @"beyond the boundary");
        return nil;
    } else {
        return [self safeObjectAtIndex:index];
    }
}
@end
