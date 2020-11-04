//
//  SelectPhotoViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/9.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectPhotoViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) NSMutableArray *dataSource;          //数据源
@property (strong, nonatomic) UICollectionView *collectionView;    //列表
@property (strong, nonatomic) UIImageView *tabheadview;            //导航条
@property (strong, nonatomic) UIButton *okbtn;                     //确定按钮
@property (strong, nonatomic) NSArray *photoData;

@property (strong, nonatomic) void(^selectPhotoBlock)(NSArray* images);
@end
