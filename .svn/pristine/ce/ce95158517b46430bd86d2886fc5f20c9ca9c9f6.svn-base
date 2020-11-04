//
//  BeautyViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/9.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "BeautyViewController.h"
#import "FamilyTableViewCell.h"
#import "TimeLineTableViewCell.h"
#import "CircleTableViewCell.h"
#import "PostViewController.h"
#import "CollectnewsViewController.h"
#import "NavgationbarView.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "MyMD5.h"
#import "ForumModel.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "SmileView.h"

#import "InvitationViewController.h"
#import "ShareBuyViewController.h"
#import "IntelligenceViewController.h"
#import "BuySuccessViewController.h"
#import "PayFailedViewController.h"
#import "popViewController.h"
#import "LoginViewController.h"

#import "TFLoginView.h"
#import "AppDelegate.h"

#define contentWidth kScreenWidth-50-ZOOM(62)*2-ZOOM(35)


@interface BeautyViewController ()<AddcircleDelegate>
{
    CGFloat _Heigh;
    CGFloat _titlenameHeigh;
    CGFloat _circlenameHeigh;
    CGFloat _discriptionHeigh;
    CGFloat _ImageHeigh;

}
@property (nonatomic ,strong) UIViewController  *thirdVC;
@property (nonatomic ,strong) UIViewController  *firstVC;
@property (nonatomic ,strong) UIViewController *secondVC;
@property (nonatomic ,strong) UIViewController *currentVC;

@end

@implementation BeautyViewController
{
    //几个状态
    NSArray *_titleArr;
    UIButton *_statebtn;
    UILabel *_statelab;
    UIView *_stateview;
    
    //列表
    UITableView *_MytableView;
    UITableView *_MytableView2;
    UITableView *_MytableView3;
    
    //数据源
    NSMutableArray *_dataArray;
    NSMutableArray *_dataArray2;
    NSMutableArray *_dataArray3;
    
    //当前页数
    NSInteger _currentpage;
    //商品总页数
    NSInteger _pageCount;
    
    NSInteger _currentpage2;
    //商品总页数
    NSInteger _pageCount2;
    
    NSInteger _currentpage3;
    //商品总页数
    NSInteger _pageCount3;
    
    SmileView *_smileView;
    
    UIButton *collectbtn;
    
    UIButton *_SelectBtn;
    
    UIView *_FootView;
    
    BOOL firstComeIn;
    
    NSInteger _num;
 
}
- (void)viewDidLoad {
    [super viewDidLoad];

    _dataArray=[NSMutableArray array];
    _dataArray2=[NSMutableArray array];
    _dataArray3=[NSMutableArray array];
    
    _num=1;
    _pageCount=1;
    _pageCount2=1;
    _pageCount3=1;
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.hidden=YES;
    self.automaticallyAdjustsScrollViewInsets=NO;
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(touchbtn:) name:@"touchbtn" object:nil];
   
    _smileView = [[SmileView alloc]initWithFrame:CGRectMake(0,0, kApplicationWidth, kApplicationHeight-74-49+kUnderStatusBarStartY)];
    _smileView.backgroundColor=[UIColor whiteColor];
//    [_smileView drawRect:CGRectMake(0, 64, kApplicationWidth, kApplicationHeight-100)];

    
    [self creatHeadView];
    [self creatTableview2];
    [self creatTableview3];

    [self creatTableview];
    
    _FootView = [self setfootview];
    
    [self.view addSubview:_FootView];
    
    
    if (!firstComeIn) {
        [self httpCircleTagData];
    }
//    [self requestHttp];

}

/**
 *  请求标签数据
 */
