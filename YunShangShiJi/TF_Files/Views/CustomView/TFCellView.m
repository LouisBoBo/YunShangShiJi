//
//  TFCellView.m
//  YunShangShiJi
//
//  Created by 云商 on 15/6/30.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFCellView.h"


@implementation TFCellView
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        [self viewInit];
    }
    return self;
}


- (void)viewInit
{
    self.headImageView = [[UIImageView alloc] init];
    self.headImageView.userInteractionEnabled = YES;
    [self addSubview:self.headImageView];
    
    self.titleLabel = [[UILabel alloc] init];
    [self addSubview:self.titleLabel];
    
    self.detailImageView = [[UIImageView alloc] init];
    self.detailImageView.userInteractionEnabled = YES;
    self.detailImageView.contentMode=UIViewContentModeScaleAspectFit;
    [self addSubview:self.detailImageView];
    
    self.cellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cellBtn.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [self addSubview:self.cellBtn];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-1, self.bounds.size.width, 1)];
    self.lineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self addSubview:self.lineView];
}

@end
