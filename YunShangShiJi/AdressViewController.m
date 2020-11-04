//
//  AdressViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/24.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "AdressViewController.h"
#import "AdressTableViewCell.h"
#import "AddAdressViewController.h"
#import "GlobalTool.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "NavgationbarView.h"
#import "AFNetworking.h"
#import "MyMD5.h"
#import "AdressModel.h"
#import "AccountAddressViewController.h"

#import "HZAreaPickerView.h"
#import "LoginViewController.h"
@interface AdressViewController ()

@end

@implementation AdressViewController
{
    //列表
    UITableView *_Mytableview;
    //数据源
    NSMutableArray *_DataArray;
    //默认收货地址数据源
//    NSMutableArray *_delevaryArray;
    
    
    //选中编辑按钮数据源
    NSMutableArray *_EditArray;
    UIButton *_selectbtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    _DataArray=[NSMutableArray array];
    _EditArray=[NSMutableArray array];
    _selectbtn=[[UIButton alloc]init];
    _selectbtn.tag=1000;
    
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 46, 46);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"选择收货地址";
    titlelable.textColor=[UIColor blackColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(kApplicationWidth-50, 20, 40, 40);
    button.centerY = View_CenterY(headview);
    [button setTitle:@"管理" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(Add:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:button];
    
    
    [self creatView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Myview.hidden=YES;
    [_DataArray removeAllObjects];
    [self AddressHttp];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
}

#pragma mark 获取所有收货地址
-(void)AddressHttp
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    
    NSString *url=[NSString stringWithFormat:@"%@address/queryall?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        //responseObject is %@",responseObject);
//        responseObject = [NSDictionary changeType:responseObject];

        
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            if(str.intValue==1)
            {
                for(NSDictionary *dic in responseObject[@"listdt"])
                {
                    AdressModel *model=[[AdressModel alloc]init];
                    model.address=dic[@"address"];
                    model.area=dic[@"area"];
                    model.city=dic[@"city"];
                    model.consignee=dic[@"consignee"];
                    model.addressid=dic[@"id"];
                    model.is_default=dic[@"is_default"];
                    model.phone=dic[@"phone"];
                    model.postcode=dic[@"postcode"];
                    model.province=dic[@"province"];
                    model.street=dic[@"street"];
                    model.user_id=dic[@"user_id"];
                    
                    [_DataArray addObject:model];
                    
                }
                
                for(int i=0;i<_DataArray.count;i++)
                {
                    AdressModel *model=_DataArray[i];
                    if(model.is_default.intValue==1)
                    {
                        [_DataArray exchangeObjectAtIndex:0 withObjectAtIndex:i];
                        break;
                    }
                }
                
                [_Mytableview reloadData];
            }
            else if(str.intValue == 10030){//没登录状态
                
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud removeObjectForKey:USER_TOKEN];
                
                LoginViewController *login=[[LoginViewController alloc]init];
                
                login.tag=1000;
                login.loginStatue = @"10030";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
                
            }
            
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        
        
    }];
 

}


#pragma mark 创建主界面
-(void)creatView
{
    _Mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kApplicationWidth, kApplicationHeight-Height_NavBar) style:UITableViewStylePlain];
