//
//  TFWithdrawCashViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/14.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFWithdrawCashViewController.h"
#import "TFCellView.h"
#import "TFMyBankCardViewController.h"
#import "KeyboardTool.h"
#import "TFPopBackgroundView.h"
#import "DataManager.h"
#import "TFMyWalletViewController.h"
#import "MyWalletHeaderView.h"
#import "DoubleModel.h"
#import "YFDoubleSucessVC.h"
#import "DoubleModel.h"
#import "DoubleRemindView.h"
#import "HTTPTarbarNum.h"
#import "TFWXWithdrawalsDescriptionVC.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
//#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <QZoneConnection/ISSQZoneApp.h>
#import "WXApi.h"
#import "OneYuanModel.h"
#import "vipInfoModel.h"
#import "AppDelegate.h"
#import "TaskCollectionVC.h"
#import "LuckdrawViewController.h"
#import "CFInviteFriendsRewardVC.h"
#import "NewSpecialViewController.h"
#import "MemberRawardsViewController.h"
typedef NS_ENUM(NSInteger, WithdrawCashCellType) {
    WithdrawCashCellTypeMoney = 0,      // 抵用券
    WithdrawCashCellTypePay = 1
};

@interface WithdrawCashTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@end
@implementation WithdrawCashTableViewCell
- (UILabel *)leftLabel {
    if (nil == _leftLabel) {
        _leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), 0, self.frame.size.width, ZOOM6(100))];
        _leftLabel.textColor = kMainTitleColor;
        _leftLabel.font = kFont6px(28);
    }
    return _leftLabel;
}
- (UIImageView *)leftImageView {
    if (nil == _leftImageView) {
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM6(20), ZOOM6(27), ZOOM6(46), ZOOM6(46))];
    }
    return _leftImageView;
}
- (UIImageView *)rightImageView {
    if (nil == _rightImageView) {
        _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-ZOOM6(20)-ZOOM6(40), ZOOM6(30), ZOOM6(40), ZOOM6(40))];
    }
    return _rightImageView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];

        [self addSubview:self.leftLabel];
        [self addSubview:self.rightImageView];
        if ([reuseIdentifier isEqualToString:@"WithdrawCashCellTypePay"]) {
            [self addSubview:self.leftImageView];
            self.leftLabel.frame = CGRectMake(ZOOM6(66)+ZOOM6(10), 0, self.frame.size.width, ZOOM6(100));

        }
    }
    return self;
}

+ (instancetype)cellWithType:(WithdrawCashCellType)type tableView:(UITableView *)tableView {
    static NSString *MoneyName = @"WithdrawCashCellTypeMoney";
    static NSString *PayName = @"WithdrawCashCellTypePay";

    WithdrawCashTableViewCell *cell = nil;
    switch (type) {
        case WithdrawCashCellTypeMoney:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:MoneyName];
            if (nil == cell) {
                cell = [[WithdrawCashTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MoneyName];
            }
        }
            break;
        case WithdrawCashCellTypePay:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:PayName];
            if (nil == cell) {
                cell = [[WithdrawCashTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PayName];
            }
        }
            break;
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end

@interface TFWithdrawCashViewController () <UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,KeyboardToolDelegate>
@property (nonatomic, strong)UILabel *moneyLabel; /**< 余额 */
@property (nonatomic, strong)UILabel *cashMoneyLabel; /**< 提现额度 */
@property (nonatomic, strong)UILabel *exfreeMoneyLabel; /**< 冻结额度 */
@property (nonatomic, strong)UITextField *moneyTextField;
@property (nonatomic, strong) UIButton *moneyBtn;

/**
 余额
 */
@property (nonatomic, assign)double money;

/**
 可提现余额
 */
@property (nonatomic, assign)double extractMoney;
/**
 金额的提现区间
 */
@property (nonatomic, assign)double minMoney;
@property (nonatomic, assign)double maxMoney;
@property (nonatomic, assign)double oneMin;
@property (nonatomic, assign) BOOL firstBlood;


@property (nonatomic, strong)UIButton *currChooseBtn;
@property (nonatomic, strong) UILabel *bankLabel;
@property (nonatomic, strong) UIButton *nextBtn;

@property (nonatomic, assign) BOOL isViewDidLoad;

@property (nonatomic, strong) MyWalletHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *leftMoneyArr;
@property (nonatomic, strong) UIButton *FootBtn;
@property (nonatomic, strong) UITextField *moneyField;
@property (nonatomic, strong) NSString * minicill;//单次提现额度
@end

@implementation TFWithdrawCashViewController
{
    CGRect _oldFrame;
    NSIndexPath *lastMoneyIndex;
    NSIndexPath *lastPayIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavigationItemLeft:@"提现"];

    lastMoneyIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    lastPayIndex = [NSIndexPath indexPathForRow:0 inSection:1];
    [self addNavgationView];
    [self.view addSubview:self.tableView];
    [self setFootView];
//    [self setupUI];
    [self setData];
    self.isViewDidLoad = YES;

}

- (void)setData
{
//    if (self.bindNameAndIdenfBlock) {
//        [self popViewWithDrawCashExplain];
//    }
    
    [vipInfoModel addUserVipOrderSuccess:^(id data) {
        vipInfoModel *model = data;
        NSInteger isVip = model.isVip ? model.isVip:0;
        NSInteger maxVipType = model.maxType?model.maxType:999;
        
        if(isVip == 0)//不是会员提示购买会员
        {
            [MBProgressHUD show:@"你还不是会员请先购买会员" icon:nil view:self.view];
        }
    }];
}
- (NSMutableArray *)leftMoneyArr {
    if (!_leftMoneyArr) {
        _leftMoneyArr = [NSMutableArray array];
    }
    return _leftMoneyArr;
}
#pragma mark - tableHeadView
- (MyWalletHeaderView *)headerView {
    if (nil == _headerView) {
        _headerView = [[MyWalletHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kZoom6pt(250))];
        [_headerView loadViewWithType:HeaderViewTypeDefault_NoTiXian];
    }
    return _headerView;
}
- (UIView *)tableHeader {
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(324))];
    header.backgroundColor = [UIColor whiteColor];

    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ZOOM6(60), kScreenWidth, 20)];
    topLabel.textColor = kSubTitleColor;
    topLabel.font = kFont6px(30);
    topLabel.text = @"总金额";
    topLabel.textAlignment = NSTextAlignmentCenter;
    [header addSubview:topLabel];
    UILabel *money = [[UILabel alloc]initWithFrame:CGRectMake(0, topLabel.bottom+ZOOM6(10), kScreenWidth, ZOOM6(224)-ZOOM6(130)-15)];
    money.textColor = tarbarrossred;
    money.textAlignment = NSTextAlignmentCenter;
