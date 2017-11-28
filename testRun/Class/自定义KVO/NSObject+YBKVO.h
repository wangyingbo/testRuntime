//
//  NSObject+YBKVO.h
//  testRun
//
//  Created by 王迎博 on 2017/11/28.
//  Copyright © 2017年 王迎博. All rights reserved.
//
//  http://www.jianshu.com/p/a32d851603e5
//  http://tech.glowing.com/cn/implement-kvo/


#import <Foundation/Foundation.h>

/** 监听回调用block */
typedef void(^PGObservingBlock)(id observedObject,
                                NSString *observedKey,
                                id oldValue, id newValue);

@interface NSObject (YBKVO)
/** 添加观察者 */
- (void)PG_addObserver:(NSObject *)observer
                forKey:(NSString *)key
             withBlock:(PGObservingBlock)block;

/** 移除观察者 */
- (void)PG_removeObserver:(NSObject *)observer
                   forKey:(NSString *)key;

@end
