//
//  UIAlertView+YBBlock.h
//  testRun
//
//  Created by 王迎博 on 16/8/1.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (YBBlock)
- (void)yb_clickedButtonAtIndexWithBlock:(void(^)(UIAlertView *alertView,NSInteger buttonIndex))block;


@end
