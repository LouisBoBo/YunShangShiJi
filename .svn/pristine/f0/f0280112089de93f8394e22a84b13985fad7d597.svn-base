//
//  TFMyIntegralViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/16.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//
//***********目前没有用到弃用***********

#import "TFMyIntegralViewController.h"
#import "TFIntegralExplainViewController.h"
#import "HYJIntelgralDetalViewController.h"
#import "SignViewController.h"


@interface TFMyIntegralViewController ()

@property (nonatomic, strong)UIImageView *integImageView;

@property (nonatomic, strong)UILabel *countLabel;
@property (nonatomic, strong)UILabel *inLabel;
@property (nonatomic, strong)UILabel *outLabel;
@property (nonatomic, strong)UIButton *signBtn;
@property (nonatomic, strong)UILabel *signLabel;

@property (nonatomic, assign)int signDay;
@property (nonatomic, assign)BOOL isSign;

@end

@implementation TFMyIntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeIntegral:) name:@"integral" object:nil];

    [super setNavigationItemLeft:@"我的积分"];
    
    [self createUI];
    
    [self httpGetIntegral];
}
-(void)changeIntegral:(NSNotification *)note
{
    NSString *string = [NSString stringWithFormat:@"%@",note.object];
    self.countLabel.text = string;
    self.signDay += 1;
}
- (void)createUI
{
    UIButton *explainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [explainBtn setTitle:@"说明" forState:UIControlStateNormal];
    explainBtn.frame = CGRectMake(kScreenWidth-60, 20, 60, 44);
    explainBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    explainBtn.titleLabel.font = kFont6px(34);
    [explainBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];;
    explainBtn.backgroundColor = [UIColor clearColor];
    [explainBtn addTarget:self action:@selector(explainBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:explainBtn];
    
    
    UIImageView *headIv = [[UIImageView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7, kScreenWidth, ZOOM(334))];
    headIv.image = [UIImage imageNamed:@"积分背景.jpg"];
    headIv.backgroundColor = [UIColor grayColor];
    [self.view addSubview:headIv];

    self.integImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2-ZOOM(334)/2, headIv.frame.origin.y+headIv.frame.size.height-ZOOM(334)/2+(10), ZOOM(334), ZOOM(334))];
//    self.integImageView.backgroundColor = BLOCKCOLOR;
    self.integImageView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.integImageView.layer.borderWidth = 2;
    self.integImageView.layer.masksToBounds = YES;
    self.integImageView.layer.cornerRadius = ZOOM(334)/2;
//    self.integImageView.image = [UIImage imageNamed:@"总积分黑"];
    [self.view addSubview:self.integImageView];
    
    CGFloat H_countLabel = CGRectGetHeight(self.integImageView.frame)/4.0;
    CGFloat W_countLabel = CGRectGetWidth(self.integImageView.frame)-ZOOM(40)*2;
    
    CGFloat H_2 = CGRectGetHeight(self.integImageView.frame)/2.0;
    
    
    UILabel *countTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ZOOM(40),H_2-H_countLabel-5, W_countLabel, H_countLabel)];
    countTitleLabel.text = @"总积分";
    countTitleLabel.textAlignment = NSTextAlignmentCenter;
    countTitleLabel.font = [UIFont boldSystemFontOfSize:ZOOM(48)];
    countTitleLabel.adjustsFontSizeToFitWidth = YES;
    countTitleLabel.textColor = [UIColor whiteColor];
    [self.integImageView addSubview:countTitleLabel];
    
    self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(ZOOM(40), H_2, W_countLabel, H_countLabel)];
//    self.countLabel.backgroundColor = [UIColor yellowColor];
    self.countLabel.font = [UIFont boldSystemFontOfSize:ZOOM(100)];
    self.countLabel.adjustsFontSizeToFitWidth = YES;
    self.countLabel.textColor = [UIColor whiteColor];
    self.countLabel.textAlignment = NSTextAlignmentCenter;
//    self.countLabel.text = @"0.00";
    [self.integImageView addSubview:self.countLabel];
    
    NSArray *titleArr = [NSArray arrayWithObjects:@"近一个月进账",@"签到",@"近一个月支出", nil];
    
    CGFloat W_l = ZOOM(200);
    CGFloat margin = (kScreenWidth-W_l*3)/4;
    CGFloat Y_l = CGRectGetMaxY(self.integImageView.frame)+ZOOM(20);
    CGFloat H_l = ZOOM(70);
    
    CGFloat H_bl = ZOOM(70);
    CGFloat W_bl = kScreenWidth/3;
    for (int i= 0 ; i<titleArr.count; i++) {
        UILabel *bottomLabel = [[UILabel alloc] init];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(W_bl*i, Y_l, W_bl, ZOOM(140));
        if (i == 0) {
            self.inLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, Y_l, W_l, H_l)];
            self.inLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
            self.inLabel.textColor = [UIColor whiteColor];
            self.inLabel.layer.masksToBounds  = YES;
            self.inLabel.layer.cornerRadius = H_l/2.0;
            self.inLabel.adjustsFontSizeToFitWidth = YES;
            self.inLabel.textAlignment = NSTextAlignmentCenter;
            self.inLabel.backgroundColor = RGBCOLOR_I(167,167,167);;
