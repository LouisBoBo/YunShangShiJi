//
//  PersonHomepageViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/6/26.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "PersonHomepageViewController.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "NavgationbarView.h"
#import "MyMD5.h"
#import "UIImageView+WebCache.h"
#import "FunsViewController.h"
#import "AttentionViewController.h"
#import "InvitationViewController.h"
#import "ForumModel.h"
#import "CollectTableViewCell.h"
#import "SmileView.h"
//#import "ChatViewController.h"
#import "RobotManager.h"
#import "LoginViewController.h"
#import "TFLoginView.h"


@interface PersonHomepageViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    ForumModel *_fornmModel;
    NSString* _isNo;
    UITableView *_myTableView;
    UIScrollView *_profileView;
    NSMutableArray *_UserNewsArray;
    SmileView *_smileView;

    NSArray *provinces, *cities, *areas, *strees;
    
    BOOL _isFocusSuccess;
    
    //记录粉丝数量
    int _funs_count;
    
}
@end

@implementation PersonHomepageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _UserNewsArray = [NSMutableArray array];
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
//    //
    [self.headView addSubview:headview];
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
    titlelable.text=@"个人主页";
    titlelable.textColor=[UIColor whiteColor];
    titlelable.font = [UIFont systemFontOfSize:ZOOM(57)];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    _smileView = [[SmileView alloc]init];
    [_smileView drawRect:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight-350)];
    
    self.bgImg.image = [UIImage imageNamed:@"圈圈背景图.jpg"];
    
    self.headimage.clipsToBounds = YES;
    self.headimage.layer.cornerRadius = self.headimage.frame.size.height / 2;
    
    
    
    [self creatDynamicView];
    [self creatFootView];
    [self creatView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    Myview.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    Myview.hidden=NO;
}

#pragma mark 个人主页网络请求
-(void)requestHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    
    if(token !=nil)
    {
        url=[NSString stringWithFormat:@"%@userFans/home?version=%@&token=%@&user_id=%@",[NSObject baseURLStr],VERSION,token,self.userid];
    }else{
        url=[NSString stringWithFormat:@"%@userFans/homeUnLogin?version=%@&user_id=%@",[NSObject baseURLStr],VERSION,self.userid];
    }
    
    
    //-------%@",self.userid);
//    url=[NSString stringWithFormat:@"%@userFans/home?version=V1.0&token=%@&user_id=%@",[NSObject baseURLStr],token,@"210"];
    
    NSString *URL=[MyMD5 authkey:url];
