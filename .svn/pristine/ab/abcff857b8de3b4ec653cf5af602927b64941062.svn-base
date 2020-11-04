//
//  MyMD5.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/14.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyMD5 : NSObject

+(NSString *) md5: (NSString *) inPutText ;

+(NSString *) authkey:(NSString *)url;

+(NSString *)EncryptionKey: (NSString *) inPutText;

+ (NSString *)getTimeToShowWithTimestamp:(NSString *)timestamp;
+ (NSString *)getTimeToShowWithTimestampSecond:(NSString *)timestamp;
+ (NSString *)getTimeToShowWithTimestampHour:(NSString *)timestamp;

+(NSString *) compareCurrentTime:(NSString*) timestamp;

+ (NSString *)getCurrTimeString:(NSString *)type;

+ (NSString *)compareDate:(NSDate *)date;

+(NSUInteger) asciiLengthOfString: (NSString *) text ;

+(NSString *)pictureString:(NSString *)string;

+ (BOOL)validateNumber:(NSString *) textString;

+ (BOOL)stringContainsEmoji:(NSString *)string;

+(void)changeMemberPriceRate;//改变会员折扣比率

+ (NSDate *)getCustomDateWithHour:(NSInteger)hour;

+ (NSString *)timeInfoWithTimeInterval:(NSTimeInterval)time;

+ (NSArray *)timeCountDown:(NSTimer*)timer Nowtime:(NSString*)nowtime Endtime:(NSString*)endtime Count:(int)count;
+ (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour;

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;

+ (NSString *)getWeekDayFordate:(long long)data;

+ (NSString *)timeWithTimeIntervalString:(NSTimeInterval)time;

+ (NSString *) themecompareCurrentTime:(NSTimeInterval) timestamp;

+ (NSString *)timeInfoWithDateTimeInterval:(NSTimeInterval)time;

/**
 清空搜索历史记录
 */
+ (void)removeSearchHistory;

+ (NSString*)replaceUnicode:(NSString*)aUnicodeString;
@property (nonatomic , strong)NSString *ishiden;
@end
