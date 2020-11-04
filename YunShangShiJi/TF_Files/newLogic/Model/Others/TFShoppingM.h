//
//  ShoppingModel.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/6.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "PublicModel.h"
@interface TFShoppingM : PublicModel
@property (assign,nonatomic)BOOL isSelect;
@property (copy, nonatomic) NSString *shop_code;
@property (copy, nonatomic) NSString *shop_name;
@property (copy, nonatomic) NSString *def_pic;
@property (copy, nonatomic) NSString *show_pic;
@property (copy, nonatomic) NSString *four_pic;
@property (strong, nonatomic) NSNumber *shop_se_price;
@property (strong, nonatomic) NSNumber *shop_status;
@property (strong, nonatomic) NSNumber *kickback;
@property (strong, nonatomic) NSNumber *virtual_sales;
@property (strong, nonatomic) NSNumber *shop_price;
@property (strong, nonatomic) NSNumber *supp_label_id;
@property (copy, nonatomic) NSString *supp_label;
@property (copy, nonatomic) NSString *roll_price;
@property (strong, nonatomic) NSNumber *ID;
@property (strong, nonatomic) NSNumber *type;
@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *h5_url;
@property (copy, nonatomic) NSString *remark;
@property (strong, nonatomic) NSNumber *option_type;
@property (strong, nonatomic) NSNumber *app_shop_group_price;

//何波加的2016-10-24
@property (nonatomic , strong)NSString *name;
@property (nonatomic , strong)NSString *content1;
@property (nonatomic , strong)NSString *content2;


//夺宝—新增商品列表页3.5.4
@property (nonatomic, strong) NSNumber *active_people_num;//总人数
@property (nonatomic, strong) NSNumber *involved_people_num;//已参与人数

//
@property (nonatomic , strong)NSNumber *isVip;
@property (nonatomic , strong)NSString *maxType;
@property (nonatomic , assign)CGFloat reduceMoney;
@property (nonatomic , copy)  NSString * shop_deduction;
@end
