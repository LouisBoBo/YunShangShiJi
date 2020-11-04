//
//  LikeModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/1/19.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface LikeModel : BaseModel
@property (nonatomic , copy) NSString *shop_code;                //商品编号
@property (nonatomic , copy) NSString *show_pic;                 //商品图片
@property (nonatomic , copy) NSString *shop_name;                //商品名称
@property (nonatomic , copy) NSString *shop_price;               //商品出产价
@property (nonatomic , copy) NSString *shop_se_price;            //商品售价
@property (nonatomic , copy) NSString *supp_label;               //商品制造商
@property (nonatomic , copy) NSString *app_shop_group_price;     //一元购价格
@property (nonatomic , copy) NSString *virtual_sales;            //虚拟销量

@property (nonatomic,strong)NSNumber *isVip;
@property (nonatomic,strong)NSNumber *maxType;
@property (nonatomic , assign)CGFloat reduceMoney;
@property (nonatomic , copy)  NSString * shop_deduction;
@end
