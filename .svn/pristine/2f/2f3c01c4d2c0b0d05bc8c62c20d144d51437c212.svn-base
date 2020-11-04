//
//  PostViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/23.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "PostViewController.h"
#import "PostTableViewCell.h"
#import "InvitationViewController.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "NavgationbarView.h"
#import "MyMD5.h"
#import "ForumModel.h"
#import "UIImageView+WebCache.h"
#import "CircledetailViewController.h"
#import "SubmitTopicViewController.h"
#import "DoImagePickerController.h"
#import "topTableViewCell.h"
#import "LoginViewController.h"
#import "MJRefresh.h"

#import "TFLoginView.h"
#import "SmileView.h"

@interface PostViewController ()<DoImagePickerControllerDelegate,submitDelegate>

@end

@implementation PostViewController
{
    
    UIImageView *_imageView;
    //个人头像
    UIImageView *_headImage;
    //管理员
    UILabel *_admin;
    //帖子总数
    UILabel *_dresslable;
    //用户总数
    UILabel *_liulan;
    //圈名
    UILabel *lable;
    
    UIImageView *_headview;
    //评论列表
    UITableView *_MytableView;
    //评论数据源
    NSMutableArray *_dataArray;
    //圈成员数据源
    NSMutableArray *_memberArray;
    //圈管理员数据源
    NSMutableArray *_adminisArray;
    //圈精华数据源
    NSMutableArray *_creamArray;
    //列表顶置数据源
    NSMutableArray *_headArrray;
    //圈子相关内容
    ForumModel *_circleModel;
    
    //圈子的总帖数
    NSString *_n_count;
    
    //圈子的总人数
    NSString *_u_count;
    
    //圈子总对话数
    NSString *rn_count;
    //记录是否第一次进来
    BOOL _isfirst;
    //圈子标签tag
    NSMutableArray *_allTagArray;
    
    UIButton *_addbtn;
    
    UIImageView *_dressImgView;
    
    UIImageView *_liulanImgView;
    
    UIView *_backview;
    
    int _index;
    
    int _currentpage;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //解决界面交叉
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    _dataArray=[NSMutableArray array];
    _memberArray=[NSMutableArray array];
    _adminisArray=[NSMutableArray array];
    _creamArray=[NSMutableArray array];
    _headArrray=[NSMutableArray array];
    _allTagArray=[NSMutableArray array];
    
    _isfirst=YES;
    //导航条
    
    _headview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
//    headview.image=[UIImage imageNamed:@"背景图"];
    _headview.backgroundColor=tarbarrossred;
    [self.view addSubview:_headview];
    _headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(_headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [_headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, 42);
    titlelable.text=@"帖子列表";
    titlelable.font = [UIFont systemFontOfSize:ZOOM(57)];
    
    titlelable.textColor=[UIColor whiteColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [_headview addSubview:titlelable];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kApplicationWidth-25-ZOOM(50), ZOOM(89), 25, 25)];
    imageView.centerY = View_CenterY(_headview);
    imageView.image = [UIImage imageNamed:@"发帖"];
    [_headview addSubview:imageView];
    
    UIButton *setting=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    setting.frame=CGRectMake(kApplicationWidth-50, 25, 50, 30);
    setting.centerY = View_CenterY(_headview);
//    [setting setTitle:@"编辑" forState:UIControlStateNormal];
    //setting.tintColor=[UIColor whiteColor];
    [setting addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    [_headview addSubview:setting];

    [self creatHeadView];
    
    [self creatTableview];
    
    _currentpage=1;
    [self requestHttp];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commentSuccess:) name:@"commentSuccess" object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(submitSuccess:) name:@"submitSuccess" object:nil];
    
}

-(void)viewDidAppear:(BOOL)animated
{
//    _currentpage=1;
//    for(int i=0;i<3;i++)
//    {
//        UIButton *btn=(UIButton*)[self.view viewWithTag:1000+i];
//        if (btn.selected ==YES) {
//            if (btn.tag == 1000) {
//                
//                [self requestHttp];
//            }else if (btn.tag == 1001)
//            {
//                
//                [self BoutiqueHttp ];
//            }else if (btn.tag == 1002)
//            {
//                
//                [self HotHttp];
//            }
//        }
//    }

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
}

