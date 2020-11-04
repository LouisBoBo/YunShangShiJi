//
//  OneYuanModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 2018/3/18.
//  Copyright © 2018年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface OneYuanDataModel : BaseModel
@property (nonatomic, assign) NSInteger app_status;
@property (nonatomic, assign) CGFloat app_value;
@property (nonatomic, assign) CGFloat app_every;
@property (nonatomic, assign) CGFloat app_zero;
@property (nonatomic, assign) CGFloat order_price;
@end

@interface OneYuanModel : BaseModel
@property (nonatomic, assign) NSInteger status;   //结果
@property (nonatomic, copy) NSString *message;    //结果信息
@property (nonatomic, assign) CGFloat order_price;//累计返回余额
@property (nonatomic, assign) CGFloat one_not_use_price;//可用余额
@property (nonatomic, assign) CGFloat price;      //优惠券价格
@property (nonatomic, assign) CGFloat cond;       //优惠券满多少可用
@property (nonatomic, assign) NSInteger count;    //订单数量
@property (nonatomic, copy)   NSString *shop_deduction; //抵扣率
@property (nonatomic, assign) BOOL isFail;
@property (nonatomic, assign) BOOL is_open;
@property (nonatomic, strong) OneYuanDataModel *data;

//获取用户是否是一元购
+ (void)GetOneYuanDataSuccess:(void(^)(id data))success;

//获取一元购返回总额
+ (void)GetOneYuanCountSuccess:(void (^)(id data))success;

//获取新用户优惠券
+ (void)GetCouponDataSuccess:(void(^)(id data))success;

//获取是否有交易记录
+ (void)getNewUserOrderSucceww:(void(^)(id data))success;

//1元购抽奖结束调用
+ (void)GetOneYuanFinishOrder_code:(NSString*)order_code Success:(void (^)(id data))success;

@end
