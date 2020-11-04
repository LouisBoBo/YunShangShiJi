//
//  MKJCollectionViewCell.m
//  PhotoAnimationScrollDemo
//
//  Created by MKJING on 16/8/9.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "MKJCollectionViewCell.h"
#import "GlobalTool.h"
@implementation MKJCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.heroImageVIew.layer.cornerRadius = 5.0f;
    self.heroImageVIew.layer.masksToBounds = YES;
    self.backView.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    self.backView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backView.layer.shadowOpacity = 0.7;
    self.backView.layer.shadowRadius = 5.0f;
    self.backView.layer.shadowOffset = CGSizeMake(2, 6);
    self.backView.layer.cornerRadius = 15.0;
    self.backView.layer.masksToBounds = YES;
    
    self.vipCardName.textColor = kWiteColor;
    self.vipCardFee.textColor = kWiteColor;
    self.cardContext.textColor = kWiteColor;
    self.cardSubstance.textColor = kWiteColor;
    
    self.vipCardName.font = [UIFont systemFontOfSize:ZOOM6(30)];
    self.vipCardFee.font = [UIFont systemFontOfSize:ZOOM6(30)];
    self.cardContext.font = [UIFont systemFontOfSize:ZOOM6(20)];
    self.cardSubstance.font = [UIFont systemFontOfSize:ZOOM6(20)];
}

@end