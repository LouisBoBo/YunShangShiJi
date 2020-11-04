//
//  TFJSObjCModel.m
//  YunShangShiJi
//
//  Created by 云商 on 15/10/17.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "TFJSObjCModel.h"

@implementation TFJSObjCModel

- (void)callObjectiveCWithDict:(NSDictionary *)params {
    if (self.index == 0) {
        
        if ([self.delegate respondsToSelector:@selector(callObjectiveCWithHomeWithUserInfo:)]) {
            [self.delegate callObjectiveCWithHomeWithUserInfo:params];
        }
        
    } else if (self.index == 1) {

        if ([self.delegate respondsToSelector:@selector(callObjectiveCWithMyShopWithUserInfo:)]) {
            [self.delegate callObjectiveCWithMyShopWithUserInfo:params];
        }
        
    }
    
}

//用户第一次进入我的店
- (void)callObjectiveCWithIsFirst
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:YES forKey:@"isHome"];
}

//用户每天首次进入我的店
- (NSString *)callObjectiveCWithEverydayFirstGoShop
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *currDate = [self getCurrTimeString:@"year-month-day"];
    NSString *oldDate = [ud objectForKey:@"isEverydayGoShop"];
    if (oldDate == nil || ![oldDate isEqualToString:currDate]) {
        [ud setObject:currDate forKey:@"isEverydayGoShop"];
        return @"true";
    }
    return @"false";
}

- (NSString *)callObjectiveCWithIsOpenShop
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([[ud objectForKey:@"isOpenShop"] intValue] == 1) {
        [ud setBool:NO forKey:@"isOpenShop"];
        //开店
        return @"true";
    }
    return @"false";
}

- (NSString *)callObjectiveCWithIsFirstSign
{
    
    return @"true";
}

//获取用户信息
- (NSString *)callObjectiveCWithReturnUserString
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSString *realm = [NSString stringWithFormat:@"%@",[ud objectForKey:USER_REALM]];
    NSString *token = [NSString stringWithFormat:@"%@",[ud objectForKey:USER_TOKEN]];
    NSString *isIOS = [NSString stringWithFormat:@"%@", @"true"];
    
    NSString *userInfo = [NSString stringWithFormat:@"%@,%@,%@", realm, token, isIOS];
    
//    //userInfo = %@", userInfo);
    
    return userInfo;
}

//刷新主页
- (void)callObjectiveCWithRefreshMyShop
{
    if ([self.delegate respondsToSelector:@selector(callObjectiveCWithRefreshMyShop)]) {
        [self.delegate callObjectiveCWithRefreshMyShop];
    }
    
}

//读取文件
- (NSString *)callObjectiveCWithReturnFileWithName:(NSString *)fileName
{
    //fileName = %@", fileName);
    
    NSString * filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    
//    //filePath = %@", filePath);
    
    NSData *fileData = [[NSData alloc] initWithContentsOfFile:filePath];
    
//    //fileData = %@", fileData);
    
    NSString *fileContent = [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
    
//    //fileContent = %@", fileContent);
    
    return fileContent;
}

- (void)callObjectiveCWithH5ShareStore
{
    NSDictionary *dic = [NSDictionary dictionary];
    if ([self.delegate respondsToSelector:@selector(callObjectiveCWithH5ShareApp:witnIndex:)]) {
        [self.delegate callObjectiveCWithH5ShareApp:dic witnIndex:self.index];
    }
}

- (void)callObjectiveCWithGoLogin
{
    if ([self.delegate respondsToSelector:@selector(callObjectiveCWithGoLogin)]) {
        [self.delegate callObjectiveCWithGoLogin];
    }
}

- (void)callObjectiveCWithH5ShareStoreLink
{
    NSDictionary *dic = [NSDictionary dictionary];
    if ([self.delegate respondsToSelector:@selector(callObjectiveCWithH5ShareStoreLink:witnIndex:)]) {
        [self.delegate callObjectiveCWithH5ShareStoreLink:dic witnIndex:self.index];
    }
}

- (void)callObjectiveCWithBackViewController
{
    if ([self.delegate respondsToSelector:@selector(callObjectiveCWithBackViewControllerWithIndex:)]) {
        [self.delegate callObjectiveCWithBackViewControllerWithIndex:self.index];
    }
}

- (void)callObjectiveCWithChangeShopName:(NSDictionary *)params
{
    //paranms = %@",params);
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:params[@"s_name"] forKey:STORE_NAME];
    
}

- (void)callObjectiveCWithGoShopCart
{
    if ([self.delegate respondsToSelector:@selector(callObjectiveCWithGoShopCart)]) {
        [self.delegate callObjectiveCWithGoShopCart];
    }
}

- (void)callObjectiveCWithGoPersonCenter
{
    if ([self.delegate respondsToSelector:@selector(callObjectiveCWithGoPersonCenter)]) {
        [self.delegate callObjectiveCWithGoPersonCenter];
    }
}
- (void)callObjectiveCWithH5EditStoreModel:(NSDictionary *)params
{
    if ([self.delegate respondsToSelector:@selector(callObjectiveCWithH5EditStoreModelInfo:)]) {
        [self.delegate callObjectiveCWithH5EditStoreModelInfo:params];
    }
}


- (NSString *)getCurrTimeString:(NSString *)type
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
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
        NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        
        NSDateComponents *comps = [calendar components:unitFlags fromDate:curDate];
        NSInteger week = [comps weekday];
        return [NSString stringWithFormat:@"%d",(int)week];
    }
    return showCurDate;
}

- (void)callObjectiveCWithGuideComplete
{
    if ([self.delegate respondsToSelector:@selector(callObjectiveCWithGuideComplete)]) {
        [self.delegate callObjectiveCWithGuideComplete];
    }
}

- (void)callObjectiveCWithAlreadyRed:(NSDictionary *)params;
{
    if ([self.delegate respondsToSelector:@selector(callObjectiveCWithAlreadyRed:)]) {
        [self.delegate callObjectiveCWithAlreadyRed:params];
    }
}


@end
