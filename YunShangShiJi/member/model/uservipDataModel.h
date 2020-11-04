//
//  uservipDataModel.h
//  YunShangShiJi
//
//  Created by hebo on 2019/5/27.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN
/**
 add_time: 1557481977000
 arrears_price: 0
 bonus: 0
 context: null
 count: 0
 end_time: 1557485577000
 num: 0
 v_code: "V190510v9TwUOlo"
 vip_balance: 0.2
 vip_code: "190510OrKBpNZW"
 vip_num: 0
 vip_price: 0.2
 vip_type: 6
 */
@interface uservipDataModel : BaseModel
@property (nonatomic , strong) NSNumber *add_time;
@property (nonatomic , strong) NSNumber *arrears_price;
@property (nonatomic , strong) NSNumber *bonus;
@property (nonatomic , strong) NSNumber *count;
@property (nonatomic , strong) NSNumber *end_time;
@property (nonatomic , strong) NSNumber *num;
@property (nonatomic , strong) NSNumber *vip_balance;
@property (nonatomic , strong) NSNumber *vip_num;
@property (nonatomic , strong) NSNumber *vip_price;
@property (nonatomic , strong) NSNumber *vip_type;
@property (nonatomic , copy) NSString *context;
@property (nonatomic , copy) NSString *substance;
@property (nonatomic , copy) NSString *vip_code;
@property (nonatomic , copy) NSString *v_code;
@end

NS_ASSUME_NONNULL_END
