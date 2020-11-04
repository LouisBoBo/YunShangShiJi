//
//  YiFuUserDBManager.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2016/11/11.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "YiFuUserInfoManager.h"

@interface YiFuUserInfoManager ()

/**
 表中的user数量
 */
@property (nonatomic, assign, readwrite)NSUInteger userInfoCount;

/**
 数据库是否存在
 */
@property (nonatomic, assign) BOOL isDB;

@end

@implementation YiFuUserInfoManager
/**
 用户数据管理单例

 @return <#return value description#>
 */
+ (instancetype)shareInstance
{
    static YiFuUserInfoManager* shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[YiFuUserInfoManager alloc] init];
    });
    shareInstance.isDB = [LKDBUtils isFileExists:[LKDBHelper getDBPathWithDBName:[self getUserDBName]]];
    return shareInstance;
}

- (NSUInteger)userInfoCount
{
    if (_isDB && [YiFuUserInfo isTableCreated]) {
        NSLog(@"进入");
        NSArray *userList = [[YiFuUserInfo getUsingLKDBHelper] searchWithSQL:@"select * from @t" toClass:[YiFuUserInfo class]];
        return userList.count;
    } else {
        return 0;
    }
    return 0;
}

+ (NSString *)getUserDBName {
    return [NSString stringWithFormat:@"YiFuUser/YiFuUserDB"];
}

#pragma mark - 数据库操作
+ (void)insertUserInfo:(YiFuUserInfo *)user
{
    YiFuUserInfo *searchUser = [self searchUserInfoWithUserId:user.userId];
    if (searchUser) {
        searchUser.userIdenf = user.userIdenf;
        searchUser.userName = user.userName;
        [searchUser updateToDB];
    } else {
        [user saveToDB];
    }
}

+ (void)insertUserInfoList:(NSArray *)userList
{
    for (YiFuUserInfo *user in userList) {
        [self insertUserInfo:user];
    }
}

+ (BOOL)deleteUserInfo:(YiFuUserInfo *)user
{
    YiFuUserInfo *searchUser = [self searchUserInfoWithUserId:user.userId ];
    return [searchUser deleteToDB];
}

+ (void)deleteUserInfoList:(NSArray *)userList
{
    for (YiFuUserInfo *user in userList) {
        [self deleteUserInfo:user];
    }
}

+ (YiFuUserInfo *)searchUserInfoWithUserId:(NSNumber *)userId
{
    NSString *where = [NSString stringWithFormat:@"userId='%@'",userId];
    YiFuUserInfo *searchUser = [YiFuUserInfo searchSingleWithWhere:where orderBy:nil];
    return searchUser;
}

+ (NSArray *)searchUserInfoWithUserIdList:(NSArray *)userIdList
{
    NSMutableArray *searchUserList = [NSMutableArray array];
    for (NSNumber *userId in userIdList) {
        YiFuUserInfo *searchUser = [self searchUserInfoWithUserId:userId];
        if (searchUser) {
            [searchUserList addObject:searchUser];
        }
    }
    return searchUserList;
}

+ (NSUInteger)userInfoCountOfManager
{
    return [[YiFuUserInfoManager shareInstance] userInfoCount];
}

@end




