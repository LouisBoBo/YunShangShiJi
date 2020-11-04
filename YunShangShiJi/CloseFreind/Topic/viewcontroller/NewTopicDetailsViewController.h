//
//  NewTopicDetailsViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/5/16.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTopicDetailsViewController : UIViewController
@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) UIImageView *tabheadview;            //导航条
@property (nonatomic, assign) BOOL isFinish;
@property (strong, nonatomic) NSMutableArray *dataSource;          //数据源

@property (nonatomic , strong) NSString *theme_id;                //帖子ID
@property (nonatomic , assign) NSInteger recommentPage;         //相关推荐当前页
@end
