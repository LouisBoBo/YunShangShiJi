//
//  MyMD5.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/14.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "MyMD5.h"
#import "CommonCrypto/CommonDigest.h"
#import "GlobalTool.h"
@implementation MyMD5
//密码加密
+(NSString *) md5: (NSString *) inPutText
{
    if(inPutText)
    {
        const char *cStr = [inPutText UTF8String];
        unsigned char result[CC_MD5_DIGEST_LENGTH];
        CC_MD5(cStr, strlen(cStr), result);
        
        return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                 result[0], result[1], result[2], result[3],
                 result[4], result[5], result[6], result[7],
                 result[8], result[9], result[10], result[11],
                 result[12], result[13], result[14], result[15]
                 ] uppercaseString];
    }
    
    return 0;
}

#pragma mark 本地加密方式
+(NSString *)EncryptionKey: (NSString *) inPutText
{
    static  int RANGE = 0xff;
    //自定义码表 可随意变换字母排列顺序，然后会自动生成解密表
     static char Base64ByteToStr[64] =  {
         
//        'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',// 0 ~ 9
//        'A', 'V', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',// 10 ~ 19
//        'U', 'B', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd',// 20 ~ 29
//        'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x',// 30 ~ 39
//        'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',// 40 ~ 49
//        'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7',// 50 ~ 59
//        '8', '9', '+', '/'// 60 ~ 63
         
//最新的
         'K', 'L', 'G', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',// 0 ~ 9
         'A', 'V', 'X', 'D', 'E', 'F', 'M', 'H', 'I', 'J',// 10 ~ 19
         'U', 'Z', 'W', 'C', 'Y', 'B', 'a', 'b', 'c', 'd',// 20 ~ 29
         'o', 'p', 'q', 'r', 'i', 't', 'u', 'v', 'w', 'x',// 30 ~ 39
         'e', 'f', 'g', 'h', 's', 'j', 'k', 'l', 'm', 'n',// 40 ~ 49
         'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7',// 50 ~ 59
         '8', '9', '+', '/'// 60 ~ 63

    };
    
    NSString *testString = inPutText;
    NSData *testData = [testString dataUsingEncoding: NSUTF8StringEncoding];
    Byte *testByte = (Byte*)[testData bytes];
    
    NSMutableString *res = [NSMutableString string];
    //per 3 bytes scan and switch to 4 bytes
    for(int i = 0; i <= testData.length - 1; i+=3) {
        
        Byte enBytes[4];
        
        Byte tmp = (Byte)0x00;// save the right move bit to next position's bit
        //3 bytes to 4 bytes

        for(int k = 0; k <= 2; k++) {// 0 ~ 2 is a line
            if((i + k) <= testData.length - 1) {
                enBytes[k] = (Byte) (((((int) testByte[i + k] & RANGE) >> (2 + 2 * k))) | (int)tmp);//note , we only get 0 ~ 127 ???
                tmp = (Byte) (((((int) testByte[i + k] & RANGE) << (2 + 2 * (2 - k))) & RANGE) >> 2);
                
            } else {
                
                enBytes[k] = tmp;
                tmp = (Byte)64;//if tmp > 64 then the char is '=' hen '=' -> byte is -1 , so it is EOF or not print char
            }
        }
        
        enBytes[3] = tmp;//forth byte
        //4 bytes to encode string
        for (int k = 0; k <= 3; k++) {
            if((int)enBytes[k] <= 63) {

                [res appendString:[NSString stringWithFormat:@"%c",Base64ByteToStr[(int)enBytes[k]]]];
                
            } else {
                
                [res appendString:[NSString stringWithFormat:@"="]];
            }
        }
    }
    
    return res;
}


+(void)changeMemberPriceRate
{
//   NSString *member = [[NSUserDefaults standardUserDefaults] objectForKey:USER_MEMBER];
//    if ([member intValue] == 2||[member intValue] == 3||[member intValue] == 4) {
//        memberPriceRate=0.95;
//    }else
        memberPriceRate=1;
    
    //memberpricerate : %f",memberPriceRate);
}

