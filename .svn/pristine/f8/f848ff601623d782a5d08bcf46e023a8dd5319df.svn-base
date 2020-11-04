//
//  ShareModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/20.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DShareManager.h"

typedef NS_ENUM(NSInteger ,shareType) {
    shareType_weixin_pyq =0,     //微信朋友圈
    shareType_weixin_hy =1,      //微信好友
    shareType_qq_kj =2,          //QQ空间
    shareType_qq_hy =3,          //QQ好友
    shareType_weibo =4           //微博
};
@interface ShareModel : NSObject<DShareManagerDelegate>
@property (nonatomic , copy)   NSString *shareImage;
@property (nonatomic , copy)   NSString *shareTitle;
@property (nonatomic , copy)   NSString *shareLink;
@property (nonatomic , assign) shareType sharetype;

@property (nonatomic , strong) void (^shareResultBlock)(NSInteger statue);

- (void)goshare:(shareType)isshare ShareImage:(NSString*)image ShareTitle:(NSString*)title ShareLink:(NSString*)link Discription:(NSString*)discription;

- (void)goshare:(shareType)isshare ShareImage:(NSString*)image ShareTitle:(NSString*)title ShareLink:(NSString*)link;
@end
