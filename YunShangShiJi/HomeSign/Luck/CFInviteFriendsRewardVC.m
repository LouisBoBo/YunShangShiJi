//
//  CFInviteFriendsRewardVC.m
//  YunShangShiJi
//
//  Created by YF on 2017/11/1.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "CFInviteFriendsRewardVC.h"

#import "AppDelegate.h"
#import "VitalityModel.h"
#import "DShareManager.h"
#import "CFPopView.h"
#import "FriendSharePopview.h"

#import "TFWithdrawCashViewController.h"
#import "FriendsRawardsViewController.h"

@interface CFInviteFriendsRewardVC ()<DShareManagerDelegate,MiniShareManagerDelegate>{
    UIView *ScrContainer;
    NSString *shareDiscription, *shareTitle, *imgPathUrl, *linkUrl;
    NSString *dayRewardStr;
    ShareType sharetype;
}
@property (strong, nonatomic) UIImageView *headView;             //头部
@property (nonatomic, strong) UIScrollView *myScrollview;
@property (nonatomic, strong) UILabel *totalbalanceLab;
@property (nonatomic, strong) UILabel *availablebalanceLab;
@property (nonatomic, strong) UILabel *activityTitle;
@property (nonatomic, strong) DShareManager *shareManager;
@end

@implementation CFInviteFriendsRewardVC

- (DShareManager*)shareManager
{
    if(_shareManager == nil) {
        AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        [app shardk];
        _shareManager = [DShareManager share];
        _shareManager.delegate = self;
    }
    return _shareManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationItemLeft:@"邀请好友赢提成奖励"];
    [self setTopMoneyView];
    [self setActivityRulesView];
    
    [self setTodayRewardBtn];
    
    [self httpGetData];
    [self httpActivityRule];
    [self httpGetDayReward];
}
- (void)getBalancemutable:(UILabel*)lab Text:(NSString*)text
{
    NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:lab.text];
    
    [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(48)] range:NSMakeRange(0, text.length)];
    [lab setAttributedText:mutable];
    
}
//!!!!: 网络请求
//获取余额
- (void)httpGetData
{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr1 = [NSString stringWithFormat:@"%@wallet/myWallet?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL1 = [MyMD5 authkey:urlStr1];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            
            if ([responseObject[@"status"] intValue] == 1) {
                
                float _balance = [[NSString stringWithFormat:@"%@",responseObject[@"balance"]] floatValue];
                float _extract = [[NSString stringWithFormat:@"%@",responseObject[@"extract"]] floatValue];
                float _ex_free = [[NSString stringWithFormat:@"%@",responseObject[@"ex_free"]] floatValue];
                
                if(_balance)
                {
                    CGFloat bb = 0;
                    if ([DataManager sharedManager].isOligible&&[DataManager sharedManager].isOpen&&([DataManager sharedManager].twofoldness > 0)) {
                        
                        bb = [DataManager sharedManager].twofoldness *_balance;
                    }else{
                        bb = _balance;
                    }
                    
                    self.totalbalanceLab.text = [NSString stringWithFormat:@"%.2f\n总金额(元)",bb];
                    [self getBalancemutable:self.totalbalanceLab Text:[NSString stringWithFormat:@"%.2f",bb]];
                }
                
                if(_extract+_ex_free >0)
                {
                    self.availablebalanceLab.text = [NSString stringWithFormat:@"%.2f\n可提现(元)",_extract+_ex_free];
                    [self getBalancemutable:self.availablebalanceLab Text:[NSString stringWithFormat:@"%.2f",_extract+_ex_free]];
                }
                
            } else {
                //                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
    }];
    
}
- (void)httpActivityRule {
    NSString *url= [NSString stringWithFormat:@"%@paperwork/paperwork.json",[NSObject baseURLStr_Upy]];
    
    NSURL *httpUrl=[NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:httpUrl];
    request.timeoutInterval = 3;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSDictionary *text = responseObject[@"hytc_hdgz"][@"text"];
            
            NSMutableString *str = [NSMutableString string];
            for (int i=0; i<[text allKeys].count; i++) {
                [str appendFormat:@"%d.%@",i+1,text[[NSString stringWithFormat:@"t%zd",i]]];
                [str appendFormat:i==[text allKeys].count-1?@"":@"\n"];
            }
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.paragraphSpacing = ZOOM6(28);
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
//            [_activityTitle setAttributedText:attributedString];
            
            shareDiscription=responseObject[@"hytc_h5_fx"][@"text"];
            shareTitle=responseObject[@"hytc_h5_fx"][@"title"];
            NSString *pic=[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy], responseObject[@"hytc_h5_fx"][@"icon"]];
            
            linkUrl = [NSString stringWithFormat:@"%@view/activity/mission.html?realm=%@",[NSObject baseURLStr_H5],[[NSUserDefaults standardUserDefaults]objectForKey:USER_ID]];

            //            imgPathUrl=[[NSUserDefaults standardUserDefaults]objectForKey:USER_WX_HEADPIC];
