//
//  SpecialDetailViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 2016/12/2.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLPlainFlowLayout.h"
#import "CollectionHeaderView.h"
#import "CollocationModel.h"

typedef void(^BrowseCountBlock)(NSString *shopCode);
@interface SpecialDetailViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView *collectionView;  //列表
@property (strong, nonatomic) UIImageView *tabheadview;          //导航条
@property (strong, nonatomic) XLPlainFlowLayout *layout;
@property (strong, nonatomic) UIImageView *heardImgView;         //列表头大图
@property (strong, nonatomic) CollectionHeaderView *headerView;  //列表头
@property (strong, nonatomic) CollectionHeaderView *footView;    //列表尾
@property (strong, nonatomic) NSString *collocationCode;         //搭配编号
@property (strong, nonatomic) NSArray *shopList;                 //商品数据
@property (strong, nonatomic) NSMutableArray *RecommendList;     //热门推荐商品
@property (strong, nonatomic) CollocationModel *collcationModel; 
@property (nonatomic, assign) NSInteger currPage;                //热门推荐当前页

/**< 签到相关跳转参数 */
@property (nonatomic, copy)BrowseCountBlock browseCountBlock;
@property (nonatomic, assign)NSInteger browseCount;
@property (nonatomic, assign)double currTimeCount;
@property (nonatomic, assign)BOOL showGetMoneyWindow;

@property (strong , nonatomic)NSString * stringtype;
@property (nonatomic, copy) NSString *rewardType;               //签到奖励类型
@property (nonatomic, copy) NSString *rewardValue;              //签到奖励
@property (nonatomic, strong) NSMutableDictionary *Browsedic;   //签到数据

//签到
@property (nonatomic, copy) NSString *index_id;
@property (nonatomic, copy) NSString *index_day;
@property (nonatomic, assign)NSInteger rewardCount;

@property (nonatomic, assign) BOOL isMoreTopVC;
@end
