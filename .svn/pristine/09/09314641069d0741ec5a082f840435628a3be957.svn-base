//
//  CollectionViewCell.h
//  UiTabBarController
//
//  Created by apple on 15/3/2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopDetailModel.h"

@protocol OverheadDelegate <NSObject>

-(void)Overhead:(NSInteger)index;

@end

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *shopprice;
@property (weak, nonatomic) IBOutlet UILabel *lovenumber;
@property (weak, nonatomic) IBOutlet UILabel *lableline;
@property (weak, nonatomic) IBOutlet UIImageView *lovenum;
@property (weak, nonatomic) IBOutlet UIImageView *shopcar;
@property (weak, nonatomic) IBOutlet UIButton *exchangebtn;

@property (assign, nonatomic) CGFloat Heigh;
@property (weak, nonatomic) IBOutlet UIButton *overhead;

@property(nonatomic,assign)NSInteger row;
@property (nonatomic ,strong)id<OverheadDelegate>delegate;

-(void)creashData:(ShopDetailModel*)model;

-(void)creashData1:(ShopDetailModel*)model;
@end
