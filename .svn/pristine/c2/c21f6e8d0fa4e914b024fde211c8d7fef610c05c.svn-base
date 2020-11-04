//
//  ActivityShopOrderVC.h
//  YunShangShiJi
//
//  Created by yssj on 2016/10/17.
//  Copyright © 2016年 ios-1. All rights reserved.
//
//  签到的活动商品  下单界面

#import <UIKit/UIKit.h>
#import "ShopDetailModel.h"

@interface ActivityShopOrderVC : UIViewController

@property (nonatomic,strong)ShopDetailModel *shopModel;
@property (nonatomic,strong)NSString *rollCode;//拼团必选.不给或者给0 为不使用拼团 //给1表示为发起拼团 //给参团编号表示参与别人的拼团

@property (nonatomic,assign)BOOL is_group;      // 别个参团
@property (nonatomic,strong)NSString *fromType; // 从哪个界面过来的 何波加的2016-11-25

/**
 yes 为活动商品  no为拼团商品
 */
@property (nonatomic, assign) BOOL isNOFightgroups;
@end
