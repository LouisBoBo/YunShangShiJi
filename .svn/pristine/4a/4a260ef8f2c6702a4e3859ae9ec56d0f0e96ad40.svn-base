//
//  BindingManager.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/9/17.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "BindingManager.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "GlobalTool.h"
#import "BoundPhoneVC.h"
#import "TaskModel.h"
#import "MyMD5.h"

#import <TencentOpenAPI/TencentOAuth.h>
#import <ShareSDKCoreService/ShareSDKCoreService.h>
#import <ShareSDK/ShareSDKPlugin.h>
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <QZoneConnection/ISSQZoneApp.h>

@implementation BindingManager

+(BindingManager*)BindingManarer
{
    static BindingManager *sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        assert(sharedManager != nil);
    });
    return sharedManager;
}
- (void)checkPhoneAndUnionID:(BOOL)redCount Success:(void (^)())success;
{
    //先检测是否绑定手机
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if([user objectForKey:USER_PHONE]==nil)//没有绑定手机
    {
        [self httpFindPhone:nil Success:^{
            
            if(success)
            {
                success();
            }
        }];
    }else
    {
        if([user objectForKey:UNION_ID] != nil)//有绑定微信
        {
            if(success)
            {
                success();
            }
        }else{//没有绑定微信
            [self shareSdkWithAutohorWithTypeGetOpenID:nil dictionary:nil];
        }
    }

}
#pragma mark 判断用户是否绑定过手机
- (void)httpFindPhone:(TaskModel*)model Success:(void (^)())success
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@user/queryPhone?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL = [MyMD5 authkey:urlStr];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                if ([responseObject[@"bool"] boolValue]== YES) { // 绑定过手机
                    
                    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
                    NSString *unionid = [userdefaul objectForKey:UNION_ID];
                    
                    if(unionid == nil)
                    {
                        [self shareSdkWithAutohorWithTypeGetOpenID:nil dictionary:nil];
                        
                    }else{
                        
                        if(success)
                        {
                            success();
                        }
                    }
                    
                } else { //没有绑定过手机
                    
                    [self showPopView];
                }
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
    }];
}

- (void)shareSdkWithAutohorWithTypeGetOpenID:(NSString*)type dictionary:(NSDictionary *)dic {
    
    UIWindow *kwindow = [UIApplication sharedApplication].keyWindow;
    
    //判断设备是否安装微信
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]){
        
    }else{
        
        [MBProgressHUD show:@"亲,你还没安装微信哦~" icon:nil view:kwindow];
        return;
    }
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate shardk];
    
    // 取消授权
    [ShareSDK cancelAuthWithType:ShareTypeWeixiFav];
    
    // 开始授权
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    id<ISSQZoneApp> app =(id<ISSQZoneApp>)[ShareSDK getClientWithType:ShareTypeQQSpace];
    [app setIsAllowWebAuthorize:YES];
    
    kWeakSelf(self);
    [ShareSDK getUserInfoWithType:ShareTypeWeixiFav
                      authOptions:authOptions
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                               
                               if (result)
                               {
                                   NSDictionary *uniondic = (NSDictionary *)[userInfo sourceData];
                                   
                                   if(uniondic[@"unionid"] !=nil)
                                   {
                                       NSString *unionid = [NSString stringWithFormat:@"%@",uniondic[@"unionid"]];
                                       NSString *wx_openid = [userInfo uid];
                                       
                                       [weakself saveunionid:unionid Openid:wx_openid];
                                   }
                               }else{
                                   [MBProgressHUD show:@"亲，微信授权后才能抽红包哦~" icon:nil view:kwindow];
                               }
                               
                           }];
    
}

#pragma mark 修改用户信息 将微信授权unionid传给后台
-(void)saveunionid:(NSString*)unionid Openid:(NSString*)wx_openid
{
    UIWindow *kwindow = [UIApplication sharedApplication].keyWindow;
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    NSString *url=[NSString stringWithFormat:@"%@user/update_userinfo?version=%@&token=%@&unionid=%@&wx_openid=%@",[NSObject baseURLStr],VERSION,token,unionid,wx_openid];
    
    NSString *URL=[MyMD5 authkey:url];
    
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[Animation shareAnimation] stopAnimationAt:kwindow];
        
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            
            if(str.intValue==1)
            {
                MyLog(@"上传成功");
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                [user setObject:unionid forKey:UNION_ID];
                
                    
                if(self.BindingSuccessBlock)
                {
                    self.BindingSuccessBlock();
                }

                [MBProgressHUD show:@"授权成功" icon:nil view:kwindow];
            }
            else{
        
                [MBProgressHUD show:responseObject[@"message"] icon:nil view:kwindow];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //网络连接失败");
       
        [[Animation shareAnimation] stopAnimationAt:kwindow];
    }];

}

- (void)showPopView
{
    PopBindingPhoneView *popView = [[PopBindingPhoneView alloc] init];
    [popView show];
    
    /**
     *  取消 和 确定
     */
    [popView setCancelBlock:^{
        
    } withConfirmBlock:^{
        
        [self gotoBindingVC];
    }];
}

- (void)gotoBindingVC
{
    BoundPhoneVC *tovc = [[BoundPhoneVC alloc] init];
    tovc.hidesBottomBarWhenPushed = YES;
    tovc.comefrom = @"余额红包";
    
    UIViewController *vv = [self topViewController];
    [vv.navigationController pushViewController:tovc animated:YES];
}
//获取当前的VC
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}
- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end

@implementation PopBindingPhoneView