//            self.inLabel.text = @"0.00";
            [self.view addSubview:self.inLabel];
            btn.tag = 1000;
            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            bottomLabel.frame = CGRectMake(0+i*W_bl, CGRectGetMaxY(self.inLabel.frame), W_bl, H_bl);
            bottomLabel.center = CGPointMake(self.inLabel.center.x, bottomLabel.center.y);
            bottomLabel.textColor = RGBCOLOR_I(152,152,152);
            [self.view addSubview:btn];
            
        } else if (i == 1) {
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, Y_l, ZOOM(67), ZOOM(67))];
            iv.center = CGPointMake(self.view.center.x, iv.center.y);
            iv.image = [UIImage imageNamed:@"签到"];
            iv.userInteractionEnabled = YES;
            [self.view addSubview:iv];
            bottomLabel.frame = CGRectMake(0+i*W_bl, CGRectGetMaxY(iv.frame), W_bl, H_bl);
            bottomLabel.center = CGPointMake(iv.center.x, bottomLabel.center.y);
            bottomLabel.textColor = COLOR_ROSERED;
            self.signLabel = bottomLabel;
            self.signBtn = btn;
            [self.signBtn addTarget:self action:@selector(signBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:self.signBtn];
            
        } else if (i == 2) {
            self.outLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin*3+W_l*2, Y_l, W_l, H_l)];
            self.outLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
            self.outLabel.textColor = [UIColor whiteColor];
            self.outLabel.backgroundColor = RGBCOLOR_I(167,167,167);
            self.outLabel.layer.masksToBounds  = YES;
            self.outLabel.layer.cornerRadius = H_l/2.0;
            self.outLabel.adjustsFontSizeToFitWidth = YES;
            self.outLabel.textAlignment = NSTextAlignmentCenter;
//            self.outLabel.text = @"0.00";
            [self.view addSubview:self.outLabel];
            bottomLabel.frame = CGRectMake(0+i*W_bl, CGRectGetMaxY(self.outLabel.frame), W_bl, H_bl);
            bottomLabel.center = CGPointMake(self.outLabel.center.x, bottomLabel.center.y);
            bottomLabel.textColor = RGBCOLOR_I(152,152,152);
            btn.tag = 1001;
            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn];
        }
        bottomLabel.text = titleArr[i];
        bottomLabel.textAlignment = NSTextAlignmentCenter;
        bottomLabel.font = kFont6px(28);
        [self.view addSubview:bottomLabel];
    
        
    }
    
    NSArray *titArr = [NSArray arrayWithObjects:@"完善注册信息",@"设置个人头像为自拍",@"认证手机号",@"认证邮箱",@"打分鼓励我们", nil];
    
    CGFloat ST = self.signLabel.frame.origin.y+self.signLabel.frame.size.height;
    
    CGFloat WW = (kScreenHeight-ST-ZOOM(67)-ZOOM(67)); //剩余空间
    CGFloat H = WW/(4*titArr.count); //平均高度
    CGFloat YZ = ST+ZOOM(67);        //0开始的位置

    for (int i = 0; i<titArr.count*2; i++) {
        CGFloat Y = YZ+H+i*H+i*H;
        if (i%2 == 0) {
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-2*H)/2, Y-H, 1.25*H, 1.25*H)];
            iv.tag = 300+i/2;
            iv.center = CGPointMake(self.view.center.x, iv.center.y);
            iv.userInteractionEnabled = YES;
            iv.image = [UIImage imageNamed:@"积分商城未选中"];
            [self.view addSubview:iv];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, Y-H, kScreenWidth, 2*H+H+H+(2));
            btn.tag = 100+i/2;
            [btn addTarget:self action:@selector(cellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn];
            
        } else if (i%2 == 1) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ZOOM(62), Y-H-(1), kScreenWidth-2*ZOOM(62), 2*H-2)];
            label.text = titArr[i/2];
            label.font = [UIFont systemFontOfSize:ZOOM(44)];
            label.center = CGPointMake(self.view.center.x, label.center.y);
            label.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:label];
        }
    }
    
    UIButton *countBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    countBtn.frame = CGRectMake((20), kScreenHeight-(5)-(35), kScreenWidth-(20)*2, (35));
    [countBtn setTitle:@"积分商城" forState:UIControlStateNormal];
    [countBtn setBackgroundImage:[UIImage imageNamed:@"退出账号框"] forState:UIControlStateNormal];
    [countBtn setBackgroundImage:[UIImage imageNamed:@"退出账号框高亮"] forState:UIControlStateHighlighted];
    [countBtn addTarget:self action:@selector(countBtn) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:countBtn];

}

#pragma mark - 获取积分
- (void)httpGetIntegral
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/getIntegral?token=%@&version=%@",[NSObject baseURLStr],token,VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];
    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                [self refreshUI:responseObject]; //刷新UI
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

