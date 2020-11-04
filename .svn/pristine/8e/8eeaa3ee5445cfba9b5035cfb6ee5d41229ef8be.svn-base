//
//  OrderTableViewCell.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/7/10.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopDetailModel.h"
#import "OrderDetailModel.h"
@interface OrderTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *groupBuyImg;

/**
 问好按钮
 */
@property (nonatomic, strong) UIButton *questionBtn;
@property (nonatomic, copy) dispatch_block_t questionBtnBlock;

/**
 余额抵扣金额
 */
@property (nonatomic, strong) UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UIImageView *headimage;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *color_size;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *statue;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *changeNum;
@property (weak, nonatomic) IBOutlet UILabel *zeroLabel;
@property (weak, nonatomic) IBOutlet UIButton *interveneBtn;//平台介入

@property (weak, nonatomic) IBOutlet UIButton *minusBtn;
@property (weak, nonatomic) IBOutlet UIButton *plusBtn;
@property (weak, nonatomic) IBOutlet UILabel *line;

@property (weak, nonatomic) IBOutlet UILabel *shop_oldPrice;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;

-(void)refreshIndianaData:(ShopDetailModel*)model;

-(void)refreshZeroData:(ShopDetailModel*)model;
-(void)refreshData:(ShopDetailModel*)model;
-(void)refreshData1:(ShopDetailModel*)model;
-(void)refreshData2:(ShopDetailModel*)model;
-(void)refreshData3:(ShopDetailModel *)model;

-(void)refreshAfterSaleData:(ShopDetailModel*)model;

@end