-(void)httpCircleTagData
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    NSString *url;
    url=[NSString stringWithFormat:@"%@circleNews/queryTag?version=%@&tag_data=%@",[NSObject baseURLStr],VERSION,@""];
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //%@",responseObject);
        
        if (responseObject!=nil) {
            NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject];
            NSString*newFielPath = [documentsPath stringByAppendingPathComponent:@"circleTag.txt"];
            
            NSMutableDictionary *dictionary=[NSMutableDictionary dictionary];
            //        NSDictionary *dic = responseObject[@"circle_tag"];
            for(NSDictionary *dic in responseObject[@"circle_tag"]){
                [dictionary setObject:dic[@"tag_name"] forKey:dic[@"id"]];
                //%@,%@,%@",dic[@"tag_name"],responseObject[@"tag_data"],dic[@"id"]);
            }
            
            BOOL isSucceed = [dictionary writeToFile:newFielPath atomically:YES];
            //%d",isSucceed);
            
            NSString* newFielPath1 = [documentsPath stringByAppendingPathComponent:@"circleTag.txt"];
            NSDictionary *content = [NSDictionary dictionaryWithContentsOfFile:newFielPath1];
            //%@",content);
            NSArray *arr=@[@"1"];
            
            NSMutableArray *array=[NSMutableArray array];
            for (int i=0; i<arr.count; i++) {
                NSString *string =[NSString stringWithFormat:@"%@",[content objectForKey:arr[i]] ];
                NSString *str2=[string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                //%@,%@",string,str2);
                [array addObject:str2];
            }
            //%@",array);

        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[Animation shareAnimation]createAnimationAt:self.view];
 

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    for(int i=0;i<_titleArr.count;i++)
    {
        UIButton *btn=(UIButton*)[self.view viewWithTag:1000+i];
        
        if(btn.selected == YES)
        {
            if(i==0)
            {
//                [_MytableView setHidden:NO];
//                [_MytableView2 setHidden:YES];
//                [_MytableView3 setHidden:YES];
                
                _currentpage = 1;
                [self requestHttp];
                
            }else if (i==1)
            {
//                [_MytableView2 setHidden:NO];
//                [_MytableView setHidden:YES];
//                [_MytableView3 setHidden:YES];
                
                _currentpage2 = 1;
                [self recommendHttp];
                
                
            }else if (i==2)
            {
//                [_MytableView3 setHidden:NO];
//                [_MytableView setHidden:YES];
//                [_MytableView2 setHidden:YES];
                
                _currentpage3 = 1;
                [self circleHttp];
                
            }
        }
    }

}
#pragma mark 网络请求——我的
-(void)requestHttp
{

    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    url=[NSString stringWithFormat:@"%@circle/queryUserCircleList?version=%@&token=%@&pager.curPage=%d",[NSObject baseURLStr],VERSION,token,_currentpage];

    
    NSString *URL=[MyMD5 authkey:url];

//    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //[MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
//        [_MytableView headerEndRefreshing];
        [_MytableView footerEndRefreshing];
        
        if (responseObject!=nil) {
//            //
            
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            NSString *pagecount =responseObject[@"pager"][@"pageCount"];
            
            if (_currentpage == 1) {
                [_dataArray removeAllObjects];;
            }
            if(statu.intValue==1)//请求成功
            {
                for(NSDictionary *dic in responseObject[@"circles"])
                {
                    ForumModel *model=[[ForumModel alloc]init];
                    
                    model.n_count=dic[@"n_count"];
                    model.circle_id=dic[@"circle_id"];
                    model.content=dic[@"content"];
                    model.pic=dic[@"pic"];
                    model.title=dic[@"title"];
                    model.u_count=dic[@"u_count"];
                    
                    [_dataArray addObject:model];
                }
                _pageCount=pagecount.intValue;
                
                //daarr.cout %d",_dataArray.count);
                if (_dataArray.count > 0) {
                    
                    //                _MytableView.tableFooterView = [self creatfootView];
                    
                    _MytableView.tableFooterView=nil;
                    
                    
                    
                    
                }else if(_dataArray.count==0||responseObject[@"circles"]==nil){
                    
                    
                    SmileView *smileView = [[SmileView alloc]initWithFrame:CGRectMake(0,0, kApplicationWidth, kApplicationHeight-74-49+kUnderStatusBarStartY)];
                    smileView.backgroundColor=[UIColor whiteColor];
                    smileView.str = @"O(n_n)O~亲~";
                    smileView.str2 = @"您还没有加入任何圈子";
                    [smileView addview:[self creatfootView]];
                    
                    _MytableView.tableFooterView = smileView;
                }
                [_MytableView reloadData];
                
            }else if (statu.intValue==10030)
            {
                
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud removeObjectForKey:USER_TOKEN];
                LoginViewController *login=[[LoginViewController alloc]init];
                
                login.tag=1000;
                
                login.loginStatue = @"10030";
                
                [self.navigationController pushViewController:login animated:YES];
                
//                UINavigationController *navv=[[UINavigationController alloc] initWithRootViewController:login];
//                AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//                app.window.rootViewController = navv;
                
            }
            
            else{
                
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:message Controller:self];
                
            }

        }
        
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        SmileView *smileView = [[SmileView alloc]initWithFrame:CGRectMake(0,0, kApplicationWidth, kApplicationHeight-74-49+kUnderStatusBarStartY)];
        smileView.backgroundColor=[UIColor whiteColor];
        smileView.str = @"O(n_n)O~亲~";
        smileView.str2 = @"您还没有加入任何圈子";
        [smileView addview:[self creatfootView]];
        
        _MytableView.tableFooterView = smileView;
        
        [_MytableView reloadData];

        
        //[MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        [_MytableView headerEndRefreshing];
        [_MytableView footerEndRefreshing];
            if ([error code] == kCFURLErrorTimedOut) {
                [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
            }else{
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
            }
    }];
    


}
#pragma mark 网络请求——推荐
-(void)recommendHttp
{

    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    if(token!=nil){
        url=[NSString stringWithFormat:@"%@circle/fine?version=%@&token=%@&recom=false&pager.curPage=%d",[NSObject baseURLStr],VERSION,token,_currentpage2];
    }else
        url=[NSString stringWithFormat:@"%@circle/fineUnLogin?version=%@&recom=false&pager.curPage=%d",[NSObject baseURLStr],VERSION,_currentpage2];

    
    NSString *URL=[MyMD5 authkey:url];

    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {

        [[Animation shareAnimation] stopAnimationAt:self.view];

        [_MytableView2 footerEndRefreshing];
//        //
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            NSString *pagecount =responseObject[@"pager"][@"pageCount"];
            
            if (_currentpage2 == 1) {
                [_dataArray2 removeAllObjects];;
            }
            if(statu.intValue==1)//请求成功
            {
                for(NSDictionary *dic in responseObject[@"circles"])
                {
                    ForumModel *model=[[ForumModel alloc]init];
                    model.circle_id=dic[@"circle_id"];
                    model.content=dic[@"content"];
                    model.ctitle=dic[@"ctitle"];
                    model.ftitle=dic[@"ftitle"];
                    model.pic=dic[@"pic"];
                    model.news_id=dic[@"news_id"];
                    model.pic_list=dic[@"pic_list"];
                    model.send_time=dic[@"send_time"];
                    model.user_id=dic[@"user_id"];
                    model.r_count=dic[@"r_count"];
                    model.nickname=dic[@"nickname"];
                    
                    [_dataArray2 addObject:model];
                }
                _pageCount2=pagecount.intValue;
                
                if (_dataArray2.count == 0 || responseObject[@"circles"]==nil) {
                    
                    SmileView *smileView = [[SmileView alloc]initWithFrame:CGRectMake(0,0, kApplicationWidth, kApplicationHeight-74-49+kUnderStatusBarStartY)];
                    smileView.backgroundColor=[UIColor whiteColor];
                    //                smileView.str = @"O(n_n)O~亲~";
                    //                smileView.str2 = @"您还没有加入任何圈子";
                    [smileView addview:[self creatfootView]];
                    
                    _MytableView2.tableFooterView = smileView;
                }else
                    _MytableView2.tableFooterView=nil;
                
                [_MytableView2 reloadData];
                
                
                
            }else{
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:message Controller:self];
            }

        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[Animation shareAnimation] stopAnimationAt:self.view];

        
        SmileView *smileView = [[SmileView alloc]initWithFrame:CGRectMake(0,0, kApplicationWidth, kApplicationHeight-74-49+kUnderStatusBarStartY)];
        smileView.backgroundColor=[UIColor whiteColor];
//        smileView.str = @"O(n_n)O~亲~";
//        smileView.str2 = @"您还没有加入任何圈子";
        [smileView addview:[self creatfootView]];
        
        _MytableView2.tableFooterView = smileView;

        [_MytableView2 reloadData];

        [_MytableView2 headerEndRefreshing];
        [_MytableView2 footerEndRefreshing];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
    

}
#pragma mark 网络请求---全部
-(void)circleHttp
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    url=[NSString stringWithFormat:@"%@circle/queryAll?version=%@&token=%@&pager.curPage=%d",[NSObject baseURLStr],VERSION,token,_currentpage3];
    
    NSString *URL=[MyMD5 authkey:url];

//    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {

        [[Animation shareAnimation] stopAnimationAt:self.view];
//        [_MytableView3 headerEndRefreshing];
        [_MytableView3 footerEndRefreshing];
