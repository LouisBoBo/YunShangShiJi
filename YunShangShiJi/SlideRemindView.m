//
//  SlideRemindView.m
//  YunShangShiJi
//
//  Created by ios-1 on 16/8/24.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "SlideRemindView.h"
#import "GlobalTool.h"
@implementation SlideRemindView

- (instancetype)initWithFrame:(CGRect)frame Type:(NSString *)slidetype
{
    if(self = [super initWithFrame:frame])
    {
        self.slidetype = slidetype;
        [self creatPopview];
    }
    
    return self;
}

- (void)creatPopview
{
    _SlidePopview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    
    _SlidePopview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _SlidePopview.userInteractionEnabled = YES;
    
    _SlidePopview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    //点击
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disapper)];
    [_SlidePopview addGestureRecognizer:tap];
    
    //上滑
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(disapper)];
    
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [_SlidePopview addGestureRecognizer:recognizer];
    
    [self creatBackview];
    
    [self addSubview:_SlidePopview];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _SlidePopview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        
               
    } completion:^(BOOL finish) {
        
    }];

    
}

//弹框内容
- (void)creatBackview
{
    _SlideBackView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM6(50),(kScreenHeight-ZOOM6(400))/2,kScreenWidth-ZOOM6(50)*2, ZOOM6(450))];
    
    _SlideBackView.backgroundColor=[UIColor clearColor];
    _SlideBackView.clipsToBounds = YES;
    [_SlidePopview addSubview:_SlideBackView];
    
    CGFloat imageWidth = IMAGEW(@"shoushi");
    CGFloat imageHeigh = IMAGEH(@"shoushi");
    UIImageView *slideImage = [[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(_SlideBackView.frame)-imageWidth)/2, 0, imageWidth, imageHeigh)];
    if([self.slidetype isEqualToString:@"推荐"])
    {
        slideImage.image = [UIImage imageNamed:@"recommend_tip"];
    }else{
        slideImage.image = [UIImage imageNamed:@"shoushi"];
    }
    
    [_SlideBackView addSubview:slideImage];
    
    CGFloat buttonWidth = IMAGEW(@"but_i-know");
    CGFloat buttonHeigh = IMAGEH(@"but_i-know");
    UIButton *knowbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    knowbutton.frame = CGRectMake((CGRectGetWidth(_SlideBackView.frame)-buttonWidth)/2, CGRectGetMaxY(slideImage.frame)+50, buttonWidth, buttonHeigh);
    [knowbutton setBackgroundImage:[UIImage imageNamed:@"but_i-know"] forState:UIControlStateNormal];
    [knowbutton addTarget:self action:@selector(iknow) forControlEvents:UIControlEventTouchUpInside];
    [_SlideBackView addSubview:knowbutton];
}

- (void)disapper
{
    if(_disapperBlock)
    {
        _disapperBlock();
    }

    [self remindViewHiden];
}

- (void)iknow
{
    if(_disapperBlock)
    {
        _disapperBlock();
    }
    [self remindViewHiden];
}
//弹框消失
- (void)remindViewHiden
{
    [UIView animateWithDuration:0.5 animations:^{
        
        [_SlideBackView removeFromSuperview];
        
        _SlidePopview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
        
    } completion:^(BOOL finish) {
        
        [self removeFromSuperview];
    }];

}
@end
