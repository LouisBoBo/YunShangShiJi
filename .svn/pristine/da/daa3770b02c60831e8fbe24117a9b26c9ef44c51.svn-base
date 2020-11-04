//
//  MyOrderViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/17.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLScrollViewer.h"
@interface MyOrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate>
@property (nonatomic,assign)NSInteger tag;

//一级标签选中按钮
@property (nonatomic,strong)UIButton *slectbtn1;
@property (nonatomic,strong)UIButton *statebtn1;

//二级标签选中按钮
@property (nonatomic,strong)UIButton *slectbtn2;
@property (nonatomic,strong)UIButton *statebtn2;

//我的买单订单状态
@property (nonatomic,strong)NSString *status1;
@property (nonatomic,strong)NSString *oldstatus1;
//我的卖单订单状态
@property (nonatomic,strong)NSString *status2;
@property (nonatomic,strong)NSString *oldstatus2;


@property BOOL Distribution;
//订单编号
@property (nonatomic,strong)NSString *order_code;

@property(nonatomic ,strong)XLScrollViewer *scroll;//如果无需外部调用XLScrollViewer的属性，则无需写此属性


//是否是包邮过来的
@property (nonatomic, assign)BOOL isbaoyou;
//是否是首单免费领
@property (nonatomic, assign)BOOL isfirst_freeling;

@property(nonatomic, retain)NSString *mode;
@property(nonatomic, retain)NSString *tnURL;
@property(nonatomic, retain)NSString *configURL;

@property (nonatomic , strong)NSString *orderstatue;


@property (nonatomic,strong)NSString *user_id;      //下级用户user_id

@end
