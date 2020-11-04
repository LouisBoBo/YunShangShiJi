//
//  HotOutfitViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/4/1.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotOutfitViewController : UIViewController
@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) UIImageView *tabheadview;            //导航条
@property (nonatomic, assign) BOOL isFinish;
@property (nonatomic, assign) BOOL isLiulan;
@property (strong, nonatomic) NSMutableArray *dataSource;          //数据源
@property (nonatomic, assign) BOOL showGetMoneyWindow;
/**
 浏览赢提现的任务
 */
@property (nonatomic, assign) BOOL isTiXian;
@property (nonatomic, copy) NSString *index;
@property (nonatomic, copy) NSString *day;

@end
