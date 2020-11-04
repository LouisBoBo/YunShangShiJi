//
//  AddAdressViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/24.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "AddAdressViewController.h"
#import "HZAreaPickerView.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "NavgationbarView.h"
#import "LoginViewController.h"
#import "GlobalTool.h"
#import "Tools.h"
#import "MyMD5.h"
@interface AddAdressViewController ()<UITextViewDelegate,UITextFieldDelegate,HZAreaPickerDelegate>

@property (strong, nonatomic) HZAreaPickerView *locatePicker;
@end

@implementation AddAdressViewController
{
    //底部视图
    UIView *_backView;
    
    UITextField *_Namefild;
    UITextField *_Phonefild;
    UITextField *_Codefild;
    UILabel *_provincelable;
    UILabel *_streelable;
    UITextView *_detailTextview;
    
    //省市区街道ID
    NSString *Address_allid;
    NSString * _stateID;
    NSString * _cityID;
    NSString * _arreaID;
    NSString * _streetID;

    
    
    //姓名、手机、邮政编码
    UITextField *_fild;
    //省 街道
    UILabel *_lable;
    //详细地址
    UITextView *_textView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
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
    titlelable.font=kNavTitleFontSize;
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    if([self.typestring isEqualToString:@"修改"])
    {
        titlelable.text=@"修改收货地址";
    }else{
        titlelable.text=@"新建收货地址";
    }
    
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(kApplicationWidth-50, 20, 40, 40);
    button.centerY = View_CenterY(headview);
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:button];
    
    [self creatView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Myview.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
}
-(void)creatView
{
    _backView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, kApplicationWidth, 280)];
    _backView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_backView];
    
    NSArray *titlearr=@[@"收货人姓名",@"手机号码",@"邮政编码",@"省，市，区",@"街道",@"详细地址"];
    for(int i=0;i<6;i++)
    {
        
        if(i==0)//姓名
        {
            _Namefild=[[UITextField alloc]initWithFrame:CGRectMake(ZOOM(62), 5+40*i, kApplicationWidth-ZOOM(62)*2, 30)];
            _Namefild.placeholder=titlearr[i];
            _Namefild.tag=1000+i;
//            _Namefild.delegate=self;
            [_backView addSubview:_Namefild];
            
        }else if (i==1)//电话
        {
            _Phonefild=[[UITextField alloc]initWithFrame:CGRectMake(ZOOM(62), 5+40*i, kApplicationWidth-ZOOM(62)*2, 30)];
            _Phonefild.placeholder=titlearr[i];
            _Phonefild.tag=1000+i;
//            _Phonefild.delegate=self;
            [_backView addSubview:_Phonefild];
        }else if (i==2)//邮政编码
        {
            _Codefild=[[UITextField alloc]initWithFrame:CGRectMake(ZOOM(62), 5+40*i, kApplicationWidth-ZOOM(62)*2, 30)];
            _Codefild.placeholder=titlearr[i];
            _Codefild.tag=1000+i;
//            _Codefild.delegate=self;
            [_backView addSubview:_Codefild];
        }else if (i==3)//省市区
        {
            _provincelable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), 5+40*i, kApplicationWidth-ZOOM(62)*2, 30)];
            _provincelable.text=titlearr[i];
            _provincelable.tag=1000+i;
    
            //添加手势
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
            [_provincelable addGestureRecognizer:tap];
            _provincelable.userInteractionEnabled=YES;
            
            [_backView addSubview:_provincelable];

        }else if (i==4)//街道
        {
            _streelable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), 5+40*i, kApplicationWidth-ZOOM(62)*2, 30)];
            _streelable.text=titlearr[i];
            _streelable.tag=1000+i;
            
            //添加手势
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
            [_streelable addGestureRecognizer:tap];
            _streelable.userInteractionEnabled=YES;
            
            [_backView addSubview:_streelable];

        }else{//详细地址
            _detailTextview=[[UITextView alloc]initWithFrame:CGRectMake(ZOOM(62), 5+40*i, kApplicationWidth-ZOOM(62)*2, 70)];
            _detailTextview.text=titlearr[i];
            _detailTextview.textColor=[UIColor groupTableViewBackgroundColor];
            _detailTextview.font=[UIFont systemFontOfSize:18];
            _detailTextview.tag=1000+i;
            _detailTextview.delegate=self;
            [_backView addSubview:_detailTextview];

        }
        
        //分界线
        UILabel *linelable=[[UILabel alloc]initWithFrame:CGRectMake(0, 40*i, kApplicationWidth, 1)];
        linelable.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [_backView addSubview:linelable];
        
    }
    
    if([self.typestring isEqualToString:@"修改"])
    {
        NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
        NSString *province= [userdefaul objectForKey:ORDER_STATE_CITY_AREA];
        NSString *street= [userdefaul objectForKey:ORDER_STREET];
        
        _Namefild.text=[NSString stringWithFormat:@"%@",self.model.consignee];
        _Phonefild.text=[NSString stringWithFormat:@"%@",self.model.phone];
        _Codefild.text=[NSString stringWithFormat:@"%@",self.model.postcode];
        _provincelable.text=[NSString stringWithFormat:@"%@",province];
        _streelable.text=[NSString stringWithFormat:@"%@",street];
        _detailTextview.text=[NSString stringWithFormat:@"%@",self.model.address];
        _detailTextview.textColor=[UIColor blackColor];
    }
}

