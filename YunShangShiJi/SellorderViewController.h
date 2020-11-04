//
//  SellorderViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/7/1.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopDetailModel.h"
@interface SellorderViewController : UIViewController<UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *Myscrollview;
@property (weak, nonatomic) IBOutlet UIView *Orderview;
@property (weak, nonatomic) IBOutlet UIView *buyerview;
@property (weak, nonatomic) IBOutlet UIView *shopview;
@property (weak, nonatomic) IBOutlet UIView *addressview;
@property (weak, nonatomic) IBOutlet UIView *serverview;

@property (weak, nonatomic) IBOutlet UILabel *ordercode;
@property (weak, nonatomic) IBOutlet UILabel *creattime;
@property (weak, nonatomic) IBOutlet UILabel *paytime;
@property (weak, nonatomic) IBOutlet UILabel *payordercode;
@property (weak, nonatomic) IBOutlet UILabel *buyer;
@property (weak, nonatomic) IBOutlet UILabel *mark;
@property (weak, nonatomic) IBOutlet UILabel *consignee;
@property (weak, nonatomic) IBOutlet UILabel *adress;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UIButton *relation;
@property (weak, nonatomic) IBOutlet UIButton *callphone;
@property (weak, nonatomic) IBOutlet UILabel *status;        //待发货
@property (weak, nonatomic) IBOutlet UIImageView *addressImg;

@property (nonatomic,strong)ShopDetailModel *orderModel;
//订单状态
@property (nonatomic,strong)NSString *Orderstatue;
@end
