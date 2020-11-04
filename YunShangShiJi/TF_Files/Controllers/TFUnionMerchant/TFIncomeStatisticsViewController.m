//
//  TFIncomeStatisticsViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/10/26.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "TFIncomeStatisticsViewController.h"
#import "NavgationbarView.h"
#import "UIImageView+WebCache.h"

#import "TFWithdrawCashViewController.h"
#import "WithdrawalsViewController.h"
@interface TFIncomeStatisticsViewController ()

@property (nonatomic, strong)UIScrollView *backgroundScrollView;
@property (nonatomic, strong)UIImageView *headImageView;//头像
@property (nonatomic, strong)UILabel *nameLabel;        //名字
@property (nonatomic, strong)UILabel *timeLabel;        //时间

@property (nonatomic, strong)UILabel *tixianMoneyLabel;
@property (nonatomic, strong)UILabel *countMoneyLabel;  //总金额

@property (nonatomic, strong)UILabel *moneyLabel1;  //
@property (nonatomic, strong)UILabel *moneyLabel2;  //
@property (nonatomic, strong)UILabel *moneyLabel3;  //
@property (nonatomic, strong)UILabel *moneyLabel4;  //

@property (nonatomic, strong)NavgationbarView *showMsg;

@end

@implementation TFIncomeStatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super setNavigationItemLeft:@"收益统计"];
    
    [self createUserInterface];
    
    [self httpGetData];
    
}

- (void)btnClick:(UIButton *)sender
{
    if (sender.tag == 100) {    //next
        WithdrawalsViewController *view = [[WithdrawalsViewController alloc]init];
        view.model=_model;
        [self.navigationController pushViewController:view animated:YES];
        
    } else if (sender.tag == 101) { //提现
        
        TFWithdrawCashViewController *tvc = [[TFWithdrawCashViewController alloc] init];
        tvc.type = Withdrawals;
        [self.navigationController pushViewController:tvc animated:YES];

    }
}

- (void)httpGetData
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@merchantAlliance/earningsCount?token=%@&version=%@",[NSObject baseURLStr], token, VERSION];
    
    NSString *URL = [MyMD5 authkey:urlStr];
    
    [manager POST:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //收益统计: %@", responseObject);
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                
                NSString *monthMoney = responseObject[@"monthMoney"];
                NSString *todayMoney = responseObject[@"todayMoney"];
                NSString *weekMoney = responseObject[@"weekMoney"];
                
                self.moneyLabel2.text = [NSString stringWithFormat:@"%.2f", [todayMoney floatValue]];
                self.moneyLabel3.text = [NSString stringWithFormat:@"%.2f", [weekMoney floatValue]];
                self.moneyLabel4.text = [NSString stringWithFormat:@"%.2f", [monthMoney floatValue]];
                
            } else {
                [self.showMsg showLable:responseObject[@"message"] Controller:self];
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
    }];
}

- (void)createUserInterface
{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, Height_NavBar-1, kScreenWidth, 1)];
    lineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.view addSubview:lineView];
    
    NavgationbarView *nv =[[NavgationbarView alloc] init];
    _showMsg = nv;
    
    self.backgroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7, kScreenWidth, kScreenHeight-kNavigationheightForIOS7)];
    self.backgroundScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.backgroundScrollView];
    
    CGFloat H_s = CGRectGetHeight(self.backgroundScrollView.frame);
    
    CGFloat scroll_H = 0;

    CGFloat Margin_lr = ZOOM(40);
    CGFloat W_H = ZOOM(180);
    
    UIImageView *headIv = [[UIImageView alloc] initWithFrame:CGRectMake(Margin_lr, ZOOM(60), W_H, W_H)];
//    headIv.backgroundColor = COLOR_RANDOM;
    [headIv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy], self.model.user_pic]]];
    [self.backgroundScrollView addSubview:_headImageView = headIv];

    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headIv.frame)+Margin_lr, CGRectGetMinY(headIv.frame), kScreenWidth-CGRectGetMaxX(headIv.frame)-Margin_lr*2, CGRectGetHeight(headIv.frame)/2.0)];
//    nameLabel.backgroundColor = COLOR_RANDOM;
    nameLabel.font = kFont6px(34);
    nameLabel.textColor = RGBCOLOR_I(22,22,22);
    nameLabel.text = self.model.user_name;
    [self.backgroundScrollView addSubview:_nameLabel = nameLabel];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headIv.frame)+Margin_lr, CGRectGetMaxY(nameLabel.frame), kScreenWidth-CGRectGetMaxX(headIv.frame)-Margin_lr*2, CGRectGetHeight(headIv.frame)/2.0)];
