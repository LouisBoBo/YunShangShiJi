//
//  TFCashDetailsViewController.h
//  YunShangShiJi
//
//  Created by 云商 on 15/7/13.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFBaseViewController.h"
#import "DrawCashModel.h"

@interface TFCashDetailsViewController : TFBaseViewController

@property (nonatomic, strong)DrawCashModel *model;

@property (nonatomic, strong)UIImageView *oneIv;
@property (nonatomic, strong)UIImageView *twoIv;
@property (nonatomic, strong)UIImageView *threeIv;

@property (nonatomic, strong)UIView *lineView1;
@property (nonatomic, strong)UIView *lineView2;

@property (nonatomic, strong)UILabel *isSuccessLabel;

@property (nonatomic, strong)UILabel *moneyLabel;
@property (nonatomic, strong)UILabel *cardLabel;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UILabel *statusLabel;

@end
