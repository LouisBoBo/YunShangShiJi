//
//  TFActivityShopVC.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2016/10/22.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFBaseViewController.h"
typedef void(^BrowseFinishBlock)();
typedef void(^BrowseFailBlock)();
@interface TFActivityShopVC : TFBaseViewController
/**
 浏览赢提现的任务
 */
@property (nonatomic, assign) BOOL isTiXian;

@property (nonatomic, assign) NSInteger randomNum;
@property (nonatomic, copy) BrowseFinishBlock browseFinish;
@property (nonatomic, copy) BrowseFailBlock browseFail;
@property (nonatomic, copy) NSString *rewardType; //签到奖励类型
@property (nonatomic, copy) NSString *rewardValue; //签到奖励
@property (nonatomic, strong) NSMutableDictionary *Browsedic; //签到数据
@property (nonatomic, assign) BOOL isLiulan; //是否浏览分钟数
@property (nonatomic, assign) NSInteger liulanCount; //总计浏览多少个
@property (nonatomic, assign) BOOL isMonday;;

@property (nonatomic, strong) UIView *headerTimerView;
@property (nonatomic, strong) UILabel *messageLab;
@property (nonatomic, strong) UIButton *explainBtn;

@property(nonatomic , copy)NSString *bannerImage; //广告头图片
@property (nonatomic, copy) NSString *index;
@property (nonatomic, copy) NSString *day;
@property (nonatomic, assign) NSInteger rewardCount;
@property (nonatomic, copy) NSString *taskValue;
- (void)setBrowseFinishBlock:(BrowseFinishBlock)browseFinish browseFail:(BrowseFailBlock)browseFail;
@end

typedef void(^MenuBtnClickBlock)(NSInteger btnClickIndex);
@interface ActiveMenuButtonView : UIView

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *normalImgArray;
@property (nonatomic, strong) NSArray *selectImgArray;

@property (nonatomic, copy) MenuBtnClickBlock menuBtnClickBlock;
- (void)show;

@end
