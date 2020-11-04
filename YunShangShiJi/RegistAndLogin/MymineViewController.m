//
//  MymineViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/9.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "MymineViewController.h"
#import "MyTabBarController.h"
#import "GlobalTool.h"
#import "NavgationbarView.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "NavgationbarView.h"
#import "MyInformationViewController.h"
#import "MyOrderViewController.h"
#import "PersonCenterCell.h"
#import "DianPumeiyiViewController.h"
#import "SettingViewController.h"
#import "MessageViewController.h"
#import "HelppingCenterViewController.h"
#import "MywalletViewController.h"
#import "MyintegralViewController.h"
#import "MyjifenViewController.h"
#import "AftersaleViewController.h"
#import "AFNetworking.h"
#import "UserInfo.h"
#import "MyMD5.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "TFSettingViewController.h"
#import "IntelligenceViewController.h"
#import "RerundViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
//#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <QZoneConnection/ISSQZoneApp.h>
#import "TFMyWalletViewController.h"
#import "TFMyIntegralViewController.h"
#import "TFHelpCenterViewController.h"
#import "TFMyInformationViewController.h"
//#import "ChatListViewController.h"
#import "IntelligenceViewController.h"
#import "TFMyShopViewController.h"
#import "popViewController.h"
#import "PayFailedViewController.h"
#import "OneLuckdrawViewController.h"
#import "MemberRawardsViewController.h"
#import "DistributionRegistViewController.h"
#import "DBCenterViewController.h"
#import "TFVoiceRedViewController.h"
//#import "ComboShopDetailViewController.h"
#import "TFShoppingViewController.h"

#import "TFPayStyleViewController.h"
#import "SelectShareTypeViewController.h"
#import "NewSigninViewController.h"
#import "TFMakeMoneySecretViewController.h"
#import "ZeroShopShareViewController.h"
#import "BusinessCommentViewController.h"
#import "TFLedBrowseShopViewController.h"
#import "TFMemberCheckViewController.h"
#import "TFMemberShopStoreViewController.h"
#import "TFMemberSuccessViewController.h"
#import "HTTPTarbarNum.h"
#import <RongIMKit/RongIMKit.h>
#import "CollocationDetailViewController.h"
#import "TFIndianaRecordViewController.h"
#import "TFCashSuccessViewController.h"
#import "ShareToFriendsView.h"
#import "TFMyCardViewController.h"
#import "DelRedDotModel.h"
#import "YFUserModel.h"
#import "OneYuanModel.h"
#import "InvitFriendFreeLingView.h"
#import "InviteFriendsVC.h"
#import "ActivityShopOrderVC.h"
#import "MyVipVC.h"
#import "VitalityModel.h"
#import "FXBlurView.h"
#import "CFCollectionButtonView.h"
#import "PersonPhotosVC.h"
#import "GroupBuyPopView.h"
#import "TFPublishThemeVC.h"
#import "TFPublishDress.h"
#import "MessageCenterVC.h"
#import "TFSubIntimateCircleVC.h"
#import "CFFriendsViewController.h"
#import "TFIndianaRecordViewController.h"
#import "FriendsRawardsViewController.h"
#import "VitalityTaskPopview.h"
#import "TFMyWalletViewController.h"
#import "HBmemberViewController.h"
#import "AddMemberCardViewController.h"
#import "InviteFriendFreelingViewController.h"
#import "ContactKefuViewController.h"
#import "ShareFreelingPopViewController.h"
#import "ShouYeShopStoreViewController.h"
#define BackGroupHeight 200*kScreenWidth/320
@interface MymineViewController ()<CFCollectionButtonViewDelegate>

/**
 * 会员头像
 */
@property (nonatomic, strong) UIButton *memberImageView;
@property (nonatomic, strong) UILabel *messagecount; //提示消息数量

@property (nonatomic, assign) BOOL isBalanceShow;
@property (nonatomic, assign) CGFloat balance;
@property (nonatomic, assign) BOOL isCouponShow;
@property (nonatomic, assign) CGFloat couponSum;
@property (nonatomic, assign) NSInteger integral;
@property (nonatomic, assign) CGFloat inviteImageHeigh;

@property (nonatomic, strong) CFCollectionButtonView *collectionButtonView;

@end

@implementation MymineViewController
{
    UIImageView *imageBG;
    UIView *BGView;
    UIButton *moneyBtn;
    UIButton *couponBtn;
    UILabel *titlelable;
    //数据源
    NSMutableArray *_dataArray;

//    UIImageView *_backgroundImageView;
    
    //图像
    UIImageView *_headImage;
    UIImageView *userVipIco;
    UIView *_pubview;
    
    UITableView *_Mytableview;
    
    //超级合伙人状态
    NSString *_statu;
    
    UIView *_messageView;
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (self.netStatusBlock) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:netStatusNotificationCenter object:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isCouponShow = YES;
    _isBalanceShow = YES;
    _dataArray=[NSMutableArray array];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.hidden=YES;
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    UIImage *invitimage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/qingfengpic/InviteFriends_img2.jpg"]]]];
    self.inviteImageHeigh = invitimage.size.height*kScreen_Width/invitimage.size.width;
    self.inviteImageHeigh = 0;
    
    [self creaData];

    //主界面
    [self creaView];
    
    [self navagationView];
    
    //监听通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeHeadimg:) name:@"imagenote" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNickName:) name:@"changeNickName" object:nil];

    // 融云收到消息通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMessageNotification:) name:RCKitDispatchMessageNotification object:nil];

    ESWeak(self, ws);
    [self netStatusBlock:^(NetworkStates networkState) {
        if (networkState != NetworkStatesNone) {
            
            [ws requestHttp];
            
        } else {
            
        }
    }];

}
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [MobClick beginLogPageView:@"WodePage"];

    //mymineviewcontroller");
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    [super viewWillAppear:animated];
    Myview.hidden=NO;
    self.navigationController.navigationBar.hidden=YES;
    
//    //获得所有DB中未读消息数量
//    NSInteger readMessageCount = IsRongCloub ? (NSInteger)[RCIMClient sharedRCIMClient].getTotalUnreadCount : [[EaseMob sharedInstance].chatManager loadTotalUnreadMessagesCountFromDatabase];
//     _messagecount.text=[NSString stringWithFormat:@"%@",@(readMessageCount)];
//
//    self.collectionButtonView.messageCount=readMessageCount+[[NSUserDefaults standardUserDefaults]integerForKey:@"TOPICMESSAGE"];
//
//    if(readMessageCount > 0) {
//        _messagecount.hidden = NO;
//    }else{
//        _messagecount.hidden = YES;
//    }

}

-(void)httpRedCount
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSString *url=[NSString stringWithFormat:@"%@user/finCount?version=%@&token=%@",[NSObject baseURLStr],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]];
    NSString *URL=[MyMD5 authkey:url];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        MyLog(@"responseObject: %@", responseObject);
        
        [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"finCount"] forKey:@"finCount"];
        NSString *H5count = [NSString stringWithFormat:@"%@",responseObject[@"H5Count"]];
        
        int count=0;
        if ([responseObject[@"finCount"]integerValue]==0) {
            [Mtarbar hideBadgeOnItemIndex:4];
            //            [Mtarbar changeBadgeNumOnItemIndex:4 withNum:responseObject[@"finCount"]];
        }
        if ([responseObject[@"finCount"]integerValue]>0) {
            
            /***************  我的任务  红点  ****************/
//            PersonCenterCell *cell = [_Mytableview viewWithTag:8989];
//            cell.detailLabel.hidden = NO;
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"%@fourIndex",[[NSUserDefaults standardUserDefaults]objectForKey:USER_ID]]]isEqualToString:[MyMD5 getCurrTimeString:@"year-month-day"]]) {
                [Mtarbar hideBadgeOnItemIndex:4];
            }else
                [Mtarbar showBadgeOnItemIndex:4];
