//
//  ZeroShopShareViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/12/17.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "ZeroShopShareViewController.h"
#import "ShareShopModel.h"
#import "LoginViewController.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "NavgationbarView.h"
#import "AppDelegate.h"
#import "DShareManager.h"
#import "AffirmOrderViewController.h"
#import "MyMD5.h"

@interface ZeroShopShareViewController ()

@end

@implementation ZeroShopShareViewController
{
    //分享的图片
    NSString *_shareShopimage;
    //分享的商品描述
    NSString *_shareContent;
    //分享的商品链接
    NSString *_shareShopurl;
    
    NSTimer *_sharetimer;
    
    ShareShopModel *_shareModel;
    
    NSString *_sharePrice;

}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    if([self.typestr isEqualToString:@"夺宝"])
    {
        [self DuobaoshopRequest];
    }else{
        [self shopRequest];
    }
    
    NSString *st = @"测试";
    
    [self creaview];
    [self setNavigationView];
    
   
    
    [gKVO addObserver:self forKeyPath:@"zeroindex" options:NSKeyValueObservingOptionNew context:(void *)st];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zerosharesuccess:) name:@"zeroIndexsharesuccess" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zerosharefail:) name:@"zeroIndexsharefail" object:nil];
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"zeroindex"]) {
        //value = %@", change[@"new"]);
        
        if([gKVO.text isEqualToString:@"分享失败"])
        {
            MyLog(@"分享失败");
        }
        
        NSNumber *st = change[@"new"];
        if ([st intValue ]== 1) //第一次回调
        {
            
            MyLog(@"分享成功");
            
        
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[AffirmOrderViewController class]]) {
                    
                    NSNotification *notification=[NSNotification notificationWithName:@"zerosharesuccess" object:@"zerosharesuccess"];
                    
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
        
                    
                    [self.navigationController popToViewController:controller animated:NO];
                   
                    return;
                    
                }
            }
            
        }
        else if ([st intValue] == 33) //分享失败
        {
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[AffirmOrderViewController class]]) {
                    
                    
                    [self.navigationController popToViewController:controller animated:NO];
                }
            }
            
        }else{
            
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[AffirmOrderViewController class]]) {
                    
                    
                    [self.navigationController popToViewController:controller animated:NO];
                }
            }

        }
        
    }
    
    
}

#pragma mark 分享成功
- (void)zerosharesuccess:(NSNotification*)note
{

    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[AffirmOrderViewController class]]) {
            
            NSNotification *notification=[NSNotification notificationWithName:@"zerosharesuccess" object:@"zerosharesuccess"];
            
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
            
            [self.navigationController popToViewController:controller animated:NO];
            
            return;
            
        }
    }

}

#pragma mark 分享失败
-(void)zerosharefail:(NSNotification*)note
{
  
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[AffirmOrderViewController class]]) {
            
            
            [self.navigationController popToViewController:controller animated:NO];
        }
    }

}

- (void)makeVisiblebgView
{
    UIView *bigview =(UIView*)[self.view viewWithTag:9999];
    
    bigview.hidden=NO;
    
    UIView *animationView=(UIView*)[self.view viewWithTag:888];
    
    [animationView removeFromSuperview];
    
}


- (void)sharetimego
{
    MyLog(@"ok");
    
    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
    
    NSString *sharetime =[user objectForKey:SHARE_TIME];
    
    if(sharetime)
    {
        return;
    }
    
}


-(void)viewDidAppear:(BOOL)animated
{
    MyLog(@"no");
    
    [TFStatisticsClickVM handleDataWithPageType:nil withClickType:@"智能分享图弹出次数" success:^(id data, Response *response) {
    } failure:^(NSError *error) {
    }];

    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }

}

- (void)viewDidDisappear:(BOOL)animated
{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }

}

-(void)setNavigationView
{
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //    headview.image=[UIImage imageNamed:@"u265"];
    headview.backgroundColor = [UIColor clearColor];
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
    titlelable.text=@"智能分享";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
}

- (void)shareSuccess:(NSNotification*)note
{
    
    MyLog(@"shareSuccess");
    

    
}

