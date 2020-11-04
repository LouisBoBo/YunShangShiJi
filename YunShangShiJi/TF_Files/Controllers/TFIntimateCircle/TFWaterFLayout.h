//
//  TFWaterFLayout.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2017/2/18.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString *const TFWaterFallSectionHeader;
extern NSString *const TFWaterFallSectionFooter;
#pragma mark WaterF
@protocol TFWaterFLayoutDelegate <UICollectionViewDelegate>
@required
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
@optional

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section;

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForFooterInSection:(NSInteger)section;
@end

@interface TFWaterFLayout : UICollectionViewLayout

@property (nonatomic, assign) NSInteger columnCount;

@property (nonatomic, assign) CGFloat minimumColumnSpacing;

@property (nonatomic, assign) CGFloat minimumInteritemSpacing;

@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, assign) CGFloat footerHeight;

@property (nonatomic, assign) UIEdgeInsets sectionInset;



@end
