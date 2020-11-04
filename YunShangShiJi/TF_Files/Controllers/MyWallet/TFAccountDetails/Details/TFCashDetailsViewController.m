//
//  TFCashDetailsViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/13.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFCashDetailsViewController.h"
#import "TFCellView.h"
#import "TFWithdrawCashViewController.h"
@interface TFCashDetailsViewController ()

@property (nonatomic, strong) UIScrollView *backgroundScrollView;
@property (nonatomic, strong) UILabel *whyLabel;
@property (nonatomic, strong) UIButton *applyBtn;


@end
@implementation TFCashDetailsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super setNavigationItemLeft:@"提现详情"];
    
    [self createUI];
}


- (void)createUI
{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7, kScreenWidth, kScreenHeight-kNavigationheightForIOS7)];
    [self.view addSubview:_backgroundScrollView = scrollView];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM(700))];
    bgView.tag = 1000;
//    bgView.backgroundColor = [UIColor yellowColor];
    [self.backgroundScrollView addSubview:bgView];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, bgView.frame.size.height-1, bgView.frame.size.width, 1)];
    lineView.backgroundColor = RGBACOLOR_F(0.5, 0.5, 0.5, 0.2);
    [bgView addSubview:lineView];
    CGFloat imgH = ZOOM(90);
    
    NSArray *tArr = self.model.t_type.integerValue == 2 ? [NSArray arrayWithObjects:@"卖家退款",@"银行受理",@"退款成功", nil] : [NSArray arrayWithObjects:@"开始",@"提交到银行",@"到账", nil];
    for (int i = 0; i<tArr.count; i++) {
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-imgH*3)/6+i*imgH+i*(kScreenWidth-imgH*3)/3, (50), imgH, imgH)];
//        iv.backgroundColor = [UIColor yellowColor];
        iv.image = [UIImage imageNamed:tArr[i]];
        iv.tag = 200+i;
        [bgView addSubview:iv];
        if (i == 0) {
            self.oneIv = iv;
        } else if (i == 1) {
            self.twoIv = iv;
        } else if (i == 2) {
            self.threeIv = iv;
        }
        CGFloat width = ZOOM(280);
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-width*3)/6+i*width+i*(kScreenWidth-width*3)/3, iv.frame.origin.y+iv.frame.size.height+(20), width, (40))];
        label.text = tArr[i];
        label.tag = 300+i;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:ZOOM(50)];
        [bgView addSubview:label];
        
        if (i == 1) {
            self.isSuccessLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-ZOOM(600))/2, label.frame.origin.y+label.frame.size.height+ZOOM(70), ZOOM(600), ZOOM(100))];
//            self.isSuccessLabel.backgroundColor = COLOR_ROSERED;
            self.isSuccessLabel.textColor = COLOR_ROSERED;
            self.isSuccessLabel.textAlignment = NSTextAlignmentCenter;
//            self.isSuccessLabel.backgroundColor = [UIColor yellowColor];
            self.isSuccessLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
            [bgView addSubview:self.isSuccessLabel];
        }
    }
    
    UIImageView *iv1 = (UIImageView *)[self.view viewWithTag:200];
    UIImageView *iv2 = (UIImageView *)[self.view viewWithTag:201];
    
    self.lineView1 = [[UIView alloc] initWithFrame:CGRectMake(iv1.frame.origin.x+iv1.frame.size.width+(5), iv1.frame.origin.y+iv1.frame.size.height/2-1, iv2.frame.origin.x-iv1.frame.origin.x-iv1.frame.size.width-(5)*2, 2)];
    self.lineView1.backgroundColor = [UIColor grayColor];
    [bgView addSubview:self.lineView1];
    
    self.lineView2 = [[UIView alloc] initWithFrame:CGRectMake(iv2.frame.origin.x+iv2.frame.size.width+(5), self.lineView1.frame.origin.y, self.lineView1.frame.size.width, 2)];
//    self.lineView2.backgroundColor = COLOR_ROSERED;
    self.lineView2.backgroundColor = [UIColor grayColor];
    [bgView addSubview:self.lineView2];
    
    
    NSArray *titleArr = self.model.t_type.integerValue == 2 ? [NSArray arrayWithObjects:@"退款金额:",@"银行卡:",@"提交时间:",@"当前状态:", nil] : [NSArray arrayWithObjects:@"提现金额:",@"银行卡:",@"提交时间:",@"当前状态:", nil];
    NSArray *dataArr = [NSArray arrayWithObjects:@"",@"",@"",@"", nil];
    
    CGFloat lr_Margin = ZOOM(62);
    CGFloat cell_H = ZOOM(130);
    
    for (int i = 0; i<titleArr.count; i++) {
        TFCellView *tcv = [[TFCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bgView.frame)+i*cell_H, kScreenWidth, cell_H)];
        [tcv.headImageView removeFromSuperview];
        tcv.titleLabel.frame = CGRectMake(lr_Margin, 0, ZOOM(220), cell_H);
        tcv.titleLabel.text = titleArr[i];
        tcv.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
        [tcv.detailImageView removeFromSuperview];
        
        tcv.tag = 200+i;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(tcv.frame.size.width-ZOOM(700)-lr_Margin, 0, ZOOM(700), tcv.frame.size.height)];
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:ZOOM(48)];
        label.adjustsFontSizeToFitWidth = YES;
        [tcv addSubview:label];
        label.text = dataArr[i];
        [self.backgroundScrollView addSubview:tcv];
        if (i == 0) {
            label.textColor = COLOR_ROSERED;
            self.moneyLabel = label;
        } else if (i == 1) {
            self.cardLabel = label;
        } else if (i == 2) {
            self.timeLabel = label;
        } else if (i == 3) {
            self.statusLabel = label;
        }
    }
    
