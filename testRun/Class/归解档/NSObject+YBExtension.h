//
//  NSObject+YBExtension.h
//  testRun
//
//  Created by 王迎博 on 16/7/15.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YBExtension)

- (NSArray *)ignoredNames;
- (void)encode:(NSCoder *)aCoder;
- (void)decode:(NSCoder *)aDecoder;

@end
