//
//  UIView+Animation.h
//  YunShangShiJi
//
//  Created by zgl on 16/7/5.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animation)

/// 抖动动画
- (void)shakeStatus:(BOOL)enabled;

/**
 * 搭配界面 小红点动画
 *
 * @param enabled 动画开始与结束，YES开始、NO结束动画
 *
 * @param layers 波纹小圆
 */
- (void)scaleStatus:(BOOL)enabled layers:(NSArray<CALayer *> *)layers;

/**
 * 抛物线动画
 *
 * @param enabled 动画开始与结束，YES开始、NO结束动画
 *
 * @param fromPoint 出发点
 *
 * @param toPoint 结束点
 *
 * @param controlPoint 控制点（控制抛物线形状）
 *
 * @param duration 动画时间
 *
 * @param layer 做动画的图层（如果为nil，则为self.layer）
 */
- (void)parabolaStatus:(BOOL)enable
             fromPoint:(CGPoint)fromPoint
               toPoint:(CGPoint)toPoint
          controlPoint:(CGPoint)controlPoint
              duration:(CFTimeInterval)duration
                 layer:(CALayer *)layer;

/**
 * 放大
 *
 * @param enabled 动画开始与结束，YES开始、NO结束动画
 *
 * @param time    时长
 */
- (void)scaleStatus:(BOOL)enabled time:(CGFloat)time;

/**
 *透明动画
 *
 *@param enabled 开始／关闭动画
 *@param time    一个循环时长
 *@param fromValue    开始透明度
 *@param toValue      结束透明度
 *
 */
- (void)opacityStatus:(BOOL)enabled time:(CGFloat)time fromValue:(CGFloat)fvalue toValue:(CGFloat)tvalue;

/**
 *放大与透明组合动画
 *
 *@param enabled 开始／关闭动画
 *@param layer   动画层
 *@param time    开始时间（0.0～1.0），是动画时间的百分比。
 *
 */
+ (void)scaleAndOpacityStatus:(BOOL)enabled layer:(CALayer *)layer beginTime:(CGFloat)time;

@end
