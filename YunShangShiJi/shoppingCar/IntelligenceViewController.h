//
//  IntelligenceViewController.h
//  YunShangShiJi
//
//  Created by yssj on 15/8/6.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "ShareShopModel.h"
@interface IntelligenceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UIView *PopView;

@property (strong , nonatomic) ShareShopModel *shareModel;

@property (strong , nonatomic) NSString *shopPrice;
@property (strong , nonatomic) NSString *orderCode;

@property (nonatomic,strong)UIButton *statebtn1;
@property (nonatomic,strong)UIButton *slectbtn1;

@property (nonatomic, copy) dispatch_block_t BackBlock;//下单前分享成功回调

@property (nonatomic,strong)NSString* isshare;

@end
