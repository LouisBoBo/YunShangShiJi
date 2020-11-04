//
//  HomeSingViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 16/3/29.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "HomeSingViewController.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "NavgationbarView.h"
#import "MJRefresh.h"
#import "SignModel.h"
#import "AppDelegate.h"
#import "DShareManager.h"
#import "MBProgressHUD.h"
#import "MobClick.h"
#import "TFShoppingViewController.h"
#import "TFNoviceTaskView.h"
#import "CollocationVC.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <QZoneConnection/ISSQZoneApp.h>
#import "TFLedBrowseShopViewController.h"
#import "TFIndianaRecordViewController.h"
#import "TFMyWalletViewController.h"
#import "TFMyCardViewController.h"
#import "LoginViewController.h"
#import "HYJIntelgralDetalViewController.h"
#import "TFLoginView.h"
#import "SubmitViewController.h"
#import "QRCodeGenerator.h"
#import "DShareManager.h"
#import "ProduceImage.h"
#import "NewSigninViewController.h"
#import "TFHomeViewController.h"
#import "ShopStoreViewController.h"
#import "TFSalePurchaseViewController.h"
#import "TFOldPaymentViewController.h"
#import "ComboShopDetailViewController.h"
#import "IndianaDetailViewController.h"
#import "IndianaOweViewController.h"
#import "DoubleModel.h"
#import "YFDoubleSucessVC.h"

#import "TopRemindView.h"
#import "UIView+Animation.h"

#define SHAREMODELHEIGH ZOOM(230*3.4)
#define SHAREBUTTONHEIGH ZOOM(60*3.4)

#define SignViewTwoTag @"SignViewTwoTag"
#define SignViewTwoDate @"SignViewTwoDate"

@interface HomeSingViewController ()<SubmitViewControllerDelegate,DShareManagerDelegate,UIAlertViewDelegate>

@end

@implementation HomeSingViewController
{
    UITableView *_MytableView;        //列表
    
    UIImageView *_HeadImageview;      //列表的头
    
    UIImageView *_SignImageview;      //签到奖励
    
    UIScrollView *_Myscrollview;      //主界面
    
    NSMutableArray *_MydataArray;     //数据源
    NSMutableArray *_motaskList;      //任务列表数据
    NSMutableArray *_motaskDataArray;
    NSMutableArray *_finishtaskList;  //完成任务列表
    NSMutableArray *_discreptionList; //签到说明数据
    
    
    //弹框
    UIView *_Popview;
    UIView *_InvitationCodeView;
    UIButton *_canclebtn; //弹框关闭按钮
    UIView *_backview;
    
    //分享弹框
    UIView *_SharePopview;
    UIView *_ShareInvitationCodeView;
    UIView *_SharebackView;
    UIButton *_Sharecanclebtn; //弹框关闭按钮
    UIImageView *_SharetitleImg;//分享弹框的头
    UIView *_shareModelview;   //分享前弹框
    NSString *_shareType;       //分享类型
    UIImage *_shareImage;       //分享图片
    UILabel *_timelable;
    UILabel *_storetimelable;   //开店倒计时
    
    UILabel *_cornerlab;//补签角标
    
    BOOL _isBuqianka;
    
    NavgationbarView *_mentionview;
    
    NSString *_signIn_status;//是否签到
    
    int _selectSigntag;//记录点击内容的tag
    
    NSString *_Myvalue;
    
    BOOL _ismentionshow;//是否顺序提示
    BOOL _istodayshow; //是否今天提示
    BOOL _ishuodongtu; //是否是活动图片
    
    NSString *_changeTable;
    
    NSString *_selectshop_type;//是包邮商品 还是夺宝商品
    
    BOOL _isWeixin_share; //是否是微信分享
    
    TFNoviceTaskView *TwoOrFiveView;//2元或5元的弹框
    TopRemindView *RemindView;
    
    NSTimer *_mytimer;
    int _timeCount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _MydataArray = [NSMutableArray array];
    _motaskList = [NSMutableArray array];
    _finishtaskList = [NSMutableArray array];
    _discreptionList = [NSMutableArray array];
    
    [self creatNavgationView];
    [self creatMainView];
    [self PopSignView];
    
    _isWeixin_share = NO;
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    _ismentionshow = YES;
    _istodayshow = YES;
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];

    [MobClick beginLogPageView:@"QiandaoPage"];
    
    [self creatData];
    
    
    //测试用后面删除
//    [self beginShareTitlePopView];
    
//    [self beginShareImagePopView];
    
    [self creatFinishPopview:DAILY_TASK_DOUBLE];
    
//    [self creatSharePopView:DAILY_TASK_STORE];
    
//    [self popTomorrowView:DAILY_TASK_JIFEN];
    
//    [self creatPopView:@"几元夺宝"];
    
    //开店成功回来弹框
    if(self.fromType !=nil)
    {
        _Myvalue = @"3";
        
        [_SharePopview removeFromSuperview];
        [self creatSharePopView:DAILY_TASK_STORE];

        NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
        NSString *nowtime = [userdefaul objectForKey:DOUBLE_S_TIME];
        
        [_mytimer invalidate];
        _mytimer = nil;
        
        _timeCount = 0;
        _mytimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nowtime repeats:YES];
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];

        [user setObject:@"1" forKey:@"isShowNoviceTaskView6"];
        
        self.fromType = nil;
        _Myvalue = nil;
    }else{
        
        [RemindView removeFromSuperview];
        
        if([DataManager sharedManager].isOligible == YES )
        {
            [self setRemindView];
        }
    }


    
    //监听支付成功回调通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paysuccess:) name:@"paysuccess" object:nil];
    
    //监听支付失败回调通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buyfail:) name:@"buyfail" object:nil];

    _mentionview = [[NavgationbarView alloc]init];
    

}

- (void)viewDidAppear:(BOOL)animated
{
    //监听补签分享成功通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(liulansharesuccess:) name:@"liulansharesuccess" object:nil];

}

#pragma mark - 弹窗相关  签到“2元”或“5元”弹窗

- (void)showSignViewTwoOrFive:(NSString *)ShareString
{
    TwoOrFiveView = [[TFNoviceTaskView alloc] init];
    [TwoOrFiveView returnClick:^(NSInteger type) {

        [self performSelector:@selector(gotoQiandao) withObject:nil afterDelay:0.2];
        
    } withCloseBlock:^(NSInteger type) {
        
    }];
    [TwoOrFiveView showWithType:ShareString];
}
-(void)PopSignView
{
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:Phone_isOpen]integerValue]==0  &&
        ![[MyMD5 getCurrTimeString:@"year-month-day"]isEqualToString:[[NSUserDefaults standardUserDefaults]objectForKey:SignViewTwoDate]]){
        [self showSignViewTwoOrFive:@"签到_5元现金"];
        [[NSUserDefaults standardUserDefaults]setObject:[MyMD5 getCurrTimeString:@"year-month-day"] forKey:SignViewTwoDate];
        
        
    } else if ([[[NSUserDefaults standardUserDefaults]objectForKey:SignViewTwoTag]integerValue]<3 &&
               ![[MyMD5 getCurrTimeString:@"year-month-day"]isEqualToString:[[NSUserDefaults standardUserDefaults]objectForKey:SignViewTwoDate]]){
        [self showSignViewTwoOrFive:@"签到_2元现金"];
        NSString *string = [[NSUserDefaults standardUserDefaults]objectForKey:SignViewTwoTag];
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",[string intValue]+1] forKey:SignViewTwoTag];
        [[NSUserDefaults standardUserDefaults]setObject:[MyMD5 getCurrTimeString:@"year-month-day"] forKey:SignViewTwoDate];
        
    }
}

#pragma mark 3元2元弹框激发的签到任务
- (void)gotoQiandao
{
    MyLog(@"count = %d",(int)_finishtaskList.count);
    
    int tag = (int)_finishtaskList.count;
    _selectSigntag = tag;
    
    [self qianDao:tag];
}

#pragma mark *********检测是否登录*********
- (void)islog
{
    //用户是否登录
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *token = [userdefaul objectForKey:USER_TOKEN];
    
    if(token == nil)
    {
        [self ToLoginView];
        
        return;
    }

}
- (void)ToLoginView
{
    TFLoginView *tf = [[TFLoginView alloc] initWithHeadImage:nil contentText:nil upButtonTitle:nil downButtonTitle:nil];
    [tf show];
    
    tf.upBlock = ^() { //注册
        //上键");
        
        [self ToLogin:2000];
    };
    
    tf.downBlock = ^() {// 登录
        //下键");
        
        [self ToLogin:1000];
    };
}
#pragma mark 跳转到登录界面
- (void)ToLogin :(NSInteger)tag
{
    LoginViewController *login=[[LoginViewController alloc]init];
    login.tag = tag;
    login.loginStatue=@"toBack";
    login.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:login animated:YES];
}


#pragma mark **************UI***************
-(void)creatNavgationView
{
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    headview.image=[UIImage imageNamed:@"导航背景"];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 80, 44);
    [backbtn addTarget:self action:@selector(leftBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_高亮"] forState:UIControlStateHighlighted];
//    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, headview.frame.size.width, 40);
    titlelable.center=CGPointMake(kScreenWidth/2, headview.frame.size.height/2+10);
    titlelable.text= @"签到";
    titlelable.font = [UIFont systemFontOfSize:ZOOM(57)];
    titlelable.textColor=[UIColor blackColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, headview.frame.size.height-1, kScreenWidth, 1)];
    line.backgroundColor=lineGreyColor;
    [headview addSubview:line];
}


- (void)creatMainView
{
    _Myscrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64+kUnderStatusBarStartY-59)];
    _Myscrollview.scrollEnabled = YES;
    _Myscrollview.showsVerticalScrollIndicator = NO;
    _Myscrollview.userInteractionEnabled = YES;
   
    UIView *headview = [self creatHeadView];
    [_Myscrollview addSubview:headview];
    
    UIView *signview = [self creatSignView];
    [_Myscrollview addSubview:signview];
    
     _Myscrollview.contentSize = CGSizeMake(0, CGRectGetHeight(_HeadImageview.frame)+CGRectGetHeight(_SignImageview.frame)+kUnderStatusBarStartY - ZOOM(20*3.4));
    
    [self.view addSubview:_Myscrollview];
    
}

#pragma mark 头部
- (UIView*)creatHeadView
{
    
    CGFloat headimageW =IMGSIZEW(@"qiandaobg1");
    CGFloat headimageH =IMGSIZEH(@"qiandaobg1");
    CGFloat spaceX = 0;
    
    if(headimageW > kScreenWidth)
    {
        spaceX = (headimageW - kScreenWidth)/2;
    }

    _HeadImageview = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-headimageW)/2, 0, headimageW, headimageH)];
    _HeadImageview.image = [UIImage imageNamed:@"qiandaobg1"];
    _HeadImageview.userInteractionEnabled = YES;
    
    //夺宝记录
    UIImageView *Retroactiveimage = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-IMGSIZEW(@"duobaojilu_hover")+spaceX-10, 0, IMGSIZEW(@"duobaojilu_hover"), IMGSIZEH(@"duobaojilu_hover"))];
    
    Retroactiveimage.image = [UIImage imageNamed:@"duobaojilu_hover"];
    Retroactiveimage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *Retroactivetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(RetroactiveClick:)];
    [Retroactiveimage addGestureRecognizer:Retroactivetap];
    
    [_HeadImageview addSubview:Retroactiveimage];
    
    //顶部钱包 积分 卡券 按钮
    CGFloat btnwidth = kScreenWidth/3;
    CGFloat btnheigh = 50;
    
    CGFloat labimageW = IMGSIZEW(@"jifen");
    CGFloat labimageH = IMGSIZEH(@"jifen");
    
    CGFloat typimageW = ZOOM(25*3.4);
    
    for(int i =0;i<3;i++)
    {
        UIButton *otherbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        otherbtn.frame = CGRectMake(i*btnwidth+spaceX, ZOOM(36), btnwidth, btnheigh);
        otherbtn.tag = 10000+i;
        [otherbtn addTarget:self action:@selector(otherClick:) forControlEvents:UIControlEventTouchUpInside];
        [_HeadImageview addSubview:otherbtn];
        
        
        UIImageView *labimageview = [[UIImageView alloc]initWithFrame:CGRectMake((btnwidth-labimageW)/2+i*btnwidth+spaceX, ZOOM(20)+(btnheigh-labimageH)/2, labimageW, labimageH)];
        labimageview.layer.cornerRadius = labimageH/2;
        
        [_HeadImageview addSubview:labimageview];
        
        
        if(i==0)
        {
            labimageview.image = [UIImage imageNamed:@"yu e"];
        }else if (i==1)
        {
            labimageview.image = [UIImage imageNamed:@"jifen"];
        }else if (i==2)
        {
            labimageview.image = [UIImage imageNamed:@"youhuijuan"];
            
        }

        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(typimageW, 0, labimageW-typimageW, labimageH-5)];
        lable.font = [UIFont systemFontOfSize:ZOOM(47)];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = tarbarrossred;
        lable.text = @"0";
        lable.tag = 400000+i;
        [labimageview addSubview:lable];
        
    }
    
    CGFloat cornerlabW = ZOOM(18*3.4);
    
    _cornerlab = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-ZOOM(30)-15, Retroactiveimage.frame.size.height/2-cornerlabW-2, cornerlabW, cornerlabW)];
    _cornerlab.backgroundColor = [UIColor redColor];
    _cornerlab.text = @"";
    _cornerlab.textAlignment = NSTextAlignmentCenter;
    _cornerlab.textColor = [UIColor whiteColor];
    _cornerlab.clipsToBounds = YES;
    _cornerlab.font = [UIFont systemFontOfSize:ZOOM(40)];
    _cornerlab.layer.cornerRadius = cornerlabW/2;
    _cornerlab.hidden = YES;
//    [_HeadImageview addSubview:_cornerlab];
    
    //签到说明
    CGFloat discriptionW = IMGSIZEW(@"qiandaoshuoming");;
    CGFloat discriptionH = IMGSIZEH(@"qiandaoshuoming");
    UIImageView *discriptionimage = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-discriptionW+spaceX, CGRectGetHeight(Retroactiveimage.frame)+ZOOM(10*3.4), discriptionW, discriptionH)];
    discriptionimage.image = [UIImage imageNamed:@"qiandaoshuoming"];
    discriptionimage.userInteractionEnabled = YES;
    
    UILabel *discriptionlab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, discriptionW, discriptionH)];
    discriptionlab.numberOfLines = 0;
    discriptionlab.textAlignment = NSTextAlignmentCenter;
    discriptionlab.text = @"签到说明";
    discriptionlab.font = [UIFont systemFontOfSize:ZOOM(51)];
    discriptionlab.textColor = [UIColor whiteColor];
    
    
    UITapGestureRecognizer *discriptiontap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(discriptionClick:)];
    [discriptionimage addGestureRecognizer:discriptiontap];
    
    [_HeadImageview addSubview:discriptionimage];
    
    return _HeadImageview;
}

#pragma mark 签到奖励
- (UIView*)creatSignView
{
    _SignImageview = [[UIImageView alloc]init];
    _SignImageview.frame = CGRectMake(ZOOM(30), CGRectGetMaxY(_HeadImageview.frame)-20, kScreenWidth-2*ZOOM(30), 0);
    _SignImageview.image = [UIImage imageNamed:@"qiandaobg@2x"];
    _SignImageview.userInteractionEnabled = YES;
    
    CGFloat width = (CGRectGetWidth(_SignImageview.frame)-ZOOM(20)*2)/5;

    CGFloat heigh = width+ZOOM(60);
    
    int xxxx=0;
    int yyyy=0;
    
    //当月任务数由当月天数决定
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate date]];
   
    NSUInteger numberOfDaysInMonth = range.length;
    
    for(int i=0;i<numberOfDaysInMonth;i++)
    {
        xxxx = i%5;
        yyyy = i/5;
    
        //底视图
        UIView *baseview = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(20)+width*xxxx, heigh*yyyy+50, width, heigh)];
        baseview.tag = 50000+i;
        baseview.userInteractionEnabled = YES;
        [_SignImageview addSubview:baseview];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SignImageClick:)];
        [baseview addGestureRecognizer:tap];
        
        
        //小图片
        CGFloat titleimageW =IMGSIZEW(@"积分");
        
        UIImageView *titltimage = [[UIImageView alloc]initWithFrame:CGRectMake((width-titleimageW)/2, ZOOM(20), titleimageW, titleimageW)];
        titltimage.tag = 60000+i;
        titltimage.contentMode=UIViewContentModeScaleAspectFit;
        [baseview addSubview:titltimage];
        [baseview sendSubviewToBack:titltimage];
        
        //任务状态图片
        CGFloat statueimageW = IMGSIZEW(@"yilingqu");
        CGFloat statueimageH = IMGSIZEH(@"yilingqu");
        UIImageView *statueimage = [[UIImageView alloc]initWithFrame:CGRectMake((width-statueimageW)/2+2, (titleimageW-statueimageH)/2-5, titleimageW, titleimageW)];
        statueimage.tag = 80000+i;
        statueimage.contentMode=UIViewContentModeScaleAspectFit;
        [baseview addSubview:statueimage];
        
        
        //内容
        CGFloat titlelabeY = CGRectGetMaxY(titltimage.frame);
        
        UILabel *titlelable = [[UILabel alloc]initWithFrame:CGRectMake(0, titlelabeY, width, ZOOM(20*3.4))];
        titlelable.numberOfLines = 0;
        
        titlelable.tag = 70000+i;
        titlelable.textAlignment = NSTextAlignmentCenter;
        titlelable.textColor = RGBCOLOR_I(125, 125, 125);
        titlelable.font = [UIFont systemFontOfSize:ZOOM(37)];
        [baseview addSubview:titlelable];

    }
    
    int signrow;
    if(numberOfDaysInMonth > 30)
    {
        signrow = (int)numberOfDaysInMonth / 5 +1;
    }else{
        signrow = (int)numberOfDaysInMonth / 5 ;
    }
    _SignImageview.frame = CGRectMake(ZOOM(30), CGRectGetMaxY(_HeadImageview.frame)-ZOOM(20*3.4), kScreenWidth-2*ZOOM(30), signrow*heigh+90);
    
   
    return _SignImageview;
}


