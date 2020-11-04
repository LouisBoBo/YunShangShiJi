//
//  NSObject+TFCommon.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/12.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "NSObject+TFCommon.h"
#import "TFPublicClass.h"
#import "MyMD5.h"


@implementation NSObject (TFCommon)


//网络请求
+ (BOOL)saveResponseData:(NSDictionary *)data toPath:(NSString *)requestPath{
//    User *loginUser = [Login curLoginUser];
//    if (!loginUser) {
//        return NO;
//    } else{
//        requestPath = [NSString stringWithFormat:@"%@_%@", loginUser.userinfo.user_id, requestPath];
//    }
    if ([self createDirInCache:kPath_ResponseCache]) {
        NSString *abslutePath = [NSString stringWithFormat:@"%@/%@.plist", [self pathInCacheDirectory:kPath_ResponseCache], [MyMD5 md5:requestPath]];
//        MyLog(@"abslutePath: %@", abslutePath);
        return [[NSDictionary changeType:data] writeToFile:abslutePath atomically:YES];
    } else{
        return NO;
    }
}

+ (BOOL)saveTimeIntervalResponseData:(NSDictionary *)data toPath:(NSString *)requestPath
{
    if ([self createDirInCache:kPath_ResponseCache]) {
        NSString *abslutePath = [NSString stringWithFormat:@"%@/%@.plist", [self pathInCacheDirectory:kPath_ResponseCache], [MyMD5 md5:requestPath]];
        NSMutableDictionary *timeIntervalMuDic = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary changeType:data]];
        [timeIntervalMuDic setObject:[NSString stringWithFormat:@"%f", [NSDate timeIntervalSinceReferenceDate]] forKey:@"timeInterval"];
        return [timeIntervalMuDic writeToFile:abslutePath atomically:YES];
    } else{
        return NO;
    }
}

+ (id) loadResponseWithPath:(NSString *)requestPath{//返回一个NSDictionary类型的json数据
//    User *loginUser = [Login curLoginUser];
//    if (!loginUser) {
//        return nil;
//    } else{
//        requestPath = [NSString stringWithFormat:@"%@_%@", loginUser.userinfo.user_id, requestPath];
//    }
    
    NSString *abslutePath = [NSString stringWithFormat:@"%@/%@.plist", [self pathInCacheDirectory:kPath_ResponseCache], [MyMD5 md5:requestPath]];
    return [NSMutableDictionary dictionaryWithContentsOfFile:abslutePath];
}

+ (id)loadTimeIntervalResponseWithPath:(NSString *)requestPath withTimeInterval:(NSTimeInterval)timeInterval
{
    if (![NSObject findCachefileExistsAtPath:requestPath]) {
        return nil;
    }
    NSString *abslutePath = [NSString stringWithFormat:@"%@/%@.plist", [self pathInCacheDirectory:kPath_ResponseCache], [MyMD5 md5:requestPath]];
    NSMutableDictionary *muDic = [NSMutableDictionary dictionaryWithContentsOfFile:abslutePath];
    if (muDic) {
        NSString *updateDate = [muDic objectForKey:@"timeInterval"];
        NSTimeInterval update = updateDate.doubleValue;
        NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
        if ((now - update)<timeInterval) {
            [muDic removeObjectForKey:@"timeInterval"];
            return muDic;
        } else {
            [self deleteCacheWithPath:requestPath]; // 过期删除
            return nil;
        }
    } else {
        return muDic;
    }
    return nil;
}

+ (BOOL)findCachefileExistsAtPath:(NSString *)requestPath
{
    NSString *abslutePath = [NSString stringWithFormat:@"%@/%@.plist", [self pathInCacheDirectory:kPath_ResponseCache], [MyMD5 md5:requestPath]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:abslutePath];
}

+ (BOOL)deleteResponseCacheForPath:(NSString *)requestPath{
//    User *loginUser = [Login curLoginUser];
//    if (!loginUser) {
//        return NO;
//    }else{
//        requestPath = [NSString stringWithFormat:@"%@_%@", loginUser.userinfo.user_id, requestPath];
//    }
    NSString *abslutePath = [NSString stringWithFormat:@"%@/%@.plist", [self pathInCacheDirectory:kPath_ResponseCache], [MyMD5 md5:requestPath]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:abslutePath]) {
        return [fileManager removeItemAtPath:abslutePath error:nil];
    }else{
        return NO;
    }
}

