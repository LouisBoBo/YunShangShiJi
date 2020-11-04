//
//  TFShopStoreViewController.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/6/16.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalTool.h"

#import "TFShoppingViewController.h"

@protocol TFShopStoreDelegate <NSObject>

- (void)titlePageToIndex:(NSInteger)index withTitleShopType:(NSDictionary *)typeParms;
- (void)storePageViewScrollView:(UIScrollView *)pageViewScrollView setTabBarStatus:(TabBarStutes)status animation:(BOOL)isAnimation;
- (void)storePageViewScrollViewDidScroll:(UIScrollView *)pageViewScrollView;
- (void)storeTitleTopStatus:(BOOL)isTop;

@end


@interface TFShopStoreViewController : UIViewController
@property (nonatomic , copy) NSString *shopTypeName;  //是搭配还是专题
@property (nonatomic, assign) NSInteger currPageViewController;
@property (nonatomic ,assign) BOOL                  isHeadView;
@property (nonatomic ,assign) BOOL                  isFootView;
@property (nonatomic, assign ) CGFloat                   titleHeight;
@property (nonatomic, weak) id <TFShopStoreDelegate> shopStoreDelegate;

@end