//生成密码签名文件
+(NSString *) authkey:(NSString*)url
{
    //1.对url进行UTF8编码
    //    NSString *codeurl=[NSString stringWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //2.UTF8编码后的字符串加上KEY形成新的字符串
    NSMutableString *URL=[NSMutableString stringWithString:[NSString stringWithFormat:@"%@",url]];
    [URL appendString:@"yunshangshiji"];
   
    //3.新的字符串加密生成authkey
    NSString *authKey=[MyMD5 md5:URL];
    
    NSString *newauthKey = [MyMD5 EncryptionKey:authKey];
    
    
    //UTF8编码后的URL+密码签名串=新的URL
    
    NSString *Posturl=[NSString stringWithFormat:@"%@&%@=%@&%@=%@",url,@"authKey",authKey,@"I10o",newauthKey];

    
    MyLog(@"\n===========URLString==========\n%@\n==============================\n\n", Posturl);
    
    
    NSString *utf8Str = [Posturl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
//    NSString *authKeystr = [self EncryptionKey:utf8Str];
    
    return utf8Str;
}

#pragma mark 时间 年-月-日-时-分-秒
+ (NSString *)getTimeToShowWithTimestamp:(NSString *)timestamp
{
    if (![timestamp isEqual:[NSNull null]] ) {
        double publishLong = [timestamp doubleValue];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        [formatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
        
        NSDate *publishDate = [NSDate dateWithTimeIntervalSince1970:publishLong/1000];
        
        NSDate *date = [NSDate date];
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate:date];
        publishDate = [publishDate  dateByAddingTimeInterval: interval];
        
        NSString* publishString = [formatter stringFromDate:publishDate];
        return publishString;
    } else
        return timestamp;

}

#pragma mark 时间 年-月-日-时-分-秒
+ (NSString *)getTimeToShowWithTimestampSecond:(NSString *)timestamp
{
    if (![timestamp isEqual:[NSNull null]] ) {
        double publishLong = [timestamp doubleValue];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        [formatter setDateFormat:@"yyyy.MM.dd HH:mm"];
        
        NSDate *publishDate = [NSDate dateWithTimeIntervalSince1970:publishLong/1000];
        
        NSDate *date = [NSDate date];
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate:date];
        publishDate = [publishDate  dateByAddingTimeInterval: interval];
        
        NSString* publishString = [formatter stringFromDate:publishDate];
        return publishString;
    } else
        return timestamp;
    
}

+ (NSString *)getTimeToShowWithTimestampHour:(NSString *)timestamp
{
    if (![timestamp isEqual:[NSNull null]] ) {
        double publishLong = [timestamp doubleValue];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        [formatter setDateFormat:@"yyyy.MM.dd"];
        
        NSDate *publishDate = [NSDate dateWithTimeIntervalSince1970:publishLong/1000];
        
        NSDate *date = [NSDate date];
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate:date];
        publishDate = [publishDate  dateByAddingTimeInterval: interval];
        
        NSString* publishString = [formatter stringFromDate:publishDate];
        return publishString;
    } else
        return timestamp;

}

+ (NSString *)getCurrTimeString:(NSString *)type
{
    NSDate *curDate = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *showCurDate = [formatter stringFromDate:curDate];
    
    if ([type isEqualToString:@"year"]) {
        return [showCurDate substringToIndex:4];
    } else if ([type isEqualToString:@"month"]) {
        return [showCurDate substringWithRange:NSMakeRange(5, 2)];
    } else if ([type isEqualToString:@"day"]) {
        return [showCurDate substringWithRange:NSMakeRange(8, 2)];
    } else if ([type isEqualToString:@"hour"]) {
        return [showCurDate substringWithRange:NSMakeRange(11, 2)];
    } else if ([type isEqualToString:@"min"]) {
        return [showCurDate substringWithRange:NSMakeRange(14, 2)];
    } else if ([type isEqualToString:@"sec"]) {
        return [showCurDate substringWithRange:NSMakeRange(17, 2)];
    } else if ([type isEqualToString:@"year-month-day"]) {
        return [showCurDate substringToIndex:10];
    } else if ([type isEqualToString:@"year-month"]) {
        return [showCurDate substringToIndex:7];
    } else if ([type isEqualToString:@"month-day"]) {
        return [showCurDate substringWithRange:NSMakeRange(5, 5)];
    } else if ([type isEqualToString:@"hour-min-sec"]) {
        return [showCurDate substringWithRange:NSMakeRange(11, 8)];
    } else if ([type isEqualToString:@"hour-min"]) {
        return [showCurDate substringWithRange:NSMakeRange(11, 5)];
    } else if ([type isEqualToString:@"min-sec"]) {
        return [showCurDate substringWithRange:NSMakeRange(14, 5)];
    } else if ([type isEqualToString:@"week"]) {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
        NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        
        comps = [calendar components:unitFlags fromDate:curDate];
        NSInteger week = [comps weekday];
        return [NSString stringWithFormat:@"%d",(int)week];
    }
    
    return showCurDate;
}

