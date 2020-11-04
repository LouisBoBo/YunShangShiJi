//
//  MyWalletHeaderView.h
//  YunShangShiJi
//
//  Created by zgl on 16/6/25.
//  Copyright © 2016年 ios-1. All rights reserved.
//  我的钱包头部

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HeaderViewType) {
    HeaderViewTypeDefault = 0,  //默认
    HeaderViewTypeOpen = 1,     //开启余额翻倍
    HeaderViewTypeOpenEnd = 2,   //已经开启余额翻倍
    HeaderViewTypeDefault_NoTiXian = 3 //没有提现按钮
};

typedef NS_ENUM(NSInteger, HeaderViewBtnType) {
    HeaderViewBtnTypeShop = 0,   //开启余额翻倍
    HeaderViewBtnTypeWithdraw = 1, //提现
    HeaderViewBtnTypeShopping= 2 // 买买买
};

typedef void(^BtnBlock)(HeaderViewBtnType type);


@interface MyWalletHeaderView : UIView
@property (nonatomic, strong) UILabel *yueLabel;
@property (nonatomic, strong) UILabel *overLabel; //余额
@property (nonatomic, strong) UILabel *timeLabel; //倒计时
@property (nonatomic, strong) UILabel *timeLabel2;
@property (nonatomic, strong) UILabel *canWithCashLabel;

@property (nonatomic, copy) BtnBlock block; //按钮点击回调

/// 根据类型刷新视图
- (void)loadViewWithType:(HeaderViewType)type;


/**
 <#Description#>

 @param str 我的余额ø
 @param str2 冻结余额
 @param str3 提现额度
 @param str4 提现冻结
 */
- (void)loadDataWithStr:(NSString *)str str2:(NSString *)str2 str3:(NSString *)str3 str4:(NSString *)str4;

@end
