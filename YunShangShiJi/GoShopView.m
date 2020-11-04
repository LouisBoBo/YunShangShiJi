//
//  GoShopView.m
//  YunShangShiJi
//
//  Created by yssj on 16/6/18.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "GoShopView.h"
#import "GlobalTool.h"

#import <objc/runtime.h>

static char BtnClickBlock;

@implementation GoShopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}
-(void)drawRect:(CGRect)rect
{
    
    CGFloat imgWidth=ZOOM6(150);
    UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-imgWidth/2, ZOOM6(50), imgWidth, imgWidth)];
    imgView.image=[UIImage imageNamed:@"icon_gouwuche1"];
    imgView.contentMode=UIViewContentModeScaleAspectFit;
    [self addSubview:imgView];
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imgView.frame)+ZOOM6(24), kScreenWidth, 20)];
    titleLabel.text=@"你的购物车空空如也";
    titleLabel.textColor=kMainTitleColor;
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.font=[UIFont systemFontOfSize:ZOOM6(30)];
    [self addSubview:titleLabel];
    
    UILabel *subLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame)+ZOOM6(5), kScreenWidth, 20)];
    subLabel.text=@"快去挑选宝贝吧～";
    subLabel.textAlignment=NSTextAlignmentCenter;
    subLabel.textColor=kTextColor;
    subLabel.font=[UIFont systemFontOfSize:ZOOM6(24)];
    [self addSubview:subLabel];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(kScreenWidth/2-ZOOM6(280)/2, CGRectGetMaxY(subLabel.frame)+ZOOM6(50), ZOOM6(280), ZOOM6(88));
    [btn setTitle:@"去逛逛" forState:UIControlStateNormal];
    [btn setTintColor:tarbarrossred];
    btn.layer.borderColor=tarbarrossred.CGColor;
    btn.layer.borderWidth=1;
    btn.layer.cornerRadius=3;
    btn.titleLabel.font=[UIFont systemFontOfSize:ZOOM6(36)];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    

}
- (void)loadingSuccess {
    for (UIView *vv in self.subviews) {
        [vv removeFromSuperview];
    }
}
-(void)btnClick
{
    if (self.BtnBlock) {
//        [self loadingSuccess];
        self.BtnBlock();
    }
}

@end