//    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [MBProgressHUD hideHUDForView:self.view];
         [[Animation shareAnimation] stopAnimationAt:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            _isNo = responseObject[@"isNo"];
            if(statu.intValue==1)//请求成功
            {
                NSDictionary *dic=responseObject[@"home_info"];
                
                if ([dic isKindOfClass:[NSNull class]]) {
                    NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                    [mentionview showLable:@"找不到这个人" Controller:self];
                    
                    
                    
                    return;
                }
                ForumModel *model=[[ForumModel alloc]init];
                model.birthday=[NSString stringWithFormat:@"%@",dic[@"birthday"]];
                model.circle_count=[NSString stringWithFormat:@"%@",dic[@"circle_count"]];
                model.fans_count=[NSString stringWithFormat:@"%@",dic[@"fans_count"]];
                model.fol_user_id=[NSString stringWithFormat:@"%@",dic[@"fol_user_id"]];
                model.hobby=[NSString stringWithFormat:@"%@",dic[@"hobby"]];
                model.ID=[NSString stringWithFormat:@"%@",dic[@"id"]];
                model.nickname=[NSString stringWithFormat:@"%@",dic[@"nickname"]];
                model.person_sign=[NSString stringWithFormat:@"%@",dic[@"person_sign"]];
                model.pic=[NSString stringWithFormat:@"%@",dic[@"pic"]];
                model.user_id=[NSString stringWithFormat:@"%@",dic[@"user_id"]];
                model.province = [NSString stringWithFormat:@"%@",dic[@"province"]];
                model.city =[NSString stringWithFormat:@"%@", dic[@"city"]];
                
                if ([dic[@"birthday"] isEqual:[NSNull null]]) {
                    model.birthday=@"";
                }
                if ([dic[@"person_sign"] isEqual:[NSNull null]]) {
                    model.person_sign=@"";
                }
                _fornmModel=model;
                
                
                
                //            [self creatView];
                [self reloadData];
                
            }
            else if(statu.intValue == 10030){//没登录状态
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud removeObjectForKey:USER_TOKEN];
                LoginViewController *login=[[LoginViewController alloc]init];
                
                login.tag=1000;
                login.loginStatue = @"10030";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
                
            }
            
            else{
                
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:message Controller:self];
                
            }
            

        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        [MBProgressHUD hideHUDForView:self.view];
         [[Animation shareAnimation] stopAnimationAt:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
        
    }];
    


}
-(void)reloadData
{
//    _myTableView.hidden = YES;
//    _profileView.hidden = NO;
    
    
    NSString *pic;
    if(self.forumModel.pic !=nil)
    {
        pic=self.forumModel.pic;
    }else{
        pic=self.forumModel.upic;
    }
    
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    [userdefaul setObject:pic forKey:SEND_HEADPIC];
    
    
    self.headimage.center=CGPointMake(kApplicationWidth/2, 64+55);
    self.headimage.clipsToBounds=YES;
    self.headimage.layer.borderWidth = 2;
    self.headimage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headimage.layer.cornerRadius=self.headimage.frame.size.width/2;
    
//    [self.headimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],pic]] placeholderImage:[UIImage imageNamed:@"默认头像.jpg"]];
    
//    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
//    NSString *User_id = [ud objectForKey:USER_ID];
//    NSString *aPath=[NSString stringWithFormat:@"%@/Documents/headImgae%@.png",NSHomeDirectory(),User_id];
//    UIImage *imgFromUrl=[[UIImage alloc]initWithContentsOfFile:aPath];
//    if (imgFromUrl!=nil) { //判断用户是否登陆
//        self.headimage.image = imgFromUrl;
//    } else {
//        self.headimage.image = [UIImage imageNamed:@"默认头像.jpg"];
//    }


    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_Upy],pic]];
    if ([pic hasPrefix:@"http://"]) {
        imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",pic]];
    }
//    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],pic]];
//    if(imgUrl)
//    {
//        [self.headimage sd_setImageWithURL:imgUrl];
//        
//    }
    
#if 1
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [self.headimage sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
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
    
#endif
    
    self.username.frame=CGRectMake((kApplicationWidth-200)/2, self.headimage.frame.origin.y+self.headimage.frame.size.height+10, 200, 20);
    self.username.text=self.forumModel.nickname;
    self.username.font = [UIFont systemFontOfSize:ZOOM(50)];
    
    self.attention.text=[NSString stringWithFormat:@"关注:%@",_fornmModel.circle_count];
    self.attention.font = [UIFont systemFontOfSize:ZOOM(48)];
    
    self.funs.text=[NSString stringWithFormat:@"粉丝:%@",_fornmModel.fans_count];
    
    _funs_count = [_fornmModel.fans_count intValue];
    
    self.funs.font=[UIFont systemFontOfSize:ZOOM(48)];

    UIButton *btn = (UIButton *)[self.view viewWithTag:3001];
    if (_isNo.intValue==1  ) {

        _isFocusSuccess = YES;
        [btn setTitle:@"取消关注" forState:UIControlStateNormal];
    } else {
        
        _isFocusSuccess = NO;
        [btn setTitle:@"关注" forState:UIControlStateNormal];
    }

    
    //查询地址ID
    provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"areatbl.plist" ofType:nil]];
    
    cities = [[provinces objectAtIndex:0] objectForKey:@"cities"];
    
    NSString *provincesid=[NSString stringWithFormat:@"%@",_fornmModel.province];
    NSString *citiesid=[NSString stringWithFormat:@"%@",_fornmModel.city];

    NSMutableString *areastr =[[NSMutableString alloc]init];
    
    for(NSDictionary *dic in provinces)
    {
        NSString *ID=[NSString stringWithFormat:@"%@",dic[@"id"]];
        if([ID isEqualToString:provincesid] )
        {
            //dic is %@",dic[@"state"]);
            
            [areastr appendString:dic[@"state"]];
            
            cities=dic[@"cities"];
            for (NSDictionary *dic1 in cities) {
                NSString *ID1=[NSString stringWithFormat:@"%@",dic1[@"id"]];
                if([ID1 isEqualToString:citiesid])
                {
                    //dic is %@",dic1[@"city"]);
                    
                    [areastr appendString:dic1[@"city"]];
                    
                    areas=dic1[@"areas"];
                    for(NSDictionary *dic2 in areas)
                    {
                        NSString *ID2=[NSString stringWithFormat:@"%@",dic2[@"id"]];
                        
                    }
                }
            }
        }
    }
    

    for(int i=0; i<3;i++)
    {
        UILabel *label = (UILabel *)[self.view viewWithTag:4000+i];
        NSString *str = [NSString stringWithFormat:@"%@",_fornmModel.person_sign];
                switch (i) {
                    case 0:
                        label.text=areastr;
                        break;
                    case 1: {
                        NSString *timeString = [NSString stringWithFormat:@"%lf",[_fornmModel.birthday doubleValue]/1000];
                        NSString *time =[self timeInfoWithDateString:timeString];
                        
                        if(time !=nil && ![time hasPrefix:@"1970"])
                        {
                            label.text= time;
                        }
                    }
                        break;
                    case 2:
                        
                        if(![[NSString stringWithFormat:@"%@",_fornmModel.person_sign] isEqualToString:@"<null>"])
                        {
                            label.text=_fornmModel.person_sign;
                        }
                        
                        break;
                        
                    default:
                        break;
                }
    }
    
    
}

