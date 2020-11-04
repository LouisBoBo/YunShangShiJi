//
//  FMDBUserInfoManager.h
//  YunShangShiJi
//
//  Created by yssj on 16/3/23.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MYUserInfo.h"

@interface FMDBUserInfoManager : NSObject

+ (FMDBUserInfoManager *)shareManager;

/**
 *  增加搜索
 */
- (void)addUserInfo:(MYUserInfo *)userInfo;
/**
 *  按照搜索内容删除
 */
- (void)deleteUserInfo:(NSString *)text;



@end
