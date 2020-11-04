//
//  SelectHobbyViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 2016/12/26.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterFallFlowViewModel.h"
#import "HobbyCollectionFootView.h"

@interface SelectHobbyViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>
@property (strong, nonatomic) UICollectionView *collectionView;    //列表
@property (strong, nonatomic) UIImageView *tabheadview;            //导航条
@property (strong, nonatomic) HobbyCollectionFootView *footerView; //列表尾

@property (strong, nonatomic) WaterFallFlowViewModel *viewModel;   //数据模型
@property (strong, nonatomic) NSMutableArray *SelectSaleArray;     //选择的消费
@property (strong, nonatomic) NSMutableArray *SelectStyleArry;     //选择的风格
@property (strong, nonatomic) NSMutableArray *SelectAgesArray;     //选择的年龄

@property (assign, nonatomic) BOOL is_change;                      //是否是修改
@property (strong, nonatomic) NSMutableString* beforeChangeStrData;//修改前数据
@property (strong, nonatomic) NSMutableString* afterChangeStrData; //修改后数据

//签到奖励
@property (nonatomic, copy) NSString *index;                       //签到任务
@property (nonatomic, copy) NSString *day;                         //签到第几天
@property (nonatomic, copy) NSString *rewardType;                  //签到奖励类型
@property (nonatomic, copy) NSString *rewardValue;                 //签到奖励

@property (nonatomic , strong)dispatch_block_t submitHobbySuccess;//提交喜好成功回调
@property (nonatomic , strong)NSString *comefrom;              //是否从推荐过来
@end
