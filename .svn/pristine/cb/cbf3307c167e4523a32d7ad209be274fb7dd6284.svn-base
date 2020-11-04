//
//  MemberRawardsViewController.m
//  YunShangShiJi
//
//  Created by hebo on 2019/7/26.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import "MemberRawardsViewController.h"
#import "FriendsRawardsTableViewCell.h"
#import "TFWithdrawCashViewController.h"
#import "FriendsRawardModel.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "AFNetworking.h"
#import "GlobalTool.h"
#import "AppDelegate.h"
#import "MiniShareManager.h"
#import "memberRawardsModel.h"
#import "memberRawardTableViewCell.h"
#import "memberRawardsFriends.h"
#import "memberRawardsModel.h"

#define kYellowColor RGBA(255, 63, 139, 1)
#define kRedColor RGBA(255, 0, 76, 1)
@interface MemberRawardsViewController ()<MiniShareManagerDelegate>
@property (nonatomic , strong) memberRawardsModel*rawardModel;
@property (nonatomic , strong) UILabel *totalRawardLab;
@property (nonatomic , strong) UILabel *todayRawardLab;
@property (nonatomic , strong) UILabel *yesdayRawardLab;
@property (nonatomic , strong) UILabel *numberRawardLab;
@property (nonatomic , strong) UILabel *timeRawardLab;

@property (nonatomic , copy) NSString *shareTitle;
@property (nonatomic , copy) NSString *sharePic;
@end

@implementation MemberRawardsViewController
{
    NSInteger currentPage;        //当前页
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    currentPage = 1;
    
    [self creatNavagationbar];
    [self creatTableView];
    
    [self httpGetDayReward];
    [self httpShareData];
    [self httpGetRewardList:NO];
    
}

- (void)httpGetDayReward {
    [[APIClient sharedManager]netWorkGeneralRequestWithApi:@"wallet/getExtremeToDayCount?" caches:NO cachesTimeInterval:0 token:YES success:^(id data, Response *response) {
        if (response.status == 1) {
            if(data[@"data"] != NULL && ![data[@"data"] isEqual:[NSNull null]]){
                memberRawardsModel *model = [memberRawardsModel alloc];
                
                model.ext_num = data[@"data"][@"ext_num"];
                model.ext_now = data[@"data"][@"ext_now"];
                model.ext_yet = data[@"data"][@"ext_yet"];
                model.ext_time = data[@"data"][@"time"];
                model.ext_money = data[@"data"][@"ext_money"];
                model.is_vip = data[@"data"][@"is_vip"];
                
                self.rawardModel = model;
            }
        }
        
        [self refreshUI];
    } failure:^(NSError *error) {
        
    }];
    
    self.rawardModel.ext_money = [NSNumber numberWithInt:0];
    self.rawardModel.ext_now = [NSNumber numberWithInt:0];
    self.rawardModel.ext_yet = [NSNumber numberWithInt:0];
    self.rawardModel.ext_num = [NSNumber numberWithInt:0];
    self.rawardModel.ext_time = [NSNumber numberWithInt:0];
    
    [self refreshUI];
}