//        //
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            NSString *pagecount =responseObject[@"pager"][@"pageCount"];
            
            if (_currentpage3 == 1) {
                [_dataArray3 removeAllObjects];;
            }
            
            if(statu.intValue==1)//请求成功
            {
                for(NSDictionary *dic in responseObject[@"circles"])
                {
                    ForumModel *model=[[ForumModel alloc]init];
                    model.circle_id=dic[@"circle_id"];
                    model.content=dic[@"content"];
                    model.title=dic[@"title"];
                    model.day_count=dic[@"day_count"];
                    model.pic=dic[@"pic"];
                    model.isNO=dic[@"isNo"];
                    [_dataArray3 addObject:model];
                }
                _pageCount3=pagecount.intValue;
                
                
                if (_dataArray3.count == 0) {
                    
                    _smileView.str = @"O(n_n)O~亲~";
                    _smileView.str2 = @"暂时还没有任何圈子";
                    _MytableView3.tableFooterView = _smileView;
                }
                
                [_MytableView3 reloadData];
            }else{
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:message Controller:self];
                
            }

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        SmileView *smileView = [[SmileView alloc]initWithFrame:CGRectMake(0,0, kApplicationWidth, kApplicationHeight-74-49+kUnderStatusBarStartY)];
        smileView.backgroundColor=[UIColor whiteColor];
        smileView.str = @"O(n_n)O~亲~";
        smileView.str2 = @"您还没有加入任何圈子";
        [smileView addview:[self creatfootView]];
        
        _MytableView3.tableFooterView = smileView;
        
        [_MytableView3 reloadData];

        
        //[MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        [_MytableView3 headerEndRefreshing];
        [_MytableView3 footerEndRefreshing];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
    


}

#pragma mark 网络请求————加入圈
-(void)AddcircleHttp:(NSString*)circleid :(NSInteger)index
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    url=[NSString stringWithFormat:@"%@circle/add?version=%@&token=%@&circle_id=%@",[NSObject baseURLStr],VERSION,token,circleid];
    
    NSString *URL=[MyMD5 authkey:url];
//    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
//        //
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(statu.intValue==1)//请求成功
            {
                message=@"恭喜你成功加入该圈";
                //            _currentpage3=1;
                //            [self circleHttp];
                
                ForumModel *model = _dataArray3[index];
                model.isNO=@"1";
                
            }else{
                message=@"加入该圈失败";
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
            
            [_MytableView3 reloadData];

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //[MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        
    }];
    

}

#pragma mark 网络请求——退出圈
-(void)ExitcircleHttp:(NSString*)circleid :(NSInteger)index
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    url=[NSString stringWithFormat:@"%@circle/del?version=%@&token=%@&circle_id=%@",[NSObject baseURLStr],VERSION,token,circleid];
    
    NSString *URL=[MyMD5 authkey:url];

    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {

        [[Animation shareAnimation] stopAnimationAt:self.view];
        
//        //
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(statu.intValue==1)//请求成功
            {
                message=@"退出圈成功";
                
                ForumModel *model = _dataArray3[index];
                model.isNO=@"0";
                
//                [self circleHttp];
                
            }else{
                message=@"退出圈失败";
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
            
            [_MytableView3 reloadData];

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        

        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        
    }];


}

#pragma mark 头部按钮
-(void)creatHeadView
{
//    UIView *headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 64)];
    
//    [self.view addSubview:headview];

    
    _titleArr=@[@"我的",@"推荐",@"全部"];
    CGFloat btnwidh=kApplicationWidth/_titleArr.count;

    for(int i=0;i<_titleArr.count;i++)
    {
        //按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnwidh*i, 20, btnwidh, 44);
        [btn setTitle:_titleArr[i] forState:UIControlStateNormal];

        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:tarbarrossred forState:UIControlStateSelected];
        btn.titleLabel.font=[UIFont systemFontOfSize:ZOOM(57)];
        btn.tag=1000+i;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        //状态条
//        _statelab=[[UILabel alloc]initWithFrame:CGRectMake(btnwidh*i+20, 65, btnwidh-40, 2)];
//        _statelab.backgroundColor=[UIColor clearColor];
//        
//        _statelab.tag=2000+i;
//        [headview addSubview:_statelab];
        
        //设置进来时选中的按键
        if(i == 0)
        {
//            [_statebtn setTitleColor:tarbarrossred forState:UIControlStateNormal];
//            _statelab.backgroundColor=tarbarrossred;
            btn.selected=YES;
            self.slectbtn=btn;
        }
        
    }
    
    _stateview = [[UIView alloc]initWithFrame:CGRectMake(20, 65, btnwidh-40, 2)];
    _stateview.backgroundColor = tarbarrossred;
    [self.view addSubview:_stateview];
    
}

#pragma mark 按钮监听事件
-(void)click:(UIButton*)sender
{

    if (sender.selected == YES) {
        return;
    }
    
    for (int i = 0; i<3; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:1000+i];
        
        //btn = %@", btn);
        
        btn.selected = NO;
    }
    sender.selected = YES;

    NSInteger index = sender.tag%1000;
    CGFloat btnwidh=kApplicationWidth/3;
    CGFloat XX =(btnwidh*index)+20;
    [UIView animateWithDuration:0.15 animations:^{
        _stateview.frame =CGRectMake(XX, _stateview.frame.origin.y, _stateview.frame.size.width, _stateview.frame.size.height);
    }];
    
    switch (sender.tag) {
        case 1000:
        {

            _currentpage=1;
            [self requestHttp];
            [self replaceController:_currentVC newController:_firstVC];
        }
            break;
        case 1001:
        {

            _currentpage2=1;
            [self recommendHttp];
            [self replaceController:_currentVC newController:_secondVC];
        }
            break;
        case 1002:
        {

            _currentpage3=1;
            [self circleHttp];
            [self replaceController:_currentVC newController:_thirdVC];
        }
            break;
        default:
            break;
    }

    /*
    if(sender.tag==1000)
    {
        [_MytableView setHidden:NO];
        [_MytableView2 setHidden:YES];
        [_MytableView3 setHidden:YES];
        

        _currentpage=1;
        [self requestHttp];
        

        collectbtn.hidden=NO;
        _FootView.hidden=NO;
        
        
    }else if (sender.tag==1001)
    {
        [_MytableView2 setHidden:NO];
        [_MytableView setHidden:YES];
        [_MytableView3 setHidden:YES];
        
        _currentpage2=1;
        [self recommendHttp];
        
        
        collectbtn.hidden=YES;
        _FootView.hidden=YES;
        
    }else if (sender.tag==1002)
    {
        [_MytableView3 setHidden:NO];
        [_MytableView setHidden:YES];
        [_MytableView2 setHidden:YES];
        

        _currentpage3=1;
        [self circleHttp];

        collectbtn.hidden=YES;
        _FootView.hidden=YES;
    }

    */
