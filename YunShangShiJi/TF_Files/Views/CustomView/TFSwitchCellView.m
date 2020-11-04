//
//  TFSwitchCellView.m
//  YunShangShiJi
//
//  Created by 云商 on 15/6/30.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFSwitchCellView.h"

@implementation TFSwitchCellView
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        [self viewInit];
    }
    return self;
}

- (void)viewInit
{
    CGFloat ud_Margin = ZOOM(52);
    CGFloat lr_Margin = ZOOM(62);
    
    CGFloat label_H = ZOOM(50);
    
    CGFloat sw_W = ZOOM(170);
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(lr_Margin, ud_Margin, CGRectGetWidth(self.frame)-lr_Margin*2-sw_W, label_H)];
    [self addSubview:self.titleLabel];
    self.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
    self.titleLabel.textColor = RGBCOLOR_I(34,34,34);
    
    self.subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height+ZOOM(10), self.titleLabel.frame.size.width, self.frame.size.height-CGRectGetMaxY(self.titleLabel.frame)-ud_Margin-ZOOM(10))];
    self.subTitleLabel.font = [UIFont systemFontOfSize:ZOOM(36)];
    self.subTitleLabel.textColor = RGBCOLOR_I(137,137,137);
    [self addSubview:self.subTitleLabel];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-1, self.bounds.size.width, 1)];
    self.lineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self addSubview:self.lineView];
}

- (void)setImageOrSwitch:(BOOL)bl
{
    if (bl) {
        self.rightSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.frame.size.width-ZOOM(62)-ZOOM(170), (self.frame.size.height-31)/2, 0, 0)];
        [self addSubview:self.rightSwitch];
        //设置打开状态下的渲染色
        self.rightSwitch.onTintColor = [UIColor greenColor];
        //设置关闭状态下的渲染色
        self.rightSwitch.tintColor = [UIColor grayColor];
    } else {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.userInteractionEnabled = YES;
        self.cellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cellBtn.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self addSubview:self.cellBtn];
        [self addSubview:self.imageView];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
