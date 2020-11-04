//
//  TFQRCodeView.m
//  YunShangShiJi
//
//  Created by 云商 on 15/6/30.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFQRCodeView.h"

@implementation TFQRCodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        [self viewInit];
    }
    return self;
}

- (void)viewInit
{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/5)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height/5, self.frame.size.width, self.frame.size.width)];
    [self addSubview:self.imageView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
