//
//  CollocationModel.h
//  YunShangShiJi
//
//  Created by zgl on 16/6/21.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "BaseModel.h"
#import "CollocationShopModel.h"
#import "CollocationTypeModel.h"

@interface CollocationModel : BaseModel

@property (nonatomic, assign) NSInteger cID;                //id
@property (nonatomic, copy) NSString *collocation_name;     //标题
@property (nonatomic, copy) NSString *collocation_name2;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, copy) NSString *collocation_code;     //编号
@property (nonatomic, copy) NSString *collocation_pic;      //图片
@property (nonatomic, strong) NSArray *collocation_shop;    //搭配商品列表（CollocationShopModel）
@property (nonatomic, strong) NSArray *shop_type_list;      //关联商品列表（CollocationTypeModel）

@property (nonatomic, assign) BOOL isHighlight;

@end
