//
//  InvitCodeViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/10/16.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "InvitCodeViewController.h"
#import "ExchangeInvitViewController.h"
#import "ExchangeCodeViewController.h"
#import "GlobalTool.h"


#import "GlobalTool.h"

#import "AFNetworking.h"
#import "MyMD5.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "ShopDetailModel.h"
#import "UIImageView+WebCache.h"
#import "UIViewController+KNSemiModal.h"
#import "NavgationbarView.h"
#import "AffirmOrderViewController.h"
#import "NavgationbarView.h"
#import "ShopDetailViewController.h"
#import "LoginViewController.h"
#import "MJRefresh.h"
#import "ShareShopModel.h"
#import "OrderTableViewController.h"
#import "AppDelegate.h"
#import "DShareManager.h"
#import "MyTabBarController.h"
#import "ProduceImage.h"

#define USER_H5ShareApp @"share/900_900_2_IOS.png"
#define USER_H5ShareApp2 @"share/900_900_3_IOS.png"
@interface InvitCodeViewController () <DShareManagerDelegate>
{
    //分享按钮
    UIButton *_sharebtn;
    
    //分享的模态视图
    UIView *_shareModelview;
    
    ShareShopModel *_shareModel;
    
    //商品链接
    NSString *_shareShopurl;
    
    //记录用户是否兑换过邀请码
    NSString *_userCode;

}

@property (nonatomic, strong)UIImage *shareAppImg;
@property (nonatomic, strong)UIImage *shareAppImg2;
@end

@implementation InvitCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"邀请码";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    
    [self creatView];

}

- (void)httpGetShareImage2
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    NSString *url=[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy], USER_H5ShareApp2];
    //url = %@", url);
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSData *imgData = UIImagePNGRepresentation(responseObject);
            self.shareAppImg2 = [UIImage imageWithData:imgData];
        }
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[Animation shareAnimation] stopAnimationAt:self.view];
    }];
    
}

- (void)httpGetShareImage
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    NSString *url=[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy], USER_H5ShareApp];
    //url = %@", url);
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSData *imgData = UIImagePNGRepresentation(responseObject);
            self.shareAppImg = [UIImage imageWithData:imgData];
        }

        [[Animation shareAnimation] stopAnimationAt:self.view];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[Animation shareAnimation] stopAnimationAt:self.view];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    //获取商品链接
    [self shopRequest];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self httpGetShareImage];
    
    [self httpGetShareImage2];
    
}
- (void)creatView
{
    self.invitTitle.font = [UIFont systemFontOfSize:ZOOM(48)];
    UIImageView *invitimage =[[UIImageView alloc]initWithFrame:CGRectMake((kApplicationWidth-250)/2, 10, IMAGEW(@"图层-147"), IMAGEH(@"图层-147"))];
    invitimage.image = [UIImage imageNamed:@"图层-147"];
    
    CGFloat invitlableY =CGRectGetMaxX(invitimage.frame);
    
    UILabel *invitlable = [[UILabel alloc]initWithFrame:CGRectMake(invitlableY+ZOOM(30), 10, 100, 20)];
    invitlable.text =@"邀请码兑换";
    
    [self.exchangeView addSubview:invitimage];
    [self.exchangeView addSubview:invitlable];

    CGFloat spaceHeight;
    if (ThreeAndFiveInch) {
        spaceHeight=ZOOM(50);
    }else{
        spaceHeight=ZOOM(100);
    }
    UILabel *shareLable = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_exchangeView.frame)+spaceHeight , kApplicationWidth, 100)];
    shareLable.font = fiftySize;
    shareLable.textColor=tarbarrossred;
    shareLable.numberOfLines=2;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:10];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"分享自己的邀请码给朋友\n能赢取100元大礼包哦~"]];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:@"100"].location,[[noteStr string] rangeOfString:@"100"].length);
    [noteStr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(80)]} range:redRange];
    [shareLable setAttributedText:noteStr] ;
    CGRect rect = [noteStr boundingRectWithSize:CGSizeMake(kScreenWidth-2*ZOOM(60), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin  context:nil];

    shareLable.frame = CGRectMake(0,CGRectGetMaxY(_exchangeView.frame)+ZOOM(50) , kApplicationWidth, rect.size.height*2);
    shareLable.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:shareLable];
    
    UIImageView *shareImgBtn = [[UIImageView alloc]initWithFrame:CGRectMake(70,CGRectGetMaxY(shareLable.frame) , kApplicationWidth-60*2,ZOOM(400))];
