//
//  ShareModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/20.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "ShareModel.h"
#import "AppDelegate.h"

@implementation ShareModel
#pragma mark *****************分享***********************
- (void)goshare:(shareType)isshare ShareImage:(NSString*)image ShareTitle:(NSString*)title ShareLink:(NSString*)link;
{
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app shardk];
    DShareManager *ds = [DShareManager share];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    ds.fightIndianaBlock = ^(SSResponseState statue){
        switch (statue) {
            case 1:
                [MBProgressHUD show:@"分享成功" icon:nil view:window];
                break;
            case 2:
                [MBProgressHUD show:@"分享失败" icon:nil view:window];
                break;
            case 3:
                [MBProgressHUD show:@"分享取消" icon:nil view:window];
                break;
            default:
                break;
        }
    };
    
    ds.delegate = self;
    
    switch (self.sharetype) {
        case shareType_weixin_pyq:
            self.sharetype = ShareTypeWeixiTimeline;
            
            [ds shareAppWithType:ShareTypeWeixiTimeline withLink:link andImagePath:image andContent:title];

            break;
        case shareType_weixin_hy:
            
            [ds shareAppWithType:ShareTypeWeixiSession withLink:link andImagePath:image andContent:title];

            break;
        case shareType_qq_kj:
            
            [ds shareAppWithType:ShareTypeQQSpace withLink:link andImagePath:image andContent:title];

            break;
        case shareType_qq_hy:
            
            [ds shareAppWithType:ShareTypeQQ withLink:link andImagePath:image andContent:title];

            break;
        case shareType_weibo:
            
            [ds shareAppWithType:ShareTypeSinaWeibo withLink:link andImagePath:image andContent:title];

            break;

        default:
            break;
    }
    
}

- (void)goshare:(shareType)isshare ShareImage:(NSString*)image ShareTitle:(NSString*)title ShareLink:(NSString*)link Discription:(NSString*)discription;
{
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app shardk];
    DShareManager *ds = [DShareManager share];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    ds.fightIndianaBlock = ^(SSResponseState statue){
        switch (statue) {
            case 1:
                [MBProgressHUD show:@"分享成功" icon:nil view:window];
                break;
            case 2:
                [MBProgressHUD show:@"分享失败" icon:nil view:window];
                break;
            case 3:
                [MBProgressHUD show:@"分享取消" icon:nil view:window];
                break;
            default:
                break;
        }
    };
    
    ds.delegate = self;
    
    switch (self.sharetype) {
        case shareType_weixin_pyq:
            self.sharetype = ShareTypeWeixiTimeline;
            
            [ds shareAppWithType:ShareTypeWeixiTimeline withLink:link andImagePath:image andContent:title Discription:discription];
            
            break;
        case shareType_weixin_hy:
            
            [ds shareAppWithType:ShareTypeWeixiSession withLink:link andImagePath:image andContent:title Discription:discription];
            
            break;
        case shareType_qq_kj:
            
            [ds shareAppWithType:ShareTypeQQSpace withLink:link andImagePath:image andContent:title Discription:discription];
            
            break;
        case shareType_qq_hy:
            
            [ds shareAppWithType:ShareTypeQQ withLink:link andImagePath:image andContent:title Discription:discription];
            
            break;
        case shareType_weibo:
            
            [ds shareAppWithType:ShareTypeSinaWeibo withLink:link andImagePath:image andContent:title Discription:discription];
            
            break;
            
        default:
            break;
    }

}
- (void)DShareManagerStatus:(SHARESTATE)shareStatus withType:(NSString *)type
{
    if(shareStatus != 0)//分享取消
    {
        if(self.shareResultBlock)
        {
            self.shareResultBlock(shareStatus);
        }
    }
}

@end
