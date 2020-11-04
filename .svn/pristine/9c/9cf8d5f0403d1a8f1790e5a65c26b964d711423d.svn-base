//
//  IntelligenceViewController.m
//  YunShangShiJi
//
//  Created by yssj on 15/8/6.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "IntelligenceViewController.h"
#import "AffirmOrderViewController.h"
#import "MyOrderViewController.h"
#import "OrderDetailViewController.h"
#import "GlobalTool.h"
#import "DShareManager.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "MyMD5.h"
#import "ShareShopModel.h"
#import "ProduceImage.h"
#import "NavgationbarView.h"


#import "ShopDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "ValueObserver.h"
#import "MymineViewController.h"
#import "LoginViewController.h"
#import "AffirmOrderViewController.h"
#import "OrderTableViewController.h"
#import "NewShoppingCartViewController.h"

@interface IntelligenceViewController ()
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

@property (nonatomic, strong)UIImageView *animationView;
@property (nonatomic, assign)BOOL isKVO;
@end



@implementation IntelligenceViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    if (self.isKVO)
    {
        [gKVO removeObserver:self forKeyPath:@"index"];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [DataManager sharedManager].outAppStatistics=@"智能分享弹窗页";
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sharesuccess:) name:@"Intelligencesharesuccess" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sharefail:) name:@"Intelligencesharefail" object:nil];

   if([self.isshare isEqualToString:@"no"])
   {
       [self creaSmileview];
       
       [self setNavigationView];
       
   }else{
   
       [self creaview];
       
       [self setNavigationView];
       
       [self shopRequest];

   }
}
-(void)sharefail:(NSNotificationCenter *)noti{
    if (self.BackBlock) {
        self.BackBlock();
    }
}
-(void)sharesuccess:(NSNotificationCenter *)noti{
    if (self.BackBlock) {
        self.BackBlock();
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{

    if ([keyPath isEqualToString:@"index"]) {
        //value = %@", change[@"new"]);
        
        if([gKVO.text isEqualToString:@"分享失败"])
        {
            MyLog(@"分享失败");
        }

        NSNumber *st = change[@"new"];
        if ([st intValue ]== 1) //第一次回调
        {

            //分享成功后直接跳转到详情页面
            for (UIViewController *controller in self.navigationController.viewControllers) {
//                if ([controller isKindOfClass:[WTFCartViewController class]]) {
//                    
//                    NSNotification *notification=[NSNotification notificationWithName:@"ShoppingCartsharesuccess" object:@"sharesuccess"];
//                    
//                    [[NSNotificationCenter defaultCenter] postNotification:notification];
//                    
//                    [self.navigationController popToViewController:controller animated:YES];
//                    
//                    return;
//
//                }
                
                
//                else
                    if ([controller isKindOfClass:[ShopDetailViewController class]]) {
                    
                    NSNotification *notification=[NSNotification notificationWithName:@"ShopDetailsharesuccess" object:@"sharesuccess"];
                    
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                    
                    [self.navigationController popToViewController:controller animated:YES];
                    
                    return;
                }

                else if ([controller isKindOfClass:[MyOrderViewController class]]) {
                    
                    NSNotification *notification=[NSNotification notificationWithName:@"MyOrdersharesuccess" object:@"sharesuccess"];
                    
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                    
                    [self.navigationController popToViewController:controller animated:YES];
                    
                    return;
                }
                
                
            }

        }
        else if ([st intValue] == 33) //分享失败
        {
            
            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
            [mentionview showLable:@"分享失败" Controller:self];
            
            
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[ShopDetailViewController class]]) {
                    
                    NSNotification *notification=[NSNotification notificationWithName:@"ShopDetailsharefail" object:@"sharefail"];
                    
                    [[NSNotificationCenter defaultCenter] postNotification:notification];


                    [self.navigationController popToViewController:controller animated:YES];
                    
                     return;
                }
                
             if ([controller isKindOfClass:[MyOrderViewController class]]) {
                    
                    
                    [self.navigationController popToViewController:controller animated:YES];
                    
                    return;
                }

            }

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

- (void)viewWillAppear:(BOOL)animated
{
    
    //VVVVVV");
    
    [super viewWillAppear:animated];
    Myview.hidden=YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    [TFStatisticsClickVM handleDataWithPageType:nil withClickType:@"智能分享图弹出次数" success:^(id data, Response *response) {
    } failure:^(NSError *error) {
    }];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
  
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

#pragma mark 分享成功
- (void)IntelligenceshareSuccess:(NSNotification*)note
{
    //分享成功后直接跳转到详情页面
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[NewShoppingCartViewController class]]) {
            
            NSNotification *notification=[NSNotification notificationWithName:@"ShoppingCartsharesuccess" object:@"sharesuccess"];
            
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
            [self.navigationController popToViewController:controller animated:YES];
            
            return;
            
        }
        
        
        
        else if ([controller isKindOfClass:[ShopDetailViewController class]]) {
            
            NSNotification *notification=[NSNotification notificationWithName:@"ShopDetailsharesuccess" object:@"sharesuccess"];
            
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
            [self.navigationController popToViewController:controller animated:YES];
            
            return;
        }
        
        else if ([controller isKindOfClass:[MyOrderViewController class]]) {
            
            NSNotification *notification=[NSNotification notificationWithName:@"MyOrdersharesuccess" object:@"sharesuccess"];
            
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
            [self.navigationController popToViewController:controller animated:YES];
            
            return;
        }
        
        
    }
    
}

