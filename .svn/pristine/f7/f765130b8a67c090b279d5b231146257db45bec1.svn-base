//
//  CartNoEditCollectionViewCell.h
//  FJWaterfallFlow
//
//  Created by ios-1 on 2017/1/16.
//  Copyright © 2017年 fujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopDetailModel.h"
@interface CartNoEditCollectionViewCell : UICollectionViewCell
@property (strong , nonatomic) ShopDetailModel *shopdetailModel;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *colorAndSize;
@property (weak, nonatomic) IBOutlet UILabel *salePrice;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *shopNumber;
@property (strong, nonatomic) IBOutlet UILabel *makelab;
@property (strong, nonatomic) IBOutlet UILabel *linelab;
@property (strong, nonatomic) IBOutlet UILabel *line;
@property (weak, nonatomic) IBOutlet UILabel *CashbackLab;
//编辑
@property (weak, nonatomic) IBOutlet UIView *editView;
@property (weak, nonatomic) IBOutlet UIButton *reduceBtn;
@property (strong, nonatomic) IBOutlet UILabel *numberLab;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UILabel *editColorAndSize;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleateBtn;

@property (strong , nonatomic) void (^selectClick)();              //勾选商品
@property (strong , nonatomic) void (^addClick)();                 //加数量
@property (strong , nonatomic) void (^reduiceClick)();             //减数量
@property (strong , nonatomic) void (^delateClick)();              //删除商品
@property (strong , nonatomic) void (^changeClick)();              //更改商品

- (void)refreshData:(ShopDetailModel*)model;
@end
