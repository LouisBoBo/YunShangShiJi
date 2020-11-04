//
//  TFCollocationViewController.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/28.
//  Copyright © 2016年 ios-1. All rights reserved.
//  搭配

#import <UIKit/UIKit.h>
#import "TFBaseViewController.h"
typedef NS_ENUM(NSUInteger, PushType) {
    PushTypeHome = 0,
    PushTypeSign
};

@protocol collocationViewCustomDelegate <NSObject>

- (void)collocationViewPullDownRefreshWithIndex:(int)index;

- (void)collocationViewWithScrollViewWillBeginDragging:(UIScrollView *)scrollView index:(int)index;
- (void)collocationViewWithScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate index:(int)index;
- (void)collocationViewWithScrollViewWillBeginDecelerating:(UIScrollView *)scrollView index:(int)index;
- (void)collocationViewWithscrollViewDidEndDecelerating:(UIScrollView *)scrollView index:(int)index;

@end

@interface TFCollocationViewController : TFBaseViewController

@property (nonatomic, assign) PushType pushType;
//是否有头部
@property (nonatomic ,assign) BOOL isFinish;
@property (nonatomic ,assign) BOOL isHeadView;
@property (nonatomic , strong)NSString *typeName;
@property (nonatomic , strong)NSNumber *typeID;
@property (nonatomic ,assign) NSInteger page;
@property (nonatomic, assign)CGFloat headHeight;
@property (nonatomic ,strong) UITableView *mainTableView;
@property (nonatomic , weak)id <collocationViewCustomDelegate> customDelegate;
@end
