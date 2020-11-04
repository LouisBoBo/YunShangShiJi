//
//  NSString+TFCommon.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/12.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "NSString+TFCommon.h"
#import <sys/utsname.h>
#import "SSKeychain.h"
#import "SSKeychainQuery.h"
@implementation NSString (TFCommon)

+ (NSString *)userNameRandomProduce
{
    NSString *text = @"";
    while (text.length<2) {
        NSString *temp = text;
        text = [NSString stringWithFormat:@"%@%@", [NSString userNameFormFile], temp];
    }
    text = [NSString stringWithFormat:@"%@**%@", [text substringToIndex:1], [text substringFromIndex:text.length-1]];
    
    return text;
}

+ (NSString *)userNameFormFile
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"用户昵称生成表" ofType:@"txt"];
    NSString *string = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSArray *stringsArray = [string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (!stringsArray.count) {
        return @"莉萍";
    }
    NSInteger index = arc4random() % stringsArray.count;
    NSString *text = stringsArray[index];
    
    return text;
}

+(NSString *)userHeadRandomProduce
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"用户头像生成表" ofType:@"txt"];
    NSString *string = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSArray *stringsArray = [string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (!stringsArray.count) {
        return @"9358d109b3de9c82748f306b6a81800a18d84368.jpg";
    }
    NSInteger index = arc4random() % stringsArray.count;
    
    NSString *text = [NSString stringWithFormat:@"%@",stringsArray[index]];
    
    return text;

}
+ (NSArray *)userImgArrRandomProduce {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"用户头像生成表" ofType:@"txt"];
    NSString *string = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSArray *stringsArray = [string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (!stringsArray.count) {
        return @[@"9358d109b3de9c82748f306b6a81800a18d84368.jpg"];
    }
    
    NSMutableSet *randomSet = [[NSMutableSet alloc] init];
    while ([randomSet count] < 5) {
        int r = arc4random() % [stringsArray count];
        [randomSet addObject:[NSString stringWithFormat:@"%@",[stringsArray objectAtIndex:r]]];
    }
    NSArray *randomArray = [randomSet allObjects];
    
    return randomArray;
}
//获得设备型号
+ (NSString *)stringCurrentDeviceModel
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4s (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}

#pragma mark - 注释:输入字体，和限制size，求出文本的size
- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    CGSize resultSize = CGSizeZero;
    if (self.length <= 0) {
        return resultSize;
    }
    resultSize = [self boundingRectWithSize:size
                                    options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)
                                 attributes:@{NSFontAttributeName: font}
                                    context:nil].size;
    resultSize = CGSizeMake(MIN(size.width, ceilf(resultSize.width)), MIN(size.height, ceilf(resultSize.height)));
    return resultSize;
}
#pragma mark - 注释:输入字体，和限制size，求出文本的高度
- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    return [self getSizeWithFont:font constrainedToSize:size].height;
}
#pragma mark - 注释:输入字体，和限制size，求出文本的宽度
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    return [self getSizeWithFont:font constrainedToSize:size].width;
}

-(BOOL)containsEmoji{
    if (!self || self.length <= 0) {
        return NO;
    }
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
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
             // non surrogate
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

- (NSString *)trimWhitespace
{
    NSMutableString *str = [self mutableCopy];
    CFStringTrimWhitespace((__bridge CFMutableStringRef)str);
    return str;
}

- (BOOL)isEmpty
{
    return [[self trimWhitespace] isEqualToString:@""];
}

//判断是否为整形
- (BOOL)isPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形
- (BOOL)isPureFloat{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}
//判断是否是手机号码或者邮箱
- (BOOL)isPhoneNo{
    // http://blog.csdn.net/lun379292733/article/details/8169807
//    NSString *regMobile= @"/^1[3,5,8]\d{9}$/";
    NSString *phoneRegex = @"1[3|5|7|8|][0-9]{9}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:self];
}
- (BOOL)isEmail{
    //var regEmail=/^([a-zA-Z0-9]+[_|\-|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\-|\.]?)*[a-zA-Z0-9]+(\.[a-zA-Z]{2,3})+$/;
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isIdCard
{
    //判断位数
    if ([self length] < 15 ||[self length] > 18) {
        return NO;
    }
    
    NSString *regIdCard = @"^(\\d{15}$|^\\d{18}$|^\\d{17}(\\d|X|x))$";
    NSPredicate *IdCardTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regIdCard];
    BOOL IdBool =  [IdCardTest evaluateWithObject:self];
    
    if (IdBool) { // 如果通过该验证，说明身份证格式正确，但准确性还需计算
        NSArray *idCardWi = @[@7, @9, @10, @5, @8, @4, @2, @1, @6, @3, @7, @9, @10, @5, @8, @4, @2]; //将前17位加权因子保存在数组里
        NSArray *idCardY = @[@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];  ////这是除以11后，可能产生的11位余数、验证码，也保存成数组
        
        NSString *sPaperId = self; // 待验证的
        
        NSMutableString *mString = [NSMutableString stringWithString:sPaperId];
        
        if (mString.length == 15) { //15位身份证
            [mString insertString:@"19" atIndex:6];
            
            long p = 0;
            const char *pid = [mString UTF8String];
            for (int i = 0; i<= 16; i++) {
                p += (pid[i]-48) * [idCardWi[i] integerValue];
            }
            
            int o = p%11;
            NSString *string_content = [NSString stringWithFormat:@"%@",idCardY[o]];
            [mString insertString:string_content atIndex:[mString length]];
            sPaperId = mString; // 15位身份证转成了 18位
        }
        
        NSInteger idCardWiSum = 0; //用来保存前17位各自乖以加权因子后的总和
        for (int i = 0; i<idCardWi.count; i++) {
            idCardWiSum += [[sPaperId substringWithRange:NSMakeRange(i, 1)] integerValue] * [idCardWi[i] integerValue];
        }
        NSInteger idCardMod = idCardWiSum % 11; // //计算出校验码所在数组的位置
        NSString *idCardLast = [sPaperId substringFromIndex:sPaperId.length-1]; // //得到最后一位身份证号码
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod == 2) {
            if([idCardLast isEqualToString:@"X"] || [idCardLast isEqualToString:@"x"]){
                MyLog(@"恭喜通过验证啦！");
                return YES;
            } else{
                MyLog(@"身份证号码错误！");
                return NO;
            }
        } else {
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast integerValue] == [idCardY[idCardMod] integerValue]) {
                MyLog(@"恭喜通过验证啦！");
                return YES;
            } else{
                MyLog(@"身份证号码错误！");
                return NO;
            }
        }
    } else { // 不是身份证号
        MyLog(@"身份证格式不正确!");
        return NO;
    }
    return YES;
}

+ (NSMutableAttributedString *)attributedSourceString:(NSString *)string targetString:(NSString *)targetString addAttributes:(NSDictionary *)addAttributes
{
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range = [string rangeOfString:targetString];
    [attString addAttributes:addAttributes range:range];
    return attString;
}


@end
