//
//  ShopListPackage.h
//  YunShangShiJi
//
//  Created by 云商 on 16/5/4.
//  Copyright © 2016年 ios-1. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "TFTableViewBaseCell.h"
#import "PListModel.h"
@interface ShopListPackage : TFTableViewBaseCell
@property (weak, nonatomic) IBOutlet UILabel *packageNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *packageImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *packageImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *packageImageView3;

@property (weak, nonatomic) IBOutlet UIImageView *soldOutImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *soldOutImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *soldOutImageView3;

@property (weak, nonatomic) IBOutlet UIImageView *addImageView2;

@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel1;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel2;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel3;

@property (weak, nonatomic) IBOutlet UILabel *packagePriceLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *H_postagePrice;
@property (weak, nonatomic) IBOutlet UILabel *packageOriginalPariceLabel;
@property (weak, nonatomic) IBOutlet UIView *shopNameView3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *H_shopBackground;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *S_price;

@property (weak, nonatomic) IBOutlet UILabel *postagePriceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *H_shopHeadLine;

@property (weak, nonatomic) IBOutlet UILabel *personLabel;

@property (weak, nonatomic) IBOutlet UIButton *goShopBtn;

@property (weak, nonatomic) IBOutlet UILabel *shopNumberLabel;
@property (weak, nonatomic) IBOutlet UIView *shopBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *shopBeforeView;
@property (weak, nonatomic) IBOutlet UIView *shopSpaceView;
@property (weak, nonatomic) IBOutlet UIView *shopHeadLine;

@property (weak, nonatomic) IBOutlet UIView *shopPriceLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *W_postagePrice;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *W_shopBefore;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *W_shopBackground;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *H_goShopBtn;

@property (nonatomic, assign) BOOL isStock;
@property (nonatomic, strong) PListModel *myModel;
@property (nonatomic, copy)void (^goShopDetailBlock)();
- (void)receiveDataModel:(PListModel *)model;

@end
