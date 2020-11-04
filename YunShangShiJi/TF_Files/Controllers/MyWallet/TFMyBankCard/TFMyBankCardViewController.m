//
//  TFAddBankCardViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/8.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFMyBankCardViewController.h"
#import "BankCardModel.h"
#import "TFPayPasswordView.h"
#import "BankCardCell.h"
#import "AddCardCell.h"
#import "TFCashSuccessViewController.h"
#import "TFAddBankCardViewController.h"
#import "DXAlertView.h"
#import "TFSetPaymentPasswordViewController.h"
#import "TFChangePaymentPasswordViewController.h"
#import "TFBankListViewController.h"

@interface TFMyBankCardViewController ()<UIAlertViewDelegate>

@property (nonatomic, copy)NSString *pwd; //获取的支付密码

@end

@implementation TFMyBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super setNavigationItemLeft:@"我的银行卡"];
    //[self httpGetMyCard];
}
#pragma mark - 创建UI
- (void)createUI
{
    
    CGFloat Margin = ZOOM(80);
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7+Margin-1, kScreenWidth, 1)];
    lineView.backgroundColor = RGBCOLOR_I(220,220,220);
//    [self.view addSubview:lineView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7+Margin, kScreenWidth, kScreenHeight-kNavigationheightForIOS7)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kApplicationWidth, ZOOM(150))];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ZOOM(62), ZOOM(30), kApplicationWidth-2*ZOOM(62), ZOOM(60))];
    label.text = @"";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = RGBCOLOR_I(168,168,168);
    [view addSubview:label];
    self.tableView.tableFooterView = view;
    self.tableView.tableHeaderView = [self tableviewHeardView];

    
}

/// 列表头部
- (UIView *)tableviewHeardView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ZOOM(62), 0, (120), (40))];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:(16)];
    label.text = self.isCash?@"     选择提现到哪张银行卡":@"     支持银行卡";
    if (self.isCash == NO) {
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoBankList)];
        [label addGestureRecognizer:tap];
        [label setUserInteractionEnabled:YES];
    }
    return label;
}

#pragma mark - tableView代理方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 ) {
        
        BankCardModel *bModel = self.dataArray[indexPath.section][indexPath.row];
        
        if(self.isCash){                    //选中提现到银行卡
            
            if (bModel.province_id == nil||bModel.city_id == nil ) {
            
                TFAddBankCardViewController *tavc = [[TFAddBankCardViewController alloc] init];
                tavc.navigationTitle = @"完善身份验证";
                tavc.bModel = bModel;
                [self.navigationController pushViewController:tavc animated:YES];

            } else {
            
                [self httpIsSetPwd:bModel];
            }
        } else {               //删除银行卡
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"删除此银行卡？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            
            NSArray *arr = self.dataArray[indexPath.section];
            
            BankCardModel *model = arr[indexPath.row];
            self.index  = indexPath.row;
            self.cardID = model.ID;
            
            [alert show];
        }
        
    }
    if (indexPath.section == 1&&indexPath.row == 0) {
        //进入下一页添加银行卡
        TFAddBankCardViewController *tavc = [[TFAddBankCardViewController alloc] init];
        tavc.navigationTitle = @"身份验证";
        [self.navigationController pushViewController:tavc animated:YES];
    }
    
    
}

