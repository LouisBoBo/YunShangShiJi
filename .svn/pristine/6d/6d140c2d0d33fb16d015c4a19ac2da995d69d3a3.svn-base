//
//  ExtrabonusTopView.m
//  YunShangShiJi
//
//  Created by ios-1 on 16/9/25.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "ExtrabonusTopView.h"
#import "GlobalTool.h"
@implementation ExtrabonusTopView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = tarbarrossred;
        [self setSubView];
    }
    return self;
}
-(void)setSubView{
    [self addSubview:self.BrowseLabel];
    [self addSubview:self.FunsLabel];
    [self addSubview:self.RemindBtn];
}
- (void)setRemindIsHidden:(BOOL)hidden {
    [UIView animateWithDuration:0.5 animations:^{
        self.left = hidden?kScreenWidth:0;
    }];
}
-(UILabel *)BrowseLabel{
    if (_BrowseLabel==nil) {
        _BrowseLabel=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20),0, ZOOM6(500), self.frame.size.height)];
        _BrowseLabel.font = [UIFont systemFontOfSize:ZOOM6(24)];
        _BrowseLabel.textColor=[UIColor whiteColor];
        _BrowseLabel.text=@"商品分享浏览数：";
    }
    return _BrowseLabel;
}
-(UILabel *)FunsLabel{
    if (_FunsLabel==nil) {
        _FunsLabel=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(320),0, ZOOM6(300), self.frame.size.height)];
        _FunsLabel.font = [UIFont systemFontOfSize:ZOOM6(24)];
        _FunsLabel.textColor=[UIColor whiteColor];
        _FunsLabel.text=@"累计获得奖励：";
    }
    return _FunsLabel;
}

-(UIButton *)RemindBtn{
    
    if (_RemindBtn==nil) {
        _RemindBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _RemindBtn.frame=CGRectMake(kScreenWidth-ZOOM6(164), 0, ZOOM6(164), self.frame.size.height);
        [_RemindBtn addTarget:self action:@selector(RemindBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_RemindBtn setBackgroundImage:[UIImage imageNamed:@"xianqing"] forState:UIControlStateNormal];
        [_RemindBtn setBackgroundImage:[UIImage imageNamed:@"xianqing"] forState:UIControlStateNormal|UIControlStateHighlighted];
        
//        [_RemindBtn setBackgroundImage:[UIImage imageNamed:@"已开启按钮"] forState:UIControlStateSelected];
//        [_RemindBtn setBackgroundImage:[UIImage imageNamed:@"已开启按钮"] forState:UIControlStateSelected|UIControlStateHighlighted];
        
    }
    return _RemindBtn;
}
-(void)RemindBtnClick{
    if (self.RemindBtnBlock) {
        self.RemindBtnBlock();
    }
}


@end
