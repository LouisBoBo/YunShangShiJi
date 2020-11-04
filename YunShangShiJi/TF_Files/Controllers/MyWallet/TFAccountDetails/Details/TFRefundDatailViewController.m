//
//  TFRefundDatailViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/13.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFRefundDatailViewController.h"
#import "TFCellView.h"

@interface TFRefundDatailViewController ()

@property (nonatomic, strong)UILabel *moneyLabel;

@end

@implementation TFRefundDatailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super setNavigationItemLeft:@"退款详情"];
    
    [self createUI];
    
    [self httpGetMoney];
}
#pragma mark - 创建UI
- (void)createUI
{
    NSArray *titleArr = [NSArray arrayWithObjects:@"订单编号:",@"退款金额:",@"退款时间:", @"退至钱包余额:",nil];
    if([self.model.type intValue] == 20)
    {
        titleArr = [NSArray arrayWithObjects:@"提现单号:",@"退款金额:",@"退款时间:", @"退至钱包余额:",nil];
    }
    
    CGFloat lr_Margin = ZOOM(62);
    CGFloat cell_H = ZOOM(150);
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7+ZOOM(80)-1, kScreenWidth, 1)];
    lineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.view addSubview:lineView];
    
    for (int i = 0; i<titleArr.count; i++) {
        TFCellView *tcv = [[TFCellView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7+ZOOM(80)+i*cell_H, kScreenWidth, cell_H)];
        [tcv.headImageView removeFromSuperview];
        tcv.titleLabel.frame = CGRectMake(lr_Margin, 0, (110), tcv.frame.size.height);
        tcv.titleLabel.text = titleArr[i];
        tcv.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
        [tcv.detailImageView removeFromSuperview];
        
        UILabel *label;
        if (i<3) {
            label = [[UILabel alloc] initWithFrame:CGRectMake(tcv.frame.size.width-(200)-lr_Margin, 0, (200), tcv.frame.size.height)];
            label.textAlignment = NSTextAlignmentRight;
        } else {
            
            NSString *st = titleArr[i];
            
            CGSize size = [st boundingRectWithSize:CGSizeMake( 1000,cell_H) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kFont6px(32)} context:nil].size;
            
//            tcv.titleLabel.frame = CGRectMake(lr_Margin, 0, size.width+1, tcv.frame.size.height);
            
            tcv.titleLabel.frame = CGRectMake(lr_Margin, 0, 150, tcv.frame.size.height);
            label = [[UILabel alloc] initWithFrame:CGRectMake(tcv.frame.size.width-(200)-lr_Margin, 0, (200), tcv.frame.size.height)];
            label.textAlignment = NSTextAlignmentRight;
            self.moneyLabel = label;
        }
        label.adjustsFontSizeToFitWidth = YES;
        label.tag = 200+i;
        label.font = [UIFont systemFontOfSize:ZOOM(48)];
        label.adjustsFontSizeToFitWidth = YES;
        [tcv addSubview:label];
        [self.view addSubview:tcv];
        if (i == 0) {
            label.text = self.model.order_code;
        } else if (i == 1) {
            label.text = [NSString stringWithFormat:@"￥%.2f",[self.model.money doubleValue]];
        } else if (i == 2) {
            label.text = [self calculationSecFor1970:[self.model.add_time longLongValue]/1000.0];
        } else if (i == 3) {
//            label.text = [NSString stringWithFormat:@"￥%.2f",[self.model.money doubleValue]];
        }
    }
}

- (void)httpGetMoney
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
                NSString *balanceStr = responseObject[@"balance"];
                self.moneyLabel.text = [NSString stringWithFormat:@"￥%.2f",[balanceStr doubleValue]];
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
- (NSString *)calculationSecFor1970:(long long)theDate
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd  HH:mm:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:theDate];
    NSString *showtimeNew = [dateFormatter stringFromDate:date];
    return showtimeNew;
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