//            [Mtarbar changeBadgeNumOnItemIndex:4 withNum:responseObject[@"finCount"]];
        } else {
//            PersonCenterCell *cell = [_Mytableview viewWithTag:8989];
//            cell.detailLabel.hidden = YES;
            
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
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];

}
-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    
    [MobClick endLogPageView:@"WodePage"];
    
    [self reloadInfomation];
    [self requestHttp];

    [self httpRedCount];
    
    [self httpGetUserInfo];
    
//    if ([DataManager sharedManager].grade==1&&![_dataArray containsObject:@"我的会员"]) {
//        [_dataArray insertObject:@"我的会员" atIndex:_dataArray.count-1];
//        [_Mytableview reloadData];
//    }
    /*
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *member = [ud objectForKey:USER_MEMBER];
    if (member!=nil) {
        if ([member intValue] == 2||[member intValue] == 3||[member intValue] == 4) {
            UIImage *memImg = [UIImage imageNamed:@"premium-services"];
            self.memberImageView.image = memImg;
        } else {
            self.memberImageView.image = nil;
        }
    } else {
        self.memberImageView.image = nil;
    }
    */

    //拼团失败退款提示框
    kWeakSelf(self);
    [OneYuanModel GetOneYuanCountSuccess:^(id data) {
        OneYuanModel *oneModel = data;
        if(oneModel.status == 1 && oneModel.isFail == 1)
        {
            [DataManager sharedManager].OneYuan_count = oneModel.order_price;

            [weakself setVitalityPopMindView:Detail_OneYuanDeductible];
        }
    }];
    
    //拼单成功弹框 只弹两次
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *popcount = [user objectForKey:@"groupPopcount"];
    if(popcount.integerValue <2)
    {
        [self getFightOrderStataus];
    }
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

//    for(UIView *vv in self.view.subviews)
//    {
//        [vv removeFromSuperview];
//    }
    

}
#pragma mark 个人中心数据统计
-(void)requestHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString*token=[user objectForKey:USER_TOKEN];
    
    NSString *url=[NSString stringWithFormat:@"%@user/count?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    NSString *URL=[MyMD5 authkey:url];
    
//    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        //responseObject is %@",responseObject);
        MyLog(@"responseObject: %@", responseObject);
//        responseObject = [NSDictionary changeType:responseObject];
        MyLog(@"change responseObject: %@", responseObject);
        
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            
            
            if(str.intValue==1)
            {
                self.ass_count=[NSString stringWithFormat:@"%@",responseObject[@"ass_count"]];
                self.furl_count=[NSString stringWithFormat:@"%@",responseObject[@"furl_count"]];
                self.like_count=[NSString stringWithFormat:@"%@",responseObject[@"like_count"]];
                self.pay_count=[NSString stringWithFormat:@"%@",responseObject[@"pay_count"]];
               
                self.isBalanceShow = [responseObject[@"balance_show"] integerValue] == 1;
                self.balance = [responseObject[@"balance"] floatValue];
                
                self.isCouponShow = [responseObject[@"coupon_show"] integerValue] == 1;
                self.couponSum = [responseObject[@"coupon_sum"] floatValue];
//                MyLog(@"self.pay_count is %@",responseObject[@"pay_count"]);
                
                self.refund_count=[NSString stringWithFormat:@"%@",responseObject[@"change_count"]];
                self.send_count=[NSString stringWithFormat:@"%@",responseObject[@"send_count"]];
                if ([[NSString stringWithFormat:@"%@",responseObject[@"store_shop_count"]]isEqualToString:@"<null>"]) {
                    self.store_shop_count=@"0";
                }else
                    self.store_shop_count=[NSString stringWithFormat:@"%@",responseObject[@"store_shop_count"]];
                if ([[NSString stringWithFormat:@"%@",responseObject[@"mySteps_count"]]isEqualToString:@"<null>"]) {
                    self.mySteps_count=@"0";
                }else
                    self.mySteps_count=[NSString stringWithFormat:@"%@",responseObject[@"mySteps_count"]];
                self.finCount = [NSString stringWithFormat:@"%@",responseObject[@"finCount"]];
                
                self.integral = [responseObject[@"integral"] integerValue];
                if(![responseObject[@"home_info"]isEqual:[NSNull null]]){
                    if(responseObject[@"home_info"][@"fans_count"]!=nil)
                        self.fans_count=[NSString stringWithFormat:@"%@",responseObject[@"home_info"][@"fans_count"]];
                    if (responseObject[@"home_info"][@"circle_count"]!=nil)
                        self.circle_count=[NSString stringWithFormat:@"%@",responseObject[@"home_info"][@"circle_count"]];
                    
                    
                    
                    NSString *stateID=responseObject[@"home_info"][@"province"];
                    NSString *cityID=responseObject[@"home_info"][@"city"];
                    if (![stateID isEqual:[NSNull null]] && ![cityID isEqual:[NSNull null]]) {
                        
                    }else
                        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@""] forKey:USER_ARRER];
                }
                
                if(![responseObject[@"vipData"]isEqual:[NSNull null]] && responseObject[@"vipData"]!=nil){
                    self.vip_url = [NSString stringWithFormat:@"%@",responseObject[@"vipData"][@"head_url"]];
                    self.vip_name = [NSString stringWithFormat:@"%@",responseObject[@"vipData"][@"vip_name"]];
                    self.vip_type = [NSString stringWithFormat:@"%@",responseObject[@"vipData"][@"vip_type"]];
                }
                
                if(responseObject[@"fans_count"]!=nil&&![responseObject[@"fans_count"]isEqual:[NSNull null]])
                    self.fans_count=[NSString stringWithFormat:@"%@",responseObject[@"fans_count"]];
                
                [self creatmarklable];
                
            }
            else if(str.intValue == 10030){//没登录状态
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_TOKEN];
                [self loginWithPro:@"10030" Success:nil];
            }
            
            else{
                
                
            }
            
        }
        
        

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        
        
    }];
    

}
- (void)httpGetUserInfo {
    [YFUserModel getUserInfoWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:USER_ID] success:^(id data) {
        YFUserModel *model=data;
        if (model.status==1) {
            if (![model.userinfo.v_ident isEqual:[NSNull null]]) {
                [[NSUserDefaults standardUserDefaults]setInteger:[model.userinfo.v_ident integerValue] forKey:USER_V_IDENT];
                NSInteger v_ident = [[NSUserDefaults standardUserDefaults] integerForKey:USER_V_IDENT];
                userVipIco.image = v_ident==1?[UIImage imageNamed:@"V_red_个人中心"]:[UIImage imageNamed:@"V_blue_个人中心"];
                userVipIco.hidden=v_ident==0;
            }else
                [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:USER_V_IDENT];
            if (![model.userinfo.province isEqual:[NSNull null]] && ![model.userinfo.city isEqual:[NSNull null]]) {
                NSArray *array=[self getAddressStateID:model.userinfo.province withCityID:model.userinfo.city witAreaID:nil withStreetID:nil];
                if(array.count >= 2) {
                    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@%@",array[0],array[1]] forKey:USER_ARRER];
                }
            }else
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@""] forKey:USER_ARRER];
        }
    }];
}

#pragma mark 获取用户是否有疯抢过的订单
- (void)getFightOrderStataus
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString*token=[user objectForKey:USER_TOKEN];
    
    NSString *url=[NSString stringWithFormat:@"%@order/getOrderStatus?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        MyLog(@"change responseObject: %@", responseObject);

        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            NSString *rollCount = [NSString stringWithFormat:@"%@",responseObject[@"rollCount"]];
            if(str.intValue==1 && rollCount.intValue == 1)
            {
                kWeakSelf(self);
                [OneYuanModel GetCouponDataSuccess:^(id data) {
                    OneYuanModel *model = data;
                    if(model.status == 1)
                    {
                        CGFloat coupon = model.price > 0 ? model.price:6;
                        [weakself popView:GroupBuySuccess coupon:coupon];
                    }
                }];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        
        
    }];
    
}
-(void)navagationView
{
    
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];

    headview.tag=3838;
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    [headview bringSubviewToFront:self.view];
    
