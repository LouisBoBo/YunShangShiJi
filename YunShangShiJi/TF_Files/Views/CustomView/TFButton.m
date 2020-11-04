//
//  TFButton.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/7.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFButton.h"
 
@implementation TFButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
    [self addSubview:self.lineView];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        self.lineView.backgroundColor = COLOR_ROSERED;
        self.lineView.hidden = NO;
    } else {
        self.lineView.hidden = YES;
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