#pragma mark 网络请求
-(void)requestHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    if(token!=nil){
        url=[NSString stringWithFormat:@"%@circle/queryList?version=%@&token=%@&circle_id=%@&queryCircle=true&pager.curPage=%d",[NSObject baseURLStr],VERSION,token,self.circle_id,_currentpage];
    }else
        url=[NSString stringWithFormat:@"%@circle/queryLUnLogin?version=%@&circle_id=%@&queryCircle=true&pager.curPage=%d",[NSObject baseURLStr],VERSION,self.circle_id,_currentpage];

    NSString *URL=[MyMD5 authkey:url];

//    [[Animation shareAnimation] CreateAnimationAt:self.view];
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {

        [MBProgressHUD hideHUDForView:self.view];
         [[Animation shareAnimation] stopAnimationAt:self.view];
        if (_currentpage==1) {
            [_dataArray removeAllObjects];
            [_headArrray removeAllObjects];
            [_adminisArray removeAllObjects];
        }

//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            
            self.isNO = [NSString stringWithFormat:@"%@",responseObject[@"isNo"]];
            
            if(statu.intValue==1)//请求成功
            {
                for(NSDictionary *dic in responseObject[@"admins"])//管理员
                {
                    ForumModel *model=[[ForumModel alloc]init];
                    model.admin=dic[@"admin"];
                    model.nickname=dic[@"nickname"];
                    model.pic=dic[@"pic"];
                    model.user_id=dic[@"user_id"];
                    //-----------%@%@%@%@",model.admin,model.nickname,model.pic,model.user_id);
                    [_adminisArray addObject:model];
                }
                
                for(NSDictionary *dic in responseObject[@"news"])//帖子
                {
                    ForumModel *model=[[ForumModel alloc]init];
                    model.news_id=dic[@"news_id"];
                    model.nickname=dic[@"nickname"];
                    model.r_count=dic[@"r_count"];
                    model.send_time=dic[@"send_time"];
                    model.title=dic[@"title"];
                    model.user_id=dic[@"user_id"];
                    model.tag=dic[@"tag"];
                    model.top=dic[@"top"];
                    model.fine=dic[@"fine"];
                    model.hot=dic[@"hot"];
                    model.pic_list=dic[@"pic_list"];
                    
                    NSString *top=model.top;
                    if(top.intValue==1){
                        [_headArrray addObject:model];
                    }else
                        [_dataArray addObject:model];
                }
                
                //圈子
                NSDictionary *dict=responseObject[@"circle"];
                ForumModel *model=[[ForumModel alloc] init];
                model.admin=dict[@"admin"];
                model.bg_pic=dict[@"bg_pic"];
                model.circle_id=dict[@"circle_id"];
                model.content=dict[@"content"];
                model.create_time=dict[@"create_time"];
                model.pic=dict[@"pic"];
                model.tag=dict[@"tag"];
                model.title=dict[@"title"];
                model.user_id=dict[@"user_id"];
                _circleModel=model;

                NSString *tagstr =[NSString stringWithFormat:@"%@",dict[@"tag"]];
                if(![tagstr isEqualToString:@"<null>"]){
                    _allTagArray = [NSMutableArray arrayWithArray:[dict[@"tag"]componentsSeparatedByString:@","]];
                }
                
                //            //%@,%lu",_allTagArray,(unsigned long)_allTagArray.count);
                
                NSArray *n_countArray =responseObject[@"n_count"];
                if(n_countArray.count ){
                    _n_count=responseObject[@"n_count"][0][@"count"];
                }
                
                NSArray *u_countArray =responseObject[@"u_count"];
                if(u_countArray.count){
                    _u_count=responseObject[@"u_count"][0][@"count"];
                }
                
                rn_count=responseObject[@"rn_count"];
                
                
                if (_headArrray.count > 0 || _dataArray.count > 0) {
                    _MytableView.tableFooterView=nil;
                }else if((_headArrray.count==0&&_dataArray.count==0)||responseObject[@"news"]==nil){
                    SmileView *smileView = [[SmileView alloc]initWithFrame:CGRectMake(0,0, kApplicationWidth, kApplicationHeight-74-49+kUnderStatusBarStartY)];
                    smileView.backgroundColor=[UIColor whiteColor];
                    smileView.str = @"O(n_n)O~亲~";
                    smileView.str2 = @"暂无帖子";
                    _MytableView.tableFooterView = smileView;
                }
                if(_isfirst==YES){
                    [self reloadHeadView];
                }
                
                [_MytableView reloadData];
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
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
         [[Animation shareAnimation] stopAnimationAt:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
    


}

#pragma mark 精品
-(void)BoutiqueHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    if (token!=nil) {
        url=[NSString stringWithFormat:@"%@circle/queryList?version=%@&token=%@&circle_id=%@&fine=1&pager.curPage=%d",[NSObject baseURLStr],VERSION,token,self.circle_id,_currentpage];
    }else
        url=[NSString stringWithFormat:@"%@circle/queryLUnLogin?version=%@&circle_id=%@&fine=1&pager.curPage=%d",[NSObject baseURLStr],VERSION,self.circle_id,_currentpage];
    
    NSString *URL=[MyMD5 authkey:url];
//    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [MBProgressHUD hideHUDForView:self.view];
         [[Animation shareAnimation] stopAnimationAt:self.view];
        if (_currentpage==1) {
            [_dataArray removeAllObjects];
            [_headArrray removeAllObjects];
        }


//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            if(statu.intValue==1)//请求成功
            {
                for(NSDictionary *dic in responseObject[@"news"])//帖子
                {
                    ForumModel *model=[[ForumModel alloc]init];
                    model.news_id=dic[@"news_id"];
                    model.tag=dic[@"tag"];
                    model.top=dic[@"top"];
                    model.send_time=dic[@"send_time"];
                    model.title=dic[@"title"];
                    model.user_id=dic[@"user_id"];
                    model.nickname=dic[@"nickname"];
                    model.r_count=dic[@"r_count"];
                    model.fine=dic[@"fine"];
                    model.hot= dic[@"hot"];
                    model.pic_list=dic[@"pic_list"];

                    NSString *top=model.top;
                    if(top.intValue==1)
                    {
                        [_headArrray addObject:model];
                    }else
                        [_dataArray addObject:model];
                }
                
                if (_headArrray.count > 0 || _dataArray.count > 0) {
                    //                _MytableView.tableFooterView = [self creatfootView];
                    _MytableView.tableFooterView=nil;
 
                }else if((_headArrray.count==0&&_dataArray.count==0)||responseObject[@"news"]==nil){
                    SmileView *smileView = [[SmileView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight-74-49)];
                    smileView.backgroundColor=[UIColor whiteColor];
                    smileView.str = @"O(n_n)O~亲~";
                    smileView.str2 = @"暂无精品帖子";
                    _MytableView.tableFooterView = smileView;
                }
            }
            [_MytableView reloadData];
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

#pragma mark 热门
-(void)HotHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    if (token==nil) {
        url=[NSString stringWithFormat:@"%@circle/queryLUnLogin?version=%@&circle_id=%@&hot=1&pager.curPage=%d",[NSObject baseURLStr],VERSION,self.circle_id,_currentpage];
    }else
        url=[NSString stringWithFormat:@"%@circle/queryList?version=%@&token=%@&circle_id=%@&hot=1&pager.curPage=%d",[NSObject baseURLStr],VERSION,token,self.circle_id,_currentpage];
    
    NSString *URL=[MyMD5 authkey:url];
//    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [MBProgressHUD hideHUDForView:self.view];
         [[Animation shareAnimation] stopAnimationAt:self.view];
        if (_currentpage==1) {
            [_dataArray removeAllObjects];
            [_headArrray removeAllObjects];
        }


//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            
            if(statu.intValue==1)//请求成功
            {
                for(NSDictionary *dic in responseObject[@"news"])//帖子
                {
                    ForumModel *model=[[ForumModel alloc]init];
                    model.news_id=dic[@"news_id"];
                    model.tag=dic[@"tag"];
                    model.top=dic[@"top"];
                    model.send_time=dic[@"send_time"];
                    model.title=dic[@"title"] ;
                    model.fine=dic[@"fine"];
                    model.hot=dic[@"hot"];
                    model.user_id=dic[@"user_id"];
                    model.nickname=dic[@"nickname"];
                    model.r_count=dic[@"r_count"];
                    model.pic_list=dic[@"pic_list"];

                    
                    NSString *top=model.top;
                    if(top.intValue==1)
                    {
                        [_headArrray addObject:model];
                    }else
                        [_dataArray addObject:model];
                }
                
                if (_headArrray.count > 0 || _dataArray.count > 0) {
                    _MytableView.tableFooterView=nil;
  
                }else if((_headArrray.count==0&&_dataArray.count==0)||responseObject[@"news"]==nil){
                    SmileView *smileView = [[SmileView alloc]initWithFrame:CGRectMake(0,0, kApplicationWidth, kApplicationHeight-74-49+kUnderStatusBarStartY)];
                    smileView.backgroundColor=[UIColor whiteColor];
                    smileView.str = @"O(n_n)O~亲~";
                    smileView.str2 = @"暂无热门帖子";
                    _MytableView.tableFooterView = smileView;
                }
            }
            [_MytableView reloadData];
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


#pragma mark 网络请求————加入圈
-(void)AddcircleHttp:(NSString*)circleid
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    NSString *url=[NSString stringWithFormat:@"%@circle/add?version=%@&token=%@&circle_id=%@",[NSObject baseURLStr],VERSION,token,circleid];
    
    NSString *URL=[MyMD5 authkey:url];
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
         [[Animation shareAnimation] stopAnimationAt:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(statu.intValue==1)//请求成功
            {
                message=@"加入圈成功";
                
                self.isNO=@"1";
                [_addbtn setBackgroundImage:[UIImage imageNamed:@"退出圈"] forState:UIControlStateNormal];
                
                _liulan.text=[NSString stringWithFormat:@"%d",_liulan.text.intValue + 1];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"CircleAdd" object:nil];
                [MBProgressHUD showSuccess:message];
            }else{
                message=@"加入圈失败";
                [MBProgressHUD showError:message];
            }
//            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
//            [mentionview showLable:message Controller:self];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
         [[Animation shareAnimation] stopAnimationAt:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
    
    
}

#pragma mark 网络请求——退出圈
-(void)ExitcircleHttp:(NSString*)circleid
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    NSString *url=[NSString stringWithFormat:@"%@circle/del?version=%@&token=%@&circle_id=%@",[NSObject baseURLStr],VERSION,token,circleid];
    
    NSString *URL=[MyMD5 authkey:url];
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(statu.intValue==1)//请求成功
            {
                message=@"退出圈成功";
                
                self.isNO = @"0";
                [_addbtn setBackgroundImage:[UIImage imageNamed:@"30-30加入"] forState:UIControlStateNormal];
                if(_liulan.text.intValue !=0)
                {
                    _liulan.text=[NSString stringWithFormat:@"%d",_liulan.text.intValue - 1];
                }
                [[NSNotificationCenter defaultCenter]postNotificationName:@"CircleAdd" object:nil];
                [MBProgressHUD showSuccess:message];
            }else{
                message=@"退出圈失败";
                [MBProgressHUD showError:message];
            }
//            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
//            [mentionview showLable:message Controller:self];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
        
    }];
    
    
}

