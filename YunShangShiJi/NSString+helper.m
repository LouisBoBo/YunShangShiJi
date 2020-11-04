//
//  NSString+helper.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/2.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "NSString+helper.h"

#define ISIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

@implementation NSString (helper)
#pragma mark - 计算高度
+ (CGFloat)heightWithString:(NSString *)string font:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    CGSize rtSize;
    if (ISIOS7)
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        rtSize = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        return ceil(rtSize.height) + 0.5;
    }
    else
    {
        rtSize = [string sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        return rtSize.height;
    }
}

+ (CGFloat)widthWithString:(NSString *)string font:(UIFont *)font constrainedToHeight:(CGFloat)height
{
    CGSize rtSize;
    if (ISIOS7)
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        rtSize = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        return rtSize.width;
    }
    else
    {
        rtSize = [string sizeWithFont:font constrainedToSize:CGSizeMake(CGFLOAT_MAX,height) lineBreakMode:NSLineBreakByWordWrapping];
        return rtSize.width;
    }
}

+ (NSString*)getTimeStyle:(TimeStrStyle)style time:(long long)time
{
    if (style == TimeStrStyleDefault) {
        return [self timeInfoWithDateString:time];
    }else if (style == TimeStrStyleMessage)
        return [self timeInfoWithDate:time];
    
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    
    int year=(int)[component year];
    int month=(int)[component month];
    int day=(int)[component day];
    int hour = (int)[component hour];
    int min = (int)[component minute];
    
    NSDate * today=[NSDate date];
    component=[calendar components:unitFlags fromDate:today];
    
    int t_year=(int)[component year];
//    int t_month=(int)[component month];
//    int t_day=(int)[component day];
    int t_hour=(int)[component hour];
    int t_min=(int)[component minute];
    int t_second=(int)[component second];
    int t_total = t_hour*60*60+t_min*60+t_second;
    NSString*string=nil;
    
    long long now=[today timeIntervalSince1970];
    
    long distance=(long)(now-time);
    if(distance<60)
        string=@"刚刚";
    else if(distance<60*60)
        string=[NSString stringWithFormat:@"%ld分钟前",distance/60];
    else if(distance<60*60*12)
        string=[NSString stringWithFormat:@"%ld小时前",distance/60/60];
    else if(distance<t_total)
        string=[NSString stringWithFormat:@"今天 %02d:%02d",hour,min];
    else
        string=[NSString stringWithFormat:@"%d月%d日 %02d:%02d",month,day,hour,min];
//    else if(distance<60*60*24+t_total)
//        string=[NSString stringWithFormat:@"昨天 %02d:%02d",hour,min];
//    else if(distance<60*60*24*2+t_total)
//        string=[NSString stringWithFormat:@"前天 %02d:%02d",hour,min];
//    else if(year==t_year)
//        string=[NSString stringWithFormat:@"%d月%d日 %02d:%02d",month,day,hour,min];
//    else
//        string=[NSString stringWithFormat:@"%d年%02d月%02d日",year,month,day];
    
    return string;
    
}
+ (NSString *)timeInfoWithDate:(long long)time {
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time/1000];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    
    int year=(int)[component year];
    int month=(int)[component month];
    int day=(int)[component day];
    int hour = (int)[component hour];
    int min = (int)[component minute];
    
    NSDate * today=[NSDate date];
    component=[calendar components:unitFlags fromDate:today];
    
//    int t_year=(int)[component year];
    //    int t_month=(int)[component month];
    //    int t_day=(int)[component day];
    int t_hour=(int)[component hour];
    int t_min=(int)[component minute];
    int t_second=(int)[component second];
    int t_total = t_hour*60*60+t_min*60+t_second;
    NSString*string=nil;
    
//    long long now=[today timeIntervalSince1970];
    long long now=[[NSDate date] timeIntervalSince1970];
    
    long distance=(long)(now-time/1000);
    if(distance<60)
        string=@"刚刚";
    else if(distance<t_total)
        string=[NSString stringWithFormat:@"%@%02d:%02d",hour<=12?@"上午":@"下午",hour<=12?hour:hour-12,min];
    else
        string=[NSString stringWithFormat:@"%d年%d月%d日",year,month,day];
    
    return string;
}
/// 显示时间（yyyy年MM月dd日）
+ (NSString *)timeInfoWithDateString:(long long)time
{
    NSDate *oldDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *showOldDate = [formatter stringFromDate:oldDate];
    return showOldDate;
}
#pragma mark - 获取这个字符串中的所有xxx的所在的index
+ (NSMutableArray *)getRangeStr:(NSString *)text findText:(NSString *)findText
{
    
    NSMutableArray *arrayRanges = [NSMutableArray arrayWithCapacity:3];
    
    if (findText == nil && [findText isEqualToString:@""])
    {
        
        return nil;
        
    }
    
    NSRange rang = [text rangeOfString:findText]; //获取第一次出现的range
    
    if (rang.location != NSNotFound && rang.length != 0)
    {
        
        [arrayRanges addObject:[NSNumber numberWithInteger:rang.location]];//将第一次的加入到数组中
        
        NSRange rang1 = {0,0};
        
        NSInteger location = 0;
        
        NSInteger length = 0;
        
        for (int i = 0;; i++)
        {
            
            if (0 == i)
            {//去掉这个xxx
                
                location = rang.location + rang.length;
                
                length = text.length - rang.location - rang.length;
                
                rang1 = NSMakeRange(location, length);
                
            }
            else
            {
                
                location = rang1.location + rang1.length;
                
                length = text.length - rang1.location - rang1.length;
                
                rang1 = NSMakeRange(location, length);
                
            }
            
            //在一个range范围内查找另一个字符串的range
            
            rang1 = [text rangeOfString:findText options:NSCaseInsensitiveSearch range:rang1];
            
            if (rang1.location == NSNotFound && rang1.length == 0)
            {
                
                break;
                
            }
            else//添加符合条件的location进数组
                
                [arrayRanges addObject:[NSNumber numberWithInteger:rang1.location]];
            
        }
        
        return arrayRanges;
        
    }
    
    return nil;
    
}
+ (NSMutableAttributedString *)getAllColorStringInLabel:(NSString *)allstring ColorString:(NSString *)string Color:(UIColor*)color fontSize:(float)size {
    NSMutableAttributedString *allString = [[NSMutableAttributedString alloc]initWithString:allstring];
    NSMutableArray *arr = [self getRangeStr:allstring findText:string];
    for (NSNumber *index in arr) {
        NSRange range = NSMakeRange(index.integerValue, string.length);
        NSMutableDictionary *stringDict = [NSMutableDictionary dictionary];
        [stringDict setObject:color forKey:NSForegroundColorAttributeName];
        [stringDict setObject:[UIFont systemFontOfSize:size] forKey:NSFontAttributeName];
        [allString setAttributes:stringDict range:range];
    }
    return allString;
}

