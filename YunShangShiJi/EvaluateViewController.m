//
//  EvaluateViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/6/4.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "EvaluateViewController.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "NavgationbarView.h"
#import "UIImageView+WebCache.h"
#import "KeyboardTool.h"
#import "MyMD5.h"
#import "CameraVC.h"
#import "DoImagePickerController.h"
#import "RatingBar.h"
#import "FullScreenScrollView.h"
#import "UpYun.h"
#import "LoginViewController.h"
@interface EvaluateViewController ()<KeyboardToolDelegate,CameraDelegate,DoImagePickerControllerDelegate>

{
    NSMutableArray *_imageArray;

    //记录是否加过图片
    BOOL _isaddimage;
    
    CGFloat _widh;
    
    //星级指数
    NSString *_start;

    FullScreenScrollView *_fullScreenScrollView;
    
    NSMutableString *_images;
}
@end

@implementation EvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageArray=[NSMutableArray array];
    _widh=(kApplicationWidth-60)/5;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"aSelected"];
    
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"评价订单";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=[UIColor whiteColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    [self creatView];
    
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(starttap:) name:@"starttap" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startpan:) name:@"startpan" object:nil];

}

-(void)viewWillAppear:(BOOL)animated
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
    //头像
//    [self.headimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],self.Ordermodel.shop_pic]]];
    
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],self.Ordermodel.shop_pic]];
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [self.headimage sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d = (float)receivedSize/expectedSize;
        isDownlaod = YES;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod == YES) {
            self.headimage.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                self.headimage.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        } else if (image != nil && isDownlaod == NO) {
            self.headimage.image = image;
        }
    }];
    

    //色 尺码
    self.shopcolor_size.text=[NSString stringWithFormat:@"颜色:%@ 尺码:%@",self.Ordermodel.shop_color,self.Ordermodel.shop_size];

    //价格
    self.shopprice.text=[NSString stringWithFormat:@"￥%@",self.Ordermodel.order_price];
    
    //添加图片
    [self.addimgbtn addTarget:self action:@selector(addimg:) forControlEvents:UIControlEventTouchUpInside];

    
    [self.btn1 addTarget:self action:@selector(click1:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn2 addTarget:self action:@selector(click1:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn3 addTarget:self action:@selector(click1:) forControlEvents:UIControlEventTouchUpInside];
    self.btn1.tag=1000;
    self.btn2.tag=2000;
    self.btn3.tag=3000;
    
    if(self.btn1.tag==1000)
    {
        [self.btn1 setBackgroundImage:[UIImage imageNamed:@"icon_my_edit_sex_option_on@2x"] forState:UIControlStateSelected];
        self.btn1.selected=YES;
        self.selectbtn=self.btn1;
    }
    self.comfild.delegate=self;
    
    self.footview.clipsToBounds=YES;
    self.footview.frame=CGRectMake(0, kApplicationHeight-40+kUnderStatusBarStartY, kApplicationWidth, 40);
    [self.view addSubview:self.footview];
    
    self.commitbtn.frame=CGRectMake((kApplicationWidth-80)/2, 5, 80, 30);
    [self.commitbtn addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    
    KeyboardTool *tool = [KeyboardTool keyboardTool];
    tool.delegate = self;
    tool.frame=CGRectMake(0, tool.frame.origin.y, kScreenWidth, 40);
    self.comfild.inputAccessoryView=tool;
    
    //星级指数
    RatingBar *bar = [[RatingBar alloc] initWithFrame:CGRectMake(100, self.startlable.frame.origin.y+55, 220, 40)];
    [self.view addSubview:bar];
    
    //分类评价
    UIView *backview=[[UIView alloc]initWithFrame:CGRectMake(10, self.startlable.frame.origin.y+self.startlable.frame.size.height+10, kApplicationWidth-20, 160)];
//    backview.backgroundColor=kBackgroundColor;
    [self.Myscrollview addSubview:backview];
    
    NSArray *titleArray=@[@"没有色差",@"版型很好",@"做工很好",@"性价比高"];
    for(int i=0;i<4;i++)
    {
        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0+40*i, 100, 40)];
        lable.text=titleArray[i];
        [backview addSubview:lable];
        
        
        for(int j=0 ;j<2;j++)
        {
            UIButton *yesbutton=[UIButton buttonWithType:UIButtonTypeCustom];
            yesbutton.frame=CGRectMake(125+100*j, 10+40*i, 20, 20);
            yesbutton.tag=1000*(i+1)+j;
            yesbutton.layer.cornerRadius=5;
            [yesbutton setBackgroundImage:[UIImage imageNamed:@"icon_my_edit_sex_option@2x"] forState:UIControlStateNormal];
            [yesbutton addTarget:self action:@selector(yesclick:) forControlEvents:UIControlEventTouchUpInside];
            
            [backview addSubview:yesbutton];
            
            if(j==0)
            {
             
                if(yesbutton.tag==1000)
                {
//                    [yesbutton setBackgroundImage:[UIImage imageNamed:@"icon_my_edit_sex_option_on@2x"] forState:UIControlStateNormal];
                    yesbutton.selected=YES;
                    
                    self.selectbtn1=yesbutton;
                }
                if(yesbutton.tag==2000)
                {
                    self.selectbtn2=yesbutton;
                }
                if(yesbutton.tag==3000)
                {
                    self.selectbtn3=yesbutton;
                }
                if(yesbutton.tag==4000)
                {
                    self.selectbtn4=yesbutton;
                }

            }


        }
        
        UILabel *lable1=[[UILabel alloc]initWithFrame:CGRectMake(155, 0+40*i, 100, 40)];
        lable1.text=@"是";
        [backview addSubview:lable1];
        

        UILabel *lable2=[[UILabel alloc]initWithFrame:CGRectMake(255, 0+40*i, 100, 40)];
        lable2.text=@"否";
        [backview addSubview:lable2];
        
     }

    
    
    
    
}

