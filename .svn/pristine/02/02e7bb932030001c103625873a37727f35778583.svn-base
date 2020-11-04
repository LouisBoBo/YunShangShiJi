//
//  HBCollectionViewFlowLayout.h
//  YunShangShiJi
//
//  Created by ios-1 on 2016/12/2.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
UIKIT_EXTERN NSString *const UICollectionElementKindSectionHeader;
UIKIT_EXTERN NSString *const UICollectionElementKindSectionFooter;

@class HBCollectionViewFlowLayout;
@protocol HBCollectionViewFlowLayoutDelegate <NSObject>
@required
//item heigh
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(HBCollectionViewFlowLayout*)collectionViewLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath*)indexPath;

@optional
//section header
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(HBCollectionViewFlowLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
//section footer
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(HBCollectionViewFlowLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;
@end

@interface HBCollectionViewFlowLayout : UICollectionViewFlowLayout

@property(nonatomic, assign)UIEdgeInsets sectionInset; //sectionInset
@property(nonatomic, assign)CGFloat lineSpacing;  //line space
@property(nonatomic, assign)CGFloat itemSpacing; //item space
@property(nonatomic, assign)CGFloat colCount; //column count
@property(nonatomic, weak)id<HBCollectionViewFlowLayoutDelegate> delegate;
@end