+ (BOOL) deleteResponseCache{
    return [self deleteCacheWithPath:kPath_ResponseCache];
}


/**
 在caches文件夹中删除文件

 @param path <#path description#>
 @return <#return value description#>
 */
+ (BOOL)deleteCachesForPath:(NSString *)path
{
    NSString *cachesFileName = [self pathInCacheDirectory:path];
    return [self fileManagerDeleteForPath:cachesFileName];
}

+ (BOOL) deleteCacheWithPath:(NSString *)cachePath{
    NSString *dirPath = [self pathInCacheDirectory:cachePath];
    return [self fileManagerDeleteForPath:dirPath];
}

+ (BOOL)fileManagerDeleteForPath:(NSString *)path
{
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    bool isDeleted = false;
    if ( isDir == YES && existed == YES )
    {
        isDeleted = [fileManager removeItemAtPath:path error:nil];
    }
    return isDeleted;
}

#pragma mark File M
//获取fileName的完整地址
+ (NSString* )pathInCacheDirectory:(NSString *)fileName
{
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cachePaths objectAtIndex:0];
    return [cachePath stringByAppendingPathComponent:fileName];
}
//创建缓存文件夹
+ (BOOL) createDirInCache:(NSString *)dirName
{
    NSString *dirPath = [self pathInCacheDirectory:dirName];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:dirPath isDirectory:&isDir];
    BOOL isCreated = NO;
    if ( !(isDir == YES && existed == YES) )
    {
        isCreated = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if (existed) {
        isCreated = YES;
    }
    return isCreated;
}


#pragma mark - Dictionary to Object
+(id)objectOfClass:(NSString *)object fromJSON:(NSDictionary *)dict {
    if (!dict || ![dict isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    id newObject = [[NSClassFromString(object) alloc] init];
    
    NSDictionary *mapDictionary = [newObject propertyDictionary];
    
    for (NSString *key in [dict allKeys]) {
        NSString *tempKey;
        if ([key isEqualToString:@"description"]) {
            tempKey = [key stringByAppendingString:@"_mine"];
        }else{
            tempKey = key;
        }
        NSString *propertyName = [mapDictionary objectForKey:tempKey];
        if (!propertyName) {
            continue;
        }
        // If it's a Dictionary, make into object
        if ([[dict objectForKey:key] isKindOfClass:[NSDictionary class]]) {
            //id newObjectProperty = [newObject valueForKey:propertyName];
            NSString *propertyType = [newObject classOfPropertyNamed:propertyName];
            id nestedObj = [NSObject objectOfClass:propertyType fromJSON:[dict objectForKey:key]];
            [newObject setValue:nestedObj forKey:propertyName];
        }
        
        // If it's an array, check for each object in array -> make into object/id
        else if ([[dict objectForKey:key] isKindOfClass:[NSArray class]]) {
            NSArray *nestedArray = [dict objectForKey:key];
            NSString *propertyType = [newObject valueForKeyPath:[NSString stringWithFormat:@"propertyArrayMap.%@", key]];
            [newObject setValue:[NSObject arrayMapFromArray:nestedArray forPropertyName:propertyType] forKey:propertyName];
        }
        
        // Add to property name, because it is a type already
        else {
            objc_property_t property = class_getProperty([newObject class], [propertyName UTF8String]);
            if (!property) {
                continue;
            }
            NSString *classType = [newObject typeFromProperty:property];
            
            // check if NSDate or not
            if ([classType isEqualToString:@"T@\"NSDate\""]) {
                //                1970年的long型数字
                NSObject *obj = [dict objectForKey:key];
                if ([obj isKindOfClass:[NSNumber class]]) {
                    NSNumber *timeSince1970 = (NSNumber *)obj;
                    NSTimeInterval timeSince1970TimeInterval = timeSince1970.doubleValue/1000;
                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeSince1970TimeInterval];
                    [newObject setValue:date forKey:propertyName];
                }else{
                    //                            日期字符串
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:OMDateFormat];
                    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:OMTimeZone]];
                    NSString *dateString = [[dict objectForKey:key] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
                    [newObject setValue:[formatter dateFromString:dateString] forKey:propertyName];
                }
            }
            else {
                if ([dict objectForKey:key] != [NSNull null]) {
                    [newObject setValue:[dict objectForKey:key] forKey:propertyName];
                }
                else {
                    [newObject setValue:nil forKey:propertyName];
                }
            }
        }
    }
    
    return newObject;
}