//            if (imgPathUrl==nil) {
                imgPathUrl=pic;
//            }
        }
    }
}

/**
 增加好友提成系统分享次数接口     (分享成功后调用)
 */
- (void)httpShareSuccess {
    [[APIClient sharedManager]netWorkGeneralRequestWithApi:@"share/addShareCount?" caches:NO cachesTimeInterval:0 token:YES success:^(id data, Response *response) {
        if (response.status == 1) {
        }
    } failure:^(NSError *error) {
        
    }];
}


/**
 获取当前用户的提成相关的数据
 "ed_num": xx人获得额度,
 "xj_num": xx人获得现金
 "f_money":下级获得的现金,
 "money": 我获得现金,
 extra:我获得的额度
 f_extra:下级获得的额度
 */
- (void)httpGetDayReward {
    [[APIClient sharedManager]netWorkGeneralRequestWithApi:@"wallet/getTcToDayCount?" caches:NO cachesTimeInterval:0 token:YES success:^(id data, Response *response) {
        if (response.status == 1) {
            NSDictionary *dic = data[@"data"];
            dayRewardStr = [NSString stringWithFormat:@"%@-%@-%@-%@-%@-%@",dic[@"xj_num"]?:@"0",dic[@"f_money"]?:@"0",dic[@"ed_num"]?:@"0",dic[@"f_extra"]?:@"0",dic[@"money"]?:@"0",dic[@"extra"]?:@"0"];
        }
    } failure:^(NSError *error) {
        
    }];
}


//!!!!: UI界面
/**
 今日奖励按钮
 */
- (void)setTodayRewardBtn {
    
    UIButton *todayReward=[UIButton buttonWithType:UIButtonTypeCustom];
    [todayReward setTitle:@"好\n友\n奖\n励" forState:UIControlStateNormal];
    todayReward.layer.cornerRadius=3;
    [todayReward setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [todayReward setBackgroundColor:RGBA(255, 207, 0, 1)];
    todayReward.frame=CGRectMake(kScreenWidth-ZOOM6(65), 64+ZOOM6(200)+ZOOM6(100)+ZOOM6(12), ZOOM6(70), ZOOM6(160));
    [todayReward addTarget:self action:@selector(creatDayRewardView) forControlEvents:UIControlEventTouchUpInside];
    todayReward.titleLabel.font=[UIFont boldSystemFontOfSize:ZOOM6(30)];
    todayReward.titleLabel.numberOfLines=4;
    todayReward.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:todayReward];
}
/**
 总余额、可提现、提现
*/
- (void)setTopMoneyView {
    
    self.myScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar)];
    self.myScrollview.userInteractionEnabled = YES;
    self.myScrollview.backgroundColor = RGBCOLOR_I(242, 24, 64);
    self.myScrollview.contentMode =UIViewContentModeScaleAspectFill;
    self.myScrollview.contentSize = CGSizeMake(0, 1000);
    [self.view addSubview:self.myScrollview];
    
    ScrContainer = [UIView new];
    [self.myScrollview addSubview:ScrContainer];
    [ScrContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_myScrollview);
        make.width.equalTo(_myScrollview);
    }];
    
    self.headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
    self.headView.userInteractionEnabled = YES;
    self.headView.image = [UIImage imageNamed:@"invite_好友提成奖励.jpg"];
    [ScrContainer addSubview:self.headView];
    
    UIImageView *headimage = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM6(20), 0, kScreenWidth-ZOOM6(20)*2, ZOOM6(130))];
    headimage.image = [UIImage imageNamed:@"bg_top"];
    headimage.userInteractionEnabled = YES;
    [self.headView addSubview:headimage];
    
    
    CGFloat labwith = CGRectGetWidth(headimage.frame)/3;
    CGFloat labheigh = CGRectGetHeight(headimage.frame);

    //总余额 提现额度
    for(int i = 0;i<3;i++)
    {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(30)+labwith*i, ZOOM6(10), labwith, labheigh-ZOOM6(20))];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:ZOOM6(30)];
        lable.numberOfLines = 0;;
        lable.textColor = [UIColor redColor];
        if(i==0)
        {
            NSString *str = @"0.00";
            lable.text = [NSString stringWithFormat:@"%.2f\n总金额(元)",[str floatValue]];
            [self getBalancemutable:lable Text:str];
            
            self.totalbalanceLab = lable;
            
        }else if (i == 1)
        {
            NSString *str = @"0.00";
            lable.text = [NSString stringWithFormat:@"%.2f\n可提现(元)",[str floatValue]];
            [self getBalancemutable:lable Text:str];
            
            self.availablebalanceLab = lable;
        }else{
            lable.frame = CGRectMake(CGRectGetWidth(headimage.frame)-ZOOM6(180), (labheigh - ZOOM6(60))/2+ZOOM6(10), ZOOM6(160), ZOOM6(60));
            lable.userInteractionEnabled = YES;
            lable.backgroundColor = tarbarrossred;
            lable.textColor = [UIColor whiteColor];
            lable.clipsToBounds = YES;
            lable.layer.cornerRadius = 5;
            lable.text = @"提现";
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tixian)];
            [lable addGestureRecognizer:tap];
        }
        
        [headimage addSubview:lable];
    }
    
}

