//
//  CollocationDetailModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 16/6/23.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollocationDetailModel : NSObject

@property (nonatomic, copy) NSString *collocation_code;
@property (nonatomic, copy) NSString *collocation_name;
@property (nonatomic, copy) NSString *collocation_pic;
@property (nonatomic, copy) NSString *collocation_remark;
@property (nonatomic, copy) NSString *add_time;
@property (nonatomic, copy) NSString *c_time;
@property (nonatomic, copy) NSString *s_time;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *type_relation_ids;
@property (nonatomic, copy) NSArray *collocation_shop;
@property (nonatomic, copy) NSArray *attrList;
@property (nonatomic, copy) NSString *cart_count;

@end
