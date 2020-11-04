//
//  SelectedPhotoView.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2017/2/18.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "SelectedPhotoView.h"
#import "GlobalTool.h"
#pragma mark - Cell


#define kCellId_SelectedPhotoCell @"SelectedPhotoCell"

typedef void(^DeleteBlock)(NSIndexPath *indexPath);
@interface SelectedPhotoCell : UICollectionViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, copy) DeleteBlock deleteBlock;
@property (nonatomic, strong) UIButton *deleteButton;
@end

@implementation SelectedPhotoCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.deleteButton];
}

- (void)layoutSubviews {
    self.imageView.frame = CGRectMake(0, 0, self.width, self.height);
    self.deleteButton.frame = CGRectMake(self.width - ZOOM6(50) - ZOOM6(10), ZOOM6(10), ZOOM6(50), ZOOM6(50));
}

+ (CGSize)cellSizeWithColumnCount:(NSInteger)columnCount contentWidth:(CGFloat)contentWidth marginWidth:(CGFloat)marginWidth {
    CGSize size = CGSizeZero;
    if (!columnCount) {
        return size;
    }
    size.width = (contentWidth - (columnCount-1) * marginWidth) /columnCount;
    size.height = size.width;
    return size;
}

#pragma mark - Getter
- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(0, 0, self.width, self.height);
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (UIButton *)deleteButton {
    if (_deleteButton == nil) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setBackgroundImage:[UIImage imageNamed:@"miyou_icon_del"] forState:UIControlStateNormal];
        _deleteButton.frame = CGRectMake(self.width - ZOOM6(50), 0, ZOOM6(50), ZOOM6(50));
        [_deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

- (void)deleteButtonClick {
    if (self.deleteBlock) {
        self.deleteBlock(self.indexPath);
    }
}

@end

#pragma mark - View
@interface SelectedPhotoView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, assign, readwrite) NSInteger rowCount;
@end

@implementation SelectedPhotoView
- (void)dealloc
{
    MyLog(@"%@ release", [self class]);
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    [self addSubview:self.photoCollectionView];
    [self.photoCollectionView reloadData];
}

- (CGFloat)heightPhotoCollectionView {
    CGFloat height = 0;
    if (self.columnCount == 0) {
        self.rowCount = 0;
        return height;
    }
    if (self.imagesData.count >= 1) {
        self.rowCount = ((self.imagesData.count - 1) / ( self.columnCount) + 1);
        CGFloat  W_H_cell = ((self.width - (self.columnCount - 1) * self.minimumInteritemSpacing) / self.columnCount);
        height = W_H_cell * self.rowCount + (self.rowCount- 1) * self.minimumInteritemSpacing;
    }
    return height;
}

- (void)layoutSubviews {
    CGRect frame = CGRectMake(0, 0, self.width, self.height);
    self.photoCollectionView.frame = frame;
}

#pragma mark - Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.imagesData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SelectedPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellId_SelectedPhotoCell forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.imageView.image = self.imagesData[indexPath.item];
    
    kSelfWeak;
    cell.deleteBlock = ^(NSIndexPath *currIndex) {
        [weakSelf.imagesData removeObjectAtIndex:currIndex.item];
        if (weakSelf.photoImagesData.count == weakSelf.maxPhotoCount) {
            [weakSelf.imagesData addObject:[weakSelf addImage]];
        }
        [weakSelf.photoImagesData removeObjectAtIndex:currIndex.item];
        
//        [self reloadPhotoCollectionViewHeight:^(CGFloat height) {
//            
//        }];
        if (weakSelf.deletePhotoBlock) {
            weakSelf.deletePhotoBlock(indexPath);
        }
    };
    
    if (self.photoImagesData.count < self.maxPhotoCount) {
        if (indexPath.item == self.imagesData.count - 1)
        {
            cell.deleteButton.hidden = YES;
        } else {
            cell.deleteButton.hidden = NO;
        }
    } else {
        cell.deleteButton.hidden = NO;
    }
    if (self.isFirstTag&&indexPath.item==0)//第一个隐藏删除按钮
        cell.deleteButton.hidden = YES;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize itemSize = CGSizeZero;
    itemSize = [SelectedPhotoCell cellSizeWithColumnCount:self.columnCount contentWidth:self.width marginWidth:self.minimumInteritemSpacing];
    return itemSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.minimumInteritemSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.minimumInteritemSpacing;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.photoImagesData.count < self.maxPhotoCount) {
        if (indexPath.item == self.imagesData.count - 1) { // 最后 +
            if (self.addPhotoBlock) {
                self.addPhotoBlock(indexPath);
            }
        } else {
            if (self.didSelectBlock) {
                self.didSelectBlock(indexPath);
            }
        }
    } else {
        if (self.didSelectBlock) {
            self.didSelectBlock(indexPath);
        }
    }
}


- (void)reloadPhotoCollectionViewHeight:(void(^)(CGFloat height))heightBlock {
    CGFloat height = [self heightPhotoCollectionView];
    self.height = height;
    [self setNeedsLayout];
    
    if (heightBlock) {
        heightBlock(self.height);
    }
    [self.photoCollectionView reloadData];
}

#pragma mark - Getter
- (UICollectionView *)photoCollectionView {
    if (_photoCollectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGRect frame = CGRectMake(0, 0, self.width, self.height);
        
        UICollectionView *photoCollectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        photoCollectionView.dataSource = self;
        photoCollectionView.delegate = self;
        photoCollectionView.showsVerticalScrollIndicator = NO;
        photoCollectionView.bounces = NO;
        photoCollectionView.scrollsToTop = NO;
        photoCollectionView.scrollEnabled = NO;
        photoCollectionView.backgroundColor = [UIColor whiteColor];
        [photoCollectionView registerClass:[SelectedPhotoCell class] forCellWithReuseIdentifier:kCellId_SelectedPhotoCell];
        _photoCollectionView = photoCollectionView;
    }
    return _photoCollectionView;
}

- (NSMutableArray *)imagesData {
    if (_imagesData == nil) {
        _imagesData = [NSMutableArray array];
        [_imagesData addObject:[self addImage]];
    }
    return _imagesData;
}

- (UIImage *)addImage {
    UIImage *addImage = [UIImage imageNamed:@"miyou_+"];
    return addImage;
}

- (NSMutableArray *)photoImagesData {
    if (_photoImagesData == nil) {
        _photoImagesData = [NSMutableArray array];
    }
    return _photoImagesData;
}

@end