#pragma mark 开始抖动
- (void)goshake:(int)tag
{
    UIView *baseview = (UIView*)[_SignImageview viewWithTag:50000 + tag];
    
    [baseview shakeStatus:YES];
}

#pragma mark 停止抖动
- (void)stopshake:(int)tag
{
    UIView *baseview = (UIView*)[_SignImageview viewWithTag:50000 + tag];
    
    [baseview shakeStatus:NO];
}

#pragma mark 数据源
- (void)creatData
{

    //数据统计
    [self requestHttp];
    
    //任务列表
    [self taskListHttp];
    
    NSArray *disarray = @[@"每天分享美衣进行签到，即可领取当天奖励。",
                          @"签到领取的现金存进衣蝠余额，达到2元可提现。",
                          @"签到领取的积分和优惠券，可以抵扣商品价。",
                          @"签到领取1元/2元/3元/5元包邮机会须分享购买后方可完成当日签到。",
                          @"签到分享的美衣有好友购买,还有商品价格10%的现金奖励!坚持签到轻松月赚千元零花哦~",
                          @"本次活动仅限女性用户参与。",
                         ];
    _discreptionList = [NSMutableArray arrayWithArray:disarray];
    
}

#pragma mark *************tableView*************
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *content = _discreptionList[indexPath.row];
    
    
    CGFloat Heigh = [self getRowHeight:content fontSize:ZOOM(45)];

    return Heigh+ZOOM(8*3.4);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _discreptionList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    CGFloat headlabW = 20;
    UILabel *headlab = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(30), (60-headlabW)/2, headlabW, headlabW)];
    headlab.backgroundColor = tarbarrossred;
    headlab.tag = 200000+indexPath.row;
    headlab.textColor=[UIColor whiteColor];
    headlab.clipsToBounds = YES;
    headlab.layer.cornerRadius = headlabW/2;
    headlab.text = [NSString stringWithFormat:@"%d",(int)indexPath.row+1];
    headlab.textAlignment = NSTextAlignmentCenter;
    headlab.font = [UIFont systemFontOfSize:ZOOM(43)];
//    [cell addSubview:headlab];
    
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"q-%d",(int)indexPath.row+1]];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",_discreptionList[indexPath.row]];
    
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.textColor=kTextColor;
    cell.textLabel.font = [UIFont systemFontOfSize:ZOOM(45)];
    
    return cell;
}

-(CGFloat)getRowHeight:(NSString *)text fontSize:(CGFloat)fontSize
{
    //文字高度
    CGFloat height;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(CGRectGetWidth(_MytableView.frame)- ZOOM(55*3.4), 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
        
    }
    else{
        
    }
    
    return height;
}

#pragma mark **************点击事件*******************
#pragma mark 顶部钱包 积分 卡券的点击事件
- (void)otherClick:(UIButton*)sender
{
    kSelfWeak;
    [self loginVerifySuccess:^{
        if(sender.tag == 10000)
        {
            [MobClick event:QIANDAO_YUER];
            
            MyLog(@"钱包");
            TFMyWalletViewController *wallet = [[TFMyWalletViewController alloc]init];
            wallet.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:wallet animated:YES];
            
        }else if (sender.tag == 10001)
        {
            MyLog(@"积分");
            [MobClick event:QIANDAO_JIFEN];
            
            HYJIntelgralDetalViewController *vc = [[HYJIntelgralDetalViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.index = 0;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        }else if (sender.tag == 10002)
        {
            MyLog(@"卡券");
            [MobClick event:QIANDAO_KAQUAN];
            TFMyCardViewController *tmvc = [[TFMyCardViewController alloc] init];
            tmvc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:tmvc animated:YES];
        }
    }];
}

#pragma mark 夺宝记录点击事件
- (void)RetroactiveClick:(UITapGestureRecognizer*)tap
{
    [MobClick event:QIANDAO_BUQIAN];
    kSelfWeak;
    [self loginVerifySuccess:^{
        TFIndianaRecordViewController *tiVC = [[TFIndianaRecordViewController alloc] init];
        tiVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:tiVC animated:YES];
    }];
}

#pragma mark 签到说明点击事件
- (void)discriptionClick:(UITapGestureRecognizer*)tap
{
    MyLog(@"签到说明");
    [MobClick event:QIANDAO_SHUOMING];
    
    if(!_Popview)
    {
        [self creatPopView:@"签到说明"];
    }
}

#pragma mark 签到任务点击事件
- (void)SignImageClick:(UITapGestureRecognizer*)tap
{
    
    int tag = tap.view.tag%50000;
    
    _selectSigntag = tag;
    
    [self qianDao:tag];
}

#pragma mark 去完成签到任务
- (void)qianDao:(int)tag
{
    [MobClick event:QIANDAO_RENWU];

    //用户是否登录
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *token = [userdefaul objectForKey:USER_TOKEN];
    
    if(token == nil)
    {
        [self loginVerifySuccess:nil];
        return;
    }

    if(tag == _finishtaskList.count)//当天的签到任务
    {
        if(tag==0)//去开店
        {
            if(_motaskList.count)
            {
                NSString *todaystatue = [self signImagestatue:tag];
                
                if(_signIn_status.intValue == 0)//没签到
                {
                    if([todaystatue intValue] == 6)//开店
                    {
                        //开店前先检测是否绑定手机号
                        [self httpFindPhone];
                        
                    }else if([todaystatue intValue] == 7)
                    {
                        //夺宝弹框
                        [self creatPopView:@"几元夺宝"];
                        
                    }else if([todaystatue intValue] == 8)
                    {
                        //余额翻倍
                        [self beginShareTitlePopView];
                        
                    }else if ([todaystatue intValue] == 20)
                    {
                        //强制浏览
                        [self goLedBrowse];
                    }
                    else
                    {
                        //分享前弹框
                        [self beginshareStatue];
                    }

                }else if (_signIn_status.intValue == 1)//已签到
                {
                
                    if(_istodayshow == YES)
                    {
                        _istodayshow = NO;
                        [_mentionview disapperlable];
                        [_mentionview showLable:@"今天已经签到，亲~" Controller:self];
                        
                        [self performSelector:@selector(todayshow) withObject:self afterDelay:2.5];
                    }

                }
                
            }
            
        }else{
            
            if(_signIn_status.intValue == 0)//没签到
            {
                NSString *todaystatue = [self signImagestatue:tag];
                MyLog(@"todaystatue = %@",todaystatue);
                
                if(todaystatue.intValue == 7)//签到包邮
                {
                    
                    if(!_Popview)
                    {
                        [self creatPopView:@"几元夺宝"];
                    }

                }else if (todaystatue.intValue == 8)
                {
                    //余额翻倍
                    [self beginShareTitlePopView];
                    
                }else if ([todaystatue intValue] == 20)
                {
                    //强制浏览
                    [self goLedBrowse];
                }
                else{
                    
                    [self beginshareStatue];
                }
            
            }else if (_signIn_status.intValue == 1)//已签到
            {
                
                NSString *todaystatue = [self signImagestatue:tag];
                
                [self gotomorrowType:todaystatue];
            
            }
            
        }
        
    }
    else if (tag > _finishtaskList.count)//未完成的任务
    {
        
        if(_signIn_status.intValue == 1)//已经签到
        {
            if(_istodayshow == YES)
            {
                _istodayshow = NO;
                
                [_mentionview disapperlable];
                [_mentionview showLable:@"今天已经签到，亲~" Controller:self];
                
                [self performSelector:@selector(todayshow) withObject:self afterDelay:2.5];
            }

        }else{
            
            if(_ismentionshow == YES)
            {
                _ismentionshow = NO;
                
                [_mentionview disapperlable];
                [_mentionview showLable:@"请按顺序完成签到，亲~" Controller:self];
                
                [self performSelector:@selector(mentionshow) withObject:self afterDelay:2.5];
            }
            
        }
        
    }
    else{//已经完成的签到任务中如有去抢购还可弹出去抢购弹框
        
        if(tag < _finishtaskList.count)
        {
            NSString *todaystatue = [self signImagestatue:tag];
            
            if(todaystatue.intValue == 2)//已经完成过的任务中有0元疯抢直接跳到0元购
            {
                Mtarbar.selectedIndex=3;
            }
        }
    }

}

- (void)beginshareStatue
{
    BOOL yestodayisshare = YES;
    for(int j =0; j <_finishtaskList.count;j++)
    {
        NSString *yestodaystatue = [self signImagestatue:j];
        if(yestodaystatue.intValue == 3 ||yestodaystatue.intValue == 4 ||yestodaystatue.intValue == 5 ||yestodaystatue.intValue == 8)
        {
            yestodayisshare = YES;
            break;
        }
    }
    
    if(yestodayisshare == NO)
    {
        [self beginShareTitlePopView];
    }else{
        [self beginShareImagePopView];
    }

}
- (void)gotoshareType:(NSString*)type Tag:(int)tag
{
    switch (type.intValue) {
        case 1:
            
             [self creatShareModelView:DAILY_TASK_BUQIAN Image:nil];
            
            break;
        case 2:
            
            //去分享
            [self creatShareModelView:DAILY_TASK_ZERO Image:nil];
            
            break;
        case 3:
            
            //去分享
            [self creatShareModelView:DAILY_TASK_YOUHUI Image:nil];
            
            break;
        case 4:
            
            //去分享
            [self creatShareModelView:DAILY_TASK_JIFEN Image:nil];
            
            break;
        case 5:
            
            //去分享
            [self creatShareModelView:DAILY_TASK_XIANJING Image:nil];
            
            break;
        case 6:
            
            //去分享
            [self creatShareModelView:DAILY_TASK_STORE Image:nil];
            
            break;
      
        case 8:
            //去分享
            [self creatShareModelView:DAILY_TASK_DOUBLE Image:nil];
        
            break;
            
        case 20:
            
            //强制浏览
            [self goLedBrowse];
        
            break;
  
        default:
            break;
    }


}

#pragma mark 预告明日任务类型
- (void)gotomorrowType:(NSString*)type
{
    switch (type.intValue) {
        case 3:
            
            [self popTomorrowView:DAILY_TASK_YOUHUI];
            
            break;
        case 4:

            [self popTomorrowView:DAILY_TASK_JIFEN];
            break;
            
        case 5:
            
            [self popTomorrowView:DAILY_TASK_XIANJING];
            break;
        case 7:
            
            [self popTomorrowView:DAILY_TASK_BAOYOU];
            break;
            
        case 8:
            
            [self popTomorrowView:DAILY_TASK_DOUBLE];
            break;
            
        case 20:
            
            [self popTomorrowView:DAILY_TASK_XIANJING];
            
            break;
            
        default:
            break;
    }
    
    
}

#pragma mark 强制浏览
- (void)goLedBrowse
{
    TFLedBrowseShopViewController *lbVC = [[TFLedBrowseShopViewController alloc] init];
    [lbVC setBrowseFinishBlock:^{ /**< 完成强制浏览 */
        
        
    } browseFail:^{ /**< 未完成强制浏览 */
        
        
    }];
    
    lbVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:lbVC animated:YES];
}

//是否提示
- (void)mentionshow
{
    _ismentionshow = YES;
}
- (void)todayshow
{
    _istodayshow = YES;
}
#pragma mark ******************* 弹框  ****************/
-(void)creatPopView:(NSString*)str
{
    _Popview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    
    _Popview.userInteractionEnabled = YES;

    
    //弹框内容
    _InvitationCodeView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(120), ZOOM(420)-(IMGSIZEW(@"icon_close1")/2), kScreenWidth-ZOOM(120)*2, kScreenHeight-ZOOM(420)*2+IMGSIZEW(@"icon_close1"))];
    _InvitationCodeView.backgroundColor=[UIColor clearColor];
    
    _InvitationCodeView.clipsToBounds = YES;
    [_Popview addSubview:_InvitationCodeView];
    
    //关闭按钮
    CGFloat btnwidth = IMGSIZEW(@"icon_close1");
    
    _canclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _canclebtn.frame=CGRectMake(CGRectGetWidth(_InvitationCodeView.frame)-btnwidth-ZOOM(10), 0, btnwidth, btnwidth);
    [_canclebtn setImage:[UIImage imageNamed:@"icon_close1"] forState:UIControlStateNormal];
    _canclebtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    _canclebtn.layer.cornerRadius=btnwidth/2;
    [_canclebtn addTarget:self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
    [_InvitationCodeView addSubview:_canclebtn];
    
    _backview = [[UIView alloc]initWithFrame:CGRectMake(0,btnwidth+ZOOM(30), kScreenWidth-ZOOM(120)*2,CGRectGetHeight(_InvitationCodeView.frame)-btnwidth-ZOOM(30))];
    _backview.backgroundColor=[UIColor whiteColor];
    _backview.layer.cornerRadius=5;
    _backview.clipsToBounds = YES;
    [_InvitationCodeView addSubview:_backview];
    
    UIImageView *bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _InvitationCodeView.frame.size.width, _InvitationCodeView.frame.size.height/8)];
    bgImg.backgroundColor=tarbarrossred;
    [_backview addSubview:bgImg];
    
    
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(bgImg.frame), CGRectGetHeight(bgImg.frame))];
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.backgroundColor = [UIColor clearColor];
    titlelabel.font = [UIFont systemFontOfSize:ZOOM(70)];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    [_backview addSubview:titlelabel];
    
    if([str isEqualToString:@"签到说明"])
    {
        titlelabel.text = @"任务签到说明";
        
        _MytableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bgImg.frame)+5, CGRectGetWidth(bgImg.frame), CGRectGetHeight(_backview.frame)-CGRectGetHeight(bgImg.frame)-10) style:UITableViewStylePlain];
        _MytableView.delegate = self;
        _MytableView.dataSource = self;
        [self.view addSubview:_MytableView];
        _MytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _MytableView.showsVerticalScrollIndicator = YES;
        [_MytableView registerNib:[UINib nibWithNibName:@"PartnerCardCell" bundle:nil] forCellReuseIdentifier:@"CardCell"];
        [_backview addSubview:_MytableView];
        
    }else if([str isEqualToString:@"几元夺宝"])
    {
        _InvitationCodeView.frame = CGRectMake(ZOOM(120), (kScreenHeight - ZOOM6(580))/2, kScreenWidth-ZOOM(120)*2, ZOOM6(580));
        
        _backview.frame = CGRectMake(0,0, kScreenWidth-ZOOM(120)*2,CGRectGetHeight(_InvitationCodeView.frame));
        
        NSString *value = [self signtypestatue:_selectSigntag];
        MyLog(@"value = %@",value);

        titlelabel.text = [NSString stringWithFormat:@"%@元夺宝",value];
        
        [self creatDuobao:bgImg Value:value];
        
        _canclebtn.frame=CGRectMake(CGRectGetWidth(_InvitationCodeView.frame)-btnwidth-ZOOM(10), (CGRectGetHeight(bgImg.frame)-btnwidth)/2, btnwidth, btnwidth);
        [_canclebtn setImage:[UIImage imageNamed:@"qiandao_icon_close"] forState:UIControlStateNormal];

        [_backview addSubview:_canclebtn];
    }
    else{
        
        titlelabel.text = @"补签卡";
        
        [self creatbuqianka:bgImg];
    }
    
    [_Popview addSubview:_InvitationCodeView];
    
    [self.view addSubview:_Popview];
    
    
    _InvitationCodeView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    _InvitationCodeView.alpha = 0.5;
    
    _Popview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _Popview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        
        _InvitationCodeView.transform = CGAffineTransformMakeScale(1, 1);
        _InvitationCodeView.alpha = 1;
        
    } completion:^(BOOL finish) {
        
    }];
    
}

#pragma mark 夺宝弹框
- (void)creatDuobao:(UIView*)headview Value:(NSString*)valuestr
{
   
    //任务分类图片
    
    CGFloat headimageW = ZOOM6(200);
    CGFloat headimageH = ZOOM6(200);
    
    CGFloat ORXX = (headview.frame.size.width/2-headimageW)/2;
    CGFloat headSpace = CGRectGetWidth(_InvitationCodeView.frame) - 2*ORXX - 2*headimageW;
    
    CGFloat gobtnYY = 0.0;
    for(int j =0;j<2;j++)
    {
        UIImageView *headimage = [[UIImageView alloc]initWithFrame:CGRectMake(ORXX+(headimageW+headSpace)*j, CGRectGetMaxY(headview.frame)+ZOOM6(50), headimageW, headimageH)];
        
        UILabel *discriptionlab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(headimage.frame), CGRectGetMaxY(headimage.frame)+ZOOM6(14), CGRectGetWidth(headimage.frame), ZOOM6(24))];
        discriptionlab.textColor = RGBCOLOR_I(125, 125, 125);
        discriptionlab.font = [UIFont systemFontOfSize:ZOOM6(24)];
        discriptionlab.textAlignment = NSTextAlignmentCenter;
        
        if(j==0)
        {
            
            if (valuestr.intValue ==3)
            {
                headimage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",@"qiandao_3yuan iPhone6"]];
                discriptionlab.text = @"赢取iPhone6";
            }
            else{
                headimage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",@"qiandao_5yuan-mac"]];
                
                discriptionlab.text = @"赢取MacBook Air";
            }
            
        }else{
            
            headimage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",valuestr,@"yuanbaoyou_pop-up"]];
            discriptionlab.text = [NSString stringWithFormat:@"%@元包邮",valuestr];
        }
        
        [_backview addSubview:headimage];
        [_backview addSubview:discriptionlab];
        
        gobtnYY = CGRectGetMaxY(discriptionlab.frame);
        
       
    }
    
    
    //去抢购、去夺宝按钮
    CGFloat gobtnWidth = (CGRectGetWidth(_InvitationCodeView.frame)-2*20-20)/2;
    CGFloat gobtnHeigh = ZOOM(36*3.4);
    
    for(int k =0;k<2;k++)
    {
        UIButton *gobtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        gobtn.frame = CGRectMake(20+(gobtnWidth+20)*k, gobtnYY+ZOOM6(60), gobtnWidth, gobtnHeigh);
        gobtn.backgroundColor = tarbarrossred;
        gobtn.clipsToBounds = YES;
        gobtn.layer.cornerRadius = 5;
        [gobtn setTintColor:[UIColor whiteColor]];
        
        if(k==0)
        {
            [gobtn setTitle:@"去夺宝" forState:UIControlStateNormal];
            
        }else if (k==1)
        {
            [gobtn setTitle:@"去抢购" forState:UIControlStateNormal];
        }
        
        gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(51)];
        [gobtn addTarget:self action:@selector(goIndiana:) forControlEvents:UIControlEventTouchUpInside];
        [_backview addSubview:gobtn];
    }
    
}

