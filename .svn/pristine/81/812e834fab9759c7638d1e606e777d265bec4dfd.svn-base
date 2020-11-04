//
//  TFBindingPhoneViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/1.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFBindingPhoneViewController.h"
#import "TFCellView.h"

#import "TFBindingEmailViewController.h"
#import "TFOldPaymentViewController.h"

@interface TFBindingPhoneViewController ()

@property (nonatomic, strong)UILabel *phoneLabel;
@property (nonatomic, strong)UILabel *statusLabel;

@end

@implementation TFBindingPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super setNavigationItemLeft:_navTitle];
    
    [self createUI];
}

- (void)createUI
{
    
    CGFloat lr_Margin = ZOOM(62);
    CGFloat ud_Margin = ZOOM(50);
    
    CGFloat H = ZOOM(60)+ud_Margin*2;
    
    TFCellView *tc1 = [[TFCellView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7, kScreenWidth, H)];
    [tc1.headImageView removeFromSuperview];
    [tc1.detailImageView removeFromSuperview];
    tc1.titleLabel.frame = CGRectMake(lr_Margin, 0, lr_Margin*3, H);
    tc1.titleLabel.text = _leftTitle;
    tc1.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
    tc1.titleLabel.textColor = RGBCOLOR_I(34,34,34);
    self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake( tc1.titleLabel.right+lr_Margin, 0, lr_Margin*6, H)];
    [tc1 addSubview:self.phoneLabel];
    self.phoneLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
    self.phoneLabel.textColor = COLOR_ROSERED;
    self.phoneLabel.text = [NSString stringWithFormat:@"%@****%@",[self.phone substringToIndex:3],[self.phone substringWithRange:NSMakeRange(self.phone.length-4, 4)]];
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-lr_Margin-lr_Margin*4, 0, lr_Margin*4, H)];
    self.statusLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
    self.statusLabel.textColor = RGBCOLOR_I(137,137,137);
    self.statusLabel.textAlignment = NSTextAlignmentRight;
    self.statusLabel.text = @"已绑定";
    [tc1 addSubview:self.statusLabel];
    [self.view addSubview:tc1];
    
    TFCellView *tc2 = [[TFCellView alloc] initWithFrame:CGRectMake(0,  tc1.bottom, kScreenWidth, H)];
    [tc2.headImageView removeFromSuperview];
    tc2.titleLabel.frame = CGRectMake(lr_Margin, 0, kScreenWidth-tc2.titleLabel.frame.origin.x-ZOOM(32)-lr_Margin, H);
    tc2.titleLabel.text = _subTitle;
    tc2.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
    tc2.titleLabel.textColor = RGBCOLOR_I(34,34,34);
//    tc2.detailImageView.frame = CGRectMake(kScreenWidth-ZOOM(32)-lr_Margin, (H-ZOOM(72))/2, ZOOM(32), ZOOM(72));;
    tc2.detailImageView.frame = CGRectMake(kScreenWidth-ZOOM(32)-ZOOM(42), ((H)-ZOOM(32))/2, ZOOM(32), ZOOM(32));

    tc2.detailImageView.image = [UIImage imageNamed:@"详细"];
    tc2.cellBtn.tag = 100;
    [tc2.cellBtn addTarget:self action:@selector(cellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tc2];

}

- (void)cellBtnClick:(UIButton *)sender
{
    if (sender.tag == 100&&[_navTitle isEqualToString:@"绑定手机"]) { //更换绑定的手机
        //
        TFOldPaymentViewController *tovc = [[TFOldPaymentViewController alloc] init];
        tovc.headTitle = @"更换绑定手机";
        tovc.leftStr = @"新手机号";
        tovc.plaStr = @"请输入手机号码";
        tovc.labelStr = @"请输入您需要绑定的新手机号码";
        tovc.oldPhone = self.phone;
        tovc.index = 2;
        [self.navigationController pushViewController:tovc animated:YES];
    }else if ([_navTitle isEqualToString:@"绑定邮箱"]){
        
        TFBindingEmailViewController *tevc = [[TFBindingEmailViewController alloc] init];
        [self.navigationController pushViewController:tevc animated:YES];
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
