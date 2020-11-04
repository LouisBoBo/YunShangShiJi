//
//  SignViewController.h
//  YunShangShiJi
//
//  Created by yssj on 15/9/10.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignViewController : UIViewController

@property (nonatomic, assign)BOOL isSign;   //今天是否签到
@property (nonatomic, assign)int signDay;   //连续签到的天数
@property (nonatomic, strong)NSString *totalintegral;                     //总积分

@end
