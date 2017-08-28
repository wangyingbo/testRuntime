//
//  ViewController.m
//  testRun
//
//  Created by 王迎博 on 16/7/14.
//  Copyright © 2016年 王迎博. All rights reserved.

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
#import "NSArray+YBExtension.h"
#import "TableViewController.h"
#import "DemoObj.h"
#import "CreateClassVC.h"
#import "testVC.h"
#import "UIViewController+YBBlock.h"
#import "testModel.h"
#import "UIAlertView+YBBlock.h"
#import "NSObject+XWAdd.h"
#import "XWTestObject.h"
#import "UIViewController+Tracking.h"
#import "Car.h"
#import "NSDictionary+Test.h"
#import "UIControl+Custom.h"
#import "NSObject+YBProperty.h"



#define  FULL_SCREEN_W [UIScreen mainScreen].bounds.size.width
#define FULL_SCREEN_H [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *twelvthBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirteenBtn;
@property (weak, nonatomic) IBOutlet UIButton *fifteen;
@property (weak, nonatomic) IBOutlet UIButton *seventeenBtn;

@property (nonatomic, strong) XWTestObject *objA;

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
    
    //8、用runtime测试数组越界
    [self testArray];
    
    //9、用runtime遍历一个类的所有属性
    [self getAllPropeties];
    
    //10、用runtime测试替换方法
    [self replaceMethod];
    
    //11、用runtime动态挂载对象
    [self addObject];
    
    //12、用runtime动态创建类
    [self objectClass];
    
    //13、用runtime给viewController的block回调
    [self testVCBlock];
    
    //14、用runtime利用debugDescription打印model的值
    [self debugDescriptionModel];
    
    //15、用runtime定义alertView
    [self testRuntimeAlertView];
    
    //16、用runtime中文打印输出NSArray和NSDictionary的内容
    [self logArrayDictionary];
    
    //17、一键调用通知和KVO
    [self testKVO_Notification];
    
    //18、Method Swizzling的各种姿势
    //参见 UIViewController+Tracking.h
    
    //19、在不同类之间实现Method Swizzling
    [self testMethodSwizzling];
    
    //20、实现类方法的Method Swizzling
    [self testCategoryMethodSwizzling];
    
    //21、在类簇中如何实现Method Swizzling
    [self test21];
    
    //22、解决同一个button重复点击事件
    [self testSameButtonClick];
    
    //23、一行代码生成模型所有属性
    [self autoGetProperty];
}

/**
 *  23、一行代码生成模型所有属性
 */
- (void)autoGetProperty
{
    // 1.定义一个字典
    NSDictionary *dict = @{
                           @"statuses" : @[
                                   @{
                                       @"text" : @"今天天气真不错！",
                                       
                                       @"user" : @{
                                               @"name" : @"Rose",
                                               @"icon" : @"nami.png"
                                               }
                                       },
                                   
                                   @{
                                       @"text" : @"明天去旅游了",
                                       
                                       @"user" : @{
                                               @"name" : @"Jack",
                                               @"icon" : @"lufy.png"
                                               }
                                       }
                                   ],
                           
                           @"ads" : @[
                                   @{
                                       @"image" : @"ad01.png",
                                       @"url" : @"http://www.小码哥ad01.com"
                                       },
                                   @{
                                       @"image" : @"ad02.png",
                                       @"url" : @"http://www.小码哥ad02.com"
                                       }
                                   ],
                           
                           @"totalNumber" : @"2014",
                           @"previousCursor" : @"13476589",
                           @"nextCursor" : @"13476599"
                           };
    
    //log出来的可以直接复制
    [NSObject propertyCodeWithDictionary:dict];
    
}

/**
 *  22、解决同一个button重复点击事件
 */
- (void)testSameButtonClick
{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(FULL_SCREEN_W*2/3, FULL_SCREEN_H*1/2, 120, 50)];
    [button setTitle:@"12_testFunc12" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(func22) forControlEvents:UIControlEventTouchUpInside];
    button.custom_acceptEventInterval = 2.0;
    [self.view addSubview:button];
}


- (void)func22
{
    NSLog(@"解决button重复点击");
}


/**
 *  21、在类簇中如何实现Method Swizzling
 */
- (void)test21
{
    //NSMutableDictionary的setObject:forKey:方法,让调用这个方法时当参数object或key为空的不会抛出异常
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    [mutDic setObject:@"" forKey:@"test"];
}


/**
 *  20、实现类方法的Method Swizzling
 */
- (void)testCategoryMethodSwizzling
{
    //参见NSDictionary+Test.h
    NSDictionary *dic = [NSDictionary dictionary];
    NSLog(@"%@",dic);
    
}


/**
 *  19、在不同类之间实现Method Swizzling
 */
