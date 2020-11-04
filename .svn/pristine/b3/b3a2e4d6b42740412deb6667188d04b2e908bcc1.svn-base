//
//  TopicPublicModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/21.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TopicPublicModel.h"
#import "LastCommentsModel.h"
#import "ShopDetailModel.h"
#import "TShoplistModel.h"
@implementation TopicPublicModel
+ (NSMutableDictionary *)getMapping
{
    NSMutableDictionary *mapping = [NSMutableDictionary dictionaryWithObjectsAndKeys:[LastCommentsModel mappingWithKey:@"list"], @"data",[LastCommentsModel mappingWithKey:@"hotlist"],@"data2",[TShoplistModel mappingWithKey:@"shop_list"],@"shop_list",nil];
    return mapping;
}

+ (void)ThumbstData:(NSInteger)type This_id:(NSString*)this_id Theme_id:(NSString*)theme_id Success:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"fc/addApplaud?token=%@&version=%@&type=%d&this_id=%@&theme_id=%@",token,VERSION,(int)type,this_id,theme_id];
    [self getDataResponsePath:path success:success];

}

+ (void)DisThumbstData:(NSInteger)type This_id:(NSString*)this_id  Theme_id:(NSString*)theme_id Success:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"fc/removeApplaud?token=%@&version=%@&type=%d&this_id=%@&theme_id=%@",token,VERSION,(int)type,this_id,theme_id];
    [self getDataResponsePath:path success:success];

}

+ (void)FollowData:(NSInteger)type Friend_user_id:(NSString*)friend_user_id Success:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"fc/addOrDelMiYou?token=%@&version=%@&type=%d&friend_user_id=%@",token,VERSION,(int)type,friend_user_id];
    [self getDataResponsePath:path success:success];
}

+ (void)CommentData:(NSString*)content Location:(NSString*)location Theme_id:(NSString*)theme_id Base_user_id:(NSString*)base_user_id Success:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"fc/sendReply?token=%@&version=%@&location=%@&theme_id=%@&content=%@&base_user_id=%@",token,VERSION,location,theme_id,content,base_user_id];
    [self getDataResponsePath:path success:success];
}

+ (void)ReplyData:(NSString*)content Comment_id:(NSString*)comment_id Receive_user_id:(NSString*)receive_user_id Success:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path;
    
    if(receive_user_id.intValue > 0 )
    {
        path = [NSString stringWithFormat:@"fc/addReply?token=%@&version=%@&comment_id=%@&receive_user_id=%@&content=%@",token,VERSION,comment_id,receive_user_id,content];
    }else{
        path = [NSString stringWithFormat:@"fc/addReply?token=%@&version=%@&comment_id=%@&content=%@",token,VERSION,comment_id,content];
    }
    [self getDataResponsePath:path success:success];
}

+ (void)LastComments:(NSString*)theme_id Page:(NSInteger)page Pagesize:(NSInteger)pagesize Success:(void(^)(id data))success;

{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path ;
    if(token.length >10)
    {
        path = [NSString stringWithFormat:@"fc/latestComments?token=%@&version=%@&theme_id=%@&curPage=%d&pageSize=%zd",token,VERSION,theme_id,(int)page,pagesize];
    }else{
        path = [NSString stringWithFormat:@"fc/latestComments?&version=%@&theme_id=%@&curPage=%d&pageSize=%zd",VERSION,theme_id,(int)page,pagesize];
    }
    [self getDataResponsePath:path success:success];
}

+ (void)LandlordComments:(NSString*)theme_id Theme_user_id:(NSString*)theme_user_id Page:(NSInteger)page Pagesize:(NSInteger)pagesize Success:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path ;
    if(token.length >10)
    {
        path = [NSString stringWithFormat:@"fc/onlyLookBuilding?token=%@&version=%@&theme_id=%@&theme_user_id=%@&curPage=%d&pageSize=%zd",token,VERSION,theme_id,theme_user_id,(int)page,pagesize];
    }else{
        path = [NSString stringWithFormat:@"fc/onlyLookBuilding?&version=%@&theme_id=%@&theme_user_id=%@&curPage=%d&pageSize=%zd",VERSION,theme_id,theme_user_id,(int)page,pagesize];
    }
    [self getDataResponsePath:path success:success];
}
+ (void)DtleateTheme:(NSString*)theme_id Success:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"fc/deleteTheme?token=%@&version=%@&theme_id=%@",token,VERSION,theme_id];
    [self getDataResponsePath:path success:success];
}


+ (void)AddCollectionTheme:(NSString*)theme_id Success:(void(^)(id data))success
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"fc/addCollect?token=%@&version=%@&theme_id=%@",token,VERSION,theme_id];
    [self getDataResponsePath:path success:success];

}

+ (void)DelCollectionTheme:(NSString*)theme_id Success:(void(^)(id data))success
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"fc/delCollect?token=%@&version=%@&theme_id=%@",token,VERSION,theme_id];
    [self getDataResponsePath:path success:success];

}

+ (void)DetailRecommendShop:(NSString*)theme_id Onlyid:(NSString*)nolyid Page:(NSInteger)page Success:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"fc/QueryTRSList?token=%@&version=%@&theme_id=%@&curPage=%d&pageSize=10",token,VERSION,theme_id,(int)page];
    if(nolyid != nil)
    {
       path = [NSString stringWithFormat:@"fc/QueryTRSList?token=%@&version=%@&theme_id=%@&only_id=%@&curPage=%d&pageSize=10",token,VERSION,theme_id,nolyid,(int)page];
    }
    [self getDataResponsePath:path success:success];
}

+ (void)GetisMandayDataSuccess:(void(^)(id data))success
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"/signIn2_0/isMonday?token=%@&version=%@",token,VERSION];
    [self getDataResponsePath:path success:success];

}


@end