-(void)creaview
{
    UIImageView *bigview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight+kUnderStatusBarStartY)];
    [bigview setImage:[UIImage imageNamed:@"1080+1920.jpg"]];
    bigview.userInteractionEnabled=YES;
    bigview.tag=9999;
    [self.view addSubview:bigview];
    
    
    NSArray *titlearr=@[@"WX",@"QQ"];
    CGFloat btnwidh=kApplicationWidth/2;
    for(int i=0;i<titlearr.count;i++)
    {
        //按钮
        self.statebtn1=[UIButton buttonWithType:UIButtonTypeCustom];
        self.statebtn1.frame=CGRectMake(btnwidh*i, kApplicationHeight-ZOOM(60*3.4)+kUnderStatusBarStartY, btnwidh, ZOOM(60*3.4));
        
        if(i==0)
        {
            [self.statebtn1 setBackgroundImage:[UIImage imageNamed:@"朋友圈1"] forState:UIControlStateNormal];
            [self.statebtn1 setBackgroundImage:[UIImage imageNamed:@"朋友圈2"] forState:UIControlStateSelected];
            
        }else if (i==1)
        {
            [self.statebtn1 setBackgroundImage:[UIImage imageNamed:@"QQ流程"] forState:UIControlStateNormal];
            [self.statebtn1 setBackgroundImage:[UIImage imageNamed:@"QQ流程2"] forState:UIControlStateSelected];
        }
        
        self.statebtn1.userInteractionEnabled=YES;
        self.statebtn1.tag=8888+i;
        
        //设置进来时选中的按键
        if(i==0)
        {
            self.statebtn1.selected=YES;
            self.slectbtn1=_statebtn1;
        }
    }


}


#pragma mark 判断某个时间是否在7~14点
- (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour
{
    NSDate *date7 = [self getCustomDateWithHour:7];
    NSDate *date14 = [self getCustomDateWithHour:14];
    
    NSDate *currentDate = [NSDate date];
    
    if ([currentDate compare:date7]==NSOrderedDescending && [currentDate compare:date14]==NSOrderedAscending)
    {
        //该时间在 %d:00-%d:00 之间！", fromHour, toHour);
        return YES;
    }
    return NO;
}

/**
 * @brief 生成当天的某个点（返回的是伦敦时间，可直接与当前时间[NSDate date]比较）
 * @param hour 如hour为“8”，就是上午8:00（本地时间）
 */
- (NSDate *)getCustomDateWithHour:(NSInteger)hour
{
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    
    //设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return [resultCalendar dateFromComponents:resultComps];
}



-(void)setMainView
{
    UIImageView *smileView = [[UIImageView alloc]initWithFrame:CGRectMake(kApplicationWidth/2-40, 120, 80, 60)];
    //    smileView.center = CGPointMake(kApplicationWidth/2, 100);
    if (kScreenWidth>=375) {
        smileView.frame = CGRectMake(kApplicationWidth/2-40, 180, 80, 60);
    }
    smileView.image = [UIImage imageNamed:@"笑脸21"];
    [self.view addSubview:smileView];
    
    if(kScreenHeight == 480){
        //4S
        UILabel *thanksLabel = [[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth/2-150, smileView.frame.origin.y+smileView.frame.size.height, 300, 50)];
        thanksLabel.text = @"亲爱的,接下来会自动进入分享流程";
        thanksLabel.textColor = tarbarrossred;
        [thanksLabel setFont:[UIFont systemFontOfSize:ZOOM(50)]];
        thanksLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:thanksLabel];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(kApplicationWidth/2-100, thanksLabel.frame.origin.y+thanksLabel.frame.size.height +15,200, 50 );
        [btn setTitle:@"只要再轻轻点一下" forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:ZOOM(50)]];
        btn.tintColor = [UIColor blackColor];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        UILabel *remindLabel = [[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth/2-150,  btn.frame.origin.y+btn.frame.size.height, 300, 50)];
        remindLabel.text = @"就有机会拿到50元回佣啦!";
        remindLabel.textColor = tarbarrossred;
        [remindLabel setFont:[UIFont systemFontOfSize:ZOOM(50)]];
        remindLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:remindLabel];
        
    }
    else{
        
        UILabel *thanksLabel = [[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth/2-150, smileView.frame.origin.y+smileView.frame.size.height+30, 300, 50)];
        thanksLabel.text = @"亲爱的,接下来会自动进入分享流程";
        thanksLabel.textColor = tarbarrossred;
        [thanksLabel setFont:[UIFont systemFontOfSize:ZOOM(50)]];
        thanksLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:thanksLabel];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(kApplicationWidth/2-100, thanksLabel.frame.origin.y+thanksLabel.frame.size.height +30,200, 50 );
        [btn setTitle:@"只要再轻轻点一下" forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:ZOOM(50)]];
        btn.tintColor = [UIColor blackColor];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        UILabel *remindLabel = [[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth/2-150,  btn.frame.origin.y+btn.frame.size.height, 300, 50)];
        remindLabel.text = @"就有机会拿到50元回佣啦!";
        remindLabel.textColor = tarbarrossred;
        [remindLabel setFont:[UIFont systemFontOfSize:ZOOM(50)]];
        remindLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview:remindLabel];
    }
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView *view=(UIView*)[self.view viewWithTag:7777];
    [view removeFromSuperview];
    
}


