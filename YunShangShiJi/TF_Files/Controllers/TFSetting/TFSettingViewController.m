//
//  TFSettingViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/6/30.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFSettingViewController.h"
#import "TFCellView.h"
#import "TFMyInformationViewController.h"
#import "TFAccountSafeViewController.h"
#import "TFGeneralViewController.h"
#import "TFAboutViewController.h"
#import "LoginViewController.h"
//#import "ChatViewController.h"
#import "RobotManager.h"
#import "HYJGuideView.h"
//#import "ChatListViewController.h"
#import "WXApi.h"
#import "TFIndianaRecordViewController.h"
#import "DistributionRegistViewController.h"
#import "TFIncomeStatisticsViewController.h"
#import "TFBusinessCategoryViewController.h"

#import "DBCenterViewController.h"
#import "TFSalePurchaseViewController.h"
#import "SettingCell.h"
#import "TFHelpCenterViewController.h"
#import <RongIMKit/RongIMKit.h>

#import "TFExpViewController.h"
#import "TFLedBrowseShopViewController.h"
#import "TFShareRewardDetailVC.h"
#import "GoldCouponsManager.h"

#import "TFIntimateCircleVC.h"

@interface TFSettingViewController () <UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;   /**< tableView */
@property (nonatomic, strong)NSMutableArray *dataSourceArray; /**< 数据源 */

@end

@implementation TFSettingViewController

- (void)dealloc
{
    MyLog(@"%@ release", [self class]);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    NSMutableArray *p = [[NSMutableArray alloc] initWithObjects:@"S1",@"S14",@"S3",@"S4",@"S12",@"S6",@"S7",@"S8",@"S9",@"S10",@"S11",@"S5",@"S13",@"S2",nil];
    
//    NSComparator comp =  ^(id obj1, id obj2){
//        if ([obj1 integerValue] > [obj2 integerValue]) {
//            return (NSComparisonResult)NSOrderedDescending;
//        }
//        if ([obj1 integerValue] < [obj2 integerValue]) {
//            return (NSComparisonResult)NSOrderedAscending;
//        }
//        return (NSComparisonResult)NSOrderedSame;
//    };
    
//    [p sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        NSString *a = (NSString *)obj1;
//        NSString *b = (NSString *)obj2;
//        int aNum = [[a substringFromIndex:1] intValue];
//        int bNum = [[b substringFromIndex:1] intValue];
//        if (aNum > bNum) {
//            return NSOrderedDescending;
//        }
//        else if (aNum < bNum){
//            return NSOrderedAscending;
//        }
//        else {
//            return NSOrderedSame;
//        }
//    }];
//    NSLog(@"p %@", p);
    
    [super setNavigationItemLeft:@"设置"];
    
    [self setupUI];
    
    
    [self addVCTestGesture];
    
//    MyLog(@"%@",  [[UIDevice currentDevice] model]);
}