#pragma mark 分享失败
- (void)IntelligenceshareFail:(NSNotification*)note
{
    NavgationbarView *mentionview = [[NavgationbarView alloc]init];
    [mentionview showLable:@"分享失败" Controller:self];
    
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[ShopDetailViewController class]]) {
            
            NSNotification *notification=[NSNotification notificationWithName:@"ShopDetailsharefail" object:@"sharefail"];
            
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
            
            [self.navigationController popToViewController:controller animated:YES];
            
            return;
        }
        if ([controller isKindOfClass:[MyOrderViewController class]]) {
            
            
            [self.navigationController popToViewController:controller animated:YES];
            
            return;
        }
        
    }

}

-(void)creaview
{
    UIImageView *bigview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight+kUnderStatusBarStartY)];
    [bigview setImage:[UIImage imageNamed:@"背景1.jpg"]];
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
//        [self.statebtn1 addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
//        [bigview addSubview:self.statebtn1];
        
        
        //设置进来时选中的按键
        if(i==0)
        {
            self.statebtn1.selected=YES;
            self.slectbtn1=_statebtn1;
        }
    }
    
    
    NSUserDefaults *userdefaul =[NSUserDefaults standardUserDefaults];
    NSString *kickback =[userdefaul objectForKey:KICKBACK];
    
    
        UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, -10, 120, 30)];
        titlelabel.center = CGPointMake(kApplicationWidth/2, kApplicationHeight/2-15);
        titlelabel.text=@"恭喜获得";
        titlelabel.textColor=kTextColor;
        titlelabel.font=[UIFont systemFontOfSize:ZOOM(40)];
        titlelabel.textAlignment=NSTextAlignmentCenter;
//        [bigview addSubview:titlelabel];

        UILabel *moneylabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-ZOOM(200*3.4))/2, 60, ZOOM(200*3.4), ZOOM(70*3.4))];

        moneylabel.text=[NSString stringWithFormat:@"分享后即可使用\n%d元抵用劵",[kickback intValue]];
        moneylabel.numberOfLines = 0;
        moneylabel.font=[UIFont systemFontOfSize:ZOOM(84)];
        moneylabel.textAlignment=NSTextAlignmentCenter;
        moneylabel.textColor=[UIColor redColor];
        [moneylabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM(84)]];
    
        [bigview addSubview:moneylabel];

}

-(void)creaSmileview
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, Height_NavBar,kScreenWidth, kScreenHeight-Height_NavBar)];
    view.backgroundColor = [UIColor whiteColor];
    //    view.alpha = 0.9;
    view.tag =9797;
    
    
    UIView * smileView=[[UIView alloc]initWithFrame:CGRectMake(0, view.frame.size.height/2-200, kApplicationWidth, 200)];
    smileView.backgroundColor=[UIColor whiteColor];
    UIImageView *smileImg = [[UIImageView alloc]initWithFrame:CGRectMake(smileView.frame.size.width/2-35, smileView.frame.size.height/2-40, 64, 56)];
    //    smileView.center = CGPointMake(kApplicationWidth/2, 100);
    smileImg.image = [UIImage imageNamed:@"表情"];
    smileImg.contentMode = UIViewContentModeScaleAspectFit;
    [smileView addSubview:smileImg];
    
    
    NSMutableAttributedString *noteStr ;
    
    BOOL result = [self isBetweenFromHour:7 toHour:14];
    
    if( result)//早上
    {
         noteStr = [[NSMutableAttributedString alloc] initWithString:@"亲爱的，你今天上午的分享次数已经全部使用了哦,下午再来吧！接下来购物不分享也能得到现金红包哦！"];
        
    }else{
       
        noteStr = [[NSMutableAttributedString alloc] initWithString:@"亲爱哒，今天的分享次数已经使用完了哦，明天再分享吧。接下来购物不分享也能得到现金红包哦！"];
    }
    
    
    NSRange redRange = NSMakeRange(0, [[noteStr string] rangeOfString:@"接"].location);
    [noteStr addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:redRange];
    

    UILabel* thanksLabel = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(80), smileImg.frame.origin.y+smileImg.frame.size.height+30, kApplicationWidth-2*ZOOM(80), 120)];
    
    thanksLabel.numberOfLines = 0;
    thanksLabel.textColor = kTextColor;
    
    thanksLabel.attributedText = noteStr;
    
    [thanksLabel setFont:[UIFont systemFontOfSize:ZOOM(64)]];
