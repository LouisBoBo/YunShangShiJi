//
//  TaskModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 16/10/18.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TaskModel.h"

@implementation TaskModel

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.index forKey:@"index"];
    [aCoder encodeObject:self.num forKey:@"num"];
    [aCoder encodeObject:self.t_id forKey:@"t_id"];
    [aCoder encodeObject:self.task_class forKey:@"task_class"];
    [aCoder encodeObject:self.task_type forKey:@"task_type"];
    [aCoder encodeObject:self.t_name forKey:@"t_name"];
    [aCoder encodeObject:self.imagestr forKey:@"imagestr"];
    [aCoder encodeObject:self.value forKey:@"value"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeBool:self.isfinish forKey:@"isfinish"];
    [aCoder encodeObject:self.app_name forKey:@"app_name"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self=[super init])
    {
        self.index=[aDecoder decodeObjectForKey:@"index"];
        self.num=[aDecoder decodeObjectForKey:@"num"];
        self.t_id=[aDecoder decodeObjectForKey:@"t_id"];
        self.task_class=[aDecoder decodeObjectForKey:@"task_class"];
        self.task_type=[aDecoder decodeObjectForKey:@"task_type"];
        self.t_name=[aDecoder decodeObjectForKey:@"t_name"];
        self.imagestr=[aDecoder decodeObjectForKey:@"imagestr"];
        self.value=[aDecoder decodeObjectForKey:@"value"];
        self.name=[aDecoder decodeObjectForKey:@"name"];
        self.status=[aDecoder decodeObjectForKey:@"status"];
        self.isfinish=[aDecoder decodeBoolForKey:@"isfinish"];
        self.app_name=[aDecoder decodeObjectForKey:@"app_name"];
    }
    return self;
}

@end
