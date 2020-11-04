//
//  MiniShareManager.m
//  YunShangShiJi
//
//  Created by YF on 2017/12/15.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "MiniShareManager.h"
#import "GlobalTool.h"
#import "AppDelegate.h"
@implementation MiniShareManager

static MiniShareManager *shareManager = nil;

+(MiniShareManager *)share{
    @synchronized(self)
    {
        if (shareManager == nil) {
            shareManager = [[MiniShareManager alloc] init];
        }
        return shareManager;
    }
}
- (void)shareAppWithType:(MINISHARETYPE)type Image:(NSString*)shopImage Title:(NSString*)title Discription:(NSString*)discription WithSharePath:(NSString*)path;
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isMiniShare"];
    
    WXMiniProgramObject *wxminiobject = [WXMiniProgramObject object];
    wxminiobject.webpageUrl = [NSString stringWithFormat:@"http://www.52yifu.com/view/activity/mission.html?realm=%@",[[NSUserDefaults standardUserDefaults] objectForKey:USER_ID]];
    
    NSString * baseurl = [NSObject baseURLStr];
    
    if(![baseurl containsString:@"www.52yifu.wang"])//正式环境
    {
        wxminiobject.userName = @"gh_05d342ef9932";
    }else{
        wxminiobject.userName = @"gh_01f3abb24f0b";
    }

    wxminiobject.path = path;
    
    if([shopImage hasPrefix:@"http"])
    {
        wxminiobject.hdImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:shopImage]];
    }else{
        UIImage *image = [UIImage imageNamed:shopImage];
        NSData *imageData = UIImagePNGRepresentation(image);
        wxminiobject.hdImageData = imageData;
    }
    WXMediaMessage*message = [WXMediaMessage message];
    message.title = title;
    message.description = @"我的衣蝠";
    message.mediaObject = wxminiobject;
    message.thumbData = nil;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
    req.message = message;
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];
}
- (void)testshareAppImageWithType:(MINISHARETYPE)type Image:(UIImage*)shopImage Title:(NSString*)title Discription:(NSString*)discription WithSharePath:(NSString*)path;
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isMiniShare"];
    
    WXMiniProgramObject *wxminiobject = [WXMiniProgramObject object];
    wxminiobject.webpageUrl = [NSString stringWithFormat:@"http://www.52yifu.com/view/activity/mission.html?realm=%@",[[NSUserDefaults standardUserDefaults] objectForKey:USER_ID]];
    
    NSString * baseurl = [NSObject baseURLStr];
    
    if(![baseurl containsString:@"www.52yifu.wang"])//正式环境
    {
        wxminiobject.userName = @"gh_05d342ef9932";
    }else{
        wxminiobject.userName = @"gh_01f3abb24f0b";
    }
    
    wxminiobject.path = path;
    
    NSData *imageData = UIImageJPEGRepresentation(shopImage,0.8f);
    wxminiobject.hdImageData = imageData;
    
    WXMediaMessage*message = [WXMediaMessage message];
    message.title = title;
    message.description = @"我的衣蝠";
    message.mediaObject = wxminiobject;
    message.thumbData = nil;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
    req.message = message;
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];
}
- (void)shareAppImageWithType:(MINISHARETYPE)type Image:(NSData*)shopImage Title:(NSString*)title Discription:(NSString*)discription WithSharePath:(NSString*)path;
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isMiniShare"];
    
    WXMiniProgramObject *wxminiobject = [WXMiniProgramObject object];
    wxminiobject.webpageUrl = [NSString stringWithFormat:@"http://www.52yifu.com/view/activity/mission.html?realm=%@",[[NSUserDefaults standardUserDefaults] objectForKey:USER_ID]];
    
    NSString * baseurl = [NSObject baseURLStr];
    
    if(![baseurl containsString:@"www.52yifu.wang"])//正式环境
    {
        wxminiobject.userName = @"gh_05d342ef9932";
    }else{
        wxminiobject.userName = @"gh_01f3abb24f0b";
    }
    
    wxminiobject.path = path;
    
    wxminiobject.hdImageData = shopImage;
    
    WXMediaMessage*message = [WXMediaMessage message];
    message.title = title;
    message.description = @"我的衣蝠";
    message.mediaObject = wxminiobject;
    message.thumbData = nil;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
    req.message = message;
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];
}
- (NSString*)newtaskrawardHttp:(NSString *)strtype Price:(NSString *)price Brand:(NSString *)brand
{
    NSString *textstr = @"";
    
    textstr = [NSString stringWithFormat:@"快来%.1f元抢【%@正品%@】，专柜价%.1f元！",[DataManager sharedManager].app_value,brand,strtype,price.floatValue];
    
    return textstr;
}
- (NSString*)taskrawardHttp:(NSString*)strtype Price:(NSString*)price Brand:(NSString*)brand
{
    NSString *textstr = @"";
    
    NSString *URL= [NSString stringWithFormat:@"%@paperwork/paperwork.json",[NSObject baseURLStr_Upy]];
    NSURL *httpUrl=[NSURL URLWithString:URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:httpUrl];
    request.timeoutInterval = 3;
    
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            
            if (responseObject[@"wxdddfx"] != nil ){
                if(responseObject[@"wxdddfx"][@"title"] != nil)
                {
                    NSString *str0 = responseObject[@"wxdddfx"][@"title"];
                    str0 = [str0 stringByReplacingOccurrencesOfString:@"${replace}元" withString:[NSString stringWithFormat:@"%.1f元",price.floatValue]];
                    
                    brand = ([brand isEqualToString:@"<null>"] || [brand isEqual:[NSNull null]])?@"衣蝠":brand;
                    str0 = [str0 stringByReplacingOccurrencesOfString:@"${replace}品牌" withString:[NSString stringWithFormat:@"%@品牌",brand]];
                    
                    str0 = [str0 stringByReplacingOccurrencesOfString:@"${replace}" withString:[NSString stringWithFormat:@"%@",strtype]];
                    textstr = str0;
                }
            }
        }
    }
    
    return textstr;
}
#pragma mark 微信支付、分享结果回调
-(void)onResp:(BaseResp*)resp
{
    //0成功 -1错误 -2取消
    if([self.delegate respondsToSelector:@selector(MinihareManagerStatus:withType:)]){
        MINISHARESTATE st = 999;
        switch (resp.errCode) {
            case WXSuccess: //分享成功！
    
                st = MINISTATE_SUCCESS;
                [self shareSuccessStatistic];
                break;
            case WXErrCodeCommon://分享错误！
                
                st = MINISTATE_FAILED;
                break;
            case WXErrCodeUserCancel://分享取消！
                
                st = MINISTATE_CANCEL;
                break;
                
            default:
                
                break;
        }
        
        [self.delegate MinihareManagerStatus:st withType:nil];
    }
    
    [self shareFailStatistic];
}

#pragma mark 分享成功统计
- (void)shareSuccessStatistic
{
    if(self.MinishareSuccess)
    {
        self.MinishareSuccess();
    }
    //签到分享次数统计
    if([Signmanager SignManarer].shareShopCart > 0)
    {
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSString *sharecount = [user objectForKey:TASK_SHARE_SHOPCOUNT];
        [user setObject:[NSString stringWithFormat:@"%d",sharecount.intValue+1] forKey:TASK_SHARE_SHOPCOUNT];
    }
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app shareSuccess];
}
- (void)shareFailStatistic
{
    if(self.MinishareFail)
    {
        self.MinishareFail();
    }
}
@end
