//
//  vipDataModel.h
//  YunShangShiJi
//
//  Created by hebo on 2019/5/27.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 cashabletime: 1
 free_count: 1
 free_num: 1
 head_url: "vip/vip_head/diamondzs.png"
 is_use: 1
 url: "vip/vip_type/diamondsCard.png"
 vip_equity: "1,2"
 vip_name: "钻石卡"
 vip_price: 0.1
 vip_type: 4
 vipcard_id: 4
 weight: 4
 */
@interface vipDataModel : BaseModel
@property (nonatomic , strong) NSNumber * cashabletime;
@property (nonatomic , strong) NSNumber * free_count;
@property (nonatomic , strong) NSNumber * free_num;
@property (nonatomic , strong) NSNumber * is_use;
@property (nonatomic , strong) NSNumber * vip_price;
@property (nonatomic , strong) NSNumber * vip_type;
@property (nonatomic , strong) NSNumber * vipcard_id;
@property (nonatomic , strong) NSNumber * weight;
@property (nonatomic , strong) NSNumber * arrears_price;
@property (nonatomic , strong) NSNumber * count;
@property (nonatomic , strong) NSNumber * num;
@property (nonatomic , strong) NSNumber * vip_balance;
@property (nonatomic , strong) NSNumber * vip_num;
@property (nonatomic , strong) NSNumber * punch_days;
@property (nonatomic , strong) NSNumber * return_money;
@property (nonatomic , strong) NSNumber * price_section;
@property (nonatomic , strong) NSNumber * original_vip_price;
@property (nonatomic , strong) NSNumber * discount;
@property (nonatomic , copy) NSArray * markrule;
@property (nonatomic , copy) NSString * ruledata;
@property (nonatomic , copy) NSString * context;
@property (nonatomic , copy) NSString * substance;
@property (nonatomic , copy) NSString * url;
@property (nonatomic , copy) NSString * vip_equity;
@property (nonatomic , copy) NSString * vip_name;
@property (nonatomic , copy) NSString * vip_code;
@property (nonatomic , copy) NSString * head_url;
@property (nonatomic , copy) NSArray * equity;
@property (nonatomic , copy) NSArray * equityYet;
@end

NS_ASSUME_NONNULL_END
