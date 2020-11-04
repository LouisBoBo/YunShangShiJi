//
//  vipInfoModel.h
//  YunShangShiJi
//
//  Created by hebo on 2019/6/21.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface vipInfoModel : BaseModel
@property (nonatomic , assign) NSInteger status;
@property (nonatomic , copy)   NSString *message;
@property (nonatomic , assign) NSInteger is_buy;
@property (nonatomic , assign) NSInteger isVip;
@property (nonatomic , assign) NSInteger vip_type;
@property (nonatomic , assign) NSInteger vip_page;
@property (nonatomic , assign) NSInteger vip_free;
@property (nonatomic , assign) NSInteger ordervip_free;
@property (nonatomic , assign) NSInteger first_group;
@property (nonatomic , copy)   NSString *free_page;
@property (nonatomic , copy)   NSString *vipFreeText;
@property (nonatomic , assign) NSInteger maxType;

//获取用户会员信息
+ (void)Getvip_userInfoDataSuccess:(NSString*)shop_code T:(NSInteger)t Page:(NSInteger)page3 Success:(void (^)(id data))success;
//获取是否是会员
+ (void)addUserVipOrderSuccess:(void(^)(id))success;
@end

NS_ASSUME_NONNULL_END
