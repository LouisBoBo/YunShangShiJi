//
//  FriendsRawardModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/12/13.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendsRawardModel : NSObject
@property (nonatomic, copy) NSString *add_date;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *f_extra;     //提现额度
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *f_money;     //余额

@end