//    shareImgBtn.backgroundColor=DRandomColor;
    shareImgBtn.image = [UIImage imageNamed:@"点我分享"];
    shareImgBtn.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:shareImgBtn];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame=shareImgBtn.frame;
    [shareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    
    self.invitCode.textColor = tarbarrossred;
    self.invitCode.font = [UIFont systemFontOfSize:ZOOM(48)];
    
    
    self.exchangeView.layer.borderWidth = 1;
    self.exchangeView.layer.borderColor = tarbarrossred.CGColor;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(invit:)];
    [self.exchangeView addGestureRecognizer:tap];
    self.exchangeView.userInteractionEnabled = YES;
    
    
//    CGFloat sharelableY =CGRectGetMaxX(self.exchangeView.frame);
    
//    UILabel *sharelable = [[UILabel alloc]initWithFrame:CGRectMake((kApplicationWidth-200)/2    , sharelableY+ZOOM(100), 200, 60)];
//    invitlable.text =@"分享自己的邀请码给朋友\n能赢取100元大礼包哦~";
//    sharelable.
}


#pragma mark 获取邀请码请求
- (void)shopRequest
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];

    NSString *token = [user objectForKey:USER_TOKEN];
    
    NSString *url=[NSString stringWithFormat:@"%@inviteCode/getInviteCode?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    
    NSString *URL=[MyMD5 authkey:url];
    
    [[Animation shareAnimation] createAnimationAt:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            
            if(str.intValue==1)
            {
                
                self.invitCode.text = responseObject[@"inviteCode"];
                
                _userCode = [NSString stringWithFormat:@"%@",responseObject[@"useCode"]];
                
                
                _shareModel=[ShareShopModel alloc];
                _shareModel.shopUrl=responseObject[@"link"];
                
                _shareShopurl=responseObject[@"link"];
                
                NSDictionary * dic =responseObject[@"shop"];
                
                NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
                
                [userdefaul setObject:[NSString stringWithFormat:@"%@",responseObject[@"content"]] forKey:SHOP_TITLE];
                
                [userdefaul setObject:[NSString stringWithFormat:@"%@",_shareShopurl] forKey:SHOP_LINK];
                
                if( !_shareShopurl)
                {
                    return;
                }
                
            }
            else if(str.intValue == 10030){//没登录状态
                
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud removeObjectForKey:USER_TOKEN];
                
                LoginViewController *login=[[LoginViewController alloc]init];
                
                login.tag=1000;
                login.loginStatue = @"10030";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
                
            }

            else if(str.intValue==1050)
            {
                NavgationbarView *mentionview =[[NavgationbarView alloc]init];
                [mentionview showLable:@"亲,你今天的分享次数已用完" Controller:self];
                
                
                if(_shareModelview)
                {
                    
                    UIView *backview = (UIView*)[self.view viewWithTag:9797];
                    [backview removeFromSuperview];
                    
                    
                    [UIView animateWithDuration:0.3 animations:^{
                        
                        _shareModelview.frame=CGRectMake(0, kApplicationHeight+30, kApplicationWidth, ZOOM(680));
                        
                    } completion:^(BOOL finished) {
                        
                        _sharebtn.selected=NO;
                        
                        [_shareModelview removeFromSuperview];
                    }];
                    
                }
                
            }
            
            else{
                
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:@"网络异常，请稍后重试" Controller:self];
            }
        }
        
        
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [[Animation shareAnimation] stopAnimationAt:self.view];
    }];
}