//活动规则
- (void)setActivityRulesView {
    UIView *activityRulesView=[[UIView alloc]initWithFrame:CGRectMake(ZOOM6(20), CGRectGetMaxY(self.headView.frame), kScreenWidth-ZOOM6(40), 35+ZOOM6(80)*8+ZOOM6(20)*8)];
    activityRulesView.backgroundColor = [UIColor whiteColor];
    activityRulesView.layer.cornerRadius = 3;
    [ScrContainer addSubview:activityRulesView];
    
    UIImageView *titleimage = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM6(20), 15, kScreenWidth-ZOOM6(20)*2, 20)];
    titleimage.image=[UIImage imageNamed:@"invite_hdgz"];
    //    titleimage.backgroundColor=[UIColor whiteColor];
    titleimage.contentMode=UIViewContentModeScaleAspectFit;
    [activityRulesView addSubview:titleimage];
    
    UILabel *activityTitle = [[UILabel alloc]init];
    activityTitle.textColor = kMainTitleColor;
    activityTitle.font = kFont6px(28);
    activityTitle.numberOfLines = 0;
    activityTitle.lineBreakMode = UILineBreakModeCharacterWrap;
    [activityRulesView addSubview:activityTitle];
    _activityTitle = activityTitle;
    
    UIImageView *rewardImg = [[UIImageView alloc]init];
    rewardImg.image = [UIImage imageNamed:@"invite_biaoge"];
    [activityRulesView addSubview:rewardImg];
    
    UILabel *shareTitleLabel = [[UILabel alloc]init];
    shareTitleLabel.textColor = tarbarrossred;
    shareTitleLabel.font = kFont6px(24);
    shareTitleLabel.text = @"分享到3个群后,\n100%拿到现金奖励";
    shareTitleLabel.textAlignment = NSTextAlignmentCenter;
    shareTitleLabel.numberOfLines = 0;
    [activityRulesView addSubview:shareTitleLabel];
    
    UIButton *wxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [wxBtn setImage:[UIImage imageNamed:@"分享到微信群"] forState:UIControlStateNormal];
    wxBtn.tag = 10000;
    [wxBtn addTarget:self action:@selector(shareclick:) forControlEvents:UIControlEventTouchUpInside];
    [activityRulesView addSubview:wxBtn];
    
