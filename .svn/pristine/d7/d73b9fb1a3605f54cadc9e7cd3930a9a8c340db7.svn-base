//
//  TFBankListViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/8.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFBankListViewController.h"
#import "TFCellView.h"

@interface TFBankListViewController ()
@property (nonatomic, strong)UIScrollView *backgroundScrollView;

@end

@implementation TFBankListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super setNavigationItemLeft:@"银行列表"];
    
    [self createUI];
}

#pragma mark - 创建UI
- (void)createUI
{
    
    self.backgroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7, kScreenWidth, kScreenHeight-kNavigationheightForIOS7)];
    //    self.backgroundScrollView.bounces = NO;
    self.backgroundScrollView.contentSize = CGSizeMake(kScreenWidth, 400+144);
    self.backgroundScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.backgroundScrollView];

    
    NSArray *titleArr = [NSArray arrayWithObjects:@"中国银行",@"农业银行",@"工商银行",@"建设银行",@"交通银行",@"邮政银行",@"招商银行",@"中信银行",@"浦发银行",@"光大银行", nil];
    
    CGFloat H = ZOOM(150);
    CGFloat up_top = ZOOM(40);
    CGFloat l_margin = ZOOM(62);
    
    for (int i = 0; i<titleArr.count; i++) {
        TFCellView *tc = [[TFCellView alloc] initWithFrame:CGRectMake(0, 0+H*i, kScreenWidth, H)];
        tc.headImageView.frame = CGRectMake(l_margin, up_top, ZOOM(70), ZOOM(70));
        tc.headImageView.image = [UIImage imageNamed:titleArr[i]];
        tc.titleLabel.frame = CGRectMake(tc.headImageView.frame.origin.x+tc.headImageView.frame.size.width+ZOOM(54), 0, (100), tc.frame.size.height);
        tc.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
        tc.titleLabel.text = titleArr[i];
        [tc.detailImageView removeFromSuperview];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(tc.frame.size.width-l_margin-(150), 0, (150), tc.frame.size.height)];
        label.text = @"储蓄卡";
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:ZOOM(44)];
        [tc addSubview:label];
        
        tc.cellBtn.tag = 100+i;
        
        [self.backgroundScrollView addSubview:tc];
        
//        //%@",tc);
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
