//
//  RelationShopViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/5/19.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoMentionView.h"
typedef NS_ENUM(NSInteger,SelectShopType){
    shop_meiyiType = 0,
    shop_chuandaType = 1
};

@interface RelationShopViewController : UIViewController
@property (nonatomic, strong) UICollectionView *collectionView;

@property (strong, nonatomic) UIImageView *tabheadview;            //导航条
@property (strong, nonatomic) UIView *shareView;                   //分享视图
@property (strong, nonatomic) UISegmentedControl *segment;         //选择器
@property (strong, nonatomic) NoMentionView *nomentionView;        //提示
@property (assign, nonatomic) SelectShopType selectShareType;
@property (nonatomic , copy) void(^selectShopBlock)(NSString *shopBrand,NSNumber *shopBrandID,NSString *shop_code);

@end
