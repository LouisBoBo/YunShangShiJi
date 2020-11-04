//
//  Tools.m
//  test
//
//  Created by ken on 15/1/2.
//  Copyright (c) 2015年 Ken. All rights reserved.
//

#import "Tools.h"
#import "GlobalTool.h"
#import "UIImage_extra.h"
//#import "MBProgressHUD.h"
#import <objc/runtime.h>

@implementation Tools

static Tools *_tools = nil;

+(Tools *)share{
    @synchronized(self)
    {
        if (_tools == nil) {
            _tools = [[Tools alloc] init];
        }
        return _tools;
    }
}

/**
 * 判断字符串中是否包含表情
 */
-(BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
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

- (UIBarButtonItem *)createRightBarButtonItem:(NSString *)title target:(id)obj selector:(SEL)selector ImageName:(NSString*)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightButton setImage:image forState:UIControlStateNormal];
    [self.rightButton setTitle:title forState:UIControlStateNormal];
    //FIX ME:!!!不是所有的右上按钮都是更多！
    self.rightButton.accessibilityLabel = title;
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.rightButton setTitleColor:[UIColor colorWithRed:55/255.0 green:203/255.0 blue:253/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
//    [self.rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor colorWithWhite:1 alpha:0.6] forState:UIControlStateDisabled];
    [self.rightButton addTarget:obj action:selector forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton sizeToFit];
    [self.rightButton setAccessibilityLabel:title];
    //iOS7之前的版本需要手动设置和屏幕边缘的间距
    if (kIOSVersions < 7.0) {
        self.rightButton.frame = CGRectInset(self.rightButton.frame, -10, 0);
    }
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    return item;
}

- (UIBarButtonItem *)createLeftBarButtonItem:(NSString *)title target:(id)obj selector:(SEL)selector ImageName:(NSString*)imageName
{
    if (!imageName) {
        imageName = @"hd_back";
    }
    UIImage *image = [UIImage imageNamed:imageName];
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftButton setImage:image forState:UIControlStateNormal];
    [self.leftButton setAccessibilityLabel:title];
    [self.leftButton setAccessibilityLabel:@"返回"];
    
//    CGSize titleSize = [title sizeWithAttributes:[UIFont systemFontOfSize:18]];
//    if (titleSize.width < 44) {
//        titleSize.width = 44;
//    }
//    self.leftButton.frame = CGRectMake(0, 0, titleSize.width, 44);
    self.leftButton.titleLabel.font = [UIFont systemFontOfSize:18];
    self.leftButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.leftButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.leftButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    //    [self.leftButton setTitleColor:[UIColor colorWithRed:130.0/255 green:56.0/255 blue:23.0/255 alpha:1] forState:UIControlStateHighlighted];
    [self.leftButton setTitleColor:[UIColor colorWithWhite:1 alpha:0.6] forState:UIControlStateDisabled];
    [self.leftButton addTarget:obj action:selector forControlEvents:UIControlEventTouchUpInside];
    [self.leftButton sizeToFit];
    
    //iOS7之前的版本需要手动设置和屏幕边缘的间距
    if (kIOSVersions < 7.0) {
        self.leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }else{
        self.leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        self.leftButton.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    }
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.leftButton];
    return item;
}

/**
 * 获取当前日期
 */
- (NSString *)getDate{
    NSDate * senddate=[NSDate date];
    NSCalendar * cal = [NSCalendar currentCalendar];
    NSUInteger unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    NSInteger year = [conponent year];
    NSInteger month = [conponent month];
    NSInteger day = [conponent day];
    NSString * nsDateString= [NSString stringWithFormat:@"%d%d%d",year,month,day];
    
    return nsDateString;
}

/**
 * 获取当前时间
 */
- (NSString *)getTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"yyyyMMddHHmmss"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    NSString *timeDesc = [formatter stringFromDate:[NSDate date]];
    return timeDesc;
}

/**
 * 压缩图片
 */
