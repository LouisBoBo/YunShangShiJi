//
//  TFStartScoreView.m
//  YunShangShiJi
//
//  Created by 云商 on 15/8/5.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFStartScoreView.h"
#define DafaultStartSize 30
@interface TFStartScoreView ()
{
    UIView *_backView;
    UIView *_foreView;
}

@end


@implementation TFStartScoreView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        [self makeView];
    }
    return self;
}

- (void)awakeFromNib
{
    [self makeView];
    
}

- (void)makeView
{
    [self layoutIfNeeded];
    self.startSize = self.frame.size.height;
    CGFloat space = 2;
    
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (self.startSize+space)*5, self.startSize)];
    [self addSubview:_backView];
    
    _foreView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (self.startSize+space)*5, self.startSize)];

    [self addSubview:_foreView];
    _foreView.clipsToBounds = YES;
    
    for (int i = 0; i<5; i++) {
        UIImageView *backStar = [[UIImageView alloc] initWithFrame:CGRectMake(i*(self.startSize+space), 0, self.startSize, self.startSize)];
        backStar.image = [UIImage imageNamed:@"星_默认"];
        [_backView addSubview:backStar];
        
        UIImageView *foreStar = [[UIImageView alloc] initWithFrame:CGRectMake(i*(self.startSize+space), 0, self.startSize, self.startSize)];
        foreStar.image = [UIImage imageNamed:@"星_选中"];
        [_foreView addSubview:foreStar];
    }
}

- (void)setScore:(float)score
{
    _foreView.frame = CGRectMake(0, 0, (self.startSize+2)*5*(score/5.0), self.startSize);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
