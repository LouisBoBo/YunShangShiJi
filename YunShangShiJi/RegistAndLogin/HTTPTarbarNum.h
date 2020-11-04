//
//  HTTPTarbarNum.h
//  YunShangShiJi
//
//  Created by yssj on 16/3/2.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPTarbarNum : NSObject

+(void)httpRedCount;

/**
 *  获取用户等级
 *  
 *  garde 1==A类 2==B类…以此类推,目前只有两类
    
    A类：为平台正常用户，即可以正常提现余额，支付流程和现有流程一致。
    B类：为平台限制用户，即限制提现，限制余额支付。6元（等消息，量启动后改为3元）
 */
+(void)httpGetUserGrade;


/**
 发布成功后  获取最新标签
 */
+ (void)httpGetCircleTagSuccess:(void (^)())success;
@end
