//
//  CircleTagsCell.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2017/2/22.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "CircleTagsCell.h"
#import "TagsCell.h"
@interface CircleTagsCell () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *bottomView;
@end
@implementation CircleTagsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}

- (void)setUI {
    [self.contentView addSubview:self.collectionView];
    [self.contentView addSubview:self.bottomView];
}

- (void)layoutSubviews {
    CGRect frame = CGRectMake(ZOOM6(20), (self.height - ZOOM6(57)) * 0.5, self.width-ZOOM6(20)*2, ZOOM6(57));
    self.collectionView.frame = frame;
    
    CGRect rect = CGRectMake(0, self.height-1, self.width, 1);
    self.bottomView.frame = rect;
}

- (void)setData:(NSArray *)tags {
    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:tags];
    [self.collectionView reloadData];
}

#pragma mark - CollectionView Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TagsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kICCellIdentifier_TagsCell forIndexPath:indexPath];
    BOOL isSelected = indexPath.item == 0? YES : NO;
    [cell setText:self.dataSource[indexPath.item] withSelected:isSelected selectedBackgroundColor:COLOR_ROSERED selectedTextColor:[UIColor whiteColor]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize itemSize = CGSizeZero;
    NSString *text = [NSString stringWithFormat:@"%@", self.dataSource[indexPath.item]];
        itemSize = [TagsCell cellSizeWithObj:text];
    return itemSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return ZOOM6(20);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didSelectedBlock) {
        self.didSelectedBlock(indexPath.item);
    }
}

#pragma maek - Getter
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGRect frame = CGRectMake(0, 0, self.width, self.height);
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.bounces = NO;
        collectionView.scrollsToTop = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.backgroundColor = [UIColor whiteColor];
        [collectionView registerClass:[TagsCell class] forCellWithReuseIdentifier:kICCellIdentifier_TagsCell];
        _collectionView = collectionView;

    }
    return _collectionView;
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UIView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = RGBCOLOR_I(240, 240, 240);
    }
    return _bottomView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
