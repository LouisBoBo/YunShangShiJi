//
//  TFSalePurchaseTwoViewController.h
//  YunShangShiJi
//
//  Created by 云商 on 15/11/27.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "TFBaseViewController.h"

@interface TFSalePurchaseTwoViewController : TFBaseViewController

@property (nonatomic, copy)NSString *type;

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArr;

@property (nonatomic, strong)NSMutableArray *pListArr;

@end