//    money.text = @"0";
    money.font = [UIFont boldSystemFontOfSize:ZOOM6(72)];
    _moneyLabel = money;
    [header addSubview:money];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, money.bottom+ZOOM6(60), kScreenWidth, 0.5)];
    line.backgroundColor = kTableLineColor;
    [header addSubview:line];
    UILabel *leftMoney = [[UILabel alloc]initWithFrame:CGRectMake(0, line.bottom, kScreenWidth/2, header.height-line.bottom)];
    leftMoney.textColor = kMainTitleColor;
    leftMoney.font = kFont6px(30);
    leftMoney.textAlignment = NSTextAlignmentCenter;
    leftMoney.attributedText = [NSString attributedSourceString:@"提现额度：" targetString:@"0" addAttributes:@{NSForegroundColorAttributeName:COLOR_ROSERED}];
    _cashMoneyLabel = leftMoney;
    [header addSubview:leftMoney];
    UILabel *rightMoney = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, line.bottom, kScreenWidth/2, header.height-line.bottom)];
    rightMoney.textColor = kMainTitleColor;
    rightMoney.font = kFont6px(30);
    rightMoney.textAlignment = NSTextAlignmentCenter;
    rightMoney.attributedText = [NSString attributedSourceString:@"冻结额度：" targetString:@"0" addAttributes:@{NSForegroundColorAttributeName:COLOR_ROSERED}];
    _exfreeMoneyLabel = rightMoney;
    [header addSubview:rightMoney];
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2, leftMoney.centerY-ZOOM6(15), 0.5, ZOOM6(30))];
    line2.backgroundColor = kTableLineColor;
    [header addSubview:line2];
    return header;
}
- (UITableView *)tableView {
    if (nil == _tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar-ZOOM(200)) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;//[self tableHeader];
        _tableView.separatorColor = kTableLineColor;
    }
    return _tableView;
}
- (void)setFootView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-ZOOM(200), kScreenWidth, ZOOM(200))];
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    line.backgroundColor=kNavLineColor;
    [view addSubview:line];

    UIButton *FootBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    FootBtn.frame=CGRectMake(kZoom6pt(15), ZOOM(32), kScreenWidth-kZoom6pt(15)*2, view.frame.size.height-ZOOM(32)*2);
    [FootBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [FootBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [FootBtn setBackgroundImage:[UIImage imageWithColor:tarbarrossred] forState:UIControlStateNormal];
    FootBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOMPT(18)];
    [FootBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    FootBtn.layer.cornerRadius = 3;
    FootBtn.layer.masksToBounds = YES;
    FootBtn.userInteractionEnabled=NO;//交互关闭
    FootBtn.alpha=0.4;//透明度
    [view addSubview:self.FootBtn=FootBtn];

}
- (void)addNavgationView {
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, Height_NavBar-0.5, kScreenWidth, 0.5)];
    line.backgroundColor = kNavLineColor;
    [self.navigationView addSubview:line];

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
/*
- (void)setupUI
{
    self.view.backgroundColor = RGBCOLOR_I(243, 243, 243);

    UIScrollView *myScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    myScrollview.userInteractionEnabled = YES;
    myScrollview.contentMode =UIViewContentModeScaleAspectFill;
    myScrollview.contentSize = CGSizeMake(0, 1000);
    [self.view addSubview:myScrollview];

    UIView *ScrContainer = [UIView new];
    [myScrollview addSubview:ScrContainer];
    [ScrContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(myScrollview);
        make.width.equalTo(myScrollview);
    }];
    
    UIView *backgroundV = [UIView new];
    backgroundV.backgroundColor = [UIColor whiteColor];
    [ScrContainer addSubview:backgroundV];
    
    CGFloat padding = ZOOM6(30);
    
    [backgroundV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kStatusBar_And_NavigationBar_Height+ZOOM6(20));
        make.left.right.equalTo(self.view);
    }];
    
    UILabel *moneyLab = [UILabel new];
    moneyLab.attributedText = [NSString attributedSourceString:@"总余额：" targetString:@"0" addAttributes:@{NSForegroundColorAttributeName:COLOR_ROSERED}];
    moneyLab.font = kFont6px(40);
    [backgroundV addSubview:_moneyLabel = moneyLab];
    
    [moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundV.mas_top).offset(padding);
        make.left.equalTo(backgroundV.mas_left).offset(padding);
        make.right.equalTo(backgroundV.mas_right).offset(-padding);
        make.height.mas_equalTo(ZOOM6(60));
    }];
    
    UILabel *cashMoneyLabel = [UILabel new];
    cashMoneyLabel.attributedText = [NSString attributedSourceString:@"提现额度：" targetString:@"0" addAttributes:@{NSForegroundColorAttributeName:COLOR_ROSERED}];
    cashMoneyLabel.font = kFont6px(35);
    [backgroundV addSubview:_cashMoneyLabel = cashMoneyLabel];
    [cashMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyLab.mas_bottom).offset(padding);
        make.left.equalTo(moneyLab.mas_left);
        make.width.mas_equalTo(kScreen_Width * 0.5 - padding);
        make.height.mas_equalTo(ZOOM6(60));
    }];
    
    UILabel *exfreeMoneyLabel = [UILabel new];
    exfreeMoneyLabel.attributedText = [NSString attributedSourceString:@"冻结额度：" targetString:@"0" addAttributes:@{NSForegroundColorAttributeName:COLOR_ROSERED}];
    exfreeMoneyLabel.font = kFont6px(35);
    [backgroundV addSubview:_exfreeMoneyLabel = exfreeMoneyLabel];
    [exfreeMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cashMoneyLabel.mas_right).offset(padding);
        make.right.equalTo(backgroundV.mas_right).offset(-padding);
        make.height.mas_equalTo(ZOOM6(60));
        make.centerY.equalTo(cashMoneyLabel.mas_centerY);
    }];
    
    UIView *lineV = [[UIView alloc] init];
    lineV.backgroundColor = RGBCOLOR_I(243, 243, 243);
    [backgroundV addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cashMoneyLabel.mas_bottom).offset(padding);
        make.left.right.equalTo(backgroundV);
        make.height.mas_equalTo(ZOOM6(20));
    }];

    *
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, ZOOM6(100))];
    UITextField *withDrawText = [[UITextField alloc] init];
    withDrawText.borderStyle = UITextBorderStyleNone;
    withDrawText.font = [UIFont systemFontOfSize:ZOOM6(30)];
    withDrawText.delegate = self;
    withDrawText.placeholder = @"";
    withDrawText.layer.borderWidth = 1;
    withDrawText.layer.borderColor = [RGBCOLOR_I(240, 240, 240) CGColor];
    withDrawText.clearButtonMode = UITextFieldViewModeWhileEditing;
    withDrawText.layer.masksToBounds = YES;
    withDrawText.layer.cornerRadius = ZOOM6(8);
    withDrawText.leftView = paddingView;
    withDrawText.leftViewMode = UITextFieldViewModeAlways;
    [backgroundV addSubview:_moneyTextField = withDrawText];
    
    [withDrawText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineV.mas_bottom).offset(padding);
        make.left.equalTo(backgroundV.mas_left).offset(padding);
        make.right.equalTo(backgroundV.mas_right).offset(-padding);
        make.height.mas_equalTo(ZOOM6(100));
    }];
    *

    UILabel *label1 = [[UILabel alloc]init];
    label1.textColor = RGBCOLOR_I(168, 168, 168);
    label1.text = @"30元";
    [backgroundV addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineV.mas_bottom);
        make.left.equalTo(backgroundV.mas_left).offset(padding);
        make.right.equalTo(backgroundV.mas_right).offset(-padding);
        make.height.mas_equalTo(ZOOM6(100));
    }];
    UIButton *Btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [Btn1 setImage:[UIImage imageNamed:@"pay_icon_nor"] forState:UIControlStateNormal];
    [Btn1 setImage:[UIImage imageNamed:@"pay_icon_cel"] forState:UIControlStateSelected];
    Btn1.selected = YES;
    Btn1.tag = 100;
    self.moneyBtn = Btn1;
    [Btn1 setTitleColor:RGBCOLOR_I(168, 168, 168) forState:UIControlStateNormal];
    Btn1.titleLabel.font = kFont6px(30);
    Btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [Btn1 addTarget:self action:@selector(moneyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundV addSubview:Btn1];
    [Btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(label1);
    }];

    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = RGBCOLOR_I(240, 240, 240);
    [backgroundV addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom);
        make.left.right.equalTo(label1);
        make.height.offset(1);
    }];

    UILabel *label2 = [[UILabel alloc]init];
    label2.textColor = RGBCOLOR_I(168, 168, 168);
    label2.text = @"50元";
    [backgroundV addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom);
        make.left.equalTo(backgroundV.mas_left).offset(padding);
        make.right.equalTo(backgroundV.mas_right).offset(-padding);
        make.height.mas_equalTo(ZOOM6(100));
    }];
    UIButton *Btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [Btn2 setImage:[UIImage imageNamed:@"pay_icon_nor"] forState:UIControlStateNormal];
    [Btn2 setImage:[UIImage imageNamed:@"pay_icon_cel"] forState:UIControlStateSelected];
    [Btn2 setTitleColor:RGBCOLOR_I(168, 168, 168) forState:UIControlStateNormal];
    Btn2.titleLabel.font = kFont6px(30);
    Btn2.tag = 101;
    Btn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [Btn2 addTarget:self action:@selector(moneyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundV addSubview:Btn2];
    [Btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(label2);
    }];

    UIView *line3 = [[UIView alloc]init];
    line3.backgroundColor = RGBCOLOR_I(240, 240, 240);
    [backgroundV addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label2.mas_bottom);
        make.left.right.equalTo(label2);
        make.height.offset(1);
    }];
    UILabel *label3 = [[UILabel alloc]init];
    label3.textColor = RGBCOLOR_I(168, 168, 168);
    label3.text = @"100元";
    [backgroundV addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3.mas_bottom);
        make.left.equalTo(backgroundV.mas_left).offset(padding);
        make.right.equalTo(backgroundV.mas_right).offset(-padding);
        make.height.mas_equalTo(ZOOM6(100));
    }];
    UIButton *Btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    Btn3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [Btn3 setImage:[UIImage imageNamed:@"pay_icon_nor"] forState:UIControlStateNormal];
    [Btn3 setImage:[UIImage imageNamed:@"pay_icon_cel"] forState:UIControlStateSelected];
    [Btn3 addTarget:self action:@selector(moneyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    Btn3.tag = 102;
    [backgroundV addSubview:Btn3];
    [Btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(label3);
    }];
    UIView *line4 = [[UIView alloc]init];
    line4.backgroundColor = RGBCOLOR_I(243, 243, 243);
    [backgroundV addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label3.mas_bottom);
        make.left.right.equalTo(backgroundV);
        make.height.offset(ZOOM6(20));
    }];
    
    UILabel *textLab = [UILabel new];
    textLab.text = @"提现到";
    textLab.font = kFont6px(30);
    [backgroundV addSubview:textLab];
    
    [textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line4.mas_bottom).offset(padding);
        make.left.equalTo(backgroundV.mas_left).offset(padding);
        make.right.equalTo(backgroundV.mas_right).offset(-padding);
        make.height.mas_equalTo(ZOOM6(35));
    }];
    
    UIView *lineV2 = [[UIView alloc] init];
    lineV2.backgroundColor = RGBCOLOR_I(240, 240, 240);
    [backgroundV addSubview:lineV2];
    [lineV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textLab.mas_bottom).offset(padding);
        make.left.right.equalTo(backgroundV);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *wxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    wxBtn.tag = 100;
    [wxBtn setTitle:@"    微信" forState:UIControlStateNormal];
    [wxBtn setImage:[UIImage imageNamed:@"pay_icon_nor"] forState:UIControlStateNormal];
    [wxBtn setImage:[UIImage imageNamed:@"pay_icon_cel"] forState:UIControlStateSelected];
    wxBtn.selected = YES;
    [wxBtn setTitleColor:RGBCOLOR_I(168, 168, 168) forState:UIControlStateNormal];
    wxBtn.titleLabel.font = kFont6px(30);
    [wxBtn addTarget:self action:@selector(chooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundV addSubview:wxBtn];
    
    [wxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineV2.mas_bottom).offset(0);
        make.left.equalTo(backgroundV.mas_left).offset(ZOOM6(50));
        make.height.mas_equalTo(ZOOM6(100));
    }];
    
    UIView *lineV3 = [[UIView alloc] init];
    lineV3.backgroundColor = RGBCOLOR_I(240, 240, 240);
    [backgroundV addSubview:lineV3];
    [lineV3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wxBtn.mas_bottom).offset(0);
        make.right.equalTo(backgroundV.mas_right);
        make.left.equalTo(backgroundV.mas_left).offset(ZOOM6(100));
        make.height.mas_equalTo(1);
        
    }];
    
    UIButton *bankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bankBtn.tag = 101;
    [bankBtn setTitle:@"    银行卡" forState:UIControlStateNormal];
    bankBtn.titleLabel.font = kFont6px(30);
    [bankBtn setImage:[UIImage imageNamed:@"pay_icon_nor"] forState:UIControlStateNormal];
    [bankBtn setImage:[UIImage imageNamed:@"pay_icon_cel"] forState:UIControlStateSelected];
    [bankBtn setTitleColor:RGBCOLOR_I(168, 168, 168) forState:UIControlStateNormal];
    [bankBtn addTarget:self action:@selector(chooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundV addSubview:bankBtn];
    
    [bankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineV3.mas_bottom).offset(0);
        make.left.equalTo(backgroundV.mas_left).offset(ZOOM6(50));
        make.height.mas_equalTo(ZOOM6(100));
        
        make.bottom.equalTo(backgroundV.mas_bottom);
    }];
    
    UILabel *bankLabel = [UILabel new];
    bankLabel.textColor = RGBA(168, 168, 168, 1);
    bankLabel.font = kFont6px(30);
    bankLabel.text = @"";
    bankLabel.textAlignment = NSTextAlignmentCenter;
    [backgroundV addSubview:_bankLabel = bankLabel];
    
    [bankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backgroundV.mas_right).offset(-padding);
        make.height.equalTo(bankBtn.mas_height);
        make.centerY.equalTo(bankBtn.mas_centerY);
    }];

    self.currChooseBtn = wxBtn;
    
    [ScrContainer addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(padding);
        make.right.equalTo(self.view.mas_right).offset(-padding);
        make.top.equalTo(backgroundV.mas_bottom).offset(ZOOM6(50));
        make.height.mas_equalTo(ZOOM6(100));
    }];

    [ScrContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.nextBtn.mas_bottom);
    }];


    self.nextBtn.userInteractionEnabled = YES;
    self.nextBtn.selected = NO;
}
*/
- (void)moneyBtnClick:(UIButton *)sender {
    self.moneyBtn.selected = NO;
    sender.selected = YES;
    self.moneyBtn = sender;
}
/**
 提现说明框
 */
