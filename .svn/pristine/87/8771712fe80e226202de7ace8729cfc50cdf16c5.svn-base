//
//  GoldCouponsManager.h
//  YunShangShiJi
//
//  Created by ios-1 on 16/10/9.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoldCouponsManager : NSObject
/************************金币**********************/
@property (nonatomic , assign)long long gold_end_date;
@property (nonatomic , assign)BOOL gold_is_open;
@property (nonatomic , assign)NSInteger gold_id;

/************************金券**********************/
/*
is_open=1,(0否1是 ,只有=1时下面的参数才有值)
end_date=此次升级的过期时间,
c_last_time=被升级的优惠券的过期时间,
c_price=升级的优惠券面值,
c_id 升级的优惠券id
is_use 升级的优惠券是否使用 (0否1是)
*/
 
@property (nonatomic , assign)long long goldcp_end_date;
@property (nonatomic , assign)BOOL is_open;
@property (nonatomic , assign)long long c_last_time;
@property (nonatomic , assign)CGFloat c_price;
@property (nonatomic , assign)NSInteger is_use;
@property (nonatomic , assign)NSInteger c_id;

+ (instancetype)goldcpManager;
@end