- (void)httpGetRewardList:(BOOL)isfresh {
    kWeakSelf(self);
    [memberRawardsFriends getFriendsData:currentPage Success:^(id data) {
        [weakself.mytableview footerEndRefreshing];
        [weakself.mytableview headerEndRefreshing];
        memberRawardsFriends *rawardFriend = data;
        if(rawardFriend.status == 1)
        {
            currentPage ++;
            for(memberRawardsModel *friendsmodel in rawardFriend.friendsdata){
                [weakself.mydataArray addObject:friendsmodel];
            }
            [weakself.mytableview reloadData];
        }
    }];
}
- (void)httpShareData
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
            
            if(responseObject[@"wxcx_share_links"] != nil){
                NSString *shareTitle = [NSString stringWithFormat:@"%@",responseObject[@"wxcx_share_links"][@"title"]];
                if(shareTitle == nil || [shareTitle isEqualToString:@""])
                {
                    shareTitle = @"我刚领的红包也分你一个，帮我提现就能拿钱哦~";
                }
                NSString *sharePic = [NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_XCX_Upy],responseObject[@"wxcx_share_links"][@"icon"]];
                if(sharePic == nil || [sharePic isEqualToString:@""])
                {
                    sharePic = [NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"/small-iconImages/heboImg/shareBigImage_new.jpg!280"];
                }
                
                
                //后面修改2019-10-14
                shareTitle = @"199元购物红包免费抢，多平台可用，快来试试人品吧👉";
                sharePic = [NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"/small-iconImages/heboImg/freeling_share199yuan.jpg!280"];
                
                self.shareTitle = shareTitle;
                self.sharePic = sharePic;
            }
        }
    }
}
//导航条
- (void)creatNavagationbar
{
    self.navheadview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    [self.view addSubview:self.navheadview];
    self.navheadview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(self.navheadview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.navheadview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, self.navheadview.frame.size.height/2+10);
    titlelable.text=@"好友奖励";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [self.navheadview addSubview:titlelable];
    
    UIView *hView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navheadview.frame.size.height-1, self.navheadview.frame.size.width, 1)];
    hView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.navheadview addSubview:hView];
    
}
- (UIView*)tabheadview{
    if(_tabheadview == nil)
    {
        _tabheadview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(600))];
        
        
        UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ZOOM6(20), CGRectGetWidth(_tabheadview.frame), ZOOM6(60))];
        titlelabel.textColor = RGBCOLOR_I(62, 62, 62);
        titlelabel.backgroundColor = [UIColor clearColor];
        titlelabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
        titlelabel.textAlignment = NSTextAlignmentCenter;
        titlelabel.textColor = tarbarrossred;
        titlelabel.text = @"可提现收益";
        [_tabheadview addSubview:titlelabel];
        
        UILabel *firstLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(titlelabel.frame), CGRectGetWidth(titlelabel.frame)+ZOOM6(10), ZOOM6(40))];
        firstLabel.textAlignment=NSTextAlignmentCenter;
        firstLabel.font=kFont6px(50);
        firstLabel.textColor=tarbarrossred;
        firstLabel.text = @"0.0";
        [_tabheadview addSubview:self.totalRawardLab = firstLabel];
        
        UILabel *secondLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(firstLabel.frame), CGRectGetWidth(titlelabel.frame), ZOOM6(40))];
        secondLabel.textAlignment=NSTextAlignmentCenter;
        secondLabel.font=kFont6px(24);
        secondLabel.textColor=tarbarrossred;
        secondLabel.text = @"";
        [_tabheadview addSubview:self.timeRawardLab = secondLabel];
        

        UIButton *thirdLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        thirdLabel.frame = CGRectMake(ZOOM6(20),CGRectGetMaxY(secondLabel.frame)+ZOOM6(30), kScreen_Width-2*ZOOM6(20), ZOOM6(90));
        [thirdLabel setTitle:@"去提现" forState:UIControlStateNormal];
        thirdLabel.titleLabel.font=kFont6px(36);
        thirdLabel.titleLabel.textColor = kWiteColor;
        thirdLabel.clipsToBounds = YES;
        thirdLabel.layer.cornerRadius = 5;
        thirdLabel.backgroundColor = tarbarrossred;
        [thirdLabel addTarget:self action:@selector(gotixian:) forControlEvents:UIControlEventTouchUpInside];
        [_tabheadview addSubview:thirdLabel];
        
        
        UILabel *fourLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(thirdLabel.frame)+ZOOM6(40), kScreen_Width/3, ZOOM6(50))];
        fourLabel.textAlignment=NSTextAlignmentCenter;
        fourLabel.font=kFont6px(36);
        fourLabel.textColor=kYellowColor;
        NSString * str = @"0";
        NSString *str1 = [NSString stringWithFormat:@"%@元",str];
        [fourLabel setAttributedText:[NSString getOneColorInLabel:str1 strs:@[str] Color:kYellowColor fontSize:ZOOM6(48)]];
        [_tabheadview addSubview:self.todayRawardLab =fourLabel];
        
        UILabel *fiveLabel=[[UILabel alloc]initWithFrame:CGRectMake(fourLabel.x,CGRectGetMaxY(fourLabel.frame)+ZOOM6(10), fourLabel.width, ZOOM6(40))];
        fiveLabel.textAlignment=NSTextAlignmentCenter;
        fiveLabel.font=kFont6px(36);
        fiveLabel.text=@"今日收益";
        fiveLabel.textColor=kYellowColor;
        [_tabheadview addSubview:fiveLabel];
        
        UILabel *middleline = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/3, CGRectGetMaxY(thirdLabel.frame)+ZOOM6(70), 1, ZOOM6(60))];
        middleline.backgroundColor = kYellowColor;
        [_tabheadview addSubview:middleline];
        
        UILabel *sixLabel=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/3,CGRectGetMaxY(thirdLabel.frame)+ZOOM6(40), kScreen_Width/3, ZOOM6(50))];
        sixLabel.textAlignment=NSTextAlignmentCenter;
        sixLabel.font=kFont6px(36);
        sixLabel.textColor=kYellowColor;
        NSString * sixstr = @"0";
        NSString *sixstr1 = [NSString stringWithFormat:@"%@元",sixstr];
        [sixLabel setAttributedText:[NSString getOneColorInLabel:sixstr1 strs:@[sixstr] Color:kYellowColor fontSize:ZOOM6(48)]];
        [_tabheadview addSubview:self.yesdayRawardLab =sixLabel];
        
        UILabel *sevenLabel=[[UILabel alloc]initWithFrame:CGRectMake(sixLabel.x,CGRectGetMaxY(fourLabel.frame)+ZOOM6(10), sixLabel.width, ZOOM6(40))];
        sevenLabel.textAlignment=NSTextAlignmentCenter;
        sevenLabel.font=kFont6px(36);
        sevenLabel.text=@"昨日收益";
        sevenLabel.textColor=kYellowColor;
        [_tabheadview addSubview:sevenLabel];
        
        UILabel *middleline1 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/3*2, CGRectGetMaxY(thirdLabel.frame)+ZOOM6(70), 1, ZOOM6(60))];
        middleline1.backgroundColor = kYellowColor;
        [_tabheadview addSubview:middleline1];
        
        UILabel *eightLabel=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/3*2,CGRectGetMaxY(thirdLabel.frame)+ZOOM6(40), kScreenWidth/3, ZOOM6(50))];
        eightLabel.textAlignment=NSTextAlignmentCenter;
        eightLabel.font=kFont6px(36);
        eightLabel.textColor=kYellowColor;
        NSString * eigstr = @"0";
        NSString *eigstr1 = [NSString stringWithFormat:@"%@人",eigstr];
        [eightLabel setAttributedText:[NSString getOneColorInLabel:eigstr1 strs:@[eigstr] Color:kYellowColor fontSize:ZOOM6(48)]];
        [_tabheadview addSubview:self.numberRawardLab =eightLabel];
        
        UILabel *nineLabel=[[UILabel alloc]initWithFrame:CGRectMake(eightLabel.x,CGRectGetMaxY(fourLabel.frame)+ZOOM6(10), eightLabel.width, ZOOM6(40))];
        nineLabel.textAlignment=NSTextAlignmentCenter;
        nineLabel.font=kFont6px(36);
        nineLabel.text=@"好友数";
        nineLabel.textColor=kYellowColor;
        [_tabheadview addSubview:nineLabel];
        
        
        UILabel *spaceline = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(sevenLabel.frame)+ZOOM6(40), kScreenWidth, ZOOM6(20))];
        spaceline.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_tabheadview addSubview:spaceline];
        
        UILabel *bottomlab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(spaceline.frame)+ZOOM6(40), kScreenWidth, ZOOM6(40))];
        bottomlab.text = @"好友奖励明细";
        bottomlab.font = [UIFont systemFontOfSize:ZOOM6(36)];
        bottomlab.textAlignment = NSTextAlignmentCenter;
        bottomlab.textColor = RGBCOLOR_I(62, 62, 62);
        [_tabheadview addSubview:bottomlab];
        
        UILabel *bottomline = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_tabheadview.frame)-1, kScreenWidth, 1)];
        bottomline.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_tabheadview addSubview:bottomline];
        
    }
    return _tabheadview;
}
- (void)refreshUI
{
    self.totalRawardLab.text = [NSString stringWithFormat:@"%@",self.rawardModel.ext_money];
    
    if(self.rawardModel.ext_money.floatValue >0 && self.rawardModel.is_vip.integerValue != 1 && self.rawardModel.ext_time.integerValue >0)
    {
        self.timeRawardLab.text = [NSString stringWithFormat:@"（非会员%@日后收益清0）",self.rawardModel.ext_time];
    }
    NSString * str = [NSString stringWithFormat:@"%@",self.rawardModel.ext_now];
    NSString *str1 = [NSString stringWithFormat:@"%@元",str];
    [self.todayRawardLab setAttributedText:[NSString getOneColorInLabel:str1 strs:@[str] Color:kYellowColor fontSize:ZOOM6(48)]];
    
    NSString * str2 = [NSString stringWithFormat:@"%@",self.rawardModel.ext_yet];
    NSString *str22 = [NSString stringWithFormat:@"%@元",str2];
    [self.yesdayRawardLab setAttributedText:[NSString getOneColorInLabel:str22 strs:@[str2] Color:kYellowColor fontSize:ZOOM6(48)]];
    
    NSString * str3 = [NSString stringWithFormat:@"%@",self.rawardModel.ext_num];
    NSString *str33 = [NSString stringWithFormat:@"%@人",str3];
    [self.numberRawardLab setAttributedText:[NSString getOneColorInLabel:str33 strs:@[str3] Color:kYellowColor fontSize:ZOOM6(48)]];
    
}

