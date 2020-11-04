//
//  ToupdateView.m
//  YunShangShiJi
//
//  Created by ios-1 on 16/7/18.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "ToupdateView.h"
#import "GlobalTool.h"
#import "AppDelegate.h"

@implementation ToupdateView
{
    UIView *_Popview;
    UIView *_InvitationCodeView;

}

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.7];
        
        AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
        if(app.isComeing == YES)
        {
            [self setToupdateView];
            
            app.isComeing = NO;
        }
        
    }
    return self;
}

- (void)setToupdateView
{
    _Popview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    
    _Popview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _Popview.userInteractionEnabled = YES;
    
    
    _InvitationCodeView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(80), ZOOM(660), kScreenWidth-ZOOM(80)*2, kScreenHeight-ZOOM(660)*2)];
    _InvitationCodeView.backgroundColor=[UIColor whiteColor];
    _InvitationCodeView.layer.cornerRadius=5;
    _InvitationCodeView.clipsToBounds = YES;
    [_Popview addSubview:_InvitationCodeView];
    
    
    //title
    UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, CGRectGetWidth(_InvitationCodeView.frame), ZOOM(100))];
    titlelab.text = @"不更新就哭〒▽〒";
    titlelab.textAlignment = NSTextAlignmentCenter;
    titlelab.font = [UIFont systemFontOfSize:ZOOM(55)];
    [_InvitationCodeView addSubview:titlelab];
    
    //提示方案
    CGFloat viewHeigh = _InvitationCodeView.frame.size.height - ZOOM(100) - ZOOM(50*3.4);
    
    CGFloat viewWidth = _InvitationCodeView.frame.size.width-2*ZOOM(50);
    
    UITextView *msgtextview = [[UITextView alloc]initWithFrame:CGRectMake(ZOOM(50), ZOOM(100), viewWidth, viewHeigh)];
    
    msgtextview.text=@"1.全新签到任务，iPhone6、现金领不停\n2.时尚炫酷搭配购，最新潮流看不够\n3.更多新内容等你来解锁我们的愿望是希望你们立即更新";
   
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSString *getmsg = app.versionmsg;
    msgtextview.text = getmsg;
    
    msgtextview.font = [UIFont systemFontOfSize:ZOOM(47)];
    msgtextview.textColor = kTextColor;
    msgtextview.editable = NO;
    [_InvitationCodeView addSubview:msgtextview];
    
    
    CGFloat lineYY = ZOOM(45*3.4);
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _InvitationCodeView.frame.size.height-lineYY, _InvitationCodeView.frame.size.width, 1)];
    lineView.backgroundColor = lineGreyColor;
    [_InvitationCodeView addSubview:lineView];
    
    if(app.isQiangGeng == YES)
    {
        //强更时用到
        UIButton *changebtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        changebtn.frame = CGRectMake(0, CGRectGetMaxY(lineView.frame), lineView.frame.size.width, lineYY);
        changebtn.tag = 888889;
        [changebtn setTitle:@"立即更新" forState:UIControlStateNormal];
        changebtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(60)];
        [changebtn addTarget:self action:@selector(changeclick:) forControlEvents:UIControlEventTouchUpInside];
        changebtn.tintColor = tarbarrossred;
        [_InvitationCodeView addSubview:changebtn];
        
    }else{
    
        NSArray *buttonarr = @[@"稍后再说",@"立即更新"];
        CGFloat buttonWith = (lineView.frame.size.width - 80)/2;
        
        for(int i =0;i<buttonarr.count;i++)
        {
            UIButton *changebtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            changebtn.frame = CGRectMake(20+(buttonWith+40)*i, CGRectGetMaxY(lineView.frame), buttonWith, lineYY);
            changebtn.tag = 888888+i;
            //        changebtn.layer.borderWidth = 1;
            //        changebtn.layer.borderColor = tarbarrossred.CGColor;
            [changebtn setTitle:buttonarr[i] forState:UIControlStateNormal];
            changebtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(60)];
            [changebtn addTarget:self action:@selector(changeclick:) forControlEvents:UIControlEventTouchUpInside];
            changebtn.tintColor = tarbarrossred;
            [_InvitationCodeView addSubview:changebtn];
            
            [_Popview addSubview:_InvitationCodeView];
        }

    }
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_Popview];
    
    _InvitationCodeView.transform = CGAffineTransformMakeScale(0.7, 0.7);
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _Popview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        _InvitationCodeView.transform = CGAffineTransformMakeScale(1, 1);
        _InvitationCodeView.alpha = 1;
        
    } completion:^(BOOL finish) {
        
    }];
}

-(void)tapClick
{
    [UIView animateWithDuration:0.5 animations:^{
        
        _Popview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
        _InvitationCodeView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        _InvitationCodeView.alpha = 0;
        
    } completion:^(BOOL finish) {
        
        [_Popview removeFromSuperview];
    }];
    
}

- (void)changeclick:(UIButton*)sender
{

    if(sender.tag == 888889)
    {
        if(self.ToupdateBlock)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/yi-fu/id1029741842?mt=8"]];
        }

    }else{
        [self tapClick];
        self.ToupdateBlock();
    }
    
}

@end
