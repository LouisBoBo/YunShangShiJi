//
//  TShoplistModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/25.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface TShoplistModel : BaseModel
/*
 "shop_list" : [// 商品列表
 {
 "shop_code" : "EDFF58452",  // 商品编号
 "def_pic" : "main.png",  // 商品主图
 "shop_se_price" : 12.25, // 商品售价
 "shop_price" : 154.2,  // 商品原价
 "supp_label" : "ZARA制造商"// 品牌
 },
 */
@property (nonatomic , strong) NSString *shop_code;
@property (nonatomic , strong) NSString *def_pic;
@property (nonatomic , strong) NSString *shop_se_price;
@property (nonatomic , strong) NSString *shop_price;
@property (nonatomic , strong) NSString *supp_label;
@property (nonatomic , strong) NSString *shop_name;
@property (nonatomic , assign) NSInteger shop_status;
@property (nonatomic , strong) NSString *app_shop_group_price;
@property (nonatomic , strong) NSString *virtual_sales;
@end
