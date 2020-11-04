//
//  SecondHeadView.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/17.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "SecondHeadView.h"
#import "GlobalTool.h"
@implementation SecondHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self creatMainView];
    }
    return self;
}

- (void)creatMainView
{
    self.headBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.headBackView.userInteractionEnabled = YES;
    [self addSubview:self.headBackView];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreClick)];
//    [self.headBackView addGestureRecognizer:tap];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(20))];
    line.backgroundColor = RGBCOLOR_I(240, 240, 240);
    [self.headBackView addSubview:line];
    
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20),ZOOM6(20), ZOOM6(200),ZOOM6(80))];
    titlelabel.text = @"相关推荐";
    titlelabel.textColor = tarbarrossred;
    titlelabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
    [self.headBackView addSubview:titlelabel];

    UIButton *followbutton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-ZOOM6(190), ZOOM6(30), ZOOM6(180), ZOOM6(50))];
    [followbutton setTitle:@"更多" forState:UIControlStateNormal];
    [followbutton setTitleColor:tarbarrossred forState:UIControlStateNormal];
    followbutton.titleLabel.textAlignment = NSTextAlignmentLeft;
    followbutton.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
    followbutton.imageEdgeInsets = UIEdgeInsetsMake(0,ZOOM6(140),0.0f,ZOOM(10));
    followbutton.titleEdgeInsets = UIEdgeInsetsMake(0,0,0.0f,0);
    [followbutton setImage:[UIImage imageNamed:@"icon_go"] forState:UIControlStateNormal];
    followbutton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [followbutton addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.headBackView addSubview:followbutton];
}

- (void)moreClick
{
    if(self.moreBlock)
    {
        self.moreBlock();
    }
}
@end
