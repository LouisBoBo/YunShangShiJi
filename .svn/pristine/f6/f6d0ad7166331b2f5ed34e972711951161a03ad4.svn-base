//
//  ShareToFriendsModel.h
//  YunShangShiJi
//
//  Created by yssj on 16/7/26.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface DataModel : BaseModel
@property (nonatomic, strong) NSString* link;
@property (nonatomic, strong) NSString* pic;
@end

@interface ShareToFriendsModel : BaseModel

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) DataModel* data;


+ (void)getModelWithToken:(NSString *)token success:(void (^)(id data))success;

@end

