//
//  TopicSofaView.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/22.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TopicSofaView.h"
#import "GlobalTool.h"
@implementation TopicSofaView

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
    CGFloat with = ZOOM6(200);
    UIView *modelview = [[UIView alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.frame)-with)/2, (CGRectGetHeight(self.frame)-with)/2, with, with)];
    modelview.backgroundColor = [UIColor whiteColor];
    modelview.userInteractionEnabled = YES;
    [self addSubview:modelview];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    [modelview addGestureRecognizer:tap];
    
    CGFloat imgWidth=ZOOM6(70);
    UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-imgWidth/2,((self.frame.size.height)-ZOOM6(120))/2, imgWidth, imgWidth)];
    imgView.image=[UIImage imageNamed:@"topic_icon_shafa"];
    imgView.contentMode=UIViewContentModeScaleAspectFit;
    [self addSubview:imgView];
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imgView.frame)+ZOOM6(20), kScreenWidth, ZOOM6(30))];
    titleLabel.text=@" 快来抢沙发吧～";
    titleLabel.textColor=RGBCOLOR_I(168, 168, 168);
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.font=[UIFont systemFontOfSize:ZOOM6(28)];
    [self addSubview:titleLabel];
    
}

- (void)click:(UITapGestureRecognizer*)tap
{
    if(self.sofaBlock)
    {
        self.sofaBlock();
    }
}
- (void)loadingSuccess {
    for (UIView *vv in self.subviews) {
        [vv removeFromSuperview];
    }
}

@end