/*
    
//    [_smileView removeFromSuperview];
//    _MytableView.tableFooterView=nil;
    
    NSInteger index = sender.tag%1000;
    
    CGFloat btnwidh=kApplicationWidth/3;
    
    CGFloat XX =(btnwidh*index)+20;
    
    
    [UIView animateWithDuration:0.15 animations:^{
       
        _stateview.frame =CGRectMake(XX, _stateview.frame.origin.y, _stateview.frame.size.width, _stateview.frame.size.height);
        for(int i=0;i<_titleArr.count;i++)
        {
            UIButton *btn=(UIButton*)[self.view viewWithTag:1000+i];
            if(i+1000 == sender.tag)
            {
                [btn setTitleColor:tarbarrossred forState:UIControlStateNormal];
                btn.backgroundColor=[UIColor clearColor];

            }else{
                 [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            
        }
        
       

        
    } completion:^(BOOL finished) {
        UIView *footview = (UIView *)[self.view viewWithTag:9898];
        
        
        for(int i=0;i<_titleArr.count;i++)
        {
            UIButton *btn=(UIButton*)[self.view viewWithTag:1000+i];
            UILabel *lable=(UILabel*)[self.view viewWithTag:2000+i];
            if(i+1000==sender.tag)
            {
                [btn setTitleColor:tarbarrossred forState:UIControlStateNormal];
                btn.backgroundColor=[UIColor clearColor];
                lable.backgroundColor=tarbarrossred;
                [[Animation shareAnimation]createAnimationAt:self.view];
                
                
                if(i==0)
                {
                    [_MytableView setHidden:NO];
                    [_MytableView2 setHidden:YES];
                    [_MytableView3 setHidden:YES];
                    
                    //                if(_currentpage <=_pageCount )
                    //                {
                    _currentpage=1;
                    [self requestHttp];
                    
                    //                }else{
                    //                    [[Animation shareAnimation]stopAnimationAt:self.view];
                    //                }
                    
                    collectbtn.hidden=NO;
                    _FootView.hidden=NO;
                    
                    
                }else if (i==1)
                {
                    [_MytableView2 setHidden:NO];
                    [_MytableView setHidden:YES];
                    [_MytableView3 setHidden:YES];
                    
                    //                if(_currentpage2 < _pageCount2)
                    //                {
                    _currentpage2=1;
                    [self recommendHttp];
                    
                    //                }else{
                    //                    [[Animation shareAnimation]stopAnimationAt:self.view];
                    //                }
                    
                    collectbtn.hidden=YES;
                    _FootView.hidden=YES;
                    
                }else if (i==2)
                {
                    [_MytableView3 setHidden:NO];
                    [_MytableView setHidden:YES];
                    [_MytableView2 setHidden:YES];
                    
                    //                if(_currentpage3 < _pageCount3)
                    //                {
                    _currentpage3=1;
                    [self circleHttp];
                    
                    //                }else{
                    //                    [[Animation shareAnimation]stopAnimationAt:self.view];
                    //                }
                    
                    
                    collectbtn.hidden=YES;
                    _FootView.hidden=YES;
                }
                
                
                
            }else{
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                lable.backgroundColor=[UIColor clearColor];
            }
        }
        
        
        self.slectbtn.selected=NO;
        sender.selected=YES;
        self.slectbtn=sender;
       
    }];
    
    
    */

}

//  切换各个标签内容
- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController
{
    /**
     *            着重介绍一下它
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController      当前显示在父视图控制器中的子视图控制器
     *  toViewController        将要显示的姿势图控制器
     *  duration                动画时间(这个属性,old friend 了 O(∩_∩)O)
     *  options                 动画效果(渐变,从下往上等等,具体查看API)
     *  animations              转换过程中得动画
     *  completion              转换完成
     */
    
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        
        if (finished) {
            
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVC = newController;
            
        }else{
            
            self.currentVC = oldController;
            
        }
    }];
}
-(UIView *)setfootview
{
    UIView *footview=[[UIView alloc]initWithFrame:CGRectMake(0, kScreenWidth-49-40+kUnderStatusBarStartY, kScreenWidth, 40)];
    footview.tag = 9898;
    footview.backgroundColor=kBackgroundColor;
    
    
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-80, 10, 150, 20)];
    lable.text=@"更多圈子";
    lable.textColor=kTitleColor;
    lable.textAlignment=NSTextAlignmentCenter;
    [footview addSubview:lable];
    
    UIImageView *Img = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-80, (footview.frame.size.height-IMGSIZEW(@"+"))/2, IMGSIZEW(@"+"), IMGSIZEH(@"+"))];
    Img.image = [UIImage imageNamed:@"+"];
    [footview addSubview:Img];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(footclick:)];
    [footview addGestureRecognizer:tap];
    footview.userInteractionEnabled=YES;
    
    return footview;
}
-(UIView *)creatfootView
{
    if (_num==1) {
        
        UIView *footview=[[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight-49-40+kUnderStatusBarStartY, kApplicationWidth-ZOOM(150)*2, 40)];
        footview.tag = 9898;
        //    footview.backgroundColor=kBackgroundColor;
        footview.layer.borderWidth=1;
        footview.layer.borderColor=[UIColor blackColor].CGColor;
        
        
        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, footview.frame.size.width, 20)];
        lable.text=@"查看所有圈子";
        lable.textColor=kTitleColor;
        lable.textAlignment=NSTextAlignmentCenter;
        [footview addSubview:lable];
        
        //    UIImageView *Img = [[UIImageView alloc]initWithFrame:CGRectMake(kApplicationWidth/2-80, 10, 20, 20)];
        //    Img.image = [UIImage imageNamed:@"+"];
        //    [footview addSubview:Img];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(footclick:)];
        [footview addGestureRecognizer:tap];
        footview.userInteractionEnabled=YES;
        
        return footview;
    }
    
    return nil;
}
-(void)creatTableview
{

    
//    _MytableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 74, kApplicationWidth, kScreenHeight-74-49-40) style:UITableViewStylePlain];
    _MytableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, kApplicationWidth, kScreenHeight-74-49-40) style:UITableViewStylePlain];

    _MytableView.tag=3333;
    _MytableView.delegate=self;
    _MytableView.dataSource=self;
    _MytableView.separatorStyle=UITableViewCellSeparatorStyleNone;