#pragma mark 补签卡弹框
- (void)creatbuqianka:(UIView*)headview
{
    //get-head
    CGFloat headimageW = IMGSIZEW(@"get-head");;
    CGFloat headimageH = IMGSIZEH(@"get-head");
    
    UIImageView *headimage = [[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(_InvitationCodeView.frame)-headimageW)/2, CGRectGetMaxY(headview.frame)+ZOOM(30*3.4), headimageW, headimageH)];
    headimage.image = [UIImage imageNamed:@"get-head"];
    [_backview addSubview:headimage];
    
    UILabel *titlelab1 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(headimage.frame)+15, CGRectGetWidth(_InvitationCodeView.frame)-40, ZOOM(25*3.4))];
    titlelab1.textColor = tarbarrossred;
    titlelab1.textAlignment = NSTextAlignmentCenter;
    titlelab1.font = [UIFont systemFontOfSize:ZOOM(51)];
    
    UILabel *titlelab2 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(titlelab1.frame), CGRectGetWidth(_InvitationCodeView.frame)-40, ZOOM(40*3.4))];
    titlelab2.textColor = tarbarrossred;
    titlelab2.textAlignment = NSTextAlignmentCenter;
    titlelab2.font = [UIFont systemFontOfSize:ZOOM(40)];
    titlelab2.textColor = kTextColor;
    titlelab2.numberOfLines = 0;
    
    //按钮
    
    CGFloat gobtnWidth = (CGRectGetWidth(_InvitationCodeView.frame)-2*30-20)/2;
    CGFloat gobtnHeigh = ZOOM(36*3.4);
    
    for(int k =0;k<2;k++)
    {
        UIButton *gobtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        gobtn.frame = CGRectMake(30+(gobtnWidth+20)*k, CGRectGetMaxY(titlelab2.frame)+ZOOM(15*3.4), gobtnWidth, gobtnHeigh);
        gobtn.backgroundColor = tarbarrossred;
        gobtn.clipsToBounds = YES;
        gobtn.tag = 8888+k;
        gobtn.layer.cornerRadius = 5;
        [gobtn setTintColor:[UIColor whiteColor]];
        
        if(k==0)
        {
            [gobtn setTitle:@"去收集" forState:UIControlStateNormal];
            
        }else if (k==1)
        {
            [gobtn setTitle:@"去使用" forState:UIControlStateNormal];
        }
        
        gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(51)];
        [gobtn addTarget:self action:@selector(goClick:) forControlEvents:UIControlEventTouchUpInside];
        [_backview addSubview:gobtn];
    }
    
    UIButton *button = (UIButton*)[_InvitationCodeView viewWithTag:8889];
    if(_isBuqianka == NO)//没有补签卡
    {
        titlelab1.text = @"你现在没有补签卡哦~";
        titlelab2.text = @"邀请好友下载注册衣蝠APP或购买您分享的美衣即可获得补签卡";
        
        button.enabled = YES;
        button.backgroundColor = kTextColor;
        
    }else if (_isBuqianka == YES)//有补签卡
    {
        
        if(_cornerlab.text.intValue >0)
        {
            _cornerlab.hidden = NO;
            titlelab1.text = [NSString stringWithFormat:@"您已收集到%@张补签卡哦~",_cornerlab.text];
        }
        titlelab2.text = @"邀请好友下载注册衣蝠APP或购买您分享的美衣即可获得补签卡";
        
        if(_signIn_status.intValue == 0 || _signIn_status.intValue == 1)
        {
            
            button.enabled = YES;
            button.backgroundColor = kTextColor;
            
        }
        else if(_signIn_status.intValue == 2)
        {
            
            button.enabled = YES;
            button.backgroundColor = tarbarrossred;
        
        }
       
        
    }
    
    [_backview addSubview:titlelab1];
    [_backview addSubview:titlelab2];
    
    
}


#pragma mark ******** 弹框点击事件 **********
- (void)goClick:(UIButton*)sender
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *realm = [user objectForKey:USER_REALM];
    
    if(sender.tag == 8889)
    {
       
        NSString *title = sender.titleLabel.text;
        
        if ([title isEqualToString:@"去小店"])
        {
            
             Mtarbar.selectedIndex=0;
        
        }else if ([title isEqualToString:@"去查看"])
        {
            NSString *todaystatue = [self signImagestatue:_selectSigntag];
            
            if(todaystatue.intValue == 7)
            {
                TFIndianaRecordViewController *tiVC = [[TFIndianaRecordViewController alloc] init];
                tiVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:tiVC animated:YES];
                
            }else{
                
                MyLog(@"钱包");
                TFMyWalletViewController *wallet = [[TFMyWalletViewController alloc]init];
                wallet.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:wallet animated:YES];
            }
            
        }else if ([title isEqualToString:@"赚积分"])
        {
            NewSigninViewController *newSign = [[NewSigninViewController alloc]init];
            newSign.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:newSign animated:YES];

        }
        else if ([title isEqualToString:@"查看余额"])
        {
            MyLog(@"钱包");
            TFMyWalletViewController *wallet = [[TFMyWalletViewController alloc]init];
            wallet.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:wallet animated:YES];

        }else if ([title isEqualToString:@"查看积分"])
        {
        
            HYJIntelgralDetalViewController *vc = [[HYJIntelgralDetalViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.index = 0;
            [self.navigationController pushViewController:vc animated:YES];
            
       
        }else if ([title isEqualToString:@"查看卡券"])
        {
       
            TFMyCardViewController *tmvc = [[TFMyCardViewController alloc] init];
            tmvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:tmvc animated:YES];
        
        }
        
        [self SharetapClick];
        
    }else if (sender.tag == 8888)
    {
        
        NSString *title = sender.titleLabel.text;
        
        
        if ([title isEqualToString:@"查余额"])
        {
            MyLog(@"钱包");
            TFMyWalletViewController *wallet = [[TFMyWalletViewController alloc]init];
            wallet.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:wallet animated:YES];

        }
        else if ([title isEqualToString:@"开启特权"])
        {

           [self doubleSuccessEntrance:1];

        }else if([title isEqualToString:@"知道了"])
        {
            
        }


    }
    
    
    [self SharetapClick];
}


- (void)goIndiana:(UIButton*)sender
{
    NSMutableString *shopcodeStr = [NSMutableString stringWithFormat:@"%@",_motaskDataArray[_selectSigntag][@"value"]];
    
    NSArray *shopcodeArr = [shopcodeStr componentsSeparatedByString:@","];
    
    
    if([sender.titleLabel.text isEqualToString:@"去抢购"])//包邮
    {
        [self tapClick];
        
        _selectshop_type = @"包邮";
        
        NSString *shop_code = shopcodeArr[0];
        NSString *duobao_shop_code = shopcodeArr[1];
        
        ComboShopDetailViewController *detail=[[ComboShopDetailViewController alloc] initWithNibName:@"ComboShopDetailViewController" bundle:nil];
        detail.detailType = @"签到包邮";
        detail.shop_code = shop_code;
        detail.duobao_shop_code = duobao_shop_code;
        detail.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:detail animated:YES];
        
    }else{//夺宝
        
        [self tapClick];
        _selectshop_type = @"夺宝";
        
        NSString *shop_code = shopcodeArr[1];
        NSString *baoyou_shop_code = shopcodeArr[0];
        
        IndianaDetailViewController *shopdetail=[[IndianaDetailViewController alloc]init];
        shopdetail.shop_code= shop_code;
        shopdetail.baoyou_shop_code = baoyou_shop_code;
        shopdetail.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:shopdetail animated:YES];
    }
}

-(void)tapClick
{
    [_canclebtn removeFromSuperview];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _Popview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
        _InvitationCodeView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        _InvitationCodeView.alpha = 0;
        
    } completion:^(BOOL finish) {
        
        [_Popview removeFromSuperview];
        _Popview = nil;
    }];
    
    
}

#pragma mark ***********分享弹框***********
#pragma mark 分享前文字提示弹框
- (void)beginShareTitlePopView
{
    NSString *todaystatue = [self signImagestatue:_selectSigntag];
    
    _SharePopview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    
    _SharePopview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _SharePopview.userInteractionEnabled = YES;
    
    CGFloat invitcodeYY = (kScreenHeight - ZOOM6(580))/2;
    
    UITapGestureRecognizer *dismistap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissclick:)];
    [_SharePopview addGestureRecognizer:dismistap];
    
    
    //弹框内容
    _ShareInvitationCodeView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(120), invitcodeYY, kScreenWidth-ZOOM(120)*2, ZOOM6(580))];
    [_SharePopview addSubview:_ShareInvitationCodeView];
    
    CGFloat imgHeigh = IMGSIZEH(@"congratulation");
    
    _SharebackView = [[UIView alloc]initWithFrame:CGRectMake(0,imgHeigh/2, kScreenWidth-ZOOM(120)*2, CGRectGetHeight(_ShareInvitationCodeView.frame)-imgHeigh/2)];
    _SharebackView.backgroundColor=[UIColor whiteColor];
    _SharebackView.layer.cornerRadius=5;
    _SharebackView.clipsToBounds = YES;
    [_ShareInvitationCodeView addSubview:_SharebackView];
    
    //title
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_SharebackView.frame), ZOOM6(80))];
    titlelabel.text = @"分享时尚赢现金";
    if(todaystatue.intValue == 8)
    {
        titlelabel.text = @"余额翻倍特权说明";
    }
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.backgroundColor = tarbarrossred;
    titlelabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    [_SharebackView addSubview:titlelabel];

    
    //关闭按钮
    CGFloat btnwidth = IMGSIZEW(@"qiandao_icon_close");
    
    _Sharecanclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _Sharecanclebtn.frame=CGRectMake(CGRectGetWidth(_SharebackView.frame)-btnwidth-ZOOM6(20), ZOOM6(20), btnwidth, btnwidth);
    [_Sharecanclebtn setImage:[UIImage imageNamed:@"qiandao_icon_close"] forState:UIControlStateNormal];
    _Sharecanclebtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    _Sharecanclebtn.layer.cornerRadius=btnwidth/2;
    [_Sharecanclebtn addTarget:self action:@selector(SharetapClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_SharebackView addSubview:_Sharecanclebtn];

    
    int count =2;
    CGFloat discriptionlabelHeigh = ZOOM6(100);
    if(todaystatue.intValue == 8)
    {
        count = 1;
        discriptionlabelHeigh = ZOOM6(200);
    }
    for(int i =0;i<count;i++)
    {
        UILabel *discriptionlabel = [[UILabel alloc]init];
        discriptionlabel.frame = CGRectMake(ZOOM6(30), CGRectGetMaxY(titlelabel.frame)+ZOOM6(60)+discriptionlabelHeigh*i, CGRectGetWidth(_SharebackView.frame)-2*ZOOM6(30), discriptionlabelHeigh);
        discriptionlabel.numberOfLines = 0;
        discriptionlabel.textColor = RGBCOLOR_I(125, 125, 125);
        discriptionlabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
        if(i==0)
        {
            discriptionlabel.text = @"1.分享后成功注册的小伙伴将会成功你的粉丝.";
            if(todaystatue.intValue == 8)
            {
                discriptionlabel.text = @"分享成功后,您可以获得开启余额翻倍特权,余额在24小时内变成原来的2倍,可直接用于购物,24小时后余额变为原来的金额.";
            }
        }else{
            discriptionlabel.text = @"2.粉丝每次从app下单,你将可以从衣蝠得到商品价格10%的现金奖励.";
        }
        
        [_SharebackView addSubview:discriptionlabel];
    }
    
    
    UIButton *gosharebtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    gosharebtn.frame = CGRectMake(ZOOM6(30), CGRectGetHeight(_SharebackView.frame)-ZOOM6(130), CGRectGetWidth(_SharebackView.frame)-2*ZOOM6(30), ZOOM6(80));
    gosharebtn.layer.cornerRadius = 5;
    gosharebtn.backgroundColor = tarbarrossred;
    [gosharebtn setTitle:@"去分享 (完成签到任务)" forState:UIControlStateNormal];
    
    gosharebtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
    NSMutableAttributedString *noteStr ;
    if(gosharebtn.titleLabel.text)
    {
        noteStr = [[NSMutableAttributedString alloc]initWithString:gosharebtn.titleLabel.text];
    }
    
    [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:ZOOM6(32)] range:NSMakeRange(0, 3)];
    [gosharebtn.titleLabel setAttributedText:noteStr];

    
    [gosharebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [gosharebtn addTarget:self action:@selector(goshareclick:) forControlEvents:UIControlEventTouchUpInside];
    [_SharebackView addSubview:gosharebtn];
    
    [self.view addSubview:_SharePopview];
    
    _ShareInvitationCodeView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    _ShareInvitationCodeView.alpha = 0.5;
    
    _SharePopview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _SharePopview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        
        _ShareInvitationCodeView.transform = CGAffineTransformMakeScale(1, 1);
        _ShareInvitationCodeView.alpha = 1;
        
    } completion:^(BOOL finish) {
        
    }];

}

#pragma mark 分享前图片提示弹框
- (void)beginShareImagePopView
{
    _SharePopview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    
    _SharePopview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _SharePopview.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *dismistap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissclick:)];
    [_SharePopview addGestureRecognizer:dismistap];
    
    CGFloat invitcodeYY = (kScreenHeight - ZOOM6(900))/2;
    
    //弹框内容
    _ShareInvitationCodeView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(120), invitcodeYY, kScreenWidth-ZOOM(120)*2, kScreenHeight-invitcodeYY*2)];
    [_SharePopview addSubview:_ShareInvitationCodeView];
    
    
    CGFloat imgHeigh = IMGSIZEH(@"congratulation");
    
    _SharebackView = [[UIView alloc]initWithFrame:CGRectMake(0,imgHeigh/2, kScreenWidth-ZOOM(120)*2, CGRectGetHeight(_ShareInvitationCodeView.frame)-imgHeigh/2)];
    _SharebackView.layer.cornerRadius=5;
    _SharebackView.clipsToBounds = YES;
    [_ShareInvitationCodeView addSubview:_SharebackView];
    
    //1-5随机数
    int i = arc4random() % 4 ;
    
    UIImageView *imageview = [[UIImageView alloc]init];
    imageview.frame = CGRectMake(0, 0, CGRectGetWidth(_SharebackView.frame), CGRectGetHeight(_SharebackView.frame));
    imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"Daisy_%d",i]];
    [_SharebackView addSubview:imageview];
        
    //关闭按钮
    CGFloat btnwidth = IMGSIZEW(@"qiandao_icon_close");
    
    _Sharecanclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _Sharecanclebtn.frame=CGRectMake(CGRectGetWidth(_SharebackView.frame)-btnwidth-ZOOM6(60), ZOOM6(20), btnwidth, btnwidth);
    [_Sharecanclebtn setImage:[UIImage imageNamed:@"qiandao_icon_close"] forState:UIControlStateNormal];
    _Sharecanclebtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    _Sharecanclebtn.layer.cornerRadius=btnwidth/2;
    [_Sharecanclebtn addTarget:self action:@selector(SharetapClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_SharebackView addSubview:_Sharecanclebtn];

    
    [self.view addSubview:_SharePopview];
    
    
    UIButton *gosharebtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    gosharebtn.frame = CGRectMake(ZOOM6(50), CGRectGetHeight(_SharebackView.frame)-ZOOM6(100), CGRectGetWidth(_SharebackView.frame)-2*ZOOM6(50), ZOOM6(80));
    gosharebtn.layer.cornerRadius = 5;
    gosharebtn.backgroundColor = tarbarrossred;
    [gosharebtn setTitle:@"去分享 (完成签到任务)" forState:UIControlStateNormal];
    
    gosharebtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
    NSMutableAttributedString *noteStr ;
    if(gosharebtn.titleLabel.text)
    {
        noteStr = [[NSMutableAttributedString alloc]initWithString:gosharebtn.titleLabel.text];
    }
    
    [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:ZOOM6(32)] range:NSMakeRange(0, 3)];
    [gosharebtn.titleLabel setAttributedText:noteStr];

    
    [gosharebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [gosharebtn addTarget:self action:@selector(goshareclick:) forControlEvents:UIControlEventTouchUpInside];
    [_SharebackView addSubview:gosharebtn];

    
    _ShareInvitationCodeView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    _ShareInvitationCodeView.alpha = 0.5;
    
    _SharePopview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _SharePopview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        
        _ShareInvitationCodeView.transform = CGAffineTransformMakeScale(1, 1);
        _ShareInvitationCodeView.alpha = 1;
        
    } completion:^(BOOL finish) {
        
    }];
    
}

