//
//  starView.m
//  YunShangShiJi
//
//  Created by yssj on 15/10/16.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "StarsView.h"

#define DafaultStartSize 30
@interface StarsView ()
{
    UIView *_backView;
    UIView *_foreView;
}

@end

@implementation StarsView


- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        [self makeView];
    }
    return self;
}

//- (void)awakeFromNib
//{
//    [self makeView];
//    
//}

- (void)makeView
{
    self.startSize = self.frame.size.height;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    
    [self addGestureRecognizer:tap];
    
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.startSize*5, self.startSize)];
    [self addSubview:_backView];
    
    _foreView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.startSize*5, self.startSize)];
    
    [self addSubview:_foreView];
    _foreView.clipsToBounds = YES;
    
    for (int i = 0; i<5; i++) {
        UIImageView *backStar = [[UIImageView alloc] initWithFrame:CGRectMake(i*(self.startSize+3), 0, self.startSize, self.startSize)];
        backStar.image = [UIImage imageNamed:@"星_默认"];
        [_backView addSubview:backStar];
        UIImageView *foreStar = [[UIImageView alloc] initWithFrame:CGRectMake(i*(self.startSize+3), 0, self.startSize, self.startSize)];
        foreStar.image = [UIImage imageNamed:@"星_选中"];
        [_foreView addSubview:foreStar];
    }
}
-(void)tap:(UITapGestureRecognizer *)gesture{
    if(self.enable){
        
        CGPoint point = [gesture locationInView:self];
        int count = (int)(point.x/(self.startSize+3))+1;
        _num=count;
        _foreView.frame = CGRectMake(0, 0, (self.startSize+3)*count, self.startSize);
      
//        [self setScore:2];
        
    }
}
- (void)setScore:(float)score
{
    _foreView.frame = CGRectMake(0, 0, (self.startSize+3)*5*(score/5.0), self.startSize);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
