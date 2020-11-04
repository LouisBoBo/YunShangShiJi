//
//  TFWithdrawCashViewController.h
//  YunShangShiJi
//
//  Created by 云商 on 15/7/14.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFBaseViewController.h"
#import "FinishTaskPopview.h"
typedef enum : NSUInteger {
    TFMyWallet = 0,         //我的钱包
    TFIncomeStatistics = 1, //收入
    Withdrawals = 2,        //明细
} TYPE_STATE;

typedef NS_ENUM(NSInteger, WXCheckPopType)
{
    WXCheckPopTypeSuccess = 100,
    WXCheckPopTypeFailure = 101,
    WXCheckPopTypeSuccessFailure = 102
};

@interface TFWithdrawCashViewController : TFBaseViewController

@property (nonatomic, copy) void(^bindNameAndIdenfBlock)(NSInteger grade);
@property (nonatomic, assign) WXCheckPopType wxCheckPopType; // 微信提现结果
@property (nonatomic, assign) double WXwithDrawMoney; // 微信成功提现的金额
@property (nonatomic, strong) FinishTaskPopview *bonusview;
@property (nonatomic, assign)TYPE_STATE type;
@property (nonatomic, assign)int flag;
@property (nonatomic, assign) BOOL isLingHongBao;
@property (nonatomic, assign) CGFloat coupon;
@end

