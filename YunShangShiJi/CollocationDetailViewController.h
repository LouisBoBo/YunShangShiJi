//
//  CollocationDetailViewController.h
//  XLPlainFlowLayoutDemo
//
//  Created by hebe on 15/7/30.
//  Copyright (c) 2015年 ___ZhangXiaoLiang___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollocationModel.h"

typedef void(^BrowseCountBlock)(NSString *shopCode);
@interface CollocationDetailViewController : UICollectionViewController
@property (nonatomic, strong) CollocationModel *collcationModel;
@property (nonatomic, strong) NSArray *shopData;
@property (nonatomic, strong) NSMutableArray *pages;
@property (nonatomic, copy) NSString *collocationCode;
@property (nonatomic, copy) NSString *shopCodes;
@property (nonatomic, assign) int page;
@property (nonatomic, copy) NSString *pushType;

/**< 签到相关跳转参数 */
@property (nonatomic, copy)BrowseCountBlock browseCountBlock;
@property (nonatomic, assign)NSInteger browseCount;
@property (nonatomic, assign)double currTimeCount;
@property (nonatomic, assign)BOOL showGetMoneyWindow;

@property (strong , nonatomic)NSString * stringtype;
@property (nonatomic, copy) NSString *rewardType; //签到奖励类型
@property (nonatomic, copy) NSString *rewardValue; //签到奖励
@property (nonatomic, strong) NSMutableDictionary *Browsedic; //签到数据

//签到
@property (nonatomic, copy) NSString *index_id;
@property (nonatomic, copy) NSString *index_day;
@property (nonatomic, assign)NSInteger rewardCount;
@end

