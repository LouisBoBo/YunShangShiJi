//
//  LoginDeviceCell.h
//  YunShangShiJi
//
//  Created by 云商 on 15/7/8.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFTableViewBaseCell.h"
#import "LoginDeviceModel.h"

@interface LoginDeviceCell : TFTableViewBaseCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *visityLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_headImg_w;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_headImg_h;

- (void)receiveDataModel:(LoginDeviceModel *)model;

@end
