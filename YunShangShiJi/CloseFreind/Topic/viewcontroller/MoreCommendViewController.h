//
//  MoreCommendViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/4/7.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreCommendViewController : UIViewController
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *shop_list;           //数据源
@property (strong, nonatomic) UIImageView *tabheadview;            //导航条
@property (strong, nonatomic) NSString *theme_id;                  //帖子id
@property (strong, nonatomic) NSString *custumTagID;               //标签id
@property (assign, nonatomic) NSInteger curpage;                   //当前页

@end