- (void)popViewWithDrawCashExplain {
    NSString *user_idcardFlag = [NSString stringWithFormat:@"%@_idcardFlag",[[NSUserDefaults standardUserDefaults]objectForKey:USER_ID]];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:user_idcardFlag];

    TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] init];
    popView.showCancelBtn = YES;
    popView.rightText = @"立即提现";
    popView.title = @"提现说明";
    popView.isManualDismiss = YES;
    
    UIView *contentV = [[UIView alloc] init];
    popView.contentView = contentV;
    
    UILabel *contentLabel = [UILabel new];
    NSString *text = @"请填写你的真实姓名及身份证验证微信或银行卡提现账号";
    contentLabel.textColor = RGBCOLOR_I(125, 125, 125);
    contentLabel.font = kFont6px(28);
    contentLabel.numberOfLines = 0;
    contentLabel.attributedText = [NSString attributedSourceString:text targetString:@"身份证号必须正确填写" addAttributes:@{NSForegroundColorAttributeName: COLOR_ROSERED}];
    [contentV addSubview:contentLabel];
    
    UITextField *nameTextField = [[UITextField alloc] init];
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    nameTextField.placeholder = @"姓名";
    nameTextField.font = kFont6px(28);
    [contentV addSubview:nameTextField];
    
    UITextField *idenfTextField = [[UITextField alloc] init];
    idenfTextField.borderStyle = UITextBorderStyleRoundedRect;
    idenfTextField.placeholder = @"身份证号";
    idenfTextField.font = kFont6px(28);
    [contentV addSubview:idenfTextField];
    
    /**< 布局 */
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(contentV);
    }];
    [nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentLabel.mas_bottom).offset(ZOOM6(20));
        make.left.right.equalTo(contentV);
        make.height.mas_equalTo(ZOOM6(85));
    }];
    [idenfTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameTextField.mas_bottom).offset(ZOOM6(20));
        make.left.right.equalTo(contentV);
        make.height.mas_equalTo(ZOOM6(85));
        make.bottom.equalTo(contentV.mas_bottom);
    }];
    [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(popView.contentViewWidth);
    }];
    [contentV setNeedsLayout];
    
    [popView showCancelBlock:^{
//        [popView dismissAlert:YES];
    } withConfirmBlock:^{
        
        NSString *nameText = nameTextField.text;
        NSString *idenfText = idenfTextField.text;
        if (nameText.length == 0) {
            [MBProgressHUD showError:@"请输入姓名"];
            return;
        }
        if (idenfText.length == 0) {
            [MBProgressHUD showError:@"请输入身份证号"];
            return;
        }
        if (![idenfText isIdCard]) {
            [MBProgressHUD showError:@"身份证号有误，请重新输入"];
            return;
        }
        
        [self httpSendNameAndIdenf:nameText idenf:idenfText];
        [popView dismissAlert:YES];
        
    } withNoOperationBlock:^{
        [nameTextField resignFirstResponder];
        [idenfTextField resignFirstResponder];
    } withCloseBlock:^{
        [popView dismissAlert:YES];
    }];

}

