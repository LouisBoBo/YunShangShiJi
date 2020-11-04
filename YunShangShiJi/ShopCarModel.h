//
//  ShopCarModel.h
//  YunShangShiJi
//
//  Created by zgl on 16/8/5.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface ShopCarModel : BaseModel

@property (nonatomic, assign) long ID;               //购物车id
@property (nonatomic, copy) NSString *paired_code;   //搭配编号
@property (nonatomic, copy) NSString *shop_code;     //商品编号
@property (nonatomic, copy) NSString *shop_name;     //商品名称
@property (nonatomic, assign) long stock_type_id;    //库存ID
@property (nonatomic, assign) long supp_id;          //供应商ID
@property (nonatomic, copy) NSString *def_pic;       //商品图片
@property (nonatomic, copy) NSString *color;         //商品颜色
@property (nonatomic, copy) NSString *size;          //商品尺码
@property (nonatomic, assign) NSInteger shop_num;    //商品数量
@property (nonatomic, assign) CGFloat shop_price;    //商品价格(以前的价格)
@property (nonatomic, assign) CGFloat shop_se_price; //商品出售价格
@property (nonatomic, assign) CGFloat original_price;//商品原价
@property (nonatomic, assign) CGFloat kickback;      //回扣
@property (nonatomic, assign) BOOL expired;          //是否失效
@property (nonatomic, assign) BOOL is_del;           //是否下架（老接口）
@property (nonatomic, assign) BOOL valid;            //是否下架
@property (nonatomic ,copy)NSString *supp_label;     //供应商
@property (nonatomic, assign) int stock;             //商品库存
@property (nonatomic, assign) NSTimeInterval date_time; //加入时间


@end
