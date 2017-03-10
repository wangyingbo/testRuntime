//
//  decode.h
//  testRun
//
//  Created by 王迎博 on 16/7/15.
//  Copyright © 2016年 王迎博. All rights reserved.
//


// 一句宏搞定归解档
#import "NSObject+YBExtension.h"

#define CodingImplementation \
- (instancetype)initWithCoder:(NSCoder *)aDecoder {\
if (self = [super init]) {\
[self decode:aDecoder];\
}\
return self;\
}\
\
- (void)encodeWithCoder:(NSCoder *)aCoder {\
[self encode:aCoder];\
}
