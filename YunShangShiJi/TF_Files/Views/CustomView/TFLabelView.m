//
//  TFLabelView.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/22.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFLabelView.h"

@implementation TFLabelView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        [self viewInit];
    }
    return self;
}

- (void)viewInit
{
    CGFloat Margin_lr = ZOOM(62);
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(Margin_lr, 0, ZOOM(300), self.frame.size.height-1)];
    [self addSubview:self.titleLabel];
    
    self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake( self.titleLabel.right+ZOOM(10), 0, self.frame.size.width- self.titleLabel.right-ZOOM(10)-Margin_lr, self.frame.size.height-1)];
    [self addSubview:self.detailLabel];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-1, self.bounds.size.width, 0.5)];
    self.lineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self addSubview:self.lineView];
    
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:self.btn];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
