//
//  OrderDetailViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/27.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopDetailModel.h"
@interface OrderDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
//订单编号
@property (nonatomic,strong)NSString *order_code;
@property (nonatomic,strong)ShopDetailModel *orderModel;
@property (nonatomic,assign)BOOL comefromPaySuccess;
//订单状态
@property (weak, nonatomic) IBOutlet UILabel *statue;
@property (weak, nonatomic) IBOutlet UILabel *infoViewLine;

@end