#pragma mark 邀请码分享统计
- (void)StatisticsRequest
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    
    NSString *token = [user objectForKey:USER_TOKEN];
    
    NSString *url=[NSString stringWithFormat:@"%@inviteCode/addDepositCount?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [[Animation shareAnimation] createAnimationAt:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            
            if(str.intValue==1)
            {
                //统计成功
            }
            else{
                
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:@"网络异常，请稍后重试" Controller:self];
            }
        }
        
        
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [[Animation shareAnimation] stopAnimationAt:self.view];
    }];
}

#pragma mark 分享
-(void)share:(UIButton *)sender
{
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    if ([self.invitCode.text length]>0) {
        AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [app shardk];
        
        DShareManager *ds = [DShareManager share];
        ds.delegate = self;
        UIImage *myImg;
        ProduceImage *pi = [[ProduceImage alloc] init];
        if (self.invitCode.text.length == 4) {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
                if (self.shareAppImg == nil) {
                    [self httpGetShareImage];
                } else {
                    
                    MyLog(@"self.shareAppImg = %@",self.shareAppImg);
                    
                    myImg = [pi getH5Image:self.shareAppImg withQRCodeImage:nil withText:self.invitCode.text];
                }
                [ds shareAppWithType:ShareTypeWeixiTimeline withImageShareType:@"InvitCode" withImage:myImg];
            } else {
                [nv showLable:@"请安装微信,再分享" Controller:self];
            }
        } else if (self.invitCode.text.length == 5) {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
                if (self.shareAppImg2 == nil) {
                    [self httpGetShareImage2];
                    
                } else {
                    myImg = [pi getH5Image:self.shareAppImg2 withQRCodeImage:nil withText:self.invitCode.text];
                }
                [ds shareAppWithType:ShareTypeWeixiTimeline withImageShareType:@"InvitCode" withImage:myImg];
            } else {
                [nv showLable:@"请安装微信,再分享" Controller:self];
            }
        }
    } else {
        [self shopRequest];
    }

}

#if 0
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [_sharebtn becomeFirstResponder];
    
    
    if(_shareModelview)
    {
        
        UIView *backview = (UIView*)[self.view viewWithTag:9797];
        [backview removeFromSuperview];
        
        
        [UIView animateWithDuration:0.3 animations:^{
            
            _shareModelview.frame=CGRectMake(0, kApplicationHeight+30, kApplicationWidth, ZOOM(680));
            
        } completion:^(BOOL finished) {
            
            _sharebtn.selected=NO;
            
            [_shareModelview removeFromSuperview];
        }];
        
    }
    
    MyLog(@"fjsfj");
}
#endif

#pragma mark 分享视图
- (void)creatShareModelView
{
    _shareModelview = [[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight+30, kApplicationWidth, ZOOM(680))];
    _shareModelview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_shareModelview];
    [_shareModelview bringSubviewToFront:self.view];
    
    UILabel *titlelable = [[UILabel alloc]initWithFrame:CGRectMake(10, ZOOM(40), kApplicationWidth-20, 30)];
    titlelable.text = @"美是用来分享哒~分享最爱的美衣给好友";
    titlelable.textAlignment = NSTextAlignmentCenter;
    titlelable.font = [UIFont systemFontOfSize:ZOOM(51)];
    titlelable.textColor = kTitleColor;
