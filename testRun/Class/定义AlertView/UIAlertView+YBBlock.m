//
//  UIAlertView+YBBlock.m
//  testRun
//
//  Created by 王迎博 on 16/8/1.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import "UIAlertView+YBBlock.h"
#import <objc/runtime.h>

static const char *YBDelegateKey = "!YBDelegateKey!";

#pragma mark - class
@interface YBAlertViewDelegate : NSObject <UIAlertViewDelegate>
{
    //block变量
    void(^_block)();
}

//初始化的时候传入一个block
- (instancetype)initWithBlock:(void(^)())block;

@end

@implementation YBAlertViewDelegate

- (instancetype)initWithBlock:(void(^)())block
{
    self = [super init];
    if (self) {
        //设置关联对象, 值为self
        objc_setAssociatedObject(self, YBDelegateKey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        _block = block;
    }
    return self;
}

#pragma mark - delegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (_block) {
        //执行block
        _block(alertView,buttonIndex);
    }
    
}

@end


@implementation UIAlertView (YBBlock)

- (void)yb_clickedButtonAtIndexWithBlock:(void(^)(UIAlertView *alertView,NSInteger buttonIndex))block {
    //获取delegate对象
    id delegate = objc_getAssociatedObject([[YBAlertViewDelegate alloc] initWithBlock:block], YBDelegateKey);
    //设置delegate为其他对象
    self.delegate = delegate;
    
}
@end
