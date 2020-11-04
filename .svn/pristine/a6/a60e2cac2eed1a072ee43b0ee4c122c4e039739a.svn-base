//
//  TradAndDrawalCell.h
//  YunShangShiJi
//
//  Created by 云商 on 15/7/10.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFTableViewBaseCell.h"
#import "AccountDetailModel.h"

#import "DrawCashModel.h"
@interface TradAndDrawalCell : TFTableViewBaseCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (nonatomic, assign)int index;

- (void)receiveDataModel:(AccountDetailModel *)model;
- (void)receiveDataCashModel:(DrawCashModel *)model;

- (void)loadTaskAccountDetailModel:(DrawCashModel *)model isLeft:(BOOL)isLeft;

@end
