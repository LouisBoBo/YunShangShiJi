//
//  ShopthreeViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/5/15.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLScrollViewer.h"
@interface ShopthreeViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
@property(nonatomic ,strong)XLScrollViewer *scroll;//如果无需外部调用XLScrollViewer的属性，则无需写此属性
//上一级的父id
@property(nonatomic , strong)NSString *parentid;
@property(nonatomic , strong)NSString *shoptitle;
@end
