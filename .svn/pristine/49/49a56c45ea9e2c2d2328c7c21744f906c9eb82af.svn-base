//
//  Response.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/5.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "Response.h"
@implementation Response

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

@implementation Pager

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