-(void)yesclick:(UIButton*)sender
{
    
    NSInteger j=sender.tag/1000;
    for(int i=0;i<2;i++)
    {
        UIButton *btn=(UIButton*)[self.view viewWithTag:1000*j+i];
        
        if(1000*(j)+i==sender.tag)
        {
            [btn setBackgroundImage:[UIImage imageNamed:@"icon_my_edit_sex_option_on@2x"] forState:UIControlStateSelected];
            
            
        }else{
           [btn setBackgroundImage:[UIImage imageNamed:@"icon_my_edit_sex_option@2x"] forState:UIControlStateSelected];
        }
        
    }
    if(j==1)
    {
        self.selectbtn1.selected=NO;
        sender.selected=YES;
        self.selectbtn1=sender;
    }
    if(j==2)
    {
        self.selectbtn2.selected=NO;
        sender.selected=YES;
        self.selectbtn2=sender;

    }
    if(j==3)
    {
        self.selectbtn3.selected=NO;
        sender.selected=YES;
        self.selectbtn3=sender;

    }
    if(j==4)
    {
        self.selectbtn4.selected=NO;
        sender.selected=YES;
        self.selectbtn4=sender;

    }
    
    
    
//    for(int i=0;i<2;i++)
//    {
//        UIButton *btn=(UIButton*)[self.view viewWithTag:1000+i];
//        
//        if(i+1000==sender.tag)
//        {
//            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            btn.backgroundColor=tarbarrossred;
//            
//            
//        }else{
//            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            btn.backgroundColor=kBackgroundColor;
//        }
//        
//    }
//    
//    self.selectbtn1.selected=NO;
//    sender.selected=YES;
//    self.selectbtn1=sender;

}