//    thanksLabel.textAlignment = NSTextAlignmentCenter;
    [smileView addSubview:thanksLabel];
    
    
    
    [view addSubview:smileView];
    
    [self.view addSubview:view];

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
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    
    //设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [resultCalendar dateFromComponents:resultComps];
}



//#pragma mark 一级按钮监听事件
//-(void)btnclick:(UIButton*)sender
//{
//    
//    [_sharetimer invalidate];
//    _sharetimer = nil;
//    
//    self.slectbtn1.selected=NO;
//    sender.selected= YES;
//    self.slectbtn1=sender;
//    
//    NavgationbarView *mentionview = [[NavgationbarView alloc]init];
//    [mentionview showLable:@"分享中..." Controller:self];
//    
////    [[Animation shareAnimation] createAnimationAt:self.view];
//    
//
//    if (sender.selected == YES) {
//    
//        //配置分享平台信息
//        AppDelegate *app=[[UIApplication sharedApplication] delegate];
//        [app shardk];
//      
//        if(sender.tag==8889)//QQ
//        {
//            
//            [[DShareManager share] shareAppWithType:ShareTypeQQSpace View:nil Image:nil WithShareType:@"index"];
//            
//        }
//        else if (sender.tag==8888)//微信
//        {
//            
//            [[DShareManager share] shareAppWithType:ShareTypeWeixiTimeline View:nil Image:nil WithShareType:@"index"];
//            
//        }
//
//    }
//    
//    [[Animation shareAnimation] stopAnimationAt:self.view];
//    
//    
//}
//
- (void)shareQQ
{
   
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
    
    
    //分享平台
    for (int i=0; i<3; i++) {
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        shareBtn.frame = CGRectMake(80*i+(kApplicationWidth-220)/2,kApplicationHeight-120, 60, 60);
        shareBtn.tag = 3000+i;
        [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            
            //判断设备是否安装QQ
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]])
            {
                //判断是否有qq
                [shareBtn setBackgroundImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
            }else{
                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
            }
            
        }else if (i==1){
            [shareBtn setBackgroundImage:[UIImage imageNamed:@"微博"] forState:UIControlStateNormal];
        }else{
            
            //判断设备是否安装微信
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
                //判断是否有微信
                [shareBtn setBackgroundImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
            }else {
                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
            }
        }
        [self.view addSubview:shareBtn];
    }
    
}

- (void)shareClick:(UIButton*)sender {
    
}

-(void)creatPopview
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    view.backgroundColor = kbackgrayColor;
    view.alpha = 0.9;
    view.tag = 8888;
    
    _PopView.hidden=NO;
    _PopView=[[UIView alloc]initWithFrame:CGRectMake(kApplicationWidth/3, kApplicationHeight/2, kApplicationWidth-60, 230)];
    _PopView.alpha = 1;
    _PopView.tag=7777;
    
    _PopView.backgroundColor=kBackgroundColor;
    
    _PopView.center=CGPointMake(kApplicationWidth/2, kApplicationHeight/2);
    
    
    UILabel *titlelable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _PopView.frame.size.width, 30)];
    titlelable.text=@"请选择分享的宝贝";
    titlelable.textAlignment=NSTextAlignmentCenter;
    titlelable.font=[UIFont systemFontOfSize:15];
    [_PopView addSubview:titlelable];
    
    UITableView *MYtableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 30, _PopView.frame.size.width, _PopView.frame.size.height-30)];
    MYtableview.backgroundColor=kBackgroundColor;
    MYtableview.rowHeight=100;
    MYtableview.delegate=self;
    MYtableview.dataSource=self;
    [_PopView addSubview:MYtableview];
    
    
    
    [view addSubview:_PopView];
    [view bringSubviewToFront:_PopView];
    
    [self.view addSubview:_PopView];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView *view=(UIView*)[self.view viewWithTag:7777];
    [view removeFromSuperview];
    
}