- (NSString *)timeInfoWithDateString:(NSString *)timeString
{
    NSDate *oldDate = [NSDate dateWithTimeIntervalSince1970:[timeString longLongValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    NSString *showtimeNew = [formatter stringFromDate:oldDate];
    
    return [NSString stringWithFormat:@"%@",[showtimeNew substringToIndex:11]];

}
    
-(void)creatFootView
{
    UIView *footview=[[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight-50+kUnderStatusBarStartY, kApplicationHeight, 50)];
    footview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:footview];
    
    UILabel *linelable = [[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth/2, 10, 1, 30)];
    linelable.backgroundColor = kBackgroundColor;
    [footview addSubview:linelable];
    
    UIView *topline = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    topline.backgroundColor=kBackgroundColor;
    [footview addSubview:topline];
    
    NSArray *brr=@[@"发消息",@"关注"];
    for(int i=0;i<brr.count;i++)
    {
        UIButton *button=[[UIButton alloc]init];
        button.frame=CGRectMake(0+(kApplicationWidth/2+1)*i, 15, kApplicationWidth/2-1, 20);
        [button setTitle:brr[i] forState:UIControlStateNormal];
        if (i==0) {
            [button setImage:[UIImage imageNamed:@"发消息"] forState:UIControlStateNormal];
        } else {
            [button setImage:[UIImage imageNamed:@"关注"] forState:UIControlStateNormal];

//            [button setTitle:@"取消关注" forState:UIControlStateSelected];
            
        }
        button.backgroundColor = [UIColor whiteColor];
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [button setTitleColor:tarbarrossred forState:UIControlStateNormal];
        [button setTitleColor:tarbarrossred forState:UIControlStateSelected];
        button.tag = 3000+i;
        
//        button.backgroundColor = COLOR_RANDOM;
        
        [footview addSubview:button];
        
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)creatView
{
    
    self.profileBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(57)];
    self.dynamicBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(57)];
    
    NSArray *arr=@[@"地区:",@"生日:",@"个性签名:"];
    
    _profileView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 290, kApplicationWidth, kApplicationHeight-310)];
    
    _profileView.contentSize = CGSizeMake(kApplicationWidth,60*arr.count);
    
    [self.view addSubview:_profileView];
    

    
    CGFloat height =60;
    for(int i=0; i<arr.count;i++)
    {
        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62),height*i, 100, height)];
        lable.text=arr[i];
        lable.font=[UIFont systemFontOfSize:ZOOM(51)];
        lable.textAlignment=NSTextAlignmentLeft;
        

        [_profileView addSubview:lable];
        
        UILabel *conlable=[[UILabel alloc]initWithFrame:CGRectMake(120, height*i, kApplicationWidth-140, height)];
        
        if(i==0)
        {
            conlable.frame =CGRectMake(120, height*i, kApplicationWidth-140, height);
            
        }else if (i==1)
        {
            conlable.frame =CGRectMake(80, height*i, kApplicationWidth-140, height);
        }else if (i==2)
        {
            conlable.frame =CGRectMake(120, height*i, kApplicationWidth-140, height);
            
        }
        conlable.numberOfLines = 0;
        conlable.font=[UIFont systemFontOfSize:ZOOM(51)];
        conlable.tag = 4000+i;
        conlable.textColor=kTextColor;
        conlable.textAlignment=NSTextAlignmentLeft;

        [_profileView addSubview:conlable];
        
        
        if(i<arr.count)
        {
            UILabel *linelable=[[UILabel alloc]initWithFrame:CGRectMake(0, height*(i+1), kApplicationWidth, 1)];
            linelable.backgroundColor=lineGreyColor;
            [_profileView addSubview:linelable];
        }
    }
    
    [self requestHttp];


}
-(void)creatDynamicView
{
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 290, kApplicationWidth, kApplicationHeight-310) style:UITableViewStylePlain];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    _myTableView.rowHeight = 100;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;


