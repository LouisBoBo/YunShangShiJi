//
//  GuideIndianaModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/9/1.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface GuideIndianaModel : BaseModel

/**
 shop_code     //商品编号
 user_id       //用户id
 sup_user_id   //上级用户（团长）
 status        0默认未参团，1已参团
 */
@property (nonatomic, assign) NSInteger status;      //状态
@property (nonatomic, copy)   NSString *message;     //提示
@property (nonatomic, copy)   NSDictionary * shareData;
@property (nonatomic, copy)   NSString *shop_code;
@property (nonatomic, copy)   NSString *user_id;
@property (nonatomic, copy)   NSString *sup_user_id;

+(void)guideIndianaDataSuccess:(void(^)(id data))success;
+(void)changIndianaDataSuccess:(void(^)(id data))success;
@end