/**
 调用接口获取A、B类
 */
- (void)httpSendNameAndIdenf:(NSString *)name idenf:(NSString *)idenf {
    
    /**<
     sguidance:奖励的衣豆 ==0 表示没有奖励
     grade:等级 
     */
    
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    NSDictionary *parameter = @{@"idcard": idenf};
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:kApi_wallet_addCardDoType parameter:parameter caches:NO cachesTimeInterval:0 * TFHour token:YES success:^(id data, Response *response) {
        MyLog(@"data: %@", data);
        
        if (response.status == 1) {
            NSNumber *grade = data[@"data"][@"grade"];
            [DataManager sharedManager].grade = [grade integerValue];
            
            [self setMoneyplaceholderBalance:[NSString stringWithFormat:@"%.2f", self.money] withExtract:[NSString stringWithFormat:@"%.2f", self.extractMoney] grade:[DataManager sharedManager].grade];
            
            [DataManager sharedManager].sguidance = [[NSString stringWithFormat:@"%@",data[@"data"][@"sguidance"]] integerValue];
            if (self.bindNameAndIdenfBlock) {

                self.bindNameAndIdenfBlock([DataManager sharedManager].sguidance);
            }
            
            self.bindNameAndIdenfBlock = nil;
            [self httpDoDepositAgo:NO];
            
        } else {
            [nv showLable:response.message Controller:self];
        }
    } failure:^(NSError *error) {
        [nv showLable:@"网络有问题，请稍后重试!" Controller:self];
    }];
}

/** 微信提现部分成功 */
- (void)wxMoneyPopViewSuccess:(NSString *)successMoney failedMoney:(NSString *)failedMoney
{
    TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] init];
    popView.showCancelBtn = YES;
    
    UIView *contentV = [[UIView alloc] init];
    popView.contentView = contentV;
    
    UIImageView *imageV1 = [[UIImageView alloc] init];
    imageV1.image = [UIImage imageNamed:@"TFWXWithdrawals_weixintixian_chenggong_icon"];
    [contentV addSubview:imageV1];
    
    UILabel *label1 = [UILabel new];
    label1.textColor = RGBCOLOR_I(62, 62, 62);
    label1.attributedText = [NSString attributedSourceString:[NSString stringWithFormat:@"提现成功：%@", successMoney] targetString:successMoney addAttributes:@{NSForegroundColorAttributeName: COLOR_ROSERED}];
    label1.font = kFont6px(30);
    [contentV addSubview:label1];
    
    UILabel *desLabel1 = [UILabel new];
    desLabel1.text = @"（抽奖/回佣）";
    desLabel1.textColor = RGBCOLOR_I(125, 125, 125);
    desLabel1.font = kFont6px(24);
    [contentV addSubview:desLabel1];
    
    UIImageView *imageV2 = [[UIImageView alloc] init];
    imageV2.image = [UIImage imageNamed:@"TFWXWithdrawals_weixintixian_shibai_icon"];
    [contentV addSubview:imageV2];
    
    UILabel *label2 = [UILabel new];
    label2.textColor = RGBCOLOR_I(62, 62, 62);
    label2.attributedText = [NSString attributedSourceString:[NSString stringWithFormat:@"提现失败：%@", failedMoney] targetString:failedMoney addAttributes:@{NSForegroundColorAttributeName: COLOR_ROSERED}];;
    label2.font = kFont6px(30);
    [contentV addSubview:label2];
    
    UILabel *desLabel2 = [UILabel new];
    desLabel2.text = [[DataManager sharedManager] isGeneralA]? @"（普通会员）": @"（签到）";
    desLabel2.textColor = RGBCOLOR_I(125, 125, 125);
    desLabel2.font = kFont6px(24);
    [contentV addSubview:desLabel2];
    
    UILabel *cellLabel1 = [UILabel new];
    cellLabel1.text = [[DataManager sharedManager] isGeneralA]?
        @"（抽奖/回佣）微信提现申请已提交，审核通过后将会在1—3天内到账":
        @"（抽奖/回佣）微信提现申请已提交，审核通过后将会在1-3天内到账";
    cellLabel1.preferredMaxLayoutWidth = popView.contentViewWidth;
    cellLabel1.numberOfLines = 0;
    cellLabel1.font = kFont6px(28);
    cellLabel1.textColor = RGBCOLOR_I(125, 125, 125);
    [contentV addSubview:cellLabel1];
    
    UILabel *cellLabel2 = [UILabel new];
    cellLabel2.text = [[DataManager sharedManager] isGeneralA]?
        @"（普通会员）你现在是普通会员，任务现金暂时无法提现哦~升级会员即可享受任务现金提现特权喔。":
        @"（任务）微信提现申请失败，任务奖励仅可用于平台消费，不可提现，你可以继续使用余额进行消费喔~";
    cellLabel2.preferredMaxLayoutWidth = popView.contentViewWidth;
    cellLabel2.numberOfLines = 0;
    cellLabel2.font = kFont6px(28);
    cellLabel2.textColor = RGBCOLOR_I(125, 125, 125);
    [contentV addSubview:cellLabel2];
    
    /**< 布局 */
    [imageV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(contentV);
        make.size.mas_equalTo(CGSizeMake(ZOOM6(40), ZOOM6(40)));
    }];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imageV1.mas_centerY);
        make.left.equalTo(imageV1.mas_right).offset(ZOOM6(20));
        make.height.equalTo(imageV1.mas_height);
    }];
    
    [desLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label1.mas_centerY);
        make.left.equalTo(label1.mas_right);
        make.height.equalTo(label1.mas_height);
    }];
    
    [imageV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageV1.mas_bottom).offset(ZOOM6(20));
        make.left.equalTo(contentV);
        make.size.mas_equalTo(CGSizeMake(ZOOM6(40), ZOOM6(40)));
    }];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imageV2.mas_centerY);
        make.left.equalTo(imageV2.mas_right).offset(ZOOM6(20));
        make.height.equalTo(imageV2.mas_height);
    }];
    
    [desLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label2.mas_centerY);
        make.left.equalTo(label2.mas_right);
        make.height.equalTo(label2.mas_height);
    }];
    
    [cellLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageV2.mas_bottom).offset(ZOOM6(40));
        make.left.right.equalTo(contentV);
    }];
    [cellLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cellLabel1.mas_bottom).offset(ZOOM6(20));
        make.left.right.equalTo(contentV);
        make.bottom.equalTo(contentV.mas_bottom);
    }];
    popView.rightText = [[DataManager sharedManager] isGeneralA]?
        @"去升级会员":
        @"买买买";
    
    [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(popView.contentViewWidth);
    }];
    [contentV setNeedsLayout];
    
    [popView showCancelBlock:^{
        
    } withConfirmBlock:^{
        
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
       
    } withNoOperationBlock:^{
        
    }];
}

