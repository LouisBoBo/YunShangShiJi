//
//  YFAddShopBottomView.h
//  YunShangShiJi
//
//  Created by zgl on 16/6/20.
//  Copyright © 2016年 ios-1. All rights reserved.
//  搭配购底部

#import <UIKit/UIKit.h>
#import "YFShopCarView.h"

typedef NS_ENUM(NSInteger, YFAddAddShopBtnType) {
    YFAddAddShopBtnBuynow = 0, //立即购买
    YFAddAddShopBtnAllSelect = 1, //全选
    YFAddAddShopBtnShop = 2, //购物车
    YFAddAddShopBtnAdd = 3 //加入购物车
};

@protocol YFAddShopBottomViewDelegate <NSObject>
/// 按钮点击
- (void)buttonClickType:(YFAddAddShopBtnType)type;
@end


@interface YFAddShopBottomView : UIView

@property (nonatomic, strong) YFShopCarView *carBtn; //购物车
@property (nonatomic, strong) UIButton *addBtn;      //加入购物车
@property (nonatomic, strong) UIButton *selectBtn;   //全选
@property (nonatomic, strong) UILabel *centerLabel;  //选中数量价格相关信息
@property (nonatomic, assign) BOOL isAllSelect;

@property (nonatomic, weak) id<YFAddShopBottomViewDelegate> delegate;

/// 是否隐藏提示
- (void)setTopIsHidden:(BOOL)hidden;

@end
