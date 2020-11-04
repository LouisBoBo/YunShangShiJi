//
//  TFGroupBuyVM.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2016/11/25.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "BaseModel.h"
#import "PagerModel.h"

@interface TFGroupBuyVM : BaseModel
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, strong) PagerModel *pager;            //页码
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *message;       //结果信息

@property (nonatomic, strong) TFTableViewService *tableViewService;

- (void)getGroupBuysShopListWithCurPage:(NSInteger)curPage success:(void (^)(id data))success;

@end

@interface TFGroupBuyShop : BaseModel

/**< “user_name ”：”卡卡京东方”
 “user_portrait  ”: ” LIEnDjTm_600_900.jpg”
 “r_code ”: “MAOQ15423130”
 “shop_url ”:” LIEnDjTm_600_900.jpg”          
 “shop_name”:” 简约百搭绣花拉链刺绣短裙”
 “ shop_original “：“69”
 “shop_roll ”： “54”
 */

@property (copy, nonatomic) NSString *user_name;    //用户名称
@property (copy, nonatomic) NSString *user_portrait;//用户头像
@property (copy, nonatomic) NSString *r_code;       //拼团编号
@property (copy, nonatomic) NSString *shop_url;     //图片
@property (copy, nonatomic) NSString *shop_name;    //商品名称
@property (strong, nonatomic) NSNumber *shop_original;//商品原价
@property (strong, nonatomic) NSNumber *shop_roll;     //商品拼团价格
@property (strong, nonatomic) NSNumber *add_time;
@property (strong, nonatomic) NSNumber *end_time;
@property (strong, nonatomic) NSNumber *Id;
@property (copy, nonatomic) NSString *order_code;
@property (copy, nonatomic) NSString *shop_code;
@property (strong, nonatomic) NSNumber *status;
@property (strong, nonatomic) NSNumber *user_id;


@end