//    _MytableView.rowHeight=ZOOM(274);
    _firstVC = [[UIViewController alloc]init];
    _firstVC.view.frame=CGRectMake(0, 74, kApplicationWidth, kScreenHeight-74-49-40) ;
    [_firstVC.view addSubview:_MytableView];
    _firstVC.view.backgroundColor = DRandomColor;
    [self addChildViewController:_firstVC];
    [self.view addSubview:_firstVC.view];
    _currentVC = _firstVC;
//    _MytableView.tableFooterView=footview;
//    [self.view addSubview:_MytableView];

    [_MytableView registerNib:[UINib nibWithNibName:@"FamilyTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    collectbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    collectbtn.frame=CGRectMake(kApplicationWidth-ZOOM(110)-10,_firstVC.view.frame.size.height-30-ZOOM(110), ZOOM(110), ZOOM(110));
    [collectbtn setBackgroundImage:[UIImage imageNamed:@"圈圈收藏" ]forState:UIControlStateNormal];
    [collectbtn addTarget:self action:@selector(collectbtn:) forControlEvents:UIControlEventTouchUpInside];
    collectbtn.clipsToBounds=YES;
    collectbtn.layer.cornerRadius=15;
    [_firstVC.view addSubview:collectbtn];

//    [self.view bringSubviewToFront:collectbtn];
    
//     UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
//    [collectbtn addGestureRecognizer:pan];
    collectbtn.userInteractionEnabled=YES;
    
    __weak BeautyViewController *beauty = self;

    [_MytableView addFooterWithCallback:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        _currentpage++;
        [beauty requestHttp];
        });
    }];
    
    [_MytableView addHeaderWithCallback:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            _currentpage = 1;
            [beauty requestHttp];
            [_MytableView headerEndRefreshing];
        });
    }];
    
   
}

-(void)creatTableview2
{
    _MytableView2=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, kScreenHeight-74-49)];
    _MytableView2.delegate=self;
    _MytableView2.dataSource=self;
    _MytableView2.tag=5555;
//    _MytableView2.separatorStyle=UITableViewCellSeparatorStyleNone;
    _MytableView2.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:_MytableView2];
    
    
    _secondVC = [[UIViewController alloc]init];
    _secondVC.view.frame=CGRectMake(0, 74, kApplicationWidth, kScreenHeight-74-49) ;
    [_secondVC.view addSubview:_MytableView2];
    _secondVC.view.backgroundColor = DRandomColor;
//    [self addChildViewController:_secondVC];
//    [self.view addSubview:_secondVC.view];
//    _MytableView2.backgroundColor = tarbarrossred;
    
    [_MytableView2 registerNib:[UINib nibWithNibName:@"TimeLineTableViewCell" bundle:nil] forCellReuseIdentifier:@"TimeCell"];

    [_MytableView2 addFooterWithCallback:^{
        _currentpage2++;
        [self recommendHttp];
        
    }];
    [_MytableView2 addHeaderWithCallback:^{
        _currentpage2 = 1;
        [self recommendHttp];
        [_MytableView2 headerEndRefreshing];
    }];
}

-(void)creatTableview3
{
    _MytableView3=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth,kScreenHeight-74-49)];
    _MytableView3.delegate=self;
    _MytableView3.dataSource=self;
    _MytableView3.tag=7777;
    _MytableView3.separatorStyle=UITableViewCellSeparatorStyleNone;
    _MytableView3.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:_MytableView3];
    _thirdVC = [[UIViewController alloc]init];
    _thirdVC.view.frame=CGRectMake(0, 74, kApplicationWidth, kScreenHeight-74-49) ;
    [_thirdVC.view addSubview:_MytableView3];
    _thirdVC.view.backgroundColor = DRandomColor;
    
    
    [_MytableView3 registerNib:[UINib nibWithNibName:@"CircleTableViewCell" bundle:nil] forCellReuseIdentifier:@"CilcleCell"];
    
    [_MytableView3 addFooterWithCallback:^{
        _currentpage3++;
        [self circleHttp];
        
    }];
    [_MytableView3 addHeaderWithCallback:^{
        _currentpage3 = 1;
        [self circleHttp];
        [_MytableView3 headerEndRefreshing];
    }];
    
}

#if 0
#pragma mark 下拉刷新
-(void)addheadFresh
{
    UITableView *tableview;
    if(self.slectbtn.tag==1000)
    {
        tableview=(UITableView*)[self.view viewWithTag:3333];
    }
    if(self.slectbtn.tag==1001)
    {
        tableview=(UITableView*)[self.view viewWithTag:5555];
    }
    if(self.slectbtn.tag==1002)
    {
        tableview=(UITableView*)[self.view viewWithTag:7777];
    }
    
    [tableview addHeaderWithCallback:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if(tableview.tag==3333)
            {
                [self requestHttp];
                
            }else if (tableview.tag==5555)
            {
                [self recommendHttp];
                
            }else if (tableview.tag==7777)
            {
                [self circleHttp];
            }
            
            
            // 结束刷新
            [tableview headerEndRefreshing];
        });
    }];
    
    [_MytableView headerBeginRefreshing];
}

#pragma mark 上拉刷新
-(void)addfootFresh
{
    UITableView *tableview;
    if(self.slectbtn.tag==1000)
    {
        tableview=(UITableView*)[self.view viewWithTag:3333];
    }
    if(self.slectbtn.tag==1001)
    {
        tableview=(UITableView*)[self.view viewWithTag:5555];
    }
    if(self.slectbtn.tag==1002)
    {
        tableview=(UITableView*)[self.view viewWithTag:7777];
    }
    

    [tableview addFooterWithCallback:^{
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         
            if(tableview.tag==3333)
            {
                [self requestHttp];
                
            }else if (tableview.tag==5555)
            {
                [self recommendHttp];
                
            }else if (tableview.tag==7777)
            {
                [self circleHttp];
            }

            
            // 结束刷新
            [tableview footerEndRefreshing];
        });
        
    }];
    
    
}
#endif

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    
    NSString *YY=[NSString stringWithFormat:@"%.f",scrollView.contentSize.height];
    if(scrollView.tag==3333)
    {
    
        if (scrollView.contentOffset.y == [YY integerValue] - scrollView.frame.size.height) {
            //滑到底部加载更多

            _currentpage++;

            if(_currentpage <_pageCount )
            {

                [self requestHttp];
            }else{
//                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
//                [mentionview showLable:@"当前页已是最后一页" Controller:self];
            }

        }
    }else if (scrollView.tag==5555)
    {
        if (scrollView.contentOffset.y+1 > [YY floatValue] - scrollView.frame.size.height) {
            //滑到底部加载更多

            
            _currentpage2++;

            if(_currentpage2 <_pageCount2)
            {
                [self recommendHttp];
            }else{
//                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
//                [mentionview showLable:@"当前页已是最后一页" Controller:self];
            }

            
        }

    }else if (scrollView.tag==7777)
    {
        if (scrollView.contentOffset.y == [YY integerValue] - scrollView.frame.size.height) {
            //滑到底部加载更多

            
            _currentpage3++;

            if(_currentpage3 <_pageCount3 )
            {
                [self circleHttp];
            }else{
//                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
//                [mentionview showLable:@"当前页已是最后一页" Controller:self];
            }

            
        }

    }
}


