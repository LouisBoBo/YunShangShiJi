//
//  SelCommentModel.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/2.
//  Copyright © 2016年 ios-1. All rights reserved.
//  晒单详情

#import "SelCommentModel.h"

@implementation SelCommentModel

+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[SOCommentModel mappingWithKey:@"comment"],@"comment", nil];
    return mapping;
}

+ (void)getSelCommentModelWithShopCode:(NSString *)shopCode success:(void (^)(id))success {
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"shareOrder/selComment?token=%@&version=%@&shop_code=%@",token,VERSION,shopCode];
    [self getDataResponsePath:path success:success];
}

+ (void)addlikeWithShopCode:(NSString *)shopCode success:(void (^)(id))success {
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"shareOrder/addClick?token=%@&version=%@&shop_code=%@",token,VERSION,shopCode];
    [self getDataResponsePath:path success:success];
}

+ (void)sendMessageWithShopCode:(NSString *)shopCode toUserId:(NSString *)userId content:(NSString *)content success:(void (^)(id))success {
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = nil;
    NSString *toUID = userId?:@"";
    if (userId) {
        path = [NSString stringWithFormat:@"shareOrder/replyComment?token=%@&version=%@&shop_code=%@&to_user_id=%@&content=%@",token,VERSION,shopCode,toUID,content];
    } else {
        path = [NSString stringWithFormat:@"shareOrder/replyComment?token=%@&version=%@&shop_code=%@&content=%@",token,VERSION,shopCode,content];
    }
    [self getDataResponsePath:path success:success];
}

@end


@implementation SOCommentModel

@end