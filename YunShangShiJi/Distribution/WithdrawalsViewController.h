//
//  WithdrawalsViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/10/28.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DistributionModel.h"

@interface WithdrawalsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)DistributionModel *model;

@end