#pragma mark===========================================UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==_MytableView)
    {
        ForumModel *model=_dataArray[indexPath.row];
    
        PostViewController *post=[[PostViewController alloc]init];
        post.circle_id=[NSString stringWithFormat:@"%@",model.circle_id];
        post.forummodel=model;
        post.circle_name=model.title;
        post.isNO = @"1";
        
        post.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:post animated:YES];
    }else if (tableView==_MytableView2)
    {
        ForumModel *model=_dataArray2[indexPath.row];
        
        InvitationViewController *invitation=[[InvitationViewController alloc]init];
        invitation.circle_id=[NSString stringWithFormat:@"%@",model.circle_id];
//        invitation.circle_content=[NSString stringWithFormat:@"%@",_circleModel.content];
        invitation.model=model;
        invitation.circle_name=model.title;
        invitation.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:invitation animated:YES];
        /*
        PostViewController *post=[[PostViewController alloc]init];
        post.circle_id=[NSString stringWithFormat:@"%@",model.circle_id];
        post.forummodel=model;
        post.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:post animated:YES];
         */
    }else if (tableView==_MytableView3)
    {
        ForumModel *model=_dataArray3[indexPath.row];
        
        PostViewController *post=[[PostViewController alloc]init];
        
        post.isNO = [NSString stringWithFormat:@"%@",model.isNO];
        post.circle_id=[NSString stringWithFormat:@"%@",model.circle_id];
        post.forummodel=model;
        post.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:post animated:YES];
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==_MytableView)
    {
        return 90;
    }else if (tableView==_MytableView2)
    {
        ForumModel *model=_dataArray2[indexPath.row];
        
        
        NSArray *imageArray=[model.pic_list componentsSeparatedByString:@","];
        CGFloat heigh=0;
        for(int i=0;i<imageArray.count;i++)
        {
            NSArray *arr = [imageArray[i] componentsSeparatedByString:@":"];
            CGFloat scale;
            if(arr.count == 2)
            {
                scale = [arr[1] floatValue];
            }
            if(scale && model.pic_list.length !=0)
            {
                heigh += (kApplicationWidth-90)/scale ;


            }
        }
        heigh += 10*(imageArray.count-1);
        //........%f",heigh);
        _Heigh=heigh+[self getRowHeight:model.ftitle fontSize:ZOOM(44)]+[self getRowHeight:model.content fontSize:ZOOM(37)];

        //row heigh  %f",heigh+[self getRowHeight:model.ftitle fontSize:ZOOM(44)]+[self getRowHeight:model.content fontSize:ZOOM(37)]+ZOOM(35)*5+90);
        return heigh+[self getRowHeight:model.ftitle fontSize:ZOOM(44)]+[self getRowHeight:model.content fontSize:ZOOM(37)]+ZOOM(35)*5+90;
        
        /*
        if(_dataArray2.count)
        {
            ForumModel *model=_dataArray2[indexPath.row];
            
            NSArray *imageArray=[model.pic_list componentsSeparatedByString:@","];
            CGFloat heigh;
            for(int i=0;i<imageArray.count;i++)
            {
                NSArray *arr = [imageArray[i] componentsSeparatedByString:@":"];
                CGFloat scale;
                if(arr.count == 2)
                {
                    scale = [arr[1] floatValue];
                }
                if(scale)
                {
                    heigh = (kApplicationWidth-90)/scale;
                    _ImageHeigh +=heigh+10;
                }
            }
            
            _titlenameHeigh=[self getRowHeight:model.ctitle];
            _circlenameHeigh=[self getRowHeight:model.ftitle];
            _discriptionHeigh=[self getRowHeight:model.title];
            
            _Heigh=_titlenameHeigh+_circlenameHeigh+_discriptionHeigh+_ImageHeigh+80;
            return _Heigh;
        }
        */
        
    }else if (tableView==_MytableView3)
    {
        return 90;
    }
    return 0;
}