#pragma mark 获取商品链接请求
- (void)DuobaoshopRequest
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *shopcode=[user objectForKey:SHOP_CODE];
    NSString *realm = [user objectForKey:USER_REALM];
    NSString *token = [user objectForKey:USER_TOKEN];
    
    [user setObject:self.orderCode forKey:ORDER_CODE];
    
    //shopcode %@,_ordercode %@",shopcode,_orderCode);
    
    NSString *url=[NSString stringWithFormat:@"%@shop/getShopLink?version=%@&shop_code=%@&realm=%@&token=%@&share=%@&getShop=true&indiana=1",[NSObject baseURLStr],VERSION,shopcode,realm,token,@"2"];
    [DataManager sharedManager].key = shopcode;
    NSString *URL=[MyMD5 authkey:url];
    
    [[Animation shareAnimation] createAnimationAt:self.view];
    
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //responseObject is %@",responseObject);
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            
            [[Animation shareAnimation] stopAnimationAt:self.view];
            
            if(str.intValue==1)
            {
                
                _shareModel=[ShareShopModel alloc];
                _shareModel.shopUrl=responseObject[@"link"];
                
                _shareShopurl=@"";
                _shareShopurl=responseObject[@"link"];
                
                NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
                
                if(_shareShopurl)
                {
                    [userdefaul setObject:[NSString stringWithFormat:@"%@",_shareShopurl] forKey:QR_LINK];
                }
                
                
                NSDictionary *shopdic  = responseObject[@"shop"];
                
                if(![shopdic isEqual:[NSNull null]] || shopdic!=nil){
                    
                    if(shopdic[@"four_pic"]!=nil || ![shopdic[@"four_pic"] isKindOfClass:[NSNull class]] || ![shopdic[@"four_pic"] isEqual:[NSNull null]]){
                        
                        NSArray *imageArray = [shopdic[@"four_pic"] componentsSeparatedByString:@","];
                        
                        NSString *imgstr;
                        if(imageArray.count > 2)
                        {
                            imgstr = imageArray[2];
                            
                            _shareModel.shopImage = imageArray[2];
                            
                        }else if (imageArray.count > 0)
                        {
                            imgstr = imageArray[0];
                        }
                        
                        
                        //获取供应商编号
                        
                        NSMutableString *code ;
                        NSString *supcode  ;
                        
                        if(shopdic[@"shop_code"])
                        {
                            code = [NSMutableString stringWithString:shopdic[@"shop_code"]];
                            supcode  = [code substringWithRange:NSMakeRange(1, 3)];
                        }
                        
                        if(imgstr)
                        {
                            MyLog(@"imagestr = %@",[NSString stringWithFormat:@"%@/%@/%@",supcode,code,imgstr]);
                            
                            [userdefaul setObject:[NSString stringWithFormat:@"%@/%@/%@",supcode,code,imgstr] forKey:SHOP_PIC];
                        }else{
                            NavgationbarView *mentinview = [[NavgationbarView alloc]init];
                            [mentinview showLable:@"获取数据失败,稍后重试" Controller:self];
                            
                            return ;
                        }
                        
                    }
                    
                    NSUserDefaults *userdefaul =[NSUserDefaults standardUserDefaults];
                    NSString *kickback = [NSString stringWithFormat:@"%d",[[userdefaul objectForKey:KICKBACK] intValue]];
                    
                    NSString *price = [NSString stringWithFormat:@"%f",[shopdic[@"shop_se_price"] floatValue]];
                    
                    if(price)
                    {
                        [userdefaul setObject:price forKey:SHOP_PRICE];
                        [userdefaul setObject:@"5" forKey:P_TYPE];
                        [userdefaul setObject:@"duobao" forKey:IS_SHARE_TYPE];
                    }
                    
                }
                
                
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
                    
                    //判断是否有微信
                    
                    UIImageView *bigview=(UIImageView*)[self.view viewWithTag:9999];
                    
                    
                    [self createAnimationAt:bigview];
                    
                    [self performSelector:@selector(sharetishi) withObject:nil afterDelay:3];
                    
                    if ([_sharetimer isValid]) {
                        [_sharetimer invalidate];
                    }
                    
                    if ([self.navigationController.viewControllers.lastObject isKindOfClass:[self class]]){
                        NSTimer *time=[NSTimer weakTimerWithTimeInterval:4 target:self selector:@selector(share) userInfo:nil repeats:NO];
                        _sharetimer=time;

                    }
                    
                    
                    
                }else {
                    
                    
                }
                
            }else if(str.intValue==1050){
                
                
                //                HBLog (@"1050");
                
                UIView *view = (UIView*)[self.view viewWithTag:9999];
                [view removeFromSuperview];
                
                
                //                [self creaSmileview];
                //
                //                [self setNavigationView];
                
            }
            else if(str.intValue == 10030){//没登录状态
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud removeObjectForKey:USER_TOKEN];
                LoginViewController *login=[[LoginViewController alloc]init];
                
                login.tag=1000;
                login.loginStatue = @"10030";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
                
            }else{
                
                NavgationbarView *mentinview = [[NavgationbarView alloc]init];
                [mentinview showLable:@"获取数据失败,稍后重试" Controller:self];
                
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        [self setNavigationView];
    }];
    
    
}

