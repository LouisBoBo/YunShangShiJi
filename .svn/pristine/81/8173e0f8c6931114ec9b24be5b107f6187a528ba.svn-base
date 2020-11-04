//
//  RejoinCartCell.h
//  YunShangShiJi
//
//  Created by yssj on 16/6/20.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopDetailModel.h"

@interface RejoinCartCell : UITableViewCell

@property (strong, nonatomic) UIButton *editeBtn;
@property (strong, nonatomic)  UIButton *deleteImg;
@property (strong, nonatomic)  UILabel *grayLabel;
@property (strong, nonatomic)  UILabel *changNumLabel;
@property (strong, nonatomic)  UILabel *shop_content;
@property (strong, nonatomic)  UIImageView *shop_headimage;
@property (strong, nonatomic)  UIImageView *grayImage;
@property (strong, nonatomic)  UILabel *shop_se_price;
@property (strong, nonatomic)  UILabel *shop_price;
@property (strong, nonatomic)  UILabel *shop_num;
@property (strong, nonatomic)  UILabel *shop_depreciate;
@property (strong, nonatomic)  UILabel *shop_color_size;
@property (strong, nonatomic)  UIButton *selectbtn;
@property (strong, nonatomic)  UILabel *line;

@property (strong, nonatomic)  UIView *bottomView;
@property (strong, nonatomic)  UILabel *bottomLabel;
@property (strong, nonatomic)  UIButton *bottomBtn;

@property (nonatomic, copy) dispatch_block_t RejoinBlock;//重新加入
@property (nonatomic, copy) dispatch_block_t DeleteBlock;//删除
//@property (nonatomic, copy) dispatch_block_t bottomBtnBlock;

-(void)refreshData:(ShopDetailModel*)model;


+ (NSMutableAttributedString *)getOneColorInLabel:(NSString *)allstring ColorString:(NSString *)string Color:(UIColor*)color fontSize:(float)size withOrigalFontSize:(float)OrigalSize;
@end
