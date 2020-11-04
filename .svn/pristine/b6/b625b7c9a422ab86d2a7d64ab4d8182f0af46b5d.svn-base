//
//  TFUserLocation.m
//  TFTestDemo
//
//  Created by 云商 on 15/10/15.
//  Copyright © 2015年 云商. All rights reserved.
//

#import "TFUserLocation.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h> //位置服务框架

#import "AFNetworking.h"
#import "GTMBase64.h"
@interface TFUserLocation () <CLLocationManagerDelegate>

{

    CLLocationManager *_locationManager;
    CLGeocoder *_geocoder;
}

@end

static TFUserLocation *tf = nil;

@implementation TFUserLocation

- (instancetype)init
{
    if (self == [super init]) {
        //
    }
    return self;
}



+ (TFUserLocation *)shareLocation
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (tf == nil) {
            tf = [[TFUserLocation alloc] init];
            [tf initiate];
        }
    });
    return tf;
}

- (void)initiate
{
    if ([CLLocationManager locationServicesEnabled]) {

        _locationManager = [[CLLocationManager alloc] init];

        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 200;
        _locationManager.delegate = self;

        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            [_locationManager requestAlwaysAuthorization];
        }
    }
}

- (void)startLocation
{
   [_locationManager startUpdatingLocation];
}

- (void)stopLocation
{
    [_locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{

    CLLocation *currLocation = [locations lastObject];
    CLLocationCoordinate2D coordinate = currLocation.coordinate;

    
    NSString *rectificationURL = [NSString stringWithFormat:@"http://api.zdoz.net/transgpsbd.aspx?lng=%f&lat=%f",coordinate.longitude,coordinate.latitude];

    
    AFHTTPRequestOperationManager *httpManager = [AFHTTPRequestOperationManager manager];
    
    [httpManager GET:rectificationURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            //res = %@", responseObject);
            NSString *x_base_Str = responseObject[@"Lng"];
            NSString *y_base_Str = responseObject[@"Lat"];
            _geocoder=[[CLGeocoder alloc]init];
            
            
            self.Latitude = [y_base_Str floatValue];
            self.longitude = [x_base_Str floatValue];
            
            [self getAddressByLatitude:[y_base_Str floatValue] longitude:[x_base_Str floatValue]];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //纠偏失败");
        
        if ([self.userLocationDelegate respondsToSelector:@selector(getUserLocationFailed:withMessage:)]) {
            [self.userLocationDelegate getUserLocationFailed:self withMessage:error];
        }
        
    }];
    
    
    
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error code] == kCLErrorDenied)
    {
        //访问被拒绝
        //访问被拒绝");
    }
    if ([error code] == kCLErrorLocationUnknown)
    {        //无法获取位置信息
        //无法获取位置信息");
    }
    
    if ([self.userLocationDelegate respondsToSelector:@selector(getUserLocationFailed:withMessage:)]) {
        [self.userLocationDelegate getUserLocationFailed:self withMessage:error];
    }
    
    
}

- (void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark=[placemarks lastObject];
        NSDictionary *dic = placemark.addressDictionary;
        if ([self.userLocationDelegate respondsToSelector:@selector(getUserLocationSuccess:withPotion:withLatitude:Longitude:)]) {
            [self.userLocationDelegate getUserLocationSuccess:self withPotion:dic withLatitude:self.Latitude Longitude:self.longitude];
        }
        
    }];
}


@end
