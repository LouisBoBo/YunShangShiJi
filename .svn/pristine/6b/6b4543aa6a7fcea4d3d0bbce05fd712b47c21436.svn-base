//
//  ShouYeShopStoreViewController.h
//  YunShangShiJi
//
//  Created by hebo on 2019/1/23.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URBAlertView.h"
#import "SRRefreshView.h"
#import "CycleScrollView.h"
#import "WaterFLayout.h"


#pragma mark 000000000000000000000000
#import "TYSlidePageScrollView.h"
#import "TYTitlePageTabBar.h"
#import "CollectionViewController.h"


#define NavigationHeight 44.0f
#define StatusTableHeight 20.0f
#define TableBarHeight 49.0f
#define handViewWidth 10
#define OPENCENTERX kScreenWidth*0.718
#define DIVIDWIDTH kScreenWidth*0.718*0.25
#define PullRefreshHeight 0
NS_ASSUME_NONNULL_BEGIN

@interface ShouYeShopStoreViewController : UIViewController<TYSlidePageScrollViewDataSource, TYSlidePageScrollViewDelegate,UIAlertViewDelegate>
//商品属性
@property (nonatomic , strong)NSString *shuxing_id;
@property (nonatomic , strong)NSString *attr_name;
@property (nonatomic , strong)NSString *attr_Parent_id;
@property (nonatomic , strong)NSString *is_show;

//商品分类
@property (nonatomic , strong)NSString *dir_level;//级别
@property (nonatomic , strong)NSString *type_id;
@property (nonatomic , strong)NSString *type_parent_id;
@property (nonatomic , strong)NSString *type_name;
@property (nonatomic , strong)NSString *type_ico;


//商品标签
@property (nonatomic , strong)NSString *tag_name;
@property (nonatomic , strong)NSString *tag_id;
@property (nonatomic , strong)NSString *tag_show;
@property (nonatomic , strong)NSString *tag_parent_id;

@property (nonatomic , strong)NSString *Sqlitetype;


#pragma mark 0000000000000000000000000000000000000000000

@property (nonatomic, strong) UIView                *leftBackgroundView;
@property (nonatomic, strong) UIView                *contentBackgroundView;
@property (nonatomic, weak  ) TYSlidePageScrollView *slidePageScrollView;
//@property (nonatomic ,strong) UIButton *selectBtn;
@property (nonatomic ,assign) BOOL                  isHeadView;
@property (nonatomic ,assign) BOOL                  isFootView;
@property (nonatomic ,strong) UIView                *nheadView;
@property (nonatomic, strong) CustomTitleView       *nTitleView;
@property (nonatomic, assign) int                   nCurrPage;
@property (nonatomic, assign) BOOL                  isVseron;
@property (nonatomic, assign) BOOL                  isNewProduction;
@property (nonatomic, assign) BOOL                  isShouYeThree;
@property (nonatomic, strong) NSMutableArray        *typeIndexArr;
@property (nonatomic, strong) NSMutableArray        *hostDataArray;


@end

NS_ASSUME_NONNULL_END
