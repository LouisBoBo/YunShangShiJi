//
//  NewSpecialViewController.h
//  YunShangShiJi
//
//  Created by hebo on 2018/7/16.
//  Copyright © 2018年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewSpecialViewController : UIViewController
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *shop_list;           //数据源
@property (strong, nonatomic) UIImageView *tabheadview;            //导航条
@property (assign, nonatomic) NSInteger curpage;                   //当前页
@end
