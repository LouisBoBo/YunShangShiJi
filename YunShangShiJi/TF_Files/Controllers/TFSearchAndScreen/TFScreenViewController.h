//
//  TFScreenViewController.h
//  YunShangShiJi
//
//  Created by 云商 on 15/8/5.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFBaseWaterFlowViewController.h"

@interface TFScreenViewController : TFBaseWaterFlowViewController

/**
 浏览赢提现的任务
 */
@property (nonatomic, assign) BOOL isTiXian;

@property(nonatomic , copy)NSString *bannerImage; //广告头图片

@property (nonatomic, assign)int index; //0-文本搜索,1-热图筛选,2-直接筛选
@property (nonatomic ,copy)NSString *muStr;
@property (nonatomic ,copy)NSString *theme_id;
@property (nonatomic, copy)NSString *type2;
@property (nonatomic, copy)NSString *comefrom;
@property (nonatomic, assign) NSInteger currTitlePage;

/*
 1、搜索                notType=true
 2、类目标签查询  class_id != null
 3、一级类目查询  不满足1和2条件的均为一级类目查询
 */
@property (nonatomic, copy)NSString *class_id;//商品列表多条件分页查询变更

@property (nonatomic ,copy)NSString *type1;     //WTF传过来的type1
@property (nonatomic ,copy)NSString *type_name; //WTF传过来的type_name
@property (nonatomic, copy) dispatch_block_t MainViewStatusNormal;
@property (nonatomic , assign) BOOL isliulan;  //是否是浏览
@property (nonatomic , assign) BOOL isbrowse;  //是否强制浏览
@property (nonatomic, copy) NSString *dataStatistics;

/**
 需要浏览个数
 */
@property (nonatomic, assign) NSInteger randomNum;
@property (nonatomic, copy) NSString *rewardType;       //签到奖励类型
@property (nonatomic, copy) NSString *rewardValue;      //签到奖励
@property (nonatomic, assign) NSInteger rewardCount;    //分几次奖励
@property (nonatomic, copy) NSString *indexid;
@property (nonatomic, copy) NSString *day;
@property (nonatomic, assign) NSInteger browseCount;    /**< 已经浏览了几次 */
@property (nonatomic, assign) BOOL showGetMoneyWindow;
@property (nonatomic, assign) double currTimeCount;
@property (nonatomic, strong) NSMutableDictionary *Browsedic; //签到数据
@property (nonatomic, strong) NSMutableArray *selectShopArray; /**< 选择过的商品计数 */
@end


typedef void(^MenuBtnClickBlock)(NSInteger btnClickIndex);
@interface MenuButtonView : UIView

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *normalImgArray;
@property (nonatomic, strong) NSArray *selectImgArray;

@property (nonatomic, copy) MenuBtnClickBlock menuBtnClickBlock;
- (void)show;

@end
