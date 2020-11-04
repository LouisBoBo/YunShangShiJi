//
//  NSObject+TFCommon.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/12.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kPath_ResponseCache @"ResponseCache"
#define OMDateFormat @"yyyy-MM-dd'T'HH:mm:ss.SSS"
#define OMTimeZone @"UTC"
#define kTestKey  @"BaseURLIsTest"

typedef NS_ENUM(NSInteger, ChangeBaseURL)
{
    ChangeBaseURL_Normal = 100, // 正式
    ChangeBaseURL_Test, // 测试
    ChangeBaseURL_Ou, // 欧阳
    ChangeBaseURL_Dai, // 小戴
    ChangeBaseURL_Luan, // 世凯
    ChangeBaseURL_Fu, // 福海
    ChangeBaseURL_Wu, // 敦奉
};

@interface NSObject (TFCommon)

#pragma mark 网络请求缓存
+ (BOOL)saveResponseData:(NSDictionary *)data toPath:(NSString *)requestPath;//缓存请求回来的json
+ (BOOL)saveTimeIntervalResponseData:(NSDictionary *)data toPath:(NSString *)requestPath;
+ (id)loadTimeIntervalResponseWithPath:(NSString *)requestPath withTimeInterval:(NSTimeInterval)timeInterval;
+ (id)loadResponseWithPath:(NSString *)requestPath;//返回json数据
+ (BOOL)findCachefileExistsAtPath:(NSString *)requestPath; //找文件是否存在
+ (BOOL)deleteResponseCacheForPath:(NSString *)requestPath;
+ (BOOL)deleteResponseCache;
+ (BOOL)deleteCachesForPath:(NSString *)path;

#pragma mark File M
//获取fileName的完整地址
+ (NSString* )pathInCacheDirectory:(NSString *)fileName;
//创建缓存文件夹
+ (BOOL)createDirInCache:(NSString *)dirName;


#pragma mark - 对象操作
// Universal Method
-(NSDictionary *)propertyDictionary; //获取 属性
-(NSString *)nameOfClass;  //获取 类名

// id -> Object
+(id)objectOfClass:(NSString *)object fromJSON:(NSDictionary *)dict; // 将json转成对象
+(NSMutableArray *)arrayFromJSON:(NSArray *)jsonArray ofObjects:(NSString *) obj; // 将json数组转成对象数组(在列表 赋值时候用)

#pragma mark 提示框

#pragma mark - baseUrl
+ (NSString *)baseURLStr;
+ (NSString *)baseURLStr_Upy;
+ (NSString *)baseURLStr_XCX_Upy;
+ (NSString *)baseURLStr_Pay;
+ (NSString *)baseURLStr_H5;
+ (NSInteger)baseURLStrIsTest;
+ (NSString *)baseDataStatisticsChannel;
+ (void)changeBaseURLStrToIndex:(NSInteger)index;
+ (NSString *)baseH5ShareURLStr;
+ (void)delay:(NSTimeInterval)seconds completion:(void(^)(void))completion;
@end
