//
//  ManPicModel.m
//  YunShangShiJi
//
//  Created by zgl on 16/7/27.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "ManPicModel.h"

@implementation ManPicModel

+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[ManPicDataModel mappingWithKey:@"data"],@"data",nil];
    return mapping;
}

+ (void)getManPicModelWithShopCodes:(NSString *)shopCodes issueCode:(NSString *)issueCode success:(void (^)(id))success {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"treasures/getParticipationManPic?token=%@&version=%@&shop_code=%@&issue_code=%@",token,VERSION,shopCodes,issueCode];
    [self getDataResponsePath:path success:success];
}

@end


@implementation ManPicDataModel

@end