//
//  DPAddShopVC.h
//  YunShangShiJi
//
//  Created by zgl on 16/6/17.
//  Copyright © 2016年 ios-1. All rights reserved.
//  搭配购－加入购物车

#import <UIKit/UIKit.h>

@class CollocationDetailModel;

@interface DPAddShopVC : UIViewController

/**
 * 页面创建方法
 *
 * @param shopCodes    商品编号（多个用“，”隔开
 * @param pairedCode   联合编号（即collocation_code）
 * @param model        颜色尺码
 * @retrn 返回 DPAddShopVC 视图控制器
 */
- (instancetype)initWithShopCodes:(NSString *)shopCodes pairedCode:(NSString *)pairedCode detaiModel:(CollocationDetailModel *)model;
+ (instancetype)new __attribute__((unavailable("new 不可用,请调用initWithShopCodes:pairedCode:detaiModel:")));
- (instancetype)init __attribute__((unavailable("init 不可用,请调用initWithShopCodes:pairedCode:detaiModel:")));

@end
