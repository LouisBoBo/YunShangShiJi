//
//  OrderTableViewController.h
//  YunShangShiJi
//
//  Created by yssj on 15/9/5.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCardModel.h"

typedef enum : NSUInteger {
    OrderType_Normal,   //单独购买
    OrderType_GroupBuy, //拼团
    OrderType_FightBuy, //开团
} OrderType;

@interface OrderTableViewController : UIViewController

@property (nonatomic, assign) OrderType orderBuyType;
@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSArray     *sortArray;
/******用作分享的图片******/
@property (nonatomic , strong)NSString *four_pic;
/********订单编号********/
@property (nonatomic , strong)NSString *order_code;
/********订单的总价******/
//@property(nonatomic,strong) NSString *shop_seprice;

@property BOOL haveType;//是否含有搭配购商品
@property BOOL isSpecialOrder;//是否特价商品订单
@property int coutTime;//倒计时

@property CGFloat allResavePrice;//搭配节省的钱

@property (nonatomic , strong)MyCardModel *cardModel;

@property (nonatomic,copy)dispatch_block_t affirmOrder;

//是否是拼团商品
@property (nonatomic , assign) BOOL isFight;
//是否特卖
@property (nonatomic , assign) BOOL isTM;

@property (nonatomic , assign) NSInteger is_vip;
@property (nonatomic , assign) NSInteger vip_free;
@property (nonatomic , assign) NSInteger firstGroup;  //是否是首单
@property (nonatomic , assign) NSInteger max_vipType;
@property (nonatomic , assign) NSInteger vipType;
@property (nonatomic , assign) NSInteger free_page;
@property (nonatomic , assign) NSInteger vip_page;
@end