- (void)setupUI{

    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    [self setFootView];
}
-(void)setFootView{
    CGFloat H_footView = ZOOM(180);
    UIView *footview=[[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-H_footView, kScreenWidth, H_footView)];
    UIButton *exitbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    exitbutton.frame=CGRectMake(ZOOM6(30), (H_footView-ZOOM(130))/2, kScreenWidth- 2*ZOOM6(30), ZOOM(130));
    [exitbutton setTitle:@"退出当前帐号" forState:UIControlStateNormal];
    exitbutton.titleLabel.font= [UIFont systemFontOfSize:ZOOM(50)];
//    exitbutton.backgroundColor= [UIColor blackColor];
    [exitbutton setBackgroundImage:[UIImage imageWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    [exitbutton setBackgroundImage:[UIImage imageWithColor:RGBCOLOR_I(229, 229, 229)] forState:UIControlStateHighlighted];
    exitbutton.tintColor=[UIColor whiteColor];
    [exitbutton addTarget:self action:@selector(exit:) forControlEvents:UIControlEventTouchUpInside];
    [footview addSubview:exitbutton];
    [self.view addSubview:footview];
}
#pragma mark - tableView
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7, kScreenWidth, kScreenHeight-kNavigationheightForIOS7-ZOOM6(180))];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerNib:[UINib nibWithNibName:@"SettingCell" bundle:nil] forCellReuseIdentifier:@"SETTINGCELLID"];
//        _tableView.backgroundColor = COLOR_ROSERED;
        _tableView.tableFooterView = [[UIView alloc] init];

    }
    return _tableView;
}
#pragma mark 退出当前帐号
-(void)exit:(UIButton*)sender
{
    [self HttpLogout];
}
#pragma mark - dataSource
- (NSMutableArray *)dataSourceArray
{
    if (_dataSourceArray == nil) {
        NSArray *titleArr = [NSArray arrayWithObjects:
//                                                    @"个人资料",
                                                    @"账号与安全",
                                                    @"通用",
                                                    @"关于",
                                                    @"给衣蝠打分",@"帮助中心", nil];
        _dataSourceArray = [NSMutableArray arrayWithArray:titleArr];
    }
    return _dataSourceArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSourceArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ZOOM(172);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SETTINGCELLID"];
    
    NSString *st = self.dataSourceArray[indexPath.row];
    cell.headImageView.image = [UIImage imageNamed:st];
    cell.titleLabel.text = st;
    
    cell.M_l_headImageView.constant = ZOOM(62);
    cell.W_H_headImageView.constant = ZOOM(100);
    cell.M_l_titleLabel.constant = cell.W_H_headImageView.constant+cell.M_l_headImageView.constant*2;
    
    cell.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
//    cell.contentView.backgroundColor = COLOR_RANDOM;
//    if (indexPath.row==self.dataSourceArray.count-1) {
//        cell.accessoryType=UITableViewCellAccessoryNone;
//    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
//        case 0: {
//            TFMyInformationViewController *tmvc = [[TFMyInformationViewController alloc] init];
//            [self.navigationController pushViewController:tmvc animated:YES];
//
//        }
//            break;
        case 0: {
            TFAccountSafeViewController *tasvc = [[TFAccountSafeViewController alloc] init];
            [self.navigationController pushViewController:tasvc animated:YES];
        }
            break;
        case 1: {
            TFGeneralViewController *tgvc = [[TFGeneralViewController alloc] init];
            [self.navigationController pushViewController:tgvc animated:YES];
        }
            break;
        case 2: {
            TFAboutViewController *tavc = [[TFAboutViewController alloc] init];
            [self.navigationController pushViewController:tavc animated:YES];
        }
            break;
        case 3: {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1029741842"]];
        }
            break;
        case 4:{
                TFHelpCenterViewController *help=[[TFHelpCenterViewController alloc]init];
                help.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:help animated:YES];
            }
            break;
        default:
            break;
    }
}

-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}


#pragma mark 网络注销登录
-(void)HttpLogout
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paramaters=[NSMutableDictionary dictionary];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    NSString *url=[NSString stringWithFormat:@"%@user/loginout?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL=[MyMD5 authkey:url];
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    [manager POST:URL parameters:paramaters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            //responseObject is %@",responseObject[@"message"]);
            NSString *str = responseObject[@"status"];
            if(str.intValue==1)//正常退出
            {
                [user removeObjectForKey:UNION_ID];
                [user removeObjectForKey:USER_TOKEN];
                [user removeObjectForKey:USER_PHONE];
                [user removeObjectForKey:USER_REALM];
                [user removeObjectForKey:STORE_CODE];
                [user removeObjectForKey:USER_AllCount];
                [user removeObjectForKey:OTHER_PASSWORD];
                [user removeObjectForKey:PYSUCCESS];
                [user removeObjectForKey:@"NumbermarkTag"];
                [user removeObjectForKey:BROWSEDATE];
                [user removeObjectForKey:SECRETDATE];
                [user removeObjectForKey:VALITYDATE];
                [user removeObjectForKey:ShareCount];
                [user removeObjectForKey:FIRST_SHARE];
                [user removeObjectForKey:TASK_ADD_SHOPCART];
                [user removeObjectForKey:TASK_LIULAN_LASTTIME];
                [user removeObjectForKey:TASK_LIULAN_TOPIC];
                [user removeObjectForKey:FIRSTCOMING];
                [user removeObjectForKey:RAWARD_UP];
                [user removeObjectForKey:RECOMMENDDATE];
                [user removeObjectForKey:CRAZYMonday];
                [user removeObjectForKey:@"is_read"];
                [user removeObjectForKey:RECOMMENDBROWSEDATA];
                [user removeObjectForKey:ZEROSHOPPINGMENTION];
                [user removeObjectForKey:ZEROSHOPPINGHOMEMENTION];
                [user removeObjectForKey:ZEROSHOPPINGLUCKMENTION];
                [user removeObjectForKey:ZEROSHOPPINGTASKMENTION];
                [MBProgressHUD showSuccess:@"退出成功"];
                
//                [self reloadSecretFriendViewController];

//                [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:NO completion:^(NSDictionary *info, EMError *error) {
//                    if (!error) {
//                        //退出成功");
//                    }
//                } onQueue:nil];
                
                [[RCIM sharedRCIM] logout];
                [DataManager sharedManager].isRongCloubLogin = NO;
                [DataManager sharedManager].isOligible = NO;
                [DataManager sharedManager].isOpen = NO;
                [DataManager sharedManager].grade = 0;
                [Signmanager SignManarer].signChange = NO;
                [Signmanager SignManarer].addShopCart = NO;
                [GoldCouponsManager goldcpManager].gold_is_open = NO;
                [GoldCouponsManager goldcpManager].is_open = NO;
                [GoldCouponsManager goldcpManager].gold_end_date = 0;
                [GoldCouponsManager goldcpManager].goldcp_end_date = 0;
                [DataManager sharedManager].endDate = 0;
                
                [Signmanager SignManarer].addShopCart = NO;
                [Signmanager SignManarer].share_isFinish = NO;
                [Signmanager SignManarer].task_isfinish = NO;
                [Signmanager SignManarer].shareTixianCount = 0;
                [Signmanager SignManarer].liulanTixianCount = 0;
                
                [user removeObjectForKey:RongCloub_Token];
                [self performSelector:@selector(login) withObject:nil afterDelay:0.25];
                
            } else{//退出失败
                [MBProgressHUD showError:responseObject[@"message"]];
            }
            [MBProgressHUD hideHUDForView:self.view];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
    }];
}
#pragma mark - 退出账户
- (void)signOutBtnClick
{

    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];  //读出用户token
