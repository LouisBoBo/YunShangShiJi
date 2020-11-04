//
//  TFSubIntimateCircleVC.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2017/2/14.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TFBaseViewController.h"
#import "SqliteManager.h"

@protocol TFSubIntimateCircleDelegate <NSObject>

- (void)intimateCirclePullDownRefreshWithIndex:(int)index;

- (void)intimateCircleWithScrollViewWillBeginDragging:(UIScrollView *)scrollView index:(int)index;
- (void)intimateCircleWithScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate index:(int)index;
- (void)intimateCircleWithScrollViewWillBeginDecelerating:(UIScrollView *)scrollView index:(int)index;
- (void)intimateCircleWithscrollViewDidEndDecelerating:(UIScrollView *)scrollView index:(int)index;

@end

@interface TFSubIntimateCircleVC : TFBaseViewController
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSString *themeid;
@property (nonatomic, assign) CGFloat headerView_H;
@property (nonatomic, strong) ShopTypeItem *item;
@property (nonatomic , weak)id <TFSubIntimateCircleDelegate> customDelegate;

- (void)httpTheme;
- (void)httpCircle;

@end
