//
//  YiFuUserInfo.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2016/11/11.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "YiFuUserInfo.h"
#import "YiFuUserInfoManager.h"
@implementation YiFuUserInfo

- (instancetype)init
{
    if (self = [super init]) {
        _userId = @0;
        _userName = @"";
        _userIdenf = @"";
    }
    return self;
}

+ (LKDBHelper *)getUsingLKDBHelper {
    return [[LKDBHelper alloc] initWithDBName:[YiFuUserInfoManager getUserDBName]];
}

+ (void)initialize
{
    [self removePropertyWithColumnName:@"error"];
}


/**
 设定表名

 @return
 */
+ (NSString *)getTableName
{
    return @"yiFuUserInfoTable";
}


/**
 返回主键

 @return <#return value description#>
 */
+ (NSString *)getPrimaryKey
{
    return @"dbId";
}

@end
