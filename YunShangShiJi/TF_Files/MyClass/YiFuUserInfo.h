//
//  YiFuUserInfo.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2016/11/11.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YiFuBaseDBModel.h"
@interface YiFuUserInfo : YiFuBaseDBModel

@property(assign,nonatomic)int dbId;
@property(strong,nonatomic)NSNumber *userId;
@property(copy,nonatomic)NSString *userName;
@property(copy,nonatomic)NSString *userIdenf;
@property (copy, nonatomic)NSString *userType;

@end