/** 微信提现成功弹窗 */
- (void)wxPopViewIsSuccess:(BOOL)isSuccess
{
    TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] init];
    popView.showCancelBtn = YES;
    
    UIView *contentV = [[UIView alloc] init];
    popView.contentView = contentV;
    
    UIImageView *successImageV = [[UIImageView alloc] init];
    successImageV.image = isSuccess? [UIImage imageNamed:@"TFWXWithdrawals_weixintixian_chenggong_da_icon"]:
                                     [UIImage imageNamed:@"TFWXWithdrawals_weixintixian_shibai_da_icon"];
    [contentV addSubview:successImageV];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = isSuccess?
        @"微信提现申请成功":
        @"微信提现申请失败";
    titleLabel.textColor = RGBCOLOR_I(62, 62, 62);
    titleLabel.font = kFont6px(36);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [contentV addSubview:titleLabel];
    
    UILabel *desLabel = [UILabel new];
    desLabel.text = isSuccess? @"你的微信提现申请已提交，审核通过后将会在1-3天内到账":
                               ([[DataManager sharedManager] isGeneralA]?
                                @"你现在是普通会员，任务现金暂时无法提现哦~升级会员即可享受任务现金提现特权喔":
                                @"您的一元提现申请不通过，注册多个账号会被取消一元提现资格。");
    desLabel.textColor = RGBCOLOR_I(125, 125, 125);
    desLabel.font = kFont6px(30);
    desLabel.numberOfLines = 0;
    [contentV addSubview:desLabel];
    
    [successImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentV).offset(0);
        make.centerX.equalTo(contentV.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(ZOOM6(80), ZOOM6(80)));
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(successImageV.mas_bottom).offset(ZOOM6(20));
        make.left.right.equalTo(contentV);
    }];
    
    desLabel.preferredMaxLayoutWidth = popView.contentViewWidth;
    [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(ZOOM6(20));
        make.left.right.equalTo(contentV);
        make.bottom.equalTo(contentV.mas_bottom);
    }];
    
    [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(popView.contentViewWidth);
    }];
    
    [contentV setNeedsLayout];
    [contentV layoutIfNeeded];
    
    popView.rightText = isSuccess?@"继续去赚钱任务": ([[DataManager sharedManager] isGeneralA]?
                                           @"去升级会员":
                                           @"确定");
    [popView showCancelBlock:^{
        
    } withConfirmBlock:^{
        
        if (isSuccess || ![[DataManager sharedManager] isGeneralA]) {
            if (isSuccess) {
//                Mtarbar.selectedIndex = 0;
//                [self.navigationController popToRootViewControllerAnimated:YES];
                if(![DataManager sharedManager].is_MakeMoneyHiden){
                    MakeMoneyViewController *makemoney = [[MakeMoneyViewController alloc]init];
                    [self.navigationController pushViewController:makemoney animated:YES];
                }
            }
        } else {
            // 去升级会员
            TaskCollectionVC *vc = [[TaskCollectionVC alloc] init];
            vc.title = @"热卖";
            vc.typeName = @"热卖";
            vc.typeID = @6;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    } withNoOperationBlock:^{
        
    }];
}

- (void)chooseBtnClick:(UIButton *)sender
{
    self.currChooseBtn.selected = NO;
    sender.selected = YES;
    self.currChooseBtn = sender;
}

// 提现
- (void)nextBtnClick:(UIButton *)sender
{
    [self.view endEditing:YES];
   // if (self.currChooseBtn.tag == 100) { /**< 微信提现 */
    if (lastPayIndex.row == 0) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
            [self chooseWithDrawalsIsBank:NO];
        } else {
            NavgationbarView *nv = [[NavgationbarView alloc] init];
            [nv showLable:@"请安装微信后重试" Controller:self];
        }
    } else {
        [self chooseWithDrawalsIsBank:YES];
    }
}

- (void)chooseWithDrawalsIsBank:(BOOL)isBankCard
{
    //开启了余额翻倍
    if ([DataManager sharedManager].isOpen) {
        [self cannotWithdrawCashWarning];
        [self httpAddDepositCount];
        return;
    }
    
    if ([DataManager sharedManager].isOligible) { /**< 有特权 */
        [self userWithdrawCashWarning:isBankCard];
        return;
    }
    
    SEL chooseWithMethod = isBankCard? @selector(bankWithDrawals):@selector(wxWithDrawals);
    [self judgmentWithDrawalsMonemy:chooseWithMethod];
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
        if(type == RedHongBao_tixian)
        {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
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
    }
    else{//特价商品列表页
        NewSpecialViewController *subVC = [[NewSpecialViewController alloc] init];
        [self.navigationController pushViewController:subVC animated:YES];
    }
}
- (void)judgmentWithDrawalsMonemy:(SEL)chooseWithMethod
{
    NSArray *arr = self.leftMoneyArr.count ? self.leftMoneyArr : @[@30,@50,@100];
//    double inputMoney = [arr[lastMoneyIndex.row]doubleValue];
    
    
    if(!self.moneyField.text.length)
    {
        [MBProgressHUD show:@"请输入要提现的金额" icon:nil view:self.view];
        return;
    }
    
    NSArray *pointArray = [self.moneyField.text componentsSeparatedByString:@"."];
    if(pointArray.count > 2)
    {
//        [MBProgressHUD show:[NSString stringWithFormat:@"单次提现金额不得低于%@元",self.minicill] icon:nil view:self.view];
        [self setTaskPopMindView:Balance_notEnough Value:nil Title:nil Rewardvalue:nil Rewardnum:0];
        return;
    }
    
    double inputMoney = self.moneyField.text.doubleValue;
    if(inputMoney < self.minicill.doubleValue)
    {
//        [MBProgressHUD show:[NSString stringWithFormat:@"单次提现金额不得低于%@元",self.minicill] icon:nil view:self.view];
        [self setTaskPopMindView:Balance_notEnough Value:nil Title:nil Rewardvalue:nil Rewardnum:0];
        return;
    }
    
    if (inputMoney > self.extractMoney) {
        
        [self setTaskPopMindView:Balance_notEnough Value:nil Title:nil Rewardvalue:nil Rewardnum:0];
        return;
    }
    
//    if (inputMoney > self.money) {
//        [MBProgressHUD show:@"你的余额不足" icon:nil view:self.view];
//        return;
//    }

    [self performSelector:chooseWithMethod withObject:nil afterDelay:0.0];

    /*
    //如果输入的是数字和小数点
    if ([self isString:self.moneyTextField.text toCompString:@"0123456789."]) {
        //获取第一个字符
        NSString *c = [self.moneyTextField.text substringWithRange:NSMakeRange(0, 1)];
        BOOL bl = [c isEqualToString:@"."]; //判断第一个是不是小数点
        //按照小数点进行分割
        NSArray *aStr = [self.moneyTextField.text componentsSeparatedByString:@"."];
        
        if (bl||(!bl&&aStr.count>2)) { //第一个是小数点,或者有两个小数点
            [MBProgressHUD show:@"输入格式不符" icon:nil view:self.view];
        } else {
            double inputMoney = [self.moneyTextField.text doubleValue];
            double minMoney = self.minMoney;
            double maxMoney = self.maxMoney;
            
            MyLog(@"totalMoney: %.2f, extractMoney: %.2f, inputMoney: %.2f, minMoney: %.2f, maxMoney: %.2f ,oneMin:%.2f", self.money, self.extractMoney, inputMoney, minMoney, maxMoney,_oneMin);

            if ((_firstBlood && self.extractMoney<_oneMin)
                ||
                (self.extractMoney<minMoney) ) {

                double leastMoney = (_firstBlood &&self.extractMoney<_oneMin) ? _oneMin-self.extractMoney : minMoney-self.extractMoney;
                NSString *str = [NSString stringWithFormat:@"你还差%.2f元就可以申请提现啦，现在就去做提现任务吧。",leastMoney];
                [MBProgressHUD show:str icon:nil view:self.view];
                return;
            }

            if (inputMoney <= 0) {
                [MBProgressHUD show:@"输入有误，请重新输入" icon:nil view:self.view];
                return;
            }
            
            if (inputMoney > self.extractMoney) {
                [MBProgressHUD show:@"大于可提现额度" icon:nil view:self.view];
                return;
            }
            
            if (inputMoney > self.money) {
                [MBProgressHUD show:@"你的余额不足" icon:nil view:self.view];
                return;
            }
            
            if (inputMoney < minMoney || (_firstBlood&&inputMoney<_oneMin)) {
                [MBProgressHUD show:[NSString stringWithFormat:@"小于最低提现额%.2f",_firstBlood?_oneMin:minMoney] icon:nil view:self.view];
                return;
            }
            
            if (inputMoney > maxMoney) {
                [MBProgressHUD show:[NSString stringWithFormat:@"大于最高提现额%.2f",maxMoney] icon:nil view:self.view];
                return;
            }
            
            if (inputMoney <= self.money && inputMoney >= minMoney && inputMoney <= maxMoney) {
                
                [self performSelector:chooseWithMethod withObject:nil afterDelay:0.0];
            }
        }
    } else {
        [MBProgressHUD show:@"请正确输入" icon:nil view:self.view];
    }
    */

}

