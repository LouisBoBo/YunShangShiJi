//
//  SubmitLikeModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/18.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface SubmitLikeModel : BaseModel
@property (nonatomic, assign) NSInteger status;          //状态
@property (nonatomic, copy) NSString *message;           //提示
@property (nonatomic, copy) NSString *theme_id;          //帖子ID
/*
 * title 标题
 * content 文本
 * pics 图片
 * tags 标签
 * location 位置
 * theme_type 类型  1 精选推荐，2 穿搭，3 普通话题
 * shop_codes 商品编号
 *	当theme_type=1时shop_codes ,
 * 当theme_type=2时type1,type2,supp_label_id,tag_info
 * 常规参数
 */

+(void)SubmitShopLikeTitle:(NSString*)title Content:(NSString*)content Pics:(NSString*)pics Tags:(NSString*)tags Location:(NSString*)location Theme_type:(NSInteger)type Shopcodes:(NSString*)shopcodes Success:(void(^)(id data))success;
@end
