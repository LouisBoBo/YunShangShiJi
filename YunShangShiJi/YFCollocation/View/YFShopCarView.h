//
//  YFShopCarView.h
//  YunShangShiJi
//
//  Created by zgl on 16/6/20.
//  Copyright © 2016年 ios-1. All rights reserved.
//  购物车

#import <UIKit/UIKit.h>

@interface YFShopCarView : UIView

@property (nonatomic, assign) NSInteger markNumber;             //购物车数量(0隐藏角标)
@property (nonatomic, copy) NSString *time;                     //倒计时时间（“”、nil隐藏时间）
@property (nonatomic, copy) void(^btnClick)(YFShopCarView *);   //点击回调
@property (nonatomic, assign) BOOL isAnimation;                 //是否正在动画

/// 加入购物车动画
- (void)animationCar;

@end