/**< go微信提现 */
- (void)wxWithDrawals
{
    TFWXWithdrawalsDescriptionVC *vc = [[TFWXWithdrawalsDescriptionVC alloc] init];
    NSArray *arr = self.leftMoneyArr.count ? self.leftMoneyArr : @[@30,@50,@100];
//    double inputMoney = [arr[lastMoneyIndex.row]doubleValue];
    double inputMoney = self.moneyField.text.doubleValue;
    vc.money = inputMoney;
//    vc.money = [self.moneyTextField.text doubleValue];
    vc.isIdenf = ![DataManager sharedManager].idcardFlag;
    [self.navigationController pushViewController:vc animated:YES];
}

/**< go银行卡提现 */
- (void)bankWithDrawals
{
    //允许提现,进入下一步
    TFMyBankCardViewController *tbvc= [[TFMyBankCardViewController alloc] init];
    tbvc.type = self.type;
    tbvc.isCash = YES;
    NSArray *arr = self.leftMoneyArr.count ? self.leftMoneyArr : @[@30,@50,@100];
//    double inputMoney = [arr[lastMoneyIndex.row]doubleValue];
    double inputMoney = self.moneyField.text.doubleValue;
    tbvc.money = inputMoney;
//    tbvc.money = [self.moneyTextField.text doubleValue]; //把提现金额传过去
    [self.navigationController pushViewController:tbvc animated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString *oldText = textField.text;
    NSString *currInputText = [NSString stringWithFormat:@"%@%@", textField.text, string];
    if (textField == self.moneyTextField) {
        
        if (currInputText.length>0) { // 输入
            self.nextBtn.userInteractionEnabled = YES;
            self.nextBtn.selected = NO;
            self.FootBtn.userInteractionEnabled=YES;//交互打开
            self.FootBtn.alpha=1;//透明度
        }
    }
    if ((currInputText.length == oldText.length && range.location == 0)) { // 删除
        self.nextBtn.userInteractionEnabled = NO;
        self.nextBtn.selected = YES;
        self.FootBtn.userInteractionEnabled=NO;//交互关闭
        self.FootBtn.alpha=0.4;//透明度
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    
    if (textField == self.moneyTextField) {
        self.nextBtn.userInteractionEnabled = NO;
        self.nextBtn.selected = YES;
        self.FootBtn.userInteractionEnabled=NO;//交互关闭
        self.FootBtn.alpha=0.4;//透明度
    }
    return YES;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.moneyTextField.text.length) {
        self.nextBtn.userInteractionEnabled = YES;
        self.nextBtn.selected = NO;
    }
    [self.view endEditing:YES];

}

- (UIButton *)nextBtn
{
    if (!_nextBtn) {
        _nextBtn = [UIButton new];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [_nextBtn setBackgroundImage:[UIImage imageWithColor:RGBCOLOR_I(195, 195, 195)] forState:UIControlStateSelected];
        [_nextBtn setBackgroundImage:[UIImage imageWithColor:COLOR_ROSERED] forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.layer.masksToBounds = YES;
        _nextBtn.layer.cornerRadius = ZOOM6(8);
        _nextBtn.selected = YES;
        _nextBtn.userInteractionEnabled = !_nextBtn.selected;
    }
    return _nextBtn;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(self.isLingHongBao){
    
        [self setTaskPopMindView:RedHongBao_tixian Value:nil Title:nil Rewardvalue:[NSString stringWithFormat:@"%.0f",self.coupon] Rewardnum:0];
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    if (self.wxCheckPopType == WXCheckPopTypeSuccess) { // 从微信验证里 返回回来
//        [self wxPopViewIsSuccess:YES];
        
        [self setTaskPopMindView:Balance_notEnough Value:nil Title:@"提现成功" Rewardvalue:nil Rewardnum:0];
        self.wxCheckPopType = 0;
        
    } else if (self.wxCheckPopType == WXCheckPopTypeFailure) {
        [self wxPopViewIsSuccess:NO];
        self.wxCheckPopType = 0;

    } else if (self.wxCheckPopType == WXCheckPopTypeSuccessFailure) {
        NSArray *arr = self.leftMoneyArr.count ? self.leftMoneyArr : @[@30,@50,@100];
//        double inputMoney = [arr[lastMoneyIndex.row]doubleValue];
        double inputMoney = self.moneyField.text.doubleValue;

        [self wxMoneyPopViewSuccess:[NSString stringWithFormat:@"%.1f元", self.WXwithDrawMoney] failedMoney:[NSString stringWithFormat:@"%.1f元", inputMoney-self.WXwithDrawMoney]];

//        [self wxMoneyPopViewSuccess:[NSString stringWithFormat:@"%.1f元", self.WXwithDrawMoney] failedMoney:[NSString stringWithFormat:@"%.1f元", [self.moneyTextField.text doubleValue]-self.WXwithDrawMoney]];
        self.wxCheckPopType = 0;
    }
    
    if (self.isViewDidLoad) {
        [self httpDoDepositAgo:YES];
        self.isViewDidLoad = NO;
    } else {
        [self httpDoDepositAgo:NO];
    }

}

- (void)viewDidDisappear:(BOOL)animated
{
    
}

#pragma mark *************************************************************


/**
 *  申请提现前
 balance    余额  Double 用户当前余额
 message    结果信息    String  相关提示信息
 status 状态  int 1成功,其他失败
 flag   是否弹开启余额翻倍 int   0否1是,开启余额翻倍的接口不变.
 dm下面增加参数 oneMin
 增加参数
 firstBlood 判断是否第一次
 */
-(void)httpDoDepositAgo:(BOOL)isPopView
{
    NavgationbarView *nv = [[NavgationbarView alloc] init];

    [[APIClient sharedManager] netWorkGeneralRequestWithApi:kApi_wallet_doDepositAgo caches:NO cachesTimeInterval:0*TFSecond token:YES success:^(id data, Response *response) {
        
        MyLog(@"data: %@", data);
        
        if (response.status == 1) {
            NSNumber *flag = data[@"flag"];
            NSNumber *idcardFlag = data[@"idcardFlag"]; /**< 是否绑定身份证 */
            NSNumber *grade = data[@"grade"];  /**< 用户等级 */
            NSNumber *balance = data[@"balance"]; /**< 余额 */
            NSNumber *extract = data[@"extract"]; /**< 可提现额度 */
            NSNumber *ex_free = data[@"ex_free"]; /**< 冻结提现额度 */
            NSNumber *vitality = data[@"vitality"];
            NSString *lastBname = data[@"lastBname"];
            NSNumber *minMoney = data[@"dm"][@"min"];
            NSNumber *maxMoney = data[@"dm"][@"max"];
            NSNumber *oneMin = data[@"dm"][@"oneMin"] ? data[@"dm"][@"oneMin"] : [NSNumber numberWithInt:20];
            NSString *kts = data[@"kts"];
            NSArray *arr = [kts componentsSeparatedByString:@","];
            if (arr.count) {
                [self.leftMoneyArr addObjectsFromArray:arr];
            }

            self.firstBlood = [data[@"firstBlood"] boolValue];
            self.minicill = [NSString stringWithFormat:@"%@",data[@"minicill"]];
            
            [DataManager sharedManager].grade = [grade integerValue];
            [DataManager sharedManager].idcardFlag = [idcardFlag boolValue];

            NSString *user_idcardFlag = [NSString stringWithFormat:@"%@_idcardFlag",[[NSUserDefaults standardUserDefaults]objectForKey:USER_ID]];
            BOOL isShowed = [[NSUserDefaults standardUserDefaults]boolForKey:user_idcardFlag];
            //新用户首次进入提现页面，弹出绑定身份证的弹窗
//            if (![DataManager sharedManager].idcardFlag && !isShowed) {
//                [self popViewWithDrawCashExplain];
//            }
            
            if (grade.integerValue == 1) {
                [DataManager sharedManager].vitality = vitality.integerValue;
            } else {
                [DataManager sharedManager].vitality = 0;
            }
            
            if (lastBname.length) {
                self.bankLabel.text = lastBname;
            }
            self.minMoney = [minMoney doubleValue];
            self.maxMoney = [maxMoney doubleValue];
            self.oneMin = [oneMin doubleValue];
            
            if (self.type == TFMyWallet) {
                NSInteger myGrade = [DataManager sharedManager].grade;
                // 从赚钱任务来
                if (self.bindNameAndIdenfBlock) {
                    myGrade = 2; // 按照B类显示
                }
                
                [self setUserCanWithDrawCashTotalMoney:[NSString stringWithFormat:@"%.2f", balance.doubleValue] withExtract:[NSString stringWithFormat:@"%.2f", extract.doubleValue] grade:myGrade];
                
                
                // 设置提现额度
                double cashMoney = [extract doubleValue] + [ex_free doubleValue];
                self.cashMoneyLabel.attributedText = [NSString attributedSourceString:[NSString stringWithFormat:@"提现额度：%.2f",cashMoney] targetString:[NSString stringWithFormat:@"%.2f",cashMoney] addAttributes:@{NSForegroundColorAttributeName:COLOR_ROSERED}];
                
                // 设置冻结额度
                double exfreeMoney = [ex_free doubleValue];
                self.exfreeMoneyLabel.attributedText = [NSString attributedSourceString:[NSString stringWithFormat:@"冻结额度：%.2f",exfreeMoney] targetString:[NSString stringWithFormat:@"%.2f",exfreeMoney] addAttributes:@{NSForegroundColorAttributeName:COLOR_ROSERED}];
                
                double balance = [[NSString stringWithFormat:@"%@", data[@"balance"]]floatValue]; // 总余额
                double extract = [[NSString stringWithFormat:@"%@", data[@"extract"]]floatValue]; // 可提现余额
                double freeze_balance = [[NSString stringWithFormat:@"%@", data[@"freeze_balance"]]floatValue];
                double ex_free = [[NSString stringWithFormat:@"%@", data[@"ex_free"]]floatValue];
                
//                [self.headerView loadDataWithStr:[NSString stringWithFormat:@"%.2f",balance] str2:[NSString stringWithFormat:@"%.2f",freeze_balance] str3:[NSString stringWithFormat:@"%.2f", extract] str4:[NSString stringWithFormat:@"%.2f", ex_free]];
                
               
                [self.headerView loadDataWithStr:[NSString stringWithFormat:@"%.2f",balance] str2:[NSString stringWithFormat:@"%.2f",extract] str3:[NSString stringWithFormat:@"%.2f", extract] str4:[NSString stringWithFormat:@"%.2f", ex_free]];
            }
            
            if ([flag integerValue] == 1) { // 弹框提醒
                if([balance floatValue] > 0) {
                    
//                    if (isPopView) {
//                        [self setDoubleMindView:[NSString stringWithFormat:@"%@", balance]];
//                    } else {
//
//                    }
                    
                    self.flag = flag.intValue;
                }
            } else if ([data[@"flag"] integerValue] == 0) { // 不弹框提醒
                
            }
            
        } else {
            CGFloat balance = self.isLingHongBao ? 20 :0;
            [self.headerView loadDataWithStr:[NSString stringWithFormat:@"%.2f",balance] str2:[NSString stringWithFormat:@"%.2f",0.0] str3:[NSString stringWithFormat:@"%.2f", 0.0] str4:[NSString stringWithFormat:@"%.2f", 0.0]];
//            [nv showLable:response.message Controller:self];
        }

        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [nv showLable:@"网络连接失败，请重新尝试~" Controller:self];
    }];
}
/**
 *  开启余额翻倍后点击提现
 */
- (void)httpAddDepositCount
{
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:kApi_wallet_addDepositCount caches:NO cachesTimeInterval:0*TFSecond token:YES success:^(id data, Response *response) {
        if (response.status == 1) {
            
        } else {
            
        }
    } failure:^(NSError *error) {
        
    }];
}

/**
 *  用户提现警告
 */
- (void)userWithdrawCashWarning:(BOOL)isBank
{
    TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] initWithTitle:@"确定要提现吗?" message:[NSString stringWithFormat:@"亲，您已经获得限时余额x%ld倍特权，开启特权余额将会变为原来的%ld倍哦~继续提现若无余额会无法使用特权呢！", (long)[DataManager sharedManager].twofoldness, (long)[DataManager sharedManager].twofoldness] showCancelBtn:YES leftBtnText:@"继续提现" rightBtnText:@"开启特权"];
    [popView setCancelBlock:^{
        
        SEL chooseWithMethod = isBank? @selector(bankWithDrawals):@selector(wxWithDrawals);
        [self judgmentWithDrawalsMonemy:chooseWithMethod];
        
    } withConfirmBlock:^{
        
        if ([[DataManager sharedManager] isOligible]) {
            [self openDouble];
        }

    } withNoOperationBlock:^{
        
    }];
    [popView show];
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


/**
 *  不能提现警告
 */
- (void)cannotWithdrawCashWarning
{
    TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] initWithTitle:@" 亲，余额翻倍期间不能提现哦~" message:@"请耐心等待时间结束后再来提现哦。" showCancelBtn:NO leftBtnText:nil rightBtnText:@"知道了" margin:0 contentFont:ZOOM6(30)];
    
    [popView setCancelBlock:^{
        
    } withConfirmBlock:^{
        
    } withNoOperationBlock:^{
        //
    }];
    [popView show];
}