#pragma mark - 签到
- (void)httpSign
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/everydaySign?token=%@&version=%@",[NSObject baseURLStr],token,VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];
    //URL = %@",URL);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                [MBProgressHUD showSuccess:@"签到成功"];
                self.signLabel.textColor = COLOR_ROSERED;
                self.countLabel.text = [NSString stringWithFormat:@"%@",responseObject[@"integral"]];
                self.signBtn.userInteractionEnabled = NO; //不能在点击了
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

#pragma mark - 刷新UI
- (void)refreshUI:(NSDictionary *)responseObject
{
    NSString *income;
    NSString *integral;
    NSString *expense;
    /*****积分****/
    if (responseObject[@"income"]!=[NSNull null]) {
        income = [NSString stringWithFormat:@"%@",responseObject[@"income"]];//积分进账
    } else {
        income = @"0.00";
    }
    if (responseObject[@"integral"]!=[NSNull null]) {
        integral = [NSString stringWithFormat:@"%@",responseObject[@"integral"]];//积分总额
    } else {
        integral = @"0.00";
    }
    if (responseObject[@"expense"]!=[NSNull null]) {
        expense = [NSString stringWithFormat:@"%@",responseObject[@"expense"]];//积分支出
    } else {
        expense = @"0.00";
    }
    if ([integral intValue]>0) {
        self.integImageView.image = [UIImage imageNamed:@"总积分1"];
    } else {
        self.integImageView.image = [UIImage imageNamed:@"总积分黑"];
    }
    self.countLabel.text = integral;
    self.inLabel.text = income;
    self.outLabel.text = expense;
    
    /******签到*******/
    self.signDay = [responseObject[@"signDay"] intValue];
//    NSString *signDay = [NSString stringWithFormat:@"%@",responseObject[@"signDay"]];//连续签到天数
    //是否签到 0签到,其他未签
    if (responseObject[@"is_sign"] == [NSNull null]) {
        MyLog(@"未签到");
        self.isSign = NO;
        self.signBtn.userInteractionEnabled = YES; //可以点击签到
        self.signLabel.textColor = RGBACOLOR_F(0.5,0.5,0.5,0.8);
        
    } else if ([responseObject[@"is_sign"] intValue]!=0) {
        MyLog(@"未签到");
        self.isSign = NO;
        self.signBtn.userInteractionEnabled = YES; //可以点击签到
        self.signLabel.textColor = RGBACOLOR_F(0.5,0.5,0.5,0.8);

    } else {
        MyLog(@"已经签到");
        self.isSign = YES; //已经签过了
        self.signBtn.userInteractionEnabled = YES; //可以点击签到
        self.signLabel.textColor = COLOR_ROSERED;
    }
    //完成任务
    NSArray *fulfill = responseObject[@"fulfill"];
    NSMutableArray *ivArr = [[NSMutableArray alloc] init];
    for (int i = 0; i<5; i++) {
        UIImageView *iv = (UIImageView *)[self.view viewWithTag:300+i];
        [ivArr addObject:iv];
    }
    NSArray *idArr = @[@1,@2,@3,@4,@5];
    for (NSNumber *num in fulfill) {

        for (int i = 0; i<idArr.count; i++) {
            if ([num isEqualToNumber:idArr[i]]) { //找到完成的任务
                UIImageView *iv = ivArr[i];
                iv.image = [UIImage imageNamed:@"积分商城选中"];
            }
        }
    }
}

#pragma mark - 签到按钮
- (void)signBtnClick:(UIButton *)sender
{
    /*
    //self.isSign = %d",self.isSign);
    if (!self.isSign) { //如果今天没有签到过
        [self httpSign];    //签到
    } else { //已经签到过，不能点击
        [MBProgressHUD showError:@"每天只能签到一次哦"];
        self.signBtn.userInteractionEnabled  = NO;
    }
    */
    SignViewController *view = [[SignViewController alloc]init];
    view.isSign = self.isSign;
    view.signDay = self.signDay;
    view.totalintegral = self.countLabel.text;
    [self.navigationController pushViewController:view animated:YES];
    
}

- (void)cellBtnClick:(UIButton *)sender
{
    MyLog(@"sender.tag = %ld",(long)sender.tag);
    
    SignViewController *view = [[SignViewController alloc]init];
    view.isSign = self.isSign;
    view.signDay = self.signDay;
    view.totalintegral = self.countLabel.text;
    [self.navigationController pushViewController:view animated:YES];

}

#pragma mark - 积分商城
- (void)countBtn
{
    
}

#pragma mark - 说明
- (void)explainBtnClick:(UIButton *)sender
{
    TFIntegralExplainViewController *tivc = [[TFIntegralExplainViewController alloc] init];
    [self.navigationController pushViewController:tivc animated:YES];
}

- (void)click:(UIButton *)sender
{
    HYJIntelgralDetalViewController *vc = [[HYJIntelgralDetalViewController alloc] init];
    vc.index = sender.tag-1000;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
