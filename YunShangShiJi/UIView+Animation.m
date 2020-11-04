//
//  UIView+Animation.m
//  YunShangShiJi
//
//  Created by zgl on 16/7/5.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)

/// 抖动
- (void)shakeStatus:(BOOL)enabled {
    if (enabled) {
        CGFloat rotation = 0.03;
        CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform"];
        shake.duration = 0.13;
        shake.autoreverses = YES;
        shake.repeatCount  = MAXFLOAT;
        shake.removedOnCompletion = NO;
        shake.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform,-rotation, 0.0 ,0.0 ,1.0)];
        shake.toValue   = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, rotation, 0.0 ,0.0 ,1.0)];

        [self.layer addAnimation:shake forKey:@"shakeAnimation"];
    } else {
        [self.layer removeAnimationForKey:@"shakeAnimation"];
    }
}

/**
 * 搭配界面 小红点动画
 *
 * @param enabled 动画开始与结束，YES开始、NO结束动画
 *
 * @param layers 波纹小圆
 */
- (void)scaleStatus:(BOOL)enabled layers:(NSArray<CALayer *> *)layers{
    if (enabled) {
        CGFloat time = 0.34;
        for (CALayer *layer in layers) {
            [UIView scaleAndOpacityStatus:YES layer:layer beginTime:time];
            time += 0.13;
        }
        
        CAKeyframeAnimation *scale = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        scale.values = @[[NSNumber numberWithFloat:1],
                         [NSNumber numberWithFloat:0.7],
                         [NSNumber numberWithFloat:1.3],
                         [NSNumber numberWithFloat:1]];
        scale.keyTimes = @[[NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.07],
                           [NSNumber numberWithFloat:0.2],
                           [NSNumber numberWithFloat:0.27]];
        scale.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        scale.duration = 3;
        scale.autoreverses = NO;
        scale.repeatCount  = MAXFLOAT;
        scale.removedOnCompletion = NO;
        [self.layer addAnimation:scale forKey:@"scaleAnimation"];
    } else {
        [self.layer removeAnimationForKey:@"scaleAnimation"];
        for (CALayer *layer in layers) {
            [UIView scaleAndOpacityStatus:NO layer:layer beginTime:0];
        }
    }

}

/**
 *放大与透明组合动画
 *
 *@param enabled 开始／关闭动画
 *@param layer   动画层
 *@param time    开始时间（0.0～1.0），是动画时间的百分比。
 *
 */
+ (void)scaleAndOpacityStatus:(BOOL)enabled layer:(CALayer *)layer beginTime:(CGFloat)time{
    if (enabled) {
        CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.values = @[[NSNumber numberWithFloat:0.7],
                                  [NSNumber numberWithFloat:4]];
        scaleAnimation.keyTimes = @[[NSNumber numberWithFloat:time],
                                    [NSNumber numberWithFloat:time + 0.4]];
        
        CAKeyframeAnimation *opacAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opacAnimation.values = @[[NSNumber numberWithFloat:0.0],
                                 [NSNumber numberWithFloat:1.0],
                                 [NSNumber numberWithFloat:0]];
        opacAnimation.keyTimes = @[[NSNumber numberWithFloat:time],
                                   [NSNumber numberWithFloat:time],
                                   [NSNumber numberWithFloat:time + 0.4]];
        
        CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
        animationGroup.duration = 3;
        animationGroup.autoreverses = NO;
        animationGroup.repeatCount  = MAXFLOAT;
        animationGroup.removedOnCompletion = NO;
        [animationGroup setAnimations:[NSArray arrayWithObjects:scaleAnimation, opacAnimation, nil]];
        
        [layer addAnimation:animationGroup forKey:@"scaleAndOpacityAnimation"];
    } else {
        [layer removeAnimationForKey:@"scaleAndOpacityAnimation"];
    }
    
}

/**
 *透明动画
 *
 *@param enabled 开始／关闭动画
 *@param time    一个循环时长
 *@param fromValue    开始透明度
 *@param toValue      结束透明度
 *
 */
- (void)opacityStatus:(BOOL)enabled time:(CGFloat)time fromValue:(CGFloat)fvalue toValue:(CGFloat)tvalue {
    if (enabled) {
        CAKeyframeAnimation *opacAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opacAnimation.values = @[[NSNumber numberWithFloat:fvalue],
                                 [NSNumber numberWithFloat:tvalue],
                                 [NSNumber numberWithFloat:fvalue]];
        opacAnimation.keyTimes = @[[NSNumber numberWithFloat:0],
                                   [NSNumber numberWithFloat:0.4],
                                   [NSNumber numberWithFloat:0.8]];
        CAKeyframeAnimation *scale = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        scale.values = @[[NSNumber numberWithFloat:1],
                         [NSNumber numberWithFloat:0.8],
                         [NSNumber numberWithFloat:1.2],
                         [NSNumber numberWithFloat:1]];
        scale.keyTimes = @[[NSNumber numberWithFloat:0.8],
                           [NSNumber numberWithFloat:0.85],
                           [NSNumber numberWithFloat:0.95],
                           [NSNumber numberWithFloat:1]];
        scale.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
        animationGroup.duration = time;
        animationGroup.autoreverses = NO;
        animationGroup.repeatCount  = MAXFLOAT;
        animationGroup.removedOnCompletion = NO;
        [animationGroup setAnimations:[NSArray arrayWithObjects:scale, opacAnimation, nil]];
        [self.layer addAnimation:animationGroup forKey:@"opacityAnimation"];
    } else {
        [self.layer removeAnimationForKey:@"opacityAnimation"];
    }
    
}

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
                 layer:(CALayer *)layer {
    if (nil == layer) {
        layer = self.layer;
    }
    
    if (enable) {
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:fromPoint];
        [bezierPath addQuadCurveToPoint:toPoint controlPoint:controlPoint];
        
        CAKeyframeAnimation *scale = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        scale.path = bezierPath.CGPath;
        scale.duration = duration;
        scale.autoreverses = NO;
        scale.repeatCount  = 1;
        scale.removedOnCompletion = NO;
        scale.fillMode = kCAFillModeForwards;
        scale.delegate = self;
        [layer addAnimation:scale forKey:@"parabolaAnimation"];
    } else {
        [layer removeAnimationForKey:@"parabolaAnimation"];
    }
}

- (void)scaleStatus:(BOOL)enabled time:(CGFloat)time {
    if (enabled) {
        CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        shake.duration = time;
        shake.autoreverses = NO;
        shake.repeatCount  = 0;
        shake.removedOnCompletion = NO;
        shake.fillMode=kCAFillModeForwards;
        shake.fromValue = [NSNumber numberWithFloat:1];
        shake.toValue   = [NSNumber numberWithFloat:1.1];
        
        [self.layer addAnimation:shake forKey:@"SCALEAnimation"];
    } else {
        [self.layer removeAnimationForKey:@"SCALEAnimation"];
    }

}

@end
