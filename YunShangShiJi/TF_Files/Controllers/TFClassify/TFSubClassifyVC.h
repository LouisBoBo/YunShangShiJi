//
//  TFSubClassifyVC.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2017/1/19.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TFBaseViewController.h"
#import "SqliteManager.h"
@interface TFSubClassifyVC : TFBaseViewController
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ShopTypeItem *item;
@property (nonatomic, assign) CGFloat headerView_H;
@end
