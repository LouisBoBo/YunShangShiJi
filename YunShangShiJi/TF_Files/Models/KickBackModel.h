//
//  KickBackModel.h
//  YunShangShiJi
//
//  Created by 云商 on 15/7/13.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 回佣记录,若为空null,则是没有记录
 type:分类 (1一级回佣2二级回佣3供应商应得金额,4h5优惠券.5,三级回佣6四级回佣,7会员卡钱.8任务翻倍9上级奖励冻结10免付返现)
 money: 返佣金额
 add_date :添加时间
 is_free :回佣是否解冻0否1是
 status:0正常,1该商品已退款2退款中3还未收到货4为无效
 is_buy : 当type=10 的时候此值才有效. 0
 type: 回佣分类1一级回佣2二级回佣3供应商应得金额,4h5优惠券.5,三级回佣6四级回佣,7会员卡钱.8任务翻倍9上级奖励冻结10免付返现
 */
@interface KickBackModel : NSObject

@property (nonatomic, copy)NSString *order_code;
@property (nonatomic, strong)NSNumber *add_date;
@property (nonatomic, strong)NSNumber *is_free; //0-冻结 1-未冻结
@property (nonatomic, strong)NSNumber *money;
@property (nonatomic, strong)NSNumber *status;  //1-该商品已经退款2-退款中3-还未收到货
@property (nonatomic, strong)NSString *user_name;
@property (nonatomic, strong)NSNumber *order_price;
@property (nonatomic, strong)NSNumber *NICKNAME;
@property (nonatomic, strong)NSNumber *type;
@property (nonatomic, strong)NSNumber *is_buy;
@end