#pragma mark - 向银行申请提现
- (void)httpCashData:(BankCardModel *)model
{
    NSUserDefaults *ud  = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *pwdMD5 = [MyMD5 md5:self.pwd];
    NSString *bank_id = model.ID;
    
    NSString *st;
    
    if (self.type == TFMyWallet) {
        st = @"wallet";
    } else {
        st = @"merchantAlliance";
    }
    // 现在只有提现到银行卡了
    
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/bankDepositAdd?token=%@&version=%@&pwd=%@&money=%.2f&bank_id=%@",[NSObject baseURLStr],token,VERSION,pwdMD5,self.money,bank_id];
    NSString *URL = [MyMD5 authkey:urlStr];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        NavgationbarView *mentionview = [[NavgationbarView alloc]init];
        if (responseObject!=nil) {
            NSString *message =responseObject[@"message"];
            if ([responseObject[@"pwdflag"] intValue] == 0&&[responseObject[@"status"]intValue]==1) {
                
                int flag = [responseObject[@"flag"] intValue];
                double money = [responseObject[@"money"] doubleValue];
                
                TFCashSuccessViewController *tcvc = [[TFCashSuccessViewController alloc] init];
                tcvc.index = VCType_Cash;
                tcvc.type = self.type;
                
                if (flag == 4) {
                    tcvc.cashType = CashType_Fail;
                    [self.navigationController pushViewController:tcvc animated:YES];
                } else if (flag == 0) {
                    if (self.money != money) {
                        tcvc.cashType = CashType_Adopt;
                        tcvc.money = money;
                        tcvc.unAdoptMoney = self.money-money;
                        [self.navigationController pushViewController:tcvc animated:YES];
                    } else {
                        tcvc.cashType = CashType_Success;
                        tcvc.money = money;
                        [self.navigationController pushViewController:tcvc animated:YES];
                    }
                } else if (flag == 1) {
                    message = @"支行为空";
                    [mentionview showLable:message Controller:self];
                } else if (flag == 2) {
                    message = @"市id为空";
                    [mentionview showLable:message Controller:self];
                } else if (flag == 3) {
                    message = @"省id为空";
                    [mentionview showLable:message Controller:self];
                } else if (flag == 5) {
                    message = @"提现金额不能大于最高提现金额或者小于最低提现金额";
                    [mentionview showLable:message Controller:self];
                } else if (flag == 6) {
                    message = @"未找到该银行卡";
                    [mentionview showLable:message Controller:self];
                }
                
            } else {
                if ([responseObject[@"pwdflag"] intValue]==1){
                    message = pwdflagString1;
                }else if ([responseObject[@"pwdflag"] intValue]==2){
                    message = pwdflagString2;
                }else if ([responseObject[@"pwdflag"] intValue]==3){
                    message = pwdflagString3;
                }

                [mentionview showLable:message Controller:self];
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 70;
    } else
        return (60);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) { //银行卡列表
        if ([self.dataArray[indexPath.section] count]!=0) {
            BankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BANKCARDCELLID"];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"BankCardCell" owner:self options:nil] lastObject];
            }
            [cell receiveDataModel:[self.dataArray[indexPath.section] objectAtIndex:indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    } else if (indexPath.section == 1) {
        AddCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ADDCARDCELLID"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AddCardCell" owner:self options:nil] lastObject];
        }
        cell.headImageView.image = [UIImage imageNamed:[self.dataArray[indexPath.section] objectAtIndex:indexPath.row]];
        cell.titleLabel.text = [self.dataArray[indexPath.section] objectAtIndex:indexPath.row];
        cell.titleLabel.font = [UIFont systemFontOfSize:(15)];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return 0;
}


#pragma mark - alertView 的代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex ==1) {
        //确定删除");
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *token = [ud objectForKey:USER_TOKEN];
        NSString *urlStr = [NSString stringWithFormat:@"%@wallet/delMyBankCard?token=%@&version=%@&id=%@",[NSObject baseURLStr],token,VERSION,self.cardID];
       NSString *URL = [MyMD5 authkey:urlStr];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //%@",responseObject);
            responseObject = [NSDictionary changeType:responseObject];
            if (responseObject!=nil) {
                if ([responseObject[@"status"] integerValue]==1) {
                    
                    [MBProgressHUD showSuccess:responseObject[@"message"]];
                    [self.dataArray[0] removeObjectAtIndex:self.index];
                    [self.tableView reloadData];
                }
                else
                {
                    [MBProgressHUD showError:responseObject[@"message"]];
                }

            }
            
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
        
    }
}

#pragma mark 检查是否设置过支付密码
- (void)httpIsSetPwd:(BankCardModel *)bModel
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
            if ([responseObject[@"status"] intValue] == 1) {
                
                if ([responseObject[@"flag"] intValue] == 1) { //没设置
                    
                    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"温馨提示" contentText:@"亲，你还没有设置支付密码请设置!" leftButtonTitle:@"取消" rightButtonTitle:@"确认"];
                    [alert show];
                    alert.leftBlock = ^() {
                        //left button clicked");//取消
                    };
                    alert.rightBlock = ^() {
                        //right button clicked");//确认
                        
                        //进入设置支付密码页面
                        TFSetPaymentPasswordViewController *tsvc= [[TFSetPaymentPasswordViewController alloc] init];
                        [self.navigationController pushViewController:tsvc animated:YES];
                        
                    };
                    alert.dismissBlock = ^() {
                        //Do something interesting after dismiss block");
                    };
                    
                    
                    
                } else if ([responseObject[@"flag"] intValue] == 2) { //设置过了
                    
                    [self payPassWord:bModel];
                   
                }
                
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
    }];
}

