//
//  ViewController.m
//  testRun
//
//  Created by 王迎博 on 16/7/14.
//  Copyright © 2016年 王迎博. All rights reserved.
//  链接：http://www.jianshu.com/p/ab966e8a82e2

#import "ViewController.h"
#import <objc/runtime.h>
#import "Person.h"
#import "UIImage+YBExtension.h"
#import "NSObject+YBCategory.h"
#import "ReviewUserInfo.h"
#import "People.h"
#import "Dog.h"
#import "decode.h"
#import "User.h"
#import "NSObject+JSONExtension.h"
#import "Book.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //1、用runtime测试交换两个类方法
    [self testExchangeMethod];
    
    //2、用runtime拦截系统方法
    [self testInterceptMethod];
    
    //3、用runtime在分类中给任何一个对象设置属性
    [self testAddPropertyInCategory];
    
    //4、测试归档、解档
    [self testArchiver];
    
    //5、用runtime获得一个类的所有成员变量
    [self testGetAllGuys];
    
    //6、用runtime测试解档归档
    [self testRuntimeArchiver];
    
    //7、用runtime获取所有属性来进行字典转模型
    [self testJsonModel];
}


/**
 *  用runtime获取所有属性来进行字典转模型
 */
- (void)testJsonModel
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"model.json" ofType:nil];
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:NULL];
    
    User *user = [User objectWithDict:json];
    NSLog(@"%@",user.cat.name);
    Book *book = user.books[0];
    NSLog(@"user.books数组:%@",user.books);
    NSLog(@"book内容：%@",book.publisher);
}


/**
 *  6、用runtime测试解档归档
 */
- (void)testRuntimeArchiver
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"myTemp.plist"];
    People *myPeople = [[People alloc] init];
    // 归档
    myPeople.peopleName = @"用runtime测试解档归档";
    myPeople.age = @"age";
    [NSKeyedArchiver archiveRootObject:myPeople toFile:path];
    // 解档
    People *myPeople1 = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"myPeople1.peopleName:%@",myPeople1.peopleName);
    NSLog(@"myPeople1.age:%@",myPeople1.age);
    
    
    //利用宏定义测试
    NSString *path1 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"dog.plist"];
    Dog *myDog = [[Dog alloc] init];
    // 归档
    myDog.bone = @"羊骨头";
    myDog.leg = @"三条腿";
    [NSKeyedArchiver archiveRootObject:myDog toFile:path1];
    // 解档
    Dog *myDog1 = [NSKeyedUnarchiver unarchiveObjectWithFile:path1];
    NSLog(@"myDog1.bone:%@",myDog1.bone);
    NSLog(@"myDog1.leg:%@",myDog1.leg);
}


/**
 *  5、用runtime获得一个类的所有成员变量
 */
- (void)testGetAllGuys
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"temp.plist"];
    
    Person *person = [[Person alloc] init];
    // 归档
    person.userName = @"人人";
    [NSKeyedArchiver archiveRootObject:person toFile:path];
    // 解档
    Person *person1 = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"person.name:%@",person1.userName);
    //NSLog(@"%@",path);
}


/**
 *  4、测试归档、解档
 */
- (void)testArchiver
{
    //归档
    NSMutableArray *userNameArray = [NSMutableArray array];
    
    ReviewUserInfo *userInfo = [[ReviewUserInfo alloc]init];
    userInfo.userName = @"张三";
    userInfo.userReview = @"测试归档、解档";
    userInfo.userTime = @"2016-07-15";
    userInfo.userStarNum = 123;
    [userNameArray addObject:userInfo];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:userNameArray] forKey:@"UserReviewName"];
    
    //解档
    NSMutableArray *myArray = [NSMutableArray array];
    NSData *dataRepresentingSavedArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserReviewName"];
    if (dataRepresentingSavedArray != nil) {
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        [myArray setArray:oldSavedArray];
        ReviewUserInfo * myInfo =[myArray firstObject];
        NSLog(@"myInfo:%@",myInfo.userReview);
    }
}


/**
 *  3、用runtime在分类中给任何一个对象设置属性
 */
- (void)testAddPropertyInCategory
{
    NSObject *objc = [[NSObject alloc]init];
    objc.name = @"test";
}


/**
 *  2、用runtime拦截系统方法
 */
- (void)testInterceptMethod
{
    //拦截系统的imageNamed方法
    UIImageView *testImageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 100, 150, 50)];
    testImageView.image = [UIImage imageNamed:@"test"];
    testImageView.clipsToBounds = YES;
    testImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:testImageView];
}


/**
 *  1、用runtime测试交换两个类方法
 */
- (void)testExchangeMethod
{
    //获取两个类的类方法
    SEL sel1 = @selector(Run);
    Method m1 = class_getClassMethod([Person class], sel1);
    SEL sel2 = @selector(Study);
    Method m2 = class_getClassMethod([Person class], sel2);
    
    //开始交换方法实现
    method_exchangeImplementations(m1, m2);
    
    [Person Run];
    [Person Study];
}


@end
