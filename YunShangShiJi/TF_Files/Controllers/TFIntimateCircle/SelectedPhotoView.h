//
//  SelectedPhotoView.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2017/2/18.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedPhotoViewDidSelectItemAtIndexPathBlock)(NSIndexPath *indexPath);
typedef void(^AddPhotoBlock)(NSIndexPath *indexPath);
typedef void(^DeletePhotoBlock)(NSIndexPath *indexPath);
@interface SelectedPhotoView : UIView
@property (assign,nonatomic)BOOL isFirstTag;
@property (nonatomic, strong) UICollectionView *photoCollectionView;
@property (nonatomic, strong) NSMutableArray *imagesData;
@property (nonatomic, strong) NSMutableArray *photoImagesData;
@property (nonatomic, copy) SelectedPhotoViewDidSelectItemAtIndexPathBlock didSelectBlock;
@property (nonatomic, copy) AddPhotoBlock addPhotoBlock;
@property (nonatomic, copy) DeletePhotoBlock deletePhotoBlock;
@property (nonatomic, assign) NSInteger columnCount;        // 列数量
@property (nonatomic, assign, readonly) NSInteger rowCount; // 行数
@property (nonatomic, assign) CGFloat minimumInteritemSpacing; // 中间
@property (nonatomic, assign) NSInteger maxPhotoCount; // 最大数量
- (CGFloat)heightPhotoCollectionView;
- (void)reloadPhotoCollectionViewHeight:(void(^)(CGFloat height))heightBlock;
- (UIImage *)addImage;
@end
