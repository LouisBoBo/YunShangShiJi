//
//  CollocationShopModel.h
//  YunShangShiJi
//
//  Created by zgl on 16/6/21.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface CollocationShopModel : BaseModel

@property (nonatomic, copy) NSString *shop_code;        //商品编号
@property (nonatomic, copy) NSString *shop_name;        //商品名称
@property (nonatomic, assign) CGFloat shop_se_price;    //商品出售价格
@property (nonatomic, assign) NSInteger option_flag;    //0有搭配，1无搭配
@property (nonatomic, assign) CGFloat shop_x;           //图片相对x位置
@property (nonatomic, assign) CGFloat shop_y;           //图片相对y位置
@property (nonatomic, assign) CGFloat kickback;
@property (nonatomic, assign) CGFloat shop_price;       //商品原价
@property (nonatomic, copy) NSString *def_pic;          //默认图片
@property (nonatomic, assign) NSInteger shop_id;        //ID

@property (nonatomic, assign) NSInteger supp_label_id;  //供应商ID
@property (nonatomic, copy) NSString *supp_label;     //供应商名称

@property (nonatomic, assign) BOOL isHighlight;

@end
