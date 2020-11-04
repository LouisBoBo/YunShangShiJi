//
//  TFSearchViewController.h
//  YunShangShiJi
//
//  Created by 云商 on 15/8/18.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFBaseViewController.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "MyMD5.h"
#import "MBProgressHUD+NJ.h"
 
#import "MJRefresh.h"
#import "WaterFLayout.h"
#import <sqlite3.h>
#import "WaterFlowCell.h"
#import "ShopDetailViewController.h"
#import "TFScreenViewController.h"
@interface TFSearchViewController : TFBaseViewController <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, copy) dispatch_block_t MainViewStatusNormal;
@property (nonatomic, strong)NSMutableArray *type3Arr;  //原来的
@property (nonatomic, strong)NSMutableArray *chooseArr; //选择的
@property (nonatomic, strong)NSMutableArray *noChooseArr; //未选择的
@property (nonatomic, copy) NSString *dataStatistics;
@property (nonatomic, strong)NSMutableArray *waterFlowDataArray;
@property (nonatomic, strong)UICollectionView *collectionView;

@property(nonatomic , copy)NSString *parentID;
@property(nonatomic , copy)NSString *shopTitle;
@property(nonatomic , copy)NSString *valuestr;
@property(nonatomic , copy)NSString *comefrom;

@property(nonatomic , assign)BOOL isliulan;
@property(nonatomic , assign)BOOL isbrowse;
@property(nonatomic , assign)BOOL isCrazy;

@property(nonatomic , copy)NSString *bannerImage; //广告头图片
/**
 浏览赢提现的任务
 */
@property (nonatomic, assign) BOOL isTiXian;

@property (nonatomic, copy)NSString *typeName;
@property (nonatomic, strong)NSNumber *typeID;

/**
 需要浏览个数
 */
@property (nonatomic, assign) NSInteger randomNum;
@property (nonatomic, copy) NSString *rewardType;       //签到奖励类型
@property (nonatomic, copy) NSString *rewardValue;      //签到奖励
@property (nonatomic, assign) NSInteger rewardCount;    //分几次奖励
@property (nonatomic, copy) NSString *index;
@property (nonatomic, copy) NSString *day;
@property (nonatomic, assign) NSInteger browseCount;    /**< 已经浏览了几次 */
@property (nonatomic, assign) BOOL showGetMoneyWindow;
@property (nonatomic, assign) double currTimeCount;
@property (nonatomic, strong) NSMutableDictionary *Browsedic; //签到数据
@property (nonatomic, strong) NSMutableArray *selectShopArray; /**< 选择过的商品计数 */
@end
