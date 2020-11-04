//
//  SalePurchasePListCell.h
//  YunShangShiJi
//
//  Created by 云商 on 15/12/2.
//  Copyright © 2015年 ios-1. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "TFTableViewBaseCell.h"
#import "SalePListModel.h"

@interface SalePurchasePListCell : TFTableViewBaseCell

@property (nonatomic, copy)NSString *type;

@property (weak, nonatomic) IBOutlet UIView *progressView;
@property (weak, nonatomic) IBOutlet UIView *foreView;
@property (weak, nonatomic) IBOutlet UILabel *foreTitleLabel;


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *W_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *postLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *W_foreView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *W_progressView;
- (void)receiveDataModel:(SalePListModel *)model;
@end
