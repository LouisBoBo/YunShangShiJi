//
//  YFTagButton.h
//  YunShangShiJi
//
//  Created by zgl on 16/7/11.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFTagsView.h"

@interface YFTagButton : UIControl

@property (nonatomic, assign) BOOL isHighlight;     //是否高亮图标
// 创建方法
- (instancetype)initWithType:(YFTagsViewType)type maxWidth:(CGFloat)width;
+ (instancetype)buttonWithType:(YFTagsViewType)type maxWidth:(CGFloat)width;

/*
 @brief 赋值
 @param title:   标题
 @param price:   价格
 @param origin:  坐标（动画小圆点的中心）
 @param isImg:   是否显示购物车图标
 @param isImg:   是否价格标签
 @param type:    类型
 */
- (void)setTitle:(NSString *)title price:(NSString *)price origin:(CGPoint)origin isImg:(BOOL)isImg ispic:(BOOL)ispic type:(YFTagsViewType)type;

@end