-(NSString *)classOfPropertyNamed:(NSString *)propName {
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int xx = 0; xx < count; xx++) {
        NSString *curProperty = [NSString stringWithUTF8String:property_getName(properties[xx])];
        if ([curProperty isEqualToString:propName]) {
            NSString *className = [NSString stringWithFormat:@"%s", getPropertyType(properties[xx])];
            free(properties);
            return className;
        }
    }
    
    return nil;
}


static const char * getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    //    printf("attributes=%s\n", attributes);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            // it's a C primitive type:
            /*
             if you want a list of what will be returned for these primitives, search online for
             "objective-c" "Property Attribute Description Examples"
             apple docs list plenty of examples of what you get for int "i", long "l", unsigned "I", struct, etc.
             */
            return (const char *)[[NSData dataWithBytes:(attribute + 1) length:strlen(attribute) - 1] bytes];
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // it's an ObjC id type:
            return "id";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            // it's another ObjC object type:
            return (const char *)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes];
        }
    }
    return "";
}

-(NSString *)typeFromProperty:(objc_property_t)property {
    return [[NSString stringWithUTF8String:property_getAttributes(property)] componentsSeparatedByString:@","][0];
}

-(NSDictionary *)propertyDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        [dict setObject:key forKey:key];
    }
    
    free(properties);
    
    // Add all superclass properties as well, until it hits NSObject
    NSString *superClassName = [[self superclass] nameOfClass];
    if (![superClassName isEqualToString:@"NSObject"]) {
        for (NSString *property in [[[self superclass] propertyDictionary] allKeys]) {
            [dict setObject:property forKey:property];
        }
    }
    
    return dict;
}


