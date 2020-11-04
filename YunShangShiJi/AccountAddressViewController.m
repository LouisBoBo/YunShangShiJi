//
//  AccountAddressViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/5/28.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "AccountAddressViewController.h"
#import "GlobalTool.h"
#import "AdressModel.h"
#import "AdressTableViewCell.h"
#import "AddAdressViewController.h"
#import "DeliveryViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "MyMD5.h"
#import "NavgationbarView.h"
#import "HZAreaPickerView.h"
#import "LoginViewController.h"
@interface AccountAddressViewController ()
{
    //列表
    UITableView *_Mytableview;
    //数据源
    NSMutableArray *_DataArray;
    //默认收货地址数据源
    NSMutableArray *_DeliverArray;
}
@end

@implementation AccountAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _DataArray=[NSMutableArray array];
    _DeliverArray=[NSMutableArray array];
    
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
    titlelable.text=@"管理收货地址";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Myview.hidden=YES;
    
    [_DeliverArray removeAllObjects];
    [_DataArray removeAllObjects];
    [self requestHttp];

    [self crestView];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
}

#pragma mark 发送网络请求获取地址数据
-(void)requestHttp
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
        
//        responseObject = [NSDictionary changeType:responseObject];
        //responseObject is %@",responseObject);
        
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
#pragma mark 删除收货地址
-(void)deleateHttp:(AdressModel*)model
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    NSString *ID=[NSString stringWithFormat:@"%@",model.addressid];
    NSString *is_default=[NSString stringWithFormat:@"%@",model.is_default];
    NSString *url=[NSString stringWithFormat:@"%@address/delete?version=%@&token=%@&id=%@&is_default=%@",[NSObject baseURLStr],VERSION,token,ID,is_default];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showMessage:@"正在加载" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            //responseObject is %@",responseObject);
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            if(str.intValue==1)
            {
                message=@"删除收货地址成功";
            }else{
                message=@"删除收货地址失败";
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
            
            [_Mytableview reloadData];

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        
        
    }];
    
    
}


-(void)crestView
{
    _Mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kApplicationWidth, kApplicationHeight-Height_NavBar-50+kUnderStatusBarStartY) style:UITableViewStylePlain];
    //    [_Mytableview registerNib:[UINib nibWithNibName:@"AdressTableViewCell" bundle:nil] forCellReuseIdentifier:@"AdressCell"];
    
    _Mytableview.delegate=self;
    _Mytableview.dataSource=self;
    _Mytableview.rowHeight=80;
    [self.view addSubview:_Mytableview];
    
    UIView *footview=[[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight-50+kUnderStatusBarStartY, kApplicationWidth, 50)];
    
    UILabel *linelable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 0.5)];
    linelable.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [footview addSubview:linelable];
    
    UIButton *addbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    addbtn.frame=CGRectMake(100, 10, kApplicationWidth-200, 30);
    addbtn.backgroundColor=tarbarYellowcolor;
    addbtn.layer.cornerRadius=15;
    [addbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addbtn setTitle:@"添加新地址" forState:UIControlStateNormal];
    [addbtn addTarget:self action:@selector(ADD:) forControlEvents:UIControlEventTouchUpInside];
    [footview addSubview:addbtn];
    
    [self.view addSubview:footview];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _DataArray.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AdressModel *model=_DataArray[indexPath.row];

    
    DeliveryViewController *delivery=[[DeliveryViewController alloc]init];
    delivery.model=model;
    [self.navigationController pushViewController:delivery animated:YES];

}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//定义编辑样式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleDelete;
    
}

//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

//进入编辑模式，按下出现的编辑按钮后
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle==UITableViewCellEditingStyleDelete)
    {
        
        //删除数据源
        
        AdressModel *model=_DataArray[indexPath.row];
        NSString *str=[NSString stringWithFormat:@"%@",model.addressid];
        
        [_DataArray removeObjectAtIndex:indexPath.row];
        
       
        //删除单元格
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
        
        [self deleateHttp:model];
        
        
    }
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
      
    AdressTableViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"AdressTableViewCell" owner:self options:nil].lastObject;
    
   
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    HZAreaPickerView *pickview=[[HZAreaPickerView alloc]init];

    if(indexPath.row==0 )
    {
        
        AdressModel *model=_DataArray[indexPath.row];
        cell.backgroundColor=[UIColor darkGrayColor];
        
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

        
        UIButton *markbtn=[[UIButton alloc]init];
        markbtn.frame=cell.markbtn.frame;
        markbtn.tag=1000+indexPath.row;
        [markbtn setBackgroundImage:[UIImage imageNamed:@"icon_my_edit_sex_option_on@2x"] forState:UIControlStateNormal];
        [cell addSubview:markbtn];
        cell.markbtn=markbtn;

        
        cell.Ordername.textColor=[UIColor whiteColor];
        cell.OrderPhone.textColor=[UIColor whiteColor];
        
        NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
        [userdefaul setObject:cell.Ordername.text forKey:ORDER_NAEM];
        [userdefaul setObject:cell.OrderPhone.text forKey:ORDER_PHONE];
        [userdefaul setObject:cell.OrderAddress.text forKey:ORDER_ADDRESS];
        
    }else if (indexPath.row >0)
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
    
    return cell;
}

#pragma mark 添加新地址
-(void)ADD:(UIButton*)sender
{
    AddAdressViewController *adddress=[[AddAdressViewController alloc]init];
    [self.navigationController pushViewController:adddress animated:YES];

}

-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