//    UIButton *message=[UIButton buttonWithType:UIButtonTypeCustom];
//    message.frame=CGRectMake(10, 20, 40, 40);
//    [message setImage:[UIImage imageNamed:@"发消息"] forState:UIControlStateNormal];
//    message.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [message addTarget:self action:@selector(message:) forControlEvents:UIControlEventTouchUpInside];
//    [headview addSubview:message];
    
    /*
    _messageView = [[UIView alloc] initWithFrame:CGRectMake(15, 20, 60, 40)];
   
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 12, 25, 25)];
    UIImage *image = [UIImage imageNamed:@"icon_xiaoxi"];
    
//    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    imageView.image = image;
    imageView.tintColor = [UIColor whiteColor];
    [_messageView addSubview:imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(message:)];
    _messageView.userInteractionEnabled = YES;
    [_messageView addGestureRecognizer:tap];

    [headview addSubview:_messageView];
    
    //获得所有DB中未读消息数量
    NSInteger readMessageCount = IsRongCloub ? [RCIMClient sharedRCIMClient].getTotalUnreadCount : [[EaseMob sharedInstance].chatManager loadTotalUnreadMessagesCountFromDatabase];
    
    _messagecount=[[UILabel alloc]initWithFrame:CGRectMake(20, 12, 18, 18)];
    _messagecount.text=[NSString stringWithFormat:@"%ld",readMessageCount];
    _messagecount.font=[UIFont systemFontOfSize:10];
    _messagecount.textColor=tarbarrossred;
    _messagecount.backgroundColor=[UIColor whiteColor];
    _messagecount.clipsToBounds=YES;
    _messagecount.layer.cornerRadius=9;
    _messagecount.textAlignment=NSTextAlignmentCenter;
    [_messageView addSubview:_messagecount];
     
    if(readMessageCount > 0) {
        _messagecount.hidden = NO;
    }else{
        _messagecount.hidden = YES;
    }
     
     */

    CGFloat navbarHeigh = Height_NavBar;
    UIButton *leftBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame=CGRectMake(0, navbarHeigh-54, 100, 44);
    leftBtn.centerY = headview.frame.size.height/2+10;
    [leftBtn setTitle:@"个人资料" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:leftBtn];
    
    titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 100, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"个人中心";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=[UIColor whiteColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    UIButton *setting=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    setting.frame=CGRectMake(kApplicationWidth-60, navbarHeigh-54, 60, 50);
    setting.centerY = headview.frame.size.height/2+10;
    [setting setImage:[UIImage imageNamed:@"icon_shezhi"] forState:UIControlStateNormal];

    setting.titleLabel.font = [UIFont systemFontOfSize:ZOOM(50)];

    setting.tintColor=[UIColor whiteColor];
    [setting addTarget:self action:@selector(setting:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:setting];
    
//    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(headview.mas_centerY).offset(10);
//    }];
    
}


-(void)changeNickName:(NSNotification*)note
{
    //读取已经保存的图像
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *name = [ud objectForKey:USER_NAME];
    
    NSString *setName = [NSString stringWithFormat:@"%@",name];
    
    UILabel *label = (UILabel *)[BGView viewWithTag:10086];
    
    
    CGSize sizeStr = [setName boundingRectWithSize:CGSizeMake(kScreenWidth, label.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(50)]} context:nil].size;
    
    label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, sizeStr.width, label.frame.size.height);
    
    label.text = setName;
    
    self.memberImageView.frame = CGRectMake(CGRectGetMaxX(label.frame)+5, self.memberImageView.frame.origin.y, self.memberImageView.frame.size.width, self.memberImageView.frame.size.height);

}


#pragma mark 数据源
-(void)creaData
{
    NSArray *dataArr;
//     dataArr = @[@"我的订单",@"",@"我的钱包",@"我的卡券",@"邀请好友",@"我的足迹",@""];
    dataArr = @[@"我的订单",@"",@""];

    _dataArray = [NSMutableArray arrayWithArray:dataArr];
//    if ([DataManager sharedManager].grade==1) {
//        [_dataArray insertObject:@"我的会员" atIndex:dataArr.count-1];
//    }
//    [_Mytableview reloadData];
    
}
/**********************  更新个人信息  *******************/
-(void)reloadInfomation{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *User_id = [ud objectForKey:USER_ID];
    NSString *defaultPic = [ud objectForKey:USER_HEADPIC];
    
    NSString *aPath=[NSString stringWithFormat:@"%@/Documents/headImgae%@.png",NSHomeDirectory(),User_id];
    NSData *data = [NSData dataWithContentsOfFile:aPath];
    UIImage *imgFromUrl=[UIImage imageWithData:data];
    
    //defaultPic  %@",defaultPic);
    if (imgFromUrl!=nil) { //判断用户是否登陆
        _headImage.image = imgFromUrl;
        imageBG.image=imgFromUrl;
    } else {
        if ([defaultPic hasPrefix:@"http"]) {
            [_headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",defaultPic]]];
            [imageBG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",defaultPic]]];
        } else{
            [_headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy],defaultPic]]];
            [imageBG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy],defaultPic]]];
        }
        //2.缓存图片到沙盒
        NSString *aPath=[NSString stringWithFormat:@"%@/Documents/headImgae%@.png",NSHomeDirectory(),User_id];
        NSData *imgData = UIImagePNGRepresentation(_headImage.image);
        [imgData writeToFile:aPath atomically:YES];
    }
    NSInteger v_ident = [[NSUserDefaults standardUserDefaults] integerForKey:USER_V_IDENT];
    userVipIco.image = v_ident==1?[UIImage imageNamed:@"V_red_个人中心"]:[UIImage imageNamed:@"V_blue_个人中心"];
    userVipIco.hidden=v_ident==0;
    
    NSString *name = [ud objectForKey:USER_NAME];
     NSString *userName=name.length>8?[name substringToIndex:8]:name;
    NSString *setName = [NSString stringWithFormat:@"%@",userName];
    
    UILabel *label = (UILabel *)[BGView viewWithTag:10086];
    
    CGSize sizeStr = [setName boundingRectWithSize:CGSizeMake(kScreenWidth, label.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(50)]} context:nil].size;

    label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, sizeStr.width, label.frame.size.height);
    
    label.text = setName;
    
//    //获取活力值
//    [VitalityModel getVitality:^(id data) {
//        VitalityModel *model = data;
//        if(model.status == 1) {
//            [DataManager sharedManager].vitality=model.data.integerValue;
//            self.memberImageView.frame = CGRectMake(CGRectGetMaxX(label.frame)+5, self.memberImageView.frame.origin.y, ZOOM6(40), _memberImageView.height);
//            NSArray *vipImgArr=@[@"icon_vip_nor",@"icon_vip_Bronze",@"icon_vip_silver",@"icon_vip_gold"];
//            self.memberImageView.image = [UIImage imageNamed:vipImgArr[[DataManager sharedManager].vipGrade]];
//        }
//    }];
 
    /**
     *  设置皇冠
     
    self.memberImageView.frame = CGRectMake(CGRectGetMaxX(label.frame)+5, self.memberImageView.frame.origin.y, self.memberImageView.frame.size.width, self.memberImageView.frame.size.height);
    NSString *token = [ud objectForKey:USER_TOKEN];
    if (token!=nil) {
        NSString *member = [ud objectForKey:USER_MEMBER];
        if (member!=nil) {
            if ([member intValue] == 2||[member intValue]== 3||[member intValue] == 4) { //0普通用户1已通过验证2会员
                UIImage *memImg = [UIImage imageNamed:@"premium-services"];
                self.memberImageView.image = memImg;
            } else {
                self.memberImageView.image = nil;
            }
        } else {
            self.memberImageView.image = nil;
        }
        
    }
    */
}

#pragma mark - ++++++++++++主界面++++++++++++
-(void)creaView
{
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    NSString *username=[userdefaul objectForKey:USER_NAME];
    
    _Mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-Height_TabBar)];
    _Mytableview.delegate=self;
    _Mytableview.dataSource=self;