+(NSMutableArray *)arrayMapFromArray:(NSArray *)nestedArray forPropertyName:(NSString *)propertyName {
    // Set Up
    NSMutableArray *objectsArray = [@[] mutableCopy];
    
    // Removes "ArrayOf(PropertyName)s" to get to the meat
    //NSString *filteredProperty = [propertyName substringWithRange:NSMakeRange(0, propertyName.length - 1)]; /* TenEight */
    //NSString *filteredProperty = [propertyName substringWithRange:NSMakeRange(7, propertyName.length - 8)]; /* AlaCop */
    
    // Create objects
    for (int xx = 0; xx < nestedArray.count; xx++) {
        // If it's an NSDictionary
        if ([nestedArray[xx] isKindOfClass:[NSDictionary class]]) {
            // Create object of filteredProperty type
            id nestedObj = [[NSClassFromString(propertyName) alloc] init];
            
            // Iterate through each key, create objects for each
            for (NSString *newKey in [nestedArray[xx] allKeys]) {
                // If it's an Array, recur
                if ([[nestedArray[xx] objectForKey:newKey] isKindOfClass:[NSArray class]]) {
                    //添加属性判断，防止运行时崩溃
                    objc_property_t property = class_getProperty([NSClassFromString(propertyName) class], [@"propertyArrayMap" UTF8String]);
                    if (!property) {
                        continue;
                    }
                    NSString *propertyType = [nestedObj valueForKeyPath:[NSString stringWithFormat:@"propertyArrayMap.%@", newKey]];
                    if (!propertyType) {
                        continue;
                    }
                    [nestedObj setValue:[NSObject arrayMapFromArray:[nestedArray[xx] objectForKey:newKey]  forPropertyName:propertyType] forKey:newKey];
                }
                // If it's a Dictionary, create an object, and send to [self objectFromJSON]
                else if ([[nestedArray[xx] objectForKey:newKey] isKindOfClass:[NSDictionary class]]) {
                    NSString *type = [nestedObj classOfPropertyNamed:newKey];
                    if (!type) {
                        continue;
                    }
                    
                    id nestedDictObj = [NSObject objectOfClass:type fromJSON:[nestedArray[xx] objectForKey:newKey]];
                    [nestedObj setValue:nestedDictObj forKey:newKey];
                }
                // Else, it is an object
                else {
                    NSString *tempNewKey;
                    if ([newKey isEqualToString:@"description"]) {
                        tempNewKey = [newKey stringByAppendingString:@"_mine"];
                    }else{
                        tempNewKey = newKey;
                    }
                    objc_property_t property = class_getProperty([NSClassFromString(propertyName) class], [tempNewKey UTF8String]);
                    if (!property) {
                        continue;
                    }
                    NSString *classType = [self typeFromProperty:property];
                    // check if NSDate or not
                    if ([classType isEqualToString:@"T@\"NSDate\""]) {
                        //                        1970年的long型数字
                        NSObject *obj = [nestedArray[xx] objectForKey:newKey];
                        if ([obj isKindOfClass:[NSNumber class]]) {
                            NSNumber *timeSince1970 = (NSNumber *)obj;
                            NSTimeInterval timeSince1970TimeInterval = timeSince1970.doubleValue/1000;
                            NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeSince1970TimeInterval];
                            [nestedObj setValue:date forKey:tempNewKey];
                        }else{
                            //                            日期字符串
                            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                            [formatter setDateFormat:OMDateFormat];
                            [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:OMTimeZone]];
                            
                            NSString *dateString = [[nestedArray[xx] objectForKey:newKey] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
                            [nestedObj setValue:[formatter dateFromString:dateString] forKey:tempNewKey];
                        }
                    }
                    else {
                        [nestedObj setValue:[nestedArray[xx] objectForKey:newKey] forKey:tempNewKey];
                    }
                }
            }
            
            // Finally add that object
            [objectsArray addObject:nestedObj];
        }
        
        // If it's an NSArray, recur
        else if ([nestedArray[xx] isKindOfClass:[NSArray class]]) {
            [objectsArray addObject:[NSObject arrayMapFromArray:nestedArray[xx] forPropertyName:propertyName]];
        }
        
        // Else, add object directly
        else {
            [objectsArray addObject:nestedArray[xx]];
        }
    }
    
    // This is now an Array of objects
    return objectsArray;
}
-(NSString *)nameOfClass {
    return [NSString stringWithUTF8String:class_getName([self class])];
}

+(NSMutableArray *)arrayFromJSON:(NSArray *)jsonArray ofObjects:(NSString *)obj {
    //NSString *filteredObject = [NSString stringWithFormat:@"%@s",obj];
    return [NSObject arrayMapFromArray:jsonArray forPropertyName:obj];
}

#pragma mark BaseURL

+ (ChangeBaseURL)getChangeBaseURLStatus
{
    ChangeBaseURL changeBaseUrl = [self baseURLStrIsTest]+ChangeBaseURL_Normal;
    if (changeBaseUrl >=ChangeBaseURL_Normal && changeBaseUrl<=ChangeBaseURL_Wu) {
        return changeBaseUrl;
    } else {
        return ChangeBaseURL_Test;
    }
}

