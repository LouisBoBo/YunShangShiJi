//
//  TFPublicClass.m
//  YunShangShiJi
//
//  Created by 云商 on 16/3/31.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFPublicClass.h"

@implementation TFPublicClass

+ (BOOL)judgeChineseString:(NSString *)text
{
    if (text == nil || text.length == 0) {
        return NO;
    }
    
    for (int i=0; i<text.length; ++i)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [text substringWithRange:range];
        const char    *cString = [subString UTF8String];
        if (!(strlen(cString) == 3))
        {
            //不是汉字:%s", cString);
            return NO;
        }
    }
    
    return YES;
//    for(int i=0; i< [text length];i++){
//        int a = [text characterAtIndex:i];
//        if( a > 0x4e00 && a < 0x9fff) {
//            
//        } else {
//            return NO;
//        }
//    }
//    return YES;
}

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


//将图片保存到本地
+ (void)saveImageToLocal:(UIImage*)image Keys:(NSString*)key {
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    //[preferences persistentDomainForName:LocalPath];
    [preferences setObject:UIImagePNGRepresentation(image) forKey:key];
}

//本地是否有相关图片
+ (BOOL)localHaveImage:(NSString*)key {
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    //[preferences persistentDomainForName:LocalPath];
    NSData* imageData = [preferences objectForKey:key];
    if (imageData) {
        return YES;
    }
    return NO;
}

//从本地获取图片
+ (UIImage*)getImageFromLocal:(NSString*)key {
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    //[preferences persistentDomainForName:LocalPath];
    NSData* imageData = [preferences objectForKey:key];
    UIImage* image;
    if (imageData) {
        image = [UIImage imageWithData:imageData];
    }
    else {
        //未从本地获得图片");
    }
    return image;
}


/**< 用户信息 */

+ (void)saveTokenToLocal:(NSString *)token
{
    if (token == nil) {
        return;
    }
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    [preferences setObject:token forKey:USER_TOKEN];
}

+ (NSString *)getTokenFromLocal
{
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    return [preferences objectForKey:USER_TOKEN];
}

+ (NSString *)getUIDFromLocal
{
//    NSString *st = [self getExpData];
//    NSLog(@"st: %@", st);
    
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    return [preferences objectForKey:USER_ID];
}

+ (void)saveUIDToLocal:(NSString *)uid
{
    if (uid == nil) {
        return;
    }
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    [preferences setObject:uid forKey:USER_ID];
}

+ (void)saveRealmToLocal:(NSString *)realm
{
    if (realm == nil) {
        return;
    }
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    [preferences setObject:realm forKey:USER_REALM];
}



+ (NSString *)getRealmFromLocal
{
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    return [preferences objectForKey:USER_REALM];
}

@end