#pragma mark 获取商品链接请求
- (void)shopRequest
{
    
    MyLog(@"self.shopArray=%@",self.shopArray);
    
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *realm = [user objectForKey:USER_REALM];
    NSString *token = [user objectForKey:USER_TOKEN];
    
   [DataManager sharedManager].key = self.p_code;
    NSString *url=[NSString stringWithFormat:@"%@shop/getpShopLink?version=%@&p_code=%@&realm=%@&token=%@&share=%@&getPShop=true",[NSObject baseURLStr],VERSION,self.p_code,realm,token,@"2"];
    if(self.p_type.intValue == 5)
    {
        url=[NSString stringWithFormat:@"%@shop/getpShopLink?version=%@&p_code=%@&realm=%@&token=%@&share=%@&getPShop=true&p_s=1",[NSObject baseURLStr],VERSION,self.p_code,realm,token,@"2"];

    }
    
    NSString *URL=[MyMD5 authkey:url];
    
    [[Animation shareAnimation] createAnimationAt:self.view];
    
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            
            [[Animation shareAnimation] stopAnimationAt:self.view];
            
            if(str.intValue==1)
            {
                
                _shareModel=[ShareShopModel alloc];
                _shareModel.shopUrl=responseObject[@"link"];
                
                _shareShopurl=responseObject[@"link"];
    
                
                NSArray * shoparr =responseObject[@"Pshop"];
                
                if(shoparr.count)
                {
                    int dex = arc4random() % shoparr.count;
                    
                    NSDictionary *shopdic  = shoparr[dex];
                    
                    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
                    
                    if(shopdic !=NULL || shopdic!=nil)
                    {
                        if(shopdic[@"four_pic"])
                        {
                            //获取供应商编号
                            
                            NSMutableString *code ;
                            NSString *supcode  ;
                            
                            if(shopdic[@"shop_code"])
                            {
                                code = [NSMutableString stringWithString:shopdic[@"shop_code"]];
                                supcode  = [code substringWithRange:NSMakeRange(1, 3)];
                            }
                            
                            [userdefaul setObject:[NSString stringWithFormat:@"%@/%@/%@",supcode,code,shopdic[@"four_pic"]] forKey:SHOP_PIC];
                        }
                    }
                    
                    if(responseObject[@"link"])
                    {
                        [userdefaul setObject:[NSString stringWithFormat:@"%@",responseObject[@"link"]] forKey:QR_LINK];
                        
                        if(self.p_type.intValue == 5)
                        {
                            [userdefaul setObject:[NSString stringWithFormat:@"%@&post=true",responseObject[@"link"]] forKey:QR_LINK];
                        }
                    }
                    
                    if(responseObject[@"price"])
                    {
                        [userdefaul setObject:responseObject[@"price"] forKey:SHOP_PRICE];
                        
                        NSString *p_type;
                        if([responseObject[@"price"] intValue] == 0)
                        {
                            p_type = @"1";
                        }else if ([responseObject[@"price"] intValue] == 9)
                        {
                            p_type = @"2";
                        }else if ([responseObject[@"price"] intValue] == 19)
                        {
                            p_type = @"3";
                        }else if ([responseObject[@"price"] intValue] == 29)
                        {
                            p_type = @"4";
                        }else{
                            p_type = @"5";//以前是5
                            [userdefaul setObject:@"baoyou" forKey:IS_SHARE_TYPE];
                        }
                        
                        
                        [userdefaul setObject:p_type forKey:P_TYPE];
                    }
                }
                
                
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
                    
                    //判断是否有微信
                    
                    UIImageView *bigview=(UIImageView*)[self.view viewWithTag:9999];
                    
                    [self createAnimationAt:bigview];
                    
                    [self performSelector:@selector(sharetishi) withObject:nil afterDelay:3];
                    
                    if ([_sharetimer isValid]) {
                        [_sharetimer invalidate];
                    }
                    NSTimer *time=[NSTimer weakTimerWithTimeInterval:4 target:self selector:@selector(share) userInfo:nil repeats:NO];
                    
                    _sharetimer=time;
                    
                    
                }else {
                    
                    
                    
                }
                
            } else if(str.intValue==1050){
//                HBLog (@"1050");
            } else if(str.intValue == 10030){//没登录状态
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud removeObjectForKey:USER_TOKEN];
                LoginViewController *login=[[LoginViewController alloc]init];
                
                login.tag=1000;
                login.loginStatue = @"10030";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
                
            }else{
                
                
//                [self setNavigationView];
                
                NavgationbarView *mentionview = [[NavgationbarView alloc]init];
                [mentionview showLable:responseObject[@"message"] Controller:self];
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
//        [self setNavigationView];
    }];
    
    
}

