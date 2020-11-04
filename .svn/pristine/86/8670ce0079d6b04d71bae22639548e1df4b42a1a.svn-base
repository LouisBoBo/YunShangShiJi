//
//  TFLedBrowseCollocationShopVC.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2016/10/9.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFBaseViewController.h"
typedef void(^BrowseFinishBlock)();
typedef void(^BrowseFailBlock)();
@interface TFLedBrowseCollocationShopVC : TFBaseViewController


/**
 浏览赢提现的任务
 */
@property (nonatomic, assign) BOOL isTiXian;
/**
 需要浏览个数
 */
@property (nonatomic, assign) NSInteger randomNum;

/**
 浏览成功回调Block
 */
@property (nonatomic, copy) BrowseFinishBlock browseFinish;

/**
 浏览失败回调Block
 */
@property (nonatomic, copy) BrowseFailBlock browseFail;
@property (nonatomic, copy) NSString *rewardType; //签到奖励类型
@property (nonatomic, copy) NSString *rewardValue; //签到奖励
@property (nonatomic, assign) NSInteger liulanCount; //总计浏览多少个
@property (nonatomic, copy) NSString *index;
@property (nonatomic, copy) NSString *day;
@property (nonatomic, assign) NSInteger rewardCount;
@property (nonatomic, strong) NSMutableDictionary *Browsedic; //签到数据
- (void)setBrowseFinishBlock:(BrowseFinishBlock)browseFinish browseFail:(BrowseFailBlock)browseFail;

@end
