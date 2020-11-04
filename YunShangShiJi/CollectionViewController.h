//
//  CollectionViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/9/6.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleScrollView.h"

@protocol collectionViewCustomDelegate <NSObject>

- (void)collectionViewPullDownRefreshWithIndex:(int)index;

- (void)collectionViewWithScrollViewWillBeginDragging:(UIScrollView *)scrollView index:(int)index;
- (void)collectionViewWithScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate index:(int)index;
- (void)collectionViewWithScrollViewWillBeginDecelerating:(UIScrollView *)scrollView index:(int)index;
- (void)collectionViewWithscrollViewDidEndDecelerating:(UIScrollView *)scrollView index:(int)index;

@end

@interface CollectionViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, copy)NSString *fromType;

//是否有头部
@property (nonatomic ,assign)BOOL isHeadView;

@property (nonatomic ,assign) NSInteger page;

@property (nonatomic, strong)UICollectionReusableView *headView;
@property (nonatomic, strong)UIScrollView *hotScrollView;
@property (nonatomic , strong) CycleScrollView *mainScorllView;
@property (nonatomic ,strong) UICollectionView *collectionView;

@property (nonatomic , assign)int currPage;
@property (nonatomic , assign)int countPage;
@property (nonatomic , strong)NSString *typeName;
@property (nonatomic , strong)NSNumber *typeID;
@property (nonatomic, strong)NSMutableArray *collectionDataArr;

@property (nonatomic, assign)CGFloat headHeight;
@property (nonatomic , weak)id <collectionViewCustomDelegate> customDelegate;

@end