//    _myTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    [self.view addSubview:_myTableView];
    [_myTableView registerNib:[UINib nibWithNibName:@"CollectTableViewCell" bundle:nil] forCellReuseIdentifier:@"CollectCell" ];

}
-(void)click:(UIButton*)sender
{
    NSUserDefaults *userdefaul =[NSUserDefaults standardUserDefaults];
    NSString *token = [userdefaul objectForKey:USER_TOKEN];
    if(token == nil)
    {
        [self ToLoginView];
        
        return;
    }
    
    if(sender.tag==3001)//关注
    {
        if(_isFocusSuccess==NO)
        {
            [self attentionHttp:sender.tag];
        
        } else{
            [self CancelattentionHttp:sender.tag];
      
        }
    }else{
    
        if(_fornmModel)
        {
            NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
            NSString *userid =[NSString stringWithFormat:@"%@",[userdefaul objectForKey:USER_ID]];
            
            
            MyLog(@"userid = %@ self.userid=%@",userid,self.userid);
            
            if([userid isEqualToString:[NSString stringWithFormat:@"%@",self.userid]])
            {
            
                NavgationbarView *mentionview = [[NavgationbarView alloc]init];
                [mentionview showLable:@"亲！不能和自己聊天。" Controller:self];
            }else{
                [self Message];
            }
            
            
        }else{
            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
            [mentionview showLable:@"系统异常稍后重试！" Controller:self];
        }
        
    }
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


#pragma mark 聊天
-(void)Message
{
    NSString *title= _fornmModel.nickname;
    NSString *chatter = [NSString stringWithFormat:@"%@",_fornmModel.user_id];
    // begin 赵官林 2016.5.26
    [self messageWithSuppid:chatter title:title model:nil detailType:nil imageurl:nil];
    // end
}
#pragma mark 网络请求发帐号记录
-(void)requestSubmitHttp
{
    [_UserNewsArray removeAllObjects];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    
    if (token!=nil) {
        url = [NSString stringWithFormat:@"%@circle/queryUserNewsList?version=%@&token=%@&user_id=%@&bool=false",[NSObject baseURLStr],VERSION,token,self.userid];
    } else {
        url = [NSString stringWithFormat:@"%@circle/qDynamicUnLogin?version=%@&token=%@&user_id=%@&bool=false",[NSObject baseURLStr],VERSION,token,self.userid];
    }
    

    
    NSString *URL=[MyMD5 authkey:url];
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [MBProgressHUD hideHUDForView:self.view];
         [[Animation shareAnimation] stopAnimationAt:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message;
            
            if(statu.intValue==1)//请求成功
            {
                
                for(NSDictionary *dic in responseObject[@"news"])
                {
                    ForumModel *model=[[ForumModel alloc]init];
                    model.circle_id=dic[@"circle_id"];
                    model.fine=dic[@"fine"];
                    model.hot=dic[@"hot"];
                    model.news_id=dic[@"news_id"];
                    model.nickname=dic[@"nickname"];
                    model.pic=dic[@"pic"];
                    model.pic_list=dic[@"pic_list"];
                    model.send_time=dic[@"send_time"];
                    model.title=dic[@"title"];
                    model.user_id=dic[@"user_id"];
                    
                    [_UserNewsArray addObject:model];
                }
                if (_UserNewsArray.count == 0) {
                    
                    _smileView.str = @"O(n_n)O~亲~";
                    _smileView.str2 = @"还没有发布动态哦!";
                    _myTableView.tableFooterView = _smileView;
                }
                
                [_myTableView reloadData];
                
            }else{
                
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
        }
        
  
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        [MBProgressHUD hideHUDForView:self.view];
         [[Animation shareAnimation] stopAnimationAt:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
        
    }];
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ForumModel *model=_UserNewsArray[indexPath.row];
    
    InvitationViewController *invitation=[[InvitationViewController alloc]init];
    invitation.circle_id=[NSString stringWithFormat:@"%@",model.circle_id];
    invitation.model=model;
    [self.navigationController pushViewController:invitation animated:YES];
}
#pragma mark------------------------------UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _UserNewsArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CollectCell"];
    if(!cell)
    {
        cell=[[CollectTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CollectCell"];
    }
    cell.selectbtn.hidden = YES;
    ForumModel *model=_UserNewsArray[indexPath.row];
    
    
//    [cell.titleimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.upic]] placeholderImage:[UIImage imageNamed:@"默认头像.jpg"]];
    
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_Upy],model.pic]];
    if ([model.pic hasPrefix:@"http://"]) {
        imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.pic]];
    }
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [cell.titleimage sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"默认头像.jpg"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d = (float)receivedSize/expectedSize;
        isDownlaod = YES;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod == YES) {
            cell.titleimage.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                cell.titleimage.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        } else if (image != nil && isDownlaod == NO) {
            cell.titleimage.image = image;
        }
    }];
    
    cell.titleimage.clipsToBounds=YES;
    cell.titleimage.layer.cornerRadius=cell.titleimage.frame.size.width/2;
    
    cell.title.text=model.nickname;
    cell.title.font = [UIFont systemFontOfSize:ZOOM(51)];
    cell.title.textColor = kTitleColor;
    
    if(model.pic_list == nil || model.pic_list.length == 0)
    {
//        [cell.headimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.npic]]placeholderImage:[UIImage imageNamed:@"默认头像.jpg"]];
        
       
        NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.pic]];

        if ([model.pic hasPrefix:@"http://"]) {
            imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.pic]];
        }
        __block float d = 0;
        __block BOOL isDownlaod = NO;
        [cell.headimage sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"默认头像.jpg"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            d = (float)receivedSize/expectedSize;
            isDownlaod = YES;
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image != nil && isDownlaod == YES) {
                cell.headimage.alpha = 0;
                [UIView animateWithDuration:0.5 animations:^{
                    cell.headimage.alpha = 1;
                } completion:^(BOOL finished) {
                }];
            } else if (image != nil && isDownlaod == NO) {
                cell.headimage.image = image;
            }
        }];
        
        cell.headimage.hidden = YES;
        
        cell.content.frame = CGRectMake(cell.headimage.frame.origin.x, cell.content.frame.origin.y, cell.headimage.frame.size.width + cell.content.frame.size.width, cell.content.frame.size.height);
        
    }else{
        NSArray *piclist=[model.pic_list componentsSeparatedByString:@","];
        if(piclist.count)
        {
            
            cell.headimage.hidden = NO;
            
            cell.content.frame = CGRectMake(50 , cell.content.frame.origin.y, cell.content.frame.size.width, cell.content.frame.size.height);

            
            NSArray *imagearray = [piclist[0] componentsSeparatedByString:@":"];
            
            NSString *imageurl ;
            if(imagearray.count == 2)
            {
                imageurl = imagearray[0];
            }
            
            NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_Upy],imageurl]];
            if ([imageurl hasPrefix:@"http://"]) {
                imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",imageurl]];
            }
            
            __block float d = 0;
            __block BOOL isDownlaod = NO;
            [cell.headimage sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"默认头像.jpg"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                d = (float)receivedSize/expectedSize;
                isDownlaod = YES;
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image != nil && isDownlaod == YES) {
                    cell.headimage.alpha = 0;
                    [UIView animateWithDuration:0.5 animations:^{
                        cell.headimage.alpha = 1;
                    } completion:^(BOOL finished) {
                    }];
                } else if (image != nil && isDownlaod == NO) {
                    cell.headimage.image = image;
                }
            }];
            
        }
    }
    cell.content.text=model.title;
    cell.content.font = [UIFont systemFontOfSize:ZOOM(44)];
    cell.content.textColor = kTextColor;
    return cell;
}

