//
//  YiFuUserDBManager.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2016/11/11.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YiFuUserInfo.h"
@interface YiFuUserInfoManager : NSObject
@property (nonatomic, assign, readonly)NSUInteger userInfoCount;

/**
 单例

 @return <#return value description#>
 */
+ (instancetype)shareInstance;


/**
 返回DB名字

 @return <#return value description#>
 */
+ (NSString *)getUserDBName;

/**
 插入一个user 数据

 @param user <#user description#>
 */
+ (void)insertUserInfo:(YiFuUserInfo *)user;


/**
 插入多条user 数据

 @param userList <#userList description#>
 */
+ (void)insertUserInfoList:(NSArray *)userList;


/**
 删除一个user 数据

 @param user <#user description#>
 @return <#return value description#>
 */
+ (BOOL)deleteUserInfo:(YiFuUserInfo *)user;


/**
 批量删除user 数据

 @param userList <#userList description#>
 @return <#return value description#>
 */
+ (void)deleteUserInfoList:(NSArray *)userList;


/**
 根据userId查找一个user 数据

 @param userId <#userId description#>
 @return <#return value description#>
 */
+ (YiFuUserInfo *)searchUserInfoWithUserId:(NSNumber *)userId;

/**
 批量查找

 @param userIdList <#userIdList description#>
 @return <#return value description#>
 */
+ (NSArray *)searchUserInfoWithUserIdList:(NSArray *)userIdList;



+ (NSUInteger)userInfoCountOfManager;

@end


