//
//  TFVersionInfoViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/30.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFVersionInfoViewController.h"

@interface TFVersionInfoViewController ()

@end

@implementation TFVersionInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    NSString *buildVersion = [NSString stringWithFormat:@"%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
    
    NSString *title = [NSString stringWithFormat:@"版本信息"];
    
    [super setNavigationItemLeft:title];
    
    [self setupUI];
}

- (void)setupUI
{
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7+ZOOM(80), kScreenWidth, 1)];
    lineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.view addSubview:lineView];
    
    
    CGFloat Margin_lr_iv = ZOOM(286);
    CGFloat H_iv = (kScreenWidth-2*Margin_lr_iv)/2.3;
    CGFloat Margin_ud_iv = ZOOM(100);
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(Margin_lr_iv, Margin_ud_iv+ lineView.bottom, (kScreenWidth-2*Margin_lr_iv), H_iv)];
    iv.image = [UIImage imageNamed:@"logoInfo"];
    [self.view addSubview:iv];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0,  iv.bottom+ZOOM(151), kScreenWidth, 1)];
    line2.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.view addSubview:line2];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,  line2.bottom+ZOOM(120), kScreenWidth, ZOOM(50))];
    label.text = [NSString stringWithFormat:@"当前版本：%@",[self getVersion]];
    label.textColor = RGBCOLOR_I(152,152,152);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = kFont6px(32);
    [self.view addSubview:label];
    
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-ZOOM(380), kScreenWidth, 1)];
    line3.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.view addSubview:line3];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0,  line3.bottom+ZOOM(80), kScreenWidth, ZOOM(50))];
    label2.text = @"云商世纪（深圳）电子商务有限公司 版权所有";
    label2.textColor = RGBCOLOR_I(152,152,152);
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = kFont6px(29);
    [self.view addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0,  label2.bottom+ZOOM(20), kScreenWidth, ZOOM(50))];
    label3.text = @"Copyright 2015 52yifu.com";
    label3.textColor = RGBCOLOR_I(152,152,152);
    label3.textAlignment = NSTextAlignmentCenter;
    label3.font = kFont6px(29);
    [self.view addSubview:label3];

    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(0,  label3.bottom+ZOOM(20), kScreenWidth, ZOOM(50))];
    label4.text = @"All Rights Reserved";
    label4.textColor = RGBCOLOR_I(152,152,152);
    label4.textAlignment = NSTextAlignmentCenter;
    label4.font = kFont6px(29);
    [self.view addSubview:label4];
    
    /*
    //横线
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.translatesAutoresizingMaskIntoConstraints = NO;
    lineView1.backgroundColor = RGBACOLOR_F(0.5,0.5,0.5,0.3);
    [self.view addSubview:lineView1];
    
    //布局
    NSArray *hLine1Array = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[lineView1]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lineView1)];
    [NSLayoutConstraint activateConstraints:hLine1Array];
    NSArray *vLine1Array = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-kNavigationheightForIOS7-[lineView1(1)]" options:0 metrics:@{@"kNavigationheightForIOS7":[NSNumber numberWithInt:kNavigationheightForIOS7]} views:NSDictionaryOfVariableBindings(lineView1)];
    [NSLayoutConstraint activateConstraints:vLine1Array];
    
    //图片
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logoInfo"]];
    logoImageView.translatesAutoresizingMaskIntoConstraints = NO;
    logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:logoImageView];
    
    NSArray *hLogoIvArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-T80-[logoImageView]-T80-|" options:0 metrics:[self TFNSDictionaryOfVariableBindings:@[@"T80",@"T80"]] views:NSDictionaryOfVariableBindings(logoImageView)];
    [NSLayoutConstraint activateConstraints:hLogoIvArray];
    NSArray *vLogoIvArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[lineView1]-T40-[logoImageView(T100)]" options:0 metrics:[self TFNSDictionaryOfVariableBindings:@[@"T40",@"T100"]] views:NSDictionaryOfVariableBindings(lineView1,logoImageView)];
    [NSLayoutConstraint activateConstraints:vLogoIvArray];
    
    //横线
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.translatesAutoresizingMaskIntoConstraints = NO;
    lineView2.backgroundColor = RGBACOLOR_F(0.5,0.5,0.5,0.4);
    [self.view addSubview:lineView2];
    
    //布局
    NSArray *hLine2Array = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[lineView2]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lineView2)];
    [NSLayoutConstraint activateConstraints:hLine2Array];
    NSArray *vLine2Array = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[logoImageView]-T40-[lineView2(1)]" options:0 metrics:[self TFNSDictionaryOfVariableBindings:@[@"T40"]] views:NSDictionaryOfVariableBindings(logoImageView,lineView2)];
    [NSLayoutConstraint activateConstraints:vLine2Array];

    //当前版本
    UILabel *label = [[UILabel alloc] init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.textColor = RGBCOLOR_I(152,152,152);
    label.font = [UIFont systemFontOfSize:ZOOM(48)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"当前版本:V1.0";
    [self.view addSubview:label];
    
    //布局
    NSArray *hLabelArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-T60-[label]-T60-|" options:0 metrics:[self TFNSDictionaryOfVariableBindings:@[@"T60",@"T60"]] views:NSDictionaryOfVariableBindings(label)];
    [NSLayoutConstraint activateConstraints:hLabelArray];
    NSArray *vLabelArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[lineView2]-T30-[label(T30)]" options:0 metrics:[self TFNSDictionaryOfVariableBindings:@[@"T30",@"T30"]] views:NSDictionaryOfVariableBindings(lineView2,label)];
    [NSLayoutConstraint activateConstraints:vLabelArray];

    //横线
    UIView *lineView3 = [[UIView alloc] init];
    lineView3.translatesAutoresizingMaskIntoConstraints = NO;
    lineView3.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.view addSubview:lineView3];
    
    //布局
    NSArray *hLine3Array = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[lineView3]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lineView3)];
    [NSLayoutConstraint activateConstraints:hLine3Array];
    NSArray *vLine3Array = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[lineView3(1)]-T130-|" options:0 metrics:[self TFNSDictionaryOfVariableBindings:@[@"T130"]] views:NSDictionaryOfVariableBindings(lineView3)];
    [NSLayoutConstraint activateConstraints:vLine3Array];


    //公司
    UILabel *label2 = [[UILabel alloc] init];
    label2.translatesAutoresizingMaskIntoConstraints = NO;
    label2.textColor = RGBCOLOR_I(152,152,152);
    label2.font = [UIFont systemFontOfSize:ZOOM(48)];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = @"云商世纪（深圳）电子商务有限公司 版权所有";
    [self.view addSubview:label2];
    NSArray *hLabel2Arr = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[label2]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label2)];
    [NSLayoutConstraint activateConstraints:hLabel2Arr];

    //版权
    UILabel *label3 = [[UILabel alloc] init];
    label3.translatesAutoresizingMaskIntoConstraints = NO;
    label3.textColor = RGBCOLOR_I(152,152,152);
    label3.font = [UIFont systemFontOfSize:ZOOM(48)];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.text = @"CopyRight 2015 52yifu.com";
    [self.view addSubview:label3];
    NSArray *hLabel3Arr = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[label3]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label3)];
    [NSLayoutConstraint activateConstraints:hLabel3Arr];
    
    //英文版权
    UILabel *label4 = [[UILabel alloc] init];
    label4.translatesAutoresizingMaskIntoConstraints = NO;
    label4.textColor = RGBCOLOR_I(152,152,152);
    label4.font = [UIFont systemFontOfSize:ZOOM(48)];
    label4.textAlignment = NSTextAlignmentCenter;
    label4.text = @"All Rights Reserved";
    [self.view addSubview:label4];
    NSArray *hLabel4Arr = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[label4]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label4)];
    [NSLayoutConstraint activateConstraints:hLabel4Arr];

    NSArray *vLabelArr = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[lineView3]-T20-[label2(T30)][label3(T30)][label4(T30)]-T20-|" options:0 metrics:[self TFNSDictionaryOfVariableBindings:@[@"T20",@"T30",@"T30",@"T30",@"T20"]] views:NSDictionaryOfVariableBindings(lineView3,label2,label3,label4)];
    [NSLayoutConstraint activateConstraints:vLabelArr];

     */
    
}

- (NSString*)getVersion
{
    NSString *version = [NSString stringWithFormat:@"V%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    //version = %@", version);
    
    return version;
}


////打印约束
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    
//    for (UIView *view in self.view.subviews) {
//        //%@\n",NSStringFromClass([view class]));
//        for (NSLayoutConstraint* eachCon in view.constraints)
//        {
//            //%@\nPriority:%.0f", eachCon, eachCon.priority);
//        }
//    }
//}

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
