//
//  TFGlobalTools.h
//  YunShangShiJi
//
//  Created by 云商 on 15/7/1.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "GlobalTool.h"

#ifdef DEBUG
    #define TF_DEBUG 0
#else
    #define TF_DEBUG 0
#endif


#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
//#define SIZE [[UIScreen mainScreen] bounds].size

#define USER_ISPOSITION @"isPosition" //是否开启位置服务

//颜色设置
#define RGBCOLOR_I(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR_I(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGBCOLOR_F(r,g,b) [UIColor colorWithRed:(r) green:(g) blue:(b) alpha:1]
#define RGBACOLOR_F(r,g,b,a) [UIColor colorWithRed:(r) green:(g) blue:(b) alpha:(a)]

//颜色
//玫红色
#define COLOR_ROSERED [UIColor colorWithRed:255/255.f green:63/255.f blue:139/255.f alpha:1]

#define COLOR_RANDOM [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

/**
 *  手机屏幕
 */
#define INCHES_3_5 (480.0 == [UIScreen mainScreen].bounds.size.height)
#define INCHES_4_0 (568.0 == [UIScreen mainScreen].bounds.size.height)
#define INCHES_4_7 (667.0 == [UIScreen mainScreen].bounds.size.height)
#define INCHES_5_5 (736.0 == [UIScreen mainScreen].bounds.size.height)

/**
 *  客服电话
 */
#define COMPANY_PHONENUBER @"4008884224"

/**
 *  验证码等待时间
 */
#define WAITTIME 120

//手机号的正则表达
//#define PHONE_CODE @"1([3|5|8|7][0-9])\\d{8}"
#define PHONE_CODE @"^\\d{11}$"


//邮编的正则表达式
#define POSTCODE @"^[0-9]\\d{5}$"
//密码正则表达式
#define LOGIN_PWD_CODE @"^[A-Za-z0-9]+$"
//邮编数字
#define POSTNUMBER @"1234567890"
//邮箱
//                 @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define EMAIL_CODE @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"

//数字
#define NUMBER @"1234567890"
//又拍云
//#define UPYUN @"https://yssj668.b0.upaiyun.com/"
//上传又拍云图片压缩系数
#define IMGCOMPCOEFF 0.1f
//上传又拍云图片大小压缩系数
#define IMGSIZECOMPCOEFF 2.0f
//版本号

//字体
#define kFont6px(px) [UIFont systemFontOfSize:ZOOM6(px)]
#define kFont6pt(pt) [UIFont systemFontOfSize:kZoom6pt(pt)]

#define LogFunc MyLog(@"%s", __func__)


