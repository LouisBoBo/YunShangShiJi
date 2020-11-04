//
//  BaseModel.m
//  YIFUDemo
//
//  Created by hyj on 16/5/5.
//  Copyright © 2016年 ZhaoGuanLin. All rights reserved.
//  基础Model（封装有网络请求与json解析）

#import "BaseModel.h"

@implementation BaseModel

#pragma mark - DB
+ (LKDBHelper *)getUsingLKDBHelper
{
    static LKDBHelper* helper;
    NSString *dbName = @"YF_default.db";
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    NSString *cachPath = [NSString stringWithFormat:@"%@/%@",path,dbName];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[LKDBHelper alloc]initWithDBPath:cachPath];
    });
    return helper;
}

+ (NSString *)getUserDBName {
    
    return [NSString stringWithFormat:@"YFSHOPCAR/%@",[[NSUserDefaults standardUserDefaults] objectForKey:USER_ID]];
}

#pragma mark - map
+ (NSMutableDictionary *)getMapping
{
    return nil;
}

+ (id <JTValidMappingKey>)mappingWithKey:(NSString *)key
{
    return [self mappingWithKey:key mapping:[self getMapping]];
}

+ (id <JTValidMappingKey>)mappingWithKey:(NSString *)key mapping:(NSMutableDictionary *)mapping
{
    if (!mapping)
    {
        return [super mappingWithKey:key mapping:[self getMapping]];
    }
    return [super mappingWithKey:key mapping:mapping];
}

#pragma mark - handle network data
+ (void)getDataResponsePath:(NSString *)path onCompletion:(void (^)(id data))completionBlock {
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 10;
    NSString *paths = [NSString stringWithFormat:@"%@%@",[NSObject baseURLStr],path];
    NSString *URL= [MyMD5 authkey:paths];
    NSLog(@"\n<<-----------请求-------------------\n Url == %@\n------------------------------->>",URL);
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"\n<<-----------返回-------------------\n Url == %@\n responseObject == %@\n------------------------------->>",URL,responseObject);
        if (completionBlock)
        {
            completionBlock(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"\n<<-----------返回-------------------\n Url == %@\n error == %@\n------------------------------->>",URL,error);
        NSDictionary *dic = [self getErrorDictionary:error];
        if (completionBlock) {
            completionBlock(dic);
        }
    }];
}

+ (void)getDataResponsePath:(NSString *)path success:(void (^)(id data))success {
    [self getDataResponsePath:path onCompletion:^(id data) {
        BaseModel *model = [self objectFromJSONObject:data mapping:[self getMapping]];
        if (success)
        {
            success(model);
        }
    }];
}

+ (NSDictionary *)getErrorDictionary:(NSError *)error
{
    //判断超时的情况
    BOOL isTimeout = [[error.userInfo objectForKey:@"NSLocalizedDescription"] rangeOfString:@"超时"].location != NSNotFound;
    if (isTimeout) {
        return [NSDictionary dictionaryWithObjectsAndKeys:
                [NSNumber numberWithInteger:250], @"status",
                @"请求超时，请检查网络",@"message",
                nil];
    } else {
        return [NSDictionary dictionaryWithObjectsAndKeys:
                [NSNumber numberWithInteger:404], @"status",
                @"网络异常，请检查网络",@"message",
                nil];
    }
}
@end
