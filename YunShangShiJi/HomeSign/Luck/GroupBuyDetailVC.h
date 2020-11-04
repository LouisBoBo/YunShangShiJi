//
//  GroupBuyDetailVC.h
//  YunShangShiJi
//
//  Created by YF on 2017/7/11.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TFBaseViewController.h"

@interface GroupBuyDetailVC : TFBaseViewController
@property (nonatomic , assign) NSInteger offered;     //0参团未结束 1参团结束
@property (nonatomic , assign) NSInteger isTM;        //是否特卖 1是 0不是
@property (nonatomic , strong) NSString *roll_code;   //拼团团号
@property (nonatomic , assign) NSInteger fightStatus; //拼团状态
@end
