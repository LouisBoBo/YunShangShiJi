//
//  TFMyWalletViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/6.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFMyWalletViewController.h"
#import "TFCellView.h"
#import "TFSaleManagementViewController.h"
#import "TFAccountDetailsViewController.h"
#import "TFSetPaymentPasswordViewController.h"
#import "TFMyBankCardViewController.h"
#import "TFWithdrawCashViewController.h"
#import "TFChangePaymentPasswordViewController.h"
#import "TFMyCardViewController.h"
//#import "ChatViewController.h"
#import "RobotManager.h"
//#import "ChatListViewController.h"
#import "InvitCodeViewController.h"
#import "MyWalletHeaderView.h"
#import "TFPopBackgroundView.h"
#import "YFDoubleSucessVC.h"
#import "SettingCell.h"
#import "DoubleModel.h"
#import "ShopCarCountModel.h"
#import "NSDate+Helper.h"
#import "NavgationbarView.h"
#import "LuckdrawViewController.h"
#import "MemberRawardsViewController.h"
#import "CFPopView.h"
#import "VitalityModel.h"
#import "CFInviteFriendsRewardVC.h"
#import "CollectionViewController.h"
#import "NewSpecialViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <QZoneConnection/ISSQZoneApp.h>
#import "AppDelegate.h"

@interface TFMyWalletViewController () <UITableViewDataSource, UITableViewDelegate> {
    NSTimer *_timer; //计时器
    NSInteger _timeout;
}

@property (nonatomic, strong) MyWalletHeaderView *heardView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;

@property (nonatomic, strong) NSString *cardString;
@property (nonatomic, strong) FinishTaskPopview *bonusview;
@property (nonatomic ,strong) UILabel *balanceLabel;
@property (nonatomic, strong) UILabel *cardLabel;
@property (nonatomic, strong) UIScrollView *backgroundScrollView;
@property (nonatomic, strong) UIButton *withdrawCashBtn;
@end

@implementation TFMyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super setNavigationItemLeft:@"我的钱包"];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, Height_NavBar-1, kScreenWidth, 1)];
    lineView.backgroundColor = lineGreyColor;
    [self.view addSubview:lineView];
    
    self.type = TFMyWallet;

    [self setupUI];


}
- (void)toBindWXView {
    TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] init];
    popView.showCancelBtn = YES;
    popView.rightText = @"现在授权并绑定微信账户";
    popView.title = @"提示";
    popView.isManualDismiss = YES;

    UIView *contentV = [[UIView alloc] init];
    popView.contentView = contentV;

    UILabel *contentLabel = [UILabel new];
    NSString *text = @"系统检测到你尚未绑定微信提现账户，微信授权后即可绑定。提现款项将直接打入你绑定的微信提现账户";
    contentLabel.textColor = RGBCOLOR_I(125, 125, 125);
    contentLabel.font = kFont6px(28);
    contentLabel.numberOfLines = 0;
    contentLabel.text = text;
    [contentV addSubview:contentLabel];
