//
//  SharOrderVC.h
//  YunShangShiJi
//
//  Created by zgl on 16/6/1.
//  Copyright © 2016年 ios-1. All rights reserved.
//  晒单详情

#import <UIKit/UIKit.h>

/// 点赞成功通知
#define AddLikeNotification @"AddLikeNotification"

@interface SharOrderVC : UIViewController

@property (nonatomic, copy) NSString *shopCode; // 商品编号

/// 请用此方法初始化或者直接给_shopCode赋值（必须传入商品编号）
- (instancetype)initWithShopCode:(NSString *)shopCode;

@end
