//
//  User.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/14.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "User.h"

@implementation User


- (NSString *)description
{
    NSMutableString* desc = [NSMutableString new];
    NSArray* propertyArray = [[self propertyDictionary] allKeys];
    [desc appendString:@"{\r"];
    
    
    for (NSString* key in propertyArray) {
        [desc appendFormat:@"  %@ : %@\r",key,[self valueForKey:key]];
    }
    
    
    [desc appendString:@"\r}"];
    
    return desc ;
}

@end

@implementation Store

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"ID": @"id"};
}
- (NSString *)description
{
    NSMutableString* desc = [NSMutableString new];
    NSArray* propertyArray = [[self propertyDictionary] allKeys];
    [desc appendString:@"{\r"];
    
    
    for (NSString* key in propertyArray) {
        [desc appendFormat:@"  %@ : %@\r",key,[self valueForKey:key]];
    }
    
    
    [desc appendString:@"\r}"];
    
    return desc ;
}

@end

@implementation Userinfo

- (NSString *)description
{
    NSMutableString* desc = [NSMutableString new];
    NSArray* propertyArray = [[self propertyDictionary] allKeys];
    [desc appendString:@"{\r"];
    
    for (NSString* key in propertyArray) {
        [desc appendFormat:@"  %@ : %@\r",key,[self valueForKey:key]];
    }
    [desc appendString:@"\r}"];
    
    return desc ;
}

@end
