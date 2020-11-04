//
//  TFCollectionViewService.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/6.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DidSelectItemAtIndexPathBlock)(UICollectionView *collectionView, NSIndexPath *indexPath);
typedef NSInteger(^NumberOfItemsInSectionBlock)(UICollectionView *collectionView, NSInteger section);
typedef UICollectionViewCell *(^CellForItemAtIndexPathBlock)(UICollectionView *collectionView, NSIndexPath *indexPath);
typedef CGSize(^SizeForItemAtIndexPathBlock)(UICollectionView *collectionView, UICollectionViewLayout *collectionViewLayout, NSIndexPath *indexPath);
typedef UICollectionReusableView *(^ViewForSupplementaryElementOfKindAtIndexPathBlock)(UICollectionView *collectionView,NSString *kind, NSIndexPath *indexPath);
typedef CGFloat(^HeightForHeaderInSectionBlock)(UICollectionView *collectionView,UICollectionViewLayout *collectionViewLayout, NSInteger section);


@interface TFCollectionViewService : NSObject <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy) NSString *flag;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIViewController *currViewController;

@property (nonatomic, copy) DidSelectItemAtIndexPathBlock didSelectItemAtIndexPathBlock;
@property (nonatomic, copy) NumberOfItemsInSectionBlock numberOfItemsInSectionBlock;
@property (nonatomic, copy) CellForItemAtIndexPathBlock cellForItemAtIndexPathBlock;
@property (nonatomic, copy) SizeForItemAtIndexPathBlock sizeForItemAtIndexPathBlock;
@property (nonatomic, copy) ViewForSupplementaryElementOfKindAtIndexPathBlock viewForSupplementaryElementOfKindAtIndexPathBlock;
@property (nonatomic, copy) HeightForHeaderInSectionBlock heightForHeaderInSectionBlock;

- (void)didSelectItemAtIndexPathBlock:(DidSelectItemAtIndexPathBlock)didSelectItemAtIndexPathBlock;
- (void)numberOfItemsInSectionBlock:(NumberOfItemsInSectionBlock)numberOfItemsInSectionBlock;
- (void)cellForItemAtIndexPathBlock:(CellForItemAtIndexPathBlock)cellForItemAtIndexPathBlock;
- (void)sizeForItemAtIndexPathBlock:(SizeForItemAtIndexPathBlock)sizeForItemAtIndexPathBlock;
@end
