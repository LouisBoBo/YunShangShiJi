//
//  ServiceViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/7/9.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "ServiceViewController.h"
#import "GlobalTool.h"
#import "RobotManager.h"
@interface ServiceViewController ()
{
    UITableView *_mytableview;
    
    NSMutableArray *_DataArray;
    
    NSArray *_titlearr;
    
    NSArray *_detailarr;
    
    NSArray *_typearr;
}
@end

@implementation ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 46, 46);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"选择服务";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    _titlearr=@[@"售前人工咨询",@"售后人工咨询",@"投诉建议",@"智能自助服务"];
    _detailarr=@[@"商品挑选,购买,活动咨询,会员帐号,注册帐户信息维护等咨询",@"退款退货,交易完成评价,维权投诉等各种售后类问题咨询服务",@"提供维权投诉,以及意见反馈的服务",@"7x24时在线,无需等待,即问即答"];
    _typearr=@[@"售前客服",@"售后客服",@"投诉建议",@"自助服务"];
    
    [self creatView];

}

-(void)viewWillAppear:(BOOL)animated
{
    Myview.hidden=YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    Myview.hidden=NO;
}

-(void)creatView
{
    UIView *headview=[[UIView alloc]initWithFrame:CGRectMake(0, 64, kApplicationWidth, 40)];
    headview.backgroundColor=kBackgroundColor;
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, kApplicationWidth, 40)];

    lable.text=@"客服工作时间:周一至周日9:00-22:00节假日除外";
    lable.font=[UIFont systemFontOfSize:14];
    [headview addSubview:lable];
    
    
    _mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kApplicationWidth, kApplicationHeight-Height_NavBar-50+kUnderStatusBarStartY)];
    _mytableview.delegate=self;
    _mytableview.dataSource=self;
    _mytableview.rowHeight=100;
    _mytableview.separatorStyle = UITableViewCellSelectionStyleNone;
    _mytableview.tableHeaderView=headview;
    [self.view addSubview:_mytableview];
    
    UIView *footview=[[UIView alloc]initWithFrame:CGRectMake(20, kApplicationHeight-50+kUnderStatusBarStartY, kApplicationWidth-40, 40)];
    footview.layer.borderWidth=1;
    footview.layer.borderColor=kBackgroundColor.CGColor;
    footview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footview];
    
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(30, 5, 30, 30)];
    imageview.image=[UIImage imageNamed:@"客服电话"];
    imageview.clipsToBounds=YES;
    imageview.layer.cornerRadius=15;
    [footview addSubview:imageview];
    
    UILabel *phonelable=[[UILabel alloc]initWithFrame:CGRectMake(60, 5, footview.frame.size.width-60, 30)];
    phonelable.text=@"客服电话:400-888-4224";
    
    phonelable.textAlignment = NSTextAlignmentCenter;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(phoneclick:)];
    [footview addGestureRecognizer:tap];
    footview.userInteractionEnabled=YES;
    
    [footview addSubview:phonelable];

}

#pragma mark 打电话
-(void)phoneclick:(UITapGestureRecognizer*)tap
{
    MyLog(@"打电话");
    
    UIActionSheet *phonesheet=[[UIActionSheet alloc]initWithTitle:@"联系客服" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@" 400-888-4224", nil];
    [phonesheet showInView:self.view];
    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"联系客服" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"400-888-4224", nil];
//    [alertView show];
    
    
}
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if(buttonIndex==0)//打电话
//    {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008884224"]];
//    }
//}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)//打电话
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008884224"]];
    }
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString* suppid = [user objectForKey:PTEID];
    
//    NSString *suppid = [NSString stringWithFormat:@"%@",@"915"];
    
    if(indexPath.row==0)
    {
        [self Message:suppid];
        
    }else if (indexPath.row==1)
    {
        [self Message:suppid];
        
    }else if (indexPath.row==2)
    {
        [self Message:suppid];
        
    }else if (indexPath.row==3)
    {
        [self Message:suppid];
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *titltlable=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, kApplicationWidth-90, 30)];

    titltlable.text=_titlearr[indexPath.row];
    
    UILabel *detaillable=[[UILabel alloc]initWithFrame:CGRectMake(10, 40, kApplicationWidth-90, 50)];
    detaillable.textColor=kTextGreyColor;
    detaillable.font = [UIFont systemFontOfSize:14];
    detaillable.numberOfLines=0;
    detaillable.text=_detailarr[indexPath.row];
    
    UILabel *linelable=[[UILabel alloc]initWithFrame:CGRectMake(0, 99, kApplicationWidth, 1)];
    linelable.backgroundColor=kBackgroundColor;
    [cell addSubview:linelable];
    
    UILabel *typelable=[[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth-70, 20, 60, 60)];
    typelable.backgroundColor=tarbarrossred;
    typelable.textColor=[UIColor whiteColor];
    typelable.text=_typearr[indexPath.row];
    typelable.numberOfLines=0;
    typelable.font=[UIFont systemFontOfSize:22];
    typelable.textAlignment=NSTextAlignmentCenter;
    
    [cell addSubview:titltlable];
    [cell addSubview:detaillable];
    [cell addSubview:typelable];
    
    return cell;
}

#pragma mark 聊天
-(void)Message:(NSString*)suppid
{
//    suppid = @"915";
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    suppid = [user objectForKey:PTEID];

    // begin 赵官林 2016.5.26
    [self messageWithSuppid:suppid title:nil model:nil detailType:nil imageurl:nil];
    // end
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