//    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.bottom.equalTo(contentV);
//    }];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(contentV);
    }];

    UITextField *nameTextField = [[UITextField alloc] init];
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    nameTextField.placeholder = @"姓名（必须填写本人真实姓名）";
    nameTextField.font = kFont6px(28);
    [contentV addSubview:nameTextField];
    [nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentLabel.mas_bottom).offset(ZOOM6(20));
        make.left.right.equalTo(contentV);
        make.height.mas_equalTo(ZOOM6(85));
        make.bottom.equalTo(contentV.mas_bottom);
    }];
    
    [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(popView.contentViewWidth);
    }];
    [contentV setNeedsLayout];

    [popView showCancelBlock:^{

    } withConfirmBlock:^{
        NSString *nameText = nameTextField.text;
        if (nameText.length == 0) {
            [MBProgressHUD show:@"输入姓名才能绑定" icon:nil view:nil];
            return;
        }
        if (nameText.length != [self getlongthnum:nameText]) {
            [MBProgressHUD show:@"姓名有误，请重新输入" icon:nil view:nil];
            return;
        }
        [self shareSdkWithAutohorWithTypeGetOpenID:nameText];
//        [self httpSendNameAndIdenf:nameText idenf:idenfText];
        [popView dismissAlert:YES];
    } withNoOperationBlock:^{
        [nameTextField resignFirstResponder];
    } withCloseBlock:^{
        [popView dismissAlert:YES];
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSString *popcount = [[NSUserDefaults standardUserDefaults]objectForKey:WALLET_POPUP];

    NSDate *date = [[NSUserDefaults standardUserDefaults]objectForKey:@"getWXOpenID"];
    if (self.is_guide) {
//        [self toBindWXView];
    }else if (![[MyMD5 compareDate:date]isEqualToString:@"今天"]) {
        [self httpGetWXOpenID];
    }else if(popcount.intValue <1)
    {
        [self discription];
        popcount = [NSString stringWithFormat:@"%d",popcount.intValue+1];
        [[NSUserDefaults standardUserDefaults] setObject:popcount forKey:WALLET_POPUP];
    }
}

#pragma mark 额度说明
- (void)discription
{
    CFPopView *view=[[CFPopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) textStr:@"提现额度说明" leftBtnStr:@"知道了"  rightBtnStr:@"抽提现额度" popType:CFPopTypeWhite];
    
    [view show];
    [view setLeftBlock:^{
        
    } withRightBlock:^{
        
        LuckdrawViewController *VC = [[LuckdrawViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }];
}

- (void)setupUI{
    
    self.cardString = @"0张";
    _timeout = 0;
    [self.view addSubview:self.tableView];
    
    [self.tableView reloadData];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"提现" forState:UIControlStateNormal];
//    [self.navigationView addSubview:_withdrawCashBtn = btn];
    [btn addTarget:self action:@selector(withdrawCashBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:COLOR_ROSERED forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    ESWeak(self, weakSelf);
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(weakSelf.navigationView).offset(10);
//        make.right.equalTo(weakSelf.navigationView.mas_right).offset(-5);
//        make.size.mas_equalTo(CGSizeMake(80, 44));
//    }];
    
    UIButton *adddrawCashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [adddrawCashBtn setTitle:@"增加提现额度" forState:UIControlStateNormal];
    [adddrawCashBtn setTitleColor:RGBCOLOR_I(125, 125, 125) forState:UIControlStateNormal];
    adddrawCashBtn.titleLabel.font = kFont6px(32);
    [adddrawCashBtn handleClickEvent:UIControlEventTouchUpInside withClickBlock:^(UIButton *sender) {
        MyLog(@"增加提现额度");
        MemberRawardsViewController *VC = [[MemberRawardsViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
        
//        [self setTaskPopMindView:Balance_notEnough Value:nil Title:nil Rewardvalue:nil Rewardnum:0];
    }];
    [self.navigationView addSubview:adddrawCashBtn];
    [adddrawCashBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.navigationView.mas_right).offset(-10);
        make.height.mas_equalTo(44);
        make.centerY.equalTo(self.navigationView.mas_centerY).offset(10);
    }];
}

- (void)setTaskPopMindView:(TaskPopType)type Value:(NSString*)value Title:(NSString*)title Rewardvalue:(NSString*)rewardValue Rewardnum:(int)num
{
    if(self.bonusview)
    {
        [self.bonusview removeFromSuperview];
        self.bonusview = nil;
    }
    
    self.bonusview = [[FinishTaskPopview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) TaskType:type TaskValue:value Title:title RewardValue:rewardValue RewardNumber:num Rewardtype:nil];
    
    kSelfWeak;
    self.bonusview.tapHideMindBlock = ^{
        [weakSelf.bonusview remindViewHiden];
    };
    
    self.bonusview.balanceHideMindBlock = ^(NSInteger tag){
        
        [weakSelf balanceGotoview:tag];
    };
    
    [self.view addSubview:self.bonusview];
}

- (void)balanceGotoview:(NSInteger)tag
{
    if(tag == 10000)//超级分享日
    {
        CFInviteFriendsRewardVC *friend = [[CFInviteFriendsRewardVC alloc]init];
        [self.navigationController pushViewController:friend animated:YES];
    }else if (tag == 10001)//赚钱任务页
    {
        MakeMoneyViewController *vc = [[MakeMoneyViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (tag == 10002)//APP首页
    {
        Mtarbar.selectedIndex=0;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{//特价商品列表页
        
        NewSpecialViewController *subVC = [[NewSpecialViewController alloc] init];
        [self.navigationController pushViewController:subVC animated:YES];
    }
}
- (void)withdrawCashBtnClick:(UIButton *)sender
{
    NSString *usertype = [[NSUserDefaults standardUserDefaults] objectForKey:USER_CLASSIFY];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    if([usertype isEqualToString:@"0"]||[usertype isEqualToString:@"1"]||[usertype isEqualToString:@"2"])//提现引导
    {
        if(token.length > 8)
        {
//            [self popViewWithDrawCashGuide];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_CLASSIFY];
            
            [VitalityModel posguide:^(id data) {//弹了引导弹框告诉后台
                
            }];
            
            TFWithdrawCashViewController *VC = [[TFWithdrawCashViewController alloc] init];
            VC.bindNameAndIdenfBlock = ^(NSInteger sguidance) {
                
            };
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
    }else {
        TFWithdrawCashViewController *twvc = [[TFWithdrawCashViewController alloc] init];
        twvc.type = TFMyWallet;
        [self.navigationController pushViewController:twvc animated:YES];
    }
}
#pragma mark 提现引导
- (void)popViewWithDrawCashGuide {
    TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] init];
    popView.showCancelBtn = YES;
    popView.rightText = @"下一步";
    popView.title = @"提现引导";
    UIView *contentV = [[UIView alloc] init];
    popView.contentView = contentV;

    UILabel *contentLabel = [UILabel new];
    NSString *text = @"欢迎加入衣蝠，为了让新用户能快速体验提现功能，我们特意在你的提现可提现额度中存入了1.00元现金，现在可以立即提现了哦~";
    contentLabel.textColor = RGBCOLOR_I(125, 125, 125);
    contentLabel.font = kFont6px(28);
    contentLabel.numberOfLines = 0;
    contentLabel.text = text;
    [contentV addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(contentV);
    }];

    [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(popView.contentViewWidth);
    }];
    [contentV setNeedsLayout];

    [popView showCancelBlock:^{

        [VitalityModel posguide:^(id data) {//弹了引导弹框告诉后台

        }];
    } withConfirmBlock:^{

        [VitalityModel posguide:^(id data) {//弹了引导弹框告诉后台

        }];

        TFWithdrawCashViewController *VC = [[TFWithdrawCashViewController alloc] init];
        VC.bindNameAndIdenfBlock = ^(NSInteger sguidance) {

        };
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    } withNoOperationBlock:^{

        [VitalityModel posguide:^(id data) {//弹了引导弹框告诉后台

        }];
    }];
}
#pragma mark - tableHeadView
- (MyWalletHeaderView *)heardView {
    if (nil == _heardView) {
        _heardView = [[MyWalletHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(450))];
        kSelfWeak;
        [_heardView setBlock:^(HeaderViewBtnType type) {
            [weakSelf heardBtnClick:type];
        }];
        [_heardView loadViewWithType:HeaderViewTypeDefault];
    }
    return _heardView;
}

#pragma mark - 点击事件
- (void)heardBtnClick:(HeaderViewBtnType)type {
    switch (type) {
        case HeaderViewBtnTypeShop: {
            // 点击 开启余额翻倍
            NSString *str = [NSString stringWithFormat:@"%ld",(long)[DataManager sharedManager].twofoldness];
            TFPopBackgroundView *openShopView = [[TFPopBackgroundView alloc] initWithTitle:[NSString stringWithFormat:@"什么是余额X%@倍特权？",str] message:[NSString stringWithFormat:@"亲，余额%@倍是指在开店成功后24小时之内余额为原来余额的%@倍，可直接用于购物，24小时之后余额变为原来的金额",str,str] showCancelBtn:YES leftBtnText:nil rightBtnText:[NSString stringWithFormat:@"开启余额x%@倍特权",str] margin:kZoom6pt(10) contentFont:kZoom6pt(12)];
            openShopView.textAlignment = NSTextAlignmentLeft;
            kSelfWeak;
            openShopView.confirmClickBlock = ^ {
                [weakSelf openDouble];
            };
            [openShopView show];
        }
            break;
        case HeaderViewBtnTypeWithdraw: {
            // 点击提现
            if ([DataManager sharedManager].isOligible && [DataManager sharedManager].isOpen && _timeout > 0) {
                
                // 余额翻倍期间
                NavgationbarView *nv = [[NavgationbarView alloc] init];
                [nv showLable:@"余额翻倍期间暂时不可以提现喔~" Controller:self];

            } else {
                [self withdrawCashBtnClick:nil];
                // 没有翻倍期间
                self.withdrawCashBtn.hidden = YES;
//                TFWithdrawCashViewController *twvc = [[TFWithdrawCashViewController alloc] init];
//                twvc.type = TFMyWallet;
//                [self.navigationController pushViewController:twvc animated:YES];

            }
        }
            break;
        case HeaderViewBtnTypeShopping : {
            // 买买买
            self.withdrawCashBtn.hidden = NO;
            Mtarbar.selectedIndex = 0;
            [self.navigationController popToRootViewControllerAnimated:YES];

        }
            break;
        default:
            break;
    }
}

/// 倒计时
- (void)countdownTimeWithType:(HeaderViewType)type {
    kSelfWeak;
    if (_timer != nil) {
        return;
    }
    _timer = [NSTimer weakTimerWithTimeInterval:1.0 target:self userInfo:nil repeats:YES block:^(id target, NSTimer *timer) {
        kSelfStrong;
        if(strongSelf -> _timeout<=0){ //倒计时结束，关闭
            [strongSelf -> _timer invalidate];
            strongSelf -> _timer = nil;
            [DataManager sharedManager].isOligible = NO;
            [DataManager sharedManager].isOpen = NO;
            [weakSelf httpGetData];
            [weakSelf.heardView loadViewWithType:HeaderViewTypeDefault];
            weakSelf.tableView.tableHeaderView = weakSelf.heardView;
        } else {
            int hour = (int)strongSelf -> _timeout/60/60;
            int minute = (int)(strongSelf -> _timeout%(60*60))/60;
            int seconds = (int)strongSelf -> _timeout%60;
            NSString *strTime = [NSString stringWithFormat:@"距余额翻倍结束还剩：%02d时%02d分%02d秒", hour, minute, seconds];
            if (type == HeaderViewTypeOpenEnd) {
                weakSelf.heardView.timeLabel2.text = strTime;
            } else {
                weakSelf.heardView.timeLabel.text = strTime;
            }
            strongSelf -> _timeout--;
        }
    }];
}

#pragma mark - tableView
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7, kScreenWidth, kScreenHeight-kNavigationheightForIOS7)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kBackgroundColor;
        [_tableView registerNib:[UINib nibWithNibName:@"SettingCell" bundle:nil] forCellReuseIdentifier:@"SETTINGCELLID"];
        //        _tableView.backgroundColor = COLOR_ROSERED;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.tableHeaderView = self.heardView;
    }
    return _tableView;
}

#pragma mark - dataSource
- (NSMutableArray *)dataSourceArray
{
    
    if (_dataSourceArray == nil) {
        NSArray *titleArr = [NSArray arrayWithObjects:
//                                                    @"销售管理",
                                                    @"账户明细",
//                                                    @"提现",
//                                                    @"我的卡券",
                                                    @"我的银行卡",
                                                    @"支付密码",
//                                                    @"邀请码",
                                                    nil];
        
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
    
    if ([st isEqualToString:@"支付密码"]) {
        cell.headImageView.image = [UIImage imageNamed:@"支付密码_01"];
    } else
        cell.headImageView.image = [UIImage imageNamed:st];
    cell.titleLabel.text = st;
    
    cell.M_l_headImageView.constant = ZOOM(62);
    cell.W_H_headImageView.constant = ZOOM(100);
    cell.M_l_titleLabel.constant = cell.W_H_headImageView.constant+cell.M_l_headImageView.constant*2;
    cell.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

//    if (indexPath.row == 2) {
//        cell.subTitleLabel.text = self.cardString;
//        cell.subTitleLabel.textColor = RGBACOLOR_F(0.5, 0.5, 0.5, 0.6);
//        cell.subTitleLabel.font = kFont6px(32);
//    }
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    //    cell.contentView.backgroundColor = COLOR_RANDOM;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellTitle = self.dataSourceArray[indexPath.row];
    MyLog(@"cellTitle: %@", cellTitle);
    
    if ([cellTitle isEqualToString:@"销售管理"]) {
        TFSaleManagementViewController *tsvc = [[TFSaleManagementViewController alloc] init];
        [self.navigationController pushViewController:tsvc animated:YES];
        return;
    } else if ([cellTitle isEqualToString:@"账户明细"]) {
        TFAccountDetailsViewController *tdvc = [[TFAccountDetailsViewController alloc] init];
        tdvc.headIndex = 0;
        [self.navigationController pushViewController:tdvc animated:YES];
        return;
    } else if ([cellTitle isEqualToString:@"我的银行卡"]) {
        TFMyBankCardViewController *tmvc = [[TFMyBankCardViewController alloc] init];
        tmvc.type = self.type;
        [self.navigationController pushViewController:tmvc animated:YES];
        return;
    } else if ([cellTitle isEqualToString:@"支付密码"]) {
        [self httpIsSetPwd]; //判断用户是否设置过支付密码
    } else if ([cellTitle isEqualToString:@"我的卡券"]) {
        TFMyCardViewController *tmvc = [[TFMyCardViewController alloc] init];
        [self.navigationController pushViewController:tmvc animated:YES];
        return;
    } else if ([cellTitle isEqualToString:@"邀请码"]) {
        InvitCodeViewController *invitCode =[[InvitCodeViewController alloc]init];
        [self.navigationController pushViewController:invitCode animated:YES];
        return;
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

#pragma mark - 网络请求
//自动提现绑定微信
- (void)httpAddWXOpenID:(NSString *)WXOpenID userName:(NSString *)name {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:WXOpenID forKey:@"openid"];
    [parameter setValue:name forKey:@"u_name"];

    [[APIClient sharedManager] netWorkGeneralRequestWithApi:@"wallet/addWxOpenid?" parameter:parameter caches:NO cachesTimeInterval:0*TFMinute token:YES success:^(id data, Response *response) {
        if (response.status == 1) {
//            NSNumber *dataNumber = data[@"data"];
//            if (dataNumber.integerValue==0) {//0否1是
                [MBProgressHUD show:data[@"message"] icon:nil view:self.view];
//            }
        }else
            [MBProgressHUD show:data[@"message"] icon:nil view:self.view];
    } failure:^(NSError *error) {

    }];
}
//获取用户是否绑定了微信   (自动提现)
- (void)httpGetWXOpenID {
//    [[APIClient sharedManager] netWorkGeneralRequestWithApi:@"wallet/getWxOpenid?" caches:NO cachesTimeInterval:0*TFMinute token:YES success:^(id data, Response *response) {
//        if (response.status == 1) {
//            NSNumber *dataNumber = data[@"data"];
//            if (dataNumber.integerValue==0) {//0否1是
//                [[NSUserDefaults standardUserDefaults]setObject:[NSDate date] forKey:@"getWXOpenID"];
//                [self toBindWXView];
//            }
//        }
//    } failure:^(NSError *error) {
//
//    }];
}
/// 开启余额翻倍
- (void)openDouble {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [DoubleModel getDoubleEntrance:3 Sucess:^(id data) {
        DoubleModel *model = data;
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (model.status == 1) {
            NSLog(@"开启成功");
            [DataManager sharedManager].isOpen = YES;
            YFDoubleSucessVC *doubleView = [[YFDoubleSucessVC alloc] init];
            [self.navigationController pushViewController:doubleView animated:YES];
        } else {
            [MBProgressHUD showError:model.message];
        }
    }];
}

- (void)httpGetData
{
    //获取余额
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr1 = [NSString stringWithFormat:@"%@wallet/myWallet?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL1 = [MyMD5 authkey:urlStr1];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
//                balance = "7363.05";
//                "ex_free" = 0;
//                extract = "9.98";
//                "freeze_balance" = 10;
                NSString *balance = [NSString stringWithFormat:@"%@", responseObject[@"vip_balance"]]; // 总余额
                NSString *extract = [NSString stringWithFormat:@"%@", responseObject[@"extract"]]; // 可提现余额
                //金额
                CGFloat overValue = [balance floatValue];
                CGFloat extractValue = [extract floatValue];
                //是否翻倍
                if ([DataManager sharedManager].isOligible&&[DataManager sharedManager].isOpen&&([DataManager sharedManager].twofoldness > 0)) {
                    overValue *= [DataManager sharedManager].twofoldness;
                }
                
//                self.heardView.overLabel.text = [NSString stringWithFormat:@"¥%.2f",overValue];
//                self.heardView.canWithCashLabel.text = [NSString stringWithFormat:@"¥%.2f",extractValue];
                
                double freeze_balance = [[NSString stringWithFormat:@"%@", responseObject[@"freeze_balance"]]floatValue];
                double ex_free = [[NSString stringWithFormat:@"%@", responseObject[@"ex_free"]]floatValue];

//                [self.heardView loadDataWithStr:[NSString stringWithFormat:@"%.2f",overValue] str2:[NSString stringWithFormat:@"%.2f",freeze_balance] str3:[NSString stringWithFormat:@"%.2f", extractValue] str4:[NSString stringWithFormat:@"%.2f", ex_free]];
                
                
                [self.heardView loadDataWithStr:[NSString stringWithFormat:@"%.2f",overValue] str2:[NSString stringWithFormat:@"%.2f",extractValue] str3:[NSString stringWithFormat:@"%.2f", extractValue] str4:[NSString stringWithFormat:@"%.2f", ex_free]];
                
//                NSString *count = responseObject[@"conponCount"];
//                self.cardString = [NSString stringWithFormat:@"%@张",count];
                [self.tableView reloadData];
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }
        
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          
          NavgationbarView *mentionview=[[NavgationbarView alloc]init];
          [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
//    [NSDate systemCurrentTime:^(long long time) {
//        _timeout = [DataManager sharedManager].endDate/1000 - time/1000;
//        if ([DataManager sharedManager].isOligible&&(_timeout > 0)) {
//            if ([DataManager sharedManager].isOpen) {
//                [self.heardView loadViewWithType:HeaderViewTypeOpenEnd];
//                self.withdrawCashBtn.hidden = NO;
//                [self countdownTimeWithType:HeaderViewTypeOpenEnd];
//            } else {
//                [self.heardView loadViewWithType:HeaderViewTypeOpen];
//                self.withdrawCashBtn.hidden = YES;
//                [self countdownTimeWithType:HeaderViewTypeOpen];
//
//            }
//        } else {
            self.withdrawCashBtn.hidden = YES;
            [self.heardView loadViewWithType:HeaderViewTypeDefault];
//        }
        
        self.tableView.tableHeaderView = self.heardView;
//    }];

    [self httpGetData];
}

/**
 *  开启余额翻倍后点击提现
 */
- (void)httpAddDepositCount
{
    
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:kApi_wallet_addDepositCount caches:NO cachesTimeInterval:0*TFSecond token:YES success:^(id data, Response *response) {
        if (response.status == 1) {
            
        } else {
//            [MBProgressHUD showError:response.message];
        }
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)httpIsSetPwd
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/ckSetPwd?token=%@&version=%@",[NSObject baseURLStr],token,VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];
    
    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) { //设置过密码了
                
                if ([responseObject[@"flag"] intValue] == 1) { //没设置
                    //进入设置支付密码页面
                    TFSetPaymentPasswordViewController *tsvc= [[TFSetPaymentPasswordViewController alloc] init];
                    [self.navigationController pushViewController:tsvc animated:YES];
                } else if ([responseObject[@"flag"] intValue] == 2) { //设置过了
                    //                [MBProgressHUD showError:@"您可在[设置]中修改支付密码"];
                    TFChangePaymentPasswordViewController *tppvc = [[TFChangePaymentPasswordViewController alloc] init];
                    tppvc.index = 0;
                    [self.navigationController pushViewController:tppvc animated:YES];
                }
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }

        }
        
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
         NavgationbarView *mentionview=[[NavgationbarView alloc]init];
         [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
}

- (void)rightBarButtonClick
{
    [self Message];
}

#pragma mark 聊天
-(void)Message
{
    //begin 赵官林 2016.5.26 跳转到消息列表
    [self presentChatList];
    //end
}

- (void)leftBarButtonClick {
    if (self.navigationController == [Mtarbar.viewControllers objectAtIndex:Mtarbar.viewControllers.count-1]||[self.navigationController.viewControllers[self.navigationController.viewControllers.count-2]isKindOfClass:NSClassFromString(@"MessageCenterVC")]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
//        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
#pragma mark - 微信授权
- (void)shareSdkWithAutohorWithTypeGetOpenID:(NSString *)userName {

    kSelfWeak;
    //判断设备是否安装微信
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]){

    }else{

        NavgationbarView *mentionview = [[NavgationbarView alloc]init];
        [mentionview showLable:@"还未安装微信哦~" Controller:self];
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

    [ShareSDK getUserInfoWithType:ShareTypeWeixiFav
                      authOptions:authOptions
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {

                               if (result) {
                                   if([userInfo uid] !=nil) {
                                       NSString *unionid = [NSString stringWithFormat:@"%@",[userInfo uid]];
                                       [weakSelf httpAddWXOpenID:unionid userName:userName];
                                   }

                               }else{
                                   [MBProgressHUD show:@"微信授权失败" icon:nil view:self.view];
                               }
                           }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//获取汉字的个数
- (int)getlongthnum:(NSString*)text
{
    int count = 0;
    int count1 =0;

    for (int i =0; i< text.length; i++)
    {
        unichar c = [text characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FA5)//是汉字
        {
            count ++;
        }
        else
        {
            count1 ++;
        }
    }

    return count;//返回汉子个数
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
