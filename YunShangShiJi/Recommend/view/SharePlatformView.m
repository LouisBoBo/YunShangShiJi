//
//  SharePlatformView.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/11.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "SharePlatformView.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "GlobalTool.h"
@implementation SharePlatformView
{
    BOOL is_weixin;
    BOOL is_QQ;
    BOOL is_weibo;
    
    DShareManager *commendShare;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self creatShareView];
    }
    return self;
}

- (void)creatShareView
{
    NSMutableArray *titleArray = [self justWeixinQQ];
    
    self.shareBackView = [[UIView alloc]init];
    self.shareBackView.frame = CGRectMake(ZOOM6(360)-titleArray.count*ZOOM6(120), 0, self.frame.size.width, self.frame.size.height);
    self.shareBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.shareBackView];
    
    UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ZOOM6(100), CGRectGetHeight(self.shareBackView.frame))];
    titlelab.font = [UIFont systemFontOfSize:ZOOM6(28)];
    titlelab.textColor = RGBCOLOR_I(125, 125, 125);
    titlelab.textAlignment = NSTextAlignmentRight;
    titlelab.text= @"同步到";
    [self.shareBackView addSubview:titlelab];
    
    CGFloat btnwith = ZOOM6(80);
    for(int i =0;i<titleArray.count;i++)
    {
        UIButton *sharebtn = [[UIButton alloc]init];
        sharebtn.frame = CGRectMake(CGRectGetMaxX(titlelab.frame)+ZOOM6(30)+(btnwith+ZOOM6(40))*i, ZOOM6(10), btnwith, btnwith);
        [sharebtn setTitle:titleArray[i] forState:UIControlStateNormal];
        [sharebtn setTintColor:[UIColor clearColor]];
        sharebtn.selected = NO;
        sharebtn.tag = 10000+i;
        if([titleArray[i] isEqualToString:@"微信"])
        {
            [sharebtn setImage:[UIImage imageNamed:@"recommend_icon_weixin_nor"] forState:UIControlStateNormal];
            [sharebtn setImage:[UIImage imageNamed:@"recommend_icon_weixin_cel"] forState:UIControlStateSelected];
            self.weixinBtn = sharebtn;
        }else if ([titleArray[i] isEqualToString:@"QQ"])
        {
            [sharebtn setImage:[UIImage imageNamed:@"recommend_icon_QQ_nor"] forState:UIControlStateNormal];
            [sharebtn setImage:[UIImage imageNamed:@"recommend_icon_qq_cel"] forState:UIControlStateSelected];
            self.QQbtn = sharebtn;
        }else if ([titleArray[i] isEqualToString:@"微博"])
        {
            [sharebtn setImage:[UIImage imageNamed:@"recommend_icon_weibo_nor"] forState:UIControlStateNormal];
            [sharebtn setImage:[UIImage imageNamed:@"recommend_icon_weibo_cel"] forState:UIControlStateSelected];
            self.weiboBtn = sharebtn;
        }
        
        [self.shareBackView addSubview:sharebtn];
        [sharebtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)shareClick:(UIButton*)sender
{
    sender.selected = !sender.selected;
}

//判断用户是否安装微信QQ
- (NSMutableArray*)justWeixinQQ
{
    NSMutableArray *titleArray = [NSMutableArray array];
    //判断是否有微信
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        [titleArray addObject:@"微信"];
    }

    //判断是否有qq
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]])
    {
        [titleArray addObject:@"QQ"];
    }
    
    [titleArray addObject:@"微博"];
    return titleArray;
}

#pragma mark *****************分享***********************
- (void)goshare:(BOOL)isshare
{
    if(isshare == YES)
    {
        is_weixin = NO;is_QQ = NO;is_weibo = NO;
    }
    if(self.weixinBtn.selected == YES && !is_weixin)
    {
        is_weixin = YES;
        
//        [self.shareManager shareAppWithType:ShareTypeWeixiSession withLink:self.shareLink andImagePath:self.shareImage andContent:self.shareTitle];
        
        NSString *realm = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID];
        MiniShareManager *minishare = [MiniShareManager share];
        NSString *image = [NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_Upy],self.shareImage];
        NSString *path  = [NSString stringWithFormat:@"/pages/shouye/detail/sweetFriendsDetail/friendsDetail?theme_id=%@&user_id=%@",self.theme_id,realm];
        
        minishare.delegate = self;
        [minishare shareAppWithType:MINIShareTypeWeixiSession Image:image Title:self.shareTitle Discription:nil WithSharePath:path];
    }
    else if (self.QQbtn.selected == YES && !is_QQ)
    {
        is_QQ = YES;
        
        [self.shareManager shareAppWithType:ShareTypeQQSpace withLink:self.shareLink andImagePath:self.shareImage andContent:self.shareTitle];
        
    }else if (self.weiboBtn.selected == YES && !is_weibo)
    {
        is_weibo = YES;
        
        [self.shareManager shareAppWithType:ShareTypeSinaWeibo withLink:self.shareLink andImagePath:self.shareImage andContent:self.shareTitle];
        
    }else{
        if(self.shareFinishBlock)
        {
            self.shareFinishBlock();
        }
    }
}

- (DShareManager*)shareManager
{
    if(_shareManager == nil)
    {
        AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        [app shardk];
        _shareManager = [DShareManager share];
        _shareManager.delegate = self;
    }
    return _shareManager;
}
- (void)DShareManagerStatus:(SHARESTATE)shareStatus withType:(NSString *)type
{
     if(shareStatus != 0)//分享
    {
        if(!is_weixin || !is_QQ || !is_weibo)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self goshare:NO];
            });
           
        }else{
            if(self.shareFinishBlock)
            {
                self.shareFinishBlock();
            }
        }
    }
}

#pragma mark *************小程序分享****************
//小程序分享回调
- (void)MinihareManagerStatus:(MINISHARESTATE)shareStatus withType:(NSString *)type
{
    if(shareStatus != 0)//分享
    {
        if(!is_weixin || !is_QQ || !is_weibo)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self goshare:NO];
            });
            
        }else{
            if(self.shareFinishBlock)
            {
                self.shareFinishBlock();
            }
        }
    }
}

@end
