//
//  TaskCollectionVC.h
//  YunShangShiJi
//
//  Created by yssj on 2016/11/2.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFBaseViewController.h"

typedef void(^BrowseFinishBlock)();
typedef void(^BrowseFailBlock)();
@interface TaskCollectionVC : TFBaseViewController
@property (nonatomic , assign)BOOL is_jingxi;      //是否是惊喜任务
@property (nonatomic , strong)NSString *titlename;
@property (nonatomic , strong)NSString *typeName;
@property (nonatomic , strong)NSNumber *typeID;
@property (nonatomic , strong)NSString *comefrom;


/**
 需要浏览个数
 */
@property (nonatomic, assign) NSInteger randomNum;
@property (nonatomic, copy) BrowseFinishBlock browseFinish;
@property (nonatomic, copy) BrowseFailBlock browseFail;
@property (nonatomic, copy) NSString *rewardType; //签到奖励类型
@property (nonatomic, copy) NSString *rewardValue; //签到奖励
@property (nonatomic, strong) NSMutableDictionary *Browsedic; //签到数据
@property (nonatomic , assign) BOOL isbrowse;  //是否强制浏览
@property(nonatomic , copy)NSString *bannerImage; //广告头图片
@property (nonatomic, copy) NSString *index;
@property (nonatomic, copy) NSString *day;
@property (nonatomic, assign) NSInteger rewardCount;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL isTimeOut;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) double currTimeCount;
@property (nonatomic, strong) NSMutableArray *selectShopArray; /**< 选择过的商品计数 */
@property (nonatomic, assign) BOOL showGetMoneyWindow;
@property (nonatomic, assign) NSInteger browseCount;
- (void)setBrowseFinishBlock:(BrowseFinishBlock)browseFinish browseFail:(BrowseFailBlock)browseFail;

@end
