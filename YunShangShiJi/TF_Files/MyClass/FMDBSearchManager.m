//
//  FMDBSearchManager.m
//  YunShangShiJi
//
//  Created by 云商 on 16/3/7.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "FMDBSearchManager.h"
#import "FMDatabase.h"

@interface FMDBSearchManager () {
    FMDatabase* _db;
}

@end


static FMDBSearchManager *searchManager = nil;

@implementation FMDBSearchManager


+ (FMDBSearchManager *)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (searchManager == nil) {
            searchManager = [[FMDBSearchManager alloc] init];
        }
    });
    return searchManager;
}

/**
 *  初始化
 */
- (instancetype)init
{
    if (self = [super init]) {
        //数据库路径
        NSString* path = [NSString stringWithFormat:@"%@/Documents/searchData.db", NSHomeDirectory()];
        _db = [[FMDatabase alloc] initWithPath:path];
        //打开
        if (![_db open]) {
            //打开失败");
        }

        //创建搜索表
        BOOL res = [_db executeUpdate:@"create table if not exists SEARCH(uid integer primary key autoincrement,search)"];
        if (res == NO) {
            //搜索表创建失败");
        }
    }
    return self;
}

/**
 *  增加搜索
 */
- (void)addSearchItem:(SearchItem *)searchItem
{
    BOOL res = [_db executeUpdate:@"insert into SEARCH(search) values(?)", searchItem.searchText];
    if (res == NO) {
        //插入用户失败");
        return;
    }
}
/**
 *  按照搜索内容删除
 */
- (void)deleteSearchText:(NSString *)text
{
    BOOL res = [_db executeUpdate:@"delete from SEARCH where search=?", text];
    if (res) {
        //删除成功");
    }
}

/**
 *  按照uid删除搜索
 */
- (void)deleteSearchUid:(int)uid
{
    BOOL res = [_db executeUpdate:@"delete from SEARCH where uid=?", [NSNumber numberWithInt:uid]];
    if (res) {
        //删除成功");
    }
}

/**
 *  删除搜索表所有内容
 */
- (void)deleteSearchDB
{
    /*
    BOOL success;
    NSError *error;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString* path = [NSString stringWithFormat:@"%@/Documents/searchData.db", NSHomeDirectory()];
    // delete the old db.
    if ([fileManager fileExistsAtPath:path])
    {
        [_db close];
        success = [fileManager removeItemAtPath:path error:&error];
        if (!success) {
            NSAssert1(0, @"Failed to delete old database file with message '%@'.", [error localizedDescription]);
        }
    }
    */
    
    NSArray *searchItemArray = [self getAllSearchItem];
    for (SearchItem *item in searchItemArray) {
        [self deleteSearchUid:item.uid];
        
    }
}

/**
 *  查询所有搜索数据
 */
- (NSArray*)getAllSearchItem
{
    FMResultSet* set = [_db executeQuery:@"select * from SEARCH"];
    //创建用户数组
    NSMutableArray* array = [NSMutableArray array];
    while ([set next]) {
        SearchItem* searchItem = [[SearchItem alloc] init];
        searchItem.uid = [set intForColumn:@"uid"];
        searchItem.searchText = [set stringForColumn:@"search"];
        [array addObject:searchItem];
    }
    return array;
}

@end

@implementation SearchItem


@end
