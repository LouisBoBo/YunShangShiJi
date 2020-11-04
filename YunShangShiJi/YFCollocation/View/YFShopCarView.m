//
//  YFShopCarView.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/20.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "YFShopCarView.h"
#import "GlobalTool.h"

@implementation YFShopCarView {
    UILabel *titleLabel;
    UIImageView *imageView;
    UILabel *marklable;
    UILabel *timeLabel;
    CGFloat space;
    CALayer *markLayer;
    UIBezierPath *bezierPath;
    CAEmitterLayer *explosionLayer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        CGFloat imgW = IMGSIZEW(@"shop_gwc-");
        CGFloat spaceT = (frame.size.height - imgW - ZOOMPT(10))/2;
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - imgW)/2 - ZOOMPT(3), spaceT, imgW, imgW)];
        imageView.image = [UIImage imageNamed:@"shop_gwc-"];
        [self addSubview:imageView];
        
        marklable=[[UILabel alloc]initWithFrame:CGRectMake(imgW - ZOOMPT(10), -ZOOMPT(5), ZOOMPT(16), ZOOMPT(16))];
        marklable.backgroundColor=tarbarrossred;
        marklable.hidden = YES;
        marklable.clipsToBounds=YES;
        marklable.layer.cornerRadius=kZoom6pt(8);
        marklable.textColor=[UIColor whiteColor];
        marklable.textAlignment=NSTextAlignmentCenter;
        marklable.font=[UIFont systemFontOfSize:kZoom6pt(10)];
        [imageView addSubview:marklable];
        
        CGFloat titleW = [NSString widthWithString:@"购物车" font:[UIFont systemFontOfSize:ZOOMPT(11)] constrainedToHeight:ZOOMPT(14)];
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((frame.size.width - titleW)/2, imageView.bottom + ZOOMPT(3), titleW, ZOOMPT(12))];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:kZoom6pt(11)];
        titleLabel.textColor = [UIColor colorWithWhite:168/255. alpha:1];
        titleLabel.text = @"购物车";
        [self addSubview:titleLabel];
        
        CGFloat timeW = [NSString widthWithString:@"88:88" font:[UIFont systemFontOfSize:ZOOMPT(12)] constrainedToHeight:ZOOMPT(14)];
        space = (frame.size.width - (timeW + titleW))/2;
        
        timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(space + titleW, 0, timeW + ZOOMPT(3), ZOOMPT(13))];
        timeLabel.center = CGPointMake(timeLabel.center.x, frame.size.height/2);
        timeLabel.text=@"";
        timeLabel.textColor=tarbarrossred;
        timeLabel.font=[UIFont systemFontOfSize:kZoom6pt(12)];
        timeLabel.hidden = YES;
//        [self addSubview:timeLabel];
        [self emitterAnimation];
    }
    return self;
}

/// 粒子动画
- (void)emitterAnimation {
    CAEmitterCell *explosionCell = [CAEmitterCell emitterCell];
    explosionCell.name = @"explosion";
    explosionCell.alphaRange = 0.20;
    explosionCell.alphaSpeed = -1.0;
    explosionCell.scale = 1;
    explosionCell.scaleRange = 0.2;
    explosionCell.lifetime = 0.7;
    explosionCell.lifetimeRange = 0.3;
    explosionCell.birthRate = 0;
    explosionCell.velocity = 40.00;
    explosionCell.velocityRange = 10.00;
    explosionCell.contents = (__bridge id)[UIImage imageWithColor:tarbarrossred].CGImage;
    explosionLayer = [CAEmitterLayer layer];
    explosionLayer.name = @"emitterLayer";
    explosionLayer.emitterShape = kCAEmitterLayerCircle;
    explosionLayer.emitterMode = kCAEmitterLayerOutline;
    explosionLayer.emitterSize = CGSizeMake(marklable.width*1.5, 0);
    explosionLayer.emitterPosition = marklable.center;
    explosionLayer.emitterCells = @[explosionCell];
    explosionLayer.renderMode = kCAEmitterLayerOldestFirst;
    explosionLayer.masksToBounds = NO;
    explosionLayer.seed = 1366128504;
    [imageView.layer insertSublayer:explosionLayer below:marklable.layer];
}

///抛物小圆
- (CALayer *)markLayer {
    if (markLayer == nil) {
        markLayer = [CALayer layer];
        markLayer.frame = [marklable convertRect:marklable.bounds toView:self.viewController.view];
        markLayer.backgroundColor = tarbarrossred.CGColor;
        markLayer.cornerRadius=ZOOMPT(8);
    }
    return markLayer;
}

///抛物路径
- (UIBezierPath *)bezierPathWithView:(UIView *)view {
    CGPoint end = [marklable convertPoint:CGPointMake(marklable.frame.size.width/2, marklable.frame.size.height/2) toView:view];
    CGFloat beginx = (CGRectGetWidth(view.frame)-2*ZOOM6(140))/2;
    CGPoint begin = CGPointMake(view.frame.size.width-beginx, end.y);
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:begin];
    [bezierPath addQuadCurveToPoint:end controlPoint:CGPointMake((begin.x + end.x)/2, begin.y - ZOOMPT(120))];
    return bezierPath;
}