#pragma mark 分享前弹框点击事件
- (void)goshareclick:(UIButton*)sender
{
    [self SharetapClick];
    
    NSString *todaystatue = [self signImagestatue:_selectSigntag];
    [self gotoshareType:todaystatue Tag:0];
}

#pragma mark 分享前选择分享平台弹框
- (void)creatShareModelView:(NSString*)myType Image:(UIImage*)newimg
{
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight)];
    backview.tag=9797;

    
    UITapGestureRecognizer *viewtap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disapperview:)];
    [backview addGestureRecognizer:viewtap];
    backview.userInteractionEnabled = YES;
    
    [self.view addSubview:backview];
    
    _shareModelview = [[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight+30, kApplicationWidth, SHAREMODELHEIGH)];
    _shareModelview.backgroundColor=[UIColor whiteColor];
    
    if(backview)
    {
        [self.view addSubview:_shareModelview];
        [_shareModelview bringSubviewToFront:self.view];
        
        
        UITapGestureRecognizer *shareviewtap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disapperview:)];
        [_shareModelview addGestureRecognizer:shareviewtap];
        _shareModelview.userInteractionEnabled = YES;
    }
    
    
    UILabel *titlelable = [[UILabel alloc]initWithFrame:CGRectMake(10, ZOOM(40), kApplicationWidth-20, ZOOM6(120))];
    titlelable.text = @"分享我们精心挑选的美衣给好友，让好友得到美丽与实惠，您更有10%现金奖励哦！";
    titlelable.textAlignment = NSTextAlignmentCenter;
    titlelable.font = [UIFont systemFontOfSize:ZOOM(51)];
    titlelable.textColor = kTitleColor;
    titlelable.numberOfLines = 0;
    [_shareModelview addSubview:titlelable];
    
    CGFloat titlelable1Y = CGRectGetMaxY(titlelable.frame);
    
    UILabel *titlelable1 = [[UILabel alloc]initWithFrame:CGRectMake(10, titlelable1Y+ZOOM(30), kApplicationWidth-20, 40)];
    NSString *rewardstr = [self getshareReward:myType];
    titlelable1.text = [NSString stringWithFormat:@"分享美衣完成签到,即可领取%@喔~",rewardstr];
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(51)]};
    CGSize textSize = [titlelable1.text boundingRectWithSize:CGSizeMake(kApplicationWidth-40, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    
    CGSize cSize = [[UIScreen mainScreen] bounds].size;
    
    titlelable1.frame=CGRectMake((cSize.width-textSize.width-20)/2, titlelable1Y+ZOOM(20), textSize.width+20, textSize.height+10);
    if(textSize.width > cSize.width)
    {
        titlelable1.frame=CGRectMake(10, titlelable1Y, kApplicationWidth-20, textSize.height+ZOOM(25*3.4));
    }
    
    titlelable1.textAlignment = NSTextAlignmentCenter;
    titlelable1.numberOfLines = 0;
    titlelable1.font = [UIFont systemFontOfSize:ZOOM(51)];
    titlelable1.textColor = [UIColor whiteColor];
    titlelable1.backgroundColor=tarbarrossred;
    titlelable1.clipsToBounds=YES;
    titlelable1.layer.cornerRadius=titlelable1.frame.size.height/2;
    
//    [_shareModelview addSubview:titlelable1];
    
    
    CGFloat lablelineY =CGRectGetMaxY(titlelable.frame);
    
    UILabel *lableline = [[UILabel alloc]initWithFrame:CGRectMake(0, lablelineY+ZOOM(50), kApplicationWidth, 1)];
    lableline.backgroundColor = kBackgroundColor;
    
    [_shareModelview addSubview:lableline];
    
    
    //分享平台
    for (int i=0; i<2; i++) {
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        shareBtn.frame = CGRectMake(100*i+(kApplicationWidth-160)/2,CGRectGetMaxY(lableline.frame)+ZOOM(50), 60, 60);
        shareBtn.tag = 9000+i;
        shareBtn.tintColor = [UIColor clearColor];
        [shareBtn setTitle:myType forState:UIControlStateNormal];
        [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            
            //判断设备是否安装微信
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
                
                //判断是否有微信
                
                [shareBtn setBackgroundImage:[UIImage imageNamed:@"朋友圈-1"] forState:UIControlStateNormal];
                
            }else {
                
                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
                
            }
            
        }else if (i==1){
            
            //判断设备是否安装QQ
            
            if ([QQApi isQQInstalled])
            {
                //判断是否有qq
                [shareBtn setBackgroundImage:[UIImage imageNamed:@"qq空间-1"] forState:UIControlStateNormal];
            }else{
                
                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
            }

        }
        
        [_shareModelview addSubview:shareBtn];
        
    }
    
    backview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];

    [UIView animateWithDuration:0.5 animations:^{
        
        backview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        _shareModelview.frame=CGRectMake(0, kApplicationHeight-SHAREMODELHEIGH+kUnderStatusBarStartY,   kApplicationWidth, SHAREMODELHEIGH);
        
    } completion:^(BOOL finished) {
        
        
    }];

}

#pragma mark 分享前提示将获取的奖励
- (NSString*)getshareReward:(NSString*)type
{
    NSString *value = [self signtypestatue:_selectSigntag];
    MyLog(@"value = %@",value);
    
    NSString *rewardstr;
    
    if([type isEqualToString:DAILY_TASK_BUQIAN])//补签
    {
       rewardstr = @"补签卡1张";
        
    }else if ([type isEqualToString:DAILY_TASK_ZERO])//0元购
    {
        rewardstr = @"一次0元购免积分购买机会";
    }else if ([type isEqualToString:DAILY_TASK_XIANJING])//现金
    {
        rewardstr = [NSString stringWithFormat:@"%@元现金",value];
        
    }else if ([type isEqualToString:DAILY_TASK_YOUHUI])//优惠
    {
        rewardstr = [NSString stringWithFormat:@"%@元优惠券",value];
    }else if ([type isEqualToString:DAILY_TASK_JIFEN])//积分
    {
        rewardstr = [NSString stringWithFormat:@"%@积分",value];
    }
   
    return rewardstr;

}


- (void)goshare
{
    
    //配置分享平台信息
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app shardk];
    
    DShareManager *ds = [DShareManager share];
    ds.delegate = self;
    
    if(_isWeixin_share == YES)//微信分享
    {
        [ds shareAppWithType:ShareTypeWeixiTimeline withImageShareType:_shareType withImage:_shareImage];
        
    }else{//QQ分享
        
        [ds shareAppWithType:ShareTypeQQSpace withImageShareType:_shareType withImage:_shareImage];
    }
    
}


#pragma mark ***********完成任务后的弹框(旧的)***********
-(void)creatSharePopView:(NSString*)str
{
    
    _SharePopview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    
    _SharePopview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _SharePopview.userInteractionEnabled = YES;
    UITapGestureRecognizer *dismistap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissclick:)];
    [_SharePopview addGestureRecognizer:dismistap];
    

    CGFloat spaceHeigh = 0;
    CGFloat invitcodeYY = ZOOM(420);
    if([str isEqualToString:DAILY_TASK_XIANJING])
    {
        spaceHeigh = ZOOM(50*3.4);
        invitcodeYY = ZOOM(420) - spaceHeigh/2;
    }else if ([str isEqualToString:DAILY_TASK_DOUBLE])
    {
        spaceHeigh = ZOOM6(60);
        invitcodeYY = ZOOM(420) - spaceHeigh/2;

    }
    else if ([str isEqualToString:DAILY_TASK_STORE])
    {
        invitcodeYY = (kScreenHeight - ZOOM6(880))/2;
    }
    
    //弹框内容
    _ShareInvitationCodeView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(120), invitcodeYY, kScreenWidth-ZOOM(120)*2, kScreenHeight-invitcodeYY*2)];
    [_SharePopview addSubview:_ShareInvitationCodeView];
    
    
    //关闭按钮
    CGFloat btnwidth = IMGSIZEW(@"icon_close1");
    
    _Sharecanclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _Sharecanclebtn.frame=CGRectMake(CGRectGetWidth(_ShareInvitationCodeView.frame)-btnwidth, 0, btnwidth, btnwidth);
    [_Sharecanclebtn setImage:[UIImage imageNamed:@"icon_close1"] forState:UIControlStateNormal];
    _Sharecanclebtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    _Sharecanclebtn.layer.cornerRadius=btnwidth/2;
    [_Sharecanclebtn addTarget:self action:@selector(SharetapClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    CGFloat imgHeigh = IMGSIZEH(@"congratulation");
    
    if(![str isEqualToString:DAILY_TASK_DUOBAO])
    {
        _SharebackView = [[UIView alloc]initWithFrame:CGRectMake(0,imgHeigh/2, kScreenWidth-ZOOM(120)*2, CGRectGetHeight(_ShareInvitationCodeView.frame)-imgHeigh/2)];
        _SharebackView.backgroundColor=[UIColor whiteColor];
        _SharebackView.layer.cornerRadius=5;
        _SharebackView.clipsToBounds = YES;
        [_ShareInvitationCodeView addSubview:_SharebackView];
        
        _SharetitleImg = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM(120), 0, CGRectGetWidth(_ShareInvitationCodeView.frame)-2*ZOOM(120), imgHeigh)];
        _SharetitleImg.image = [UIImage imageNamed:@"-congratulation"];
        [_ShareInvitationCodeView addSubview:_SharetitleImg];
        
    }else{
        
        _SharebackView = [[UIView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth-ZOOM(120)*2, CGRectGetHeight(_ShareInvitationCodeView.frame)-imgHeigh/2)];
        _SharebackView.backgroundColor=[UIColor whiteColor];
        _SharebackView.layer.cornerRadius=5;
        _SharebackView.clipsToBounds = YES;
        [_ShareInvitationCodeView addSubview:_SharebackView];
        
        UIImageView *bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _ShareInvitationCodeView.frame.size.width, _ShareInvitationCodeView.frame.size.height/8)];
        bgImg.backgroundColor=tarbarrossred;
        [_SharebackView addSubview:bgImg];
        
        UILabel *titlelable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_ShareInvitationCodeView.frame), _ShareInvitationCodeView.frame.size.height/8)];
        titlelable.textColor = [UIColor whiteColor];
        titlelable.font = [UIFont systemFontOfSize:ZOOM(70)];
        titlelable.textAlignment = NSTextAlignmentCenter;
        NSString *value = [self signtypestatue:_selectSigntag];
        titlelable.text = [NSString stringWithFormat:@"%@元夺宝",value];
        [_SharebackView addSubview:titlelable];
        
    }
    //弹框内容
    [self creatshare:str];
    
    [self.view addSubview:_SharePopview];

    _ShareInvitationCodeView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    _ShareInvitationCodeView.alpha = 0.5;
    
    _SharePopview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _SharePopview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        
        _ShareInvitationCodeView.transform = CGAffineTransformMakeScale(1, 1);
        _ShareInvitationCodeView.alpha = 1;
        
    } completion:^(BOOL finish) {
        
    }];
    
}

- (void)creatshare:(NSString*)typestr
{
    
    CGFloat headimageW = IMGSIZEW(@"qiandao_3yuan");;
    CGFloat headimageH = IMGSIZEH(@"qiandao_3yuan");
    CGFloat headimageY = ZOOM(30*3.4);
    if([typestr isEqualToString:DAILY_TASK_DUOBAO])
    {
        headimageY = ZOOM(50*3.4);
    }
    
    CGFloat titlelagHeigh = 20;
    if([typestr isEqualToString:DAILY_TASK_STORE])
    {
        titlelagHeigh = 0;
        headimageY = ZOOM6(60);
    }

    
    UIImageView *headimage = [[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(_SharebackView.frame)-headimageW)/2, headimageY, headimageW, headimageH)];
    headimage.image = [UIImage imageNamed:@"get-head"];
    [_SharebackView addSubview:headimage];
    
    
    UILabel *titlelab1 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(headimage.frame)+titlelagHeigh, CGRectGetWidth(_SharebackView.frame)-40, ZOOM(20*3.4))];
    titlelab1.textColor = tarbarrossred;
    titlelab1.textAlignment = NSTextAlignmentCenter;
    titlelab1.font = [UIFont systemFontOfSize:ZOOM(51)];
    
    UILabel *titlelab2 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(titlelab1.frame), CGRectGetWidth(_SharebackView.frame)-40, ZOOM(40*3.4))];
    titlelab2.textColor = tarbarrossred;
    titlelab2.textAlignment = NSTextAlignmentCenter;
    
    if([typestr isEqualToString:DAILY_TASK_DOUBLE])
    {
        titlelab2.font = [UIFont systemFontOfSize:ZOOM6(24)];
    }else{
        titlelab2.font = [UIFont systemFontOfSize:ZOOM6(24)];
    }
    titlelab2.textColor = kTextColor;
    titlelab2.numberOfLines = 0;
    
    //按钮
    CGFloat gobtnWidth = (CGRectGetWidth(_SharebackView.frame)-2*30-20)/2;
    CGFloat gobtnHeigh = ZOOM(36*3.4);
    
    
    
    CGFloat spaceHeigh = 0;
    if([typestr isEqualToString:DAILY_TASK_XIANJING])
    {
        spaceHeigh = ZOOM(50*3.4);
        
        UIImageView * markimageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(titlelab2.frame)+ZOOM(10*3.4), CGRectGetWidth(_SharebackView.frame)-2*30, ZOOM(40*3.4))];
        markimageView.image = [UIImage imageNamed:@"现金111"];
        
        UILabel *marklable = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(5*3.4), ZOOM(5*3.4), CGRectGetWidth(markimageView.frame) - ZOOM(10*3.4), ZOOM(30*3.4))];
        marklable.text = @"坚持分享美衣,好友购买再得10%现金奖励,轻松月赚千元零花钱哦~";
        marklable.numberOfLines = 0;
        marklable.textColor = RGBCOLOR_I(252, 137, 184);
        marklable.font = [UIFont systemFontOfSize:ZOOM(11*3.4)];
        
        [markimageView addSubview:marklable];
        [_SharebackView addSubview:markimageView];
    }

    for(int k =0;k<2;k++)
    {
        UIButton *gobtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        gobtn.frame = CGRectMake(30+(gobtnWidth+20)*k, CGRectGetMaxY(titlelab2.frame)+ZOOM6(20) +spaceHeigh, gobtnWidth, gobtnHeigh);
        gobtn.backgroundColor = tarbarrossred;
        gobtn.clipsToBounds = YES;
        gobtn.tag = 8888+k;
        gobtn.layer.cornerRadius = 5;
        [gobtn setTintColor:[UIColor whiteColor]];
        
    
        [self buttontitle:typestr button:gobtn Image:headimage Lab1:titlelab1 Lab2:titlelab2];
        
        gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(51)];
        [gobtn addTarget:self action:@selector(goClick:) forControlEvents:UIControlEventTouchUpInside];
        [_SharebackView addSubview:gobtn];
    }
    
    
    [_SharebackView addSubview:titlelab1];
    [_SharebackView addSubview:titlelab2];
    
    
}

