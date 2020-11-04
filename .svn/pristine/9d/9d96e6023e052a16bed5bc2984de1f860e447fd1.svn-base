//
//  ShareAnimationView.m
//  YunShangShiJi
//
//  Created by zgl on 16/8/22.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "ShareAnimationView.h"
#import "GlobalTool.h"

@implementation ShareAnimationView {
    UIImageView *imageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    frame = CGRectMake(kZoom6pt(-1)+frame.origin.x, kZoom6pt(4)+frame.origin.y, kZoom6pt(18), kZoom6pt(18));
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:@"red"];
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kZoom6pt(9), kZoom6pt(10), kZoom6pt(9), kZoom6pt(9))];
        imageView.image = [UIImage imageNamed:@"money"];
        [self addSubview:imageView];
        self.layer.anchorPoint = CGPointMake(0.99,1);
        imageView.layer.anchorPoint = CGPointMake(0.9,1);
    }
    return self;
}

- (void)animationStart:(BOOL)start {
    [self shakeStatus:start view:self];
    [self shakeStatus1:start view:imageView];
}

- (void)shakeStatus:(BOOL)enabled view:(UIView *)view {
    if (enabled) {
        CAKeyframeAnimation *tAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        tAnimation.duration = 2;
        tAnimation.autoreverses = NO;
        tAnimation.repeatCount  = MAXFLOAT;
        tAnimation.removedOnCompletion = NO;
        tAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DRotate(view.layer.transform,0.0,0.0,0.0,0.0), CATransform3DScale(view.layer.transform, 1, 1, 1))],
                              [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DRotate(view.layer.transform,30*M_PI/180,0.0,0.0,1.0), CATransform3DScale(view.layer.transform, 0.8, 0.8, 1))],
                              [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DRotate(view.layer.transform,0.0,0.0,0.0,0.0), CATransform3DScale(view.layer.transform, 1.1, 1.1, 1))],
                              [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DRotate(view.layer.transform,0.0,0.0,0.0,0.0), CATransform3DScale(view.layer.transform, 1, 1, 1))]];
        tAnimation.keyTimes = @[[NSNumber numberWithFloat:0],
                                [NSNumber numberWithFloat:0.1],
                                [NSNumber numberWithFloat:0.15],
                                [NSNumber numberWithFloat:0.17]];
        [view.layer addAnimation:tAnimation forKey:@"shakeAnimation"];
    } else {
        [view.layer removeAnimationForKey:@"shakeAnimation"];
    }
}

- (void)shakeStatus1:(BOOL)enabled view:(UIView *)view {
    if (enabled) {
        CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        scaleAnimation.duration = 2;
        scaleAnimation.autoreverses = NO;
        scaleAnimation.repeatCount  = MAXFLOAT;
        scaleAnimation.removedOnCompletion = NO;
        scaleAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DRotate(view.layer.transform,0.0, 0.0,0.0,1.0)],
                                  [NSValue valueWithCATransform3D:CATransform3DRotate(view.layer.transform,-0.3, 0.0 ,0.0 ,1.0)],
                                  [NSValue valueWithCATransform3D:CATransform3DRotate(view.layer.transform,0.25, 0.0 ,0.0 ,1.0)],
                                  [NSValue valueWithCATransform3D:CATransform3DRotate(view.layer.transform,-0.20, 0.0 ,0.0 ,1.0)],
                                  [NSValue valueWithCATransform3D:CATransform3DRotate(view.layer.transform,0.15, 0.0 ,0.0 ,1.0)],
                                  [NSValue valueWithCATransform3D:CATransform3DRotate(view.layer.transform,-0.1, 0.0 ,0.0 ,1.0)],
                                  [NSValue valueWithCATransform3D:CATransform3DRotate(view.layer.transform,0.05, 0.0 ,0.0 ,1.0)],
                                  [NSValue valueWithCATransform3D:CATransform3DRotate(view.layer.transform,0.0, 0.0 ,0.0 ,1.0)]];
        scaleAnimation.keyTimes = @[[NSNumber numberWithFloat:0.15],
                                    [NSNumber numberWithFloat:0.19],
                                    [NSNumber numberWithFloat:0.24],
                                    [NSNumber numberWithFloat:0.28],
                                    [NSNumber numberWithFloat:0.31],
                                    [NSNumber numberWithFloat:0.33],
                                    [NSNumber numberWithFloat:0.35]];
        [view.layer addAnimation:scaleAnimation forKey:@"shakeAnimation1"];
    } else {
        [view.layer removeAnimationForKey:@"shakeAnimation1"];
    }
}

@end