+ (NSString *)timeWithTimeIntervalString:(NSTimeInterval)time
{
    
    NSDate *oldDate = [NSDate dateWithTimeIntervalSince1970:(time/1000)];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM月dd日 HH:mm"];
    NSString *showtimeNew = [formatter stringFromDate:oldDate];
    return showtimeNew;

}
+ (NSString *)timeInfoWithTimeInterval:(NSTimeInterval)time
{
    NSDate *oldDate = [NSDate dateWithTimeIntervalSince1970:(time/1000)];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    NSString *showtimeNew = [formatter stringFromDate:oldDate];
    return showtimeNew;
}
+ (NSString *)timeInfoWithDateTimeInterval:(NSTimeInterval)time
{
    NSDate *oldDate = [NSDate dateWithTimeIntervalSince1970:(time/1000)];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *showtimeNew = [formatter stringFromDate:oldDate];
    return showtimeNew;
}
+ (NSString *) themecompareCurrentTime:(NSTimeInterval)timestamp
{
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 创建歌曲时间戳(后台返回的时间 一般是13位数字)
    NSTimeInterval createTime = timestamp/1000;
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    
    NSString *result;
    // 秒转小时
    NSInteger hours = time/3600;
    if (hours<24) {
        if(hours < 1)
        {
            NSInteger minute = time/60;
            if(minute <1)
            {
                result = [NSString stringWithFormat:@"刚刚"];
            }else{
                result = [NSString stringWithFormat:@"%ld分钟前",minute];
            }
        }else
        result = [NSString stringWithFormat:@"%ld小时前",hours];
    }
    
    return result;
}
+(NSString *) compareCurrentTime:(NSString*) timestamp
{
    
    double publishLong = [timestamp doubleValue];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [formatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    
    NSDate *publishDate = [NSDate dateWithTimeIntervalSince1970:publishLong/1000];
    
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    publishDate = [publishDate  dateByAddingTimeInterval: interval];
    
    
    NSTimeInterval  timeInterval = [publishDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%d分前",(int)temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%d小时前",(int)temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%d天前",(int)temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%d月前",(int)temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%d年前",(int)temp];
    }
    
    return  result;
}

#pragma mark 判断是明天还是昨天
+(NSString *)compareDate:(NSDate *)date{
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *tomorrow, *yesterday;
    
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * tomorrowString = [[tomorrow description] substringToIndex:10];
    
    NSString * dateString = [[date description] substringToIndex:10];
    
    if ([dateString isEqualToString:todayString])
    {
        return @"今天";
    } else if ([dateString isEqualToString:yesterdayString])
    {
        return @"昨天";
    }else if ([dateString isEqualToString:tomorrowString])
    {
        return @"明天";
    }
    else
    {
        return dateString;
    }
}
#pragma mark 判读字符是否为纯数字
+ (BOOL)validateNumber:(NSString *) textString
{
    NSString* number=@"^[0-9]+$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:textString];
}
#pragma mark 判读字符串字符个数
+(NSUInteger) asciiLengthOfString: (NSString *) text {
    
    int strlength = 0;
    char* p = (char*)[text cStringUsingEncoding:NSUTF8StringEncoding];
    for (int i=0 ; i<[text lengthOfBytesUsingEncoding:NSUTF8StringEncoding] ;i++) {
        if (*p) {
            if(*p == '\xe4' || *p == '\xe5' || *p == '\xe6' || *p == '\xe7' || *p == '\xe8' || *p == '\xe9')
            {
                strlength--;
            }
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}


+(NSString *)pictureString:(NSString *)string
{
    NSString *codestr;
    if (string!=nil) {
        NSMutableString *code = [NSMutableString stringWithString:string];
        NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
        codestr = [NSString stringWithFormat:@"%@/%@",supcode,code];
    }

    return codestr;
}

//判断是否含有表情
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

/**
 * @brief 生成当天的某个点（返回的是伦敦时间，可直接与当前时间[NSDate date]比较）
 * @param hour 如hour为“8”，就是上午8:00（本地时间）
 */
+ (NSDate *)getCustomDateWithHour:(NSInteger)hour
{
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    
    //设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return [resultCalendar dateFromComponents:resultComps];
}

#pragma mark 倒计时
+ (NSArray *)timeCountDown:(NSTimer*)timer Nowtime:(NSString*)nowtime Endtime:(NSString*)endtime Count:(int)count;
{
    
    NSString *endtimestring=[NSString stringWithFormat:@"%@",endtime];
    
    NSString *enddate=[self getTimeToShowWithTimestamp:[NSString stringWithFormat:@"%f",[endtimestring doubleValue]]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    NSDate *compareDate=[formatter dateFromString:enddate];//目标时间
    NSDate *nowDate=[NSDate date];//开始时间
    
    if(nowtime !=nil)
    {
        NSString*nowtimestring =[self getTimeToShowWithTimestamp:[NSString stringWithFormat:@"%f",[nowtime doubleValue]+count*1000]];
        nowDate =[formatter dateFromString:nowtimestring];//当前时间
    }
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *d = [calendar components:unitFlags fromDate:nowDate toDate:compareDate options:0];//计算时间差
    
    NSString *day=[NSString stringWithFormat:@"%ld",(long)[d day]];
    NSString *hour=[NSString stringWithFormat:@"%ld",(long)[d hour]];
    NSString *min=[NSString stringWithFormat:@"%ld",(long)[d minute]];
    NSString *sec=[NSString stringWithFormat:@"%ld",(long)[d second]];
    
    NSString *timestr;
    if(day.intValue < 1 && hour.intValue < 1 && min.intValue < 1 && sec.intValue < 1)
    {
        //关闭定时器
        [timer invalidate];
        timer = nil;
        
        day = @"0";hour = @"0";min = @"0";sec = @"0";
        
    }
    timestr = [NSString stringWithFormat:@"%@_%@_%@_%@",day,hour,min,sec];
    NSArray *timeArray = [NSArray array];
    if(timestr !=nil)
    {
        timeArray = [timestr componentsSeparatedByString:@"_"];
        if(timeArray.count)
        {
            return timeArray;
        }
    }
    
    return nil;
}

#pragma mark 判断某个时间是否在7~14点
+ (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour
{
    NSDate *datefrom = [self getCustomDateWithHour:fromHour];
    NSDate *dateto = [self getCustomDateWithHour:toHour];
    
    NSDate *currentDate = [NSDate date];
    
    if ([currentDate compare:datefrom]==NSOrderedDescending && [currentDate compare:dateto]==NSOrderedAscending)
    {
        //该时间在 %d:00-%d:00 之间！", fromHour, toHour);
        return YES;
    }
    return NO;
}
//根据当前时间获取星期几
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六",nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}
//根据时间戳获取星期几
+ (NSString *)getWeekDayFordate:(long long)data
{
    //获取日期
    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];

    NSString *endtimestring=[NSString stringWithFormat:@"%@",data];
    NSString *enddate=[self getTimeToShowWithTimestamp:[NSString stringWithFormat:@"%f",[endtimestring doubleValue]]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    NSDate *compareDate=[formatter dateFromString:enddate];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:compareDate];
    int week = [comps weekday];
  
    NSString *weekStr=[NSString stringWithFormat:@"%@",[arrWeek objectAtIndex:week-1]];
    
    return weekStr;
    
}

+ (NSString*) replaceUnicode:(NSString*)aUnicodeString

{
    NSString *tempStr1 = [aUnicodeString stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                           
                                                          mutabilityOption:NSPropertyListImmutable
                           
                                                                    format:NULL
                           
                                                          errorDescription:NULL];
    
    
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
    
}
+ (void)removeSearchHistory {
    
}

@end