//话题H5分享
+ (NSString *)baseH5ShareURLStr
{
    NSString *baseURLStr;
    ChangeBaseURL changeBaseUrl = [NSObject getChangeBaseURLStatus];
    switch (changeBaseUrl) {
        case ChangeBaseURL_Normal:
            baseURLStr = @"http://www.52yifu.com/";
            break;
        case ChangeBaseURL_Test:
            baseURLStr = @"http://www.52yifu.wang/";
            break;
        case ChangeBaseURL_Ou:
            baseURLStr = @"http://192.168.3.113:8080/";
            break;
        case ChangeBaseURL_Dai:
            baseURLStr = @"http://192.168.10.5:8080/";
            break;
        case ChangeBaseURL_Luan:
            baseURLStr = @"http://192.168.10.18:8080/";
            break;
        case ChangeBaseURL_Fu:
            baseURLStr = @"http://192.168.1.17:8080/";
            break;
        case ChangeBaseURL_Wu:
            baseURLStr = @"http://192.168.1.111:8080/";
            break;
        default:
            baseURLStr = @"http://www.52yifu.wang/";
            break;
    }
    
    if (!My_DEBUG) {
        baseURLStr = @"http://www.52yifu.com/";
    }
    
//    baseURLStr = @"http://www.52yifu.wang/";//测试用后面删除
    
    return baseURLStr;

}
//API
+ (NSString *)baseURLStr
{
    NSString *baseURLStr;
    ChangeBaseURL changeBaseUrl = [NSObject getChangeBaseURLStatus];
    switch (changeBaseUrl) {
        case ChangeBaseURL_Normal:
            baseURLStr = kBaseUrlStr;
            break;
        case ChangeBaseURL_Test:
            baseURLStr = kBaseUrlStr_Test;
            break;
        case ChangeBaseURL_Ou:
            baseURLStr = @"http://192.168.3.113:8080/cloud-api/";
            break;
        case ChangeBaseURL_Dai:
            baseURLStr = @"http://192.168.10.5:8080/cloud-api/";
            break;
        case ChangeBaseURL_Luan:
            baseURLStr = @"http://192.168.10.18:8080/cloud-api/";
            break;
        case ChangeBaseURL_Fu:
            baseURLStr = @"http://192.168.1.17:8080/cloud-api/";
            break;
        case ChangeBaseURL_Wu:
            baseURLStr = @"http://192.168.1.111:8080/cloud-api/";
            break;
        default:
            baseURLStr = kBaseUrlStr_Test;
            break;
    }
    
    if (!My_DEBUG) {
        baseURLStr = kBaseUrlStr;
    }
    
//    baseURLStr = kBaseUrlStr_Test;//测试用后面删除
    
    return baseURLStr;
}

//又拍云
+ (NSString *)baseURLStr_Upy
{
    NSString *baseURLUpyStr;
    ChangeBaseURL changeBaseUrl = [NSObject getChangeBaseURLStatus];
    switch (changeBaseUrl) {
        case ChangeBaseURL_Normal:
            baseURLUpyStr = kBaseUrlUpyStr;
            break;
        case ChangeBaseURL_Test:
            baseURLUpyStr = kBaseUrlUpyStr_Test;
            break;
        case ChangeBaseURL_Ou:
            baseURLUpyStr = kBaseUrlUpyStr_Test;
            break;
        case ChangeBaseURL_Dai:
            baseURLUpyStr = kBaseUrlUpyStr_Test;
            break;
        case ChangeBaseURL_Luan:
            baseURLUpyStr = kBaseUrlUpyStr_Test;
            break;
        case ChangeBaseURL_Fu:
            baseURLUpyStr = kBaseUrlUpyStr_Test;
            break;
        case ChangeBaseURL_Wu:
            baseURLUpyStr = kBaseUrlUpyStr_Test;
            break;
        default:
            baseURLUpyStr = kBaseUrlUpyStr_Test;
            break;
    }
    
    if (!My_DEBUG) {
        baseURLUpyStr = kBaseUrlUpyStr;
    }
    return baseURLUpyStr;
}

