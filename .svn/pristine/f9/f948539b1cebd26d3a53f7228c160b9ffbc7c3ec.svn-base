//
//  SelectShareTypeViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/4/7.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SelectShareType){
    share_meiyiType = 0,
    share_chuandaType = 1
};
@interface SelectShareTypeViewController : UIViewController
@property (nonatomic, strong) UICollectionView *collectionView;

@property (strong, nonatomic) UIImageView *tabheadview;            //导航条
@property (strong, nonatomic) UIView *shareView;                   //分享视图
@property (strong, nonatomic) UISegmentedControl *segment;         //选择器
@property (assign, nonatomic) SelectShareType selectShareType;
@property (assign, nonatomic) BOOL hideSegment;
@property (assign, nonatomic) BOOL ISInvit;                        //邀请好友
@property (nonatomic , strong) dispatch_block_t TaskFinishBlock;
@end
