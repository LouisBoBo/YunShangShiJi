//
//  NewShoppingCartViewController.h
//  FJWaterfallFlow
//
//  Created by ios-1 on 2017/1/16.
//  Copyright © 2017年 fujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartViewModel.h"
#import "WaterFallFlowViewModel.h"
#import "NavgationbarView.h"
typedef NS_ENUM(NSInteger,CART_TYPE) {
    ShopCart_NormalType=0,
    ShopCart_TarbarType=1
};

@interface NewShoppingCartViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic , assign) CART_TYPE ShopCart_Type;
@property (nonatomic , strong) UICollectionView *MycollectionView;   //列表
@property (nonatomic , strong) UIButton *editButtonn;                //编辑按钮
@property (nonatomic , strong) ShoppingCartViewModel *viewmodel;     //数据模型
@property (nonatomic , strong) NavgationbarView *mentionview;        //提示框

@property (nonatomic , strong) NSMutableArray *likeArray;            //喜欢数据
@property (nonatomic, assign) NSInteger currPage;                //热门推荐当前页

//余额红包
@property (nonatomic, strong)UIButton *redMoneybtn;
@end
