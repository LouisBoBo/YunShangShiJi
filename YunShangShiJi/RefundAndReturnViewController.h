//
//  RefundAndReturnViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/6/19.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopDetailModel.h"
@interface RefundAndReturnViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)NSString *orderPrice;
@property (nonatomic ,strong)ShopDetailModel *ordermodel;

@property (nonatomic ,strong)NSString *shop_id;
@property (nonatomic ,strong)NSString *order_code;
@property (nonatomic ,strong)NSString *issue_status;
@property (nonatomic ,strong)NSString *shop_from;

@end
