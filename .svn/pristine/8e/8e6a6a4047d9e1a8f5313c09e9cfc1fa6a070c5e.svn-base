//
//  Animation.m
//  YunShangShiJi
//
//  Created by hyj on 15/8/18.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//


#import "Animation.h"

@implementation Animation

+(Animation *)shareAnimation
{
    static Animation *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[Animation alloc] init];
        }
    });
    return instance;
}
-(void)createAnimationAt:(UIView *)View;
{
    /*
     [[Animation shareAnimation] stopAnimationAt:View];
     UIView *animationView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
     //    animationView.backgroundColor = [[UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:0.5]  colorWithAlphaComponent:0.5];
     //    animationView.alpha = 1;
     animationView.tag = 777;
     [View addSubview:animationView];
     
     UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2-15, animationView.frame.size.height/2-47, 30, 30)];
     iv.contentMode = UIViewContentModeScaleAspectFit;
     //    iv.center = CGPointMake(animationView.center.x, animationView.frame.size.height/2-32);
     iv.tag = 778;
     [animationView addSubview:iv];
     NSMutableArray *anArr = [NSMutableArray array];
     
     for (int i = 0 ; i<15; i++) {
     NSString *gStr = [NSString stringWithFormat:@"圆-%d",i+1];
     NSString *file = [[NSBundle mainBundle] pathForResource:gStr ofType:@"png"];
     UIImage *image = [UIImage imageWithContentsOfFile:file];
     [anArr addObject:image];
     }
     iv.animationImages = anArr;    //动画图片数组
     iv.animationDuration = 1;      //执行一次完整动画所需的时长
     iv.animationRepeatCount = 0;   //无限
     [iv startAnimating];
     */
}

-(void)CreateAnimationAt:(UIView *)View;
{
    
    [[Animation shareAnimation] stopAnimationAt:View];
    UIView *animationView = [[UIView alloc] initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar)];
    animationView.tag = 777;
    [View addSubview:animationView];
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2-15, animationView.frame.size.height/2-47, 30, 30)];
    iv.contentMode = UIViewContentModeScaleAspectFit;
    iv.tag = 778;
    [animationView addSubview:iv];
    NSMutableArray *anArr = [NSMutableArray array];
    
    for (int i = 0 ; i<15; i++) {
        NSString *gStr = [NSString stringWithFormat:@"圆-%d",i+1];
        NSString *file = [[NSBundle mainBundle] pathForResource:gStr ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:file];
        [anArr addObject:image];
    }
    iv.animationImages = anArr;    //动画图片数组
    iv.animationDuration = 1;      //执行一次完整动画所需的时长
    iv.animationRepeatCount = 0;   //无限
    [iv startAnimating];
    
}

- (void)stopAnimationAt:(UIView *)View
{
    UIView *view = (UIView *)[View viewWithTag:777];
    UIImageView *iv = (UIImageView *)[view viewWithTag:778];
    [iv stopAnimating];
    [view removeFromSuperview];
}

@end