- (void)creatTableView
{
    self.mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar+kUnderStatusBarStartY) style:UITableViewStylePlain];
    self.mytableview.dataSource=self;
    self.mytableview.delegate=self;
    self.mytableview.rowHeight=80;
    self.mytableview.tableHeaderView = self.tabheadview;
    self.mytableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mytableview];
    
    [self.mytableview registerNib:[UINib nibWithNibName:@"memberRawardTableViewCell" bundle:nil] forCellReuseIdentifier:@"memberRawardCell" ];
    
    kWeakSelf(self);
    [self.mytableview addHeaderWithCallback:^{
        currentPage = 1;
        
        [weakself.mydataArray removeAllObjects];
        
        [weakself httpGetRewardList:YES];
    }];
    
    [self.mytableview addFooterWithCallback:^{
        
        [weakself httpGetRewardList:YES];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.mydataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    static NSString *identifier=@"memberRawardCell";
    memberRawardTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell=[[memberRawardTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    kWeakSelf(self);
    cell.shareClickBlock = ^{
        [weakself invitshare];
    };
    rawardsFriendsModel *model = self.mydataArray[indexPath.row];
    [cell refreshData:model];
    return cell;
}
- (void)invitshare
{
    NSString *user_id = [[NSUserDefaults standardUserDefaults]objectForKey:USER_ID];
    MiniShareManager *minishare = [MiniShareManager share];
    
    NSString *image = self.sharePic;
    NSString *title = self.shareTitle;
    NSString *path  = [NSString stringWithFormat:@"/pages/shouye/shouye?isShareFlag=true&user_id=%@",user_id];
    
    minishare.delegate = self;
    [minishare shareAppWithType:MINIShareTypeWeixiSession Image:image Title:title Discription:nil WithSharePath:path];
}

#pragma mark *************小程序分享****************
//小程序分享回调
- (void)MinihareManagerStatus:(MINISHARESTATE)shareStatus withType:(NSString *)type
{
    [MBProgressHUD hideHUDForView:self.view];
    
    NSString *sstt = @"";
    switch (shareStatus) {
        case MINISTATE_SUCCESS:
            sstt = @"分享成功";
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
    
    NavgationbarView *mentionview = [[NavgationbarView alloc]init];
    [mentionview showLable:sstt Controller:self];
}
- (void)gotixian:(UIButton*)sender
{
    TFWithdrawCashViewController *cash = [[TFWithdrawCashViewController alloc]init];
    [self.navigationController pushViewController:cash animated:YES];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray*)mydataArray
{
    if(_mydataArray == nil)
    {
        _mydataArray = [NSMutableArray array];
    }
    return _mydataArray;
}
- (memberRawardsModel*)rawardModel
{
    if(_rawardModel == nil)
    {
        _rawardModel = [memberRawardsModel alloc];
    }
    return _rawardModel;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
