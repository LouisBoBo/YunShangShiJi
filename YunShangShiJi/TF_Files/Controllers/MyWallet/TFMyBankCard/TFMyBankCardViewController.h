//
//  TFAddBankCardViewController.h
//  YunShangShiJi
//
//  Created by 云商 on 15/7/8.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFTableViewBaseViewController.h"
#import "TFWithdrawCashViewController.h"

@interface TFMyBankCardViewController : TFTableViewBaseViewController

@property (nonatomic, assign)BOOL isCash; //是否从提现页面过来
@property (nonatomic, assign)double money;
@property (nonatomic, copy) NSString *cardID;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign)TYPE_STATE type;

- (void)httpGetMyCard;

@end