#pragma mark 获取二维码图片 分享的参数
- (void)requestHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *storecode=[user objectForKey:STORE_CODE];
    NSString *shopcode=[user objectForKey:SHOP_CODE];
   
    NSString *url=[NSString stringWithFormat:@"%@shop/birth_qr?version=%@&shop_code=%@&store_code=%@",[NSObject baseURLStr],VERSION,shopcode,storecode];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            
            if(str.intValue==1)
            {
                
                ShareShopModel *shareModel=[ShareShopModel alloc];
                
                NSDictionary *dic = responseObject[@"store_shop"];
                
                if(dic != NULL)
                {
                    shareModel.qr_pic=responseObject[@"store_shop"][@"qr_pic"];
                    shareModel.content=responseObject[@"store_shop"][@"content"];
                    
                    NSString *four_pic=responseObject[@"store_shop"][@"four_pic"];
                    
                    NSArray *imageArray = [four_pic componentsSeparatedByString:@","];
                    
                    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
                    [user setObject:shareModel.content forKey:SHOP_TITLE];
                    
                    
                    if(imageArray.count > 2)
                    {
                        shareModel.shopImage = imageArray[2];
                        
                        [user setObject:shareModel.shopImage forKey:SHOP_PIC];
                        
                    }else {
                        
                        shareModel.shopImage = imageArray[0];
                    }
                    
                }
                
            }else if(str.intValue == 10030){//没登录状态
                
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud removeObjectForKey:USER_TOKEN];
                
                LoginViewController *login=[[LoginViewController alloc]init];
                
                login.tag=1000;
                login.loginStatue = @"10030";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
                
            }

        }
        
        
      
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");

        
    }];

    
}

#pragma mark 获取商品链接请求
- (void)shopRequest
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *shopcode=[user objectForKey:SHOP_CODE];
    NSString *realm = [user objectForKey:USER_ID];
    NSString *token = [user objectForKey:USER_TOKEN];
    
    [user setObject:self.orderCode forKey:ORDER_CODE];
    
    //shopcode %@,_ordercode %@",shopcode,_orderCode);
    [DataManager sharedManager].key = shopcode;
    NSString *url=[NSString stringWithFormat:@"%@shop/getShopLink?version=%@&shop_code=%@&realm=%@&token=%@&share=%@&getShop=true",[NSObject baseURLStr],VERSION,shopcode,realm,token,@"2"];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [[Animation shareAnimation] createAnimationAt:self.view];

    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//       responseObject = [NSDictionary changeType:responseObject];
        
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
                            [userdefaul setObject:[NSString stringWithFormat:@"%@/%@/%@",supcode,code,imgstr] forKey:SHOP_PIC];
                        }else{
                            NavgationbarView *mentinview = [[NavgationbarView alloc]init];
                            [mentinview showLable:@"获取数据失败,稍后重试" Controller:self];
                            
                            return ;
                        }
                        
                    }
                    
                    NSUserDefaults *userdefaul =[NSUserDefaults standardUserDefaults];
                    NSString *kickback = [NSString stringWithFormat:@"%d",[[userdefaul objectForKey:KICKBACK] intValue]];
                    
//                    NSString *price = [NSString stringWithFormat:@"%f",[shopdic[@"shop_se_price"] floatValue] - [kickback floatValue]];
                    
                     NSString *price = [NSString stringWithFormat:@"%f",[shopdic[@"shop_se_price"] floatValue]*0.5];
                    if(price)
                    {
                        [userdefaul setObject:price forKey:SHOP_PRICE];
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


-(void)createAnimationAt:(UIView *)View;
{
    UIView *animationView = [[UIView alloc] initWithFrame:CGRectMake(0, kApplicationHeight-ZOOM(80*3.4), kScreenWidth, ZOOM6(120))];
    animationView.backgroundColor = [UIColor clearColor];
    animationView.alpha = 1;
    animationView.tag = 777;
    [View addSubview:animationView];
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ZOOM6(120), ZOOM6(120))];
    iv.contentMode = UIViewContentModeScaleAspectFit;
    iv.center = CGPointMake(animationView.center.x, animationView.frame.size.height/2);
    
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

