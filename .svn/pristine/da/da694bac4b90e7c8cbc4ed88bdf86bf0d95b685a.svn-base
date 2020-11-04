//
//  BaseDBManager.m
//  MyCollectionView
//
//  Created by luoyuntao on 15/4/16.
//  Copyright (c) 2015年 luoyuntao. All rights reserved.
//

#import "BaseDBManager.h"

#define DB @"DB.sqlite"

@implementation BaseDBManager
- (NSString *)getDBPath
{
    NSString *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath = [documents stringByAppendingPathComponent:DB];
    return dbPath;
}
- (BOOL)removeDBFile
{   
    NSString *dbPath = [self getDBPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:dbPath]) {
        return [fileManager removeItemAtPath:dbPath error:nil];
    }
    
    return NO;
}

- (BOOL)openDB
{
    
    if (_sqldb) {
        return YES;
    }
    
    NSString *dbPath = [self getDBPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:dbPath]) {
        NSData *dbData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:DB ofType:nil]];
        [dbData writeToFile:dbPath atomically:YES];
    }
    
    if (sqlite3_open([dbPath UTF8String], &_sqldb) == SQLITE_OK) {
        //open db success!");
        
        sqlite3_busy_timeout(_sqldb, 10000);
        
        return YES;
    }
    
    return NO;
}

- (BOOL)closeDB
{
    if (_sqldb) {
        sqlite3_close(_sqldb);
        _sqldb = 0x00;
        
        return YES;
    }
    
    return NO;
}

@end
