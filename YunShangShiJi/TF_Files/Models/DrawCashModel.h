//
//  DrawCashModel.h
//  YunShangShiJi
//
//  Created by 云商 on 15/7/16.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrawCashModel : NSObject

@property (nonatomic, copy)NSString *business_code; //业务参考号
@property (nonatomic, strong)NSNumber *add_date; //提现日期
@property (nonatomic, strong)NSNumber *money; //金额
@property (nonatomic, copy)NSString *collect_bank_name; //银行名称
@property (nonatomic, copy)NSString *collect_bank_code; //收款账号
@property (nonatomic, strong)NSNumber *check; //0待审核1通过2不通过3成功到账  
@property (nonatomic, copy)NSString *transfer_error;


/**
 "add_time": 添加时间,
 "cfrom": 来自 0冻结衣豆抽 1疯狂星期一,2分享给上级3普通衣豆抽,
 "id": 1,
 "is_deduct_money":是否已经扣除金额 0否1是,
 "money":金额,
 "order_code": "123456798",
 "status": 0(未绑定微信)等待提现 1已经提现 2提现失败等待重提3(余额不足)等待提现,
 "user_id": 用户id
 */
@property (nonatomic, strong)NSNumber *add_time;    //发生时间
@property (nonatomic, strong) NSString *cfrom;
@property (nonatomic, strong)NSNumber *ID;          //id
@property (nonatomic, strong)NSNumber *user_id;
@property (nonatomic, strong)NSNumber *is_deduct_money;
@property (nonatomic, strong) NSString *order_code;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSString *t_type;//1提现 2退款
@end
