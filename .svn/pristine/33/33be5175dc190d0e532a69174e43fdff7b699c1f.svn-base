//
//  TopicShareview.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/20.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TopicShareview.h"
#import "MBProgressHUD+NJ.h"
#import "GlobalTool.h"
@implementation TopicShareview

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
    self.popBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight+kUnderStatusBarStartY)];
    [self addSubview:self.popBackView];
    
    self.shareModelview = [[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight+30, kApplicationWidth, ZOOM6(400)+kUnderStatusBarStartY)];
    self.shareModelview.backgroundColor=[UIColor whiteColor];
    [self.popBackView addSubview:self.shareModelview];
    
    //奖励文字
    CGFloat titlelable1Y = ZOOM(20);
    UILabel *titlelable1 = [[UILabel alloc]initWithFrame:CGRectMake(10, titlelable1Y, kApplicationWidth-20, 20)];
    titlelable1.text = [NSString stringWithFormat:@"分享话题"];
    titlelable1.frame=CGRectMake(ZOOM6(20), titlelable1Y+ZOOM(20), kScreenWidth-2*ZOOM(20), 30);
    titlelable1.textAlignment = NSTextAlignmentCenter;
    titlelable1.font = [UIFont systemFontOfSize:ZOOM6(40)];
    titlelable1.textColor = RGBCOLOR_I(125, 125, 125);
    titlelable1.clipsToBounds=YES;
    [self.shareModelview addSubview:titlelable1];
    
    NSArray *titleArray = @[@"微信群",@"QQ好友",@"QQ空间",@"微博"];
    NSArray *imageArray = @[@"icon_weinxinqun",@"qq",@"qq空间-1",@"微博"];
//    NSArray *titleArray = @[@"朋友圈",@"微信好友",@"QQ好友",@"QQ空间",@"微博"];
//    NSArray *imageArray = @[@"朋友圈-1",@"微信好友",@"qq",@"qq空间-1",@"微博"];
    CGFloat dismissbtnYY =0;
    //分享平台
    for (int i=0; i<titleArray.count; i++) {
        
        CGFloat space = (kScreenWidth - ZOOM6(100)*titleArray.count -ZOOM6(20)*2)/(titleArray.count-1);
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.frame = CGRectMake((space+ZOOM6(100))*i+ZOOM6(20),CGRectGetMaxY(titlelable1.frame)+ZOOM6(40), ZOOM6(100), ZOOM6(100));
        shareBtn.tag = 9000+i;
        [shareBtn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *sharetitle = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(shareBtn.frame)-20, CGRectGetMaxY(shareBtn.frame)+ZOOM6(10), CGRectGetWidth(shareBtn.frame)+40, 15)];
        sharetitle.text = titleArray[i];
        sharetitle.textColor = RGBCOLOR_I(168, 168, 168);
        sharetitle.font = [UIFont systemFontOfSize:ZOOM6(24)];
        sharetitle.textAlignment = NSTextAlignmentCenter;
        
        dismissbtnYY = CGRectGetMaxY(sharetitle.frame);
        [self.shareModelview addSubview:sharetitle];
        [self.shareModelview addSubview:shareBtn];
        
    }
    
    //取消按钮
    UIButton *dismissbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dismissbtn.frame = CGRectMake(ZOOM6(20), dismissbtnYY+ZOOM6(40), kScreenWidth-ZOOM6(20)*2, ZOOM6(80));
    dismissbtn.layer.borderColor = RGBCOLOR_I(125, 125, 125).CGColor;
    dismissbtn.layer.borderWidth = 1;
    dismissbtn.layer.cornerRadius = 5;
    [dismissbtn setTitleColor:RGBCOLOR_I(125, 125, 125) forState:UIControlStateNormal];
    dismissbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
    [dismissbtn setTitle:@"取消" forState:UIControlStateNormal];
    [dismissbtn addTarget:self action:@selector(dismissShareView) forControlEvents:UIControlEventTouchUpInside];
    [self.shareModelview addSubview:dismissbtn];
    
    self.popBackView.backgroundColor =[UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.popBackView.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        
        self.shareModelview.frame=CGRectMake(0, kApplicationHeight-ZOOM6(400), kApplicationWidth, ZOOM6(400)+kUnderStatusBarStartY);
        
    } completion:^(BOOL finished) {
        
        
    }];

}

- (void)shareClick:(UIButton*)sender
{
    NSInteger tag = sender.tag - 9000;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    if(tag == 0 || tag == 1)
    if(tag == 0)
    {
        //判断设备是否安装微信
        if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
            [MBProgressHUD show:@"还未安装微信哦~" icon:nil view:window];
            [self dismiss];
            return;
        }
    }else if (tag == 1)
    {
        //判断设备是否安装QQ
        if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]])
        {
            [MBProgressHUD show:@"还未安装QQ哦~" icon:nil view:window];
            [self dismiss];
            return;
        }
    }
    
    if(self.shareBlock)
    {
        self.shareBlock(tag);
    }
    [self dismiss];
}
- (void)dismissShareView
{
    [self dismiss];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.5 animations:^{
        
        self.popBackView.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
        
        self.shareModelview.frame=CGRectMake(0, kApplicationHeight+30, kApplicationWidth, ZOOM6(400));
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];

}
@end