//    _Mytableview.tableHeaderView=tableHeadView;
    _Mytableview.separatorColor=RGBCOLOR_I(229, 229, 229);
    _Mytableview.contentInset=UIEdgeInsetsMake(BackGroupHeight+10, 0, 0, 0);
    _Mytableview.tableFooterView=self.collectionButtonView;
    _Mytableview.backgroundColor=RGBCOLOR_I(244,244,244);
    [self.view addSubview:_Mytableview];
    
    
    [_Mytableview registerNib:[UINib nibWithNibName:@"PersonCenterCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [_Mytableview registerNib:[UINib nibWithNibName:@"PersonCenterCell" bundle:nil] forCellReuseIdentifier:@"orderCell"];

    
    imageBG=[[UIImageView alloc]init];
    imageBG.frame=CGRectMake(0, -BackGroupHeight-10, kScreenWidth, BackGroupHeight);
    imageBG.image=[UIImage imageNamed:@"Icon"];
    
    NSString *aPath=[NSString stringWithFormat:@"%@/Documents/headImgae%@.png",NSHomeDirectory(),[[NSUserDefaults standardUserDefaults] objectForKey:USER_ID]];
    NSData *data = [NSData dataWithContentsOfFile:aPath];
    UIImage *imgFromUrl=[UIImage imageWithData:data];
    if (imgFromUrl!=nil) { //判断用户是否登陆
        imageBG.image = imgFromUrl;
    } else {
        NSString *defaultPic=[[NSUserDefaults standardUserDefaults] objectForKey:USER_HEADPIC];
        if ([defaultPic hasPrefix:@"http"]) {
            [imageBG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",defaultPic]]];
        } else
            [imageBG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy],defaultPic]]];
    }
    imageBG.backgroundColor=RGBA(255, 83, 168, 1);
    
   UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, BackGroupHeight)];
    blurView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    [imageBG addSubview:blurView];
    [_Mytableview addSubview:imageBG];
    [blurView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@(0));
        make.bottom.equalTo(imageBG.mas_bottom);
        make.width.equalTo(imageBG.mas_width);
    }];
    FXBlurView *bview=[[FXBlurView alloc]init];
    bview.tintColor=[UIColor clearColor];
    bview.blurRadius=20.;
    [imageBG addSubview:bview];
    [bview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@(0));
        make.bottom.equalTo(imageBG.mas_bottom);
        make.width.equalTo(imageBG.mas_width);
    }];
    
    BGView=[[UIView alloc]init];
    BGView.backgroundColor=[UIColor clearColor];
    BGView.frame=CGRectMake(0, -BackGroupHeight-10, kScreenWidth, BackGroupHeight);
    [_Mytableview addSubview:BGView];
    
    _headImage=[[UIImageView alloc] initWithFrame:CGRectMake(ZOOM(60), (BackGroupHeight-ZOOM(170))/2, ZOOM(200), ZOOM(200))];
    _headImage.backgroundColor = [UIColor whiteColor];
    _headImage.userInteractionEnabled=YES;
    _headImage.layer.masksToBounds=YES;
    _headImage.layer.cornerRadius = _headImage.frame.size.height/2;
    [BGView addSubview:_headImage];

    UIButton *bbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bbtn.frame = CGRectMake(ZOOM(55), (BackGroupHeight-ZOOM(180))/2, ZOOM(210), ZOOM(210));
    bbtn.layer.cornerRadius=bbtn.frame.size.height/2;
    bbtn.layer.borderWidth=ZOOM(5);
    bbtn.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.25].CGColor;
    [bbtn addTarget:self action:@selector(bbtClick:) forControlEvents:UIControlEventTouchUpInside];
    [BGView addSubview:bbtn];
    
    CGFloat userVipIcoHeight=ZOOM6(40);
    userVipIco=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headImage.frame)-userVipIcoHeight, CGRectGetMaxY(_headImage.frame)-userVipIcoHeight, userVipIcoHeight, userVipIcoHeight)];
    userVipIco.layer.cornerRadius=userVipIco.width/2;
    userVipIco.layer.masksToBounds=YES;
    NSInteger v_ident = [userdefaul integerForKey:USER_V_IDENT];
    userVipIco.image = v_ident==1?[UIImage imageNamed:@"V_red_个人中心"]:[UIImage imageNamed:@"V_blue_个人中心"];
    userVipIco.hidden=v_ident==0;
    [BGView addSubview:userVipIco];
    
    UIButton *arrowBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    arrowBtn.frame=CGRectMake(ZOOM(20),CGRectGetMinY(_headImage.frame), kScreenWidth-ZOOM(20)-10, _headImage.frame.size.height);
    [arrowBtn setImage:[UIImage imageNamed:@"arrowBtn"] forState:UIControlStateNormal];
    [arrowBtn addTarget:self action:@selector(bbtClick:) forControlEvents:UIControlEventTouchUpInside];
    arrowBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [BGView addSubview:arrowBtn];

    
    CGFloat W_attLabel = ZOOM(200);
    CGFloat H_label = ZOOM(60);
     NSString *nameStr;
    if (username) {
        nameStr = [NSString stringWithFormat:@"%@", username];
    } else {
        nameStr = [NSString stringWithFormat:@"%@", @"我的昵称"];
    }
    CGSize sizeStr = [nameStr boundingRectWithSize:CGSizeMake(kScreenWidth, H_label) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(50)]} context:nil].size;
    
    UILabel *UserNamelable=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImage.frame)+ZOOM(60), CGRectGetMidY(_headImage.frame)-H_label-ZOOM(15), sizeStr.width, H_label)];
    UserNamelable.textAlignment=NSTextAlignmentLeft;
    UserNamelable.text = nameStr;
    UserNamelable.textColor=[UIColor whiteColor];
    UserNamelable.font = [UIFont systemFontOfSize:ZOOM(50)];
    UserNamelable.tag = 10086;
     [BGView addSubview:UserNamelable];
    


    UILabel *attentionAndFunsLabel = [[UILabel alloc]initWithFrame:CGRectMake(UserNamelable.frame.origin.x, CGRectGetMidY(_headImage.frame)+ZOOM6(10), W_attLabel, H_label)];
    attentionAndFunsLabel.textAlignment = NSTextAlignmentCenter;
    attentionAndFunsLabel.text=@"成为会员";
    attentionAndFunsLabel.font=[UIFont systemFontOfSize:ZOOM6(25)];
    attentionAndFunsLabel.tag=20;
    attentionAndFunsLabel.textColor=[UIColor whiteColor];
    attentionAndFunsLabel.layer.borderWidth = 1;
    attentionAndFunsLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    attentionAndFunsLabel.layer.cornerRadius = H_label/2;
    [BGView addSubview:attentionAndFunsLabel];
    
    UITapGestureRecognizer *addcardTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addCard:)];
    attentionAndFunsLabel.userInteractionEnabled = YES;
    [attentionAndFunsLabel addGestureRecognizer:addcardTap];
    
    //     *  会员皇冠
    CGFloat H_memIV = ZOOM6(45);
    CGFloat W_memIV = ZOOM6(50);
    UIImage *memImg = [UIImage imageNamed:@""];
    CGSize memSize =  memImg.size;
    
    _memberImageView = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImage.frame)-ZOOM6(50), _headImage.frame.origin.y-ZOOM6(20), W_memIV, H_memIV)];
    _memberImageView.contentMode=UIViewContentModeScaleAspectFit;
    [BGView addSubview:_memberImageView];
    
    moneyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    moneyBtn.titleLabel.textColor=[UIColor whiteColor];
    moneyBtn.titleLabel.lineBreakMode=NSLineBreakByCharWrapping;
    moneyBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    moneyBtn.frame=CGRectMake(0, BackGroupHeight-ZOOM6(150), kScreenWidth/2, ZOOM6(150));
    [moneyBtn setAttributedTitle:[NSString getOneColorInLabel:@"¥0.00\n钱包" ColorString:@"钱包" Color:[UIColor whiteColor] fontSize:14] forState:UIControlStateNormal];
    [moneyBtn handleClickEvent:UIControlEventTouchUpInside withClickBlock:^(UIButton *sender) {
        TFMyWalletViewController *wallet=[[TFMyWalletViewController alloc]init];
        wallet.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:wallet animated:YES];
        if (_isBalanceShow) {
            [DelRedDotModel getDelRegDotWithType:DelRedDotTypeWallet success:nil];
        }
    }];
    [BGView addSubview:moneyBtn];
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, ZOOM6(60))];
    line.center=CGPointMake(kScreenWidth/2, moneyBtn.center.y);
    line.backgroundColor=kTableLineColor;
    [BGView addSubview:line];
    couponBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    couponBtn.titleLabel.textColor=[UIColor whiteColor];
    couponBtn.titleLabel.lineBreakMode=NSLineBreakByCharWrapping;
    couponBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    couponBtn.frame=CGRectMake(kScreenWidth/2, BackGroupHeight-ZOOM6(150), kScreenWidth/2, ZOOM6(150));
    [couponBtn setAttributedTitle:[NSString getOneColorInLabel:@"¥0.00\n卡券" ColorString:@"卡券" Color:[UIColor whiteColor] fontSize:14] forState:UIControlStateNormal];
    [couponBtn handleClickEvent:UIControlEventTouchUpInside withClickBlock:^(UIButton *sender) {
        TFMyCardViewController *tmvc = [[TFMyCardViewController alloc] init];
        tmvc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:tmvc animated:YES];
        if (_isCouponShow) {
            [DelRedDotModel getDelRegDotWithType:DelRedDotTypeCoupon success:nil];
        }
    }];
    [BGView addSubview:couponBtn];
    
     UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,-10, kScreenWidth, 10)];
     bottomView.backgroundColor = RGBCOLOR_I(244,244,244);
     [_Mytableview addSubview:bottomView];
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset  = scrollView.contentOffset.y;
    CGFloat xOffset = (yOffset + BackGroupHeight)/2;
    
    if (yOffset < -BackGroupHeight) {
        
        CGRect rect = imageBG.frame;
        rect.origin.y = yOffset;
        rect.size.height =  -yOffset ;
        rect.origin.x = xOffset;
        rect.size.width = kScreenWidth + fabs(xOffset)*2;
        
        imageBG.frame = rect;
    }

    
    CGFloat alpha = (yOffset+BackGroupHeight)/(BackGroupHeight-ZOOM(250));
    UIView *headview=(UIView*)[self.view viewWithTag:3838];
    headview.backgroundColor=[RGBA(255, 83, 168, 1) colorWithAlphaComponent:alpha];

}
-(void)allOrderBtnClick:(UIButton *)sender
{
    MyOrderViewController *myorder=[[MyOrderViewController alloc]init];
    myorder.tag=999;
    myorder.status1=@"0";
    myorder.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:myorder animated:YES];
}
-(void)creatmarklable
{
    [_Mytableview reloadData];
//    NSArray *marktilte=@[self.like_count,self.mySteps_count,self.store_shop_count];
    NSArray *marklable=@[self.pay_count,self.send_count,self.furl_count,self.ass_count];

    
    if (_circle_count==nil||_fans_count==nil) {
        _circle_count=@"0";_fans_count=@"0";
    }
    UILabel *attentionAndFunsLabel = (UILabel *)[BGView viewWithTag:20];
    if(self.vip_type.integerValue < 0)
    {
        attentionAndFunsLabel.text = @"会员卡失效";
    }else{
        attentionAndFunsLabel.text =self.vip_name&&self.vip_name.length>0?[NSString stringWithFormat:@"%@",self.vip_name]:@"成为会员";
    }
    
    UIImage *markimage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],self.vip_url]]]];
    [_memberImageView setBackgroundImage:markimage forState:UIControlStateNormal];

    [moneyBtn setAttributedTitle:[NSString getOneColorInLabel:[NSString stringWithFormat:@"%.2f\n钱包",self.balance] ColorString:@"钱包" Color:[UIColor whiteColor] fontSize:14] forState:UIControlStateNormal];
    [couponBtn setAttributedTitle:[NSString getOneColorInLabel:[NSString stringWithFormat:@"%.2f\n卡券",self.couponSum] ColorString:@"卡券" Color:[UIColor whiteColor] fontSize:14] forState:UIControlStateNormal];



