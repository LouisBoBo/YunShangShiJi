//
//  SuccessRerundViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/7/29.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuccessRerundViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *headview;
@property (weak, nonatomic) IBOutlet UILabel *rerundmoney;
@property (weak, nonatomic) IBOutlet UILabel *rerundtime;
@property (weak, nonatomic) IBOutlet UIButton *moneygobtn;
@property (weak, nonatomic) IBOutlet UIImageView *headimage;
@property (weak, nonatomic) IBOutlet UILabel *headtitle;

@property (weak, nonatomic) IBOutlet UILabel *statues;

//上一界面传递数据
@property (nonatomic , strong)NSDictionary *dic;
@property (nonatomic , strong)NSString *staute;
@property (nonatomic , strong)NSString *titlestr;
@end
