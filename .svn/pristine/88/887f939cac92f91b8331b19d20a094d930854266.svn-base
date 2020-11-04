//
//  WTFChangePhoneNumController.m
//  YunShangShiJi
//
//  Created by yssj on 16/2/29.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "WTFChangePhoneNumController.h"
#import "GlobalTool.h"
#import "WTFOldPhoneNumController.h"

@interface WTFChangePhoneNumController ()

@end

@implementation WTFChangePhoneNumController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    [self setNavigationItemLeft:@"绑定手机号"];
    [self creatMainView];
}
- (void)setNavigationItemLeft:(NSString *)title
{
    
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    headview.image=[UIImage imageNamed:@"导航背景"];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn addTarget:self action:@selector(leftBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
//    [backbtn setImage:[UIImage imageNamed:@"返回按钮_高亮"] forState:UIControlStateHighlighted];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, headview.frame.size.width, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text= title;
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
}
-(void)creatMainView
{
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 84, kScreenWidth, 1)];
    topLine.backgroundColor=lineGreyColor;
    [self.view addSubview:topLine];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62),CGRectGetMaxY(topLine.frame),80 , 50)];
    label.text=@"手机号";
    [self.view addSubview:label];
    UILabel *phoneNum=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), label.frame.origin.y, 200, label.frame.size.height)];
    phoneNum.textColor=kTextColor;
    phoneNum.text=[NSString stringWithFormat:@"%@****%@",[self.phone substringToIndex:3],[self.phone substringWithRange:NSMakeRange(self.phone.length-4, 4)]];
    [self.view addSubview:phoneNum];
    
    UIButton *changeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    changeBtn.frame=CGRectMake(kScreenWidth-ZOOM(62)-80, label.frame.origin.y+5, 80, 40);
    changeBtn.backgroundColor=tarbarrossred;
    [changeBtn setTitle:@"更换" forState:UIControlStateNormal];
    [changeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [changeBtn addTarget:self action:@selector(changeBtnClick:) forControlEvents:UIControlEventTouchUpInside ];
    [self.view addSubview:changeBtn];
    
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), kScreenWidth, 1)];
    bottomLine.backgroundColor=lineGreyColor;
    [self.view addSubview:bottomLine];
}
-(void)changeBtnClick:(UIButton *)sender
{
    WTFOldPhoneNumController *view=[[WTFOldPhoneNumController alloc]init];
    view.oldPhoneNum=_phone;
    [self.navigationController pushViewController:view animated:YES];
}
- (void)leftBarButtonClick
{
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
