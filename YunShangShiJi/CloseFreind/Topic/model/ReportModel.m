//
//  ReportModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/20.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "ReportModel.h"

@implementation ReportModel
+ (void)ReportData:(NSString*)content Theme_id:(NSString*)theme_id Success:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"/fc/report?token=%@&version=%@&content=%@&theme_id=%@",token,VERSION,content,theme_id];
    [self getDataResponsePath:path success:success];

}
@end