- (void)keyboardTool:(KeyboardTool *)keyboardTool itemClick:(KeyboardToolItemType)itemType
{
    if (itemType == KeyboardToolItemTypePrevious) { // 上一个
        //----上一个----");
    } else if (itemType == KeyboardToolItemTypeNext) { // 下一个
        //----下一个----");
    } else { // 完成
        //----完成----");
        [self.view endEditing:YES];
    }
}


-(void)click1:(UIButton*)sender
{
    UIButton *button=(UIButton*)[self.view viewWithTag:sender.tag];
    button.selected=!button.selected;
    if(button.selected==YES)
    {
        [button setBackgroundImage:[UIImage imageNamed:@"icon_my_edit_sex_option_on@2x"] forState:UIControlStateSelected];
    }else{
        [button setBackgroundImage:[UIImage imageNamed:@"icon_my_edit_sex_option_on@2x"] forState:UIControlStateSelected];
    }
    
    self.selectbtn.selected=NO;
    button.selected=YES;
    self.selectbtn=button;
}

-(void)commit:(UIButton*)sender
{
    if(self.comfild.text==nil)
    {
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"评价内容不能为空" Controller:self];
        
        return;
    }
    
    if(_start==nil)
    {
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"请为商家评分" Controller:self];
        
        return;
    }
    
    if(_imageArray.count)
    {
        [self creatUPY];
    }else{
        [self commitHttp];
    }

}

#pragma mark 将图片上传到upyun
-(void)creatUPY
{
    
    __block int count=_imageArray.count;
    
    UpYun *uy = [[UpYun alloc] init];
    uy.successBlocker = ^(id data)
    {
        
        //%@",data);
        
        NSString *imgurl=data[@"url"];
        if(imgurl)
        {
            [_images appendString:imgurl];
            [_images appendString:@","];
            
            count=count-1;
            if(count==0)
            {
                NavgationbarView *view=[[NavgationbarView alloc]init];
                [view showLable:@"上传成功" Controller:self];
                
                [self commitHttp];
                
                //                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:@"上传成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                //                [alert show];
            }
            
        }
        
    };
    
    uy.failBlocker = ^(NSError * error)
    {
        NSString *message = [error.userInfo objectForKey:@"message"];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"error" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        //%@",error);
        
        count=count-1;
    };
    
    
    for(int i=0;i<_imageArray.count;i++)
    {
        
        UIImage * image1 =_imageArray[i];
        [uy uploadFile:image1 saveKey:[self getSaveKey]];
        
        //        UIImage * image = [UIImage imageNamed:@"imag.jpg"];
        //        [uy uploadFile:image saveKey:[self getSaveKey]];
        
    }
    
    
}

-(NSString * )getSaveKey {
    
    NSString *UID=[self getNumber];
    NSDate *d = [NSDate date];
    
    return [NSString stringWithFormat:@"%@%d%.0f.jpg",UID,[self getSecond:d],[[NSDate date] timeIntervalSince1970]];
    
}

#pragma mark 获取毫秒数
- (int)getSecond:(NSDate *) date{
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    int second = [comps second];
    return second;
}

