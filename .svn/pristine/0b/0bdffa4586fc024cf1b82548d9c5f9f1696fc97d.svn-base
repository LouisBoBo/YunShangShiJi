//
//  ExchangeInvitViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/10/16.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "ExchangeInvitViewController.h"
#import "InvitCodeViewController.h"
#import "GlobalTool.h"
@interface ExchangeInvitViewController ()

@end

@implementation ExchangeInvitViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"兑换邀请码";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    
    
    [self creatView];

}

- (void)creatView
{
    if([self.changestatue isEqualToString:@"success"])
    {
        self.tittleimage.frame =CGRectMake((kApplicationWidth-ZOOM(40*3.4))/2, self.tittleimage.frame.origin.y, ZOOM(40*3.4), ZOOM(40*3.4));
        self.tittleimage.image = [UIImage imageNamed:@"成功"];
        
        self.titlelable1.text = [NSString stringWithFormat:@"兑换成功"];
        self.titlelable2.text = [NSString stringWithFormat:@"获得现金红包100元"];
        
        self.titlelable1.font = [UIFont systemFontOfSize:ZOOM(48)];
        self.titlelable2.font = [UIFont systemFontOfSize:ZOOM(48)];
    }
    else{
        
        self.tittleimage.frame =CGRectMake((kApplicationWidth-ZOOM(40*3.4))/2, self.tittleimage.frame.origin.y, ZOOM(40*3.4), ZOOM(40*3.4));
        self.tittleimage.image = [UIImage imageNamed:@"失败"];
        
        self.titlelable1.text = [NSString stringWithFormat:@"兑换失败"];
        self.titlelable2.text = [NSString stringWithFormat:@"请确认邀请码是否正确"];
        
        self.titlelable1.font = [UIFont systemFontOfSize:ZOOM(48)];
        self.titlelable2.font = [UIFont systemFontOfSize:ZOOM(48)];
    
    }
    
}

-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
   }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


- (IBAction)okbtn:(id)sender {
    
    MyLog(@"ok");
    
//    [self.navigationController popViewControllerAnimated:YES];
    for(UIViewController *VC in self.navigationController.viewControllers)
    {
        if([VC isKindOfClass:[InvitCodeViewController class]])
        {
            [self.navigationController popToViewController:VC animated:YES];
        }
    }

}
@end