//    [_shareModelview addSubview:titlelable];
    
    CGFloat titlelable1Y = CGRectGetMaxY(titlelable.frame);
    
    UILabel *titlelable1 = [[UILabel alloc]initWithFrame:CGRectMake(10, titlelable1Y+ZOOM(30), kApplicationWidth-20, 40)];
    titlelable1.text = @"可提现的35元现金红包在等着您";
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(51)]};
    CGSize textSize = [titlelable1.text boundingRectWithSize:CGSizeMake(1000, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    
    CGSize cSize = [[UIScreen mainScreen] bounds].size;
    
    titlelable1.frame=CGRectMake((cSize.width-textSize.width-20)/2, titlelable1Y+ZOOM(20), textSize.width+20, 30);
    
    titlelable1.textAlignment = NSTextAlignmentCenter;
    titlelable1.font = [UIFont systemFontOfSize:ZOOM(51)];
    titlelable1.textColor = [UIColor whiteColor];
    titlelable1.backgroundColor=tarbarrossred;
    titlelable1.clipsToBounds=YES;
    titlelable1.layer.cornerRadius=titlelable1.frame.size.height/2;
    
//    [_shareModelview addSubview:titlelable1];
    
    
    CGFloat lablelineY =CGRectGetMaxY(titlelable1.frame);
    
    UILabel *lableline = [[UILabel alloc]initWithFrame:CGRectMake(0, lablelineY+ZOOM(50), kApplicationWidth, 1)];
    lableline.backgroundColor = kBackgroundColor;
    
//    [_shareModelview addSubview:lableline];
    
    
    //分享平台
    for (int i=0; i<3; i++) {
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        shareBtn.frame = CGRectMake(100*i+(kApplicationWidth-260)/2,CGRectGetMaxY(lableline.frame)-30, 60, 60);
        shareBtn.tag = 9000+i;
        [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            
           
            //判断设备是否安装QQ
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]])
            {
                //判断是否有qq
                
                
                [shareBtn setBackgroundImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
                
            }else{
                
                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
                
            }
            

            
        }else if (i==1){
            [shareBtn setBackgroundImage:[UIImage imageNamed:@"微博"] forState:UIControlStateNormal];
            
            
        }else{
                //判断设备是否安装微信
                
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
                    //判断是否有微信

                    [shareBtn setBackgroundImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
                }else {
                    
                    shareBtn.userInteractionEnabled=NO;
                    shareBtn.hidden=YES;
                }

        }
        [_shareModelview addSubview:shareBtn];
        
    }

}

#pragma mark 选择分享的平台
-(void)shareClick:(UIButton*)sender
{
    //配置分享平台信息
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app shardk];
    
    if(sender.tag==9000)//QQ
    {
        [[DShareManager share] shareAppWithType:ShareTypeQQSpace View:nil Image:nil Title:nil WithShareType:@"detail"];
    }else if (sender.tag==9001)//微博
    {
        [[DShareManager share] shareAppWithType:ShareTypeSinaWeibo View:nil Image:nil Title:nil WithShareType:@"detail"];
    }else if (sender.tag==9002)//微信
    {
        [[DShareManager share] shareAppWithType:ShareTypeWeixiTimeline View:nil Image:nil Title:nil WithShareType:@"detail"];
    }
    
    if(_shareModelview)
    {
        
        UIView *backview = (UIView*)[self.view viewWithTag:9797];
        [backview removeFromSuperview];
        
        
        [UIView animateWithDuration:0.3 animations:^{
            
            _shareModelview.frame=CGRectMake(0, kApplicationHeight+30, kApplicationWidth, ZOOM(680));
            
        } completion:^(BOOL finished) {
            
            _sharebtn.selected=NO;
            
            [_shareModelview removeFromSuperview];
        }];
        
    }
    
    
}

#pragma mark 分享回调
- (void)DShareManagerStatus:(SHARESTATE)shareStatus withType:(NSString *)type
{
    NavgationbarView *nv =[[NavgationbarView alloc] init];
    
    if ([type isEqualToString:@"InvitCode"]) {
        if (shareStatus == 1) {
            [nv showLable:@"分享成功" Controller:self];
            
            //统计
            [self StatisticsRequest];
            
        } else if (shareStatus == 2) {
            [nv showLable:@"分享失败" Controller:self];
        } else if (shareStatus == 3) {
//            [nv showLable:@"分享取消" Controller:self];
        }
    }
}

#pragma mark 兑换邀请码
-(void)invit:(UITapGestureRecognizer*)tap
{
    if(_userCode.intValue == 1)//没有兑换过
    {
        ExchangeCodeViewController *exchange =[[ExchangeCodeViewController alloc]init];
        [self.navigationController pushViewController:exchange animated:YES];
    }else{
        NavgationbarView *mentionview = [[NavgationbarView alloc]init];
        [mentionview showLable:@"亲,你已兑换过不能再兑换" Controller:self];
    }
}


-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
