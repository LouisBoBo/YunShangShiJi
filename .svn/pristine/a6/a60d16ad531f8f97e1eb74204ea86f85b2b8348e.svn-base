//
//  DoubleModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 16/6/30.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "DoubleModel.h"

@implementation DoubleModel
+(void)getDoubleEntrance:(int)entrance Sucess:(void(^)(id data))success
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"wallet/ openTfn?version=%@&token=%@&entrance=%d",VERSION,token,entrance];
    [self getDataResponsePath:urlStr success:success];
}
@end
