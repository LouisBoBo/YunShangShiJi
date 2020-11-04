//
//  HelpCenterModel.h
//  YunShangShiJi
//
//  Created by 云商 on 15/7/17.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HelpCenterModel : NSObject

@property (nonatomic, strong)NSNumber *ID;
@property (nonatomic, copy)NSString *question;
@property (nonatomic, copy)NSString *answer;
@property (nonatomic, strong)NSNumber *sort;
@property (nonatomic, strong)NSNumber *adm_id;
@property (nonatomic, strong)NSNumber *add_time;
@property (nonatomic, strong)NSNumber *type;
@property (nonatomic, strong)NSNumber *u_adm_id;
@property (nonatomic, strong)NSNumber *update_time;
@end