-(void)click:(UITapGestureRecognizer*)tap
{
    UILabel *lable=(UILabel*)[self.view viewWithTag:tap.view.tag];
    if(lable.tag==1003)
    {
        //省");
        [self cancelLocatePicker];
        self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict delegate:self];
        [self.locatePicker showInView:self.view];
        
    }else{
        //街道");
        [self cancelLocatePicker];
        self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:
                              HZAreaPickerWithStateAndCity delegate:self];
        [self.locatePicker showInView:self.view];

    }

}
- (void)viewDidUnload
{
    [self cancelLocatePicker];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark - HZAreaPicker delegate
-(void)pickerDidChaneStatus:(HZAreaPickerView *)picker
{
    if (picker.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        _provincelable.text = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
        
        Address_allid=[NSString stringWithFormat:@"%@_%@_%@", picker.locate.stateID, picker.locate.cityID, picker.locate.districtID];
        //ID IS %@",Address_allid);
        
        NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
        [userdefaul setObject:Address_allid forKey:ADDRESS_ID];
        
        _stateID=picker.locate.stateID;
        _cityID=picker.locate.cityID;
        _arreaID=picker.locate.districtID;
        
    } else{
         _streelable.text = [NSString stringWithFormat:@"%@",picker.locate.street];
          NSString *ID=[NSString stringWithFormat:@"%@",picker.locate.streetID];
        //ID IS %@",ID);
        
        if(picker.locate.streetID)
        {
            _streetID=picker.locate.streetID;
        }else{
            _streetID=@"0";
        }

        
    }
    
   
    
}

-(void)cancelLocatePicker
{
    [self.locatePicker cancelPicker];
    self.locatePicker.delegate = nil;
    self.locatePicker = nil;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self cancelLocatePicker];

}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [self cancelLocatePicker];

}
#pragma mark - TextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    if ([textField isEqual:self.areaText]) {
//        [self cancelLocatePicker];
//        self.locatePicker = [[[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict delegate:self] autorelease];
//        [self.locatePicker showInView:self.view];
//    } else {
//        [self cancelLocatePicker];
//        self.locatePicker = [[[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCity delegate:self] autorelease];
//        [self.locatePicker showInView:self.view];
//    }
    return NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self cancelLocatePicker];
}

#pragma mark 保存新地址
-(void)save:(UIButton*)sender
{
#if 0
            // 判读昵称
            if ([_Namefild.text length]<1) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"昵称输入不能为空,请重新设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
            
            if ([_Namefild.text length]>10) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"昵称不能超过10个汉字" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
            
            
            if ([[Tools share] stringContainsEmoji:_Namefild.text]) {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"昵称暂不支持表情字符" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
            
    

            //判读手机号码
            NSString *phoneStr = _Phonefild.text;
            
            if (phoneStr.length == 0) {
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"亲，手机号不能空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                [alertView show];
                
                return;
            }
            else {
                
                
                BOOL isCorrect = [self isValidateMobile:phoneStr];
                
                if (isCorrect) {
                    
                    //是手机号码");
                    
                    
                }   else {
                    
                    //不是手机号码");
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    
                    [alert show];
                    return;
                    
                }
                
            }

    
            //判读邮政编码
            if(_Codefild.text.length<1)
            {
                UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"收货人邮政编码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alter show];
                return;

            }
            if(_Codefild.text.length>6)
            {
                UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"收货人邮政编码不正确" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alter show];
                return;

            }
    
    
      //判读省、市、区
    
            if(_provincelable.text.length<7)
            {
                UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"省、市、区不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alter show];
                return;

            }
    
    
    //判读街道
    
//            if(_streelable.text.length<4)
//            {
//                UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"街道不能为空" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                [alter show];
//                return;
// 
//            }

    
   //判读详细地址
    
        if(_detailTextview.text.length<5)
        {
            UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"详细地址不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alter show];
            return;

        }
#endif
    
    if([self.typestring isEqualToString:@"修改"])
    {
        [self changeHttp];
    }else{
        [self AdressHttp];
    }
   
    
}

#pragma mark 发送网络请求保存添加的收货地址
-(void)AdressHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];

    
    NSString *url=[NSString stringWithFormat:@"%@address/insert?version=%@&token=%@&province=%@&city=%@&area=%@&street=%@&address=%@&consignee=%@&phone=%@&postcode=%@",[NSObject baseURLStr],VERSION,token,_stateID,_cityID,_arreaID,_streetID,@"光谷8路888号",@"张燕",@"13838384438",@"518109"];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];

    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            //responseObject is %@",responseObject);
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            if(str.intValue==1)
            {
                message=@"添加地址成功";
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

            else{
                message=@"添加地址失败";
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        
        
    }];

}

#pragma mark 发送网络请求保存修改的收货地址
-(void)changeHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    
    NSString *url=[NSString stringWithFormat:@"%@address/update?version=%@&token=%@&province=%@&city=%@&area=%@&street=%@&address=%@&consignee=%@&phone=%@&postcode=%@",[NSObject baseURLStr],VERSION,token,_provincelable.text,_streelable.text,@"227",@"2456",@"光谷8路640号",@"张燕",@"13838384438",@"518109"];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];

        
        if (responseObject!=nil) {
            //responseObject is %@",responseObject);
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            if(str.intValue==1)
            {
                message=@"修改地址成功";
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

            else{
                message=@"修改地址失败";
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        
        
    }];
    


}

#pragma mark 验证手机号
/*
-(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    //phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}
*/
-(BOOL) isValidateMobile:(NSString *)mobile
{
    //        手机号以13， 15，18开头，八个 \d 数字字符
    //11位数字
    NSString *phoneRegex = @"^\\d{11}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    //phoneTest is %@",phoneTest);
    
    //phoneBl = %d", [phoneTest evaluateWithObject:mobile]);
    return [phoneTest evaluateWithObject:mobile];
}
-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