#pragma mark - tableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row!=lastPayIndex.row) {
            lastPayIndex = indexPath;
            [self.tableView reloadData];
        }
    }else {
        if (indexPath.row!=lastMoneyIndex.row) {
            lastMoneyIndex = indexPath;
            [self.tableView reloadData];
        }
    }
}
//- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//
//    if(section == 0)
//    {
//        UIView *moneyinputView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
//        moneyinputView.backgroundColor = [UIColor redColor];
//
//        return moneyinputView;
//    }
//    return nil;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    if(section == 0)
//    {
//        return 100;
//    }
//    return 0;
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section ? 2 : 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return section==0?ZOOM6(160):CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if(section == 0)
    {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, ZOOM6(160))];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *linelab1 =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
        linelab1.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        self.moneyField = [[UITextField alloc]initWithFrame:CGRectMake(ZOOM6(20), 0, kScreenWidth-2*ZOOM6(20), ZOOM6(100))];
        self.moneyField.placeholder = @"请输入要提现的金额";
        self.moneyField.delegate = self;
        self.moneyField.keyboardType = UIKeyboardTypeDecimalPad;
        self.moneyField.font = [UIFont systemFontOfSize:ZOOM6(30)];
        self.moneyField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.moneyField.userInteractionEnabled=YES;
        self.moneyField.delegate = self;
        self.moneyField.textColor = RGBCOLOR_I(62, 62, 62);
        
        KeyboardTool *tool = [KeyboardTool keyboardTool];
        tool.delegate = self;
        tool.frame=CGRectMake(0, tool.frame.origin.y, kScreenWidth, 40);
        self.moneyField.inputAccessoryView = tool;
        
        UILabel *linelab2 =[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.moneyField.frame), kScreenWidth, 1)];
        linelab2.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        UILabel *bottomlab = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), CGRectGetMaxY(self.moneyField.frame), CGRectGetWidth(self.moneyField.frame), ZOOM6(60))];
        bottomlab.text = [NSString stringWithFormat:@"单次提现金额不得低于%@元",self.minicill];
        bottomlab.textColor = kSubTitleColor;
        bottomlab.font = [UIFont systemFontOfSize:ZOOM6(24)];
        
        [view addSubview:self.moneyField];
        [view addSubview:bottomlab];
        [view addSubview:linelab1];
        [view addSubview:linelab2];
        
        return view;
    }
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return ZOOM6(100);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, ZOOM6(100))];
    view.backgroundColor = [UIColor whiteColor];

    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(20))];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [view addSubview:line];

    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), ZOOM6(20), self.view.width, ZOOM6(80))];
    lable.textColor = kSubTitleColor;
    lable.font = kFont6px(28);
    lable.text = section==0 ? @"提现金额" : @"请选择提现方式";
    [view addSubview:lable];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ZOOM6(100);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WithdrawCashCellType type = indexPath.section == 1 ? WithdrawCashCellTypePay : WithdrawCashCellTypeMoney;
    WithdrawCashTableViewCell *cell = [WithdrawCashTableViewCell cellWithType:type tableView:tableView];
    if (indexPath.section==1) {
        if (indexPath.row==lastPayIndex.row) {
            cell.rightImageView.image = [UIImage imageNamed:@"pay_icon_cel"];
        }else
            cell.rightImageView.image = [UIImage imageNamed:@"pay_icon_nor"];

        if (indexPath.row == 0) {
            cell.leftImageView.image = [UIImage imageNamed:@"pay_icon_微信支付"];
            cell.leftLabel.text = @"微信";
        }else {
            cell.leftImageView.image = [UIImage imageNamed:@"提现银行卡"];
            cell.leftLabel.text = @"银行卡";
        }
    }else {
        if (indexPath.row==lastMoneyIndex.row) {
            cell.leftLabel.textColor = kMainTitleColor;
            cell.rightImageView.image = [UIImage imageNamed:@"pay_icon_cel"];
        }else {
            cell.leftLabel.textColor = kNavLineColor;
            cell.rightImageView.image = [UIImage imageNamed:@"pay_icon_nor"];
        }
        if (indexPath.row == 0) {
            cell.leftLabel.text = @"30元";
        }else if (indexPath.row == 1) {
            cell.leftLabel.text = @"50元";
        } else {
            cell.leftLabel.text = @"100元";
        }
        if (self.leftMoneyArr.count>indexPath.row) {
            cell.leftLabel.text = [NSString stringWithFormat:@"%@元", self.leftMoneyArr[indexPath.row]];
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }

    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

/**
 设置余额是否翻倍后显示的金额 和 提现输入框提示文字

 @param balance 总金额
 @param extract 可提现
 @param grade 等级
 */
- (void)setUserCanWithDrawCashTotalMoney:(NSString *)balance withExtract:(NSString *)extract grade:(NSInteger)grade
{
    self.money = [balance doubleValue];
    self.extractMoney = [extract doubleValue];
    //金额
    //是否翻倍
    if ([DataManager sharedManager].isOpen&&([DataManager sharedManager].twofoldness > 0)) {
        self.money *= [DataManager sharedManager].twofoldness;
    }
//    self.moneyLabel.attributedText = [NSString attributedSourceString:[NSString stringWithFormat:@"总余额：%.2f",self.money] targetString:[NSString stringWithFormat:@"%.2f",self.money] addAttributes:@{NSForegroundColorAttributeName:COLOR_ROSERED}];
    self.moneyLabel.text = [NSString stringWithFormat:@"%.2f",self.money];

    [self setMoneyplaceholderBalance:[NSString stringWithFormat:@"%.2f", self.money] withExtract:extract grade:grade];
}


/**
 设置提现输入框提示文字

 @param balance 总金额
 @param extract 可提现
 @param grade 等级
 */
- (void)setMoneyplaceholderBalance:(NSString *)balance withExtract:(NSString *)extract grade:(NSInteger)grade {
//    CGFloat balanceValue = [balance doubleValue];
    CGFloat extractValue = [extract doubleValue];

    if (extractValue < 20) {
        self.moneyTextField.placeholder = @"20元可提";
    }else {
//        CGFloat canWithCash = extractValue < balanceValue? extractValue: balanceValue;
        self.moneyTextField.placeholder = [NSString stringWithFormat:@"可提现%.2f元", extractValue];
    }
    /*
    // 提现输入框提示文字
    float minMoneyValue = self.minMoney;
    if (grade == 1 || grade == 2) {
        if (balanceValue < minMoneyValue) {
            self.moneyTextField.placeholder = [NSString stringWithFormat:@"余额不足%.2f元", minMoneyValue];
        }
        if (extractValue < minMoneyValue) {
            self.moneyTextField.placeholder = [NSString stringWithFormat:@"可提现额度未满%.2f元", minMoneyValue];
        }
        if (balanceValue >= minMoneyValue && extractValue >= minMoneyValue) {
            
            CGFloat canWithCash = extractValue < balanceValue? extractValue: balanceValue;
            self.moneyTextField.placeholder = [NSString stringWithFormat:@"可提现%.2f元", canWithCash];
        }
    } else { // 未分类
        self.moneyTextField.placeholder = [NSString stringWithFormat:@""];
    }
    */
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.moneyTextField) {
        [self.view endEditing:YES];
    }
    return YES;
}

