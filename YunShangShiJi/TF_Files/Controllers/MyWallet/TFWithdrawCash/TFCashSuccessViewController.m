//
//  TFCashSuccessViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/15.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFCashSuccessViewController.h"
#import "TFAccountDetailsViewController.h"
#import "TFAccountSafeViewController.h"
#import "TFMyWalletViewController.h"
#import "DBCenterViewController.h"
#import "WithdrawalsViewController.h"
#import "AffirmOrderViewController.h"
#import "MakeMoneyViewController.h"
#import "TFHomeViewController.h"
#import "ActivityShopOrderVC.h"
#import "TaskCollectionVC.h"
#import "SelectHobbyViewController.h"
@interface TFCashSuccessViewController ()

@property (nonatomic, strong)UILabel *moneyLabel;

@end

@implementation TFCashSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [self setupUI];
    [super setNavigationItemLeft:self.headTitle];
}

- (void)setData
{
    
}

- (void)setupUI
{
    /**< 数据设置 */
    CGFloat ud_Margin = ZOOM(212);
    CGFloat iv_W_H = ZOOM(140);
    
    CGFloat lr_Margin = ZOOM(100);
    CGFloat udiv_Margin = ZOOM(90);
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-iv_W_H)/2, kNavigationheightForIOS7+ud_Margin, iv_W_H, iv_W_H)];
    if (self.index == VCType_Cash) { // 是提现
        self.headTitle = @"提现";
        if (self.cashType == CashType_Fail) { // 提现失败
            self.btnTitle = [[DataManager sharedManager] isGeneralA]? @"去升级会员": @"买 买 买";
            imageV.image = [UIImage imageNamed:@"失败"];
            self.text = [[DataManager sharedManager] isGeneralA]?
            @"你现在是普通会员，任务现金暂时无法提现哦~升级会员即可享受任务现金提现特权喔。":
            @"很抱歉，任务奖励仅可用于平台消费\n不可提现，您可以继续使用余额消费噢~";
        } else { // 提现成功或者 部分成功
            self.btnTitle = [[DataManager sharedManager] isGeneralA]?
            @"去升级会员":
            @"查看提现纪录";
            imageV.image = [UIImage imageNamed:@"提现成功"];
            if (self.cashType == CashType_Success) { // 提现成功
                self.text = [NSString stringWithFormat:@"申请提现成功：%.2f元", self.money];
            } else if (self.cashType == CashType_Adopt) { // 部分成功
                self.text = [NSString stringWithFormat:@"申请通过：%.2f（抽奖/回佣）", self.money];
            }
        }
    } else { // 是绑定手机
        self.btnTitle = @"关闭";
        self.headTitle = @"绑定手机";
        imageV.image = [UIImage imageNamed:@"提现成功"];
        if (self.index == VCType_BindPhoneSuccess) {
            self.text = @"绑定手机成功";
        } else if (self.index == VCType_ChangeBindPhone) {
            self.text = @"更换绑定手机成功";
        }
    }
    [self.view addSubview:imageV];
    
    /**< UI配置 */
    UIFont *font;
    if (self.cashType == CashType_Fail) {
        font = [UIFont systemFontOfSize:ZOOM(40)];
    } else {
        font = [UIFont systemFontOfSize:ZOOM(50)];
    }

    CGSize sizeString = [self.text getSizeWithFont:font constrainedToSize:CGSizeMake(kScreenWidth-lr_Margin*2, 1000)];
    self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(lr_Margin,  imageV.bottom+udiv_Margin, sizeString.width, sizeString.height)];
    self.moneyLabel.textColor = RGBCOLOR_I(62, 62, 62);
    self.moneyLabel.textAlignment = NSTextAlignmentCenter;
    self.moneyLabel.numberOfLines = 0;
    self.moneyLabel.font = font;
    self.moneyLabel.center = CGPointMake(kScreen_Width*0.5, self.moneyLabel.center.y);
    [self.view addSubview:self.moneyLabel];
    
    NSMutableAttributedString *atStr = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    if (self.index == VCType_Cash) { // 提现
        if (self.cashType == CashType_Success) { // 提现成功
            self.moneyLabel.textColor = COLOR_ROSERED;
            NSString *rangeString = @"申请提现成功：";
            NSRange range = [self.text rangeOfString:rangeString];
            [atStr addAttribute:NSForegroundColorAttributeName value:RGBCOLOR_I(62, 62, 62) range:range];
        } else if (self.cashType == CashType_Adopt) { // 提现部分成功
            self.moneyLabel.textColor = COLOR_ROSERED;
            NSString *rangeString = @"申请通过：";
            NSRange range = [self.text rangeOfString:rangeString];
            [atStr addAttribute:NSForegroundColorAttributeName value:RGBCOLOR_I(62, 62, 62) range:range];
        }
    }
    self.moneyLabel.attributedText = atStr;
    
    if (self.cashType == CashType_Adopt) { // 提现部分成功
        
        NSString *bottomString = [NSString stringWithFormat:@"申请未通过：%.2f%@", self.unAdoptMoney, [[DataManager sharedManager] isGeneralA]?
                                  @"（普通会员）":
                                  @"（签到）"];
        CGSize stringSize = [bottomString getSizeWithFont:font constrainedToSize:CGSizeMake(kScreenWidth-lr_Margin*2, 1000)];
        
        UILabel *lab = [UILabel new];
        [self.view addSubview:lab];
        lab.font = font;
        lab.textColor = COLOR_ROSERED;
        lab.textAlignment = NSTextAlignmentLeft;
        lab.numberOfLines = 0;
        
        NSString *bottomRangeString = @"申请未通过：";
        NSRange bottomRange = [bottomString rangeOfString:bottomRangeString];
        
        NSMutableAttributedString *atStr = [[NSMutableAttributedString alloc] initWithString:bottomString];
        
        [atStr addAttribute:NSForegroundColorAttributeName value:RGBCOLOR_I(62, 62, 62) range:bottomRange];
        lab.attributedText = atStr;
        
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.moneyLabel).offset(20);
//            make.centerX.equalTo(self.view);
            make.left.equalTo(self.moneyLabel.mas_left);
            make.size.mas_equalTo(stringSize);
        }];
        
    }
    
    CGFloat udlb_Margin = ZOOM(200);
    CGFloat btn_H = ZOOM(120);
    CGFloat lr_btn_Magin = ZOOM(62);
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];

    btn.frame = CGRectMake(lr_btn_Magin,  self.moneyLabel.bottom+udlb_Margin, kScreenWidth-lr_btn_Magin*2, btn_H);
    btn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(50)];

    [btn setTitle:self.btnTitle forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(50)];
    [btn setBackgroundImage:[UIImage imageNamed:@"退出账号框"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"退出账号框高亮"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(findBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    if (self.cashType == CashType_Adopt) { // 提现部分成功
        NSString *subString = [[DataManager sharedManager] isGeneralA]?
            @"（普通会员）你现在是普通会员，任务现金暂时无法提现哦~升级会员即可享受任务现金提现特权喔。":
            @"您的抽奖/回佣提现申请已通过\n任务奖励仅可用于平台消费，不可提现\n您可以继续使用余额消费噢~";
        
        CGSize subStringSize = [subString getSizeWithFont:[UIFont systemFontOfSize:ZOOM(40)] constrainedToSize:CGSizeMake(kScreenWidth-lr_Margin*2, 1000)];
        UILabel *lab = [[UILabel alloc] init];
        [self.view addSubview:lab];
        
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.size.mas_equalTo(subStringSize);
            make.top.equalTo(btn.mas_bottom).offset(udiv_Margin);
        }];
        lab.font = [UIFont systemFontOfSize:ZOOM(40)];
        lab.textColor = RGBCOLOR_I(62, 62, 62);
        lab.textAlignment = NSTextAlignmentCenter;
        lab.numberOfLines = 0;
        lab.text = subString;
        
    }
}

