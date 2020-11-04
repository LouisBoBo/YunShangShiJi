//
//  SalePListModel.h
//  YunShangShiJi
//
//  Created by 云商 on 15/12/2.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SalePListModel : NSObject <NSMutableCopying, NSCopying>
/**
 *  自定义此套餐商品件数
 */
@property (nonatomic, assign)NSInteger shopNum;     //件数
/**
 *  剩余件数
 */
@property (nonatomic, assign)NSInteger shopCount;   //剩余件数

@property (nonatomic, copy)NSString *r_num;         //剩余件数
@property (nonatomic, copy)NSString *num;           //总数
@property (nonatomic, copy)NSString *price;         //套餐价格
@property (nonatomic, copy)NSString *name;          //套餐名字
@property (nonatomic, copy)NSString *seq;           //排序字段
@property (nonatomic, copy)NSString *code;          //套餐code
@property (nonatomic, copy)NSString *type;          //套餐类型
@property (nonatomic, copy)NSString *postage;       //邮费

@property (nonatomic, strong)NSDictionary *_id;
@property (nonatomic, strong)NSNumber *ID;
@property (nonatomic, strong)NSNumber *status;
@property (nonatomic, copy)NSString *def_pic;
@property (nonatomic, strong)NSNumber *add_date;
@property (nonatomic, copy)NSString *shop_codes;    //商品编号
@property (nonatomic, copy)NSString *seq_ids;
@property (nonatomic, copy)NSString *shelf_type;
@property (nonatomic, strong)NSArray *shop_list;    //套餐下商品列表
@property (nonatomic, strong)NSNumber *is_top;


@end