//    int i = [self getStatus:self.model];
    int i = [self.model.check intValue];

    if (i==0) {
        self.oneIv.image = [UIImage imageNamed:@"开始"];
        self.twoIv.image = [UIImage imageNamed:@"提交到银行0"];
        self.threeIv.image = [UIImage imageNamed:@"到账0"];
        self.isSuccessLabel.text = @"处理中，预计1-2个工作日到账";
        self.isSuccessLabel.textColor = COLOR_ROSERED;
        self.isSuccessLabel.layer.borderColor = [COLOR_ROSERED CGColor];
        self.isSuccessLabel.layer.borderWidth = 1;
    } else if (i == 2 || i == 4 || i==6) {//还没有提交到银行
        self.oneIv.image = [UIImage imageNamed:@"开始"];
//        self.lineView1.backgroundColor = COLOR_ROSERED;
        self.twoIv.image = [UIImage imageNamed:@"提交到银行0"];
//        self.lineView2.backgroundColor = COLOR_ROSERED;
        self.threeIv.image = [UIImage imageNamed:@"到账0"];
        
        if(i == 2)
        {
            self.isSuccessLabel.text = @"失败";
        }else{
            self.isSuccessLabel.text = @"处理中，预计1-2个工作日到账";
        }
        
        self.isSuccessLabel.textColor = COLOR_ROSERED;
        self.isSuccessLabel.layer.borderColor = [COLOR_ROSERED CGColor];
        self.isSuccessLabel.layer.borderWidth = 1;
    }else if (i == 7 || i == 8 || i == 9)
    {
        self.oneIv.image = [UIImage imageNamed:@"开始"];
        self.twoIv.image = [UIImage imageNamed:@"提交到银行"];
        self.threeIv.image = [UIImage imageNamed:@"到账0"];
        self.isSuccessLabel.text = @"处理中，预计1-3个工作日到账";
        self.isSuccessLabel.textColor = COLOR_ROSERED;
        self.isSuccessLabel.layer.borderColor = [COLOR_ROSERED CGColor];
        self.isSuccessLabel.layer.borderWidth = 1;
    }
    
    else if (i == 3 || i==10 ) {//已经提交到银行
        self.oneIv.image = [UIImage imageNamed:@"开始"];
        self.lineView1.backgroundColor = COLOR_ROSERED;
        self.twoIv.image = [UIImage imageNamed:@"提交到银行"];
        
        if(i==3)//到帐成功
        {
            self.lineView2.backgroundColor = COLOR_ROSERED;
            self.threeIv.image = [UIImage imageNamed:@"到账"];
            self.isSuccessLabel.text = @"成功";
            
        }else{
            self.threeIv.image = [UIImage imageNamed:@"到账0"];
            self.isSuccessLabel.text = @"处理中，预计1-2个工作日到账";
        }
        
        self.isSuccessLabel.textColor = COLOR_ROSERED;
        self.isSuccessLabel.layer.borderColor = [COLOR_ROSERED CGColor];
        self.isSuccessLabel.layer.borderWidth = 1;
    }
    else if (i == 11)//银行转账失败
    {
        self.oneIv.image = [UIImage imageNamed:@"开始"];
        self.twoIv.image = [UIImage imageNamed:@"提交到银行0"];
        
        self.threeIv.image = [UIImage imageNamed:@"到账0"];

        self.isSuccessLabel.text = @"失败";
        self.isSuccessLabel.textColor = COLOR_ROSERED;
        self.isSuccessLabel.layer.borderColor = [COLOR_ROSERED CGColor];
        self.isSuccessLabel.layer.borderWidth = 1;

    }
    else{
        self.oneIv.image = [UIImage imageNamed:@"开始"];
        self.lineView1.backgroundColor = COLOR_ROSERED;
        self.twoIv.image = [UIImage imageNamed:@"提交到银行"];
        self.threeIv.image = [UIImage imageNamed:@"到账0"];
        self.isSuccessLabel.text = @"处理中，预计1-2个工作日到账";
        self.isSuccessLabel.textColor = COLOR_ROSERED;
        self.isSuccessLabel.layer.borderColor = [COLOR_ROSERED CGColor];
        self.isSuccessLabel.layer.borderWidth = 1;
    }

    [self changeStatue];
    
    self.moneyLabel.text = [NSString stringWithFormat:@"%.2f元",[self.model.money doubleValue]];
    self.cardLabel.text = [NSString stringWithFormat:@"%@***%@",self.model.collect_bank_name,self.model.collect_bank_code];
    self.timeLabel.text = [self calculationSecFor1970:[self.model.add_date longLongValue]/1000.0];
    
    TFCellView *tcvTemp = (TFCellView *)[self.backgroundScrollView viewWithTag:200+titleArr.count-1];
    
    if (i == 11) {
        
        NSString *st = [NSString stringWithFormat:@"原因:%@", self.model.transfer_error];
        CGSize st_size = [st boundingRectWithSize:CGSizeMake(kScreenWidth-2*lr_Margin, 1000) options: NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: kFont6px(32)} context:nil].size;
        UILabel *whyLabel = [[UILabel alloc] initWithFrame:CGRectMake(lr_Margin, CGRectGetMaxY(tcvTemp.frame)+ZOOM(67), kScreenWidth-2*lr_Margin, st_size.height)];
        whyLabel.text = st;
        whyLabel.numberOfLines = 0;
        whyLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
        [self.backgroundScrollView addSubview: _whyLabel = whyLabel];
        
        CGFloat Magin_lf_btn = ZOOM(62);
        CGFloat H_btn = ZOOM(120);
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(Magin_lf_btn, CGRectGetMaxY(whyLabel.frame)+ZOOM(200), kScreenWidth-2*Magin_lf_btn, H_btn);
        [btn setBackgroundImage:[UIImage imageNamed:@"退出账号框"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"退出账号框高亮"] forState:UIControlStateHighlighted];
        [btn setTitle:@"重新申请" forState:UIControlStateNormal];
        btn.titleLabel.font = kFont6px(32);
        [btn addTarget:self action:@selector(applyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.backgroundScrollView addSubview: _applyBtn = btn];
        

        self.backgroundScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.applyBtn.frame)+ZOOM(100));
        
    }else if (i == 2)
    {
        NSString *st = [NSString stringWithFormat:@"原因:%@", self.model.transfer_error];
        CGSize st_size = [st boundingRectWithSize:CGSizeMake(kScreenWidth-2*lr_Margin, 1000) options: NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: kFont6px(32)} context:nil].size;
        UILabel *whyLabel = [[UILabel alloc] initWithFrame:CGRectMake(lr_Margin, CGRectGetMaxY(tcvTemp.frame)+ZOOM(67), kScreenWidth-2*lr_Margin, st_size.height)];
        whyLabel.text = st;
        whyLabel.numberOfLines = 0;
        whyLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
        [self.backgroundScrollView addSubview: _whyLabel = whyLabel];
        
        self.backgroundScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_whyLabel.frame)+ZOOM(100));

    }
    else {
        self.backgroundScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(tcvTemp.frame)+ZOOM(100));
    }
}

