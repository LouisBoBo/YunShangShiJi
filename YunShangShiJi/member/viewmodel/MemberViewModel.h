//
//  MemberViewModel.h
//  YunShangShiJi
//
//  Created by hebo on 2019/5/27.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface MemberViewModel : NSObject
@property (nonatomic , strong) NSMutableArray *uservipList;
@property (nonatomic , strong) NSMutableArray *vipList;
@property (nonatomic , assign) NSInteger max_vipTypeIndex;
@property (nonatomic , copy)   NSString *bouns;
@property (nonatomic , copy)   NSString *raffle_money;
//获取会员卡列表数据
- (void)getVipData:(void(^)())success;
//添加会员卡
- (void)addUserVipCard:(NSInteger)vipcount VipType:(NSInteger)viptype Success:(void(^)(id))success;
//添加会员卡下单
- (void)addUserVipOrder:(NSString*)vipcode Success:(void(^)(id))success;
@end

NS_ASSUME_NONNULL_END
