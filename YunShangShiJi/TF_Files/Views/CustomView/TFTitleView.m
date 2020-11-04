//
//  TFTitleView.m
//  YunShangShiJi
//
//  Created by 云商 on 15/6/30.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFTitleView.h"


@implementation TFTitleView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        [self viewInit];
    }
    return self;
}

- (void)viewInit
{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((20), 0, (200), self.bounds.size.height)];
//    self.titleLabel.backgroundColor = [UIColor redColor];
    [self addSubview:self.titleLabel];
    
    self.backgroundColor = RGBCOLOR_I(244,244,244);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