- (void)buttontitle:(NSString*)type button:(UIButton*)mybtn Image:(UIImageView*)headimage Lab1:(UILabel*)lab1 Lab2:(UILabel*)lab2
{
    
    NSString *value = [self signtypestatue:_selectSigntag];
    MyLog(@"value = %@",value);
    mybtn.hidden = NO;
    
    if ([type isEqualToString:DAILY_TASK_ZERO])//0元购
    {
        if(mybtn.tag == 8888)
        {
            [mybtn setTitle:@"去抢购" forState:UIControlStateNormal];
        }else{
            [mybtn setTitle:@"知道了" forState:UIControlStateNormal];
            mybtn.backgroundColor = [UIColor clearColor];
            mybtn.tintColor = tarbarrossred;
            mybtn.layer.borderColor = tarbarrossred.CGColor;
            mybtn.layer.borderWidth=1;
            
        }

        headimage.image = [UIImage imageNamed:@"0yuangou"];
        lab1.text = @"分享成功";
        lab2.text = [NSString stringWithFormat:@"%@",@"您已获得免费0元疯抢机会\n赶紧去抢购吧~"];
    }else if ([type isEqualToString:DAILY_TASK_XIANJING])//现金
    {
        if(mybtn.tag == 8888)
        {
            [mybtn setTitle:@"去查看" forState:UIControlStateNormal];
        }else{
            [mybtn setTitle:@"知道了" forState:UIControlStateNormal];
            mybtn.backgroundColor = [UIColor clearColor];
            mybtn.tintColor = tarbarrossred;
            mybtn.layer.borderColor = tarbarrossred.CGColor;
            mybtn.layer.borderWidth=1;
        }
        
        if(value.intValue == 1)
        {
            headimage.image = [UIImage imageNamed:@"get-1-money"];
        }else if (value.intValue == 2)
        {
            headimage.image = [UIImage imageNamed:@"qiandao_2yuan"];
        }else if (value.intValue == 5)
        {
            headimage.image = [UIImage imageNamed:@"qiandao_5yuan"];
            
        }else if (value.intValue == 3)
        {
            headimage.image = [UIImage imageNamed:@"qiandao_3yuan"];
        }
        
        lab1.text = @"分享成功";
        lab2.text = [NSString stringWithFormat:@"%@元现金已存入您的余额\n可以提现喔~",value];
        
    
    }else if ([type isEqualToString:DAILY_TASK_YOUHUI])//优惠
    {
        if(mybtn.tag == 8888)
        {
            [mybtn setTitle:@"去购物" forState:UIControlStateNormal];
        }else{
            [mybtn setTitle:@"知道了" forState:UIControlStateNormal];
            mybtn.backgroundColor = [UIColor clearColor];
            mybtn.tintColor = tarbarrossred;
            mybtn.layer.borderColor = tarbarrossred.CGColor;
            mybtn.layer.borderWidth=1;
        }

        if(value.intValue == 5)
        {
            headimage.image = [UIImage imageNamed:@"qiandao_5yuan-youhuiquan"];
        }else if (value.intValue == 10)
        {
            headimage.image = [UIImage imageNamed:@"10youhuiq"];
        }else if (value.intValue == 20)
        {
            headimage.image = [UIImage imageNamed:@"20youhuiq"];
        }

        lab1.text = @"分享成功";
        lab2.text = [NSString stringWithFormat:@"%@元优惠券已发放至您的卡券\n赶紧去逛逛吧",value];

    }else if ([type isEqualToString:DAILY_TASK_JIFEN])//积分
    {
        if(mybtn.tag == 8888)
        {
            [mybtn setTitle:@"赚积分" forState:UIControlStateNormal];
        }else{
            [mybtn setTitle:@"知道了" forState:UIControlStateNormal];
            mybtn.backgroundColor = [UIColor clearColor];
            mybtn.tintColor = tarbarrossred;
            mybtn.layer.borderColor = tarbarrossred.CGColor;
            mybtn.layer.borderWidth=1;
        }

        headimage.image = [UIImage imageNamed:@"qiandao_jifen"];
        lab1.text = @"分享成功";
        lab2.text = [NSString stringWithFormat:@"您已成功增加%@积分,现在去赚更多积分吧",value];
    }else if ([type isEqualToString:DAILY_TASK_STORE])//开店
    {
        if(mybtn.tag == 8889)
        {
            [mybtn setTitle:@"去小店" forState:UIControlStateNormal];
        }else{
            [mybtn setTitle:@"查余额" forState:UIControlStateNormal];
            mybtn.backgroundColor = [UIColor clearColor];
            mybtn.tintColor = tarbarrossred;
            mybtn.layer.borderColor = tarbarrossred.CGColor;
            mybtn.layer.borderWidth=1;
        }

        headimage.image = [UIImage imageNamed:@"qiandao_3yuan"];
        lab1.text = @"开店成功";
        if(_Myvalue !=nil)
        {
            value = _Myvalue;
        }
        lab2.text = [NSString stringWithFormat:@"%@元现金已存入您的余额,明天衣蝠会教你怎么赚钱啦!记得来签到哦~",value];
        
        [self creatDoubleView];
        
        //余额翻倍倍数
        [DataManager sharedManager].twofoldness = [value integerValue];
        
    }else if ([type isEqualToString:DAILY_TASK_BAOYOU])
    {
        
        if(mybtn.tag == 8888)
        {
            [mybtn setTitle:@"知道了" forState:UIControlStateNormal];
            mybtn.frame = CGRectMake(30, CGRectGetMaxY(lab2.frame)+ZOOM(20*3.4), CGRectGetWidth(_SharebackView.frame)-2*30, ZOOM(35*3.4));
            
        }else{
            [mybtn setTitle:@"知道了" forState:UIControlStateNormal];
            
            mybtn.hidden = YES;
            
        }
        
        if(value.intValue == 1)
        {
            lab1.text = @"购买成功";
            lab2.text = [NSString stringWithFormat:@"%@",@"恭喜你成功抓住1元撕快递的机会~"];
        }else{
            lab1.text = @"抢购成功";
            lab2.text = [NSString stringWithFormat:@"%@",@"敬请期待明日的惊喜~"];
        }
        
        switch (value.intValue) {
            case 1:
                headimage.image = [UIImage imageNamed:@"1yuanbaoyou"];
                break;
            case 2:
                headimage.image = [UIImage imageNamed:@"2yuanbaoyou"];
                break;
            case 3:
                headimage.image = [UIImage imageNamed:@"3yuanbaoyou"];
                break;
            case 5:
                headimage.image = [UIImage imageNamed:@"5yuanbaoyou"];
                break;
            default:
                break;
        }
    }
    else if ([type isEqualToString:DAILY_TASK_DUOBAO])
    {
        if(mybtn.tag == 8888)
        {
            [mybtn setTitle:@"去查看" forState:UIControlStateNormal];
        }else{
            [mybtn setTitle:@"知道了" forState:UIControlStateNormal];
            mybtn.backgroundColor = [UIColor clearColor];
            mybtn.tintColor = tarbarrossred;
            mybtn.layer.borderColor = tarbarrossred.CGColor;
            mybtn.layer.borderWidth=1;
        }
        
        lab1.text = @"你已参与成功";
       
        lab2.text = [NSString stringWithFormat:@"你的参与号码为:%@\n请等待系统为你揭晓~",self.in_code];
    }
    else if ([type isEqualToString:DAILY_TASK_DOUBLE])
    {
       
        headimage.image = [UIImage imageNamed:@"qiandao_2yuan"];
        
        lab1.text = @"分享成功";
        lab2.text = [NSString stringWithFormat:@"您已获得余额翻倍特权,24小时内您的余额会成为原来的%@倍,可直接用于购物,24小时之后余额会变为原来的金额",value];
        lab2.textAlignment = NSTextAlignmentLeft;
        
        if(mybtn.tag == 8888)
        {
            [mybtn setTitle:@"狠心放弃" forState:UIControlStateNormal];
            mybtn.backgroundColor = [UIColor clearColor];
            mybtn.tintColor = tarbarrossred;
            mybtn.layer.borderColor = tarbarrossred.CGColor;
            mybtn.layer.borderWidth=1;
            mybtn.userInteractionEnabled = NO;
        
        }else{
            [mybtn setTitle:@"开启特权" forState:UIControlStateNormal];
        }

        UIImageView *baseImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_ShareInvitationCodeView.frame)-ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame), ZOOM6(60))];
        baseImg.image = [UIImage imageNamed:@"bg"];
        [_ShareInvitationCodeView addSubview:baseImg];
        
        _timelable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(baseImg.frame), CGRectGetHeight(baseImg.frame))];
        _timelable.text = @" ";
        _timelable.textAlignment = NSTextAlignmentCenter;
        _timelable.textColor = [UIColor whiteColor];
        _timelable.font = [UIFont systemFontOfSize:ZOOM6(24)];
        [baseImg addSubview:_timelable];
        
        //余额翻倍倍数
        [DataManager sharedManager].twofoldness = [value integerValue];
    }
    
}

#pragma mark **************完成任务后新的弹框*****************
- (void)creatFinishPopview:(NSString*)type
{
    _SharePopview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    
    _SharePopview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _SharePopview.userInteractionEnabled = YES;
    
    CGFloat invitcodeYY = (kScreenHeight - ZOOM6(700))/2;
    CGFloat ShareInvitationCodeViewHeigh = ZOOM6(700);
    
    if([type isEqualToString:DAILY_TASK_DUOBAO])
    {
        invitcodeYY = (kScreenHeight - ZOOM6(780))/2;
        ShareInvitationCodeViewHeigh = ZOOM6(780);
    }
    
    UITapGestureRecognizer *dismistap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissclick:)];
    [_SharePopview addGestureRecognizer:dismistap];
    
    
    //弹框内容
    _ShareInvitationCodeView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(120), invitcodeYY, kScreenWidth-ZOOM(120)*2, ShareInvitationCodeViewHeigh)];
    [_SharePopview addSubview:_ShareInvitationCodeView];
    
    CGFloat imgHeigh = IMGSIZEH(@"congratulation");
    
    _SharebackView = [[UIView alloc]initWithFrame:CGRectMake(0,imgHeigh/2, kScreenWidth-ZOOM(120)*2, CGRectGetHeight(_ShareInvitationCodeView.frame)-imgHeigh/2)];
    _SharebackView.backgroundColor=[UIColor whiteColor];
    _SharebackView.layer.cornerRadius=5;
    _SharebackView.clipsToBounds = YES;
    [_ShareInvitationCodeView addSubview:_SharebackView];
    
    _SharetitleImg = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM(120), 0, CGRectGetWidth(_ShareInvitationCodeView.frame)-2*ZOOM(120), imgHeigh)];
    _SharetitleImg.image = [UIImage imageNamed:@"-congratulation"];
    [_ShareInvitationCodeView addSubview:_SharetitleImg];
    
    
    //弹框内容
    [self finishContent:type];
    
    [self.view addSubview:_SharePopview];
    
    _ShareInvitationCodeView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    _ShareInvitationCodeView.alpha = 0.5;
    
    _SharePopview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _SharePopview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        
        _ShareInvitationCodeView.transform = CGAffineTransformMakeScale(1, 1);
        _ShareInvitationCodeView.alpha = 1;
        
    } completion:^(BOOL finish) {
        
    }];

}

- (void)finishContent:(NSString*)type
{
    
    CGFloat headimageY = ZOOM6(60);
    
    UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(20, headimageY, CGRectGetWidth(_SharebackView.frame)-40, ZOOM6(40))];
    titlelab.textColor = tarbarrossred;
    titlelab.textAlignment = NSTextAlignmentCenter;
    titlelab.font = [UIFont systemFontOfSize:ZOOM(51)];
    [_SharebackView addSubview:titlelab];
    
    CGFloat spaceheigh = ZOOM6(60);
    CGFloat imageviewYY = CGRectGetMaxY(titlelab.frame);
    
    if([type isEqualToString:DAILY_TASK_DUOBAO])
    {
        
        UILabel *titlelab1 = [[UILabel alloc]initWithFrame:CGRectMake(20, imageviewYY+ZOOM6(16), CGRectGetWidth(_SharebackView.frame)-40, ZOOM6(60))];
        titlelab1.textColor = RGBCOLOR_I(168, 168, 168);
        titlelab1.textAlignment = NSTextAlignmentCenter;
        titlelab1.font = [UIFont systemFontOfSize:ZOOM6(24)];
        titlelab1.text = [NSString stringWithFormat:@"你的参与号码为:2345678654\n请等待系统为你揭晓~"];
        titlelab1.numberOfLines = 0;
        [_SharebackView addSubview:titlelab1];
        
        spaceheigh = ZOOM6(30);
        imageviewYY = CGRectGetMaxY(titlelab1.frame);
    }
    
    
    //国片 描述文字 按钮

    CGFloat gobtnWidth = (CGRectGetWidth(_SharebackView.frame)-2*30-20)/2;
    CGFloat gobtnHeigh = ZOOM6(80);
    
    CGFloat imageHeigh = ZOOM6(200);
    
    for(int k =0;k<2;k++)
    {
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(30+(gobtnWidth+20)*k, imageviewYY+spaceheigh, imageHeigh, imageHeigh)];
        imageview.tag = 6666+k;
        [_SharebackView addSubview:imageview];
        
        UILabel *contentlab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(imageview.frame), CGRectGetMaxY(imageview.frame)+ZOOM6(14), imageHeigh, ZOOM6(24))];
        contentlab.textColor = RGBCOLOR_I(125, 125, 125);
        contentlab.text = @" ";
        contentlab.tag = 5555+k;
        contentlab.font = [UIFont systemFontOfSize:ZOOM6(24)];
        contentlab.textAlignment = NSTextAlignmentCenter;
        [_SharebackView addSubview:contentlab];
        
        
        UILabel *dislable = [[UILabel alloc]initWithFrame:CGRectMake(30+(gobtnWidth+20)*k, CGRectGetMaxY(contentlab.frame)+ZOOM6(24), gobtnWidth, ZOOM6(30))];
        
        dislable.text = @"已参与";
        dislable.tag = 7777+k;
        dislable.textColor = RGBCOLOR_I(255, 63, 139);
        dislable.textAlignment = NSTextAlignmentCenter;
        dislable.font = [UIFont systemFontOfSize:ZOOM6(28)];
        [_SharebackView addSubview:dislable];
        
        
        if(k==0)
        {
            UIImageView *checkimg = [[UIImageView alloc]init];
            checkimg.frame = CGRectMake(ZOOM6(20), -ZOOM6(5), ZOOM6(40), ZOOM6(40));
            checkimg.image = [UIImage imageNamed:@"qiandao_icon_celect"];
            [dislable addSubview:checkimg];
        }

        
        UIButton *gobtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        gobtn.frame = CGRectMake(30+(gobtnWidth+20)*k, CGRectGetMaxY(dislable.frame)+ZOOM6(60), gobtnWidth, gobtnHeigh);
        gobtn.backgroundColor = tarbarrossred;
        gobtn.clipsToBounds = YES;
        gobtn.tag = 8888+k;
        gobtn.layer.cornerRadius = 5;
        gobtn.userInteractionEnabled = YES;
        [gobtn setTintColor:[UIColor whiteColor]];
        
//        [gobtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(51)];
        [gobtn addTarget:self action:@selector(goClick:) forControlEvents:UIControlEventTouchUpInside];
        [_SharebackView addSubview:gobtn];
        
        [self buttontitle:type Titlelable:titlelab Image:imageview Lable:contentlab StatueLab:dislable Button:gobtn];
    }

    
}

- (void)buttontitle:(NSString*)type Titlelable:(UILabel*)titlelable Image:(UIImageView*)typeimage Lable:(UILabel*)typelable StatueLab:(UILabel*)Statuelable Button:(UIButton*)typebtn
{
    
    
    UILabel *name1 = (UILabel*)[_SignImageview viewWithTag:70000+_finishtaskList.count];
    UILabel *name2 = (UILabel*)[_SignImageview viewWithTag:70000+_finishtaskList.count+1];
    
    //任务类型
    if(typelable.tag == 5555)
    {
        typelable.text = name1.text;
    }else{
        typelable.text = name2.text;
        
        if([name2.text isEqualToString:@"2元包邮"] || [name2.text isEqualToString:@"3元包邮"])
        {
            typelable.text = @"赢取iPhone6";
            
        }else if ([name2.text isEqualToString:@"5元包邮"])
        {
            typelable.text = @"赢取MacBook Air";
        }
    }
    
    //任务图片
    if(typeimage.tag == 6666)
    {
        typeimage.image = [self getTypeImage:type Tag:(int)_finishtaskList.count];
    }else{
        
        NSString *tomorrrowstatue = [self signImagestatue:(int)_finishtaskList.count+1];
        NSString* type2 = [self getType:tomorrrowstatue];
        
        typeimage.image = [self getTypeImage:type2 Tag:(int)_finishtaskList.count+1];
    }

    
    typebtn.hidden = NO;
    
    if ([type isEqualToString:DAILY_TASK_ZERO])//0元购
    {
        if(typebtn.tag == 8888)
        {
            [typebtn setTitle:@"去抢购" forState:UIControlStateNormal];
            
        }else{
            [typebtn setTitle:@"知道了" forState:UIControlStateNormal];
            typebtn.backgroundColor = [UIColor clearColor];
            typebtn.tintColor = tarbarrossred;
            typebtn.layer.borderColor = tarbarrossred.CGColor;
            typebtn.layer.borderWidth=1;
        }
        
        
    }else if ([type isEqualToString:DAILY_TASK_XIANJING])//现金
    {
        titlelable.text = @"签到成功啦~";
        
        if(Statuelable.tag == 7777)
        {
            Statuelable.text = @"已领取";
        }else{
            Statuelable.text = @"明日可领取";
        }
        
        if(typebtn.tag == 8888)
        {
            [typebtn setTitle:@"知道了" forState:UIControlStateNormal];
            typebtn.backgroundColor = [UIColor clearColor];
            
            [typebtn setTitleColor:tarbarrossred forState:UIControlStateNormal];
            typebtn.layer.borderColor = tarbarrossred.CGColor;
            typebtn.layer.borderWidth=1;

        }else{
            [typebtn setTitle:@"查看余额" forState:UIControlStateNormal];
            typebtn.tintColor = [UIColor whiteColor];
        }
        
        
    }else if ([type isEqualToString:DAILY_TASK_YOUHUI])//优惠
    {
        titlelable.text = @"签到成功啦~";
        
        if(Statuelable.tag == 7777)
        {
            Statuelable.text = @"已领取";
        }else{
            Statuelable.text = @"明日可领取";
        }

        if(typebtn.tag == 8888)
        {
            [typebtn setTitle:@"知道了" forState:UIControlStateNormal];
            typebtn.backgroundColor = [UIColor clearColor];
            typebtn.tintColor = tarbarrossred;
            typebtn.layer.borderColor = tarbarrossred.CGColor;
            typebtn.layer.borderWidth=1;

        }else{
            [typebtn setTitle:@"查看卡券" forState:UIControlStateNormal];
        }
        
        
    }else if ([type isEqualToString:DAILY_TASK_JIFEN])//积分
    {
        titlelable.text = @"签到成功啦~";
        
        if(Statuelable.tag == 7777)
        {
            Statuelable.text = @"已领取";
        }else{
            Statuelable.text = @"明日可领取";
        }

        if(typebtn.tag == 8888)
        {
            [typebtn setTitle:@"知道了" forState:UIControlStateNormal];
            typebtn.backgroundColor = [UIColor clearColor];
            typebtn.tintColor = tarbarrossred;
            typebtn.layer.borderColor = tarbarrossred.CGColor;
            typebtn.layer.borderWidth=1;
            
        }else{
            [typebtn setTitle:@"查看积分" forState:UIControlStateNormal];
           
        }
        
    }
    else if ([type isEqualToString:DAILY_TASK_BAOYOU])//包邮
    {
        titlelable.text = @"签到成功啦~";
        
        if(Statuelable.tag == 7777)
        {
            Statuelable.text = @"已参与";
        }else{
            Statuelable.text = @"明日可领取";
        }
        
        if(typebtn.tag == 8888)
        {
            [typebtn setTitle:@"知道了一定来~" forState:UIControlStateNormal];
            
            typebtn.frame = CGRectMake(30, CGRectGetMaxY(Statuelable.frame)+ZOOM6(60), CGRectGetWidth(_SharebackView.frame)-2*30, ZOOM(36*3.4));
            
        }else{
            [typebtn setTitle:@"知道了" forState:UIControlStateNormal];
            
            typebtn.hidden = YES;
        }
        
    }
    else if ([type isEqualToString:DAILY_TASK_DUOBAO])//夺宝
    {
        titlelable.text = @"签到成功啦~";
        
        if(Statuelable.tag == 7777)
        {
            Statuelable.text = @"已参与";
        }else{
            Statuelable.text = @"明日可领取";
        }

        if(typebtn.tag == 8888)
        {
            [typebtn setTitle:@"知道了一定来~" forState:UIControlStateNormal];
            
            typebtn.frame = CGRectMake(30, CGRectGetMaxY(Statuelable.frame)+ZOOM6(60), CGRectGetWidth(_SharebackView.frame)-2*30, ZOOM(36*3.4));
            
        }else{
            [typebtn setTitle:@"知道了" forState:UIControlStateNormal];
            typebtn.backgroundColor = [UIColor yellowColor];
            typebtn.hidden = YES;
        }
    
    }
    else if ([type isEqualToString:DAILY_TASK_DOUBLE])
    {
    
        titlelable.text = @"签到成功啦~";
        
        if(Statuelable.tag == 7777)
        {
            Statuelable.text = @"已开启";
        }else{
            Statuelable.text = @"明日可领取";
        }

        if(typebtn.tag == 8888)
        {
            [typebtn setTitle:@"知道了" forState:UIControlStateNormal];
            typebtn.backgroundColor = [UIColor clearColor];
            typebtn.tintColor = tarbarrossred;
            typebtn.layer.borderColor = tarbarrossred.CGColor;
            typebtn.layer.borderWidth=1;
            typebtn.userInteractionEnabled = NO;
            
        }else{
            [typebtn setTitle:@"查看余额" forState:UIControlStateNormal];
        }
        
    }
}

