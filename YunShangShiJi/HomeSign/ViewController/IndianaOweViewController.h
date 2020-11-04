//
//  IndianaOweViewController.h
//  YunShangShiJi
//
//  Created by 云商 on 15/7/23.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFBaseViewController.h"
#import "ShopDetailModel.h"
#import "TFPhotoView.h"
#import "ScoreModel.h"
#import "TreasureRecordsModel.h"
@interface IndianaOweViewController : TFBaseViewController

@property (nonatomic,strong)ShopDetailModel *Ordermodel;

@property (nonatomic,strong)NSString *typestr;

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSMutableArray *modelArr;

@property (nonatomic, strong)TreasureRecordsModel *recordsModel;

@end
