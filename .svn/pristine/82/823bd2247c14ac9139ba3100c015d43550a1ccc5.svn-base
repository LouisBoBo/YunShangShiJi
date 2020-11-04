//
//  TFWarningView.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/22.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFWarningView.h"

@interface TFWarningView ()

@property (nonatomic, strong)UIView *whiteView;

@end


@implementation TFWarningView
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        [self viewInit];
    }
    return self;
}

- (void)returnBlock:(warningBlock)block
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];
    
    self.block = block;

}

- (void)viewInit
{
    self.backgroundColor =  [[UIColor blackColor] colorWithAlphaComponent:0.8];
    self.whiteView = [[UIView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame)-ZOOM(956))/2.0, (self.frame.size.height-HEIGHT(120))/2, ZOOM(956), ZOOM(624))];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    self.whiteView.center = CGPointMake(CGRectGetWidth(self.frame)/2.0, CGRectGetHeight(self.frame)*0.382);
    [self addSubview:self.whiteView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ZOOM(100), self.whiteView.frame.size.width, ZOOM(224))];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = @"确定删除收货地址,此操作不可逆";
    self.titleLabel.textColor = COLOR_34;
    self.titleLabel.font = TF_FONT(50);
    [self.whiteView addSubview:self.titleLabel];
    
    CGFloat Margin_lr = (CGRectGetWidth(self.whiteView.frame)/2.0-ZOOM(280))/2.0;
    CGFloat y = CGRectGetHeight(self.whiteView.frame)/2.0+(CGRectGetHeight(self.whiteView.frame)/2.0-ZOOM(100))/2.0;
    CGFloat w = ZOOM(280);
    CGFloat h = ZOOM(100);
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(CGRectGetWidth(self.whiteView.frame)/2.0-w-ZOOM(33), y, w, h);
    self.leftBtn.tag = 100;
    [self.leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn.backgroundColor = COLOR_22;
    [self.whiteView addSubview:self.leftBtn];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(CGRectGetWidth(self.whiteView.frame)/2.0+ZOOM(33), y, w, h);
    [self.rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.rightBtn.tag = 101;
    self.rightBtn.backgroundColor = COLOR_22;
    [self.rightBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.whiteView addSubview:self.rightBtn];

}

- (void)btnClick:(UIButton *)sender
{
    if (sender.tag == 100) {
        [self removeFromSuperview];
    } else if (sender.tag == 101) {
        if (self.block!=nil) {
            self.block(@"1");
            [self removeFromSuperview];
        }
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