-(void)payPassWord:(BankCardModel *)bModel
{
    TFPayPasswordView *view = [[TFPayPasswordView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    view.money = [NSString stringWithFormat:@"%.2f",self.money];
    
    [self.view addSubview:view];
    [view returnPayResultSuccess:^(NSString *pwd) {
        
        self.pwd = pwd;
        [self httpCashData:bModel]; //提现请求uu
        
    } withFail:^(NSString *error){
        
//        NavgationbarView *nv = [[NavgationbarView alloc] init];
//        [nv showLable:error Controller:self];
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"温馨提示" contentText:error leftButtonTitle:@"重新输入" rightButtonTitle:@"忘记密码"];
        [alert show];
        alert.leftBlock = ^() {
            [self payPassWord:bModel];
        };
        alert.rightBlock = ^() {
            TFChangePaymentPasswordViewController *tsvc= [[TFChangePaymentPasswordViewController alloc] init];
            [self.navigationController pushViewController:tsvc animated:YES];
            
        };
        
    } withTitle:@"请输入支付密码"];
}
//获取用户是否绑定了微信   (自动提现)
- (void)httpGetWXOpenID {
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:@"wallet/getWxOpenid?" caches:NO cachesTimeInterval:0*TFMinute token:YES success:^(id data, Response *response) {
        NSString * WXOpenID = @"";
        if (response.status == 1) {
            NSNumber *dataNumber = data[@"data"];
            if (dataNumber.integerValue==1 && data[@"wxOpenId"]) {//0否1是
        
                WXOpenID = [NSString stringWithFormat:@"%@",data[@"wxOpenId"]];
            }
        }
        
        [self httpGetMyCard:WXOpenID];
    } failure:^(NSError *error) {
        [self httpGetMyCard:nil];
    }];
}

#pragma mark - 获取我的银行卡
- (void)httpGetMyCard:(NSString*)WXOpenID
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/findMyBankCard?token=%@&version=%@",[NSObject baseURLStr],token,VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        [self clearBackgroundView:self.view withTag:99999];
        MyLog(@"获取银行卡列表: %@",responseObject);
       
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                NSMutableArray *muArr1 = [NSMutableArray array];
                NSMutableArray *muArr2 = [NSMutableArray array];
                //            self.dataArray  把卡保存到数据源
                NSArray *cardsArr = responseObject[@"bankCards"];
                
                if(WXOpenID.length > 0)
                {
                    BankCardModel *bcModel = [[BankCardModel alloc] init];
                    bcModel.bank_name = @"微信支付";
                    bcModel.bank_no = [NSString stringWithFormat:@"**%@",WXOpenID];
                    [muArr1 addObject:bcModel];
                }
                
                for (NSDictionary *dic in cardsArr) {
                    BankCardModel *bcModel = [[BankCardModel alloc] init];
                    [bcModel setValuesForKeysWithDictionary:dic];
                    bcModel.ID = dic[@"id"];
                    [muArr1 addObject:bcModel];
                }
                //最后一个是添加银行卡
                NSString *addCard = [NSString stringWithFormat:@"添加银行卡"];
                [muArr2 addObject:addCard];
                
                [self.dataArray addObject:muArr1];
                [self.dataArray addObject:muArr2];
                //%@",self.dataArray);
                //创建tableView
                [self createUI];
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
        CGRect frame = CGRectMake(0, kNavigationheightForIOS7, self.view.frame.size.width, kScreenHeight-kNavigationheightForIOS7);
        [self createBackgroundView:self.view andTag:99999 andFrame:frame withImgge:[UIImage imageNamed:@"哭脸"] andText:@"亲,没网了"];
        
    }];
}

/// 跳转银行卡列表
- (void)gotoBankList {
    TFBankListViewController *bankListVC = [[TFBankListViewController alloc] init];
    [self.navigationController pushViewController:bankListVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.dataArray removeAllObjects];
    self.isCash?[self httpGetMyCard:nil]:[self httpGetWXOpenID];
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
