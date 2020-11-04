//
//  commendToastView.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/13.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "commendToastView.h"
#import "GlobalTool.h"
@implementation commendToastView

-(instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title
{
    if(self = [super initWithFrame:frame])
    {
        [self creatToastView:title];
    }
    
    return self;
}

- (void)creatToastView:(NSString*)title
{
    self.toastBackView = [[UIView alloc]init];
    self.toastBackView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:self.toastBackView];
    
    UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.toastBackView.frame), CGRectGetHeight(self.toastBackView.frame))];
    titlelab.font = [UIFont systemFontOfSize:ZOOM6(28)];
    titlelab.textColor = RGBCOLOR_I(125, 125, 125);
    titlelab.textAlignment = NSTextAlignmentRight;
    titlelab.text= title;
    [self.toastBackView addSubview:titlelab];
    
    [self performSelector:@selector(dismiss) withObject:self afterDelay:3.0];
}

- (void)dismiss
{
    [self removeFromSuperview];
}
@end