/*
    for(int i=0;i<marktilte.count;i++)
    {
        UIButton *button=(UIButton*)[BGView viewWithTag:1000+i];
        UILabel *numLabel = (UILabel *)[button viewWithTag:100+i];
        numLabel.text = marktilte[i];
    }
    */

    for(int j=0;j<marklable.count;j++)
    {
        int count=[marklable[j] intValue];
        
//        //count = %d", count);
        
        UILabel *lable=(UILabel*)[self.view viewWithTag:2000+j];
        lable.backgroundColor=tarbarrossred;
        
        if(count>0)
        {
           
            lable.text=marklable[j];
            lable.backgroundColor = COLOR_ROSERED;
           
        } else{
            
//            [lable removeFromSuperview];
            lable.text = @"";
            lable.backgroundColor = [UIColor clearColor];
        }
    }
}
/*
#pragma mark 我的分类
-(void)myclik:(UIButton*)sender
{
    NSUserDefaults *nsuserdefaul=[NSUserDefaults standardUserDefaults];
    NSMutableArray* UserDataArray=[NSMutableArray arrayWithArray:[nsuserdefaul objectForKey:SHOP_INFORMATION]];
    NSString * footprintcount=[NSString stringWithFormat:@"%d",(int)UserDataArray.count];
    
    NSArray *marktilte;
    
    if (self.like_count && self.mySteps_count && self.store_shop_count) {
        marktilte =@[self.like_count,self.mySteps_count,self.store_shop_count];
    }
    
    
    NSString *title;
    NSString *shopcount;
    
    if(sender.tag==1000)
    {
        title=@"我的最爱";
        shopcount=marktilte[0];
        
        DianPumeiyiViewController *dianpu=[[DianPumeiyiViewController alloc]init];
        dianpu.titleString=title;
        dianpu.shopcount=shopcount;
        dianpu.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:dianpu animated:YES];
        
        
    }else if (sender.tag==1001)
    {
        title=@"我的足迹";
        shopcount=marktilte[1];
        
        DianPumeiyiViewController *dianpu=[[DianPumeiyiViewController alloc]init];
        dianpu.titleString=title;
        dianpu.shopcount=shopcount;
        dianpu.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:dianpu animated:YES];

#pragma mark - ******************========  修改  ==========********************   
//        BusinessCommentViewController *view = [[BusinessCommentViewController alloc]init];
//        view.hidesBottomBarWhenPushed=YES;
//        [self.navigationController pushViewController:view  animated:YES];
    
    }else{
      
        title=@"店铺美衣";
        shopcount=marktilte[2];
        
        TFMyShopViewController *tsvc = [[TFMyShopViewController alloc] init];
//        tsvc.isHeadView = YES;
//        tsvc.isFootView = NO;
        tsvc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:tsvc animated:YES];

        
    }
    

    
}
*/
#pragma mark 货物分类
-(void)butclick:(UIButton*)sender
{

    if(sender.tag==1004)
    {
        AftersaleViewController *after=[[AftersaleViewController alloc]init];
        after.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:after animated:YES];
        
    } else{

        MyOrderViewController *myorder=[[MyOrderViewController alloc]init];
        myorder.tag=sender.tag;
        myorder.status1=[NSString stringWithFormat:@"%ld",(sender.tag+1)%1000];
        myorder.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:myorder animated:YES];
    }
}

#pragma mark 跳转登录界面
-(void)loginclick:(UIButton*)sender
{
    LoginViewController *login=[[LoginViewController alloc]init];
    login.tag=1000;
    login.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:login animated:NO];
    
    [_pubview removeFromSuperview];
    [_Mytableview removeFromSuperview];
}

-(void)registclick:(UIButton*)sender
{
    LoginViewController *login=[[LoginViewController alloc]init];
    login.tag=2000;
    login.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:login animated:NO];
    
    [_pubview removeFromSuperview];
    [_Mytableview removeFromSuperview];
}

