//
//  RewardCellV.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/9/23.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "RewardCellV.h"
#import "UIView+Masonry_TF.h"
#import "GlobalTool.h"
#import "RewardV.h"

@implementation RewardCellV

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)layoutSubviews
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setupUI];
}

- (void)setupUI
{
    UIImage *image = [UIImage imageNamed:self.model.islingqu?[NSString stringWithFormat:@"RewardCellV_icon_%@monney_lingqu", self.model.money]:[NSString stringWithFormat:@"RewardCellV_icon_%@monney", self.model.money]];
    
    CGRect rect = self.frame;
    CGFloat W = rect.size.width;
    
//    MyLog(@"rect: %@", NSStringFromCGRect(rect));
    
    UILabel *lab1 = [UILabel new];
    lab1.textAlignment = NSTextAlignmentCenter;
    lab1.textColor = RGBCOLOR_I(251, 143, 28);
    lab1.font = kFont6px(28);
//    lab1.backgroundColor = COLOR_RANDOM;
    [self addSubview:lab1];
    
    UILabel *lab2 = [UILabel new];
    lab2.textAlignment = NSTextAlignmentCenter;
    lab2.textColor = RGBCOLOR_I(251, 143, 28);
    lab2.font = kFont6px(28);
//    lab2.backgroundColor = COLOR_RANDOM;
    [self addSubview:lab2];
    
    UIImageView *imageV1 = [UIImageView new];
//    imageV1.backgroundColor = COLOR_RANDOM;
    [self addSubview:imageV1];
    
    UIImageView *imageV2 = [UIImageView new];
//    imageV2.backgroundColor = COLOR_RANDOM;
    [self addSubview:imageV2];
    
    RewardCellLineV *lineV = [[RewardCellLineV alloc] init];
    [self addSubview:lineV];
    
    UILabel *lab3 = [UILabel new];
    lab3.textAlignment = NSTextAlignmentCenter;
    lab3.textColor = RGBCOLOR_I(125, 125, 125);
    lab3.font = kFont6px(28);
//    lab3.backgroundColor = COLOR_RANDOM;
    [self addSubview:lab3];
    
    
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@[self ,lab2, imageV1, imageV2, lineV, lab3]);
        make.size.mas_equalTo(CGSizeMake(W, ZOOM6(30)));
    }];
    
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(W, ZOOM6(30)));
    }];
    
    [imageV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ZOOM6(10), ZOOM6(10)));
    }];
    
    CGFloat imageV2_H = self.model.islingqu? ZOOM6(80): ZOOM6(80);
    [imageV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([UIImage imageConvertWidthWithImage:image fromHeight:imageV2_H], imageV2_H));
    }];
    
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(W, ZOOM6(20)));
    }];
    
    [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(W, ZOOM6(30)));
    }];
    
    [self distributeSpacingVerticallyWith:@[lab1,lab2,imageV1, imageV2, lineV, lab3]];
    
    lab1.text = self.model.number;
    lab2.text = self.model.desText;
    
    imageV1.image = [UIImage imageNamed:@"RewardCellV_sanjiao"];
    imageV2.image = image;
    lab3.text = [NSString stringWithFormat:@"%@元", self.model.money];
    
}


@end

@implementation RewardCellLineV

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
 
    CGFloat radius = rect.size.height*0.5;
    
    CGFloat lineW = (rect.size.width-radius*2)*0.5;
    CGFloat lineH = ZOOM6(3);
    
    CGFloat lineY = (rect.size.height-lineH)*0.5;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, lineH);
    [[UIColor colorWithRed:253/255.0 green:224/255.0 blue:64/255.0 alpha:1] set];
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    CGContextMoveToPoint(ctx, 0, lineY);
    CGContextAddLineToPoint(ctx, lineW, lineY);
    CGContextStrokePath(ctx);
    
    CGContextAddArc(ctx, lineW+radius, radius, radius, 0, 2*M_PI, 0);
    [[UIColor colorWithRed:253/255.0 green:224/255.0 blue:64/255.0 alpha:1] set];
    CGContextDrawPath(ctx, kCGPathStroke); //绘制路径
    
    CGContextMoveToPoint(ctx, lineW+radius*2, lineY);
    CGContextAddLineToPoint(ctx, rect.size.width, lineY);
    [[UIColor colorWithRed:253/255.0 green:224/255.0 blue:64/255.0 alpha:1] set];
    CGContextStrokePath(ctx);
}

@end

