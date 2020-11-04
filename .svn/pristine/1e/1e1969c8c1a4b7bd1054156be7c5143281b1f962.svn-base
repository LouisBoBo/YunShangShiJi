//
//  InvalidCollectionViewCell.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/1/17.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopDetailModel.h"
@interface InvalidCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UILabel *shopName;
@property (strong, nonatomic) IBOutlet UILabel *colorandsize;
@property (strong, nonatomic) IBOutlet UILabel *saleprice;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UIButton *closeBtn;
@property (strong, nonatomic) IBOutlet UIImageView *overheaderImage;
@property (strong, nonatomic) IBOutlet UILabel *line;

@property (strong , nonatomic) void (^delateClick)();              //删除商品
- (void)refreshData:(ShopDetailModel*)model;
@end
