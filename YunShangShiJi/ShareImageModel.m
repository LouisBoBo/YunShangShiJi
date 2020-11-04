//
//  ShareImageModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 16/8/24.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "ShareImageModel.h"

@implementation ShareImageModel
+(void)getShareImageSuccess:(void(^)(id data))Success
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"initiateApp/queryShareLifePic?version=%@&token=%@",VERSION,token];
    [self getDataResponsePath:urlStr success:Success];
}

@end
