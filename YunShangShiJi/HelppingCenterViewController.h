//
//  HelppingCenterViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/20.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelppingCenterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *serviceView;
@property (weak, nonatomic) IBOutlet UIView *phoneView;

@end
