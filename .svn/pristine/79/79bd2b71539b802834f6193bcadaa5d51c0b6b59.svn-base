//
//  ShopSaleModel.h
//  YunShangShiJi
//
//  Created by zgl on 16/8/6.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "BaseModel.h"
#import "SaleListModel.h"

@interface ShopSaleModel : BaseModel

@property (nonatomic, assign) long ID;                                  //id
@property (nonatomic, copy) NSString *p_code;                           //商品编号
@property (nonatomic, copy) NSString *p_name;                           //商品名称
@property (nonatomic, copy) NSString *p_s_t_id;                         //库存ID
@property (nonatomic, assign) NSInteger p_type;                         //类型
@property (nonatomic, copy) NSString *def_pic;                          //商品图片
@property (nonatomic, assign) NSInteger postage;                        //
@property (nonatomic, assign) NSInteger shop_num;                       //商品数量
@property (nonatomic, assign) CGFloat shop_price;                       //商品价格(以前的价格)
@property (nonatomic, assign) CGFloat shop_se_price;                    //商品出售价格
@property (nonatomic, copy) NSMutableArray<SaleListModel *> *shop_list; //列表
@property (nonatomic, assign) BOOL expired;                             //是否失效
@property (nonatomic, assign) BOOL valid;                               //是否下架
@property (nonatomic, assign) NSTimeInterval date_time;                 //加入时间

@end
