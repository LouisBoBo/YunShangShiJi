//
//  YFSearchView.h
//  YunShangShiJi
//
//  Created by zgl on 16/6/16.
//  Copyright © 2016年 ios-1. All rights reserved.
//  侧边搜索栏

#import <UIKit/UIKit.h>
#import "SqliteManager.h"

@class YFSearchView;

@protocol YFSearchViewDelegate <NSObject>

@required
/// cell数
- (NSInteger)searchView:(YFSearchView *)searchView numberOfRowsInSection:(NSInteger)section;
/// cell数据
- (ShopTypeItem *)searchView:(YFSearchView *)searchView itemForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional
/// 段数
- (NSInteger)numberOfSectionsInSearchView:(YFSearchView *)searchView;
/// 段标题
- (NSString *)searchView:(YFSearchView *)searchView titleForHeaderInSection:(NSInteger)section;

/// 搜索
- (void)searchViewSearchString:(NSString *)string;
/// 点击结果
- (void)searchView:(YFSearchView *)searchView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
/// 向左滑动
- (void)searchViewDirectionLeft;

@end


@interface YFSearchView : UIView

@property (nonatomic, weak) id<YFSearchViewDelegate> delegate;

/// 刷新
- (void)reloadData;

@end
