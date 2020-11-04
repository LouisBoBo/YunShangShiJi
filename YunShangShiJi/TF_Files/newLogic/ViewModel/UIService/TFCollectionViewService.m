//
//  TFCollectionViewService.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/6.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFCollectionViewService.h"
#import "WaterFlowCell.h"
#import "GlobalTool.h"
@implementation TFCollectionViewService

#pragma mark Block
- (void)didSelectItemAtIndexPathBlock:(DidSelectItemAtIndexPathBlock)didSelectItemAtIndexPathBlock
{
    self.didSelectItemAtIndexPathBlock = didSelectItemAtIndexPathBlock;
}

- (void)numberOfItemsInSectionBlock:(NumberOfItemsInSectionBlock)numberOfItemsInSectionBlock
{
    self.numberOfItemsInSectionBlock = numberOfItemsInSectionBlock;
}

- (void)cellForItemAtIndexPathBlock:(CellForItemAtIndexPathBlock)cellForItemAtIndexPathBlock
{
    self.cellForItemAtIndexPathBlock = cellForItemAtIndexPathBlock;
}

- (void)sizeForItemAtIndexPathBlock:(SizeForItemAtIndexPathBlock)sizeForItemAtIndexPathBlock
{
    self.sizeForItemAtIndexPathBlock = sizeForItemAtIndexPathBlock;
}

#pragma mark - UICollectionView Delegate / DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (self.viewForSupplementaryElementOfKindAtIndexPathBlock) {
        return self.viewForSupplementaryElementOfKindAtIndexPathBlock(collectionView, kind,indexPath);
    }
    return [UICollectionReusableView new];
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section{
    if (self.heightForHeaderInSectionBlock) {
        return self.heightForHeaderInSectionBlock(collectionView,collectionViewLayout,section);
    }
    return 0;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    if (self.numberOfItemsInSectionBlock) {
        return self.numberOfItemsInSectionBlock(collectionView, section);
    }
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.cellForItemAtIndexPathBlock) {
        return self.cellForItemAtIndexPathBlock(collectionView, indexPath);
    } else {
        WaterFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WATERFLOWCELLID" forIndexPath:indexPath];
        cell.selectBtn.hidden = YES;
        cell.flag = self.flag;
        if (self.dataSource.count>indexPath.item) {
            [cell receiveDataModel2:self.dataSource[indexPath.item]];
        }
        return cell;
    }
}

//大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.sizeForItemAtIndexPathBlock) {
        
        return self.sizeForItemAtIndexPathBlock(collectionView, collectionViewLayout, indexPath);
    } else {
        CGFloat imgH = 900;
        CGFloat imgW = 600;
        
        CGFloat W = (kScreenWidth-18)/2.0;
        CGFloat H = imgH*W/imgW; //
        CGSize size = CGSizeMake(W, H+5);
        return size;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.didSelectItemAtIndexPathBlock) {
        self.didSelectItemAtIndexPathBlock(collectionView, indexPath);
    }
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
