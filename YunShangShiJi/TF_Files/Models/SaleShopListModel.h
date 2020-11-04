//
//  SaleShopListModel.h
//  YunShangShiJi
//
//  Created by 云商 on 15/12/2.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SalePListModel.h"
@interface SaleShopListModel : NSObject

@property (nonatomic, strong)SalePListModel *pModel;

@property (nonatomic, copy  ) NSString *def_pic;//图片
@property (nonatomic, strong) NSNumber *virtual_sales;//多少人在抢（虚拟销量）
@property (nonatomic, strong) NSNumber *invertory_num;//剩余多少件
@property (nonatomic, strong) NSString *p_code;//套餐code
@property (nonatomic, strong) NSString *shop_name;//商品名称
@property (nonatomic, strong) NSNumber *shop_price;//原来商品价格
@property (nonatomic, strong) NSNumber *shop_se_price;//折后价
@property (nonatomic, strong) NSString *shop_code;//商品code

@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSString *shop_attr;//商品属性
@property (nonatomic, strong) NSNumber *shop_ratio;
@property (nonatomic, strong) NSString *shop_pic;//图片ID列表
@property (nonatomic, strong) NSNumber *shelf;
@property (nonatomic, strong) NSNumber *shop_up_time;//商品上架时间
@property (nonatomic, copy  ) NSString *is_new;//是否新品
@property (nonatomic, copy  ) NSString *is_hot;//是否热门
@property (nonatomic, strong) NSNumber *add_time;//时间
@property (nonatomic, strong) NSNumber *audit_time;
@property (nonatomic, strong) NSNumber *actual_sales;//实际销量
@property (nonatomic, strong) NSNumber *adm_id;
@property (nonatomic, strong) NSNumber *supp_id;//供应商id
@property (nonatomic, copy  ) NSString *content;//商品简介
@property (nonatomic, strong) NSNumber *clicks;//点击量
@property (nonatomic, strong) NSNumber *shop_status;
@property (nonatomic, copy  ) NSString *remark;//备注
@property (nonatomic, strong) NSNumber *love_num;//喜欢人数
@property (nonatomic, copy  ) NSString *four_pic;//900*900
@property (nonatomic, copy  ) NSString *p_seq;
@property (nonatomic, strong) NSNumber *is_virtual;
@end
