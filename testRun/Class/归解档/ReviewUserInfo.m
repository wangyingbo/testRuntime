//
//  ReviewUserInfo.m
//  testRun
//
//  Created by 王迎博 on 16/7/15.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import "ReviewUserInfo.h"

@implementation ReviewUserInfo

@synthesize userName;
@synthesize userTime;
@synthesize userReview;
@synthesize userStarNum;

- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject:self.userName forKey:@"userName"];
    [coder encodeObject:self.userReview forKey:@"userReview"];
    [coder encodeObject:self.userTime forKey:@"userTime"];
    [coder encodeFloat:self.userStarNum forKey:@"userStarNum"];
}

- (id) initWithCoder: (NSCoder *) coder
{
    userName = [[coder decodeObjectForKey:@"userName"]copy];
    userReview = [[coder decodeObjectForKey:@"userReview"]copy];
    userTime = [[coder decodeObjectForKey:@"userTime"]copy];
    userStarNum = [coder decodeFloatForKey:@"userStarNum"];
    return self;
}
@end