#pragma mark 获取UID
-(NSString*)getNumber
{
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    NSMutableString *strNum=[NSMutableString string];
    
    for (int i=0; i<token.length; i++) {
        NSString *character=[token substringWithRange:NSMakeRange(i, 1)];//循环取每个字符
        
        if ([character isEqual: @"0"]|
            [character isEqual: @"1"]|
            [character isEqual: @"2"]|
            [character isEqual: @"3"]|
            [character isEqual: @"4"]|
            [character isEqual: @"5"]|
            [character isEqual: @"6"]|
            [character isEqual: @"7"]|
            [character isEqual: @"8"]|
            [character isEqual: @"9"]) {
            
            strNum=[strNum stringByAppendingString:character];//是数字的累加起来
        }
        
    }
    return strNum;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark 网络请求发表评价
-(void)commitHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
//    NSString *comment_type;
//    if(self.selectbtn.tag==1000)
//    {
//        comment_type=@"1";
//    }
//    if(self.selectbtn.tag==2000)
//    {
//        comment_type=@"2";
//    }
//    if(self.selectbtn.tag==3000)
//    {
//        comment_type=@"3";
//    }

    NSString *url=[NSString stringWithFormat:@"%@shopComment/addShopComment?version=%@&token=%@&order_shop_id=%@&content=%@&comment_type=%@&ordercode=%@",[NSObject baseURLStr],VERSION,token,self.order_shopid,self.comfild.text,_start,self.Ordermodel.order_code];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *message;
            NSString *str=[NSString stringWithFormat:@"%@",responseObject[@"status"]];
            if(str.intValue==1)
            {
                message=@"发表评价成功";
                
            }else if(str.intValue == 10030){//没登录状态
                
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud removeObjectForKey:USER_TOKEN];
                
                LoginViewController *login=[[LoginViewController alloc]init];
                
                login.tag=1000;
                login.loginStatue = @"10030";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
                
            }

            else{
                
                message=@"发表评价失败";
            }
            
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        
    }];
    

}

-(void)addimg:(UIButton*)sender
{
    UIActionSheet *actionsheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册获取", nil];
    [actionsheet showInView:self.view];

}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        CameraVC *camera=[[CameraVC alloc]init];
        camera.delegate=self;
        camera.MaxImageNum=10;
        [self.navigationController pushViewController:camera animated:YES];
        
    }else if (buttonIndex==1)
    {
        DoImagePickerController *doimg=[[DoImagePickerController alloc]init];
        doimg.delegate=self;
        doimg.nColumnCount=4;
        doimg.nResultType=DO_PICKER_RESULT_UIIMAGE;
        doimg.nMaxCount=10;
        [self.navigationController pushViewController:doimg animated:YES];
    }
}

#pragma mark cameradelegate
-(void)SelectPhotoEnd:(CameraVC *)Manager WithPhotoArray:(NSArray *)PhotoArray
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSData *saveMenulistDaate = [defaults objectForKey:@"aSelected"];
    
    if (nil == saveMenulistDaate) {
        NSMutableArray *menulistarry = [[NSMutableArray alloc]init];
        
        _imageArray = menulistarry;
    }
    else
    {
        _imageArray = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:saveMenulistDaate];
    }
    
    UIImage *imagge=[UIImage imageNamed:@"add"];
    for(int i=0 ;i<PhotoArray.count;i++)
    {
        [_imageArray addObject:PhotoArray[i]];
        
    }
    
    if(_imageArray.count<5)
    {
        [_imageArray addObject:imagge];
        _isaddimage=YES;
    }
    
    //ok");
    
    NSInteger count=0;
    if(_imageArray.count%5==0)
    {
        count=_imageArray.count/5;
    }else{
        count=_imageArray.count/5+1;
    }
    
    int k=0;
    for(int i=0;i<count;i++)
    {
        
        for(int j=0;j<5;j++)
        {
            
            UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(10+(_widh+10)*j, self.addimgbtn.frame.origin.y, _widh, _widh)];
            
            if(k<_imageArray.count)
            {
                imageview.image=_imageArray[k];
                imageview.clipsToBounds = YES;
                imageview.contentMode = UIViewContentModeScaleAspectFill;
                
                imageview.tag=2000+k;
                
                
                k++;
                
                [self.Myscrollview addSubview:imageview];
                
                UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageclick:)];
                [imageview addGestureRecognizer:tap];
                imageview.userInteractionEnabled=YES;
                
            }else{
                
            }
            
        }
    }
    
    
    self.Myscrollview.contentSize=CGSizeMake(0, self.addimgbtn.frame.origin.y+110);
    
    
    if(_imageArray.count)
    {
        self.addimgbtn.enabled=NO;
    }else{
        self.addimgbtn.enabled=YES;
    }
    
    
    if(_imageArray.count)
    {
        if(_isaddimage==YES)
        {
            [_imageArray removeObjectAtIndex:_imageArray.count-1];
            _isaddimage=NO;
            
        }
        
        NSData *encodemenulist = [NSKeyedArchiver archivedDataWithRootObject:_imageArray];
        NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
        
        [defaults1 setObject:encodemenulist forKey:@"aSelected"];
        
    }
    
}