+ (NSData *)dataWithcompressImage:(UIImage *)image {
    CGSize imageSize = image.size;
    //取宽高的最大值
    float maxSize = MAX(imageSize.width, imageSize.height);
    NSData *data = nil;
    if (maxSize >= 1000.0)
    {
        float scaleValue = 1000.0/maxSize;
        image = [image scaleImageToScale:scaleValue];
        data = UIImageJPEGRepresentation(image, 0.5);
    }else if(maxSize < 1000 && maxSize >= 500){
        data = UIImageJPEGRepresentation(image, 0.6);
    }else if(maxSize < 500 && maxSize >=200){
        data = UIImageJPEGRepresentation(image,0.7);
    }else{
        data = UIImageJPEGRepresentation(image,1);
    }
    return data;
}

/**
 * string：  文本
 * font：    字体大小
 * size：    范围宽高
 */
- (CGSize )getTextSizeWithString:(NSString *)string font:(UIFont *)font size:(CGSize )CustonSize
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize textSize = [string boundingRectWithSize:CustonSize options: NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return textSize;
}

/**
 * 弹框  1.5秒
 * str： 弹框文字
 */
#if 0
- (void)showLoadingWithText:(NSString *)str WithView:(UIView *)view
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:kUIWindow];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = str;
    [hud show:YES];
    [hud hide:YES afterDelay:1.5];
    [view addSubview:hud];
}

/**
 * 弹框
 * str：   弹框文字
 * delay ：持续时间
 * view：  在哪个界面
 */
- (void)showLoadingWithText:(NSString *)str afterDelay:(CGFloat)delay WithView:(UIView *)view
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:kUIWindow];
//    hud.mode = MBProgressHUDModeCustomView;  //隐藏菊花
//    hud.dimBackground = YES;                  //蒙版
    hud.labelText = str;
    [hud show:YES];
    if (delay) {
        NSTimeInterval time = delay;
        [hud hide:YES afterDelay:time];
    }
    [view addSubview:hud];
}

/**
 * 取消弹框
 * view：  界面
 */
- (void)hideForView:(UIView *)view{
    [MBProgressHUD hideHUDForView:view animated:YES];
}
#endif
/**
 * 判断通知是否开启
 */
+(BOOL)enabledRemoteNotification{
    if (kIOSVersions >= 8.0)
    {
        UIUserNotificationType types = [[UIApplication sharedApplication] currentUserNotificationSettings].types;
        return (types & UIRemoteNotificationTypeAlert);
    }
    else
    {
        UIRemoteNotificationType types = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        return (types & UIRemoteNotificationTypeAlert);
    }
}

//字典对象转为实体对象
+ (void) dictionaryToEntity:(NSDictionary *)dict entity:(NSObject*)entity
{
    if (dict && entity) {
        
        for (NSString *keyName in [dict allKeys]) {
            //构建出属性的set方法
            NSString *destMethodName = [NSString stringWithFormat:@"set%@:",[keyName capitalizedString]];
            //capitalizedString返回每个单词首字母大写的字符串（每个单词的其余字母转换为小写）
            
            SEL destMethodSelector = NSSelectorFromString(destMethodName);
            
            if ([entity respondsToSelector:destMethodSelector]) {
                [entity performSelector:destMethodSelector withObject:[dict objectForKey:keyName]];
            }
            
        }
    }
}

//实体对象转为字典对象
+ (NSDictionary *) entityToDictionary:(id)entity
{
    
    Class clazz = [entity class];
    u_int count;
    
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray* valueArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++)
    {
        objc_property_t prop=properties[i];
        const char* propertyName = property_getName(prop);
        
        [propertyArray addObject:[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
        
        //        const char* attributeName = property_getAttributes(prop);
        //        //%@",[NSString stringWithUTF8String:propertyName]);
        //        //%@",[NSString stringWithUTF8String:attributeName]);
        
        id value =  [entity performSelector:NSSelectorFromString([NSString stringWithUTF8String:propertyName])];
        if(value == nil)
            [valueArray addObject:[NSNull null]];
        else {
            [valueArray addObject:value];
        }
        //        //%@",value);
    }
    
    free(properties);
    
    NSDictionary* returnDic = [NSDictionary dictionaryWithObjects:valueArray forKeys:propertyArray];
    //%@", returnDic);
    
    return returnDic;
}

@end
