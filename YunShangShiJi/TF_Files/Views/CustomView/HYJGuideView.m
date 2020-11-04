//
//  HYJGuideView.m
//  YunShangShiJi
//
//  Created by hyj on 15/8/26.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "HYJGuideView.h"
#import "GlobalTool.h"

@implementation HYJGuideView
{
    NSInteger _time;
    CGFloat _height;
    BOOL _isUp;
    NSTimer *_timer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        [self viewInit];
    }
    return self;
}

- (void)viewInit
{
    UIView *guidView = [[UIView alloc] initWithFrame:self.bounds];
    
    _isUp = YES;
    UIImage *image = [UIImage imageNamed:@"引导页-秋冬版640.jpg"];
    
    
    UIImageView * imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth , kScreenWidth *image.size.height/image.size.width)];
    _height = kScreenWidth *image.size.height/image.size.width;
    imageView1.image = image;
    
    
    [guidView addSubview:imageView1];
    
    UIScrollView * bgScroll = [[UIScrollView alloc] initWithFrame:self.bounds];
    bgScroll.tag = 110;
    bgScroll.pagingEnabled = NO;
    bgScroll.userInteractionEnabled = NO;
    bgScroll.contentSize =CGSizeMake(0, _height);
    
    [bgScroll addSubview:imageView1];
    
    [guidView addSubview:bgScroll];
    
    if ([_timer isValid]) {
        [_timer invalidate];
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(offset) userInfo:nil repeats:YES];
    
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth*2/3 ,kScreenWidth*8/9 )];
    whiteView.center = CGPointMake(kScreenWidth *0.5, kScreenHeight*0.5);
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.alpha = 0.9;
    [guidView addSubview:whiteView];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/6, kScreenWidth/6)];
    icon.center = CGPointMake(CGRectGetWidth(whiteView.frame)/2, CGRectGetHeight(whiteView.frame)/4);
    icon.image = [UIImage imageNamed:@"Icon"];
    [whiteView addSubview:icon];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/5, kScreenWidth/10)];
    
    title.center = CGPointMake(CGRectGetWidth(whiteView.frame)/2, CGRectGetHeight(whiteView.frame)/2-25);
    title.text = @"衣蝠";
    title.textAlignment = 1;
    title.font = [UIFont boldSystemFontOfSize:22];
    
    [whiteView addSubview:title];
    
    UILabel *website = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/5, 20)];
    website.center = CGPointMake(CGRectGetWidth(whiteView.frame)/2, CGRectGetMaxY(title.frame));
    website.text = @"52yifu.com";
    website.textAlignment = 1;
    website.textColor = kTextColor;
    website.font = [UIFont systemFontOfSize:12];
    
    [whiteView addSubview:website];
    
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    Btn.frame = CGRectMake(0, 0, CGRectGetWidth(whiteView.frame)*2/3, CGRectGetWidth(whiteView.frame)/6);
    Btn.center = CGPointMake(CGRectGetWidth(whiteView.frame)/2, CGRectGetHeight(whiteView.frame)*2/3);
    [Btn setTitle:@"注册" forState:UIControlStateNormal];
    [Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    Btn.backgroundColor = COLOR_ROSERED;
    [whiteView addSubview:Btn];
    
    UIButton *logBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    logBtn.frame = CGRectMake(0, 0, CGRectGetWidth(whiteView.frame)*2/3, CGRectGetWidth(whiteView.frame)/6);
    
    logBtn.center = CGPointMake(CGRectGetWidth(whiteView.frame)/2, CGRectGetHeight(Btn.frame) + CGRectGetMaxY(Btn.frame)-5);
    
    [logBtn setTitle:@"登录" forState:UIControlStateNormal];
    [logBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    logBtn.backgroundColor = [UIColor blackColor];
    [logBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:logBtn];
    
    [self addSubview:guidView];
    
}

- (void)regist
{
    //注册");
    self.loginBlock(@(2000));
    [_timer invalidate];
    [self removeFromSuperview];
}

- (void)login
{
    //登录");
    self.loginBlock(@(1000));
    [_timer invalidate];
    [self removeFromSuperview];
}

- (void)offset
{
    _time++;
    UIScrollView *bgScroll = (UIScrollView *)[self viewWithTag:110];
    
    if (_time % (int)(_height - kScreenHeight) == 0) {
        _isUp = !_isUp;
    }
    if (_isUp) {
        [bgScroll setContentOffset:CGPointMake(0, _time % (int)(_height - kScreenHeight)) animated:YES];
    }
    else
    {
        [bgScroll setContentOffset:CGPointMake(0,_height- kScreenHeight- _time % (int)(_height - kScreenHeight)) animated:YES];
    }
    
    
}

@end
