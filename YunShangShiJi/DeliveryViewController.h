//
//  DeliveryViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/5/29.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdressModel.h"
@interface DeliveryViewController : UIViewController<UIActionSheetDelegate>
@property (nonatomic ,strong)AdressModel *model;
@end