#pragma mark 退出当前帐号
-(void)exit:(UIButton*)sender
{
    UIButton *btn = [_Mytableview.tableFooterView viewWithTag:8080];
    btn.userInteractionEnabled=NO;
    [self HttpLogout];
//    LoginViewController *login=[[LoginViewController alloc]init];
//    login.tag=1000;
//    [self.navigationController pushViewController:login animated:NO];
    
}
#pragma mark 网络注销登录
-(void)HttpLogout
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paramaters=[NSMutableDictionary dictionary];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
//    NSString *uID=[user objectForKey:USER_ID];
//    NSString *usertype=[user objectForKey:USER_TYPE];
    
    NSString *url;
//    if(!uID)//自己的登录方式
//    {
//        url=[NSString stringWithFormat:@"%@user/logout?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
//    }else{//第三方登录
//        url=[NSString stringWithFormat:@"%@user/userLoginout?version=%@&uid=%@&token=%@&usertype=%d",[NSObject baseURLStr],VERSION,uID,token,usertype.intValue];
//    }
    
    url=[NSString stringWithFormat:@"%@user/loginout?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];

    
    NSString *URL=[MyMD5 authkey:url];
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    [manager POST:URL parameters:paramaters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject!=nil) {
            //responseObject is %@",responseObject[@"message"]);
            NSString *str = responseObject[@"status"];
            if(str.intValue==1)//正常退出
            {
                [user removeObjectForKey:USER_TOKEN];
                [user removeObjectForKey:USER_REALM];
                [user removeObjectForKey:STORE_CODE];
                [user removeObjectForKey:USER_AllCount];
                [user removeObjectForKey:OTHER_PASSWORD];
                [MBProgressHUD showSuccess:@"退出成功"];
//                [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:NO completion:^(NSDictionary *info, EMError *error) {
//                    if (!error) {
//                        //退出成功");
//                    }
//                } onQueue:nil];
                
                [[RCIM sharedRCIM] logout];
                [DataManager sharedManager].isRongCloubLogin = NO;
                [user removeObjectForKey:RongCloub_Token];

                [self performSelector:@selector(login) withObject:nil afterDelay:0.25];
                
            } else{//退出失败
                
                [MBProgressHUD showError:responseObject[@"message"]];
                UIButton *btn = [_Mytableview.tableFooterView viewWithTag:8080];
                btn.userInteractionEnabled=YES;
            }
            
            [MBProgressHUD hideHUDForView:self.view];

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
        UIButton *btn = [_Mytableview.tableFooterView viewWithTag:8080];
        btn.userInteractionEnabled=YES;

    }];


}


- (void)login
{
    UIButton *btn = [_Mytableview.tableFooterView viewWithTag:8080];
    btn.userInteractionEnabled=YES;
    
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *User_id = [ud objectForKey:USER_ID];
    
    [ud removeObjectForKey:USER_TOKEN];
    [ud removeObjectForKey:USER_PHONE];
    [ud removeObjectForKey:USER_PASSWORD];
    [ud removeObjectForKey:USER_NAME];
    [ud removeObjectForKey:USER_EMAIL];
    [ud removeObjectForKey:USER_INFO];
    [ud removeObjectForKey:USER_ID];
    [ud removeObjectForKey:USER_REALM];
    [ud removeObjectForKey:USER_ARRER];
    [ud removeObjectForKey:USER_BIRTHDAY];
    [ud removeObjectForKey:UNION_ID];
    
//    [ud removeObjectForKey:MARK_STORE];
    //删除头像
    NSString *aPath=[NSString stringWithFormat:@"%@/Documents/headImgae%@.png",NSHomeDirectory(),User_id];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:aPath error:nil];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    //回到登陆页面
    LoginViewController *login=[[LoginViewController alloc]init];
    login.tag= 1000;
    login.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:login animated:YES];

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1) {
        return ZOOM(227)+10;
    }
//    if (indexPath.row==_dataArray.count-1) {
//        return 0;
//    }
    if(indexPath.row==2)
    {
        return self.inviteImageHeigh;
    }
    return 55;
}

#pragma mark - ******************cell点击选项******************
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //index.row = %d", (int)indexPath.row);
    NSString *string = _dataArray[indexPath.row];
    
    if (indexPath.row==0) {
        MyOrderViewController *myorder=[[MyOrderViewController alloc]init];
        myorder.tag=999;
        myorder.status1=@"0";
        myorder.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:myorder animated:YES];
    }
    else if (indexPath.row==1) {

    }
    else if(indexPath.row==2) //钱包
    {
        TFMyWalletViewController *wallet=[[TFMyWalletViewController alloc]init];
        wallet.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:wallet animated:YES];
        if (_isBalanceShow) {
            [DelRedDotModel getDelRegDotWithType:DelRedDotTypeWallet success:nil];
        }
    }
    else if (indexPath.row == 3) //我的卡券
    {
        TFMyCardViewController *tmvc = [[TFMyCardViewController alloc] init];
        tmvc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:tmvc animated:YES];
        if (_isCouponShow) {
            [DelRedDotModel getDelRegDotWithType:DelRedDotTypeCoupon success:nil];
        }
    }
    else if(indexPath.row==4) //邀请好友
    {
        ShareToFriendsView *help=[[ShareToFriendsView alloc]init];
        help.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:help animated:YES];
    }else if(indexPath.row==5) { //我的足迹
        DianPumeiyiViewController *dianpu=[[DianPumeiyiViewController alloc]init];
        dianpu.titleString=@"我的足迹";
        dianpu.shopcount=self.mySteps_count;
        dianpu.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:dianpu animated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {

        PersonCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderCell"];
        cell.detailLabel.text=@"查看所有订单";
        cell.detailLabel.font=[UIFont systemFontOfSize:ZOOM6(26)];
        cell.detailLabel.textColor=[UIColor colorWithRed:168/255.0 green:168/255.0 blue:168/255.0 alpha:1];
        cell.nameLabel.text=_dataArray[indexPath.row];
        cell.headImg.image=[UIImage imageNamed:@"订单管理1"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.row==1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"viewCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"viewCell"];

            NSArray *buttonArray=@[@"待付款1",@"待发货1",@"待收货1",@"待评价1",@"退款售后1"];
            NSArray *lableArray=@[@"待付款",@"待发货",@"待收货",@"待评价",@"退款售后"];
            
            for(int i=0;i<buttonArray.count;i++)
            {
                UIButton *typebut=[UIButton buttonWithType:UIButtonTypeCustom];
                CGFloat widh=kScreenWidth/5;
                CGFloat height = ZOOM(227);
                typebut.frame=CGRectMake(widh*i,0, widh, height);
                typebut.tag=1000+i;
                
                [typebut addTarget:self action:@selector(butclick:) forControlEvents:UIControlEventTouchUpInside];
                
                UIImageView *titleimg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:buttonArray[i]]];
                titleimg.contentMode = UIViewContentModeScaleAspectFit;
                titleimg.frame=CGRectMake((widh-27)/2,5, 27, height/3*2);
                [typebut addSubview:titleimg];
                
                NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
                NSString *token=[userdefaul objectForKey:USER_TOKEN];
                
                if(token != nil)
                {
                    
                    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(16,ZOOM(10), 18, 18)];
                    lable.backgroundColor=[UIColor clearColor];
                    lable.textColor=[UIColor whiteColor];
                    lable.font=[UIFont systemFontOfSize:10];
                    lable.textAlignment=NSTextAlignmentCenter;
                    lable.clipsToBounds=YES;
                    lable.layer.cornerRadius=9;
                    lable.tag=2000+i;
                    [titleimg addSubview:lable];
                    
                }
                
                UILabel *titlelab=[[UILabel alloc]initWithFrame:CGRectMake(0,height/2, widh, height/2)];
                titlelab.text=lableArray[i];
                titlelab.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
                titlelab.textAlignment=NSTextAlignmentCenter;
                titlelab.font= [UIFont systemFontOfSize:ZOOM(36)];
                [typebut addSubview:titlelab];
                
                [cell addSubview:typebut];
        
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        cell.separatorInset = UIEdgeInsetsMake(0, kScreenWidth, 0, 0);
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, ZOOM(227), kScreenWidth, 10)];
        bottomView.backgroundColor = RGBCOLOR_I(244,244,244);
        [cell addSubview:bottomView];

        return cell;
    }
    else if (indexPath.row == 2)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"invitCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"invitCell"];
            
            InvitFriendFreeLingView *lingview = [[InvitFriendFreeLingView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, self.inviteImageHeigh)];
            lingview.invitFreeLingBlock = ^{
                InviteFriendFreelingViewController *friendraward = [[InviteFriendFreelingViewController alloc]init];
                friendraward.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:friendraward animated:YES];
            };
            lingview.closeFreeLingBlock = ^{
                _dataArray = [NSMutableArray arrayWithArray:@[@"我的订单",@""]];
                [_Mytableview reloadData];
            };
            [cell addSubview:lingview];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsMake(0, kScreenWidth, 0, 0);
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, ZOOM(227), kScreenWidth, 10)];
        bottomView.backgroundColor = RGBCOLOR_I(244,244,244);
        [cell addSubview:bottomView];
        
        return cell;
    }

    PersonCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row==_dataArray.count-1) {
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"footCell"];
        if (!cell1) {
            cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"footCell"];
        }
        return cell1;
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.headImg.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@1", _dataArray[indexPath.row]]];
        cell.nameLabel.text=_dataArray[indexPath.row];
        cell.arrow.hidden = YES;
        cell.detailLabel.hidden = YES;
    }
    
    if([cell.nameLabel.text isEqualToString:@"我的任务"])
    {
        if (_integral > 0) {
            cell.detailLabel.hidden = NO;
            cell.detailLabel.text= [NSString stringWithFormat:@"赚%zd积分", _integral];
            cell.detailLabel.textColor=tarbarrossred;
            cell.detailLabel.font=[UIFont systemFontOfSize:ZOOM(40)];
        }
        
    } else if ([cell.nameLabel.text isEqualToString:@"我的钱包"]) {
        if (_isBalanceShow) {
            cell.arrow.hidden = NO;
        } else {
            double balance = _balance;
            
            if ([DataManager sharedManager].isOligible&&[DataManager sharedManager].isOpen&&[DataManager sharedManager].twofoldness > 0) {
                balance *= [DataManager sharedManager].twofoldness;
            }
            NSNumber *money=[NSNumber numberWithFloat:balance];

            cell.detailLabel.hidden = NO;
            MyLog(@"%g %@ ",balance,money);
            cell.detailLabel.text= [NSString stringWithFormat:@"%@元", money];
            cell.detailLabel.textColor=tarbarrossred;
            cell.detailLabel.font=[UIFont systemFontOfSize:ZOOM(40)];
        }
    } else if ([cell.nameLabel.text isEqualToString:@"我的卡券"]) {
        if (_isCouponShow) {
            cell.arrow.hidden = NO;
        } else {
            cell.detailLabel.hidden = NO;
            cell.detailLabel.text= [NSString stringWithFormat:@"%.0f元", _couponSum];
            cell.detailLabel.textColor=tarbarrossred;
            cell.detailLabel.font=[UIFont systemFontOfSize:ZOOM(40)];
        }

    }
    return cell;
}

