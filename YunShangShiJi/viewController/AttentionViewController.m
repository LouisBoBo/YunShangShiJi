//
//  AttentionViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/6/29.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "AttentionViewController.h"
#import "AFNetworking.h"
#import "GlobalTool.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "NavgationbarView.h"
#import "MyMD5.h"
#import "CircleTableViewCell.h"
#import "ForumModel.h"
#import "PostViewController.h"
#import "LoginViewController.h"
#import "MJRefresh.h"
#import "TFLoginView.h"
#import "SmileView.h"

@interface AttentionViewController ()<AddcircleDelegate>
{
    UITableView *_Mytableview;
    
    NSMutableArray *_DataArray;
    
    //当前页
    NSInteger _currentPage;
    
    //总页数
    NSInteger _pageCount;
    
    //记录选择数据的下标
    int _publicIndex;

}
@end

@implementation AttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    _DataArray=[NSMutableArray array];
    
    _currentPage = 1;
    
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
//    headview.image=[UIImage imageNamed:@"u265"];
    headview.backgroundColor = [UIColor whiteColor];
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
    titlelable.text=@"关注";
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    titlelable.font = kNavTitleFontSize;
    [headview addSubview:titlelable];
    
    [self requestHttp];
    
    [self creatTableview];

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
-(void)creatTableview
{
    _Mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar+10, kApplicationWidth, kApplicationHeight-Height_NavBar+kUnderStatusBarStartY-10) style:UITableViewStylePlain];
    _Mytableview.delegate=self;
    _Mytableview.dataSource=self;
    _Mytableview.tableFooterView = [[UIView alloc]init];
    _Mytableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    _Mytableview.rowHeight=90;
    [self.view addSubview:_Mytableview];
    
    [_Mytableview registerNib:[UINib nibWithNibName:@"CircleTableViewCell" bundle:nil] forCellReuseIdentifier:@"CilcleCell"];
    
    
    [_Mytableview addFooterWithCallback:^{
       
       if(_currentPage < _pageCount || _currentPage == _pageCount)
       {
       
           [self requestHttp];
           
       }else{
       
           [_Mytableview headerEndRefreshing];
           [_Mytableview footerEndRefreshing];
       }
        
    }];
    
    [_Mytableview addHeaderWithCallback:^{
        
        _currentPage =1;
        
        [_DataArray removeAllObjects];
        
        [self requestHttp];
        
    }];

}

#pragma mark 关注列表
-(void)requestHttp
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    
    if(token !=nil)
    {
        url=[NSString stringWithFormat:@"%@circle/queryUserCircleList?version=%@&token=%@&user_id=%@&pager.curPage=%d",[NSObject baseURLStr],VERSION,token,self.userid,(int)_currentPage];
        
    }else{
        
        url=[NSString stringWithFormat:@"%@circle/queryUCLUnLogin?version=%@&user_id=%@&pager.curPage=%d",[NSObject baseURLStr],VERSION,self.userid,(int)_currentPage];

    }
    
    NSString *URL=[MyMD5 authkey:url];
    MyLog(@"&&&&&&&&&url is %@",URL);
    
//    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
        [_Mytableview headerEndRefreshing];
        [_Mytableview footerEndRefreshing];
        
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            
            if(statu.intValue==1)//请求成功
            {
                _currentPage ++;
                
                for(NSDictionary *dic in responseObject[@"circles"])
                {
                    ForumModel *model=[[ForumModel alloc]init];
                    
                    model.n_count=dic[@"n_count"];
                    model.circle_id=dic[@"circle_id"];
                    model.content=dic[@"content"];
                    model.pic=dic[@"pic"];
                    model.title=dic[@"title"];
                    model.u_count=dic[@"u_count"];
                    model.isNO=dic[@"isNo"];
                    
                    [_DataArray addObject:model];
                }
                
                NSString *pagercount =[NSString stringWithFormat:@"%@",responseObject[@"pager"][@"pageCount"]];
                
                _pageCount = pagercount.intValue;
                
                [_Mytableview reloadData];
                
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

            
            if (_DataArray.count==0) {
                SmileView *smileView = [[SmileView alloc]initWithFrame:CGRectMake(0,64, kScreenWidth, kScreenHeight-74-49)];
                smileView.backgroundColor=[UIColor whiteColor];
                smileView.str = @"O(n_n)O~亲~";
                smileView.str2 = @"还没有关注哦!";
                [self.view addSubview:smileView];
            }

        }
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        [_Mytableview headerEndRefreshing];
        [_Mytableview footerEndRefreshing];
        
        [MBProgressHUD hideHUDForView:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            //===== 请求超时");
            
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
    
    NSString *url;
    url=[NSString stringWithFormat:@"%@circle/add?version=%@&token=%@&circle_id=%@",[NSObject baseURLStr],VERSION,token,circleid];
    
    NSString *URL=[MyMD5 authkey:url];
    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
        //
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(statu.intValue==1)//请求成功
            {
                message=@"恭喜你成功加入该圈";
                
                ForumModel *model=_DataArray[_publicIndex];
                model.isNO = @"1";
                
                [_Mytableview reloadData];
                
            }else{
                message=@"加入该圈失败";
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            //===== 请求超时");
            
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
    
    NSString *url;
    url=[NSString stringWithFormat:@"%@circle/del?version=%@&token=%@&circle_id=%@",[NSObject baseURLStr],VERSION,token,circleid];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(statu.intValue==1)//请求成功
            {
                message=@"退出圈成功";
            
                ForumModel *model=_DataArray[_publicIndex];
                model.isNO = @"0";
                
                [_Mytableview reloadData];
                
            }else{
                message=@"退出圈失败";
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
            

            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"系统繁忙，请稍后再试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alter show];
        
    }];
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ForumModel *model = _DataArray[indexPath.row];
    
    PostViewController *post=[[PostViewController alloc]init];
    post.circle_id=[NSString stringWithFormat:@"%@",model.circle_id];
    post.forummodel=model;
    [self.navigationController pushViewController:post animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _DataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"CilcleCell";
    CircleTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell=[[CircleTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ForumModel *model;
    
    if(_DataArray.count)
    {
    
        model=_DataArray[indexPath.row];
    }
    
//    cell.addcircle.frame = CGRectMake(kApplicationWidth -ZOOM(38) -IMGSIZEW(@"加好友_默认"), (cell.frame.size.height - IMGSIZEH(@"加好友_默认"))/2, IMGSIZEW(@"加好友_默认"), IMGSIZEH(@"加好友_默认"));

    [cell refreshData2:model];
    
    cell.row=indexPath.row;
    cell.delegate=self;
    return cell;
    
}
#pragma mark 加入
-(void)Addcircle:(NSInteger)index
{
    
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *token = [userdefaul objectForKey:USER_TOKEN];
    if(token == nil)
    {
        [self ToLoginView];
        
        return;
    }

    
    _publicIndex = (int)index;
    
    ForumModel *model=_DataArray[index];
    NSString *circleid=[NSString stringWithFormat:@"%@",model.circle_id];
    
    if(model.isNO.intValue == 1)
    {
        [self ExitcircleHttp:circleid];
    }else{
        [self AddcircleHttp:circleid];
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


-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