//    timeLabel.backgroundColor = COLOR_RANDOM;
    timeLabel.font = kFont6px(28);
    timeLabel.textColor = RGBCOLOR_I(102,102,102);
    timeLabel.text = [NSString stringWithFormat:@"加入时间：%@", [self timeInfoWithDateString:self.model.user_add_date]];
    [self.backgroundScrollView addSubview:_timeLabel = timeLabel];

    CGFloat Margin_ud_count = ZOOM(60);
    CGFloat H_count = ZOOM(130);
    

    //总金额
    UILabel *countMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(Margin_lr, Margin_ud_count+CGRectGetMaxY(_headImageView.frame), kScreenWidth/2.0, H_count)];
//    countMoneyLabel.backgroundColor = COLOR_RANDOM;
    countMoneyLabel.text = [NSString stringWithFormat:@"%.2f", [self.model.two_balance doubleValue]];
    countMoneyLabel.textColor = COLOR_ROSERED;
    countMoneyLabel.font = [UIFont systemFontOfSize:ZOOM(80)];
    [self.backgroundScrollView addSubview:_countMoneyLabel = countMoneyLabel];
    
    CGFloat W_tiBtn = ZOOM(200);
    UIButton *tiMoneyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tiMoneyBtn.frame = CGRectMake(kScreenWidth-ZOOM(70)-W_tiBtn, CGRectGetMaxY(countMoneyLabel.frame), W_tiBtn, ZOOM(100));
//    tiMoneyBtn.backgroundColor = COLOR_RANDOM;
    tiMoneyBtn.tag = 101;
    tiMoneyBtn.layer.borderColor = [COLOR_ROSERED CGColor];
    tiMoneyBtn.layer.borderWidth = 1.5;
    [tiMoneyBtn setTitle:@"提现" forState:UIControlStateNormal];
    
    [tiMoneyBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [tiMoneyBtn setTitleColor:COLOR_ROSERED forState:UIControlStateNormal];
    [self.backgroundScrollView addSubview:tiMoneyBtn];
    
    //已经提现
    UILabel *tixianLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(countMoneyLabel.frame), CGRectGetMaxY(countMoneyLabel.frame), CGRectGetMinX(tiMoneyBtn.frame)-CGRectGetMinX(countMoneyLabel.frame), CGRectGetHeight(countMoneyLabel.frame))];
//    tixianLabel.backgroundColor = COLOR_RANDOM;
    tixianLabel.textColor = RGBCOLOR_I(102,102,102);
    NSString *st = [NSString stringWithFormat:@"已提现：%.2f元", [self.model.depositMoneySuccessSum floatValue]];
    NSMutableAttributedString *maStr = [[NSMutableAttributedString alloc] initWithString:st];
    [maStr addAttributes:@{NSForegroundColorAttributeName:COLOR_ROSERED} range:NSMakeRange(4, st.length-5)];
    [maStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(40)]} range:NSMakeRange(0, 4)];
    [maStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(40)]} range:NSMakeRange(4, st.length-5)];
    [maStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(40)]} range:NSMakeRange(st.length-1, 1)];
    tixianLabel.attributedText = maStr;
    [self.backgroundScrollView addSubview:_tixianMoneyLabel = tixianLabel];
    
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(tixianLabel.frame)+ZOOM(12), kScreenWidth, 1)];
    lineView1.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.backgroundScrollView addSubview:lineView1];
    
    CGFloat Margin_udx = ZOOM(30);      //距离line1的距离
    
    CGFloat H_line = ZOOM(600);         //竖线的高度
    CGFloat W_line = kScreenWidth*0.8;    //横线的宽度
    
    //竖线
    UIView *col_lineView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth*0.5-0.5, Margin_udx+CGRectGetMaxY(lineView1.frame), 1, H_line)];
    col_lineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.backgroundScrollView addSubview:col_lineView];
    
    //横线
    UIView *row_lineView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth*0.1, Margin_udx+CGRectGetMaxY(lineView1.frame)+CGRectGetHeight(col_lineView.frame)/2.0, W_line, 1)];
    row_lineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.backgroundScrollView addSubview:row_lineView];
    
    CGFloat Margin_udxx = ZOOM(10);
    CGFloat y1 = Margin_udx+CGRectGetMaxY(lineView1.frame);
    CGFloat y2 = CGRectGetMaxY(row_lineView.frame);
    
    
    CGFloat W_l = kScreenWidth/2.0;   //label的宽
    
    CGFloat H_l = (H_line/2.0-Margin_udxx*3)/2.0;  //label的高
    
    UILabel *label11 = [[UILabel alloc] initWithFrame:CGRectMake(0, y1+Margin_udxx, W_l, H_l)];
