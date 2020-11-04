//
//  FMDBSearchManager.h
//  YunShangShiJi
//
//  Created by 云商 on 16/3/7.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SearchItem;

@interface FMDBSearchManager : NSObject

+ (FMDBSearchManager*)sharedManager;
/**
 *  增加搜索
 */
- (void)addSearchItem:(SearchItem *)searchItem;
/**
 *  按照搜索内容删除
 */
- (void)deleteSearchText:(NSString *)text;
/**
 *  按照uid删除搜索
 */
- (void)deleteSearchUid:(int)uid;
/**
 *  删除搜索表所有内容
 */
- (void)deleteSearchDB;
/**
 *  查询所有搜索数据
 */
- (NSArray*)getAllSearchItem;
@end

@interface SearchItem : NSObject

@property (nonatomic, assign) int      uid;
@property (nonatomic, copy  ) NSString *searchText;

@end