- (void)testMethodSwizzling
{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(FULL_SCREEN_W*2/3, FULL_SCREEN_H*1/3, 120, 50)];
    [button setTitle:@"19_testFunc19" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(func19) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


- (void)func19
{
    Car *car = [[Car alloc]init];
    [self.navigationController pushViewController:car animated:YES];
}


/**
 *  18、Method Swizzling的各种姿势
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}


/**
 *  17、一键调用通知和KVO
 */
- (void)testKVO_Notification
{
    _objA = [XWTestObject new];
    
    [self.seventeenBtn addTarget:self action:@selector(testKVO_Notification_Click:) forControlEvents:UIControlEventTouchUpInside];
    
    [_objA xw_addObserverBlockForKeyPath:@"name" block:^(id obj, id oldVal, id newVal) {
        NSLog(@"kvo，修改name为%@", newVal);
    }];
    [self xw_addNotificationForName:@"XWTestNotificaton" block:^(NSNotification *notification) {
        NSLog(@"收到通知1：%@", notification.userInfo);
    }];
}


/**
 *  注册一个通知
 */
- (void)testKVO_Notification_Click:(UIButton *)btn
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"XWTestNotificaton" object:nil userInfo:@{@"test" : @"王颖博"}];
    
    static BOOL flag = NO;
    if (!flag) {
        _objA.name = @"wazrx";
        flag = YES;
    }else{
        _objA = nil;//objA 销毁的时候其绑定的KVO会自己移除
    }
}


/**
 *  16、用runtime中文打印输出NSArray和NSDictionary的内容
 */
- (void)logArrayDictionary
{
    NSArray *arr = @[@"test1",@"sssss"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"王颖博",@"name", nil];
    
    NSLog(@"arr:%@",arr);
    NSLog(@"dic:%@",dic);
}


/**
 *  15、用runtime定义alertView
 */
- (void)testRuntimeAlertView
{
    [self.fifteen addTarget:self action:@selector(showRuntimeAlertView) forControlEvents:UIControlEventTouchUpInside];
}


- (void)showRuntimeAlertView
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"show" message:@"傻逼啊" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    [alertView yb_clickedButtonAtIndexWithBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            NSLog(@"*****%ld",(long)buttonIndex);
        }else if (buttonIndex == 1)
        {
            NSLog(@"*****%ld",(long)buttonIndex);
        }
    }];
}


/**
 *  14、用runtime利用debugDescription打印model的值
 */
- (void)debugDescriptionModel
{
    testModel *model = [[testModel alloc]init];
    model.name = @"王颖博";
    model.age = @"25";
    NSLog(@"testModel:%@",model);
    
    /**
     *  由于直接NSLog的话，会打印model的内存地址，所以为了方便，我们使用了debugDescription，来打印model内容。
     *  打上断点，然后 po model
     */
}


/**
 *  13、用runtime给viewController的block回调
 */
- (void)testVCBlock
{
    [self.thirteenBtn addTarget:self action:@selector(thirtheenBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)thirtheenBtnClick:(UIButton *)button
{
    testVC *vc = [[testVC alloc]init];
    [vc viewControllerAction:^(UIViewController *vc, NSUInteger type, NSDictionary *dict) {
        NSLog(@"__%lu",(unsigned long)type);
    }];
    [self.navigationController pushViewController:vc animated:YES];
    
}


/**
 *  12、动态创建类
 */
- (void)objectClass
{
    SEL tewlveMethod = @selector(createClassVC:);
    [self.twelvthBtn addTarget:self action:tewlveMethod forControlEvents:UIControlEventTouchUpInside];
}


- (void)createClassVC:(UIButton *)button
{
    CreateClassVC *vc = [[CreateClassVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


/**
 *  11、用runtime动态挂载对象
 */
static const char associatedKey;
- (void)addObject
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"我是DemoObj动态挂载的" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    DemoObj *obj = [DemoObj new];
    objc_setAssociatedObject(obj, &associatedKey, alert, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self getAssociatedObject:obj];
    });
}


- (void)getAssociatedObject:(DemoObj *)obj {
    
    UIAlertView *alert = objc_getAssociatedObject(obj, &associatedKey);
    [alert show];
}


/**
 *  10、用runtime测试替换方法
 */
- (void)replaceMethod
{
    DemoObj *obj = [[DemoObj alloc]init];
    [obj replaceMethod];
    [obj eat];
}


/**
 *  9、用runtime遍历一个类的所有属性
 */
- (void)getAllPropeties
{
    SEL btnMethod  = @selector(nextPage:);
    [self.firstBtn addTarget:self action:btnMethod forControlEvents:UIControlEventTouchUpInside];
}


/**
 *  跳转到下一页展示所有属性
 */
- (void)nextPage:(UIButton *)button
{
    TableViewController *tabVC = [[TableViewController alloc]init];
    [self.navigationController pushViewController:tabVC animated:YES];
}


/**
 *  8、测试数组越界
 */
- (void)testArray
{
    NSArray *array = @[@"11",@"22",@"33"];
    NSString *string = [array objectAtIndex:5];
    NSLog(@"....%@",string);
}


/**
 *  7、用runtime获取所有属性来进行字典转模型
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
    UIImageView *testImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 100, 150, 50)];
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