//    [_Mytableview registerNib:[UINib nibWithNibName:@"AdressTableViewCell" bundle:nil] forCellReuseIdentifier:@"AdressCell"];
    
    _Mytableview.delegate=self;
    _Mytableview.dataSource=self;
    _Mytableview.rowHeight=80;
    [self.view addSubview:_Mytableview];
    
   
}
-(void)Add:(UIButton *)sender
{
    //管理");
    AccountAddressViewController *addadress=[[AccountAddressViewController alloc]init];
    addadress.dataarray=[NSArray arrayWithArray:_DataArray];
    [self.navigationController pushViewController:addadress animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _DataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath)
    {
        AdressModel *model=[[AdressModel alloc]init];

        _selectbtn.selected=NO;

        UIButton *markbtn=(UIButton*)[self.view viewWithTag:1000+indexPath.row];
        markbtn.selected=YES;
    
        _selectbtn=markbtn;
        
        if(_DataArray.count)
        {
            model=_DataArray[indexPath.row];
        }
        
            
        AdressTableViewCell *cell = (AdressTableViewCell *)[_Mytableview cellForRowAtIndexPath:indexPath];
        //注册通知
        
        NSNotification *notification=[NSNotification notificationWithName:@"changeaddress" object:model];
        
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
  
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     AdressTableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"AdressTableViewCell" owner:self options:nil].lastObject;
    
        HZAreaPickerView *pickview=[[HZAreaPickerView alloc]init];
        if(indexPath.row==0 && _DataArray.count)
        {
             AdressModel *model=_DataArray[indexPath.row];
            
            cell.Ordername.text=[NSString stringWithFormat:@"%@",model.consignee];
            cell.OrderPhone.text=[NSString stringWithFormat:@"%@",model.phone];
            
            //通过地址ID查询确切地址
            NSMutableString *addressString=[NSMutableString string];
            [addressString appendString:[NSString stringWithFormat:@"%@",model.province]];
            [addressString appendString:@"_"];
            [addressString appendString:[NSString stringWithFormat:@"%@",model.city]];
            [addressString appendString:@"_"];
            [addressString appendString:[NSString stringWithFormat:@"%@",model.area]];
            if(model.street !=nil)
            {
                [addressString appendString:@"_"];
                [addressString appendString:[NSString stringWithFormat:@"%@",model.street]];
            }
            
            NSString *addStr= [pickview fromIDgetAddress:addressString];
            cell.OrderAddress.text=[NSString stringWithFormat:@"[默认]%@%@",addStr,model.address];
        
    
            
            NSString *string1 = cell.OrderAddress.text;
            NSString *string2;
            NSString *string3;
            
            
            string2 = [string1 substringToIndex:4];
            string3 = [string1 substringFromIndex:4];
            //string2:%@ string3:%@",string2,string3);
            
            NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",string2,string3]];
            
            [str1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, string2.length)];
            [str1 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(string2.length, string3.length)];
            
            cell.OrderAddress.attributedText = str1;
            

        }else if(indexPath.row>0)
        {
            if(_DataArray.count)
            {
                AdressModel *model=_DataArray[indexPath.row];
                
                cell.Ordername.text=[NSString stringWithFormat:@"%@",model.consignee];
                cell.OrderPhone.text=[NSString stringWithFormat:@"%@",model.phone];
                
                //通过地址ID查询确切地址
                NSMutableString *addressString=[NSMutableString string];
                [addressString appendString:[NSString stringWithFormat:@"%@",model.province]];
                [addressString appendString:@"_"];
                [addressString appendString:[NSString stringWithFormat:@"%@",model.city]];
                [addressString appendString:@"_"];
                [addressString appendString:[NSString stringWithFormat:@"%@",model.area]];
                if(model.street !=nil)
                {
                    [addressString appendString:@"_"];
                    [addressString appendString:[NSString stringWithFormat:@"%@",model.street]];
                }
                
                NSString *addStr= [pickview fromIDgetAddress:addressString];

        
                cell.OrderAddress.text=[NSString stringWithFormat:@"%@%@",addStr,model.address];
            }

        }
        
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    cell.markbtn.selected=NO;

    
    UIButton *markbtn=[[UIButton alloc]init];
    markbtn.frame=cell.markbtn.frame;
    markbtn.frame=CGRectMake(kApplicationWidth-40, cell.markbtn.frame.origin.y, cell.markbtn.frame.size.width, cell.markbtn.frame.size.height);
    
    markbtn.tag=1000+indexPath.row;
    [markbtn setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
    [markbtn setBackgroundImage:[UIImage imageNamed:@"icon_my_edit_sex_option_on@2x"] forState:UIControlStateSelected];
    [cell addSubview:markbtn];
    cell.markbtn=markbtn;
    
    
    if(1000+indexPath.row==_selectbtn.tag)
    {
        _selectbtn.selected=NO;
        UIButton *markbtn=(UIButton*)[cell viewWithTag:_selectbtn.tag];
        markbtn.selected=YES;
        _selectbtn=markbtn;
    
        
    }
    
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}



-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
