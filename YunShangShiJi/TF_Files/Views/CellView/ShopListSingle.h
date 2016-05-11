//
//  ShopListSingle.h
//  YunShangShiJi
//
//  Created by 云商 on 16/5/3.
//  Copyright © 2016年 ios-1. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "TFTableViewBaseCell.h"
#import "PListModel.h"

@interface ShopListSingle : TFTableViewBaseCell
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
@property (weak, nonatomic) IBOutlet UIImageView *soldOutImageView;

@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopOriginalPariceLabel;
@property (weak, nonatomic) IBOutlet UILabel *postagePriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *goShopBtn;

@property (weak, nonatomic) IBOutlet UILabel *shopNumberLabel;

@property (weak, nonatomic) IBOutlet UIView *shopBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *shopBeforeView;

@property (nonatomic, assign) BOOL isStock;
@property (weak, nonatomic) IBOutlet UILabel *personLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *W_postagePrice;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *W_shopBefore;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *W_shopBackground;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *H_shopBackground;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *H_goShopBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *S_shopPrice;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *S_goShopBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *H_postagePrice;
@property (nonatomic, strong) PListModel *myModel;
@property (nonatomic, copy)void (^goShopDetailBlock)();
@property (weak, nonatomic) IBOutlet UIView *shopHeadLine;

- (void)receiveDataModel:(PListModel *)model;

@end
