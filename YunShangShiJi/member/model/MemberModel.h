//
//  MemberModel.h
//  YunShangShiJi
//
//  Created by hebo on 2019/5/27.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MemberModel : BaseModel
@property (nonatomic , assign) NSInteger status;
@property (nonatomic , copy)   NSString *message;
@property (nonatomic , copy)   NSString *v_code;
@property (nonatomic , copy)   NSString *bouns;
@property (nonatomic , copy)   NSString *actual_price;
@property (nonatomic , copy)   NSString *raffle_money;
@property (nonatomic , strong) NSMutableArray *vipdata;
@property (nonatomic , strong) NSMutableArray *uservipdata;
+ (void)getVipData:(NSInteger)jupm Success:(void(^)(id))success;
+ (void)addUserVipCard:(NSInteger)vipcount VipType:(NSInteger)viptype Success:(void(^)(id))success;
+ (void)addUserVipOrder:(NSString*)vipcode Success:(void(^)(id))success;

@end

NS_ASSUME_NONNULL_END