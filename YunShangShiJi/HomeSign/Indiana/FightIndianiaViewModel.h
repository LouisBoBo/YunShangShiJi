//
//  FightIndianiaViewModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/8/31.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface FightIndianiaViewModel : BaseModel
@property (nonatomic, assign) NSInteger status;    //状态
@property (nonatomic, copy)   NSString *message;   //提示
@property (nonatomic, strong) NSMutableArray *data;//拼团夺宝参与记录


/**拼团夺宝开团、参团

 shop_code 商品编号
 type      1开团 2参团
 tuserId   团长的用户ID 当type=2时必选
 */
+(void)acticveIndianaHttpShopCode:(NSString*)shop_code Type:(NSInteger)type ID:(NSString*)tuserId Success:(void(^)(id data))success;

/**拼团夺宝参与记录
 
 shop_code 商品编号
 issue_code 期号
 */
+(void)activeRecordHttpShopCode:(NSString*)shop_code Issue_code:(NSString*)issue_code Page:(NSInteger)page Success:(void(^)(id data))success;
@end
