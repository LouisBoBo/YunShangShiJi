//
//  TFMyShopViewController.h
//  YunShangShiJi
//
//  Created by 云商 on 15/8/6.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFBaseViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "TFJSObjCModel.h"
#import "GlobalTool.h"
 

#import "TYSlidePageScrollView.h"
#import "CustomTitleView.h"
#import "CollectionViewController.h"
@interface TFMyShopViewController : TFBaseViewController <TYSlidePageScrollViewDataSource, TYSlidePageScrollViewDelegate,collectionViewCustomDelegate>

@property (nonatomic ,assign) BOOL                  isHeadView;
@property (nonatomic ,assign) BOOL                  isFootView;

@property (nonatomic, strong) CustomTitleView       *nTitleView;

@property (nonatomic, strong) NSMutableArray        *typeIndexArr;

@end
