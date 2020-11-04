//
//  MKJCollectionViewCell.h
//  PhotoAnimationScrollDemo
//
//  Created by MKJING on 16/8/9.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MKJCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *heroImageVIew;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *vipCardName;
@property (weak, nonatomic) IBOutlet UILabel *vipCardFee;
@property (weak, nonatomic) IBOutlet UILabel *cardContext;
@property (weak, nonatomic) IBOutlet UILabel *cardSubstance;

@end