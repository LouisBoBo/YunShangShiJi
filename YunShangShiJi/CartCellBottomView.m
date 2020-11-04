//
//  CartCellBottomView.m
//  YunShangShiJi
//
//  Created by yssj on 16/6/28.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "CartCellBottomView.h"
#import "GlobalTool.h"

@implementation CartCellBottomView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self setSubView];
    }
    return self;
}
-(void)setSubView{
    self.bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(100))];
    _bottomLabel=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(54), 0, kScreenWidth, _bottomView.frame.size.height)];
    _bottomLabel.textColor=kMainTitleColor;
//    _bottomLabel.backgroundColor=tarbarrossred;
    
    _bottomBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _bottomBtn.frame=CGRectMake(kScreenWidth-ZOOM(35)-ZOOM6(180),CGRectGetHeight(_bottomView.frame)/2-ZOOM6(60)/2, ZOOM6(180),ZOOM6(60));
    [_bottomBtn setTitle:@"重新加入" forState:UIControlStateNormal];
    [_bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_bottomBtn setTintColor:tarbarrossred];
    _bottomBtn.layer.borderWidth=1;
    _bottomBtn.layer.borderColor=tarbarrossred.CGColor;
    _bottomBtn.layer.cornerRadius=3;

    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, _bottomView.frame.size.height-1, kScreenWidth, 1)];
    line.backgroundColor=kBackgroundColor;
    [_bottomView addSubview:line];
    
    [self addSubview:_bottomView];
    [self addSubview:_bottomLabel];
    [self addSubview:_bottomBtn];
}
-(void)bottomBtnClick{
    if (self.bottomBtnBlock) {
        self.bottomBtnBlock();
    }
}
@end
