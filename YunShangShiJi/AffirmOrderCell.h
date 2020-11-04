//
//  AffirmOrderCell.h
//  YunShangShiJi
//
//  Created by yssj on 16/6/27.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopDetailModel.h"

@interface AffirmOrderCell : UITableViewCell

@property (strong, nonatomic)  UIImageView *headimage;
@property (strong, nonatomic)  UILabel *title;
@property (strong, nonatomic)  UILabel *color_size;
@property (strong, nonatomic)  UILabel *price;
@property (strong, nonatomic)  UILabel *brand;
@property (strong, nonatomic)  UILabel *returnMoney; //0元购返现

//@property (weak, nonatomic) IBOutlet UILabel *zeroTypeLabel;

@property (strong, nonatomic)  UILabel *number;
@property (strong, nonatomic)  UILabel *changeNum;
@property (strong, nonatomic)  UITextField *changeNumTextField;
@property (strong, nonatomic)  UILabel *payStatusLabel;

@property (strong, nonatomic)  UIButton *minusBtn;
@property (strong, nonatomic)  UIButton *plusBtn;
@property (strong, nonatomic)  UILabel *line;

@property (strong, nonatomic)  UILabel *shop_oldPrice;
@property (strong,nonatomic)ShopDetailModel* shop_model;

- (NSString *)exchangeTextWihtString:(NSString *)text;

- (void)loadDataModel:(ShopDetailModel *)model;

@end
