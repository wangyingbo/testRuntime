//
//  ViewController.h
//  testRun
//
//  Created by 王迎博 on 16/7/26.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import "DemoObj.h"
#include <objc/runtime.h>
@implementation DemoObj


- (void)replaceMethod {
    
    class_replaceMethod([DemoObj class], @selector(eat), (IMP)run, NULL);
}

- (void)eat {
    NSLog(@"i am eat");
}

void run(id SELF, SEL _cmd) {

      NSLog(@"i am run");
}

@end