#pragma mark //获取任务图片
- (UIImage*)getTypeImage:(NSString*)type Tag:(int)tag
{
    
    NSString *valuestr = [self signtypestatue:tag];
    
    UIImage *image = [[UIImage alloc]init];
    
    if([type isEqualToString:DAILY_TASK_DOUBLE])
    {
        image = [UIImage imageNamed:@"yuefanbei"];
        
    }else if ([type isEqualToString:DAILY_TASK_XIANJING])
    {
        image = [UIImage imageNamed:[NSString stringWithFormat:@"qiandao_%@yuan",valuestr]];
        
    }else if ([type isEqualToString:DAILY_TASK_JIFEN])
    {
       image = [UIImage imageNamed:@"qiandao_jifen"];
        
    }else if ([type isEqualToString:DAILY_TASK_YOUHUI])
    {
        
        image = [UIImage imageNamed:[NSString stringWithFormat:@"qiandao_%@yuan-youhuiquan",valuestr]];
        
    }else if([type isEqualToString:DAILY_TASK_BAOYOU]){
        
        if(valuestr.intValue ==3)
        {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",@"qiandao_3yuan iPhone6"]];
        }else if (valuestr.intValue ==5)
        {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",@"qiandao_5yuan-mac"]];
        }
        else{
            image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",@"qiandao_3yuan iPhone6"]];
        }
    }

    return image;
}

- (NSString*)getType:(NSString*)type
{
    NSString *typestr;
    
    switch (type.intValue) {
        case 3:
            
            typestr = DAILY_TASK_YOUHUI;
            break;
        case 4:
            
            typestr = DAILY_TASK_JIFEN;
            break;
            
        case 5:
            
            typestr = DAILY_TASK_XIANJING;
            break;
        case 7:
            
            typestr = DAILY_TASK_BAOYOU;
            break;
            
        case 8:
        
            typestr = DAILY_TASK_DOUBLE;
            break;
            
        case 20:
            
            typestr = DAILY_TASK_XIANJING;
            
            break;
            
        default:
            break;
    }
    
    return typestr;
}


#pragma mark **************明日预告弹框*************
#pragma mark 明天任务弹框
- (void)popTomorrowView:(NSString*)type
{
    _Popview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    _Popview.userInteractionEnabled = YES;
    [self.view addSubview:_Popview];
    
    //弹框内容
    _InvitationCodeView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(120), (kScreenHeight - ZOOM6(420))/2, kScreenWidth-ZOOM(120)*2, ZOOM6(420))];
    _InvitationCodeView.backgroundColor=[UIColor clearColor];
    
    _InvitationCodeView.clipsToBounds = YES;
    [_Popview addSubview:_InvitationCodeView];
    
    //底视图
    _backview = [[UIView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth-ZOOM(120)*2,CGRectGetHeight(_InvitationCodeView.frame))];
    _backview.backgroundColor=[UIColor whiteColor];
    _backview.layer.cornerRadius=5;
    _backview.clipsToBounds = YES;
    [_InvitationCodeView addSubview:_backview];
    
    UIImageView *bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _InvitationCodeView.frame.size.width, ZOOM6(80))];
    bgImg.backgroundColor=tarbarrossred;
    [_backview addSubview:bgImg];
    
    //标题
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(bgImg.frame), CGRectGetHeight(bgImg.frame))];
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.backgroundColor = [UIColor clearColor];
    titlelabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.text = @"明日签到赢壕礼";
    [_backview addSubview:titlelabel];
    
    
    //关闭按钮
    CGFloat btnwidth = IMGSIZEW(@"icon_close1");
    _canclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _canclebtn.frame=CGRectMake(CGRectGetWidth(_InvitationCodeView.frame)-btnwidth-ZOOM(10), 0, btnwidth, btnwidth);
    [_canclebtn setImage:[UIImage imageNamed:@"icon_close1"] forState:UIControlStateNormal];
    _canclebtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    _canclebtn.layer.cornerRadius=btnwidth/2;
    [_canclebtn addTarget:self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
    _canclebtn.frame=CGRectMake(CGRectGetWidth(_InvitationCodeView.frame)-btnwidth-ZOOM(10), (CGRectGetHeight(bgImg.frame)-btnwidth)/2, btnwidth, btnwidth);
    [_canclebtn setImage:[UIImage imageNamed:@"qiandao_icon_close"] forState:UIControlStateNormal];
    [_backview addSubview:_canclebtn];
    
    
    [self creatTomrrow:bgImg Type:type];
    
    //弹框弹出
    _InvitationCodeView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    _InvitationCodeView.alpha = 0.5;
    
    _Popview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _Popview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        
        _InvitationCodeView.transform = CGAffineTransformMakeScale(1, 1);
        _InvitationCodeView.alpha = 1;
        
    } completion:^(BOOL finish) {
        
    }];

    
}

#pragma mark 夺宝弹框
- (void)creatTomrrow:(UIView*)headview Type:(NSString*)type
{
    NSString *valuestr = [self signtypestatue:_selectSigntag];
    
    //任务分类图片
    
    CGFloat headimageW = ZOOM6(200);
    CGFloat headimageH = ZOOM6(200);
    
    int count = 1;
    if([type isEqualToString:DAILY_TASK_DUOBAO] || [type isEqualToString:DAILY_TASK_BAOYOU]){
        count = 2;
    }

    CGFloat ORXX = (headview.frame.size.width/2-headimageW)/2;
    CGFloat headSpace = CGRectGetWidth(_InvitationCodeView.frame) - 2*ORXX - 2*headimageW;
    if(count == 1)
    {
        ORXX = (headview.frame.size.width-headimageW)/2;
    }
    
    for(int j =0;j<count;j++)
    {
        UIImageView *headimage = [[UIImageView alloc]initWithFrame:CGRectMake(ORXX+(headimageW+headSpace)*j, CGRectGetMaxY(headview.frame)+ZOOM6(50), headimageW, headimageH)];
        
        
        UILabel *discriptionlab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(headimage.frame), CGRectGetMaxY(headimage.frame)+ZOOM6(14), CGRectGetWidth(headimage.frame), ZOOM6(24))];
        discriptionlab.textColor = RGBCOLOR_I(125, 125, 125);
        discriptionlab.font = [UIFont systemFontOfSize:ZOOM6(24)];
        discriptionlab.textAlignment = NSTextAlignmentCenter;
        
        if(j==0)
        {
           
            if([type isEqualToString:DAILY_TASK_DOUBLE])
            {
                headimage.image = [UIImage imageNamed:@"yuefanbei"];
                discriptionlab.text = @"余额翻倍";
            }else if ([type isEqualToString:DAILY_TASK_XIANJING])
            {
                headimage.image = [UIImage imageNamed:[NSString stringWithFormat:@"qiandao_%@yuan",valuestr]];
                discriptionlab.text = [NSString stringWithFormat:@"%@元现金",valuestr];
            }else if ([type isEqualToString:DAILY_TASK_JIFEN])
            {
                headimage.image = [UIImage imageNamed:@"qiandao_jifen"];
                discriptionlab.text = [NSString stringWithFormat:@"%@积分",valuestr];
            }else if ([type isEqualToString:DAILY_TASK_YOUHUI])
            {
                
                headimage.image = [UIImage imageNamed:[NSString stringWithFormat:@"qiandao_%@yuan-youhuiquan",valuestr]];
                
                discriptionlab.text = [NSString stringWithFormat:@"%@元优惠劵",valuestr];
            }else if([type isEqualToString:DAILY_TASK_BAOYOU]){
                
                if(valuestr.intValue == 5)
                {
                    discriptionlab.text = @"赢取MacBook Air";
                    
                    headimage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",@"qiandao_5yuan-mac"]];
                }else{
                    discriptionlab.text = @"赢取iPhone6";
                    headimage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",@"qiandao_3yuan iPhone6"]];
                }
                
            }

            
        }else{
            
            headimage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",valuestr,@"yuanbaoyou_pop-up"]];
            discriptionlab.text = [NSString stringWithFormat:@"%@包邮",valuestr];
        }
        
        [_backview addSubview:headimage];
        [_backview addSubview:discriptionlab];
        
    }
    
}



#pragma mark 翻倍视图
- (void)creatDoubleView
{
    UIView *doubleView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_ShareInvitationCodeView.frame)-ZOOM6(240), CGRectGetWidth(_ShareInvitationCodeView.frame), ZOOM6(180))];
    doubleView.backgroundColor = RGBCOLOR_I(255, 248, 223);
    [_ShareInvitationCodeView addSubview:doubleView];
    
    UILabel *titlelable = [[UILabel alloc]initWithFrame:CGRectMake(0, ZOOM6(40), CGRectGetWidth(doubleView.frame), ZOOM6(30))];
    titlelable.text = @"您已获得24小时余额翻倍特权";
    titlelable.font = [UIFont systemFontOfSize:ZOOM6(30)];
    titlelable.textColor = RGBCOLOR_I(255, 170, 0);
    titlelable.textAlignment = NSTextAlignmentCenter;
    [doubleView addSubview:titlelable];
    
    UIButton *goDoublebtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    goDoublebtn.frame = CGRectMake((doubleView.frame.size.width-ZOOM6(240))/2, CGRectGetMaxY(titlelable.frame)+ZOOM6(12), ZOOM6(240), ZOOM6(60));
    goDoublebtn.layer.borderWidth = 1;
    goDoublebtn.layer.borderColor = RGBCOLOR_I(255, 170, 0).CGColor;
    goDoublebtn.layer.cornerRadius = ZOOM6(60)/2;
    
    [goDoublebtn addTarget:self action:@selector(godouble) forControlEvents:UIControlEventTouchUpInside];
    [doubleView addSubview:goDoublebtn];
    
    UILabel *btnlable = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), ZOOM6(10), ZOOM6(160), ZOOM6(40))];
    btnlable.text = @"立即开启";
    btnlable.textColor = RGBCOLOR_I(255, 170, 0);
    btnlable.font = [UIFont systemFontOfSize:ZOOM6(30)];
    btnlable.textAlignment = NSTextAlignmentCenter;
    [goDoublebtn addSubview:btnlable];
    
    UIImageView *btnImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btnlable.frame), ZOOM6(10), ZOOM6(40), ZOOM6(40))];
    btnImage.image = [UIImage imageNamed:@"icon_go_yellow"];
    [goDoublebtn addSubview:btnImage];
    
    
    UIImageView *baseImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_ShareInvitationCodeView.frame)-ZOOM6(60), CGRectGetWidth(doubleView.frame), ZOOM6(60))];
    baseImg.image = [UIImage imageNamed:@"bg"];
    [_ShareInvitationCodeView addSubview:baseImg];
    
    _storetimelable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(baseImg.frame), CGRectGetHeight(baseImg.frame))];
    _storetimelable.text = @" ";
    _storetimelable.textAlignment = NSTextAlignmentCenter;
    _storetimelable.textColor = [UIColor whiteColor];
    _storetimelable.font = [UIFont systemFontOfSize:ZOOM6(24)];
    [baseImg addSubview:_storetimelable];
}

#pragma mark 开启余额翻倍
- (void)godouble
{
    [self doubleSuccessEntrance:1];
    [self SharetapClick];
}
-(void)dismissclick:(UITapGestureRecognizer*)tap
{
    [self SharetapClick];
}

-(void)SharetapClick
{
    [_Sharecanclebtn removeFromSuperview];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _SharePopview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
        _ShareInvitationCodeView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        _ShareInvitationCodeView.alpha = 0;
        
    } completion:^(BOOL finish) {
        
        [_SharePopview removeFromSuperview];
        _SharePopview = nil;
    }];
    
    [RemindView removeFromSuperview];
    
    if([DataManager sharedManager].isOligible == YES )
    {
        [self setRemindView];
    }

}

#pragma mark 选择分享的平台
-(void)shareClick:(UIButton*)sender
{
    [MobClick event:QIANDAO_SHARE];
    
    if(sender.tag == 9000)
    {
        _isWeixin_share = YES;
    }else{
        _isWeixin_share = NO;
    }
    
    if(_shareModelview )
    {
        UIView *backview = (UIView*)[self.view viewWithTag:9797];
        
        [UIView animateWithDuration:0.5 animations:^{
            
            backview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
            
            
            _shareModelview.frame=CGRectMake(0, kApplicationHeight+30, kApplicationWidth, SHAREMODELHEIGH);
            
        } completion:^(BOOL finished) {
            
            [backview removeFromSuperview];
            [_shareModelview removeFromSuperview];
            
            NSString *type = sender.titleLabel.text;
            [self httpGetRandShopWithType:type Daytag:_selectSigntag+1];
        }];
        
    }
}


- (void)disapperview:(UITapGestureRecognizer*)tap
{
    
    [self disapperShareview];
    
}

- (void)disapperShareview
{
    if(_shareModelview )
    {
        
        UIView *backview = (UIView*)[self.view viewWithTag:9797];
        
        [UIView animateWithDuration:0.5 animations:^{
            
            backview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
            
            
            _shareModelview.frame=CGRectMake(0, kApplicationHeight+30, kApplicationWidth, SHAREMODELHEIGH);
            
        } completion:^(BOOL finished) {
            
            [backview removeFromSuperview];
            [_shareModelview removeFromSuperview];
        }];
        
    }

}

- (void)leftBarButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark ***********网络部分*************
- (void)requestHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    
    NSString *url;
    url=[NSString stringWithFormat:@"%@signIn/getCount?version=%@&token=%@",URLHTTP,VERSION,token];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
        //
        MyLog(@"responseObject = %@",responseObject);
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *messsage=responseObject[@"message"];
        
            if(statu.intValue==1)
            {
                //刷新主界面
                [self refreshMainUI:responseObject];
            }else{
                if(token.length >10)
                {
                    [_mentionview showLable:messsage Controller:self];
                }
                
            }
            
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        [MBProgressHUD hideHUDForView:self.view];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        
    }];

}

#pragma mark 网络请求是否有补签卡
- (void)RetroactiveHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    
    NSString *url;
    url=[NSString stringWithFormat:@"%@signIn/ckeckCard?version=%@&token=%@",URLHTTP,VERSION,token];
    
    NSString *URL=[MyMD5 authkey:url];
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
        //
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *messsage=responseObject[@"message"];
            
            if(statu.intValue==1)
            {
                if([responseObject[@"bool"] intValue] == 0)
                {
                    _isBuqianka = NO;
                }else if ([responseObject[@"bool"] intValue] == 1)
                {
                    _isBuqianka = YES;
                }
                
                [self creatPopView:@"补签卡"];
            }else{
                [_mentionview showLable:messsage Controller:self];
            }
            
        }
        
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        [MBProgressHUD hideHUDForView:self.view];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        
    }];
    

}