//    NSString *uID=[user objectForKey:USER_ID];
//    NSString *usertype=[user objectForKey:USER_TYPE];
    NSString *urlStr ;
    if (token!=nil) { //是否登陆状态
        [MBProgressHUD showSuccess:@"正在退出,请稍后"];
        //退出账号 进行网络请求（get请求）
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        //先读出用户token
        
//        if(!uID)//自己的登录方式
//        {
//            urlStr=[NSString stringWithFormat:@"%@user/logout?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
//        }else{  //第三方登录
//            urlStr=[NSString stringWithFormat:@"%@user/userLoginout?version=%@&uid=%@&token=%@&usertype=%d",[NSObject baseURLStr],VERSION,uID,token,usertype.intValue];
//        }
        
        urlStr=[NSString stringWithFormat:@"%@user/loginout?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
        NSString *URL=[MyMD5 authkey:urlStr];   //MD5加密
        [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            responseObject = [NSDictionary changeType:responseObject];
            if (responseObject!=nil) {
                NSString *status = responseObject[@"status"];
                if(status.intValue==1)//正常退出
                {
                    [MBProgressHUD hideHUDForView:self.view];
                    [MBProgressHUD showSuccess:@"退出成功,转向登录页"];
                    [self performSelector:@selector(login) withObject:nil afterDelay:1.5];
                } else {
                    [MBProgressHUD hideHUDForView:self.view];
                    [MBProgressHUD showError:responseObject[@"message"]];
                }

            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view];
//            [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
            
        }];
    } else { //没有登陆
        [MBProgressHUD showError:@"没有登陆用户,请登录"];
        [self performSelector:@selector(login) withObject:nil afterDelay:1.5];
    }
}
#pragma mark -转向登陆页面
- (void)login
{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *User_id = [ud objectForKey:USER_ID];
    [ud removeObjectForKey:RongCloub_Token];
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
    //删除头像
    NSString *aPath=[NSString stringWithFormat:@"%@/Documents/headImgae%@.png",NSHomeDirectory(),User_id];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:aPath error:nil];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    //回到登陆页面
    
    [Login doLogout];
   
    LoginViewController *login=[[LoginViewController alloc]init];
    login.tag= 1000;
    [self.navigationController pushViewController:login animated:YES];

}


- (void)rightBarButtonClick
{
    [self Message];
    
}

#pragma mark 消息盒子
-(void)Message
{
    //begin 赵官林 2016.5.26 跳转到消息列表
    [self presentChatList];
    //end
    
}


- (void)addVCTestGesture
{
    UIView *changeBaseURLView = [UIView new];
    
    if (My_DEBUG) {
        [self.view addSubview:changeBaseURLView];
    }
    
    changeBaseURLView.backgroundColor = [UIColor clearColor];
    ESWeakSelf;
    [changeBaseURLView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(__weakSelf.view).offset(20);
    //    make.right.equalTo(__weakSelf.view);
        make.centerX.equalTo(__weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(80, 44));
    }];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRClick:)];
    tapGR.numberOfTapsRequired = 3; //3下
    [changeBaseURLView addGestureRecognizer:tapGR];
}

- (void)tapGRClick:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateRecognized) {
        
        TFExpViewController *testVC = [[TFExpViewController alloc] init];
//        TFLedBrowseShopViewController *testVC = [[TFLedBrowseShopViewController alloc] init];
//        TFShareRewardDetailVC *testVC = [[TFShareRewardDetailVC alloc] init];
        [self.navigationController pushViewController:testVC animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
