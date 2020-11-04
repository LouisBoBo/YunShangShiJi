//
//  SpecialShopModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 2016/12/5.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "SpecialShopModel.h"

@implementation SpecialShopModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.shop_code forKey:@"shop_code"];
    [aCoder encodeObject:self.shop_name forKey:@"shop_name"];
    [aCoder encodeObject:self.shop_price forKey:@"shop_price"];
    [aCoder encodeObject:self.shop_se_price forKey:@"shop_se_price"];
    [aCoder encodeObject:self.id forKey:@"id"];
    [aCoder encodeObject:self.kickback forKey:@"kickback"];
    [aCoder encodeObject:self.supp_label forKey:@"supp_label"];
    [aCoder encodeObject:self.def_pic forKey:@"def_pic"];
    [aCoder encodeObject:self.supp_label_id forKey:@"supp_label_id"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.shop_code = [aDecoder decodeObjectForKey:@"shop_code"];
        self.shop_name = [aDecoder decodeObjectForKey:@"shop_name"];
        self.shop_price = [aDecoder decodeObjectForKey:@"shop_price"];
        self.shop_se_price = [aDecoder decodeObjectForKey:@"shop_se_price"];
        self.id = [aDecoder decodeObjectForKey:@"id"];
        self.def_pic = [aDecoder decodeObjectForKey:@"def_pic"];
        self.kickback = [aDecoder decodeObjectForKey:@"kickback"];
        self.supp_label = [aDecoder decodeObjectForKey:@"supp_label"];
        self.supp_label_id = [aDecoder decodeObjectForKey:@"supp_label_id"];
    }
    
    return self;
}

@end