#pragma mark DoImagePickerControllerDelegate
-(void)didCancelDoImagePickerController
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)didSelectPhotosFromDoImagePickerController:(DoImagePickerController *)picker result:(NSArray *)aSelected
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSData *saveMenulistDaate = [defaults objectForKey:@"aSelected"];
    
    
    if (nil == saveMenulistDaate) {
        
        NSMutableArray *menulistarry = [[NSMutableArray alloc]init];
        
        _imageArray = menulistarry;
        
    }
    else
    {
        _imageArray = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:saveMenulistDaate];
    }
    
    
    UIImage *imagge=[UIImage imageNamed:@"add"];
    for(int i=0 ;i<aSelected.count;i++)
    {
        [_imageArray addObject:aSelected[i]];
        
    }
    
    if(_imageArray.count<5)
    {
        [_imageArray addObject:imagge];
        _isaddimage=YES;
    }
    
    //ok");
    
    NSInteger count=0;
    if(_imageArray.count%5==0)
    {
        count=_imageArray.count/5;
    }else{
        count=_imageArray.count/5+1;
    }
    
    int k=0;
    for(int i=0;i<count;i++)
    {
        
        for(int j=0;j<5;j++)
        {
            
            UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(10+(_widh+10)*j, self.addimgbtn.frame.origin.y, _widh, _widh)];
            
            if(k<_imageArray.count)
            {
                imageview.image=_imageArray[k];
                imageview.clipsToBounds = YES;
                imageview.contentMode = UIViewContentModeScaleAspectFill;
                
                imageview.tag=2000+k;
                
                
                k++;
                
                [self.Myscrollview addSubview:imageview];
                
                UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageclick:)];
                [imageview addGestureRecognizer:tap];
                imageview.userInteractionEnabled=YES;
                
            }else{
                
            }
            
        }
    }
    
    
    self.Myscrollview.contentSize=CGSizeMake(0, self.addimgbtn.frame.origin.y+110);
    
    
    if(_imageArray.count)
    {
        self.addimgbtn.enabled=NO;
    }else{
        self.addimgbtn.enabled=YES;
    }
    
    if(_imageArray.count)
    {
        if(_isaddimage==YES)
        {
            [_imageArray removeObjectAtIndex:_imageArray.count-1];
            _isaddimage=NO;
            
        }
        NSData *encodemenulist = [NSKeyedArchiver archivedDataWithRootObject:_imageArray];
        NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
        
        [defaults1 setObject:encodemenulist forKey:@"aSelected"];
        
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)imageclick:(UITapGestureRecognizer*)tap
{
    UIImageView *imageview=(UIImageView*)[self.view viewWithTag:tap.view.tag];
    
    if(imageview.tag==2000+_imageArray.count)
    {
        UIActionSheet *actionsheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册获取", nil];
        [actionsheet showInView:self.view];
        
        
    }else{
        
        NSInteger image_page=imageview.tag%2000+1;
        
        UIView *Screenwindow = [[UIApplication sharedApplication].delegate window];
        
        _fullScreenScrollView = [[FullScreenScrollView alloc]initWithPicutreArray:_imageArray withCurrentPage:image_page];
        
        _fullScreenScrollView.backgroundColor = [UIColor blackColor];
        
        [Screenwindow addSubview:_fullScreenScrollView];
        
    }
    
    
}

#pragma mark 星级指数
-(void)starttap:(NSNotification*)note
{
    _start=[NSString stringWithFormat:@"%@",note.object];
}

-(void)startpan:(NSNotification*)note
{
    _start=[NSString stringWithFormat:@"%@",note.object];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.view endEditing:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