-(void)createAnimationAt:(UIView *)View;
{
    UIView *animationView = [[UIView alloc] initWithFrame:CGRectMake(0, ZOOM(110*3.4), kScreenWidth, ZOOM6(60))];
    animationView.backgroundColor = [UIColor clearColor];
    animationView.alpha = 1;
    animationView.tag = 777;
    [View addSubview:animationView];
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(ZOOM6(140), 0, ZOOM6(60), ZOOM6(60))];
    iv.contentMode = UIViewContentModeScaleAspectFit;
//    iv.center = CGPointMake(animationView.center.x, animationView.frame.size.height/2);
    
    iv.tag = 778;
    iv.userInteractionEnabled=YES;
    iv.layer.cornerRadius=iv.frame.size.width/2;
    [animationView addSubview:iv];
    
    NSMutableArray *anArr = [NSMutableArray array];
    
    for (int i = 0 ; i<3; i++) {
        NSString *gStr = [NSString stringWithFormat:@"33_%d",3-i];
        NSString *file = [[NSBundle mainBundle] pathForResource:gStr ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:file];
        [anArr addObject:image];
    }
    iv.animationImages = anArr;    //动画图片数组
    iv.animationDuration = 3;      //执行一次完整动画所需的时长
    iv.animationRepeatCount = 1;   //无限
    [iv startAnimating];
    
    //subview = %@", animationView.subviews);
    
}


- (void)sharetishi
{
    NavgationbarView *mentionview = [[NavgationbarView alloc]init];
    [mentionview showLable:@"分享中，请稍等哦~" Controller:self];
}


- (void)share
{
    //配置分享平台信息
    AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [app shardk];
    
    [self.navigationController popViewControllerAnimated:NO];
    
    [[DShareManager share] shareAppWithType:ShareTypeWeixiTimeline View:nil Image:nil WithShareType:@"zeroindex"];
}

-(void)back:(UIButton*)sender
{
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }

    [_sharetimer invalidate];
    _sharetimer = nil;
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    //VVVVVV");
    [super viewWillAppear:animated];
    Myview.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }

}

//- (void)dealloc
//{
//    [gKVO removeObserver:self forKeyPath:@"zeroindex"];
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