///抛物动画
- (void)pointStatus:(BOOL)enabled {
    if (enabled) {
        UIViewController *vc = self.viewController;
        [vc.view.layer addSublayer:[self markLayer]];
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        animation.path = [self bezierPathWithView:vc.view].CGPath;
        animation.duration = 0.6;
        animation.autoreverses = NO;
        animation.repeatCount  = 1;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.delegate = self;
        [markLayer addAnimation:animation forKey:@"positionAnimation"];
    } else {
        [markLayer removeAnimationForKey:@"positionAnimation"];
    }
}

///粒子动画
- (void)animate {
    explosionLayer.beginTime = CACurrentMediaTime();
    [explosionLayer setValue:@500 forKeyPath:@"emitterCells.explosion.birthRate"];
    [self performSelector:@selector(stop) withObject:nil afterDelay:0.1];
}

- (void)stop {
    [explosionLayer setValue:@0 forKeyPath:@"emitterCells.explosion.birthRate"];
}

///购物车移动动画
- (void)moveStatus:(BOOL)status view:(UIView *)view x:(CGFloat)x{
    if (status) {
        CAKeyframeAnimation *move = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        CGPoint begin = view.center;
        CGPoint center = CGPointMake(titleLabel.width/2 - x, view.center.y);
        CGPoint end = CGPointMake(titleLabel.width/2 + space - x, view.center.y);
        
        move.values = @[[NSValue valueWithCGPoint:begin],
                        [NSValue valueWithCGPoint:center],
                        [NSValue valueWithCGPoint:end]];
        move.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        move.duration = 0.5;
        move.autoreverses = NO;
        move.repeatCount  = 1;
        move.removedOnCompletion = YES;
        [view.layer addAnimation:move forKey:@"moveAnimation"];
    } else {
        [view.layer removeAnimationForKey:@"moveAnimation"];
    }

}

///角标动画
- (void)scaleStatus:(BOOL)enabled {
    if (enabled) {
        CAKeyframeAnimation *scale = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        scale.values = @[[NSNumber numberWithFloat:1],
                         [NSNumber numberWithFloat:0.7],
                         [NSNumber numberWithFloat:1.2],
                         [NSNumber numberWithFloat:1]];
        scale.keyTimes = @[[NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.4],
                           [NSNumber numberWithFloat:0.8],
                           [NSNumber numberWithFloat:1]];
        scale.duration = 0.7;
        scale.autoreverses = NO;
        scale.repeatCount  = 1;
        scale.removedOnCompletion = YES;
        [marklable.layer addAnimation:scale forKey:@"scaleAnimation"];
        [self performSelector:@selector(animate) withObject:nil afterDelay:0.28];
    } else {
        [marklable.layer removeAnimationForKey:@"scaleAnimation"];
    }
    
}

///抛物动画完成
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [markLayer removeFromSuperlayer];
    marklable.hidden = NO;
    if (timeLabel.hidden) {
        marklable.text = [NSString stringWithFormat:@"%ld",(long)_markNumber<100?_markNumber:99];
//        [self moveStatus:YES view:titleLabel x:0];
//        [self moveStatus:YES view:imageView x:ZOOMPT(3)];
//        titleLabel.left = 0;
//        imageView.center = CGPointMake(titleLabel.center.x - ZOOMPT(3), imageView.center.y);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _isAnimation = NO;
            timeLabel.hidden = NO;
        });
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.50 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _isAnimation = NO;
            marklable.text = [NSString stringWithFormat:@"%ld",(long)_markNumber<100?_markNumber:99];
        });
        [self scaleStatus:YES];
    }
}

/// 加入购物车动画
- (void)animationCar {
    if (_isAnimation) {
        return;
    }
    _isAnimation = YES;
    [self pointStatus:YES];
}

- (void)setMarkNumber:(NSInteger)markNumber {
    _markNumber = markNumber;
    if (_markNumber > 0) {
        if (!_isAnimation) {
            marklable.text = [NSString stringWithFormat:@"%ld",(long)_markNumber<100?_markNumber:99];
            marklable.hidden = NO;
        }
    } else {
        marklable.text = @"";
        marklable.hidden = YES;
        timeLabel.hidden = YES;
    }
}

//- (void)setTime:(NSString *)time {
//    _time = time?:@"";
//    timeLabel.text = _time;
//    if (_time.length <= 0) {
//        timeLabel.hidden = YES;
//        [UIView animateWithDuration:0.5 animations:^{
//            imageView.left = (self.width - imageView.width)/2 - ZOOMPT(3);
//            titleLabel.center = CGPointMake(imageView.center.x + ZOOMPT(3), titleLabel.center.y);
//        }];
//    } else {
//        if (!_isAnimation&&timeLabel.hidden) {
//            [UIView animateWithDuration:0.5 animations:^{
//                titleLabel.left = space;
//                imageView.center = CGPointMake(titleLabel.center.x - ZOOMPT(3), imageView.center.y);
//            } completion:^(BOOL finished) {
//                timeLabel.hidden = NO;
//            }];
//        }
//    }
//}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_btnClick) {
        _btnClick(self);
    }
}

@end