#pragma mark - 键盘出现和消失
////键盘出现
//- (void)keyboardWillShow:(NSNotification *)noti
//{
//    //键盘高度
//    //    CGFloat keyboardHeight = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
//    if ([self.moneyTextField isEditing]&&kDevice_Is_iPhone4) {
//        self.view.frame = CGRectMake(0, -40, kScreenWidth, kScreenHeight);
//    }
//}
//
////键盘消失,其他坐标归位
//- (void)keyboardWillHide:(NSNotification *)noti
//{
//    if ([self.moneyTextField isEditing]&&kDevice_Is_iPhone4) {
//        self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
//    }
//}


-(void)keyBoardShow:(NSNotification *)no
{
    NSDictionary *info = no.userInfo;
    //NSValue
    id objFrame = info[@"UIKeyboardFrameEndUserInfoKey"];
    
    CGRect keyBoardFrame = {0};
    //获取键盘的高度
    [objFrame getValue:&keyBoardFrame];
    //%@",NSStringFromCGRect(keyBoardFrame));
    
    _oldFrame = self.view.frame;
    
    //判断键盘能否把控件遮挡住
    if(kScreenHeight - keyBoardFrame.size.height <self.moneyTextField.frame.origin.y + self.moneyTextField.frame.size.height)
    {
        CGRect tempFrame = self.view.frame;
        
        tempFrame.origin.y -= (self.moneyTextField.frame.origin.y +self.moneyTextField.frame.size.height) - (kScreenHeight - keyBoardFrame.size.height)+30;
        self.view.frame = tempFrame;
        
        

    }
}

-(void)keyBoardHidden:(NSNotification *)no
{
    //当键盘隐藏的时候 把frame还原
    self.view.frame = _oldFrame;
}


//使用代理
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.moneyTextField = textField;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.text.length >= 10 && textField == self.moneyField)
    {
        self.moneyField.text = [self.moneyField.text substringToIndex:10];
    }
}

-(void)tap
{
    [self.view endEditing:YES];
    //[self.moneyTextField resignFirstResponder];
}

- (void)setDoubleMindView:(NSString*)balance
{
    DoubleRemindView *mindview = [[DoubleRemindView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) andbalance:balance];
    
    __weak DoubleRemindView *weakmind = mindview;
    mindview.leftHideMindBlock = ^{
        
        [weakmind remindViewHiden];
        
    };
    mindview.rightHideMindBlock = ^{
        
        [weakmind remindViewHiden];
        
        [self doubleSuccessEntrance:4];
        
    };
    mindview.tapHideMindBlock = ^{
        
        [weakmind remindViewHiden];
    };
    
    [self.view addSubview:mindview];
    
}

- (void)doubleSuccessEntrance:(int)entrance
{
    [DoubleModel getDoubleEntrance:entrance Sucess:^(id data) {
        DoubleModel *model = data;
        if(model.status == 1)
        {
            MyLog(@"开启成功");
            [DataManager sharedManager].isOligible = YES;
            [DataManager sharedManager].isOpen = YES;
            [DataManager sharedManager].twofoldness = 2;
            [DataManager sharedManager].endDate = model.now + model.vt*60*60*1000;
            
            YFDoubleSucessVC *vc = [[YFDoubleSucessVC alloc]init];
            vc.flag = self.flag;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            MyLog(@"开启失败");
            
            [DataManager sharedManager].isOpen = NO;
            
        }
    }];
}

//键盘
- (void)keyboardTool:(KeyboardTool *)keyboardTool itemClick:(KeyboardToolItemType)itemType
{
    if (itemType == KeyboardToolItemTypePrevious) { // 上一个
        //----上一个----");
    } else if (itemType == KeyboardToolItemTypeNext) { // 下一个
        //----下一个----");
    } else { // 完成
        //----完成----");
        [self.view endEditing:YES];
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