#pragma mark 关注
-(void)attentionHttp:(NSInteger)tag
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    url=[NSString stringWithFormat:@"%@userFans/add?version=%@&token=%@&fol_user_id=%@",[NSObject baseURLStr],VERSION,token,self.userid];
    
    NSString *URL=[MyMD5 authkey:url];
//    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [MBProgressHUD hideHUDForView:self.view];
         [[Animation shareAnimation] stopAnimationAt:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(statu.intValue==1)//请求成功
            {
                message=@"关注成功";
                
                UIButton *button=(UIButton*)[self.view viewWithTag:tag];
                [button setTitle:@"取消关注" forState:UIControlStateNormal];
                
                _isFocusSuccess = YES;
                
                _funs_count = _funs_count + 1;
                
                self.funs.text=[NSString stringWithFormat:@"粉丝:%d",_funs_count];
                
            }else{
                
                //            message=@"关注失败";
                
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        [MBProgressHUD hideHUDForView:self.view];
         [[Animation shareAnimation] stopAnimationAt:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
        
    }];
    


}

#pragma mark 取消关注
-(void)CancelattentionHttp:(NSInteger)tag
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    url=[NSString stringWithFormat:@"%@userFans/del?version=%@&token=%@&fol_user_id=%@",[NSObject baseURLStr],VERSION,token,self.userid];
    
    NSString *URL=[MyMD5 authkey:url];