#pragma mark 圈成员
-(void)memberHttp:(NSString*)circleid
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    NSString *url=[NSString stringWithFormat:@"%@circle/queryUserList?version=%@&token=%@&circle_id=%@",[NSObject baseURLStr],VERSION,token,circleid];
    
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
                for(NSDictionary *dic in responseObject[@"circleUsers"])
                {
                    ForumModel *model=[[ForumModel alloc]init];
                    model.admin=dic[@"admin"];
                    model.nickname=dic[@"nickname"];
                    model.pic=dic[@"pic"];
                    model.user_id=dic[@"user_id"];
                    [_memberArray addObject:model];
                }
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

#pragma mark 网络请求——圈精华
-(void)recommendHttp:(NSString*)circleid
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    NSString *url=[NSString stringWithFormat:@"%@circle/fine?version=%@&token=%@&recom=true&circle_id=%@",[NSObject baseURLStr],VERSION,token,circleid];
    
    NSString *URL=[MyMD5 authkey:url];
//    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [MBProgressHUD hideHUDForView:self.view];
         [[Animation shareAnimation] stopAnimationAt:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            
            if(statu.intValue==1)//请求成功
            {
                for(NSDictionary *dic in responseObject[@"circles"])
                {
                    ForumModel *model=[[ForumModel alloc]init];
                    model.circle_id=dic[@"circle_id"];
                    model.content=dic[@"content"];
                    model.ctitle=dic[@"ctitle"];
                    model.ftitle=dic[@"ftitle"];
                    model.news_id=dic[@"news_id"];
                    model.nickname=dic[@"nickname"];
                    model.pic=dic[@"pic"];
                    model.pic_list=dic[@"pic_list"];
                    model.send_time=dic[@"send_time"];
                    model.user_id=dic[@"user_id"];
                    model.r_count=dic[@"r_count"];
                }
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
#pragma  mark - 重新改变 HeadView  frame
-(void)reloadHeadView
{
//    [_headview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],_circleModel.bg_pic]] placeholderImage:[UIImage imageNamed:@"背景图"]];
    
    _headview.frame = CGRectMake(0, 0, kScreenWidth, ZOOM(55*3.4)+68+ZOOM(32));
    _headImage.frame=CGRectMake(ZOOM(62), 0, ZOOM(50*3.4), ZOOM(50*3.4));
    _headImage.layer.borderWidth = 2;
    _headImage.layer.borderColor = [UIColor whiteColor].CGColor;
    _headImage.clipsToBounds=YES;
    _headImage.layer.cornerRadius=_headImage.frame.size.width/2;
    
    _imageView.frame =CGRectMake(0, _headview.frame.size.height-ZOOM(58*3.4), kScreenWidth,100);
    lable.frame =CGRectMake(_imageView.frame.origin.x+100, _headImage.frame.origin.y+5, 200, 23);
    _admin.frame =CGRectMake(lable.frame.origin.x, CGRectGetMaxY(_headImage.frame)-23, ZOOM(100*3.4), 20);
    _dressImgView.frame =CGRectMake(CGRectGetMaxX(_admin.frame), _admin.frame.origin.y+4, IMAGEW(@"总评论"), IMAGEH(@"总评论"));
    _dresslable.frame =CGRectMake(CGRectGetMaxX(_dressImgView.frame) + 5, _admin.frame.origin.y+2, 40, 20);
    _liulanImgView.frame =CGRectMake(CGRectGetMaxX(_dresslable.frame)+ZOOM(30), _admin.frame.origin.y+3, IMAGEW(@"人数"), IMAGEH(@"人数"));
    _liulan.frame =CGRectMake(CGRectGetMaxX(_liulanImgView.frame)+5, _dresslable.frame.origin.y, 40, 20);
    _backview.frame =CGRectMake(0, CGRectGetMaxY(_headview.frame)+10, kApplicationWidth, 50);
    
    //加入圈按钮
    if(self.isNO.intValue == 0){
        [_addbtn setBackgroundImage:[UIImage imageNamed:@"30-30加入"] forState:UIControlStateNormal];
    }else if (self.isNO.intValue == 1){
        [_addbtn setBackgroundImage:[UIImage imageNamed:@"退出圈"] forState:UIControlStateNormal];
    }

    if(_adminisArray.count)    /***  管理员  */
    {
        ForumModel *model=_adminisArray[0];
        if (model.nickname ==nil) {
            _admin.text=[NSString stringWithFormat:@"管理员:"];
        }else{
            _admin.text=[NSString stringWithFormat:@"管理员:%@",model.nickname];
        }
    }else
        _admin.text=[NSString stringWithFormat:@"管理员:"];

    _dresslable.text=[NSString stringWithFormat:@"%@",_n_count];
    _liulan.text=[NSString stringWithFormat:@"%@",_u_count];
    if (_u_count==nil){
        _liulan.text=[NSString stringWithFormat:@"0"];
    }
    if (_n_count==nil){
        _dresslable.text=[NSString stringWithFormat:@"0"];
    }
    lable.text=_circleModel.title;

    
    NSURL *headimgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!560",[NSObject baseURLStr_Upy],_circleModel.bg_pic]];
    __block float d1 = 0;
    __block BOOL isDownlaod1 = NO;
    [_headview sd_setImageWithURL:headimgUrl placeholderImage:[UIImage imageNamed:@"背景图.jpg"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d1 = (float)receivedSize/expectedSize;
        isDownlaod1 = YES;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod1 == YES) {
            _headview.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                _headview.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        } else if (image != nil && isDownlaod1 == NO) {
            _headview.image = image;
        }
    }];
    
    NSURL *imgUrl2 = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!180",[NSObject baseURLStr_Upy],_circleModel.pic]];
    __block float d2 = 0;
    __block BOOL isDownlaod2 = NO;
    [_headImage sd_setImageWithURL:imgUrl2 placeholderImage:[UIImage imageNamed:@"默认头像.jpg"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d2 = (float)receivedSize/expectedSize;
        isDownlaod2 = YES;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod2 == YES) {
            _headImage.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                _headImage.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        } else if (image != nil && isDownlaod2 == NO) {
            _headImage.image = image;
        }
    }];
    
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!180",[NSObject baseURLStr_Upy],_circleModel.pic]];
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [_headImage sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"默认头像.jpg"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d = (float)receivedSize/expectedSize;
        isDownlaod = YES;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod == YES) {
            _headImage.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                _headImage.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        } else if (image != nil && isDownlaod == NO) {
            _headImage.image = image;
        }
    }];

    
    _MytableView.frame =CGRectMake(0, _backview.frame.origin.y+_backview.frame.size.height, kScreenWidth, kScreenHeight-_headview.frame.size.height-_backview.frame.size.height-10);
    