//    UIButton *wxFriendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [wxFriendBtn setImage:[UIImage imageNamed:@"朋友圈-1"] forState:UIControlStateNormal];
//    wxFriendBtn.tag = 10001;
//    [wxFriendBtn addTarget:self action:@selector(shareclick:) forControlEvents:UIControlEventTouchUpInside];
//    [activityRulesView addSubview:wxFriendBtn];
//    UILabel *textLabel = [[UILabel alloc]init];
//    textLabel.textColor = kMainTitleColor;
//    textLabel.font = kFont6px(32);
//    textLabel.text = @"微信群邀请好友";
//    [activityRulesView addSubview:textLabel];
//    UILabel *detailLabel = [[UILabel alloc]init];
//    detailLabel.textColor = kSubTitleColor;
//    detailLabel.font = kFont6px(24);
//    detailLabel.text = @"单发或发微信群，针对性强";
//    [activityRulesView addSubview:detailLabel];
//    UILabel *textLabel2 = [[UILabel alloc]init];
//    textLabel2.textColor = kMainTitleColor;
//    textLabel2.font = kFont6px(32);
//    textLabel2.text = @"朋友圈邀请好友";
//    [activityRulesView addSubview:textLabel2];
//    UILabel *detailLabel2 = [[UILabel alloc]init];
//    detailLabel2.textColor = kSubTitleColor;
//    detailLabel2.font = kFont6px(24);
//    detailLabel2.text = @"静静地广而告之，覆盖面广";
//    [activityRulesView addSubview:detailLabel2];
    
    [titleimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(ZOOM6(20));
        make.top.offset(ZOOM6(40));
        make.width.offset(kScreenWidth-ZOOM6(40));
        make.height.offset(20);
    }];
    [activityTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(ZOOM6(60));
        make.right.offset(-ZOOM6(60));
        make.top.equalTo(titleimage.mas_bottom).offset(ZOOM6(30));
    }];
    [rewardImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(activityTitle);
        make.top.equalTo(activityTitle.mas_bottom).offset(ZOOM6(40));
        make.height.offset(ZOOM6(0));
    }];
    [shareTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.equalTo(rewardImg.mas_bottom).offset(ZOOM6(0));
        make.width.offset(CGRectGetWidth(activityRulesView.frame));
        make.height.offset(ZOOM6(100));
    }];
    [wxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset((CGRectGetWidth(activityRulesView.frame)-ZOOM6(420))/2);
        make.top.equalTo(shareTitleLabel.mas_bottom).offset(ZOOM6(0));
        make.width.offset(ZOOM6(420));
        make.height.offset(ZOOM6(88));
    }];
//    [wxFriendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(shareTitleLabel);
//        make.top.equalTo(wxBtn.mas_bottom).offset(ZOOM6(30));
//        make.width.height.offset(ZOOM6(100));
//    }];
//    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(wxBtn.mas_centerY).offset(-ZOOM6(5));
//        make.left.equalTo(wxBtn.mas_right).offset(ZOOM6(30));
//        make.width.offset(kScreenWidth);
//    }];
//    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(wxBtn.mas_centerY).offset(ZOOM6(5));
//        make.left.equalTo(wxBtn.mas_right).offset(ZOOM6(30));
//        make.width.offset(kScreenWidth);
//    }];
//    [textLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(wxFriendBtn.mas_centerY).offset(-ZOOM6(5));
//        make.left.equalTo(wxFriendBtn.mas_right).offset(ZOOM6(30));
//        make.width.offset(kScreenWidth);
//    }];
//    [detailLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(wxFriendBtn.mas_centerY).offset(ZOOM6(5));
//        make.left.equalTo(wxFriendBtn.mas_right).offset(ZOOM6(30));
//        make.width.offset(kScreenWidth);
//    }];
    
    [activityRulesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(ZOOM6(20));
        make.top.offset(CGRectGetMaxY(self.headView.frame)-ZOOM6(70));
        make.width.offset(kScreenWidth-ZOOM6(40));
//        make.height.offset(35+ZOOM6(80)*8+ZOOM6(20)*7);
//        make.bottom.equalTo(wxFriendBtn.mas_bottom).offset(ZOOM6(80));
        make.bottom.equalTo(wxBtn.mas_bottom).offset(ZOOM6(80));

    }];
    
//    NSString *textStr = @"1、分享赚钱任务页邀请未注册好友。\n2、好友完成任务赢取账户余额与提现额度。\n3、你可拿好友账户余额与提现成功金额的25%奖励。（提现奖励每累计满1元会自动提现入您的微信账户。）\n4、每位好友最高100元余额，50元提现。";

