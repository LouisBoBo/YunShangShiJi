//
//  GoldCouponModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 16/10/9.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "BaseModel.h"
#import "GoldcpModel.h"
#import "GoldModel.h"
@interface GoldCouponModel : BaseModel

@property (nonatomic, assign) NSInteger status;//状态
@property (nonatomic, copy) NSString *message;//提示

///************************金币金券**********************/
//@property (nonatomic , assign)long long end_date;
//@property (nonatomic , assign)NSInteger id;
//@property (nonatomic , assign)BOOL is_open;
//@property (nonatomic , assign)long long c_last_time;
//@property (nonatomic , assign)CGFloat c_price;
//@property (nonatomic , assign)NSInteger is_use;
//@property (nonatomic , assign)NSInteger c_id;

@property (nonatomic , strong)GoldModel *twofoldnessGold;
@property (nonatomic , strong)GoldcpModel *CpGold;

+(void)getGoldCoupons:(NSString*)str success:(void(^)(id data))success;

@end