- (UIView*)creatKickbackAnimationwithDurtime:(int)time
{
    UIView *animationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight+kUnderStatusBarStartY)];
    animationView.backgroundColor = [UIColor clearColor];
    animationView.alpha = 1;
    animationView.tag = 888;
    
    [self.view addSubview:animationView];
    
    [self.view bringSubviewToFront:animationView];
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight+kUnderStatusBarStartY)];
    iv.contentMode = UIViewContentModeScaleAspectFit;
    iv.center = CGPointMake(animationView.center.x, animationView.frame.size.height/2);
    
    iv.tag = 778;
    iv.userInteractionEnabled=YES;
    iv.layer.cornerRadius=iv.frame.size.width/2;
    [animationView addSubview:_animationView = iv];
    
    NSMutableArray *anArr = [NSMutableArray array];
    

    for (int i = 0 ; i<25; i++) {
        NSString *gStr = [NSString stringWithFormat:@"%@%d",@"share00",i+20];
        
        NSString *file = [[NSBundle mainBundle] pathForResource:gStr ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:file];
        [anArr addObject:image];
    }

    iv.animationImages = anArr;    //动画图片数组
    iv.animationDuration = 3;      //执行一次完整动画所需的时长
    iv.animationRepeatCount = time;   //无限
    [iv startAnimating];
    
    
    return animationView;

}


- (void)share
{
    
    //配置分享平台信息
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app shardk];
    
    [[DShareManager share] shareAppWithType:ShareTypeWeixiTimeline View:nil Image:nil WithShareType:@"index"];
    
    //微信分享界面跳转前先返回到上一层


    [self performSelector:@selector(gotoback) withObject:nil afterDelay:0.5];
}

#pragma mark 分享前先返回上一层
- (void)gotoback
{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    if ([self.navigationController.viewControllers[self.navigationController.viewControllers.count-2]isKindOfClass:[OrderTableViewController class]]) {
        OrderTableViewController *view=self.navigationController.viewControllers[self.navigationController.viewControllers.count-2];
        [self.navigationController popToViewController:view animated:YES];
    }else{
        for (UIViewController *controller in self.navigationController.viewControllers) {
            
            if ([controller isKindOfClass:[OrderTableViewController class]]) {
                
                [self.navigationController popToViewController:controller animated:YES];
                
                return;
                
            }
            
           if ([controller isKindOfClass:[AffirmOrderViewController class]]){
                
                [self.navigationController popToViewController:controller animated:YES];
                
                return;
            }
            
            //        else if ([controller isKindOfClass:[ShopDetailViewController class]]) {
            //
            //            [self.navigationController popToViewController:controller animated:YES];
            //
            //            return;
            //        }
            
            //        else if ([controller isKindOfClass:[MyOrderViewController class]]) {
            else if ([controller isKindOfClass:[MyOrderViewController class]]&&![self.navigationController.viewControllers[self.navigationController.viewControllers.count-2]isKindOfClass:[OrderTableViewController class]]) {
                
                [self.navigationController popToViewController:controller animated:YES];
                
                return;
            }
            else if ([controller isKindOfClass:[OrderDetailViewController class]]&&![self.navigationController.viewControllers[self.navigationController.viewControllers.count-2]isKindOfClass:[OrderTableViewController class]])
            {
                [self.navigationController popToViewController:controller animated:YES];
                
                return;
            }
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    cell.backgroundColor=kBackgroundColor;
    return cell;

}


-(void)back:(UIButton*)sender
{
//    [self postNotification];
    
    if (self.BackBlock) {
        self.BackBlock();
    }
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
    [_sharetimer invalidate];
    _sharetimer = nil;

    if ([self.navigationController.viewControllers[self.navigationController.viewControllers.count-2]isKindOfClass:[OrderTableViewController class]]) {
        OrderTableViewController *view=self.navigationController.viewControllers[self.navigationController.viewControllers.count-2];
        [self.navigationController popToViewController:view animated:YES];
    }else{
        
        //分享成功后直接跳转到详情页面
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[OrderTableViewController class]]) {
                
                [self.navigationController popToViewController:controller animated:YES];
                
                return;
                
            }else if ([controller isKindOfClass:[AffirmOrderViewController class]]) {
                
                [self.navigationController popToViewController:controller animated:YES];
                
                return;
            }
           
            

            
            //        else if ([controller isKindOfClass:[ShopDetailViewController class]]) {
            //
            //
            //            [self.navigationController popToViewController:controller animated:YES];
            //
            //            return;
            //        }
            
            else if ([controller isKindOfClass:[MyOrderViewController class]]&&![self.navigationController.viewControllers[self.navigationController.viewControllers.count-2]isKindOfClass:[OrderTableViewController class]]) {
                
                [self.navigationController popToViewController:controller animated:YES];
                
                return;
            }
        }
        
    }

}

//- (void)postNotification
//{
//    UIView *view = (UIView*)[self.view viewWithTag:9797];
//    
//    if(!view)
//    {
//        
//        NSNotification *notification=[NSNotification notificationWithName:@"Intelligencesharefail" object:nil];
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"Intelligencesharefail" object:nil];
//        
//    }
//
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
