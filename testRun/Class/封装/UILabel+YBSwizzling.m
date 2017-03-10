//
//  UILabel+YBSwizzling.m
//  testRun
//
//  Created by 王迎博 on 16/11/23.
//  Copyright © 2016年 王迎博. All rights reserved.
//  全局更换控件初始效果,以UILabel为例，在项目比较成熟的基础上，应用中需要引入新的字体，需要更换所有Label的默认字体

#import "UILabel+YBSwizzling.h"

@implementation UILabel (YBSwizzling)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(init) bySwizzledSelector:@selector(sure_Init)];
        [self methodSwizzlingWithOriginalSelector:@selector(initWithFrame:) bySwizzledSelector:@selector(sure_InitWithFrame:)];
        [self methodSwizzlingWithOriginalSelector:@selector(awakeFromNib) bySwizzledSelector:@selector(sure_AwakeFromNib)];
    });
}
- (instancetype)sure_Init{
    id __self = [self sure_Init];
    UIFont * font = [UIFont fontWithName:@"Zapfino" size:self.font.pointSize];
    if (font) {
        self.font=font;
    }
    return __self;
}
-(instancetype)sure_InitWithFrame:(CGRect)rect{
    id __self = [self sure_InitWithFrame:rect];
    UIFont * font = [UIFont fontWithName:@"Zapfino" size:self.font.pointSize];
    if (font) {
        self.font=font;
    }
    return __self;
}
-(void)sure_AwakeFromNib{
    [self sure_AwakeFromNib];
    UIFont * font = [UIFont fontWithName:@"Zapfino" size:self.font.pointSize];
    if (font) {
        self.font=font;
    }
}
@end
