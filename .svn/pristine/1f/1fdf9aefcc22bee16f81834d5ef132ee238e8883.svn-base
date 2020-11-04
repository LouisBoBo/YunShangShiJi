//
//  QRCodeVC.m
//  YunShangShiJi
//
//  Created by yssj on 2016/10/13.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "QRCodeVC.h"
#import "GlobalTool.h"
#import "UIImage+CFQRcode.h"


@interface QRCodeVC ()

@end

@implementation QRCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    [self setNavgationView];
    
    [self setMainView];
}
- (void)setMainView {
    UIView *mainView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ZOOM6(578), ZOOM6(900))];
    mainView.backgroundColor=[UIColor whiteColor];
    mainView.center=CGPointMake(self.view.center.x, self.view.center.y+32);
    mainView.layer.cornerRadius=3;
    [self.view addSubview:mainView];
    
    UIImageView *userImg=[[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(mainView.frame)-ZOOM6(120))/2, ZOOM6(60), ZOOM6(120), ZOOM6(120))];
    NSString *aPath=[NSString stringWithFormat:@"%@/Documents/headImgae%@.png",NSHomeDirectory(),[[NSUserDefaults standardUserDefaults] objectForKey:USER_ID]];
    UIImage *imgFromUrl=[[UIImage alloc] initWithContentsOfFile:aPath];
    userImg.image=imgFromUrl;
    userImg.layer.cornerRadius=ZOOM6(60);
    userImg.clipsToBounds=YES;
    [mainView addSubview:userImg];
    UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(userImg.frame)+ZOOM6(20), mainView.frame.size.width, ZOOM6(90))];
    name.numberOfLines=2;
    name.textColor=kMainTitleColor;
    name.textAlignment=NSTextAlignmentCenter;
    name.font=[UIFont systemFontOfSize:ZOOM6(36)];
    name.text=[NSString stringWithFormat:@"%@\n向你发出扫码邀请",[[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME]];
    [mainView addSubview:name];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(name.frame)+ZOOM6(20), mainView.frame.size.width, 0.5)];
    line.backgroundColor=kTableLineColor;
    [mainView addSubview:line];
    
    UIImageView *codeView=[[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(mainView.frame)-ZOOM6(440))/2, CGRectGetMaxY(line.frame)+ZOOM6(20), ZOOM6(440), ZOOM6(440))];
    
    NSString *QRCodeURL = [NSString stringWithFormat:@"%@view/download/6.html?realm=%@",[NSString baseH5ShareURLStr],[[NSUserDefaults standardUserDefaults]objectForKey:USER_ID]];

    [UIImage qrImageWithString:QRCodeURL size:ZOOM6(430) completion:^(UIImage *image) {
        codeView.image=image;
    }];
    [mainView addSubview:codeView];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(codeView.frame)+ZOOM6(20), mainView.frame.size.width, ZOOM6(30))];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=kSubTitleColor;
    label.font=[UIFont systemFontOfSize:ZOOM6(30)];
    label.text=@"扫一扫加入衣蝠";
    [mainView addSubview:label];
    
//    codeView.backgroundColor=DRandomColor;
//    name.backgroundColor=DRandomColor;
//    label.backgroundColor=DRandomColor;
}


- (void)setNavgationView {
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar-1)];
    headview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 46, 46);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"扫码邀请";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, headview.frame.size.height, kApplicationWidth, 0.5)];
    line.backgroundColor = kNavLineColor;
    [headview addSubview:line];
    
}
- (void)goBack:(UIButton *)btn {
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