-(void)click:(UITapGestureRecognizer*)tap
{
    //ok");
    
    TFMyInformationViewController *myinformation=[[TFMyInformationViewController alloc]init];
    myinformation.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:myinformation animated:YES];
    
}
- (void)bbtClick:(UIButton *)sender
{
    //bbt");
    TFMyInformationViewController *myinformation=[[TFMyInformationViewController alloc]init];
    myinformation.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:myinformation animated:YES];
}

- (void)addCard:(UITapGestureRecognizer*)tap
{
    if(self.vip_name.length > 0)//是会员
    {
        AddMemberCardViewController *member = [[AddMemberCardViewController alloc]init];
        member.from_vipType = @"-1003";
        member.vip_type = self.vip_type;
        member.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:member animated:YES];
    }else{
        AddMemberCardViewController *addcard = [[AddMemberCardViewController alloc]init];
        addcard.from_vipType = @"mine";
        addcard.vip_type = self.vip_type;
        addcard.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:addcard animated:YES];
    }
}
#pragma mark 信息
-(void)message:(UIButton*)sender
{
    // begin 赵官林 2016.5.26 跳转到消息列表
    [self presentChatList];
    // end
}

- (void)pushHttpRequest
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *deviceTokenStr =[userdefaul objectForKey:DECICETOKEN];
    
    NSString *url;
    url=[NSString stringWithFormat:@"%@push/iosPush?version=%@&deviceToken=%@&alert=%@",[NSObject baseURLStr],VERSION,deviceTokenStr,@"你好"];
    
    NSString *URL=[MyMD5 authkey:url];
    
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        //
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
//            NSString *messsage=responseObject[@"message"];
            
            if(statu.intValue==1)
            {
                
            }else{
                
            }

        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
    }];
}

#pragma mark 检测商家是否添加信息
-(void)textHttprequest
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *token =[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    url=[NSString stringWithFormat:@"%@merchantAlliance/checkIsBus?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [[Animation shareAnimation] createAnimationAt:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        //检测商家是否添加信息: %@",responseObject);
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            _statu = statu;
//            NSString *messsage=responseObject[@"message"];
            
//            NavgationbarView *mentionview =[[NavgationbarView alloc]init];
            
            NSDictionary *dic;
            if(responseObject[@"business"] !=NULL)
            {
                dic = responseObject[@"business"];
                self.dictionary = dic;
            }

        }
        
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];

}

- (void)leftBtnClick {
    TFMyInformationViewController *tmvc = [[TFMyInformationViewController alloc] init];
    tmvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tmvc animated:YES];
}
#pragma mark 设置
-(void)setting:(UIButton*)sender
{
//    SettingViewController *stting=[[SettingViewController alloc]init];
//    [self.navigationController pushViewController:stting animated:YES];
    
//    TFSettingViewController *tf=[[TFSettingViewController alloc]init];
//    TFShoppingViewController *tf = [[TFShoppingViewController alloc] init];
//    TFPayStyleViewController *tf=[[TFPayStyleViewController alloc] init];
//    TFMakeMoneySecretViewController *tf = [[TFMakeMoneySecretViewController alloc] init];

    TFSettingViewController *tf=[[TFSettingViewController alloc]init];
//    TFLedBrowseShopViewController *tf = [[TFLedBrowseShopViewController alloc] init];
    
//    TFIndianaRecordViewController *tf = [[TFIndianaRecordViewController alloc] init];

    
//    TFCashSuccessViewController *tf = [[TFCashSuccessViewController alloc] init];
//    tf.index = VCType_Cash;
//    tf.cashType = CashType_Fail;
//    tf.money = 0.1;
    
//    tf.index = VCType_BindPhoneSuccess;
    
//    tf.index = VCType_ChangeBindPhone;
    
    tf.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:tf animated:YES];

}


-(void)no
{
    [ShareSDK cancelAuthWithType:ShareTypeQQSpace];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
-(void)login:(UIButton*)sender
{
    LoginViewController *login=[[LoginViewController alloc]init];
    login.tag=1000;
    login.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:login animated:NO];

}

-(void)regist
{
    //regist");
    LoginViewController *login=[[LoginViewController alloc]init];
    login.tag=2000;
    login.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:login animated:NO];

}