#pragma mark - ===========================================UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==_MytableView)
    {
        return _dataArray.count;
    }else if (tableView==_MytableView2)
    {
        return _dataArray2.count;
        
    }else if (tableView==_MytableView3)
    {
        return _dataArray3.count;
    }
    
    return 0;
}
-(void)viewDidLayoutSubviews
{
    if ([_MytableView2 respondsToSelector:@selector(setSeparatorInset:)]) {
        [_MytableView2 setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([_MytableView2 respondsToSelector:@selector(setLayoutMargins:)]) {
        [_MytableView2 setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==_MytableView)
    {
    
        FamilyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if(!cell)
        {
            cell=[[FamilyTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle     reuseIdentifier:@"Cell"];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;

        if(_dataArray.count)
        {
        
            ForumModel *model=_dataArray[indexPath.row];
            
            [cell refreshData:model];
        }
       
    
        return cell;
    }else if (tableView==_MytableView2)
    {
        
        static NSString *identifier=@"TimeCell";
        TimeLineTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        if(!cell)
        {
            cell=[[TimeLineTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            
        }
//        for (UIView *subview in cell.subviews) {
//            [subview removeFromSuperview];
//        }
        
//        cell.backgroundColor = [UIColor colorWithRed:arc4random()/256 green:arc4random()/256 blue:arc4random()/256 alpha:arc4random()/256];

        ForumModel *model;
        if(_dataArray2.count)
        {
           model=_dataArray2[indexPath.row];
        }
        
        cell.TitleImage.frame = CGRectMake(ZOOM(62), ZOOM(47), 50, 50);
        
        //主标题地
        cell.titlename.text=model.ctitle;
        cell.titlename.font = [UIFont systemFontOfSize:ZOOM(51)];
        
        CGFloat titlenameHeigh;
        titlenameHeigh=[self getRowHeight: cell.titlename.text fontSize:ZOOM(46)];
        cell.titlename.frame=CGRectMake(CGRectGetMaxX(cell.TitleImage.frame)+ZOOM(33), CGRectGetMidY(cell.TitleImage.frame)-titlenameHeigh/2, cell.titlename.frame.size.width, titlenameHeigh);
        
        cell.time.frame = CGRectMake(kApplicationWidth-ZOOM(62)-90, cell.titlename.frame.origin.y, 90, cell.time.frame.size.height);
        NSString *newtime=[MyMD5 compareCurrentTime:model.send_time];
        cell.time.text = [NSString stringWithFormat:@"%@",newtime];
        cell.time.textColor=kTextColor;
        cell.time.textAlignment=NSTextAlignmentRight;
        cell.time.font = [UIFont systemFontOfSize:ZOOM(40)];

        //副标题
        cell.circlename.text=[NSString stringWithFormat:@"【%@】",model.ftitle];
        CGFloat circlenameHeigh;
        circlenameHeigh=[self getRowHeight:cell.circlename.text fontSize:ZOOM(44)];
        cell.circlename.frame=CGRectMake(cell.titlename.frame.origin.x,CGRectGetMaxY(cell.TitleImage.frame)+ZOOM(20),contentWidth,circlenameHeigh);
        cell.circlename.font = [UIFont systemFontOfSize:ZOOM(44)];
        
        

        
        
        //描述内容
        cell.DiscriiptionLable.text=model.content;
        CGFloat discriptionHeigh;
        discriptionHeigh=[self getRowHeight:cell.DiscriiptionLable.text fontSize:ZOOM(37)];
        cell.DiscriiptionLable.frame=CGRectMake(cell.titlename.frame.origin.x, cell.circlename.frame.origin.y+circlenameHeigh+ZOOM(35), contentWidth, discriptionHeigh);
        cell.DiscriiptionLable.font = [UIFont systemFontOfSize:ZOOM(37)];
        
        for (UIView *view in cell.allImgView.subviews) {
            [view removeFromSuperview];
        }
        
        UIView *allimgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cell.backView.frame.size.width-ZOOM(62), 0)];
        allimgView.backgroundColor=[UIColor blueColor];
        

        NSString *last;
        if (model.pic_list.length!=0) {
            last = [model.pic_list substringFromIndex:model.pic_list.length-1];
        }
        //%@ , pic %@",last,model.pic_list);
//=======
//        
//        NSString *last ;
//        if(model.pic_list.length >0)
//        {
//            last = [model.pic_list substringFromIndex:model.pic_list.length-1];
//        }
//        
//        //%@",last);
//>>>>>>> .r11853
        if ([last isEqualToString:@","]) {
            model.pic_list = [model.pic_list substringToIndex:model.pic_list.length-1];
            //%@",model.pic_list);
        }
        //图片
        
        NSArray *imageArray;
        
        if(model.pic_list.length >0)
        {
            imageArray  = [model.pic_list componentsSeparatedByString:@","];
        }
        
        NSMutableArray *imagesArray = [NSMutableArray arrayWithArray:imageArray];

        //%lu",(unsigned long)imageArray.count);

        CGFloat totalHeith=0;

       
        if(imageArray.count && model.pic_list.length!=0)
        {
            CGFloat tempheigh=0;
            CGFloat tempY;

            for( int i=0 ;i<imageArray.count;i++)
            {
                CGFloat imageHeigh;
                CGFloat scale;
                NSString *imageUrl;
                
                NSString *detailimage =imagesArray[i];
                
                NSArray *arr =[detailimage componentsSeparatedByString:@":"];
                
//                [img addObject:arr[0]];
                
                if(arr.count == 2)
                {
                    imageUrl = arr[0];
                    scale = [arr[1] floatValue];
                }
                
                if(scale && model.pic_list.length!=0)
                {
                    imageHeigh =(kApplicationWidth-90)/scale;

                    totalHeith += imageHeigh;
                    //imgHeigh =======%f",imageHeigh);
                }
                tempY=tempheigh;
                UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, tempY+10*i, contentWidth, imageHeigh)];
                tempheigh=imageHeigh;

                
                NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!560",[NSObject baseURLStr_Upy],imageUrl]];
                __block float d = 0;
                __block BOOL isDownlaod = NO;
                [imageView sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                    d = (float)receivedSize/expectedSize;
                    isDownlaod = YES;
                } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (image != nil && isDownlaod == YES) {
                        imageView.alpha = 0;
                        [UIView animateWithDuration:0.5 animations:^{
                            imageView.alpha = 1;
                        } completion:^(BOOL finished) {
                        }];
                    } else if (image != nil && isDownlaod == NO) {
                        imageView.image = image;
                    }
                }];
                
                //&********%@",[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],imageUrl]]);
                
//                cell.bigimageview = imageView;
                [allimgView addSubview:imageView];
                
                
            }
        }
        [cell.allImgView addSubview:allimgView];
        cell.allImgView.frame=CGRectMake(cell.titlename.frame.origin.x, CGRectGetMaxY(cell.DiscriiptionLable.frame)+ZOOM(35), contentWidth, totalHeith+10*imageArray.count);
//        cell.allImgView.backgroundColor=[UIColor greenColor];
        //totoaheight ------%f",totalHeith);
        
//        cell.backView.frame=CGRectMake(cell.backView.frame.origin.x, cell.backView.frame.origin.y, cell.backView.frame.size.width,totalHeith*10*imageArray.count );
//        cell.backView.backgroundColor=[UIColor redColor];
        
        //名字
        cell.name.frame=CGRectMake(cell.titlename.frame.origin.x,CGRectGetMaxY(cell.allImgView.frame)+5, 150, 20);
        cell.name.font = [UIFont systemFontOfSize:ZOOM(40)];
        cell.name.textColor = kTextColor;
        cell.name.text=[NSString stringWithFormat:@"%@",model.nickname];
        
        if (model.r_count) {
            cell.couunt.text=[NSString stringWithFormat:@"%@",model.r_count];
        }else
        {
            cell.couunt.text=[NSString stringWithFormat:@"0"];
        }
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(40)]};
        CGSize textSize = [cell.couunt.text boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
        //%f",textSize.width);
        cell.couunt.frame=CGRectMake(kScreenWidth-textSize.width-ZOOM(62),cell.name.frame.origin.y,textSize.width, 30);
        cell.couunt.font = HBfont(ZOOM(40));
        cell.couunt.textColor = kTextColor;

        cell.commentImg.frame=CGRectMake(cell.couunt.frame.origin.x-cell.commentImg.frame.size.width, cell.couunt.frame.origin.y, cell.commentImg.frame.size.width, 30);

//        CGRect rect = [_MytableView2 rectForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
//        cell.standLine.frame=CGRectMake(cell.standLine.frame.origin.x,rect.size.height-1 , kScreenWidth, cell.standLine.frame.size.height);
//        cell.standLine.backgroundColor=lineGreyColor;
        cell.standLine.hidden=YES;
//        UIEdgeInsets edge=cell.separatorInset;
//        cell.separatorInset = UIEdgeInsetsMake(0,0,0,0);

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.backgroundColor=[UIColor whiteColor];

//        [cell.TitleImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.pic]]placeholderImage:[UIImage imageNamed:@"默认头像.jpg"]];
        
        
//        NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!180",[NSObject baseURLStr_Upy],model.pic]];
        NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!180",[NSObject baseURLStr_Upy],model.pic]];
        if ([model.pic hasPrefix:@"http://"]) {
            imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.pic]];
        }
        __block float d = 0;
        __block BOOL isDownlaod = NO;
        [cell.TitleImage sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"默认头像.jpg"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            d = (float)receivedSize/expectedSize;
            isDownlaod = YES;
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image != nil && isDownlaod == YES) {
                cell.TitleImage.alpha = 0;
                [UIView animateWithDuration:0.5 animations:^{
                    cell.TitleImage.alpha = 1;
                } completion:^(BOOL finished) {
                }];
            } else if (image != nil && isDownlaod == NO) {
                cell.TitleImage.image = image;
            }
        }];
        
        
        [cell.imgBtn addTarget:self action:@selector(tapClick:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.TitleImage.clipsToBounds=YES;
        cell.TitleImage.layer.cornerRadius=25;
        
        
        
        return cell;
        
    }else if (tableView==_MytableView3)
    {
        static NSString *identifier=@"CilcleCell";
        CircleTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        if(!cell)
        {
            cell=[[CircleTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
        ForumModel *model=_dataArray3[indexPath.row];
        [cell refreshData:model];
    
        
        cell.row=indexPath.row;
        cell.delegate=self;
        return cell;
        
    }
    
    return 0;
}
-(void)tapClick:(UIButton *)sender
{
    TimeLineTableViewCell * cell;
    if (kIOSVersions >= 7.0 && kIOSVersions < 8) {
        cell = [[(TimeLineTableViewCell *)[sender superview]superview]superview] ;
    }else{
        cell = (TimeLineTableViewCell *)[[sender superview] superview];
    }
    
    NSIndexPath *indexPath = [_MytableView2 indexPathForCell:cell];
    ForumModel *model=_dataArray2[indexPath.row];
    PostViewController *post=[[PostViewController alloc]init];
    post.circle_id=[NSString stringWithFormat:@"%@",model.circle_id];
    post.forummodel=model;
    post.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:post animated:YES];
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
- (void)addcircle:(UIButton*)sender
{
    ForumModel *model=_dataArray3[sender.tag%2000];

    NSString *circleid = model.circle_id;
    
    if(model.isNO.intValue == 0)
    {
        
//        [self AddcircleHttp:circleid];
        
    }else if (model.isNO.intValue == 1)
    {
        NavgationbarView *mentiontview = [[NavgationbarView alloc]init];
        [mentiontview showLable:@"已是该圈子成员" Controller:self];
    }

}

-(CGFloat)getRowHeight:(NSString *)text fontSize:(CGFloat)fontSize
{
    //文字高度
    CGFloat height;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(contentWidth, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
        
    }
    else{
        
    }
    return height;
}

#if 1

#pragma mark 加入圈
-(void)Addcircle:(NSInteger)index
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]==nil) {
        [self ToLoginView];
        return;
    }else{
        
        //index is %d",(int)index);
        ForumModel *model=_dataArray3[index];
        NSString *circleid=[NSString stringWithFormat:@"%@",model.circle_id];
        
        if(model.isNO.intValue == 0)
        {
            
            [self AddcircleHttp:circleid :index];
            
        }
        else if (model.isNO.intValue == 1)
        {
            
            MyLog(@"退出圈");
            
            [self ExitcircleHttp:circleid :index];
            
            //        NavgationbarView *mentiontview = [[NavgationbarView alloc]init];
            //        [mentiontview showLable:@"已是该圈子成员" Controller:self];
        }
    }
}

