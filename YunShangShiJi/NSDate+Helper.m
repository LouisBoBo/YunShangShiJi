//
//  NSDate+Helper.m
//  YunShangShiJi
//
//  Created by zgl on 16/7/8.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "NSDate+Helper.h"
#import "GlobalTool.h"
#import "MyMD5.h"
#import "AFNetworking.h"

@implementation NSDate (Helper)

+ (void)systemCurrentTime:(void (^)(long long time))block {
    NSString *url=[NSString stringWithFormat:@"%@order/getNow?version=%@&token=%@",[NSObject baseURLStr],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]];
    NSString *URL=[MyMD5 authkey:url];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"------------------------------------------>\n%@\n------------------------------------------>",responseObject);
        long long time = 0;
        if (responseObject != nil) {
            NSString *str=responseObject[@"status"];
            if(str.intValue==1)
                time = [responseObject[@"now"] longLongValue];
        }
        if (time == 0) {
            time = [NSDate date].timeIntervalSince1970*1000;
        }
        if (block) {
            block(time);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        long long time = [NSDate date].timeIntervalSince1970*1000;
        if (block) {
            block(time);
        }
    }];
}

@end
