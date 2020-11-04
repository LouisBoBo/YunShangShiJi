//
//  LastGroupRemindView.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/8.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "LastGroupRemindView.h"
#import "GlobalTool.h"
@implementation LastGroupRemindView
{
    CGFloat invitcodeYY;                  //弹框初始y坐标
    CGFloat ShareInvitationCodeViewHeigh; //弹框的高度
    CGFloat ShareInvitationCodeViewWidth; //弹框的宽度

}
- (instancetype)initWithFrame:(CGRect)frame Type:(recommendType)type;
{
    if(self = [super initWithFrame:frame])
    {
        self.recommendtype = type;
        [self creaPopview];
    }
    return self;
}

- (void)creaPopview
{
    _RemindPopview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    _RemindPopview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _RemindPopview.userInteractionEnabled = YES;
    [self addSubview:_RemindPopview];
    
    ShareInvitationCodeViewWidth = (kScreenWidth-ZOOM(40)*2);
    ShareInvitationCodeViewHeigh = ZOOM6(1035);
    invitcodeYY = (kScreenHeight - ShareInvitationCodeViewHeigh)/2-ZOOM6(20);
    
    //底视图
    _RemindBackView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(40), invitcodeYY, ShareInvitationCodeViewWidth, ShareInvitationCodeViewHeigh)];
    _RemindBackView.layer.cornerRadius = 5;
    _RemindBackView.userInteractionEnabled = YES;
    _RemindBackView.backgroundColor = [UIColor whiteColor];
    [_RemindPopview addSubview:_RemindBackView];
    
    //关闭按钮
    CGFloat btnwidth = ZOOM6(40);
    self.canclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.canclebtn.frame=CGRectMake(CGRectGetWidth(self.RemindBackView.frame)-btnwidth-ZOOM(30), ZOOM6(30), btnwidth, btnwidth);
    [self.canclebtn setImage:[UIImage imageNamed:@"recommend_icon_close"] forState:UIControlStateNormal];
    self.canclebtn.layer.cornerRadius=btnwidth/2;
    [self.canclebtn addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
    [_RemindBackView addSubview:self.canclebtn];

    //弹框上大图
    CGFloat imageWith = IMAGEW(@"recommend_girl");
    CGFloat imageHeig = IMAGEH(@"recommend_girl");
    _headImageview = [[UIImageView alloc]initWithFrame:CGRectMake((ShareInvitationCodeViewWidth-imageWith)/2, ZOOM6(130), imageWith, imageHeig)];
    _headImageview.image = [UIImage imageNamed:@"recommend_girl"];
    [_RemindBackView addSubview:_headImageview];
    
    //title
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), CGRectGetMaxY(_headImageview.frame)+ZOOM6(50), CGRectGetWidth(_RemindBackView.frame)-2*ZOOM6(20), ZOOM6(150))];
    NSString *title = self.recommendtype==recommend_lastgroup?@"你喜爱的商品已经推荐至购物车——我的喜欢\n你可以继续浏览下一组推荐商品，也可以去购物车查看我的喜欢浏览下一组":@"我们为你精心挑选的美衣已经全部浏览完毕!你喜欢的商品被推荐至购物车--我的喜欢";
    _titleLabel.text = title;
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
    _titleLabel.textColor = RGBCOLOR_I(125, 125, 125);
    [_RemindBackView addSubview:_titleLabel];
    
    //我的最爱
    _nextGroupBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _nextGroupBtn.frame = CGRectMake(ZOOM6(20),CGRectGetMaxY(_titleLabel.frame)+ZOOM6(90) , CGRectGetWidth(_titleLabel.frame), ZOOM6(80));
    _nextGroupBtn.backgroundColor = tarbarrossred;
    [_nextGroupBtn setTintColor:[UIColor whiteColor]];
    NSString *btntitle = self.recommendtype==recommend_lastgroup?@"浏览下一组":@"我的喜欢";
    [_nextGroupBtn setTitle:btntitle forState:UIControlStateNormal];
    _nextGroupBtn.layer.cornerRadius = 5;
    [_nextGroupBtn addTarget:self action:@selector(myLike) forControlEvents:UIControlEventTouchUpInside];
    [_RemindBackView addSubview:_nextGroupBtn];
    
    //取消
    _myfaviourtBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _myfaviourtBtn.frame = CGRectMake(ZOOM6(20),CGRectGetMaxY(_nextGroupBtn.frame)+ZOOM6(30) , CGRectGetWidth(_titleLabel.frame), ZOOM6(80));
    NSString *fabtntitle = self.recommendtype==recommend_lastgroup?@"我的喜欢":@"取 消";
    [_myfaviourtBtn setTitle:fabtntitle forState:UIControlStateNormal];
    _myfaviourtBtn.layer.cornerRadius = 5;
    _myfaviourtBtn.layer.borderWidth = 1;
    [_myfaviourtBtn setTintColor:tarbarrossred];
    _myfaviourtBtn.layer.borderColor = tarbarrossred.CGColor;
    [_myfaviourtBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_RemindBackView addSubview:_myfaviourtBtn];

    _RemindBackView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    _RemindBackView.alpha = 0.5;
    
    _RemindPopview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [UIView animateWithDuration:0.5 animations:^{
        
        _RemindPopview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        
        _RemindBackView.transform = CGAffineTransformMakeScale(1, 1);
        _RemindBackView.alpha = 1;
        
    } completion:^(BOOL finish) {
        
    }];
    
}
#pragma mark 下一组
- (void)dismiss
{
    if(self.dismissBlock)
    {
        self.dismissBlock();
    }
    
    [self remindViewHiden];
}
#pragma mark 我的最爱
- (void)myLike
{
    if(self.myfaviourtBlock)
    {
        self.myfaviourtBlock();
    }
    
    [self remindViewHiden];
}
#pragma mark 关闭弹框
- (void)cancleClick
{
    if(self.cancleBlock)
    {
        self.cancleBlock();
    }
    [self remindViewHiden];
}

#pragma mark 弹框消失
- (void)remindViewHiden
{
    [UIView animateWithDuration:0.5 animations:^{
        
        _RemindPopview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
        _RemindBackView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        _RemindBackView.alpha = 0;
        
    } completion:^(BOOL finish) {
        
        [self removeFromSuperview];
        
    }];
    
}

@end
