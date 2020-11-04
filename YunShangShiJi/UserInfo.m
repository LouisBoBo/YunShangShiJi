//
//  UserInfo.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/13.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "UserInfo.h"
#import "GlobalTool.h"
@implementation UserInfo
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userName forKey:USER_NAME];
    [aCoder encodeObject:self.userPhone forKey:USER_PHONE];
    [aCoder encodeObject:self.userPassword forKey:USER_PASSWORD];
    
    [aCoder encodeObject:self.shop_code forKey:SHOP_CODE];
    [aCoder encodeObject:self.shop_name forKey:SHOP_NAME];
    [aCoder encodeObject:self.shop_price forKey:SHOP_PRICE];
    [aCoder encodeObject:self.shop_pic forKey:SHOP_PIC];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self=[super init])
    {
        self.userName=[aDecoder decodeObjectForKey:USER_NAME];
        self.userName=[aDecoder decodeObjectForKey:USER_NAME];
        self.userName=[aDecoder decodeObjectForKey:USER_NAME];
        
        self.shop_name=[aDecoder decodeObjectForKey:SHOP_NAME];
        self.shop_code=[aDecoder decodeObjectForKey:SHOP_CODE];
        self.shop_pic=[aDecoder decodeObjectForKey:SHOP_PIC];
//        self.shop_price=[aDecoder decodeObjectForKey:SHOP_PRICE];
        
    }
    return self;
}
@end
