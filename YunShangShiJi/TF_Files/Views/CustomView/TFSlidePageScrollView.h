//
//  TFSlidePageScrollView.h
//  YunShangShiJi
//
//  Created by 云商 on 15/11/30.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "TFCustomTitleView.h"

@class TFSlidePageScrollView;

typedef NS_ENUM(NSUInteger, TFPageTabBarState) {
    TFPageTabBarStateStopOnTop,
    TFPageTabBarStateScrolling,
    TFPageTabBarStateStopOnButtom,
};

@protocol TFSlidePageScrollViewDataSource <NSObject>

@required

// num of pageViews
- (NSInteger)numberOfPageViewOnSlidePageScrollView;

// pageView need inherit UIScrollView (UITableview inherit it) ,and vertical scroll
- (UIScrollView *)slidePageScrollView:(TFSlidePageScrollView *)slidePageScrollView pageVerticalScrollViewForIndex:(NSInteger)index;

@end

@protocol TFSlidePageScrollViewDelegate <NSObject>

@optional

// vertical scroll any offset changes will call
- (void)slidePageScrollView:(TFSlidePageScrollView *)slidePageScrollView verticalScrollViewDidScroll:(UIScrollView *)pageScrollView;

// pageTabBar vertical scroll and state
- (void)slidePageScrollView:(TFSlidePageScrollView *)slidePageScrollView pageTabBarScrollOffset:(CGFloat)offset state:(TFPageTabBarState)state;

// horizen scroll to pageIndex, when index change will call
- (void)slidePageScrollView:(TFSlidePageScrollView *)slidePageScrollView horizenScrollToPageIndex:(NSInteger)index;

// horizen scroll any offset changes will call
- (void)slidePageScrollView:(TFSlidePageScrollView *)slidePageScrollView horizenScrollViewDidScroll:(UIScrollView *)scrollView;

// horizen scroll Begin Dragging
- (void)slidePageScrollView:(TFSlidePageScrollView *)slidePageScrollView horizenScrollViewWillBeginDragging:(UIScrollView *)scrollView;

// horizen scroll called when scroll view grinds to a halt
- (void)slidePageScrollView:(TFSlidePageScrollView *)slidePageScrollView horizenScrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@end

@interface TFSlidePageScrollView : UIView

@property (nonatomic, weak)   id<TFSlidePageScrollViewDataSource> tyDataSource;
@property (nonatomic, weak)   id<TFSlidePageScrollViewDelegate> tyDelegate;

@property (nonatomic, assign) BOOL automaticallyAdjustsScrollViewInsets; // default NO;(iOS 7) it will setup viewController automaticallyAdjustsScrollViewInsets, because this property (YES) cause scrollView layout no correct

@property (nonatomic, strong) UIView *headerView; // defult nil，don't forget set height

@property (nonatomic, strong) TFCustomTitleView *pageTabBar; //defult nil


@property (nonatomic, assign) BOOL pageTabBarIsStopOnTop;  // default YES, is stop on top

@property (nonatomic, assign) CGFloat pageTabBarStopOnTopHeight; // default 0, bageTabBar stop on top height, if pageTabBarIsStopOnTop is NO ,this property is inValid

@property (nonatomic, strong) UIView *footerView; // defult nil

@property (nonatomic, assign, readonly) NSInteger curPageIndex;

// 当滚动到scroll宽度的百分之多少 改变index
@property (nonatomic, assign) CGFloat changeToNextIndexWhenScrollToWidthOfPercent; // 0.0~0.1 default 0.5, when scroll to half of width, change to next index


- (void)reloadData;

- (BOOL)scrollToPageIndex:(NSInteger)index animated:(BOOL)animated;

- (UIScrollView *)pageScrollViewForIndex:(NSInteger)index;

- (NSInteger)indexOfPageScrollView:(UIScrollView *)pageScrollView;

@end