#pragma mark 任务列表
- (void)taskListHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    
    NSString *url;
    
    if(token ==nil || [token isEqual:[NSNull null]])//没登录
    {
        url=[NSString stringWithFormat:@"%@signIn/siTaskList?version=%@&token=%@",URLHTTP,VERSION,token];

    }else{
        url=[NSString stringWithFormat:@"%@signIn/siLogTaskList?version=%@&token=%@",URLHTTP,VERSION,token];
    }
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
        MyLog(@"responseObject = %@",responseObject);
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *messsage=responseObject[@"message"];
            
            if(statu.intValue==1)
            {
                if([responseObject[@"motaskList"] count])
                {
                    [_MydataArray removeAllObjects];
                    [_motaskList removeAllObjects];
                    
                    _motaskDataArray = [NSMutableArray arrayWithArray:responseObject[@"motaskList"]];
                    
                    for(NSDictionary *dic in responseObject[@"motaskList"])
                    {
                        
                        //后面加上
                        NSString * ID = [NSString stringWithFormat:@"%@",dic[@"id"]];
                      
                        
                        if(ID !=nil)
                        {
                            [_motaskList addObject:ID];
                        }
                    }
                    
                }
                
                if([responseObject[@"taskList"] count])
                {
                    for(NSDictionary *dic in responseObject[@"taskList"])
                    {
                        SignModel *model = [[SignModel alloc]init];
                        
                        NSString *add_time =[NSString stringWithFormat:@"%@",dic[@"add_time"]];
                        NSString *condition =[NSString stringWithFormat:@"%@",dic[@"condition"]];
                        NSString *is_show =[NSString stringWithFormat:@"%@",dic[@"is_show"]];
                        NSString *t_id =[NSString stringWithFormat:@"%@",dic[@"t_id"]];
                        NSString *t_name =[NSString stringWithFormat:@"%@",dic[@"t_name"]];
                        NSString *type_id =[NSString stringWithFormat:@"%@",dic[@"type_id"]];
                        NSString *value =[NSString stringWithFormat:@"%@",dic[@"value"]];
                        
                        if(add_time !=nil)
                        {
                            model.add_time = add_time;
                        }
                        if(condition !=nil)
                        {
                            model.condition = condition;
                        }
                        if(is_show !=nil)
                        {
                            model.is_show = is_show;
                        }
                        if(t_id !=nil)
                        {
                            model.t_id = t_id;
                        }
                        if(t_name !=nil)
                        {
                            model.t_name = t_name;
                        }
                        if(type_id !=nil)
                        {
                            model.type_id = type_id;
                        }
                        if(value !=nil)
                        {
                            model.value = value;
                        }
                        
                        [_MydataArray addObject:model];
                    }
                }
                
                MyLog(@"_MydataArray = %@",_MydataArray);
                MyLog(@"_motaskList = %@",_motaskList);
                
                [self refreshListUI];
                
                //任务完成列表
                [self finishtaskHttp];
            }
            
//            else{
//                
//                NavgationbarView *alertview=[[NavgationbarView alloc] init];
//                [alertview showAlert:messsage];
//                
//            }
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        [MBProgressHUD hideHUDForView:self.view];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        
    }];

}

#pragma mark 完成任务数据请求
- (void)finishtaskHttp
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    url=[NSString stringWithFormat:@"%@signIn/userTaskList?version=%@&token=%@",URLHTTP,VERSION,token];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *messsage=responseObject[@"message"];
            _signIn_status = responseObject[@"signIn_status"];
            _changeTable = responseObject[@"table"];

            if(statu.intValue==1)
            {
                if([responseObject[@"taskList"] count])
                {
                    [_finishtaskList removeAllObjects];
                    
                    for(NSDictionary *dic in responseObject[@"taskList"])
                    {
                        SignModel *model = [[SignModel alloc]init];
                        
                        NSString *add_time =[NSString stringWithFormat:@"%@",dic[@"add_time"]];
                        
                        NSString *t_id =[NSString stringWithFormat:@"%@",dic[@"t_id"]];
                        
                        NSString *type_id =[NSString stringWithFormat:@"%@",dic[@"type_id"]];
                        
                        
                        if(add_time !=nil)
                        {
                            model.add_time = add_time;
                        }
                        
                        if(t_id !=nil)
                        {
                            model.t_id = t_id;
                        }
                        
                        if(type_id !=nil)
                        {
                            model.type_id = type_id;
                        }
                        
                        [_finishtaskList addObject:model];
                    }
                    
                }
                
                if(_finishtaskList.count)//开店过
                {
                    [self refreshStatueimage];
                    
                }else{//未开店
                    
                    
                    //刷新状态图
                    if(_finishtaskList.count==0)
                    {
                        for(int k =0;k<30;k++)
                        {
                            UIImageView *statueimage = (UIImageView*)[_SignImageview viewWithTag:80000+k];
                            statueimage.image = [UIImage imageNamed:@""];
                        }
                    }

                    if(_motaskList.count)
                    {
                        UIImageView *statueimage = (UIImageView*)[_SignImageview viewWithTag:80000];
                        NSString *todaystatue = [self signImagestatue:0];
                        if([todaystatue intValue] == 6)
                        {
                            statueimage.image = [UIImage imageNamed:@"kaidianlingqu"];
                        }else if ([todaystatue intValue] == 7)
                        {
                            statueimage.image = [UIImage imageNamed:@"quduobao"];
                        }
                        else{
                            
                            if(_signIn_status.intValue == 0)
                            {
                                statueimage.image = [UIImage imageNamed:@"fenxianglingqu"];
                                
                            }else if (_signIn_status.intValue == 2)
                            {
                                statueimage.image = [UIImage imageNamed:@"buqian"];
                            }
                        }
                    }
                }
            }
            
            else if(statu.intValue == 10030){
                
                //刷新状态图
                if(_finishtaskList.count==0)
                {
                    for(int k =0;k<30;k++)
                    {
                        UIImageView *statueimage = (UIImageView*)[_SignImageview viewWithTag:80000+k];
                        statueimage.image = [UIImage imageNamed:@""];
                    }
                }

                //刷新主界面
                for(int j=0;j<3;j++)
                {
                    UILabel *countlab = (UILabel*)[self.view viewWithTag:400000+j];
                    if(j==0)
                    {
                        countlab.text = @"0";
                    }else if (j==1)
                    {
                        countlab.text = @"0";
                    }else if (j==2)
                    {
                        countlab.text = @"0";
                    }
                }
                
                _cornerlab.hidden = YES;
                _cornerlab.text = @"0";
            
            }
        
        }
    
        
        //当前未完成的任务抖动
        [self goshake:(int)_finishtaskList.count];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        [MBProgressHUD hideHUDForView:self.view];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        
    }];

}

#pragma mark 签到网络请求
- (void)SignHttp:(NSString*)myType
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    
    NSString *url;
    
    url=[NSString stringWithFormat:@"%@signIn/signIning?version=%@&token=%@",URLHTTP,VERSION,token];

    if([myType isEqualToString:DAILY_TASK_DOUBLE])//余额翻倍时获取时间
    {
        url=[NSString stringWithFormat:@"%@signIn/signIning?version=%@&token=%@&retime=true",URLHTTP,VERSION,token];
    }
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *messsage=responseObject[@"message"];
            _changeTable = responseObject[@"changeTable"];
            
            if(statu.intValue==1)
            {
                 if ([myType isEqualToString:DAILY_TASK_BUQIAN]||[myType isEqualToString:DAILY_TASK_ZERO]||[myType isEqualToString:DAILY_TASK_YOUHUI]||[myType isEqualToString:DAILY_TASK_JIFEN]||[myType isEqualToString:DAILY_TASK_XIANJING]||[myType isEqualToString:DAILY_TASK_STORE] ||[myType isEqualToString:DAILY_TASK_BAOYOU] ||[myType isEqualToString:DAILY_TASK_DOUBLE])
                 {
                     //刷新数据
                     [self creatData];
                     
                     if(!_SharePopview)
                     {
                         if([myType isEqualToString:DAILY_TASK_DOUBLE])
                         {
                             
                             if([responseObject[@"t_time"] doubleValue] >0)
                             {
                                 //保存余额翻倍时间
                                 [userdefaul setObject:responseObject[@"s_time"] forKey:DOUBLE_S_TIME];
                                
                                 [DataManager sharedManager].isOligible = YES;
                                 [DataManager sharedManager].isOpen = NO;
                                 [DataManager sharedManager].endDate = ((NSNumber *)responseObject[@"t_time"]).longLongValue;
                             }
                             
                             NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
                             NSString *nowtime = [userdefaul objectForKey:DOUBLE_S_TIME];
                             
                             [_mytimer invalidate];
                             _mytimer = nil;
                             
                             _timeCount =0;
                             _mytimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nowtime repeats:YES];
                         }
                         
                        
                        [self creatFinishPopview:myType];
                         
                     }
                 }
                
            }
            else{
                
                NavgationbarView *alertview=[[NavgationbarView alloc] init];
                [alertview showLable:messsage Controller:self];
                
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        [MBProgressHUD hideHUDForView:self.view];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        
    }];
    

}

#pragma mark 获取夺宝的参与号码
- (void)getincode
{
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *pay_type = [userdefaul objectForKey:PAY_TYPE];
    NSString *order_code = [userdefaul objectForKey:PAY_ORDERCODE];
    NSString *pay_num = [userdefaul objectForKey:PAY_NUM];
    
    NSString *url;
    if (pay_num.intValue>=2) {
        url=[NSString stringWithFormat:@"%@treasures/getPayCodeList?version=%@&token=%@&g_code=%@&pay_type=%@",PAYHTTP,VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN],order_code,pay_type];
    }else
        url=[NSString stringWithFormat:@"%@treasures/getPayCode?version=%@&token=%@&order_code=%@&pay_type=%@",PAYHTTP,VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN],order_code,pay_type];
    
    NSString *URL=[MyMD5 authkey:url];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject!=nil) {
            MyLog(@"responseObject = %@   %@", responseObject,responseObject[@"message"]);
            NSString *statue = responseObject[@"status"];
            
            if(statue.intValue == 1)
            {
                self.in_code = [NSString stringWithFormat:@"%@",responseObject[@"data"]];
                //参与号码
                if(!_SharePopview)
                {
                    [self creatFinishPopview:DAILY_TASK_DUOBAO];
                }
            }
            
            
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - 判断用户是否绑定过手机
- (void)httpFindPhone
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@user/queryPhone?version=%@&token=%@",URLHTTP,VERSION,token];
    NSString *URL = [MyMD5 authkey:urlStr];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                if ([responseObject[@"bool"] boolValue]== YES) { // 绑定过手机
                    
                    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
                    
                    NSString *unionid = [userdefaul objectForKey:UNION_ID];
                    

                    MyLog(@"unionid = %@",unionid);
                    
                    //跳转到小店去开店
                    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                    
                    [user setObject:@"2" forKey:@"isShowNoviceTaskView6"];
                    
                    NSArray *viewControllers = Mtarbar.viewControllers;
                    
                    NSMutableArray *viewControllersTemp = [NSMutableArray arrayWithArray:viewControllers];
                    
                    TFHomeViewController *thVC = [[TFHomeViewController alloc] init];
                    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:thVC];
                    [viewControllersTemp replaceObjectAtIndex:0 withObject:nc];
                    Mtarbar.viewControllers = viewControllersTemp;
                    Mtarbar.selectedIndex=0;

                    
                } else { //没有绑定过手机
                    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"为了您的账户安全，请先绑定手机" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消",@"确认", nil];
                    [alter show];
                    
                }
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
    }];
}

#pragma mark 修改用户信息 将微信授权unionid传给后台
-(void)saveHttp:(NSString*)unionidstr
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    
    NSString *url=[NSString stringWithFormat:@"%@user/update_userinfo?version=%@&token=%@&unionid=%@",URLHTTP,VERSION,token,unionidstr];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [[Animation shareAnimation] createAnimationAt:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        //responseObject is %@",responseObject);
        
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            if(str.intValue==1)
            {
                message=@"授权成功";
                
                //跳转到小店去开店
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                
                [user setObject:@"2" forKey:@"isShowNoviceTaskView6"];
                
                if(responseObject[@"unionid"] !=nil || ![responseObject[@"unionid"] isEqualToString:@"<null>"])
                {
                    [user setObject:responseObject[@"unionid"] forKey:UNION_ID];
                }
                
                NSArray *viewControllers = Mtarbar.viewControllers;
                
                NSMutableArray *viewControllersTemp = [NSMutableArray arrayWithArray:viewControllers];
                TFHomeViewController *thVC = [[TFHomeViewController alloc] init];
                UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:thVC];
                [viewControllersTemp replaceObjectAtIndex:0 withObject:nc];
                Mtarbar.viewControllers = viewControllersTemp;
                Mtarbar.selectedIndex=0;

            }
            else{
                message=@"授权失败";
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"保存失败,请重试!" Controller:self];
        
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
    }];
    
    
}

#pragma mark 修改用户信息 将微信授权UUID传给后台
-(void)saveIMEIHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    NSString *IMEI = [user objectForKey:USER_IMEI];
    
    NSString *url=[NSString stringWithFormat:@"%@user/update_userinfo?version=%@&token=%@&imei=%@",URLHTTP,VERSION,token,IMEI];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [[Animation shareAnimation] createAnimationAt:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        //responseObject is %@",responseObject);
        
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            
            if(str.intValue==1)
            {
                MyLog(@"上传成功");
            }
            else{
                MyLog(@"上传失败");
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"保存失败,请重试!" Controller:self];
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
    }];
    
}


#pragma mark 获取随机分享商品
- (void)httpGetRandShopWithType:(NSString *)myType Daytag:(int)daytag
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *realm = [ud objectForKey:USER_REALM];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlStr;
    
    NSString *shoptypestr;
    
    NSString *sharevalue;
    NSString *sharetype;
    if(_motaskDataArray.count)
    {
        NSDictionary *dic = _motaskDataArray[daytag-1];
        sharevalue = [NSString stringWithFormat:@"%@",dic[@"value"]];
        sharetype = [NSString stringWithFormat:@"%@",dic[@"type"]];
        
    }
    
    if ([myType isEqualToString:DAILY_TASK_BUQIAN]||[myType isEqualToString:DAILY_TASK_ZERO]||[myType isEqualToString:DAILY_TASK_YOUHUI]||[myType isEqualToString:DAILY_TASK_JIFEN]||[myType isEqualToString:DAILY_TASK_XIANJING]||[myType isEqualToString:DAILY_TASK_STORE] ||[myType isEqualToString:DAILY_TASK_DOUBLE])
    {
        //实惠类商品
        urlStr = [NSString stringWithFormat:@"%@shop/shareShop?token=%@&version=%@&realm=%@&getShop=true&hobby=20",URLHTTP, token,VERSION, realm];
        shoptypestr = @"正价商品";
        
        switch (sharetype.intValue) {
            case 1://0元购
                
//                //0元购商品
//                urlStr = [NSString stringWithFormat:@"%@shop/getPSShareLink?token=%@&version=%@&%@",URLHTTP, token,VERSION,sharevalue];
                break;
            case 2://正价
                
                urlStr = [NSString stringWithFormat:@"%@shop/shareShop?token=%@&version=%@&realm=%@&getShop=true&%@",URLHTTP, token,VERSION, realm,sharevalue];
                shoptypestr = @"正价商品";
                break;
                
//            case 3://活动图片
//                
//                _ishuodongtu = YES;
//                [self shareRandShopWithPrice:nil QRLink:nil sharePicUrl:sharevalue type:myType];
//                
//                return;
//            case 4://特价商品
                
                
                return;

            default:
                break;
        }
        
    }
    NSString *URL = [MyMD5 authkey:urlStr];

    [MBProgressHUD showMessage:@"分享加载中，稍等哟~" afterDeleay:0 WithView:self.view];

    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject!=nil) {
            
            MyLog(@"responseObject = %@",responseObject);
            
            if ([responseObject[@"status"] intValue] == 1) {
                
                if(![shoptypestr isEqualToString:@"正价商品"])//0元购商品
                {
                
                    NSArray * shoparr =responseObject[@"Pshop"][@"shop_list"];
                    
                    if(shoparr.count)
                    {
                        int dex = arc4random() % shoparr.count;
                        
                        NSDictionary *shopdic  = shoparr[dex];
                        
                        NSString *sharepic;
                        NSString *sharelink;
                        NSString *shareprice;
                        
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
                                
                               sharepic = [NSString stringWithFormat:@"%@/%@/%@",supcode,code,shopdic[@"four_pic"]];
                                
                            }
                            
                            
                        }
                        
                        if(responseObject[@"link"])
                        {
                            
                            sharelink = [NSString stringWithFormat:@"%@",responseObject[@"link"]];
                           
                        }
                        
                        if(responseObject[@"price"])
                        {
                            
                            shareprice = responseObject[@"price"];
                            
                        }
                        
                        MyLog(@"sharepic=%@ sharelink=%@ shareprice=%@",sharepic,sharelink,shareprice)
                        
                        [self httpGetShareImageWithPrice:responseObject[@"price"] QRLink:sharelink sharePicUrl:sharepic type:myType];
                    }
                    

                }else{//正价商品
                    
                    NSString *QrLink = responseObject[@"QrLink"];
                    NSNumber *shop_se_price = responseObject[@"shop"][@"shop_se_price"];
                    NSString *four_pic = responseObject[@"shop"][@"four_pic"];
                    NSArray *picArr = [four_pic componentsSeparatedByString:@","];
                    
                    NSString *pic = [picArr lastObject];
                    NSString *shop_code = responseObject[@"shop"][@"shop_code"];
                    NSString *sup_code  = [shop_code substringWithRange:NSMakeRange(1, 3)];
                    NSString *share_pic = [NSString stringWithFormat:@"%@/%@/%@", sup_code, shop_code, pic];

                    if(QrLink.length > 0)
                    {
                        NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
                        [userdefaul setObject:QrLink forKey:QR_LINK];
                    }
                    
                    [self httpGetShareImageWithPrice:shop_se_price QRLink:QrLink sharePicUrl:share_pic type:myType];
                }
                
            }else
                [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

- (void)httpGetShareImageWithPrice:(NSNumber *)shop_price QRLink:(NSString *)qrLink sharePicUrl:(NSString *)picUrl type:(NSString *)myType
{

    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",UPYHTTP, picUrl];

    manager.responseSerializer = [AFImageResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (responseObject!=nil) {
            NSData *imgData = UIImagePNGRepresentation(responseObject);
            self.shareRandShopImage = [UIImage imageWithData:imgData];
            
            [self shareRandShopWithPrice:shop_price QRLink:qrLink sharePicUrl:picUrl type:myType];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}
- (void)shareRandShopWithPrice:(NSNumber *)shop_price QRLink:(NSString *)qrLink sharePicUrl:(NSString *)picUrl type:(NSString *)myType
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate shardk];
        
        UIImage *QRImage =[[UIImage alloc] init];
        QRImage = [QRCodeGenerator qrImageForString:qrLink imageSize:160];
        
        ProduceImage *pi = [[ProduceImage alloc] init];
        UIImage *newimg ;
        
        if(_isWeixin_share == YES)
        {
            newimg = [pi getImage:self.shareRandShopImage withQRCodeImage:QRImage withText:myType withPrice:[NSString stringWithFormat:@"%@",shop_price]];
        }else{
            newimg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",UPYHTTP,picUrl]]]];
        }
        
        _shareType = myType;
        _shareImage = newimg;
        
        
        if(_shareImage)
        {
            [MBProgressHUD hideHUDForView:self.view];
            [self performSelector:@selector(goshare) withObject:self afterDelay:0.1];
        }
        
    } else {
        
        NavgationbarView *nv = [[NavgationbarView alloc] init];
        [nv showLable:@"没有安装微信" Controller:self];
    }
}


