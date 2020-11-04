//
//  TFAboutWeViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/3.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFAboutWeViewController.h"

#import "TFCellView.h"
#import "TFWelcomeView.h"

#import "TFVersionInfoViewController.h"

#import "TFHomeViewController.h"
#import "TFUserCardViewController.h"

@interface TFAboutWeViewController ()

@end

@implementation TFAboutWeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super setNavigationItemLeft:@"关于我们"];
    
    [self createUI];
    
}

#pragma mark - 创建UI
- (void)createUI
{
    NSString *contentStr = [NSString stringWithFormat:@"       衣蝠网是深圳市云商世纪电子商务有限公司运营的时尚电商平台，通过直接打通供应链，对接设计师原创力量，致力于成为移动电商时代最棒的女性设计电商平台之一。为广大女性消费者带来物美价廉的美与时尚的生活方式。"];
    
    CGFloat lr_Margin = ZOOM(62);
    CGFloat lrView_Margin = ZOOM(50);
    CGFloat lr_W = lr_Margin+lrView_Margin;
    
    CGSize size = [contentStr boundingRectWithSize:CGSizeMake(kScreenWidth-lr_W*2, ZOOM(5000)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kFont6px(25)} context:nil].size;
    
    CGFloat SW = size.width;
    CGFloat SH = size.height;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(lr_Margin, kNavigationheightForIOS7+ZOOM(80), SW+lrView_Margin*2, SH+lrView_Margin*2)];
    bgView.layer.cornerRadius = ZOOM(15);
    bgView.layer.borderColor = [RGBCOLOR_I(220,220,220) CGColor];
    bgView.layer.masksToBounds = YES;
    bgView.layer.borderWidth = ZOOM(3);
    [self.view addSubview:bgView];

    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(lrView_Margin, lrView_Margin, SW, SH)];
    contentLabel.text = contentStr;
    contentLabel.numberOfLines = 0;
    contentLabel.font = kFont6px(25);
    [bgView addSubview:contentLabel];
    
    
    CGFloat H = ZOOM(160);
    
    //欢迎页
    NSArray *titleArr = [NSArray arrayWithObjects:@"欢迎页",@"版本信息", nil];
    for (int i = 0; i<titleArr.count; i++) {
        TFCellView *tcv = [[TFCellView alloc] initWithFrame:CGRectMake(lr_Margin,  bgView.bottom+ZOOM(20)+i*H, kScreenWidth-2*lr_Margin, H)];
        tcv.cellBtn.tag = 100+i;
        [tcv.cellBtn addTarget:self action:@selector(cellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [tcv.headImageView removeFromSuperview];
        tcv.titleLabel.frame = CGRectMake(0, 0, ZOOM(300), tcv.frame.size.height);
        tcv.titleLabel.text = titleArr[i];
        tcv.titleLabel.font = kFont6px(32);
//        tcv.detailImageView.frame = CGRectMake(CGRectGetWidth(tcv.frame)-ZOOM(32), ((H)-ZOOM(72))/2, ZOOM(32), ZOOM(72));
        tcv.detailImageView.frame = CGRectMake(kScreenWidth-ZOOM(32)-ZOOM(42), ((H)-ZOOM(32))/2, ZOOM(32), ZOOM(32));

        tcv.detailImageView.image = [UIImage imageNamed:@"详细"];
        [self.view addSubview:tcv];
    }
}






- (void)cellBtnClick:(UIButton *)sender
{
    if (sender.tag == 100) {
        TFWelcomeView *twv = [[TFWelcomeView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        [window addSubview:twv];
        __weak TFWelcomeView *t = twv;
        [twv setWelcomeBlock:^{
            [t removeFromSuperview];
        }];
    } else if (sender.tag == 101) { //版本信息
//        TFHomeViewController *tv = [[TFHomeViewController alloc] init];

//        TFUserCardViewController *tv = [[TFUserCardViewController alloc] init];
        
        TFVersionInfoViewController *tv = [[TFVersionInfoViewController alloc] init];
        [self.navigationController pushViewController:tv animated:YES];
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
