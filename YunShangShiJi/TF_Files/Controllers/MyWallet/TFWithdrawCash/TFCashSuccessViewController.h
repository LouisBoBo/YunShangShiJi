//
//  TFCashSuccessViewController.h
//  YunShangShiJi
//
//  Created by 云商 on 15/7/15.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFBaseViewController.h"
#import "TFWithdrawCashViewController.h"

typedef NS_ENUM(NSInteger, VCType) {
    VCType_Cash = 0,
    VCType_BindPhoneSuccess,
    VCType_ChangeBindPhone
};


typedef NS_ENUM(NSInteger, CashType) {
    CashType_Success = 0, // 成功
    CashType_Adopt, // 部分
    CashType_Fail // 失败
};

@interface TFCashSuccessViewController : TFBaseViewController

@property (nonatomic, assign) double money;
@property (nonatomic, assign) double unAdoptMoney;

@property (nonatomic, copy)NSString *headTitle;
@property (nonatomic, assign)VCType index;
@property (nonatomic, copy)NSString *text;
@property (nonatomic, copy)NSString *btnTitle;
@property (nonatomic, assign)CashType cashType;
@property (nonatomic, assign)TYPE_STATE type;

@end