#endif

#pragma mark 更多圈子
-(void)footclick:(UITapGestureRecognizer*)tap
{
    
//    collectbtn.hidden = YES;
//    
//    _FootView.hidden=YES;
    

    for(int i=0;i<_titleArr.count;i++)
    {
        UIButton *btn=(UIButton*)[self.view viewWithTag:1000+i];
        UILabel *lable=(UILabel*)[self.view viewWithTag:2000+i];
        if( i == _titleArr.count-1)
        {
             [UIView animateWithDuration:0.15 animations:^{
                _stateview.frame =CGRectMake(kScreenWidth/3*2+20, _stateview.frame.origin.y, _stateview.frame.size.width, _stateview.frame.size.height);

            }];
            
            btn.selected = YES;
//            [btn setTitleColor:tarbarrossred forState:UIControlStateNormal];
            btn.backgroundColor=[UIColor clearColor];
            lable.backgroundColor=tarbarrossred;
            
//            [_MytableView3 setHidden:NO];
//            [_MytableView setHidden:YES];
//            [_MytableView2 setHidden:YES];
            
//            if(!(_currentpage3 > _pageCount3))
//            {
//                [self circleHttp];
//                
//            }
            _currentpage3=1;
            [self circleHttp];
            [self replaceController:_currentVC newController:_thirdVC];
            
        }else{
            btn.selected = NO;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            lable.backgroundColor=[UIColor clearColor];
        }
    }


    
}

/* 识别拖动 */
- (void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint location = [gestureRecognizer locationInView:_firstVC.view];
    
    [self drawImageForGestureRecognizer:gestureRecognizer atPoint:location underAdditionalSituation:nil];
    
    [gestureRecognizer setTranslation:location inView:self.view];
    
}

- (void)drawImageForGestureRecognizer:(UIGestureRecognizer *)recognizer
                              atPoint:(CGPoint)centerPoint underAdditionalSituation:(NSString *)addtionalSituation{
    if (centerPoint.y>64 &&centerPoint.y< kApplicationHeight-49+kUnderStatusBarStartY) {
        collectbtn.center = centerPoint;

    }
    collectbtn.alpha = 1.0;
}
#pragma mark 收藏的帖子
-(void)collectbtn:(UIButton*)sender
{
    //ok");
    CollectnewsViewController *collect=[[CollectnewsViewController alloc]init];
    collect.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:collect animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