#pragma mark - 按钮
- (void)findBtnClick:(UIButton *)sender
{
    if (self.index == VCType_Cash) { //查看提现的记录
        
        if (self.cashType == CashType_Success) {
            if (self.type == TFMyWallet) {
                TFAccountDetailsViewController *tdvc = [[TFAccountDetailsViewController alloc] init];
                tdvc.headIndex = 1;
                [self.navigationController pushViewController:tdvc animated:YES];
            } else {
                //跳转到
                for (UIViewController *viewColltroller in self.navigationController.viewControllers) {
                    if ([viewColltroller isKindOfClass:[WithdrawalsViewController class]]) {
                        [self.navigationController popToViewController:viewColltroller animated:YES];
                    }
                }
            }

        } else { /**< 提现失败 或者部分失败 -> 去升级会员 */
            if ([[DataManager sharedManager] isGeneralA]) {
                TaskCollectionVC *vc = [[TaskCollectionVC alloc] init];
                vc.title = @"热卖";
                vc.typeName = @"热卖";
                vc.typeID = @6;
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                Mtarbar.selectedIndex = 0;
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }
        
    } else if (self.index == VCType_BindPhoneSuccess || self.index == VCType_ChangeBindPhone) {//绑定手机成功/更换绑定手机 点 关闭
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[TFAccountSafeViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
            else if ([controller isKindOfClass:[AffirmOrderViewController class]]||[controller isKindOfClass:[ActivityShopOrderVC class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
//            else if ([controller isKindOfClass:[TFHomeViewController class]]) {
//                [self.navigationController popToViewController:controller animated:YES];
//            }
            else if ([controller isKindOfClass:[MakeMoneyViewController class]])
            {
//                //跳转到小店去开店
//                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//                
//                [user setObject:@"2" forKey:isShowNoviceTaskView6]; /**< 开店 */
//                
//                NSArray *viewControllers = Mtarbar.viewControllers;
//                
//                NSMutableArray *viewControllersTemp = [NSMutableArray arrayWithArray:viewControllers];
//                TFHomeViewController *thVC = [[TFHomeViewController alloc] init];
//                UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:thVC];
//                [viewControllersTemp replaceObjectAtIndex:0 withObject:nc];
//                Mtarbar.viewControllers = viewControllersTemp;
//                Mtarbar.selectedIndex=0;
//
//                
//                [self.navigationController popToViewController:controller animated:YES];
                
                SelectHobbyViewController *hobby = [[SelectHobbyViewController alloc]init];
                hobby.comefrom = @"赚钱任务";
                [self.navigationController pushViewController:hobby animated:YES];
            }
        }
    }

}

- (void)leftBarButtonClick
{
    for(UIViewController *vc in self.navigationController.viewControllers)
    {
        if([vc isKindOfClass:[TFMyWalletViewController class]]){
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
        if([vc isKindOfClass:[DBCenterViewController class]]){
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
        
        if([vc isKindOfClass:[TFAccountSafeViewController class]]){
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
        if ([vc isKindOfClass:[MakeMoneyViewController class]])
        {
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }

        if([vc isKindOfClass:[TFHomeViewController class]]){
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
        
    }
    [self.navigationController popViewControllerAnimated:YES];
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
