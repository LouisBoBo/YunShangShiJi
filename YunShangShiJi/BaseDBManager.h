//
//  BaseDBManager.h
//  MyCollectionView
//
//  Created by luoyuntao on 15/4/16.
//  Copyright (c) 2015年 luoyuntao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <sqlite3.h>

@interface BaseDBManager : NSObject
{
    sqlite3 *_sqldb;
}
- (BOOL)openDB;
- (BOOL)closeDB;

- (BOOL)removeDBFile;
@end