//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textStr];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.paragraphSpacing = ZOOM6(28);
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [textStr length])];
//    [activityTitle setAttributedText:attributedString];
    
    NSString *textStr = @"1、分享微信群，邀请家人，朋友或同事来衣蝠。\n2、好友每次消费，你可得10%奖励金。\n3、分享到3个以上微信群，拿到奖励金的概率提升200%。\n4、坚持分享30天，拿到200元+奖励金的概率高达98%。";
    NSArray *findStrArr = @[@"2元提现现金",@"提升200%",@"18元任务红包"];
    NSMutableAttributedString *nsmutable = [[NSMutableAttributedString alloc]initWithString:textStr];
    for(int i =0; i < findStrArr.count; i++)
    {
        NSString * findstr = findStrArr[i];
        NSRange range = [textStr rangeOfString:findstr];
        [nsmutable addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(range.location, findstr.length)];
        [nsmutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(28)] range:NSMakeRange(0, textStr.length)];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.paragraphSpacing = ZOOM6(28);
        [paragraphStyle setLineSpacing:ZOOM6(10)];
        [nsmutable addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [textStr length])];
        [activityTitle setAttributedText:nsmutable];
    }
    
    [ScrContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(activityRulesView.mas_bottom).offset(ZOOM6(20));
    }];
}

//!!!!: btn 点击事件


- (void)creatDayRewardView {
//    NSString *str = [NSString stringWithFormat:@"%@",dayRewardStr];
//    CFPopView *view=[[CFPopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) textStrs:str];
//    view.showView = self.view;
//    [view show];
    
    FriendsRawardsViewController *friend = [[FriendsRawardsViewController alloc]init];
    friend.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:friend animated:YES];
}

- (void)shareclick:(UIButton *)sender {
//    ShareType sharetype=ShareTypeWeixiTimeline;
    NSInteger tag=sender.tag-10000;
    /*
    switch (tag) {
        case 1:{
            MyLog(@"微信朋友圈");
            sharetype = ShareTypeWeixiTimeline;
//            [YFShareModel getShareModelWithKey:@"point" type:StatisticalTypeToSharePYQ tabType:StatisticalTabTypeLikeCollect success:nil];

            break;
        }
        case 0:{
            MyLog(@"微信好友");
            sharetype = ShareTypeWeixiSession;
//            [YFShareModel getShareModelWithKey:@"point" type:StatisticalTypeToShareWX tabType:StatisticalTabTypeLikeCollect success:nil];

            break;
        }
        default:
            break;
    }
    */
    NSString *discription=@"真实可提现，非优惠券。快来！";
    
    if (shareTitle==nil) {
        shareTitle = @"我在衣蝠花5分钟做任务已赚了《可提现》20.5元现金。爽呆！";
        imgPathUrl=[[NSUserDefaults standardUserDefaults]objectForKey:USER_WX_HEADPIC];
        linkUrl = [NSString stringWithFormat:@"%@view/activity/mission.html?realm=%@",[NSObject baseURLStr_H5],[[NSUserDefaults standardUserDefaults]objectForKey:USER_ID]];
    }
    if(tag==0||sender==nil){
        if(!self.isShareMakeMoney)
        {
            MiniShareManager *minishare = [MiniShareManager share];
            NSString *user_id = [[NSUserDefaults standardUserDefaults]objectForKey:USER_ID];
            NSString *path  = [NSString stringWithFormat:@"/pages/shouye/redHongBao?shouYePage=ThreePage&isShareFlag=true&user_id=%@",user_id];
            minishare.delegate = self;
            imgPathUrl = @"品牌分享.jpg";
            
            [minishare shareAppWithType:MINIShareTypeWeixiSession Image:imgPathUrl Title:@"50+一线大牌，2000款新款【全场1元】错过后悔一年。" Discription:nil WithSharePath:path];
        }else
            [self httpGetTixianShare];
    }else {
        sharetype = ShareTypeWeixiTimeline;
        if (shareTitle==nil) {
            [self.shareManager sharePersonH5WithType:sharetype withLinkShareType:@"" withLink:linkUrl andImagePath:imgPathUrl andTitle:shareTitle andContent:discription];
        }else
            [self.shareManager sharePersonH5WithType:sharetype withLinkShareType:@"" withLink:linkUrl andImagePath:imgPathUrl andTitle:shareTitle andContent:shareDiscription];
        
    }
}

