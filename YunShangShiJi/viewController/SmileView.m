//
//  SmileView.m
//  YunShangShiJi
//
//  Created by yssj on 15/8/8.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "SmileView.h"
#define SN ([UIScreen mainScreen].bounds.size.width)/(1080)
#define ZOOM(px) ((px)*(SN))

@implementation SmileView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {

    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    
    //agafsdga");

    
    self.backgroundColor = [UIColor whiteColor];
//    self.frame = rect;
    
    _smileImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-35, self.frame.size.height/2-70, 64, 56)];
    //    smileView.center = CGPointMake(kApplicationWidth/2, 100);
    _smileImg.image = [UIImage imageNamed:@"表情"];
    _smileImg.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_smileImg];
    
    _thanksLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2-150, _smileImg.frame.origin.y+_smileImg.frame.size.height+30, 300, 30)];
    _thanksLabel.text = self.str;
    _thanksLabel.textColor = [UIColor lightGrayColor];
    [_thanksLabel setFont:[UIFont systemFontOfSize:16]];
    _thanksLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_thanksLabel];
    
    
    _remindLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2-150,  _thanksLabel.frame.origin.y+_thanksLabel.frame.size.height, 300, 30)];
    _remindLabel.textColor = [UIColor lightGrayColor];
    _remindLabel.text = self.str2;
    [_remindLabel setFont:[UIFont systemFontOfSize:16]];
    _remindLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_remindLabel];

}
-(void)addview:(UIView *)view
{
    //2222");
    view.frame = CGRectMake(ZOOM(150),self.frame.size.height/2+80 , self.frame.size.width-ZOOM(150)*2, view.frame.size.height);
    
    [self addSubview:view];
}
@end
