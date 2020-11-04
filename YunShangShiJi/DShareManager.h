//
//  DShareManager.h
//  dreamer
//
//  Created by ken on 15/1/16.
//  Copyright (c) 2015年 PA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
//#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboSDK.h"
//#import <RennSDK/RennSDK.h>
#import "ShareShopModel.h"

typedef enum : NSUInteger {
    
    STATE_BEGAN = 0, /**< 开始 */
    STATE_SUCCESS = 1, /**< 成功 */
    STATE_FAILED = 2, /**< 失败 */
    STATE_CANCEL = 3 /**< 取消 */
    
} SHARESTATE;

@protocol DShareManagerDelegate <NSObject>

- (void)DShareManagerStatus:(SHARESTATE)shareStatus withType:(NSString *)type;
@end


@interface DShareManager : NSObject <ISSShareViewDelegate>



+(DShareManager *)share;

@property (nonatomic, copy) dispatch_block_t detailBlock;//详情分享回调
@property (nonatomic, copy) dispatch_block_t ShareSuccessBlock; //邀请好友分享成功回调
@property (nonatomic, copy) dispatch_block_t ShareFailBlock;    //邀请好友分享失败回调

//精选推荐分享回调
@property (nonatomic, strong) void(^commendShareBlock)(SHARESTATE shareStatus);
//拼团夺宝分享回调
@property (nonatomic, strong) void(^fightIndianaBlock)(SSResponseState shareStatus);
@property (nonatomic, weak)id <DShareManagerDelegate>delegate;

@property (nonatomic, strong) NSArray *ShareTitleArray;

@property (nonatomic, assign) int taskValue;//1图片 2链接
/**
 * type     分享的平台
 * view     ipad用 暂无用
 */
- (void)shareAppWithType:(ShareType)type View:(UIView *)view Image:(UIImage*)shopImage Title:(NSString*)title WithShareType:(NSString*)type;


- (void)shareAppWithType:(ShareType)type View:(UIView *)view Image:(UIImage*)shopImage WithShareType:(NSString*)type;
/**
 * 分享菜单栏
 */
- (void)shareList:(UIImage*)shopImage Title:(NSString*)title;
- (void)shareListOne;

- (void)shareAppWithType:(ShareType)type withImageShareType:(NSString*)sharetype withImage:(UIImage *)img;

- (void)shareAppWithType:(ShareType)type withLinkShareType:(NSString*)sharetype withLink:(NSString *)link andImagePath:(NSString *)imagePath andTitle:(NSString *)title andContent:(NSString *)content;

- (void)shareAppWithType:(ShareType)type withLink:(NSString *)link andImagePath:(NSString *)imagePath andContent:(NSString *)content;

- (void)sharePersonH5WithType:(ShareType)type withLinkShareType:(NSString*)sharetype withLink:(NSString *)link andImagePath:(NSString *)imagePath andTitle:(NSString *)title andContent:(NSString *)content;

- (void)shareAppWithType:(ShareType)type withLink:(NSString *)link andImagePath:(NSString *)imagePath andContent:(NSString *)content Discription:(NSString *)discription;
@end
