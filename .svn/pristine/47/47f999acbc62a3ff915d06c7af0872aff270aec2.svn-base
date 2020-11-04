//
//  TFLedBrowseShopViewController.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/6/27.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFBaseViewController.h"

typedef void(^BrowseFinishBlock)();
typedef void(^BrowseFailBlock)();
@interface TFLedBrowseShopViewController : TFBaseViewController

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
@property (nonatomic , assign) BOOL isbrowse;  //是否强制浏览
@property(nonatomic , copy)NSString *bannerImage; //广告头图片

@property (nonatomic, copy) NSString *index;
@property (nonatomic, copy) NSString *day;
@property (nonatomic, assign) NSInteger rewardCount;
@property (nonatomic, copy) NSString *title;

- (void)setBrowseFinishBlock:(BrowseFinishBlock)browseFinish browseFail:(BrowseFailBlock)browseFail;

@end

typedef void(^CancelBlock)();
typedef void(^ConfirmBlock)();
typedef void(^NoOperationBlock)();
typedef NSString *(^ExpBlock)();
@interface ExplainPopView : UIView 

@property (nonatomic, copy) CancelBlock cancelClickBlock;
@property (nonatomic, copy) ConfirmBlock confirmClickBlock;
@property (nonatomic, copy) NoOperationBlock noOperationBlock;

- (void)show;
- (void)setCancelBlock:(CancelBlock)canBlock withConfirmBlock:(ConfirmBlock)conBlock withNoOperationBlock:(NoOperationBlock)noOperatBlock;

@end

typedef void(^MenuBtnClickBlock)(NSInteger btnClickIndex);
@interface TaskMenuButtonView : UIView

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *normalImgArray;
@property (nonatomic, strong) NSArray *selectImgArray;

@property (nonatomic, copy) MenuBtnClickBlock menuBtnClickBlock;
- (void)show;

@end
