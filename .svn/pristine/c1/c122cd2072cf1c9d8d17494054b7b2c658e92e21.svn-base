//
//  memberRawardsFriends.h
//  YunShangShiJi
//
//  Created by hebo on 2019/9/16.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface memberRawardsFriends : BaseModel
@property (nonatomic , assign) NSInteger status;
@property (nonatomic , copy)   NSString *message;
@property (nonatomic , strong) NSMutableArray *friendsdata;

+ (void)getFriendsData:(NSInteger)page Success:(void(^)(id))success;
@end

NS_ASSUME_NONNULL_END