- (void)applyBtnClick:(UIButton *)sender
{
    TFWithdrawCashViewController *twvc = [[TFWithdrawCashViewController alloc] init];
    twvc.type = TFMyWallet;
    [self.navigationController pushViewController:twvc animated:YES];
}

-(void)changeStatue
{
    NSString *pubString = _model.t_type.integerValue == 2?@"退款":@"提现";
    if ([_model.check intValue] == 3) {
        self.statusLabel.text = [NSString stringWithFormat:@"%@成功",pubString];
    } else if ([_model.check intValue] == 0) {
        self.statusLabel.text = @"待审核";
    } else if ([_model.check intValue] == 1) {
        self.statusLabel.text = @"通过";
    } else if ([_model.check intValue] == 2) {////////
        self.statusLabel.text = @"审核不通过";
    } else if ([_model.check intValue] == 4) {////////
        self.statusLabel.text = @"审核已通过";
    } else if ([_model.check intValue] == 6) {
        self.statusLabel.text = [NSString stringWithFormat:@"%@已发起",pubString];
    } else if ([_model.check intValue] == 7) {
        self.statusLabel.text = [NSString stringWithFormat:@"%@已提交至开户行",pubString];
    } else if ([_model.check intValue] == 8) {
        self.statusLabel.text = @"开户行发放中，预计1个工作日内到账";
    } else if ([_model.check intValue] == 9) {
        self.statusLabel.text = @"开户行发放中，预计1个工作日内到账";
    } else if ([_model.check intValue] == 10) {
        self.statusLabel.text = [NSString stringWithFormat:@"%@成功",pubString];
    } else if ([_model.check intValue] == 11) {
        self.statusLabel.text = @"转账失败";
    } else if ([_model.check intValue] == 12) {
        self.statusLabel.text = @"已重新申请";
    }
}
- (int)getStatus:(DrawCashModel *)model
{
    int i = [model.check intValue];
    if (i == 0) {
        return 1;
    } else if (i == 1||i == 2) {
        return 2;
    } else if (i == 3) {
        return 3;
    } else {
        return 0;
    }
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
