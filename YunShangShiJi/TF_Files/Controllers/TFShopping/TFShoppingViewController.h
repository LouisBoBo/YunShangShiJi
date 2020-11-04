//
//  TFShoppingViewController.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/6/16.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalTool.h"
#import "ShopStoreViewController.h"

typedef NS_ENUM(NSInteger, TabBarStutes)
{
    TabBarStutesNormal = 100,
    TabBarStutesBottom
};

typedef NS_ENUM(NSInteger, CurrSelectedControllerType)
{
    CurrSelectedControllerType_A = 100,
    CurrSelectedControllerType_B
};

@interface TFShoppingViewController : UIViewController

@property (nonatomic, assign)CurrSelectedControllerType selcetedControllerType;
@property (nonatomic, assign) NSInteger currPageViewController;
@property (nonatomic, assign) BOOL pushCome;
- (instancetype)initWithFiristGo;
@end
