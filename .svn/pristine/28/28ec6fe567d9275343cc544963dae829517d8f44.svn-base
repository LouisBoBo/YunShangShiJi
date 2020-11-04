//
//  NavgationbarView.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/9.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "NavgationbarView.h"
#import "GlobalTool.h"
#import "FightgroupsViewController.h"
@implementation NavgationbarView

{
    UIViewController *_controller;
    CGFloat _titlewidh;
    UILabel *_showlable;
    UIView *backView;
}

+ (NavgationbarView *)shared {
    static dispatch_once_t once = 0;
    static NavgationbarView *progressHUD;
    dispatch_once(&once, ^{ progressHUD = [[NavgationbarView alloc] init]; });
    return progressHUD;
}

+ (void)showMessageAndHide:(NSString *)message backgroundVisiable:(BOOL)visiable {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self shared] showMessage:message autoHide:YES backgroundView:NO];
    });

}

+ (void)showMessageAndHide:(NSString *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self shared] showMessage:message autoHide:YES];
    });
}
+ (void)showMessage:(NSString *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self shared] showMessage:message autoHide:NO];
    });
}
+ (void)dismiss {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self shared] dismiss];
    });
}
- (void)dismiss {
    [NSTimer scheduledTimerWithTimeInterval:1. target:self selector:@selector(hudHide) userInfo:nil repeats:NO];
}
- (void)hudHide {
    NSUInteger options = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseIn;
    [UIView animateWithDuration:0.15 delay:0 options:options animations:^{
        _showlable.transform = CGAffineTransformScale(_showlable.transform, 0.25, 0.25);
        _showlable.alpha = 0;
        backView.alpha=0;
    } completion:^(BOOL finished) {
        [_showlable removeFromSuperview];
        [backView removeFromSuperview];
    }];
}

- (void)showMessage:(NSString *)message autoHide:(BOOL)hide backgroundView:(BOOL)isVisible {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    _titlewidh=[self getRowHeight:message];
    
    if (_showlable.superview==nil) {
        backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        if (isVisible) {
            backView.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0.5];
        }
        [window addSubview:backView];
        _showlable= [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _showlable.alpha=0;
        _showlable.tag=9999;
        _showlable.text=message;
        _showlable.numberOfLines=0;
        _showlable.font=[UIFont systemFontOfSize:ZOOM6(30)];
        
        _showlable.clipsToBounds=YES;
        _showlable.layer.cornerRadius=5;
        _showlable.textAlignment=NSTextAlignmentCenter;
        _showlable.textColor=[UIColor whiteColor];
        _showlable.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.7f];
        _showlable.center=CGPointMake(kApplicationWidth/2, kApplicationHeight/2);
        [window addSubview:_showlable];
        
        if(message.length >0) {
            _showlable.frame = CGRectMake((window.bounds.size.width-_titlewidh-30)/2, (window.bounds.size.height-[self getAutoHeight:message]-35)/2, _titlewidh+30, [self getAutoHeight:message]+35);
        }
        [UIView animateWithDuration:0.15 animations:^{
            _showlable.alpha=1;
        }];
    }
    _showlable.text = message;
    _showlable.frame = CGRectMake((window.bounds.size.width-_titlewidh-30)/2, (window.bounds.size.height-[self getAutoHeight:message]-35)/2, _titlewidh+30, [self getAutoHeight:message]+35);
    
    if (hide) {
        [self dismiss];
    }

}

- (void)showMessage:(NSString *)message autoHide:(BOOL)hide{
    [self showMessage:message autoHide:hide backgroundView:YES];
}

-(void)creatView
{
    self.headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 44)];
    self.headView.backgroundColor=headViewColor;

}

- (void)timerFireMethod:(NSTimer*)theTimer//弹出框
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}

- (void)showAlert:(NSString *) _message{//时间
    
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:nil message:_message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    promptAlert.superview.backgroundColor=[UIColor redColor];
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:1.5f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:YES];
    
    [promptAlert show];
    
}

-(void)showLable:(NSString *)_message Controller:(UIViewController*)coller
{
//    for (UIView *subV in coller.view.subviews) {
//        if (subV.tag == 9999) {
//            [subV removeFromSuperview];
//        }
//    }
    UIView *view=coller.view;
    if (coller==nil) {
        view = [[UIApplication sharedApplication] keyWindow];
    }
    if (_showlable.superview) {
        [_showlable removeFromSuperview];
    }
    _showlable= [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    _showlable.tag=9999;
    _showlable.text=_message;
    _showlable.numberOfLines=0;
    _showlable.font=[UIFont systemFontOfSize:ZOOM6(30)];

    _titlewidh=[self getRowHeight:_message];
    _showlable.clipsToBounds=YES;
    _showlable.layer.cornerRadius=5;
    _showlable.textAlignment=NSTextAlignmentCenter;
    _showlable.textColor=[UIColor whiteColor];
    _showlable.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.7f];

    [view addSubview:_showlable];
    
    //    将当前view放到首层
    [view bringSubviewToFront:_showlable];
    
    _showlable.center=CGPointMake(kApplicationWidth/2, kApplicationHeight/2);
    
    if(_message.length >0)
    {
        _showlable.frame = CGRectMake((view.bounds.size.width-_titlewidh-30)/2, (view.bounds.size.height-[self getAutoHeight:_message]-35)/2, _titlewidh+30, [self getAutoHeight:_message]+35);
        
//        _showlable.frame = CGRectMake((coller.view.bounds.size.width-_titlewidh)/2, (coller.view.bounds.size.height-49-20-([self getAutoHeight:_message])), _titlewidh+10, [self getAutoHeight:_message]+20);

    }
    CGFloat time = 2.0;
    if([coller isKindOfClass:[FightgroupsViewController class]])
    {
        time = 3.0;
    }
    [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(disapper:) userInfo:nil repeats:NO];
    
    _controller=coller;
}

-(void)disapper:(NSTimer*)timer
{
    [self disapperlable];
}

- (void)disapperlable
{
    _showlable.clipsToBounds=YES;
    _showlable.layer.cornerRadius=3;
    _showlable.textAlignment=NSTextAlignmentCenter;
    _showlable.textColor=[UIColor whiteColor];
    _showlable.backgroundColor=[UIColor blackColor];
    _showlable.transform=CGAffineTransformMakeScale(0.25, 0.25);
    
    [_showlable removeFromSuperview];
    [backView removeFromSuperview];

}

-(CGFloat)getAutoHeight:(NSString *)text
{
    //文字高度
    CGFloat height;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(_titlewidh, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:ZOOM6(28)] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
        
    }
    else{
        
    }
    return height;
}
-(CGFloat)getRowHeight:(NSString *)text
{
    //文字高度
    CGFloat widh;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(kScreenWidth-40, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:ZOOM6(30)] forKey:NSFontAttributeName] context:nil];
        
        widh=rect.size.width;
        
    }
    else{
        
    }
    return widh;
}

@end
