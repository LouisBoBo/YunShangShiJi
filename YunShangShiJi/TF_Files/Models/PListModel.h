//
//  PListModel.h
//  YunShangShiJi
//
//  Created by 云商 on 16/5/4.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFShopModel.h"

@interface PListModel : NSObject
@property (nonatomic, strong)NSDictionary *_id;
@property (nonatomic, strong)NSNumber *ID;
@property (nonatomic, copy)NSString *code;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, strong)NSNumber *postage;
@property (nonatomic, strong)NSNumber *type;
@property (nonatomic, strong)NSNumber *seq;
@property (nonatomic, copy)NSString *shop_codes;
@property (nonatomic, copy)NSString *seq_ids;
@property (nonatomic, strong)NSNumber *price;
@property (nonatomic, strong)NSNumber *status;
@property (nonatomic, strong)NSNumber *num;
@property (nonatomic, strong)NSNumber *r_num;
@property (nonatomic, copy)NSString *def_pic;
@property (nonatomic, strong)NSNumber *add_date;
@property (nonatomic, strong)NSNumber *is_top;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, strong)NSArray *shop_list;

@property (nonatomic, strong)NSMutableArray *shopList;
@end