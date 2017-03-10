//
//  testVC.m
//  testRun
//
//  Created by 王迎博 on 16/8/1.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import "testVC.h"
#import "UIViewController+YBBlock.h"


@interface testVC ()

@end

@implementation testVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.viewControllerActionBlock(nil,2,nil);
    [self.navigationController popViewControllerAnimated:YES];
}

@end
