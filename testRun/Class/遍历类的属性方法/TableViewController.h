//
//  ViewController.h
//  testRun
//
//  Created by 王迎博 on 16/7/26.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController

///获得传入类的属性/方法/变量
extern NSString * getClassAttribute(Class cls);

///获得传入对象的属性/变量的值
extern NSString *getObjectValue(id object);

@end
