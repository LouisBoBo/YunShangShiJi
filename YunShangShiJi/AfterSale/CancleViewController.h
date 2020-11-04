//
//  CancleViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/7/30.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface CancleViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *orderprice;
@property (weak, nonatomic) IBOutlet UILabel *ordercode;
@property (weak, nonatomic) IBOutlet UILabel *applytime;
@property (weak, nonatomic) IBOutlet UILabel *ordertitle;
@property (weak, nonatomic) IBOutlet UILabel *orderstatue;
@property (weak, nonatomic) IBOutlet UILabel *cancletime;
@property (weak, nonatomic) IBOutlet UILabel *timelable;


//上一界面传递数据
//@property (nonatomic , strong)NSDictionary *dic;
@property (nonatomic ,strong)OrderModel *orderModel;

@property (nonatomic , strong)NSString *titlestring;
@end
