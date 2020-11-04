//
//  GoldViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 16/10/8.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoldViewController : UIViewController

@property (nonatomic , strong)UILabel *timerLab;
@property (nonatomic , assign)int pubtime;
@property (nonatomic , strong)NSTimer *mytimer;
@property (nonatomic , strong)NSString *nowtime;
@property (nonatomic , copy)NSString *jifen;
@end
