//
//  ShopDetailViewModel.m
//  YunShangShiJi
//
//  Created by hebo on 2019/6/3.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import "ShopDetailViewModel.h"

@implementation ShopDetailViewModel
- (CGFloat)get_discount_price:(CGFloat)beforePrice DiscountMoney:(CGFloat)money MaxViptype:(NSString*)viptype Shop_deduction:(CGFloat)shop_deduction;
{
    CGFloat afterPrece = beforePrice;
    if(shop_deduction >0 && shop_deduction*afterPrece <= money)
    {
        if(viptype.integerValue == 6)
        {
            afterPrece = afterPrece*(1-shop_deduction-0.05);
        }else{
            afterPrece = afterPrece*(1-shop_deduction);
        }
    }else{

        if(viptype.integerValue == 6)
        {
            afterPrece = (afterPrece*(1-0.05) - money) >0 ? (afterPrece*(1-0.05) - money) :0.0;
        }else{
            afterPrece = (afterPrece - money) >0 ? (afterPrece - money) :0.0;
        }
    }
    
    return afterPrece;
}

+ (void)addUserVipOrderSuccess:(void(^)(id))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"userVipCard/userIsVip?token=%@&version=%@",token,VERSION];
    [self getDataResponsePath:path success:success];
}

@end
