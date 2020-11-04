//
//  TFVoiceRedViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 16/3/29.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFVoiceRedViewController.h"
#import "SettingCell.h"
#import "TFMeSendRedViewController.h"
#import "TFAlreadySendRedViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
//#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <QZoneConnection/ISSQZoneApp.h>
#import "WXApi.h"
#import "AppDelegate.h"
#import "DShareManager.h"

@interface TFVoiceRedViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSourceArray;

@property (nonatomic, copy)NSString *unionid;


@end

@implementation TFVoiceRedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setNavigationItemLeft:@"语音红包"];
    // Do any additional setup after loading the view.
    [self httpWXUid];
    
    [self createNewUI];
}

- (void)createNewUI{
    
    [self.view addSubview:self.tableView];
    
    [self.tableView reloadData];
}

#pragma mark - tableView
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7, kScreenWidth, kScreenHeight-kNavigationheightForIOS7)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerNib:[UINib nibWithNibName:@"SettingCell" bundle:nil] forCellReuseIdentifier:@"SETTINGCELLID"];
        //        _tableView.backgroundColor = COLOR_ROSERED;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

#pragma mark - dataSource
- (NSMutableArray *)dataSourceArray
{
    if (_dataSourceArray == nil) {
        NSArray *titleArr = [NSArray arrayWithObjects:
                             @"我要发红包",
                             @"已发的红包", nil];
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
    cell.Aspect_headImageView.constant = 37/45;
    cell.M_l_titleLabel.constant = cell.W_H_headImageView.constant+cell.M_l_headImageView.constant*2;
    
    cell.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, ZOOM(62), 0, 0)];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, ZOOM(62), 0, 0)];
    }
    //    cell.contentView.backgroundColor = COLOR_RANDOM;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    switch (indexPath.row) {
        case 0: {
            
            if (self.unionid.length!=0) {
                TFMeSendRedViewController *trdVC = [[TFMeSendRedViewController alloc] init];
                trdVC.unionid = self.unionid;
                [self.navigationController pushViewController:trdVC animated:YES];
            } else {
                
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
                    [self shareSdkWithAutohorWithTypeGetOpenID:0];

                } else {
                    NavgationbarView *nv = [[NavgationbarView alloc] init];
                    [nv showLable:@"请安装微信,再重新尝试" Controller:self];
                }
            }
        }
            break;
        case 1: {
            
            
            if (self.unionid.length!=0) {
                TFAlreadySendRedViewController *tasVC = [[TFAlreadySendRedViewController alloc] init];
                tasVC.unionid = self.unionid;
                [self.navigationController pushViewController: tasVC animated:YES];
            } else {
                
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
                    [self shareSdkWithAutohorWithTypeGetOpenID:1];
                    
                } else {
                    NavgationbarView *nv = [[NavgationbarView alloc] init];
                    [nv showLable:@"请先安装微信,再重新尝试" Controller:self];
                }
            }
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

- (void)httpWXUid
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    //http://{ip:port}/{proeject}/redPacket/haveUid?
    NSString *urlStr = [NSString stringWithFormat:@"%@redPacket/haveUid?token=%@&version=%@", [NSObject baseURLStr], token, VERSION];
    
    NSString *URL = [MyMD5 authkey:urlStr];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //微信uid = %@", responseObject);
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                if ([responseObject[@"flag"] intValue] == 1) {
                    self.unionid = [NSString stringWithFormat:@"%@",responseObject[@"uid"]];
                    
                }
            } else {
                NavgationbarView *nv = [[NavgationbarView alloc] init];
                [nv showLable:responseObject[@"message"] Controller:self];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
    }];
}

- (void)shareSdkWithAutohorWithTypeGetOpenID:(NSInteger)index
{
    //向微信注册
//    [WXApi registerApp:@"wx8c5fe3e40669c535" withDescription:@"demo 2.0"];
    
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
    
    [ShareSDK getUserInfoWithType:ShareTypeWeixiFav
                      authOptions:authOptions
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                               if (result) {
                                   
                                   //uid = %@", [userInfo uid]);
                                   //sourceData = %@", [userInfo sourceData]);
                                   //extInfo = %@", [[userInfo credential] extInfo]);
                                   
                                   //[userInfo nickname] = %@", [userInfo nickname]);
                                   //[userInfo profileImage] = %@", [userInfo profileImage]);
                                   
                                   
                                   if ([userInfo nickname] == nil || [userInfo uid] == nil || [userInfo profileImage] == nil) {
                                       NavgationbarView *nv = [[NavgationbarView alloc] init];
                                       [nv showLable:@"请允许获取您的公开信息,再重新尝试" Controller:self];
                                       return;
                                   } else {
                                   
                                       NSString *nickName = [NSString stringWithFormat:@"%@",[userInfo nickname]];
                                       NSString *headImgUrl = [NSString stringWithFormat:@"%@", [userInfo profileImage]];
                                       
                                       NSString *WXuid = [userInfo uid];
                                       
                                       NSString *unionid = [NSString stringWithFormat:@"%@",[userInfo sourceData][@"unionid"]];
                                       
                                       //sourceData = %@", [userInfo sourceData]);
                                       

                                       
                                       [self httpSendOutOpenIDWithNickName:nickName andPic:headImgUrl andWXUid:WXuid andWXunionid:unionid andIndex:index];
                                   }
                                   
                               }
                               
                               NSString *errorStr = [NSString stringWithFormat:@"%@", [error errorDescription]];
                               if ([errorStr isEqualToString:@"尚未授权"]) {
                                   
                                   //失败,错误码:%ld,错误描述%@",(long)[error errorCode],[error errorDescription]);
                                   
                               }
                               
    }];
    
}


- (void)httpSendOutOpenIDWithNickName:(NSString *)name andPic:(NSString *)pic andWXUid:(NSString *)wxUid andWXunionid:(NSString *)unionid andIndex:(NSInteger)index
{
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *token = [ud objectForKey:USER_TOKEN];
        
        //http://{ip:port}/{proeject}/
        NSString *urlStr = [NSString stringWithFormat:@"%@redPacket/weiXinRedPacketToken?token=%@&version=%@&uid=%@&nickname=%@&pic=%@&unionid=%@",[NSObject baseURLStr],token,VERSION,wxUid,name,pic, unionid];
        
        NSString *URL = [MyMD5 authkey:urlStr];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //传openID = %@", responseObject);
            responseObject = [NSDictionary changeType:responseObject];
            if (responseObject!=nil) {
                if ([responseObject[@"status"] intValue] == 1) {
                    
                    self.unionid = unionid;
                    
                    if (index == 0) {
                        TFMeSendRedViewController *trdVC = [[TFMeSendRedViewController alloc] init];
                        trdVC.unionid = self.unionid;
                        [self.navigationController pushViewController:trdVC animated:YES];
                    } else {
                        TFAlreadySendRedViewController *tasVC = [[TFAlreadySendRedViewController alloc] init];
                        tasVC.unionid = self.unionid;
                        [self.navigationController pushViewController: tasVC animated:YES];
                    }
                } else {
                    self.unionid = nil;
                    
                    NavgationbarView *nv = [[NavgationbarView alloc] init];
                    [nv showLable:responseObject[@"message"] Controller:self];
                }
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
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
