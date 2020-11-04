//
//  AccountDetailModel.h
//  YunShangShiJi
//
//  Created by 云商 on 15/7/10.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountDetailModel : NSObject

@property (nonatomic, strong)NSNumber *add_time;    //发生时间
@property (nonatomic, copy)NSString *deal_no;       //交易号
@property (nonatomic, strong)NSNumber *ID;          //id
@property (nonatomic, strong)NSNumber *money;       //金额
@property (nonatomic, copy)NSString *name;          //名称，如果是购物，则是订单的名称
@property (nonatomic, copy)NSString *order_code;    //订单和提现
@property (nonatomic, strong)NSNumber *pay_type;    //0 我的钱包,1 支付宝,2 微信支付
@property (nonatomic, copy)NSString *pay_user;      //买家支付账号 (银行卡号)
@property (nonatomic, strong)NSNumber *s_user_id;   //接受方id
@property (nonatomic, copy)NSString *status;        //1未到账2已到账
@property (nonatomic, copy)NSString *type;          //1购物2转账3提现4充值5回佣
@property (nonatomic, strong)NSNumber *user_id;     //发起方id

@end
