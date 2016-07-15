//
//  ReviewUserInfo.h
//  testRun
//
//  Created by 王迎博 on 16/7/15.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReviewUserInfo : NSObject<NSCoding>
{
    NSString  *userName;
    NSString  *userReview;
    NSString  *userTime;
    float     userStarNum;
}

@property(nonatomic,copy)NSString  *userName;
@property(nonatomic,copy)NSString  *userReview;
@property(nonatomic,copy)NSString  *userTime;
@property(nonatomic,assign)float    userStarNum;
- (void)encodeWithCoder:(NSCoder *)aCoder;
- (id)initWithCoder:(NSCoder *)aDecoder;

@end