#pragma mark - 获取地址
- (NSArray *)getAddressStateID:(NSNumber *)stateNum withCityID:(NSNumber *)cityNum witAreaID:(NSNumber *)areaNum withStreetID:(NSNumber *)streetNum
{
    NSString *state;
    NSString *city;
    NSString *area;
    NSString *street;
    
    NSArray *stateArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"areatbl" ofType:@"plist"]];
    if ([stateNum intValue]!=0) { //查询省
        for (NSDictionary *dic in stateArr) {
            if ([dic[@"id"] intValue] == [stateNum intValue]) { //找到省
                state = dic[@"state"];
                if ([cityNum intValue]!=0) {
                    NSArray *citiesArr = dic[@"cities"];
                    for (NSDictionary *dic in citiesArr) {
                        if ([dic[@"id"] intValue] == [cityNum intValue]) { //找到市
                            city = dic[@"city"];
                            if ([areaNum intValue]!=0) {
                                NSArray *areasArr = dic[@"areas"];
                                for (NSDictionary *dic in areasArr) {
                                    if ([dic[@"id"] intValue] == [areaNum intValue]) { //找到区
                                        area = dic[@"area"];
                                        if ([streetNum intValue]!=0) {
                                            NSArray *streetsArr = dic[@"streets"];
                                            for (NSDictionary *dic in streetsArr) {
                                                if ([streetNum intValue] == [dic[@"id"] intValue]) { //找到街道
                                                    street = dic[@"street"];
                                                    break;
                                                }
                                            }
                                        }
                                        break;
                                    }
                                }
                            }
                            break;
                        }
                    }
                }
                break;
            }
        }
    }
    if (area!=nil&&street!=nil) {
        return [NSArray arrayWithObjects:state,city,area,street, nil];
    } else if (area!=nil&&street == nil) {
        return [NSArray arrayWithObjects:state,city,area, nil];
    } else if (area ==nil&&street == nil) {
        return [NSArray arrayWithObjects:state,city, nil];
    } else
        return nil;
}

#pragma mark - RCKitDispatchMessageNotification
/// 收到消息通知
- (void)didReceiveMessageNotification:(NSNotification *)notification {
    RCMessage *message = notification.object;
    if (message.messageDirection == MessageDirection_RECEIVE) {
        //获得所有DB中未读消息数量
        NSInteger readMessageCount = [RCIMClient sharedRCIMClient].getTotalUnreadCount;
        dispatch_sync(dispatch_get_main_queue(), ^{
            _messagecount.text = [NSString stringWithFormat:@"%ld",readMessageCount];
            NSLog(@"%@",_messagecount.text);
            if(readMessageCount > 0) {
                _messagecount.hidden = NO;
            }else{
                _messagecount.hidden = YES;
            }
           
            
             self.collectionButtonView.messageCount=readMessageCount+[[NSUserDefaults standardUserDefaults]integerForKey:@"TOPICMESSAGE"];
      
        });
    }
}

#pragma mark - CFCollectionButtonView
- (CFCollectionButtonView *)collectionButtonView {
    if (_collectionButtonView==nil) {
        _collectionButtonView=[[CFCollectionButtonView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kScreenWidth/2)];
        _collectionButtonView.delegate=self;
        _collectionButtonView.arr=@[@"个人中心_消息",@"个人中心_穿搭",@"个人中心_蜜友",@"个人中心_收藏",@"个人中心_最爱",@"个人中心_足迹",@"个人中心_照片",@"个人中心_好友奖励"];
//        NSInteger readMessageCount = IsRongCloub ? [RCIMClient sharedRCIMClient].getTotalUnreadCount : [[EaseMob sharedInstance].chatManager loadTotalUnreadMessagesCountFromDatabase];
//        _collectionButtonView.messageCount=readMessageCount+[[NSUserDefaults standardUserDefaults]integerForKey:@"TOPICMESSAGE"];
    }
    return _collectionButtonView;
}
- (NSInteger)CFCollectionButtonView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}
- (void)didSelectCFCollectionButtonView:(NSInteger)index {
    NSLog(@"--index:%zd",index);
    switch (index) {
        case 0:{
//            [self message:nil];
            MessageCenterVC *vc = [MessageCenterVC new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            TFSubIntimateCircleVC *vc = [[TFSubIntimateCircleVC alloc] init];
            //            vc.headerView_H = 64;
            vc.name = @"穿搭";
            //            TFPublishDress *vc = [[TFPublishDress alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            CFFriendsViewController *vc = [CFFriendsViewController new];
            vc.type=CFFriendsSecret;
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            TFSubIntimateCircleVC *vc = [[TFSubIntimateCircleVC alloc] init];
//            vc.headerView_H = 64;
            vc.name = @"收藏";
//            TFPublishThemeVC *vc = [[TFPublishThemeVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            DianPumeiyiViewController *dianpu=[[DianPumeiyiViewController alloc]init];
            dianpu.titleString=@"我的最爱";
            dianpu.shopcount=self.like_count;
            dianpu.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:dianpu animated:YES];
        }
            break;
        case 5:
        {
            DianPumeiyiViewController *dianpu=[[DianPumeiyiViewController alloc]init];
            dianpu.titleString=@"我的足迹";
            dianpu.shopcount=self.mySteps_count;
            dianpu.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:dianpu animated:YES];
        }
            break;
        case 6:
        {
            //照片
            PersonPhotosVC *vc=[PersonPhotosVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];

//            UIViewController *vc2 = [NSClassFromString(@"CFInviteFriendsRewardVC") new];
//            vc2.hidesBottomBarWhenPushed=YES;
//            [self.navigationController pushViewController:vc2 animated:YES];
        }
            break;
            case 7:
        {
            //测试用
//            SelectShareTypeViewController *sharetype = [[SelectShareTypeViewController alloc]init];
//            sharetype.ISInvit = YES;
//            sharetype.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:sharetype animated:YES];

//            ContactKefuViewController *contact = [[ContactKefuViewController alloc]init];
//            contact.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:contact animated:YES];
            
//            ShouYeShopStoreViewController *vc = [[ShouYeShopStoreViewController alloc] init];
//            vc.hidesBottomBarWhenPushed = YES;
//            vc.isHeadView = YES;
//            vc.isFootView = NO;
//            vc.isVseron = YES;
//            [self.navigationController pushViewController:vc animated:YES];

            //好友奖励
            MemberRawardsViewController *memnumber = [[MemberRawardsViewController alloc]init];
            memnumber.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:memnumber animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark 0元购弹框
- (void)setVitalityPopMindView:(VitalityType)type
{
    NSInteger valityGrade = type ==Detail_OneYuanDeductible?3:0;
    
    VitalityTaskPopview *vitaliview = [[VitalityTaskPopview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) VitalityType:type valityGrade:valityGrade YidouCount:0];
    vitaliview.oneYuanDiKou = [DataManager sharedManager].OneYuan_count;
    __weak VitalityTaskPopview *view = vitaliview;
    view.tapHideMindBlock = ^{
        
        [view remindViewHiden];
        
    };
    
    view.leftHideMindBlock = ^(NSString*title){
        
        if(type == Detail_OneYuanDeductible)
        {
            MyOrderViewController *myorder = [[MyOrderViewController alloc]init];
            myorder.tag=999;
            myorder.status1=@"0";
            myorder.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myorder animated:YES];
        }
    };
    view.rightHideMindBlock = ^(NSString *title) {
        if (type == Detail_OneYuanDeductible)//余额返回说明
        {
            TFMyWalletViewController *wallet = [[TFMyWalletViewController alloc]init];
            wallet.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:wallet animated:YES];
        }
    };
    
    [self.view addSubview:vitaliview];
}

- (void)popView:(GroupBuyPopType)type coupon:(CGFloat)coupon {
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *popcount = [user objectForKey:@"groupPopcount"];
    
    //此框只弹两次
    if (type && popcount.integerValue <2) {
        
        GroupBuyPopView *view = [[GroupBuyPopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) popType:type];
        
        view.moneyNum = [NSString stringWithFormat:@"%.0f",20-coupon];
        kWeakSelf(self);
        view.btnBlok = ^(NSInteger index) {
            MakeMoneyViewController *vc = [[MakeMoneyViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:vc animated:YES];
        };
        [view show];
        [user setObject:[NSString stringWithFormat:@"%zd",popcount.integerValue+1] forKey:@"groupPopcount"];
    }
}

- (void)addcardPopview:(GroupBuyPopType)type
{
    GroupBuyPopView *view = [[GroupBuyPopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) popType:type];
    
    kWeakSelf(self);
    view.btnBlok = ^(NSInteger index) {
        AddMemberCardViewController *vc = [[AddMemberCardViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:vc animated:YES];
    };
    [view show];
}
@end