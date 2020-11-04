//
//  CitysModel.h
//  YunShangShiJi
//
//  Created by 云商 on 15/7/21.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityModel.h"

@interface StateModel : NSObject

@property (nonatomic, strong)NSNumber *ID;
@property (nonatomic, copy)NSString *state;
@property (nonatomic, strong)NSArray *cities;

@property (nonatomic, strong)NSMutableArray *CITIES;

@end
