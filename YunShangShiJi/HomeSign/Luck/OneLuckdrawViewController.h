//
//  OneLuckdrawViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 2018/2/24.
//  Copyright © 2018年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJRoationView.h"

@interface OneLuckdrawViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UIImageView *tabheadview;          //导航条
@property (strong, nonatomic) UIImageView *headView;             //头部
@property (strong, nonatomic) UIScrollView *myScrollview;        //滑动视图
@property (strong, nonatomic) DJRoationView *roationView;        //抽奖转盘
@property (strong, nonatomic) UITableView *ptyaRwardTableView;   //额度奖励列表
@property (nonatomic, strong) NSTimer *mytimer;

//额度数据
@property (strong, nonatomic) NSMutableArray*fictitiousPtyaArray;//虚拟奖励数据
@property (strong, nonatomic) NSMutableArray*realPtyaArray;      //真实奖励数据
@property (strong, nonatomic) NSMutableArray*totalPtyaArray;     //总奖励数据
@property (strong, nonatomic) NSString *comefrom;//从哪个界面来
@property (strong, nonatomic) NSString *order_code;
@property (strong, nonatomic) NSMutableArray *dataArray;         //订单数据
@property (assign, nonatomic) BOOL isTestLuckDraw;               //测试转盘
@end
