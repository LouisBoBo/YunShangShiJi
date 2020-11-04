//
//  ShopCarCountModel.h
//  YunShangShiJi
//
//  Created by zgl on 16/6/22.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface ShopCarCountModel : BaseModel

@property (nonatomic, assign) NSInteger status;      //结果
@property (nonatomic, copy) NSString *message;       //结果信息
@property (nonatomic, assign) NSInteger cart_count;  //数量
@property (nonatomic, assign) long long p_deadline; //套餐过期时间
@property (nonatomic, assign) long long s_deadline; //商品过期时间
@property (nonatomic, assign) long long s_time;     //系统当前时间

+ (void)getShopCarCountWithSuccess:(void (^)(id data))success;

@end
