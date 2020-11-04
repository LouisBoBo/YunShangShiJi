//
//  ChangShopTableViewCell.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/1/19.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFStepperView.h"
@class DPShopModel;
@interface ChangShopTableViewCell : UITableViewCell
@property (nonatomic, copy) void(^colorSizeBlock)(NSInteger cidx, NSInteger sidx);//颜色与尺码选择（cidx：颜色，sidx：尺码）
@property (nonatomic, copy) void(^colorSizeOtherBlock)(NSInteger cidx, NSInteger sidx,NSInteger oidx);//颜色与尺码选择（cidx：颜色，sidx：尺码 ,oidx:其它）
@property (nonatomic, copy) void(^selectBlock)(BOOL select);//是否选中
@property (nonatomic, copy) void(^numberBlock)(NSInteger number);//数量
@property (nonatomic, strong) void(^dismissModalView)();      //关闭
@property (nonatomic, strong) void(^okchange)();              //确定

@property (nonatomic, strong) UIImageView *imgView;           //图片
@property (nonatomic, strong) UIButton *selectBtn;            //选择按钮
@property (nonatomic, strong) UILabel *titleLabel;            //商品名称
@property (nonatomic, strong) UILabel *priceLabel;            //出售价格
@property (nonatomic, strong) UILabel *originalLabel;         //原价
@property (nonatomic, strong) YFStepperView *stepperView;     //数量选择
@property (nonatomic, strong) UIView *colorView;              //颜色
@property (nonatomic, strong) UIView *sizeView;               //尺码
@property (nonatomic, strong) UIView *otherView;              //其它
@property (nonatomic, strong) UILabel *nameLabel;             //数量
@property (nonatomic, assign) NSInteger colorIndex;           //选中颜色
@property (nonatomic, assign) NSInteger sizeIndex;            //选中尺码
@property (nonatomic, assign) NSInteger otherIndex;           //选中其它
@property (nonatomic, assign) NSUInteger sTag;                //尺码tag开始值
@property (nonatomic, assign) NSUInteger oTag;                //其它开始值
@property (nonatomic, copy) NSArray *colors;                  //颜色相关信息数组
@property (nonatomic, strong) UIButton *okbtn;                //确认按钮
@property (nonatomic, strong) UILabel *stocklable;            //库存
@property (nonatomic, strong) DPShopModel *dpModel;
@property (nonatomic, assign) BOOL isSelect;                  //是否点击按钮
@property (nonatomic, assign) BOOL isNewbie;                  //是否新用户
@property (nonatomic, assign) BOOL isSpecialShop;             //是否特价
/// 更新数据
- (void)receiveDataModel:(DPShopModel *)model MiniShare:(BOOL)shareSuccess;
- (void)receiveSpecialDataModel:(DPShopModel *)model MiniShare:(BOOL)shareSuccess;
///cell高度
+ (CGFloat)cellHeightWithModel:(DPShopModel *)model;

@end
