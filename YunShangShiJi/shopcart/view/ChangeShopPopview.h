//
//  ChangeShopPopview.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/1/18.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopDetailModel.h"
#import "BaseModel.h"
@class DPShopModel;
@interface ChangeShopPopview : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UIView *Popview;
@property (nonatomic , strong) UIView *BackView;
@property (nonatomic , strong) UITableView *mainTableView;
@property (nonatomic , strong) ShopDetailModel * shopdetailModel;    //商品详情数据
@property (nonatomic , strong) NSMutableArray *dataDictionaryArray;  //属性数据
@property (nonatomic , assign) BOOL isActive;                        //是活动商品
@property (nonatomic , assign) BOOL miniShareSuccess;                //小程序是否分享成功
@property (nonatomic , assign) BOOL isNewbie;                        //是否是新用户
@property (nonatomic , assign) BOOL isfreeLingClick;                 //是否点击免费领
@property (nonatomic , strong) dispatch_block_t closePopviewBlock;
@property (nonatomic , strong) void(^okChangeBlock)(ShopDetailModel *model);

- (instancetype)initWithFrame:(CGRect)frame ShopModel:(ShopDetailModel*)model;


@end
