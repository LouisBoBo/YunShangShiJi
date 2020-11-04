//
//  MKJMainPopoutView.m
//  PhotoAnimationScrollDemo
//
//  Created by MKJING on 16/8/9.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "MKJMainPopoutView.h"
#import "MKJConstant.h"
#import "NSArray+Extension.h"
#import "UIView+Extension.h"
#import "MKJCollectionViewCell.h"
#import "MKJCollectionViewFlowLayout.h"
#import "MKJItemModel.h"
#import "MKJCircleLayout.h"
#import "MKJOverLayLayout.h"
#import "GlobalTool.h"

@interface MKJMainPopoutView () <UICollectionViewDelegate,UICollectionViewDataSource,MKJCollectionViewFlowLayoutDelegate>

@property (nonatomic,strong) UIView *underBackView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,assign) NSInteger selectedIndex; // 选择了哪个
@property (nonatomic,assign) NSInteger normalSelectIndex; //进来默认选择第几个
@property (nonatomic,strong) UIButton *transformLayoutButton;
@property (nonatomic,strong) NSMutableArray *datas;
@end

static NSString *indentify = @"MKJCollectionViewCell";

@implementation MKJMainPopoutView
{
    NSInteger _selectedIndex;
}

// self是继承于UIView的，给上面的第一个View容器加个动画
- (void)showInSuperView:(UIView *)superView
{
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.25;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1f, 0.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)]];
    popAnimation.keyTimes = @[@0.2f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [superView addSubview:self];
    [self.underBackView.layer addAnimation:popAnimation forKey:nil];
}

- (void)refreshSelectIndex:(NSInteger)selectIndex;
{
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:selectIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    
    [self.collectionView reloadData];
}
// 初始化 设置背景颜色透明点，然后加载子视图
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        _selectedIndex = 0;
        self.backgroundColor =RGBCOLOR_I(247, 247, 247);
        [self addsubviews];
    }
    return self;
}

// 加载子视图
- (void)addsubviews
{
    [self addSubview:self.underBackView];
    [self.underBackView addSubview:self.collectionView];
}

#pragma makr - collectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MKJItemModel *model = self.datas[indexPath.item];
    MKJCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indentify forIndexPath:indexPath];

    [cell.heroImageVIew sd_setImageWithURL:[NSURL URLWithString:model.imageName]];
    cell.vipCardName.text = model.titleName;
    cell.vipCardFee.text = model.cardFee;
    cell.cardContext.text = model.context;
    cell.cardSubstance.text = model.substance;
    return cell;
}

// 点击item的时候
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",indexPath);
    if ([self.collectionView.collectionViewLayout isKindOfClass:[MKJCollectionViewFlowLayout class]]) {
        CGPoint pInUnderView = [self.underBackView convertPoint:collectionView.center toView:collectionView];
        
        // 获取中间的indexpath
        NSIndexPath *indexpathNew = [collectionView indexPathForItemAtPoint:pInUnderView];
        
        if (indexPath.row == indexpathNew.row)
        {
            NSLog(@"点击了同一个");
            return;
        }
        else
        {
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            self.selectedIndex = indexPath.row;
            [self scrollViewDidEndScroll];
        }
    }
    else if ([self.collectionView.collectionViewLayout isKindOfClass:[MKJCircleLayout class]])
    {
        _selectedIndex = 0;
        [self.datas removeObjectAtIndex:indexPath.item];
        [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    }
    else
    {
        
    }
}


#pragma mark - 懒加载
- (UIView *)underBackView
{
    if (_underBackView == nil) {
        _underBackView = [[UIView alloc] init];
        _underBackView.backgroundColor = RGBCOLOR_I(247, 247, 247);
        _underBackView.originX = 0;
        _underBackView.originY = 0;
        _underBackView.width = SCREEN_WIDTH - 2 * _underBackView.originX;
        _underBackView.height = 250;
        _underBackView.layer.cornerRadius = 5;
    }
    return _underBackView;
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        MKJCollectionViewFlowLayout *flow = [[MKJCollectionViewFlowLayout alloc] init];
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flow.itemSize = CGSizeMake(self.underBackView.width -180, self.underBackView.height-120);
        flow.minimumLineSpacing = 30;
        flow.minimumInteritemSpacing = 30;
        flow.needAlpha = YES;
        flow.delegate = self;
        CGFloat oneX =self.underBackView.width / 4;
        flow.sectionInset = UIEdgeInsetsMake(0, oneX, 0, oneX);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.underBackView.bounds.size.width, self.underBackView.bounds.size.height) collectionViewLayout:flow];
        _collectionView.backgroundColor = RGBCOLOR_I(247, 247, 247);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerNib:[UINib nibWithNibName:indentify bundle:nil] forCellWithReuseIdentifier:indentify];
    }
    return _collectionView;
}


#pragma CustomLayout的代理方法
- (void)collectioViewScrollToIndex:(NSInteger)index
{
    _selectedIndex = index;

    NSLog(@"*********这是第%zd个************",index);
}

// 第一次加载的时候刷新collectionView
- (void)setDataSource:(NSArray *)dataSource
{
    _dataSource = dataSource;
    self.datas = [[NSMutableArray alloc] initWithArray:self.dataSource];
    
//    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:self.normalSelectIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
//
//    [self.collectionView reloadData];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 停止类型1、停止类型2
    BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging &&    !scrollView.decelerating;
    if (scrollToScrollStop) {
        [self scrollViewDidEndScroll];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        // 停止类型3
        BOOL dragToDragStop = scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
        if (dragToDragStop) {
            [self scrollViewDidEndScroll];
        }
    }
}

#pragma mark - scrollView 停止滚动监测
- (void)scrollViewDidEndScroll {
    if(self.selectBlock)
    {
        self.selectBlock(_selectedIndex);
    }
}
@end
