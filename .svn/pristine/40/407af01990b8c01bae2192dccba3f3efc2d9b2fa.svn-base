//
//  QueryCartModel.h
//  YunShangShiJi
//
//  Created by zgl on 16/8/10.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface QueryCartModel : BaseModel

@property (nonatomic, assign) NSInteger status;         //结果
@property (nonatomic, copy) NSString *message;          //结果信息
@property (nonatomic, assign) NSTimeInterval sys_time;  //系统时间
@property (nonatomic, copy) NSArray *shop_list;         //购物列表
@property (nonatomic, copy) NSArray *p_shop_list;       //特卖列表
@property (nonatomic, assign) NSTimeInterval s_deadline;//购物时间
@property (nonatomic, assign) NSTimeInterval p_deadline;//特卖时间

+ (void)getQueryCartWithSuccess:(void (^)(id data))success;//套餐

@end
