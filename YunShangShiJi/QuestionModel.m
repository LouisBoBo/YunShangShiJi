//
//  QuestionModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/22.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "QuestionModel.h"

@implementation QuestionModel
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.question forKey:@"question"];
    [aCoder encodeObject:self.questionID forKey:@"questionid"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self=[super init])
    {
        self.question=[aDecoder decodeObjectForKey:@"question"];
        self.questionID=[aDecoder decodeObjectForKey:@"questionid"];
        
    }
    return self;
}
@end
