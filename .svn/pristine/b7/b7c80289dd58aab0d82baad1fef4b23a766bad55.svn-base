//
//  LuckdrawViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 2016/12/8.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJRoationView.h"
#import "MakeMoneyViewController.h"
@interface LuckdrawViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UIImageView *tabheadview;          //导航条
@property (strong, nonatomic) UIImageView *headView;             //头部
@property (strong, nonatomic) UIScrollView *myScrollview;        //滑动视图
@property (strong, nonatomic) DJRoationView *roationView;        //抽奖转盘
@property (strong, nonatomic) UITableView *ptyaRwardTableView;   //额度奖励列表
@property (strong, nonatomic) UITableView *yiduRwardTableView;   //衣豆奖励列表

//额度数据
@property (strong, nonatomic) NSMutableArray*fictitiousPtyaArray;//虚拟奖励数据
@property (strong, nonatomic) NSMutableArray*realPtyaArray;      //真实奖励数据
@property (strong, nonatomic) NSMutableArray*totalPtyaArray;     //总奖励数据

//衣豆数据
@property (strong, nonatomic) NSMutableArray*fictitiousYiduArray;//虚拟奖励数据
@property (strong, nonatomic) NSMutableArray*realYiduArray;      //真实奖励数据
@property (strong, nonatomic) NSMutableArray*totalYiduArray;     //总奖励数据

@property (strong , nonatomic) UILabel *totalbalanceLab;         //总余额
@property (strong , nonatomic) UILabel *availablebalanceLab;     //可提现余额
@property (strong , nonatomic) UILabel *frozenyidouLab;          //冻结衣豆
@property (strong , nonatomic) UILabel *availableyidouLab;       //可用衣豆

@property (assign , nonatomic) Mondytype mondaytype;             //是否是疯狂星期一
@property (nonatomic , assign) NSInteger LotteryNumber;          //抽奖次数
@property (nonatomic , assign) NSInteger OldLotteryNumber;       //抽奖前的抽奖次数
@property (nonatomic , assign) NSInteger OrderGetYidou;          //订单获取衣豆
@property (nonatomic , assign) BOOL  is_fromOrder;               //是否是订单过来的
@property (nonatomic , assign) BOOL is_fromMessage;              //从消息push
@property (nonatomic , assign) BOOL is_OrderRedLuck;             //50元红包抽奖
@property (nonatomic , assign) BOOL is_comefromeRed;             //红包抽奖
@property (nonatomic , assign) BOOL is_comefromeYue;             //余额抽奖

@end
