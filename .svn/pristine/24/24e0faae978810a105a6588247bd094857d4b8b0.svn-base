
//
//  FMDBUserInfoManager.m
//  YunShangShiJi
//
//  Created by yssj on 16/3/23.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "FMDBUserInfoManager.h"
#import "FMDatabase.h"


static FMDBUserInfoManager *userInfoManager=nil;

@implementation FMDBUserInfoManager
{
    FMDatabase* _db;
}

+(FMDBUserInfoManager *)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (userInfoManager==nil) {
            userInfoManager = [[FMDBUserInfoManager alloc]init];
        }
    });
    return userInfoManager;
}

-(instancetype)init
{
    if (self = [super init]) {
        
        //数据库路径
        NSString* path = [NSString stringWithFormat:@"%@/Documents/userInfoData.db", NSHomeDirectory()];
        _db = [[FMDatabase alloc] initWithPath:path];
        //打开
        if (![_db open]) {
            //打开失败");
        }
        
        //创建搜索表
        BOOL res = [_db executeUpdate:@"create table if not exists USERINFO(uid integer primary key autoincrement,user_id,user_token,user_name)"];
        if (res == NO) {
            //用户表创建失败");
        }
    }
    
    return self;
}

-(void)addUserInfo:(MYUserInfo *)userInfo
{
    NSString *sql=[NSString stringWithFormat:@"UPDATE USERINFO SET user_id='%@',user_token='%@',user_name='%@' WHERE user_id='%@'",userInfo.user_id,userInfo.user_token,userInfo.user_name,userInfo.user_id];
    BOOL result =[_db executeUpdate:sql];
    
    if (result) {
        //success");
    }else
    {
        BOOL res = [_db executeUpdate:@"insert into USERINFO(user_id,user_name) values(?,?)", userInfo.user_id,userInfo.user_name];
        if (res == NO) {
            //插入用户失败");
            return;
        }
    }
    
}
@end
