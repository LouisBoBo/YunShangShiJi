//
//  HTTPTarbarNum.m
//  YunShangShiJi
//
//  Created by yssj on 16/3/2.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "HTTPTarbarNum.h"
#import "AFNetworking.h"
#import "MyMD5.h"
#import "GlobalTool.h"
#import "SqliteManager.h"

@implementation HTTPTarbarNum

+(void)httpRedCount
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSString *url=[NSString stringWithFormat:@"%@user/finCount?version=%@&token=%@",[NSObject baseURLStr],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]];
    NSString *URL=[MyMD5 authkey:url];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //responseObject = %@   %@", responseObject,responseObject[@"message"]);
        [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"finCount"] forKey:@"finCount"];
        NSString *H5count = [NSString stringWithFormat:@"%@",responseObject[@"H5Count"]];

        int count=0;
        if ([responseObject[@"finCount"]integerValue]==0) {
            [Mtarbar hideBadgeOnItemIndex:4];
            //            [Mtarbar changeBadgeNumOnItemIndex:4 withNum:responseObject[@"finCount"]];
        }
        if ([responseObject[@"finCount"]integerValue]>0) {
            MyLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"%@fourIndex",[[NSUserDefaults standardUserDefaults]objectForKey:USER_ID]]]);
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"%@fourIndex",[[NSUserDefaults standardUserDefaults]objectForKey:USER_ID]]]isEqualToString:[MyMD5 getCurrTimeString:@"year-month-day"]]) {
                [Mtarbar hideBadgeOnItemIndex:4];
            }else
                [Mtarbar showBadgeOnItemIndex:4];
//            [Mtarbar showBadgeOnItemIndex:4];
//            [Mtarbar changeBadgeNumOnItemIndex:4 withNum:responseObject[@"finCount"]];
        }
        if (H5count !=nil && ![H5count isEqualToString:@"<null>"] && [H5count integerValue]>0) {
            
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            NSString * nowDate = [ud objectForKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],MARK_STORE]];
            NSString *hobby = [ud objectForKey:USER_HOBBY];
            MyLog(@"hobby=%@",hobby);
            
            if (![nowDate isEqualToString:[MyMD5 getCurrTimeString:@"year-month-day"]]) {
                if(hobby.length>10)
                {
                    [Mtarbar showBadgeOnItemIndex:0];
                    [Mtarbar changeBadgeNumOnItemIndex:0 withNum:H5count];
                    count +=[H5count integerValue];
                }
            }
        }
        count += [responseObject[@"finCount"] intValue];
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",count] forKey:USER_AllCount];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

+(void)httpGetUserGrade{
    
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:kApi_wallet_getGrade caches:NO cachesTimeInterval:0*TFSecond token:YES success:^(id data, Response *response) {
        if (response.status == 1) {
            [DataManager sharedManager].grade=[[data objectForKey:@"grade"]integerValue];
            [DataManager sharedManager].auseTwofold=[[data objectForKey:@"auseTwofold"]integerValue];
            [DataManager sharedManager].buseTwofold=[[data objectForKey:@"buseTwofold"]integerValue];
            if ([DataManager sharedManager].grade==1) {
                [DataManager sharedManager].vitality=[[data objectForKey:@"vitality"]integerValue];
            }
        } else {
            //            [MBProgressHUD showError:response.message];
        }
    } failure:^(NSError *error) {
        
    }];
}
+ (void)httpGetCircleTagSuccess:(void (^)())success {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:@"" forKey:@"supp_label_data"];
    [parameter setValue:@"true" forKey:@"bool"];
     [[APIClient sharedManager] netWorkGeneralRequestWithApi:@"shop/queryTA?" parameter:parameter caches:NO cachesTimeInterval:0 token:NO success:^(id data, Response *response) {
         MyLog(@"Data :%@",data);
         [[NSUserDefaults standardUserDefaults] setObject:data[@"supp_label_data"] forKey:@"supp_label_data"];
         SqliteManager *manager = [SqliteManager sharedManager];
         [manager deleteCircleTagDataBase];
         for(NSDictionary *dic in data[@"supp_label"]) {
             if(dic !=nil || ![dic isEqual:[NSNull null]]) {
                 TypeTagItem* shopTypeItem = [[TypeTagItem alloc] init];
                 shopTypeItem.ID = [NSString stringWithFormat:@"%@",dic[@"id"]];
                 shopTypeItem.class_name = [NSString stringWithFormat:@"%@",dic[@"name"]];
                 shopTypeItem.icon = [NSString stringWithFormat:@"%@",dic[@"icon"]];
                 shopTypeItem.pic = [NSString stringWithFormat:@"%@",dic[@"pic"]];
                 shopTypeItem.sort = [NSString stringWithFormat:@"%@",dic[@"sort"]];
                 //去掉转义字符\"
                 NSString *responseString = [NSString stringWithString:dic[@"remark"]];
                 responseString = [responseString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                 shopTypeItem.remark = responseString;
                 shopTypeItem.add_time = [NSString stringWithFormat:@"%@",dic[@"add_time"]];
                 shopTypeItem.type = [NSString stringWithFormat:@"%@",dic[@"type"]];
                 [manager insertCircleTagItem:shopTypeItem];
             }
         }
         success();
         
     }failure:^(NSError *error) {
         
     }];
}
@end