//    label11.backgroundColor = COLOR_RANDOM;
    label11.textAlignment = NSTextAlignmentCenter;
    label11.font = kFont6px(28);
    label11.textColor = RGBCOLOR_I(102,102,102);
    label11.text = @"累计收入(元)";
    [self.backgroundScrollView addSubview:label11];
    
    UILabel *label22 = [[UILabel alloc] initWithFrame:CGRectMake(W_l, y1+Margin_udxx, W_l, H_l)];
//    label22.backgroundColor = COLOR_RANDOM;
    label22.textAlignment = NSTextAlignmentCenter;
    label22.font = kFont6px(28);
    label22.text = @"今日收入(元)";
    label22.textColor = RGBCOLOR_I(102,102,102);
    [self.backgroundScrollView addSubview:label22];

    UILabel *label33 = [[UILabel alloc] initWithFrame:CGRectMake(0, y2+Margin_udxx, W_l, H_l)];
//    label33.backgroundColor = COLOR_RANDOM;
    label33.textAlignment = NSTextAlignmentCenter;
    label33.font = kFont6px(28);
    label33.text = @"近一周收入(元)";
    label33.textColor = RGBCOLOR_I(102,102,102);
    [self.backgroundScrollView addSubview:label33];
    
    UILabel *label44 = [[UILabel alloc] initWithFrame:CGRectMake(W_l, y2+Margin_udxx, W_l, H_l)];
//    label44.backgroundColor = COLOR_RANDOM;
    label44.textAlignment = NSTextAlignmentCenter;
    label44.font = kFont6px(28);
    label44.textColor = RGBCOLOR_I(102,102,102);
    label44.text = @"近一月收入(元)";
    [self.backgroundScrollView addSubview:label44];
    
    
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, y1+Margin_udxx*2+H_l, W_l, H_l)];
//    label1.backgroundColor = COLOR_RANDOM;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = kFont6px(42);
    label1.text = [NSString stringWithFormat:@"%.2f", [self.model.two_balance doubleValue]];;
    label1.textColor = COLOR_ROSERED;
    [self.backgroundScrollView addSubview:_moneyLabel1 = label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(W_l, y1+Margin_udxx*2+H_l, W_l, H_l)];
//    label2.backgroundColor = COLOR_RANDOM;
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = kFont6px(42);
    label2.text = @"0.00";
    label2.textColor = COLOR_ROSERED;
    [self.backgroundScrollView addSubview:_moneyLabel2 = label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, y2+Margin_udxx*2+H_l, W_l, H_l)];
//    label3.backgroundColor = COLOR_RANDOM;
    label3.textAlignment = NSTextAlignmentCenter;
    label3.font = kFont6px(42);
    label3.text = @"0.00";
    label3.textColor = COLOR_ROSERED;
    [self.backgroundScrollView addSubview:_moneyLabel3 = label3];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(W_l, y2+Margin_udxx*2+H_l, W_l, H_l)];
//    label4.backgroundColor = COLOR_RANDOM;
    label4.textAlignment = NSTextAlignmentCenter;
    label4.font = kFont6px(42);
    label4.text = @"0.00";
    label4.textColor = COLOR_ROSERED;
    [self.backgroundScrollView addSubview:_moneyLabel4 = label4];
    
    scroll_H = CGRectGetMaxY(col_lineView.frame);
    
    
    self.backgroundScrollView.backgroundColor = [UIColor whiteColor];
    
    if (scroll_H<H_s) {
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, scroll_H, kScreenWidth ,H_s-scroll_H)];
        self.backgroundScrollView.contentSize = CGSizeMake(0, H_s);
        bottomView.backgroundColor = RGBCOLOR_I(244,244,244);
        [self.backgroundScrollView addSubview:bottomView];
        
    } else {
        self.backgroundScrollView.contentSize = CGSizeMake(0, scroll_H);
    }
    
//    self.view.backgroundColor = RGBCOLOR_I(220,220,220);
    
}

- (NSString *)timeInfoWithDateString:(NSString *)timeString
{
    NSString *st = [NSString stringWithFormat:@"%lf",[timeString doubleValue]/1000];
    NSDate *oldDate = [NSDate dateWithTimeIntervalSince1970:[st longLongValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd  HH:mm:ss"];
    NSString *showtimeNew = [formatter stringFromDate:oldDate];
    return [NSString stringWithFormat:@"%@",showtimeNew];
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
