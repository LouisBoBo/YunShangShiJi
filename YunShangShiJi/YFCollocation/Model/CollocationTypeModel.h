//
//  CollocationTypeModel.h
//  YunShangShiJi
//
//  Created by zgl on 16/6/23.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface CollocationTypeModel : BaseModel

@property (nonatomic, assign) NSInteger type_id; //一级类目id
@property (nonatomic, strong) NSArray *list;   //商品列表

@end
