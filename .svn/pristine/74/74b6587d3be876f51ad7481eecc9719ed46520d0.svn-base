//
//  CartCell.h
//  YunShangShiJi
//
//  Created by yssj on 16/6/18.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopDetailModel.h"

@interface StepperView : UIView

@property(nonatomic) NSInteger value;          // 默认为0，范围在minimumValue/maximumValue之间
@property(nonatomic) NSInteger minimumValue;   // 默认为0，最大为maximumValue
@property(nonatomic) NSInteger maximumValue;   // 默认为100，最小为minimumValue
@property(nonatomic) NSInteger stepValue;      // 默认为1，最小大于0

@property(nonatomic, copy) void(^valueChangeBlock)(NSInteger value);

@end

@interface CartCell : UITableViewCell

@property (nonatomic, strong) StepperView *stepperView;//数量选择

@property (strong, nonatomic) UIButton *editeBtn;
@property (strong, nonatomic)  UIButton *deleteImg;
@property (strong, nonatomic)  UILabel *grayLabel;
@property (strong, nonatomic)  UIImageView *grayImage;
@property (strong, nonatomic)  UILabel *changNumLabel;
@property (strong, nonatomic)  UILabel *shop_content;
@property (strong, nonatomic)  UIImageView *shop_headimage;
@property (strong, nonatomic)  UILabel *shop_se_price;
@property (strong, nonatomic)  UILabel *shop_price;
@property (strong, nonatomic)  UILabel *shop_num;
@property (strong, nonatomic)  UILabel *shop_depreciate;
@property (strong, nonatomic)  UILabel *shop_color_size;
@property (strong, nonatomic)  UIButton *selectbtn;
@property (strong, nonatomic)  UIButton *minusBtn;
@property (strong, nonatomic)  UIButton *plusBtn;
@property (strong, nonatomic)  UILabel *line;

@property (strong, nonatomic)  UITextField *numTextField;

@property (strong, nonatomic)  UIView *bottomView;
@property (strong, nonatomic)  UILabel *bottomLabel;
@property (strong, nonatomic)  UILabel *bottomMoney;

@property (nonatomic, copy) dispatch_block_t deleteBlock;
@property (nonatomic, copy) dispatch_block_t editeBlock;
@property (nonatomic, copy) dispatch_block_t btnSelectBlock;
@property (nonatomic, copy) dispatch_block_t reduceBlock;
@property (nonatomic, copy) dispatch_block_t addBlock;

@property (nonatomic, copy) void(^numberBlock)(NSInteger number);//数量


-(void)refreshData:(ShopDetailModel*)model;

@end


