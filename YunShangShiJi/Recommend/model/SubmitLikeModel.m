//
//  SubmitLikeModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/18.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "SubmitLikeModel.h"

@implementation SubmitLikeModel

+(void)SubmitShopLikeTitle:(NSString*)title Content:(NSString*)content Pics:(NSString*)pics Tags:(NSString*)tags Location:(NSString*)location Theme_type:(NSInteger)type Shopcodes:(NSString*)shopcodes Success:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"fc/send?token=%@&version=%@&shop_codes=%@&title=%@&content=%@&customTags=%@&tags=%@&location=%@&theme_type=%d",token,VERSION,shopcodes,title,content,tags,tags,location,(int)type];
    [self getDataResponsePath:path success:success];

}

@end