- (void)httpGetTixianShare
{
    NSString *URL= [NSString stringWithFormat:@"%@paperwork/paperwork.json",[NSObject baseURLStr_Upy]];
    NSURL *httpUrl=[NSURL URLWithString:URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:httpUrl];
    request.timeoutInterval = 10;
    request.HTTPMethod = @"GET";
    
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            
            if(responseObject[@"wxcx_share_links"] != nil)
            {
                NSString* title = [NSString stringWithFormat:@"%@",responseObject[@"wxcx_share_links"][@"title"]];
                NSString* Share_pic = [NSString stringWithFormat:@"%@",responseObject[@"wxcx_share_links"][@"icon"]];
                NSString *shareimgae = [NSString stringWithFormat:@"%@/%@!280",[NSObject baseURLStr_XCX_Upy],Share_pic];
                
                MiniShareManager *minishare = [MiniShareManager share];
                NSString *user_id = [[NSUserDefaults standardUserDefaults]objectForKey:USER_ID];
                NSString *path  = [NSString stringWithFormat:@"/pages/shouye/redHongBao?shouYePage=ThreePage&isShareFlag=true&user_id=%@",user_id];
                
                minishare.delegate = self;
                
                [minishare shareAppWithType:MINIShareTypeWeixiSession Image:shareimgae Title:title Discription:nil WithSharePath:path];
            }else{
                [MBProgressHUD show:@"数据异常" icon:nil view:self.view];
            }
        }
    }
}
- (void)tixian
{
    NSString *usertype = [[NSUserDefaults standardUserDefaults] objectForKey:USER_CLASSIFY];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    if([usertype isEqualToString:@"0"]||[usertype isEqualToString:@"1"]||[usertype isEqualToString:@"2"])//提现引导
    {
        if(token.length > 8)  {
            //            [self popViewWithDrawCashGuide];
            [VitalityModel posguide:^(id data) {//弹了引导弹框告诉后台
                
            }];
            
            TFWithdrawCashViewController *VC = [[TFWithdrawCashViewController alloc] init];
            VC.bindNameAndIdenfBlock = ^(NSInteger sguidance) {
                
            };
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
    }else {
        TFWithdrawCashViewController *cash = [[TFWithdrawCashViewController alloc]init];
        [self.navigationController pushViewController:cash animated:YES];
    }
}

#pragma mark - 分享代理
- (void)DShareManagerStatus:(SHARESTATE)shareStatus withType:(NSString *)type {
    if(shareStatus != STATE_BEGAN){
        if (shareStatus == STATE_SUCCESS) {
            [self httpShareSuccess];
            [self friendSharePopview:FriendShare_success];
            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
            [mentionview showLable:@"分享成功" Controller:self];
        }
        else if (shareStatus == STATE_FAILED|| shareStatus==STATE_CANCEL) {
            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
            [mentionview showLable:@"分享失败" Controller:self];
        }
    }
}
//小程序分享回调
- (void)MinihareManagerStatus:(MINISHARESTATE)shareStatus withType:(NSString *)type
{
    NSString *sstt = @"";
    switch (shareStatus) {
        case MINISTATE_SUCCESS:{
            [self httpShareSuccess];
            [self friendSharePopview:FriendShare_success];
            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
            [mentionview showLable:@"分享成功" Controller:self];
        }
            break;
        case MINISTATE_FAILED:
            sstt = @"分享失败";
            break;
        case MINISTATE_CANCEL:
            sstt = @"分享取消";
            break;
        default:
            break;
    }
    if(shareStatus != MINISTATE_SUCCESS)
    {
        NavgationbarView *mentionview = [[NavgationbarView alloc]init];
        [mentionview showLable:sstt Controller:self];
    }
}
// 好友分享成功
- (void)friendSharePopview:(FriendShareType)type
{
    FriendSharePopview *pop = [[FriendSharePopview alloc] initWithHeadImage:nil contentText:nil upButtonTitle:nil downButtonTitle:nil RawardType:type Raward:0];
    [pop show];
    
    kWeakSelf(self);
    pop.dismissBlock = ^()
    {
        
    };
    pop.upBlock = ^() { //上键
        [self shareclick:nil];
    };
    
    pop.downBlock = ^() {//下键
        [weakself.navigationController popViewControllerAnimated:YES];
    };
    
}
@end