//    [_MytableView reloadData];
}

#pragma mark 列表头
-(void)creatHeadView
{
    //头像
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, _headview.frame.size.height, kApplicationWidth,ZOOM(120*3.4))];
    [self.view addSubview:_imageView];
    _imageView.userInteractionEnabled = YES;
    
    _headImage=[[UIImageView alloc]init];
    [_imageView addSubview:_headImage];

    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    [_headImage addGestureRecognizer:tap];
    _headImage.userInteractionEnabled=YES;

    //圈名
    lable=[[UILabel alloc] init];
    lable.textColor = [UIColor whiteColor];
    lable.font = [UIFont systemFontOfSize:ZOOM(48)];
    [_imageView addSubview:lable];
    
    _admin=[[UILabel alloc]initWithFrame:CGRectMake(lable.frame.origin.x, lable.frame.origin.y+lable.frame.size.height+5, ZOOM(100*3.4), 20)];
    _admin.textColor = [UIColor whiteColor];
    _admin.font=[UIFont systemFontOfSize:ZOOM(40)];
    [_imageView addSubview:_admin];
    
    //帖子总数
    _dressImgView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_admin.frame), _admin.frame.origin.y+4, IMAGEW(@"总评论"), IMAGEH(@"总评论"))];
    _dressImgView.image = [UIImage imageNamed:@"总评论"];
    [_imageView addSubview:_dressImgView];
    
    _dresslable=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_dressImgView.frame) + 5, _admin.frame.origin.y+2, 40, 20)];
    _dresslable.textAlignment = NSTextAlignmentLeft;
    _dresslable.textColor = [UIColor whiteColor];
    _dresslable.font=[UIFont systemFontOfSize:ZOOM(40)];
    [_imageView addSubview:_dresslable];
    
    //用户总数
    _liulanImgView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_dresslable.frame)+ZOOM(30), _admin.frame.origin.y+3, IMAGEW(@"人数"), IMAGEH(@"人数"))];
    _liulanImgView.image = [UIImage imageNamed:@"人数"];
    [_imageView addSubview:_liulanImgView];
    
    _liulan=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_liulanImgView.frame)+5, _dresslable.frame.origin.y, 40, 20)];
    _liulan.textAlignment = NSTextAlignmentLeft;
    _liulan.textColor = [UIColor whiteColor];
    _liulan.font=[UIFont systemFontOfSize:ZOOM(40)];
    [_imageView addSubview:_liulan];
    
    //加入圈
    _addbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _addbtn.frame=CGRectMake(kScreenWidth-ZOOM(45)-IMAGEW(@"30-30加入"),-5, IMAGEW(@"30-30加入"), IMAGEH(@"30-30加入"));
    _addbtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_addbtn addTarget:self action:@selector(addcircle:) forControlEvents:UIControlEventTouchUpInside];
    [_imageView addSubview:_addbtn];
    
    _backview=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageView.frame)+20, kScreenWidth, 50)];
    _backview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_backview];
    
    
    NSArray *butArray=@[@"全部",@"精品",@"热门"];
    for (int i=0; i<butArray.count; i++) {
        UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
        but.frame=CGRectMake(kScreenWidth/3 *i, 0, kScreenWidth/3, 45);
        [but setTitle:butArray[i] forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:ZOOM(55)];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        but.tag=1000+i;
        [but addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        [_backview addSubview:but];
        
        UILabel *linelable=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/3 *(i+1), 15, 1, 20)];
        linelable.backgroundColor=kBackgroundColor;
        [_backview addSubview:linelable];
        
        //设置进来时选中的按键
        if(i==0){
            [but setTitleColor:tarbarrossred forState:UIControlStateNormal];;
            self.selectbtn.selected=NO;
            but.selected=YES;
            self.selectbtn=but;
        }
    }
    
    UILabel *llable = [[UILabel alloc]initWithFrame:CGRectMake(0, 48, kApplicationWidth, 1)];
    llable.backgroundColor = kBackgroundColor;
    [_backview addSubview:llable];

}
#pragma mark 列表
-(void)creatTableview
{
    _MytableView=[[UITableView alloc]initWithFrame:CGRectMake(0, _headview.frame.origin.y+_headview.frame.size.height, kApplicationWidth, kApplicationHeight-_headview.frame.size.height+kUnderStatusBarStartY-10) style:UITableViewStyleGrouped];
    _MytableView.backgroundColor = [UIColor whiteColor];
    _MytableView.delegate=self;
    _MytableView.dataSource=self;
    _MytableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:_MytableView];
    
    [_MytableView registerNib:[UINib nibWithNibName:@"PostTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [_MytableView registerNib:[UINib nibWithNibName:@"topTableViewCell" bundle:nil] forCellReuseIdentifier:@"topCell"];

    
    __weak PostViewController *postView = self;

    [_MytableView addFooterWithCallback:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _currentpage++;
            for(int i=0;i<3;i++)
            {
                UIButton *btn=(UIButton*)[self.view viewWithTag:1000+i];
                if (btn.selected ==YES) {
                    if (btn.tag == 1000) {
                        [self requestHttp];
                    }else if (btn.tag == 1001)
                    {
                        
                        [self BoutiqueHttp ];
                    }else if (btn.tag == 1002)
                    {
                        
                        [self HotHttp];
                    }
                }
            }
            
            [_MytableView footerEndRefreshing];
        });
        
        
    }];
    
    [_MytableView addHeaderWithCallback:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            _currentpage=1;
            for(int i=0;i<3;i++)
            {
                UIButton *btn=(UIButton*)[self.view viewWithTag:1000+i];
                if (btn.selected ==YES) {
                    if (btn.tag == 1000) {
                        [self requestHttp];
                    }else if (btn.tag == 1001)
                    {
                        
                        [self BoutiqueHttp ];
                    }else if (btn.tag == 1002)
                    {
                        
                        [self HotHttp];
                    }
                }
            }
            
            [_MytableView headerEndRefreshing];
            
        });
    }];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
        return _headArrray.count;
    }else{
        return _dataArray.count;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        ForumModel *model=_headArrray[indexPath.row];
        
        InvitationViewController *invitation=[[InvitationViewController alloc]init];
        invitation.circle_id=[NSString stringWithFormat:@"%@",_circleModel.circle_id];
        invitation.circle_content=[NSString stringWithFormat:@"%@",_circleModel.content];
        invitation.model=model;
        invitation.circle_name=_circleModel.title;
        [self.navigationController pushViewController:invitation animated:YES];
    }else{
    
        ForumModel *model=_dataArray[indexPath.row];
        
        MyLog(@"");
    
        InvitationViewController *invitation=[[InvitationViewController alloc]init];
        invitation.circle_id=[NSString stringWithFormat:@"%@",_circleModel.circle_id];
        invitation.model.news_id = model.news_id;
        
        invitation.circle_content=[NSString stringWithFormat:@"%@",_circleModel.content];
        invitation.model=model;
        invitation.circle_name=_circleModel.title;
        [self.navigationController pushViewController:invitation animated:YES];
    }
    
    _index = (int)indexPath.row;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        return 41;
    }else{
        return 70;
    }
    return 70;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(indexPath.section==0){
        topTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"topCell"];
        if(!cell){
            cell=[[topTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"topCell"];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        ForumModel *model=_headArrray[indexPath.row];
        [cell refreshData:model];
        
        return cell;

    }else{
        PostTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if(!cell){
            cell=[[PostTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        if(_dataArray.count){
            ForumModel * model=_dataArray[indexPath.row];
            [cell refreshData:model];
        }
        return cell;
    }
    
    return 0;
}

#pragma mark 评论成功后刷新cell
- (void)commentSuccess:(NSNotification*)note
{
    if(_dataArray.count)
    {
        ForumModel *model = _dataArray[_index];
        MyLog(@"model.u_count = %@",model.r_count);
        model.r_count = [NSString stringWithFormat:@"%d",model.r_count.intValue+1];
        MyLog(@"model.u_count = %@",model.r_count);
        
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:_index inSection:1];
        
        [_MytableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

#pragma mark 按钮监听事件
-(void)btnclick:(UIButton*)sender
{
    _currentpage=1;
    for(int i=0;i<3;i++)
    {
        UIButton *btn=(UIButton*)[self.view viewWithTag:1000+i];

        if(i+1000==sender.tag){
            [btn setTitleColor:tarbarrossred forState:UIControlStateNormal];
            if(i==0){
                _isfirst=NO;
                [_dataArray removeAllObjects];
                [_headArrray removeAllObjects];
                [self requestHttp];
                
            }else if (i==1){
                [_dataArray removeAllObjects];
                 [_headArrray removeAllObjects];
                [self BoutiqueHttp];
            }else if (i==2){
                [_dataArray removeAllObjects];
                 [_headArrray removeAllObjects];
                [self HotHttp];
            }
        }else{
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    self.selectbtn.selected=NO;
    sender.selected=YES;
    self.selectbtn=sender;

}

#pragma mark 头像点击事件
-(void)click:(UIGestureRecognizer*)tap
{
    //good");
    CircledetailViewController *circle=[[CircledetailViewController alloc]init];
    circle.circleModel=_circleModel;
    circle.n_count=_n_count;
    circle.u_count=_u_count;
    circle.rn_count=rn_count;
    circle.circleArr=_adminisArray;
    [self.navigationController pushViewController:circle animated:YES];
}

#pragma mark 发表话题
-(void)edit:(UIButton*)sender
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]==nil) {
        [self ToLoginView];
        return;
    }else{
        SubmitTopicViewController *topic=[[SubmitTopicViewController alloc]init];
        topic.delegate=self;
        topic.circle_id=self.circle_id;
        topic.allIdArray=_allTagArray;
        
        MyLog(@"self.circle_id = %@  _allTagArray=%@",self.circle_id,_allTagArray);
        [self.navigationController pushViewController:topic animated:YES];
    }
}
-(void)submitRefreshInfo
{
        _currentpage=1;
        for(int i=0;i<3;i++)
        {
            UIButton *btn=(UIButton*)[self.view viewWithTag:1000+i];
            if (btn.selected ==YES) {
                if (btn.tag == 1000) {
                    [self requestHttp];
                }else if (btn.tag == 1001){
                    [self BoutiqueHttp ];
                }else if (btn.tag == 1002){
                    [self HotHttp];
                }
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
#pragma mark 加入圈
-(void)addcircle:(UIButton*)sender
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]==nil) {
        [self ToLoginView];
        return;
    }else{
        NSString *circleid=[NSString stringWithFormat:@"%@",self.forummodel.circle_id];
        if(self.isNO.intValue == 0){
            [self AddcircleHttp:circleid];
        }else if (self.isNO.intValue == 1) {
            [self ExitcircleHttp:circleid];
        }
    }
}
-(void)back:(UIButton*)sender
{
    NSNotification *backnote = [[NSNotification alloc]initWithName:@"backnote" object:self userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:backnote];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
