//
//  CreateClassVC.m
//  testRun
//
//  Created by 王迎博 on 16/7/26.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import "CreateClassVC.h"
#include <objc/runtime.h>
#import "TableViewController.h"


@interface CreateClassVC ()

@end

@implementation CreateClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建类方法
    [self createClassMethod];
}


/**
 *  创建类方法
 */
- (void)createClassMethod
{
    const char *className = "MyClass";
    ///声明类
    Class MyClass = objc_getClass(className);
    if (!MyClass) {
        Class supercls = [NSObject class];
        MyClass = objc_allocateClassPair(supercls, className, 0);
    }
    
    ///添加一个属性
    objc_property_attribute_t type = { "T", "@\"NSString\"" };
    objc_property_attribute_t ownership = { "C", "" }; // C = copy
    objc_property_attribute_t backingivar  = { "V", "aProperty" };
    objc_property_attribute_t attribute[] = { type, ownership, backingivar };
    class_addIvar(MyClass, "aProperty", sizeof(NSString *), 0, "@");
    class_addProperty(MyClass, "aProperty", attribute, 1);
    class_addMethod(MyClass, @selector(aProperty), (IMP)aProperty, "@@:");
    class_addMethod(MyClass, @selector(setAPriperty:), (IMP)setAPriperty, "v@:@");
    
    ///添加一个变量
    class_addIvar(MyClass, "aIvar", sizeof(NSString *), 0, "@");
    
    ///添加一个方法
    class_addMethod(MyClass, @selector(aMethod:), (IMP)aMethod, "v@:@");
    objc_registerClassPair(MyClass);
    
    //替换方法
    class_replaceMethod(MyClass, @selector(description), (IMP)description, "@@:");
    
    //类的实例化
    id myObj = [MyClass new];
    
    Ivar ivar = class_getInstanceVariable(MyClass, "aIvar");
    object_setIvar( myObj, ivar, @"你好我是iVar");
    
    [myObj setAPriperty:@"这是property_____"];
    
    NSLog(@"----%@===",[myObj aProperty]);
    
    [myObj aMethod:100];
    
    NSString *des = [myObj description];
    //    id instence = getObjectFrom
    NSLog(@"------%@", des);
}


#pragma mark - 属性的添加
///get方法
NSString *aProperty(id SELF, SEL _cmd) {
    Ivar ivar = class_getInstanceVariable([SELF class], "aProperty");
    return object_getIvar(SELF, ivar);
}

- (NSString *)aProperty {
    return @"";
}
///set方法
void setAPriperty(id SELF, SEL _cmd, NSString *aProperty) {
    Ivar ivar = class_getInstanceVariable([SELF class], "aProperty");
    id oldName = object_getIvar(SELF, ivar);
    if (oldName != aProperty){
        object_setIvar(SELF, ivar, [aProperty copy]);
    }
}

- (void)setAPriperty:(NSString *)aPriperty {
    
}


#pragma mark - 方法的添加
void aMethod(id SELF, SEL _cmd, int a) {
    NSLog(@"调用好了方法...\n传入的参数为:%d", a);
    
    [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"传入值为%d", a] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
}

- (void)aMethod:(int )a {
    
}


#pragma mark - 方法的替换
NSString *description(id SELF, SEL _cmd) {
    
    NSString *str1 = getClassAttribute([SELF class]);
    
    NSMutableString *str = [NSMutableString stringWithString:str1];
    
    [str appendFormat:@"\n\n%@",getObjectValue(SELF)];
    
    
    return str;
}



@end
