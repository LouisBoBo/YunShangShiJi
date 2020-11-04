//
//  AddShopModel.h
//  YunShangShiJi
//
//  Created by zgl on 16/6/20.
//  Copyright © 2016年 ios-1. All rights reserved.
//  搭配购

#import "BaseModel.h"

@class DPShopModel;

@interface AddShopModel : BaseModel

@property (nonatomic, assign) NSInteger status;      //结果
@property (nonatomic, copy) NSString *message;       //结果信息
@property (nonatomic, copy) NSDictionary *shop_attr; //颜色尺码
@property (nonatomic, copy) NSArray *stocktype;      //内容

+ (void)getAddShopModelWithShopCodes:(NSString *)shopCodes success:(void (^)(id data))success;

@end


@interface DPShopModel : BaseModel

@property (nonatomic, copy) NSArray *colors;            //颜色
@property (nonatomic, copy) NSArray *sizes;             //尺码
@property (nonatomic, copy) NSArray *others;            //其它
@property (nonatomic, copy) NSString *colorTitle;       //颜色名称
@property (nonatomic, copy) NSString *sizeTitle;        //尺码名称
@property (nonatomic, copy) NSString *otherTitle;       //其它名称
@property (nonatomic, copy) NSString *selectcolor;      //选中的颜色
@property (nonatomic, copy) NSString *selectsize;       //选中的尺码

@property (nonatomic, assign) NSInteger sID;            //id
@property (nonatomic, copy) NSString *color_size;       //颜色_尺码
@property (nonatomic, copy) NSString *pic;              //图片
@property (nonatomic, copy) NSString *shop_code;        //商品编号
@property (nonatomic, copy) NSString *shop_name;        //商品名称
@property (nonatomic, copy) NSString *kickback;         //回扣
@property (nonatomic, copy) NSString *three_kickback;   //3级回扣
@property (nonatomic, copy) NSString *two_kickback;     //两级回扣
@property (nonatomic, copy) NSString *original_price;   //原价（供应商价格）
@property (nonatomic, copy) NSString *core;             //积分（供应商价格算出的最多可使用积分）
@property (nonatomic, copy) NSString *price;            //价格（现价）
@property (nonatomic, copy) NSString *shop_price;       //商品价格（以前的价格）
@property (nonatomic, assign) NSInteger stock;          //库存
@property (nonatomic, copy) NSString *supp_id;          //供应商ID
@property (nonatomic, assign) BOOL isFight;             //是否是拼团
/************************** 交互相关 ****************************/
@property (nonatomic, assign) BOOL isSelect;            //是否选中
@property (nonatomic, assign) NSUInteger colorIndex;    //选中颜色
@property (nonatomic, assign) NSUInteger sizeIndex;     //选中尺码
@property (nonatomic, assign) NSUInteger otherIndex;    //选中其它
@property (nonatomic, assign) NSUInteger shopNumber;    //数量

@end
