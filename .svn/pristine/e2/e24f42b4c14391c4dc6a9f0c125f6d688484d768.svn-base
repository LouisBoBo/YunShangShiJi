//
//  MiniShareManager.h
//  YunShangShiJi
//
//  Created by YF on 2017/12/15.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

typedef enum : NSUInteger {
    
    MINISTATE_BEGAN = 0, /**< 开始 */
    MINISTATE_SUCCESS = 1, /**< 成功 */
    MINISTATE_FAILED = 2, /**< 失败 */
    MINISTATE_CANCEL = 3 /**< 取消 */
    
} MINISHARESTATE;

typedef enum : NSUInteger {
    
    MINIShareTypeWeixiSession = 11,     /**< 微信好友 */
    MINIShareTypeWeixiTimeline = 12,    /**< 微信朋友圈 */
    
}MINISHARETYPE;

@protocol MiniShareManagerDelegate <NSObject>
- (void)MinihareManagerStatus:(MINISHARESTATE)shareStatus withType:(NSString *)type;
@end

@interface MiniShareManager : NSObject <WXApiDelegate,MiniShareManagerDelegate>

+(MiniShareManager *)share;
@property (nonatomic, weak)id <MiniShareManagerDelegate>delegate;
@property (nonatomic, assign) BOOL isMiniShare;
@property (nonatomic, strong) dispatch_block_t MinishareSuccess;
@property (nonatomic, strong) dispatch_block_t MinishareFail;
- (void)shareAppWithType:(MINISHARETYPE)type Image:(NSString*)shopImage Title:(NSString*)title Discription:(NSString*)discription WithSharePath:(NSString*)path;
- (void)shareAppImageWithType:(MINISHARETYPE)type Image:(NSData*)shopImage Title:(NSString*)title Discription:(NSString*)discription WithSharePath:(NSString*)path;
- (void)testshareAppImageWithType:(MINISHARETYPE)type Image:(UIImage*)shopImage Title:(NSString*)title Discription:(NSString*)discription WithSharePath:(NSString*)path;
- (NSString*)taskrawardHttp:(NSString*)strtype Price:(NSString*)price Brand:(NSString*)brand;
- (NSString*)newtaskrawardHttp:(NSString *)strtype Price:(NSString *)price Brand:(NSString *)brand;
@end