//小程序又拍云
+ (NSString *)baseURLStr_XCX_Upy
{
    NSString *baseURLUpyStr;
    ChangeBaseURL changeBaseUrl = [NSObject getChangeBaseURLStatus];
    switch (changeBaseUrl) {
        case ChangeBaseURL_Normal:
            baseURLUpyStr = kBaseUrlUpyStr_XCX;
            break;
        case ChangeBaseURL_Test:
            baseURLUpyStr = kBaseUrlUpyStr_XCX_Test;
            break;
        case ChangeBaseURL_Ou:
            baseURLUpyStr = kBaseUrlUpyStr_XCX_Test;
            break;
        case ChangeBaseURL_Dai:
            baseURLUpyStr = kBaseUrlUpyStr_XCX_Test;
            break;
        case ChangeBaseURL_Luan:
            baseURLUpyStr = kBaseUrlUpyStr_XCX_Test;
            break;
        case ChangeBaseURL_Fu:
            baseURLUpyStr = kBaseUrlUpyStr_XCX_Test;
            break;
        case ChangeBaseURL_Wu:
            baseURLUpyStr = kBaseUrlUpyStr_XCX_Test;
            break;
        default:
            baseURLUpyStr = kBaseUrlUpyStr_XCX_Test;
            break;
    }
    
    if (!My_DEBUG) {
        baseURLUpyStr = kBaseUrlUpyStr_XCX;
    }
    return baseURLUpyStr;
}
//支付
+ (NSString *)baseURLStr_Pay
{
    NSString *baseURLPayStr;
    ChangeBaseURL changeBaseUrl = [NSObject getChangeBaseURLStatus];
    switch (changeBaseUrl) {
        case ChangeBaseURL_Normal:
            baseURLPayStr = kBaseUrlPayStr;
            break;
        case ChangeBaseURL_Test:
            baseURLPayStr = kBaseUrlPayStr_Test;
            break;
        case ChangeBaseURL_Ou:
            baseURLPayStr = kBaseUrlPayStr_Test;
            break;
        case ChangeBaseURL_Dai:
            baseURLPayStr = kBaseUrlPayStr_Test;
            break;
        case ChangeBaseURL_Luan:
            baseURLPayStr = kBaseUrlPayStr_Test;
            break;
        case ChangeBaseURL_Fu:
            baseURLPayStr = kBaseUrlPayStr_Test;
            break;
        case ChangeBaseURL_Wu:
            baseURLPayStr = kBaseUrlPayStr_Test;
            break;
        default:
            baseURLPayStr = kBaseUrlPayStr_Test;
            break;
    }
    
    
    if (!My_DEBUG) {
        baseURLPayStr = kBaseUrlPayStr;
    }
    
//    baseURLPayStr = kBaseUrlPayStr_Test;//测试用后面删除
    
    return baseURLPayStr;
}
//H5
+ (NSString *)baseURLStr_H5
{
    NSString *baseURLH5Str;
    ChangeBaseURL changeBaseUrl = [NSObject getChangeBaseURLStatus];
    switch (changeBaseUrl) {
        case ChangeBaseURL_Normal:
            baseURLH5Str = kBaseUrlH5Str;
            break;
        case ChangeBaseURL_Test:
            baseURLH5Str = kBaseUrlH5Str_Test;
            break;
        case ChangeBaseURL_Ou:
            baseURLH5Str = @"http://192.168.3.113:8080/cloud-h5/";
            break;
        case ChangeBaseURL_Dai:
            baseURLH5Str = @"http://192.168.10.5:8080/";
            break;
        case ChangeBaseURL_Luan:
            baseURLH5Str = @"http://192.168.10.18:8080/cloud-h5/";
            break;
        case ChangeBaseURL_Fu:
            baseURLH5Str = @"http://192.168.1.17:8080/";
            break;
        case ChangeBaseURL_Wu:
            baseURLH5Str = @"http://192.168.1.111:8080/cloud-h5/";
            break;
        default:
            baseURLH5Str = kBaseUrlH5Str_Test;
            break;
    }
    

    if (!My_DEBUG) {
        baseURLH5Str = kBaseUrlH5Str;
    }
    return baseURLH5Str;
}

//数据统计渠道
+ (NSString *)baseDataStatisticsChannel
{
    return @"7";
}
+ (NSInteger)baseURLStrIsTest
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [[defaults valueForKey:kTestKey] integerValue];
}
+ (void)changeBaseURLStrToIndex:(NSInteger)index
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 清楚数据库标志
    [defaults removeObjectForKey:TYPE_DATA];
    [defaults removeObjectForKey:TAG_DATA];
    
    [defaults setObject:@(index) forKey:kTestKey];
    [defaults synchronize];
}

+ (void)delay:(NSTimeInterval)seconds completion:(void(^)(void))completion {
    /**
     *
     dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int)(NSEC_PER_SEC * seconds));
     */
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, seconds *NSEC_PER_SEC);
    // 一定时间后，将执行的操作加入到队列
    //1.不是一定时间后执行相应的任务，而是一定时间后，将执行的操作加入到队列中（队列里面再分配执行的时间）
    //2.主线程 RunLoop 1/60秒检测时间，追加的时间范围 3s~(3+1/60)s
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        if (completion) {
            completion();
        }
    });
}

@end
