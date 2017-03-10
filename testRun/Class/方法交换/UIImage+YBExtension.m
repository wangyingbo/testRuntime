//
//  UIImage+YBExtension.m
//  testRun
//
//  Created by 王迎博 on 16/7/15.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import "UIImage+YBExtension.h"
#import <objc/runtime.h>

@implementation UIImage (YBExtension)
+ (UIImage *)yb_imageNamed:(NSString *)name {
    
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    if (version >= 7.0) {
        // 如果系统版本是7.0以上，使用另外一套文件名结尾是‘_os7’的扁平化图片
        name = [name stringByAppendingString:@"_os7"];
    }
    return [UIImage yb_imageNamed:name];
}


+ (void)load
{
    Method m1 = class_getClassMethod([UIImage class], @selector(imageNamed:));
    Method m2 = class_getClassMethod([UIImage class], @selector(yb_imageNamed:));
    
    method_exchangeImplementations(m1, m2);
}
@end
