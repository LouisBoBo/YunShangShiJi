//
//  TopRemindView.m
//  YunShangShiJi
//
//  Created by yssj on 16/6/30.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TopRemindView.h"
#import "GlobalTool.h"

@implementation TopRemindView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.7];
        [self setSubView];
    }
    return self;
}
-(void)setSubView{
    [self addSubview:self.RemindLabel];
    [self addSubview:self.RemindBtn];
}
- (void)setRemindIsHidden:(BOOL)hidden {    
    [UIView animateWithDuration:0.5 animations:^{
        self.left = hidden?kScreenWidth:0;
    }];
}
-(UILabel *)RemindLabel{
    if (_RemindLabel==nil) {
        _RemindLabel=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20),0, kScreenWidth, self.frame.size.height)];
        _RemindLabel.font = [UIFont systemFontOfSize:ZOOM6(24)];
        _RemindLabel.textColor=[UIColor whiteColor];
        _RemindLabel.text=@"";
    }
    return _RemindLabel;
}
-(UIButton *)RemindBtn{
    
    if (_RemindBtn==nil) {
        _RemindBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _RemindBtn.frame=CGRectMake(kScreenWidth-ZOOM6(164), 0, ZOOM6(164), self.frame.size.height);
        [_RemindBtn addTarget:self action:@selector(RemindBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_RemindBtn setBackgroundImage:[UIImage imageNamed:@"立即开启按钮"] forState:UIControlStateNormal];
        [_RemindBtn setBackgroundImage:[UIImage imageNamed:@"立即开启按钮"] forState:UIControlStateNormal|UIControlStateHighlighted];
        
        [_RemindBtn setBackgroundImage:[UIImage imageNamed:@"已开启按钮"] forState:UIControlStateSelected];
        [_RemindBtn setBackgroundImage:[UIImage imageNamed:@"已开启按钮"] forState:UIControlStateSelected|UIControlStateHighlighted];
    
    }
    return _RemindBtn;
}
-(void)RemindBtnClick{
    if (self.RemindBtnBlock) {
        self.RemindBtnBlock();
    }
}
@end