- (void)DShareManagerStatus:(SHARESTATE)shareStatus withType:(NSString *)type
{
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    
    if ([type isEqualToString:DAILY_TASK_BUQIAN]||[type isEqualToString:DAILY_TASK_ZERO]||[type isEqualToString:DAILY_TASK_YOUHUI]||[type isEqualToString:DAILY_TASK_JIFEN]||[type isEqualToString:DAILY_TASK_XIANJING]||[type isEqualToString:DAILY_TASK_STORE]||[type isEqualToString:DAILY_TASK_DOUBLE])
    {
        if (shareStatus == 1) {//分享成功
            
            [nv showLable:@"分享成功" Controller:self];
            
            //分享成功后签到
            [self SignHttp:type];
            
        } else if (shareStatus == 2) {
            
            [nv showLable:@"分享失败" Controller:self];
            
            
        } else if (shareStatus == 3) {
            
            
            [nv showLable:@"分享取消" Controller:self];
            
        }
    }
}

#pragma mark 刷新主界面
- (void)refreshMainUI:(NSDictionary*)dic
{
    
    //余额
    CGFloat over = [dic[@"bCount"] floatValue];
    if ([DataManager sharedManager].isOligible&&[DataManager sharedManager].isOpen&&([DataManager sharedManager].twofoldness > 0)) {
        over *= [DataManager sharedManager].twofoldness;
    }
    NSString *bCount = [NSString stringWithFormat:@"%.1f",over];
    //积分
    NSString *iCount = [NSString stringWithFormat:@"%@",dic[@"iCount"]];
    //卡券
    NSString *cCount = [NSString stringWithFormat:@"%@",dic[@"cCount"]];
    //补签卡
    NSString *sCount = [NSString stringWithFormat:@"%@",dic[@"sCount"]];
    
    
    for(int j=0;j<3;j++)
    {
        UILabel *countlab = (UILabel*)[self.view viewWithTag:400000+j];
        if(j==0)
        {
            if(bCount)
            {
                countlab.text = bCount;
            }
        }else if (j==1)
        {
            if(iCount)
            {
                countlab.text = iCount;
            }

        }else if (j==2)
        {
            if(cCount)
            {
                countlab.text = cCount;
            }

        }
    }

    if(sCount.intValue >0)
    {
        _cornerlab.hidden = NO;
        _cornerlab.text = sCount;
    }
}

#pragma mark 刷新任务列表
- (void)refreshListUI
{
    CGFloat width = (CGRectGetWidth(_SignImageview.frame)-20)/5;

    CGFloat heigh = width+30;
    
    if(_MydataArray.count && _motaskList.count)
    {
        int xxxx=0;
        int yyyy=0;
        
        for(int j=0;j<_motaskList.count;j++)
        {
            
            MyLog(@"ID=%@",_motaskList[j]);
            NSString *strid = [NSString stringWithFormat:@"%@",_motaskList[j]];
            
            xxxx = j%5;
            yyyy = j/5;
            for(int i=0;i<_MydataArray.count;i++)
            {
                
                SignModel *model = _MydataArray[i];
                
                if([model.t_id isEqualToString:strid])
                {
                    
                    //小图片
                    
                    UIImageView *titltimage = (UIImageView*)[_SignImageview viewWithTag:60000+j];
                    titltimage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",model.t_name]];
                    if([model.t_name hasSuffix:@"积分"])
                    {
                        titltimage.image = [UIImage imageNamed:@"积分"];
                    }else if ([model.t_name hasSuffix:@"包邮"])
                    {
                        titltimage.image = [UIImage imageNamed:@"icon_baobei"];
                    }

                    //内容
                    
                    UILabel *titlelable = (UILabel*)[_SignImageview viewWithTag:70000+j];
                    titlelable.numberOfLines = 0;
                    titlelable.text = model.t_name;
                    titlelable.tag = 70000+j;
                    titlelable.textAlignment = NSTextAlignmentCenter;
                    titlelable.textColor = kTextColor;
                    titlelable.font = [UIFont systemFontOfSize:ZOOM(37)];
                    
                }
                
            }

        }
        
    }
    
}

#pragma mark 刷新任务状态图片
- (void)refreshStatueimage
{
    if(_finishtaskList.count==0)
    {
        for(int k =0;k<30;k++)
        {
            UIImageView *statueimage = (UIImageView*)[_SignImageview viewWithTag:80000+k];
            statueimage.image = [UIImage imageNamed:@""];
        }
        
        
    }
    
    for(int i =0;i<_finishtaskList.count;i++)
    {
        NSString *todaystatue = [self signImagestatue:i];
        MyLog(@"todaystatue = %@",todaystatue);
        
        UIImageView *statueimage = (UIImageView*)[_SignImageview viewWithTag:80000+i];
        
        switch (todaystatue.intValue) {
            case 1:
                statueimage.image = [UIImage imageNamed:@"yilingqu"];
                break;
            case 2:
                statueimage.image = [UIImage imageNamed:@"quqianggou"];
                break;
            case 3:
                statueimage.image = [UIImage imageNamed:@"yilingqu"];
                break;
            case 4:
                statueimage.image = [UIImage imageNamed:@"yilingqu"];
                break;
            case 5:
                statueimage.image = [UIImage imageNamed:@"yilingqu"];
                break;
            case 6:
                statueimage.image = [UIImage imageNamed:@"yikaidian"];
                break;
            case 7:
                statueimage.image = [UIImage imageNamed:@"yicanyu"];
                break;
            case 8:
                statueimage.image = [UIImage imageNamed:@"yilingqu"];
                break;
            case 20:
                statueimage.image = [UIImage imageNamed:@"yilingqu"];
                break;
            default:
                break;
        }
        
    }
    
    //今天的任务状态
    UIImageView *todaystatueimage = (UIImageView*)[_SignImageview viewWithTag:80000+_finishtaskList.count];
    
    NSString *todaystatue = [self signImagestatue:(int)_finishtaskList.count];
    
    MyLog(@"_signIn_status = %@",_signIn_status);
    
    if(_signIn_status.intValue == 0)//没签
    {
        switch (todaystatue.intValue) {
            case 1:
                todaystatueimage.image = [UIImage imageNamed:@"fenxianglingqu"];
                break;
            case 2:
                todaystatueimage.image = [UIImage imageNamed:@"fenxianglingqu"];
                break;
            case 3:
                todaystatueimage.image = [UIImage imageNamed:@"fenxianglingqu"];
                break;
            case 4:
                todaystatueimage.image = [UIImage imageNamed:@"fenxianglingqu"];
                break;
            case 5:
                todaystatueimage.image = [UIImage imageNamed:@"fenxianglingqu"];
                break;
            case 6:
                todaystatueimage.image = [UIImage imageNamed:@"kaidianlingqu"];
                break;
                
            case 7:
                todaystatueimage.image = [UIImage imageNamed:@"quduobao"];
                break;
                
            case 8:
                todaystatueimage.image = [UIImage imageNamed:@"fenxianglingqu"];
                break;
            case 20:
                todaystatueimage.image = [UIImage imageNamed:@"dianjilingqu"];
                break;

            default:
                break;
        }
        
    }else if (_signIn_status.intValue == 1)//已签到
    {

    }else if (_signIn_status.intValue == 2)//补签
    {
        todaystatueimage.image = [UIImage imageNamed:@"buqian"];
    }

    //已完成的任务停止抖动
    [self stopshake:(int)_finishtaskList.count-1];
}

#pragma mark 今天的任务状态
- (NSString*)signImagestatue:(int)intcount
{
    NSString *statuestr;
    
    //今天的任务id
    NSString *today_tid;
    NSString *today_type;
    if(_motaskList.count)
    {
        today_tid = [NSString stringWithFormat:@"%@",_motaskList[intcount]];
    }
    
    MyLog(@"today_tid=%@",today_tid);
    
    for(int i =0;i<_MydataArray.count;i++)
    {
        SignModel *model = _MydataArray[i];
        
        if([today_tid isEqualToString:[NSString stringWithFormat:@"%@",model.t_id]])
        {
            //任务类型
            NSString *typeid = [NSString stringWithFormat:@"%@",model.type_id];
            MyLog(@"typeid=%@",typeid);
            
            if(typeid.intValue ==1)//补签
            {
                statuestr = @"1";
            }else if (typeid.intValue ==2){//0元购
                statuestr = @"2";
            }else if (typeid.intValue ==3){//优惠券
                statuestr = @"3";
            }else if (typeid.intValue ==4){//积分
                statuestr = @"4";
            }else if (typeid.intValue ==5){//现金
                
                NSDictionary *dic = _motaskDataArray[intcount];
                NSString *type = dic[@"type"];
                
                if(type.intValue == 5)//强制浏览
                {
                     statuestr = @"20";
                    
                }else{//现金
                    statuestr = @"5";
                }
                
            }else if (typeid.intValue ==6){//开店
                statuestr = @"6";
            }else if (typeid.intValue ==7){//签到包邮
                statuestr = @"7";
            }else if (typeid.intValue ==8){//余额翻倍
                statuestr = @"8";
            }
        }
    }
    
    return  statuestr ;
}

#pragma mark 签到类型
- (NSString*)signtypestatue:(int)intcount
{
    NSString *statuestr;
    
    //今天的任务id
    NSString *today_tid;
    if(_motaskList.count)
    {
        today_tid = [NSString stringWithFormat:@"%@",_motaskList[intcount]];
    }
    
    MyLog(@"today_tid=%@",today_tid);
    
    for(int i =0;i<_MydataArray.count;i++)
    {
        SignModel *model = _MydataArray[i];
        
        if([today_tid isEqualToString:[NSString stringWithFormat:@"%@",model.t_id]])
        {
            //任务类型
            NSString *typeid = [NSString stringWithFormat:@"%@",model.type_id];
            NSString *value = [NSString stringWithFormat:@"%@",model.value];
            MyLog(@"typeid=%@",value);
            
            if(typeid.intValue ==1)//补签
            {
                statuestr = value;
            }else if (typeid.intValue ==2){//0元购
                statuestr = value;
            }else if (typeid.intValue ==3){//优惠券
                statuestr = value;
            }else if (typeid.intValue ==4){//积分
                statuestr = value;
            }else if (typeid.intValue ==5){//现金
                statuestr = value;
            }else if (typeid.intValue ==6){//开店
                statuestr = value;
            }else if (typeid.intValue ==7){//签到包邮
                statuestr = value;
            }else if (typeid.intValue ==8){//余额翻倍
                statuestr = value;
            }
        }
    }
    
    return  statuestr ;
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"QiandaoPage"];
    
    UIView *backview = (UIView*)[self.view viewWithTag:9797];
    
    if(_shareModelview)
    {
        
        
        [backview removeFromSuperview];
        
        
        [UIView animateWithDuration:0.3 animations:^{
            
            _shareModelview.frame=CGRectMake(0, kApplicationHeight+30, kApplicationWidth, SHAREMODELHEIGH);
            
        } completion:^(BOOL finished) {
            
            
            [_shareModelview removeFromSuperview];
        }];
        
    }else{
        
        [backview removeFromSuperview];
    }
    
    MyLog(@"fjsfj");
    
    [_mytimer invalidate];
    [RemindView removeFromSuperview];
}

#pragma mark ********uialterviewdelegate******
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        MyLog(@"去绑定手机");
        TFOldPaymentViewController *tovc = [[TFOldPaymentViewController alloc] init];
        tovc.headTitle = @"绑定手机";
        tovc.leftStr = @"手机号码";
        tovc.plaStr = @"输入您要绑定的手机号";
        tovc.index = 1;
        tovc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tovc animated:YES];
        
    }
}

#pragma mark 微信授权
- (void)shareSdkWithAutohorWithTypeGetOpenID
{
    
    //向微信注册
//    [WXApi registerApp:@"wx8c5fe3e40669c535" withDescription:@"demo 2.0"];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate shardk];
    
    // 取消授权
    [ShareSDK cancelAuthWithType:ShareTypeWeixiFav];
    
    // 开始授权
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    id<ISSQZoneApp> app =(id<ISSQZoneApp>)[ShareSDK getClientWithType:ShareTypeQQSpace];
    [app setIsAllowWebAuthorize:YES];
    
    [ShareSDK getUserInfoWithType:ShareTypeWeixiFav
                      authOptions:authOptions
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                               if (result)
                               {
                                   
                                   //uid = %@", [userInfo uid]);
                                   //sourceData = %@", [userInfo sourceData]);
                                   //extInfo = %@", [[userInfo credential] extInfo]);
                                   
                                   NSDictionary *uniondic = (NSDictionary *)[userInfo sourceData];
                                   
                                   //unionid = %@",uniondic[@"unionid"]);
                                   
                                   if(uniondic[@"unionid"] !=nil)
                                   {
                                       
                                       //上传unionid给后台
                                       [self saveHttp:uniondic[@"unionid"]];

                                   }
                                   
                                   
                               }
                               
                               
                               NSString *errorStr = [NSString stringWithFormat:@"%@", [error errorDescription]];
                               MyLog(@"errorStr = %@",errorStr);
                               
                               if ([errorStr isEqualToString:@"尚未授权"]) {
                                   
                                   //失败,错误码:%ld,错误描述%@",(long)[error errorCode],[error errorDescription]);
                                   
                               }else if (errorStr == nil)//授权成功
                               {
                               
                               }
                               
                           }];
    
}




#pragma mark *************通知方法****************

- (void)liulansharesuccess:(NSNotification*)note
{
    [self creatFinishPopview:DAILY_TASK_XIANJING];
}
- (void)paysuccess:(NSNotification*)note
{
    [_SharePopview removeFromSuperview];
    
    
    if([_selectshop_type isEqualToString:@"包邮"])
    {
        if(!_SharePopview)
        {
            [self creatFinishPopview:DAILY_TASK_BAOYOU];
        }
        
    }else if ([_selectshop_type isEqualToString:@"夺宝"]){
        

        
        [self getincode];
    }
    
    //刷新数据
    [self creatData];

}


- (void)buyfail:(NSNotification*)note
{
    MyLog(@"支付失败");
}


#pragma mark ***********余额翻倍倒计时***************
-(void)setRemindView
{
    [_mytimer invalidate];
    _mytimer = nil;
    
    _timeCount = 0;
    _mytimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    
    RemindView=[[TopRemindView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, ZOOM6(60))];
    
    if([DataManager sharedManager].isOpen == YES)
    {
        RemindView.RemindBtn.selected = YES;
    }else{
        RemindView.RemindBtn.selected = NO;
    }
    
    __weak typeof(self) weakSelf = self;
    RemindView.RemindBtnBlock=^{
        
        [weakSelf doubleSuccessEntrance:2];
        
    };
    [self.view addSubview:RemindView];
}

- (void)doubleSuccessEntrance:(int)entrance
{
    if(RemindView.RemindBtn.selected == NO)
    {
        [DoubleModel getDoubleEntrance:entrance Sucess:^(id data) {
            DoubleModel *model = data;
            if(model.status == 1)
            {
                MyLog(@"开启成功");
                RemindView.RemindBtn.selected=YES;
                [DataManager sharedManager].isOpen = YES;
                
                YFDoubleSucessVC *vc = [[YFDoubleSucessVC alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                
            }else{
                MyLog(@"开启失败");
                RemindView.RemindBtn.selected=NO;
                [DataManager sharedManager].isOpen = NO;
                
            }
        }];
    }
    
}

#pragma mark 倒计时
- (void)timerFireMethod:(NSTimer*)timer
{
    NSString *nowtime = timer.userInfo;
    
    if(nowtime !=nil)
    {
        _timeCount ++;
    }
    
    NSString *endtime = [NSString stringWithFormat:@"%lld",[DataManager sharedManager].endDate];
    
    NSArray*timeArray= [MyMD5 timeCountDown:_mytimer Nowtime:nowtime Endtime:endtime Count:_timeCount];
    
    NSString *timestr;
    if(timeArray.count)
    {
       
        if([timeArray[0] intValue]==0&&[timeArray[1] intValue]==0
           &&[timeArray[2] intValue]==0&&[timeArray[3] intValue]==0)
        {
            [self requestHttp];
            timestr = [NSString stringWithFormat:@"距余额翻倍结束还剩: %@ 时 %@ 分 %@ 秒",@"0",@"0",@"0"];
            
            [DataManager sharedManager].isOligible = NO;
            
            RemindView.hidden = YES;
        }else{
            timestr = [NSString stringWithFormat:@"距余额翻倍结束还剩: %@ 时 %@ 分 %@ 秒",timeArray[1],timeArray[2],timeArray[3]];
        }
    }
    
    _storetimelable.text = timestr;
    _timelable.text = timestr;
    RemindView.RemindLabel.text = timestr;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
