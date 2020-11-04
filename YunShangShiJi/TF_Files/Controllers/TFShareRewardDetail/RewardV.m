//
//  RewardV.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/9/23.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "RewardV.h"
#import "GlobalTool.h"
#import "RewardCellV.h"
@implementation RewardV

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        [self setupUI];
    }
    return self;
}
- (instancetype)init
{
    if (self = [super init]) {
//        [self setupUI];
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
    CGRect rect = self.frame;
//    MyLog(@"rect: %@", NSStringFromCGRect(rect));
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = kFont6px(32);
    titleLabel.textColor = RGBCOLOR_I(62, 62, 62);
    titleLabel.text = self.titleText;
    //    titleLabel.backgroundColor = COLOR_RANDOM;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(ZOOM6(330), ZOOM6(40)));
    }];
    
    UIImage *left_image = [UIImage imageNamed:@"RewardCellV_right"];
    CGFloat imageV_W = (rect.size.width-ZOOM6(330)) * 0.5;
    CGFloat imageV_H = [UIImage imageConvertHeightWithImage:left_image fromWidth:imageV_W];
    UIImageView *left_imageV = [UIImageView new];
    left_imageV.image = left_image;
    [self addSubview:left_imageV];
    [left_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLabel.mas_centerY);
        make.right.equalTo(titleLabel.mas_left);
        make.height.mas_equalTo(imageV_H);
        make.left.equalTo(self.mas_left);
    }];
    
    UIImage *right_image = [UIImage imageNamed:@"RewardCellV_left"];
    CGFloat imageV_W2 = (rect.size.width-ZOOM6(330)) * 0.5;
    CGFloat imageV_H2 = [UIImage imageConvertHeightWithImage:right_image fromWidth:imageV_W2];
    UIImageView *right_imageV = [UIImageView new];
    right_imageV.image = right_image;
    [self addSubview:right_imageV];
    [right_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLabel.mas_centerY);
        make.left.equalTo(titleLabel.mas_right);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(imageV_H2);
    }];
    
    CGFloat W = 0;
    CGFloat H = rect.size.height- ZOOM6(40) - ZOOM6(30);
    if (self.cellItemArray.count) {
        W = rect.size.width/self.cellItemArray.count;
        RewardCellV *lastV = nil;
        for (int i = 0; i<self.cellItemArray.count; i++) {
            RewardCellV *cellV = [[RewardCellV alloc] init];
            cellV.model = self.cellItemArray[i];
            [self addSubview:cellV];
            
            if (!lastV) {
                [cellV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.mas_left);
                    make.bottom.equalTo(self.mas_bottom);
                    make.size.mas_equalTo(CGSizeMake(W, H));
                }];
            } else {
                [cellV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(lastV.mas_right);
                    make.bottom.equalTo(self.mas_bottom);
                    make.size.mas_equalTo(CGSizeMake(W, H));
                    
                }];
            }
            lastV = cellV;
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

@implementation RewardM

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end

