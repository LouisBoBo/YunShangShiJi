//
//  SalePurchaseShopListCell.h
//  YunShangShiJi
//
//  Created by 云商 on 15/12/2.
//  Copyright © 2015年 ios-1. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "TFTableViewBaseCell.h"
#import "SaleShopListModel.h"
#import "SalePListModel.h"

@interface SalePurchaseShopListCell : TFTableViewBaseCell

@property (nonatomic, copy)NSString *type;
@property (nonatomic, assign)BOOL isPackage;

@property (weak, nonatomic) IBOutlet UIImageView        *headImageView;
@property (weak, nonatomic) IBOutlet UILabel            *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel            *currPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel            *oldPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel            *personLabel;
@property (weak, nonatomic) IBOutlet UILabel            *packageLabel;
@property (weak, nonatomic) IBOutlet UIView             *progressView;
@property (weak, nonatomic) IBOutlet UIView             *foreView;
@property (weak, nonatomic) IBOutlet UIImageView        *defaultImageView;
@property (weak, nonatomic) IBOutlet UILabel            *foreTitleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *W_foreView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *H_progressView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *W_package;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *WH_defaultImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *H_titleLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerY_defaultImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *P_packageLabel;

- (void)receiveDataModel:(SaleShopListModel *)model;

- (void)receiveDataModel:(SaleShopListModel *)sModel withPListModel:(SalePListModel *)pModel;


@end


