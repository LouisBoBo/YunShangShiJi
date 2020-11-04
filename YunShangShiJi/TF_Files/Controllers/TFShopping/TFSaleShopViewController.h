//
//  TFSaleShopViewController.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/6/16.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFShoppingViewController.h"
@protocol TFSaleDelegate <NSObject>

- (void)salePageViewScrollSetTabBarStatus:(TabBarStutes)status animation:(BOOL)isAnimation;

- (void)saleTitleTopStatus:(BOOL)isTop;
@end

@interface TFSaleShopViewController : UIViewController

@property (nonatomic, weak) id <TFSaleDelegate> saleDelegate;

@end