#pragma mark- 当需要改变Label中得一段字体属性时调用
+ (NSMutableAttributedString *)getOneColorInLabel:(NSString *)allstring ColorString:(NSString *)string Color:(UIColor*)color font:(UIFont *)font
{
    NSMutableAttributedString *allString = [[NSMutableAttributedString alloc]initWithString:allstring];
    NSRange stringRange = [allstring rangeOfString:string];
    NSMutableDictionary *stringDict = [NSMutableDictionary dictionary];
    [stringDict setObject:color forKey:NSForegroundColorAttributeName];
    [stringDict setObject:font forKey:NSFontAttributeName];

    [allString setAttributes:stringDict range:stringRange];

    return allString;
}
+ (NSMutableAttributedString *)getOneColorInLabel:(NSString *)allstring ColorString:(NSString *)string Color:(UIColor*)color fontSize:(float)size
{
    NSMutableAttributedString *allString = [[NSMutableAttributedString alloc]initWithString:allstring];
    if(allString !=nil && string != nil)
    {
        NSRange stringRange = [allstring rangeOfString:string];
        NSMutableDictionary *stringDict = [NSMutableDictionary dictionary];
        [stringDict setObject:color forKey:NSForegroundColorAttributeName];
        [stringDict setObject:[UIFont systemFontOfSize:size] forKey:NSFontAttributeName];
        [allString setAttributes:stringDict range:stringRange];
    }
    return allString;
}

+ (NSMutableAttributedString *)getOneColorInLabel:(NSString *)allstring strs:(NSArray *)strs Color:(UIColor*)color fontSize:(float)size
{
    NSMutableAttributedString *allString = [[NSMutableAttributedString alloc]initWithString:allstring];
    NSMutableDictionary *stringDict = [NSMutableDictionary dictionary];
    [stringDict setObject:color forKey:NSForegroundColorAttributeName];
    [stringDict setObject:[UIFont systemFontOfSize:size] forKey:NSFontAttributeName];
    NSRange range = NSMakeRange(0, allString.length);
    for (NSString *str in strs) {
        NSRange strRange = [allstring rangeOfString:str options:NSLiteralSearch range:range];
        if (strRange.location != NSNotFound) {
            range.location = strRange.length + strRange.location;
            range.length -= range.location;
            [allString setAttributes:stringDict range:strRange];
        }
    }
    return allString;
}
+ (NSMutableAttributedString *)getOneColorInLabel:(NSString *)allstring strs:(NSArray *)strs Color:(UIColor*)color font:(UIFont *)font
{
    NSMutableAttributedString *allString = [[NSMutableAttributedString alloc]initWithString:allstring];
    NSMutableDictionary *stringDict = [NSMutableDictionary dictionary];
    [stringDict setObject:color forKey:NSForegroundColorAttributeName];
    [stringDict setObject:font forKey:NSFontAttributeName];
    NSRange range = NSMakeRange(0, allString.length);
    for (NSString *str in strs) {
        NSRange strRange = [allstring rangeOfString:str options:NSLiteralSearch range:range];
        if (strRange.location != NSNotFound) {
            range.location = strRange.length + strRange.location;
            range.length -= range.location;
            [allString setAttributes:stringDict range:strRange];
        }
    }
    return allString;
}

#pragma mark- 设置文章正文字体段距、行间距以及字体大小
+ (NSAttributedString *)attributedStringWithString:(NSString *)string paragraphSpacing:(CGFloat)paragraphSpacing lineSpacing:(CGFloat)lineSpacing fontSize:(CGFloat)size color:(UIColor *)color{
    NSMutableParagraphStyle *pgStyle = [[NSMutableParagraphStyle alloc] init];
    pgStyle.paragraphSpacing = paragraphSpacing;
    pgStyle.lineSpacing = lineSpacing;
    NSDictionary *attrDict = @{NSParagraphStyleAttributeName:pgStyle,NSFontAttributeName:[UIFont systemFontOfSize:size],NSForegroundColorAttributeName:color};
    NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:string attributes:attrDict];
    return attrStr;
}
+ (NSMutableAttributedString *)paragraphLineSpaceAttrWithString:(NSString *)fullStr
                                                      lineSpace:(CGFloat)lineSpace
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:fullStr];;
    NSMutableParagraphStyle *prgpStyle = [[NSMutableParagraphStyle alloc] init];
    [prgpStyle setLineSpacing:lineSpace];
    [attrStr addAttribute:NSParagraphStyleAttributeName
                    value:prgpStyle
                    range:NSMakeRange(0, fullStr.length)];
    return attrStr;
}

@end