- (instancetype)init
{
    ESWeakSelf;
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        
        CGFloat W_backgrd = kScreenWidth- ZOOM6(85)*2;
        CGFloat H_backgrd = 180;
        
        CGFloat H_titleLab = ZOOM6(40);
        CGFloat H_btn = ZOOM6(80);
        NSString *string = @"为了您的账户安全，请先绑定手机。";
        
        CGSize sizeString = [string boundingRectWithSize:CGSizeMake(W_backgrd-ZOOM6(40)*2, 1000)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:ZOOM6(28)]}
                                                 context:nil].size;
        CGFloat H_contentLab = ceil(sizeString.height);
        H_backgrd = ZOOM6(60) + H_titleLab + ZOOM6(20) + H_contentLab + ZOOM6(60) + H_btn + ZOOM6(50);
        
        UIView *backgroundView = [UIView new];
        backgroundView.tag = 200;
        backgroundView.layer.masksToBounds = YES;
        backgroundView.layer.cornerRadius = ZOOM6(15);
        backgroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backgroundView];
        [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(__weakSelf);
            make.centerY.equalTo(__weakSelf);
            make.size.mas_equalTo(CGSizeMake(W_backgrd, H_backgrd));
        }];
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = @"温馨提示";
        titleLabel.textColor = RGBCOLOR_I(62, 62, 62);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
        [backgroundView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(backgroundView).offset(ZOOM6(60));
            make.left.right.equalTo(backgroundView);
            make.height.mas_equalTo(H_titleLab);
        }];
        
        UILabel *contentLabel = [UILabel new];
        contentLabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
        contentLabel.text = string;
        contentLabel.textColor = RGBCOLOR_I(125, 125, 125);
        contentLabel.numberOfLines = 0;
        [backgroundView addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(backgroundView).offset(ZOOM6(40));
            make.right.equalTo(backgroundView).offset(-ZOOM6(40));
            make.top.equalTo(titleLabel.mas_bottom).offset(ZOOM6(20));
            make.height.mas_equalTo(H_contentLab);
        }];
        
        UIButton *canBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [canBtn setTitle:@"取消" forState:UIControlStateNormal];
        [canBtn setTitleColor:COLOR_ROSERED forState:UIControlStateNormal];
        [canBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        canBtn.layer.masksToBounds = YES;
        canBtn.layer.cornerRadius = ZOOM6(8);
        canBtn.layer.borderColor = [COLOR_ROSERED CGColor];
        canBtn.layer.borderWidth = 1;
        canBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
        [canBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [canBtn setBackgroundImage:[UIImage imageWithColor:COLOR_ROSERED] forState:UIControlStateHighlighted];
        [backgroundView addSubview:canBtn];
        
        [canBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentLabel.mas_left);
            make.bottom.equalTo(backgroundView).offset(-ZOOM6(50));
            make.size.mas_equalTo(CGSizeMake(W_backgrd*0.5-ZOOM6(40)-ZOOM6(15), H_btn));
        }];
        
        UIButton *conBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [conBtn setTitle:@"取消" forState:UIControlStateNormal];
        conBtn.layer.masksToBounds = YES;
        conBtn.layer.cornerRadius = ZOOM6(8);
        [conBtn setTitle:@"确定" forState:UIControlStateNormal];
        [conBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        conBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
        //        conBtn.backgroundColor = COLOR_ROSERED;
        [conBtn setBackgroundImage:[UIImage imageWithColor:COLOR_ROSERED] forState:UIControlStateNormal];
        [conBtn setBackgroundImage:[UIImage imageWithColor:RGBCOLOR_I(204, 20, 93)] forState:UIControlStateHighlighted];
        [backgroundView addSubview:conBtn];
        
        [conBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(contentLabel.mas_right);
            make.bottom.equalTo(backgroundView).offset(-ZOOM6(50));
            make.size.mas_equalTo(CGSizeMake(W_backgrd*0.5-ZOOM6(40)-ZOOM6(15), H_btn));
        }];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        backgroundView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        
        [canBtn addTarget:self action:@selector(canBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [conBtn addTarget:self action:@selector(conBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRClick:)];
        [self addGestureRecognizer:tapGR];
    }
    return self;
}


- (void)setCancelBlock:(CancelBlock)canBlock withConfirmBlock:(ConfirmBlock)conBlock
{
    self.cancelClickBlock = canBlock;
    self.confirmClickBlock = conBlock;
}

- (void)show
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];
    
    UIView *backgroundView = (UIView *)[self viewWithTag:200];
    [UIView animateWithDuration:0.35 animations:^{
        self.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        backgroundView.transform = CGAffineTransformMakeScale(1, 1);
        backgroundView.alpha = 1;
    } completion:^(BOOL finish) {
        
    }];
    
}
- (void)tapGRClick:(UITapGestureRecognizer *)sender
{
    [self dismissAlert:YES];
}

- (void)canBtnClick:(UIButton *)sender
{
    if (self.cancelClickBlock) {
        self.cancelClickBlock();
    }
    [self dismissAlert:YES];
}

- (void)conBtnClick:(UIButton *)sender
{
    if (self.confirmClickBlock) {
        self.confirmClickBlock();
    }
    [self dismissAlert:YES];
}

- (void)dismissAlert:(BOOL)animation
{
    UIView *backgroundView = (UIView *)[self viewWithTag:200];
    if (animation) {
        [UIView animateWithDuration:0.35 animations:^{
            self.alpha = 0;
            backgroundView.transform = CGAffineTransformMakeScale(0.25, 0.25);
            backgroundView.alpha = 0;
        } completion:^(BOOL finish) {
            [backgroundView removeFromSuperview];
            [self removeFromSuperview];
        }];
    } else {
        [backgroundView removeFromSuperview];
        [self removeFromSuperview];
    }
}


@end
