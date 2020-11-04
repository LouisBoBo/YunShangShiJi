//
//  TFUserLocation.h
//  TFTestDemo
//
//  Created by 云商 on 15/10/15.
//  Copyright © 2015年 云商. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TFUserLocation;

/**
 *  位置代理
 */
@protocol TFUserLocationDelegate <NSObject>

@required
- (void)getUserLocationSuccess:(TFUserLocation *)tfUserLocation withPotion:(NSDictionary *)info withLatitude:(CGFloat)latitude Longitude:(CGFloat)longitude;
- (void)getUserLocationFailed:(TFUserLocation *)tfUserLocation withMessage:(NSError *)error;

@end

@interface TFUserLocation : NSObject

@property (nonatomic, assign) CGFloat                Latitude;
@property (nonatomic, assign) CGFloat                longitude;
@property (nonatomic , weak ) id <TFUserLocationDelegate> userLocationDelegate;

+(TFUserLocation *)shareLocation;
- (void)startLocation;
- (void)stopLocation;


@end
