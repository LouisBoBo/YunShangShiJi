//
//  HZLocation.h
//  areapicker
//
//  Created by Cloud Dai on 12-9-9.
//  Copyright (c) 2012年 clouddai.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HZLocation : NSObject

@property (copy, nonatomic) NSString *country;
@property (copy, nonatomic) NSString *state;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *district;
@property (copy, nonatomic) NSString *street;
@property (copy, nonatomic) NSString *stateID;
@property (copy, nonatomic) NSString *cityID;
@property (copy, nonatomic) NSString *districtID;
@property (copy, nonatomic) NSString *streetID;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@end