//    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [MBProgressHUD hideHUDForView:self.view];
         [[Animation shareAnimation] stopAnimationAt:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(statu.intValue==1)//请求成功
            {
                message=@"取消关注成功";
                
                UIButton *button=(UIButton*)[self.view viewWithTag:tag];

                [button setTitle:@"关注" forState:UIControlStateNormal];
                
                _isFocusSuccess = NO;
                
                 _funs_count = _funs_count - 1;
                
                self.funs.text=[NSString stringWithFormat:@"粉丝:%d",_funs_count];
                
            } else{
                
                message=@"取消关注失败";
                
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
            

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        [MBProgressHUD hideHUDForView:self.view];
         [[Animation shareAnimation] stopAnimationAt:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
        
    }];
    

}

//-(void)attentionclick:(UITapGestureRecognizer*)tap
//{
//    //关注");
//    AttentionViewController *attention=[[AttentionViewController alloc]init];
//    attention.userid=self.userid;
//    [self.navigationController pushViewController:attention animated:YES];
//    
//}
//
//-(void)funsclick:(UITapGestureRecognizer*)tap
//{
//    //粉丝");
//    FunsViewController *funs=[[FunsViewController alloc]init];
//    funs.userid=self.userid;
//    [self.navigationController pushViewController:funs animated:YES];
//}
/**
 *  关注列表
 */
- (IBAction)attentionClick:(UIButton *)sender {
    AttentionViewController *attention=[[AttentionViewController alloc]init];
    attention.userid=self.userid;
    [self.navigationController pushViewController:attention animated:YES];

}
/**
 *  粉丝列表
 */
- (IBAction)funsClick:(UIButton *)sender {
    FunsViewController *funs=[[FunsViewController alloc]init];
    funs.userid=self.userid;
    [self.navigationController pushViewController:funs animated:YES];

}
/**
 *  资料界面
 */
- (IBAction)profileClick:(UIButton *)sender {
    
    _myTableView.hidden=YES;
    _profileView.hidden=NO;
    
    _profileBtn.selected = !_profileBtn.selected;
    _dynamicBtn.selected = !_dynamicBtn.selected;
    _profileBtn.userInteractionEnabled=NO;
    _dynamicBtn.userInteractionEnabled=YES;
    
//    [self creatView];
}
/**
 *  动态界面
 */
- (IBAction)dynamicClick:(UIButton *)sender {

    _profileBtn.selected = !_profileBtn.selected;
    _dynamicBtn.selected = !_dynamicBtn.selected;
    _dynamicBtn.userInteractionEnabled=NO;
    _profileBtn.userInteractionEnabled=YES;
    
    _profileView.hidden = YES;
    _myTableView.hidden = NO;

    [self requestSubmitHttp];
}
-(void)back:(UIButton*)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
