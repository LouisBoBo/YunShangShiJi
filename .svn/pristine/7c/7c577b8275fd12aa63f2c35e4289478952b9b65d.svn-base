//
//  LiuBingObject.m
//  YunShangShiJi
//
//  Created by yssj on 16/3/11.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "WTFObject.h"

@implementation WTFObject

+(WTFObject *)shareWTF
{
    static WTFObject *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[WTFObject alloc] init];
            instance.myMemberPriceRate=1;
        }
    });
    return instance;
}



@end
