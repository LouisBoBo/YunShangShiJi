//
//  CollectnewsViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/6/15.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "CollectnewsViewController.h"
#import "GlobalTool.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "MyMD5.h"
#import "NavgationbarView.h"
#import "AFNetworking.h"
#import "CollectTableViewCell.h"
#import "ForumModel.h"
#import "UIImageView+WebCache.h"
#import "LoginViewController.h"
#import "InvitationViewController.h"
#import "MJRefresh.h"

#import "SmileView.h"

@interface CollectnewsViewController ()
{
    UITableView *_Mytableview;
    
    
    //数据源
    NSMutableArray *_CollectionArray;
    
    BOOL _isedit;
    
    //选择按钮
    UIButton *_SelectBtn;
    NSMutableArray *_selectArray;
    
    //编辑按钮
    UIButton *_setting;
    
    UIButton *_DeleteButton;
    
    UIView *_footview;
    
    //当前页数
    NSInteger _currentpage;
    //商品总页数
    NSInteger _pageCount;
    
    //记录是发帖还是收藏帖子
    NSString *_typestring;

}
@end

@implementation CollectnewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _isedit=NO;
    
    _CollectionArray=[NSMutableArray array];
    _selectArray=[NSMutableArray array];
    
    _typestring = @"发帖";
    
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    
    //    headview.image=[UIImage imageNamed:@"u265"];
    headview.backgroundColor=[UIColor whiteColor];
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
    titlelable.text=@"收藏列表";
    titlelable.textColor= kMainTitleColor;
    titlelable.font = kNavTitleFontSize;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    _setting=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _setting.frame=CGRectMake(kApplicationWidth-60, titlelable.frame.origin.y, 50, 40);
    [_setting setTitle:@"编辑" forState:UIControlStateNormal];
    _setting.tintColor=kTitleColor;
    _setting.titleLabel.font = [UIFont systemFontOfSize:ZOOM(50)];
    [_setting addTarget:self action:@selector(editClick:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:_setting];
    
    
    _footview=[[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight-50+kUnderStatusBarStartY, kApplicationWidth, 50)];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 1)];
    line.backgroundColor = lineGreyColor;
    [_footview addSubview:line];
    _footview.backgroundColor=[UIColor whiteColor];
    _footview.tag=9999;
    
    
    
    [self creatHeadView];
    
    [self creatTableView];
    
    [self creatFootView];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
//    [_CollectionArray removeAllObjects];
    Myview.hidden=YES;
    for(int i=0;i<2;i++)
    {
        UIButton *btn = (UIButton *)[self.view viewWithTag:8888+i];
        if (btn.selected==YES && i==0) {
             [self requestSubmitHttp];
        }else if (btn.selected == YES && i==1)
        {
            [self requestHttp];
        }
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    Myview.hidden=NO;
}

-(void)creatData
{
    //首次进来所选商品数为0 总金额为0
    
    [_selectArray removeAllObjects];
    
    for(int i=0;i<_CollectionArray.count;i++)
    {
        [_selectArray addObject:@"0"];
    }
    
    
}

#pragma mark 网络请求发帐号记录
-(void)requestSubmitHttp
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    
    url=[NSString stringWithFormat:@"%@circle/queryUserNewsList?version=%@&token=%@&bool=true",[NSObject baseURLStr],VERSION,token];
    
    NSString *URL=[MyMD5 authkey:url];
       // [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [MBProgressHUD hideHUDForView:self.view];
         [[Animation shareAnimation] stopAnimationAt:self.view];
        
        [_CollectionArray removeAllObjects];

//        //
        
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
                    model.upic=dic[@"pic"];
                    model.pic_list=dic[@"pic_list"];
                    model.send_time=dic[@"send_time"];
                    model.title=dic[@"title"];
                    model.user_id=dic[@"user_id"];
                    
                    
                    [_CollectionArray addObject:model];
                }
                if (_CollectionArray.count > 0) {
                    
                    //                _MytableView.tableFooterView = [self creatfootView];
                    
                    _Mytableview.tableFooterView=nil;
                    
                    
                    
                    
                }else if(_CollectionArray.count==0||responseObject[@"news"]==nil){
                    
                    
                    SmileView *smileView = [[SmileView alloc]initWithFrame:CGRectMake(0,0, kApplicationWidth, kApplicationHeight-74-49+kUnderStatusBarStartY)];
                    smileView.backgroundColor=[UIColor whiteColor];
                    smileView.str = @"O(n_n)O~亲~";
                    smileView.str2 = @"暂时没有发帖记录";
                    
                    _Mytableview.tableFooterView = smileView;
                }
                
                [self creatData];
                
                [_Mytableview reloadData];
                [self updateDeleteButtonTitle];
            }else{
                
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //[MBProgressHUD hideHUDForView:self.view];
         [[Animation shareAnimation] stopAnimationAt:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
        
    }];
    
    
    
}
#pragma mark 删除发帖记录
-(void)deleateHttp:(NSString*)newsid cid:(NSString *)circle_id
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSArray *arr=[newsid componentsSeparatedByString:@","];
    NSString *url;
    if(arr.count>1)
    {
        url=[NSString stringWithFormat:@"%@circleNews/delNews?version=%@&token=%@&news_ids=%@",[NSObject baseURLStr],VERSION,token,newsid];
    }else{
        url=[NSString stringWithFormat:@"%@circleNews/delNews?version=%@&token=%@&&news_id=%@",[NSObject baseURLStr],VERSION,token,newsid];
    }
    
    
    NSString *URL=[MyMD5 authkey:url];
//    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        [MBProgressHUD hideHUDForView:self.view];
         [[Animation shareAnimation] stopAnimationAt:self.view];
        
//        //
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message;
            
            if(statu.intValue==1)//请求成功
            {
                NSMutableArray *indexarray=[NSMutableArray array];
                for(int i=0;i<_selectArray.count;i++)
                {
                    
                    if([_selectArray[i] isEqualToString:@"1"])
                    {
                        [indexarray addObject:[NSString stringWithFormat:@"%d",i]];
                    }
                    
                }
                
                [_CollectionArray removeObjectsInArray:indexarray];
                [_selectArray removeObjectsInArray:indexarray];
                
                
                [self requestSubmitHttp];
                
                message=@"删除成功";
            }else{
                message=@"删除失败";
            }
            
            //        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            //        [mentionview showLable:message Controller:self];

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

#pragma mark 网络请求收藏记录
-(void)requestHttp
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    
    url=[NSString stringWithFormat:@"%@circle/queryCollectList?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    NSString *URL=[MyMD5 authkey:url];
//        [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [MBProgressHUD hideHUDForView:self.view];
         [[Animation shareAnimation] stopAnimationAt:self.view];
        
        [_CollectionArray removeAllObjects];

//        //
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message;
            
            if(statu.intValue==1)//请求成功
            {
                
                for(NSDictionary *dic in responseObject[@"collects"])
                {
                    ForumModel *model=[[ForumModel alloc]init];
                    model.news_id=dic[@"news_id"];
                    model.nickname=dic[@"nickname"];
                    model.title=dic[@"title"];
                    model.upic=dic[@"upic"];
                    model.user_id=dic[@"user_id"];
                    model.npic=dic[@"npic"];
                    model.pic_list=dic[@"pic_list"];
                    model.circle_id = dic[@"circle_id"];
                    [_CollectionArray addObject:model];
                }
                
                if (_CollectionArray.count > 0) {
                    

                    
                    _Mytableview.tableFooterView=nil;
                    
                    
                    
                    
                }else if(_CollectionArray.count==0||responseObject[@"news"]==nil){
                    
                    
                    SmileView *smileView = [[SmileView alloc]initWithFrame:CGRectMake(0,0, kApplicationWidth, kApplicationHeight-74-49+kUnderStatusBarStartY)];
                    smileView.backgroundColor=[UIColor whiteColor];
                    smileView.str = @"O(n_n)O~亲~";
                    smileView.str2 = @"暂时没有收藏纪录";
                    
                    _Mytableview.tableFooterView = smileView;
                }
                
                [self creatData];
                
                [_Mytableview reloadData];
                [self updateDeleteButtonTitle];
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

#pragma mark 删除收藏的帖子
-(void)deleateCollectHttp:(NSString*)collectNewsid
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSArray *arr=[collectNewsid componentsSeparatedByString:@","];
    NSString *url;
    if(arr.count>1)
    {
        url=[NSString stringWithFormat:@"%@circleNews/deleteCollectNews?version=%@&token=%@&news_ids=%@",[NSObject baseURLStr],VERSION,token,collectNewsid];
    }else{
        url=[NSString stringWithFormat:@"%@circleNews/deleteCollectNews?version=%@&token=%@&news_id=%@",[NSObject baseURLStr],VERSION,token,collectNewsid];
    }
    
    
    NSString *URL=[MyMD5 authkey:url];
//    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        [MBProgressHUD hideHUDForView:self.view];
         [[Animation shareAnimation] stopAnimationAt:self.view];
        
//        //
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message;
            
            if(statu.intValue==1)//请求成功
            {
                NSMutableArray *indexarray=[NSMutableArray array];
                for(int i=0;i<_selectArray.count;i++)
                {
                    
                    if([_selectArray[i] isEqualToString:@"1"])
                    {
                        [indexarray addObject:[NSString stringWithFormat:@"%d",i]];
                    }
                    
                }
                
                [_CollectionArray removeObjectsInArray:indexarray];
                [_selectArray removeObjectsInArray:indexarray];
                
                
                [self requestHttp];
                
                message=@"删除成功";
            }else{
                message=@"删除失败";
            }
            
            //        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            //        [mentionview showLable:message Controller:self];
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
- (void)creatFootView
{
    UIButton *selectbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    selectbutton.frame=CGRectMake(ZOOM(65), 15, 20, 20);
    selectbutton.tag=2222;
//    [selectbutton  setTitle:@"全选" forState:UIControlStateNormal];
    [selectbutton setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    [selectbutton setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    [selectbutton addTarget:self action:@selector(allSelect:) forControlEvents:UIControlEventTouchUpInside];
    [_footview addSubview:selectbutton];
    
    CGFloat lableX= CGRectGetMaxX(selectbutton.frame);
    
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(lableX +ZOOM(50), 15, 40, 20)];
    lable.text=@"全选";
    lable.font=[UIFont systemFontOfSize:ZOOM(50)];
    [_footview addSubview:lable];
    
    _DeleteButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _DeleteButton.frame=CGRectMake(kApplicationWidth-70-ZOOM(60), 10, 70, 30);
    [_DeleteButton setTitle:@"删除" forState:UIControlStateNormal];
    _DeleteButton.tintColor=[UIColor whiteColor];
    _DeleteButton.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
    [_DeleteButton setBackgroundColor:kbackgrayColor];
    [_DeleteButton setUserInteractionEnabled:NO];
    //    [_DeleteButton setBackgroundImage:[UIImage imageWithCGImage:<#(CGImageRef)#>] forState:<#(UIControlState)#>]
    
    [_DeleteButton addTarget:self action:@selector(deleate:) forControlEvents:UIControlEventTouchUpInside];
    [_footview addSubview:_DeleteButton];
    
}
-(void)creatHeadView
{
    NSArray *titlearr=@[@"发帖记录",@"收藏记录"];
    CGFloat btnwidh=kApplicationWidth/2;
    for(int i=0;i<titlearr.count;i++)
    {
        //按钮
        self.statebtn1=[UIButton buttonWithType:UIButtonTypeCustom];
        self.statebtn1.frame=CGRectMake(btnwidh*i, 64, btnwidh, 40);
        [self.statebtn1 setTitle:titlearr[i] forState:UIControlStateNormal];
        [self.statebtn1 setTitleColor:kTitleColor forState:UIControlStateNormal];
        self.statebtn1.titleLabel.font= [UIFont systemFontOfSize:ZOOM(50)];
//        self.statebtn1.backgroundColor=kBackgroundColor;
        self.statebtn1.tag=8888+i;
        [self.statebtn1 addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:self.statebtn1];
        
        
        //设置进来时选中的按键
        if(i==0)
        {
            [self.statebtn1 setTitleColor:tarbarrossred forState:UIControlStateNormal];;
//            self.statebtn1.backgroundColor=tarbarrossred;
            self.statebtn1.selected=YES;
            self.slectbtn1=_statebtn1;
        }
    }
    UIView *centerline = [[UIView alloc]initWithFrame:CGRectMake(kApplicationWidth/2, _statebtn1.frame.origin.y+10, 1, 20)];
    centerline.backgroundColor = lineGreyColor;
    [self.view addSubview:centerline];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, _statebtn1.frame.origin.y+_statebtn1.frame.size.height-1, kApplicationWidth, 1)];
    line.backgroundColor = lineGreyColor;
    [self.view addSubview:line];
    
}

#pragma mark 一级按钮监听事件
-(void)btnclick:(UIButton*)sender
{
    [_setting setTitle:@"编辑" forState:UIControlStateNormal];
    
    UIImageView *footview=(UIImageView*)[self.view viewWithTag:9999];
    [footview removeFromSuperview];
    
    _isedit=NO;
    
    for(int i=0;i<2;i++)
    {
        UIButton *btn=(UIButton*)[self.view viewWithTag:8888+i];
        
        if(i+8888==sender.tag)
        {
            [btn setTitleColor:tarbarrossred forState:UIControlStateNormal];
//            btn.backgroundColor=tarbarrossred;
            
            if(btn.tag==8888)
            {
                [self requestSubmitHttp];
                _typestring = @"发帖";
                
            }else{
                [self requestHttp];
                
                _typestring = @"藏帖";
            }
            
           
            
        }else{
            [btn setTitleColor:kTitleColor forState:UIControlStateNormal];
//            btn.backgroundColor=kBackgroundColor;
            
           
        }
        
    }
    
    self.slectbtn1.selected=NO;
    sender.selected=YES;
    self.slectbtn1=sender;
    
    
}


-(void)creatTableView
{
    _Mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 40+Height_NavBar, kApplicationWidth, kApplicationHeight-Height_NavBar-kUnderStatusBarStartY) style:UITableViewStylePlain];
    _Mytableview.dataSource=self;
    _Mytableview.delegate=self;
    _Mytableview.rowHeight=100;
    _Mytableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 设置tableView可不可以选中
    _Mytableview.allowsSelection = NO;
    
    // 允许tableview多选
    _Mytableview.allowsMultipleSelection = YES;
    
    // 编辑模式下是否可以多选
    _Mytableview.allowsMultipleSelectionDuringEditing = YES;
    
    // 获取被选中的所有行
    
    
    [self.view addSubview:_Mytableview];
    
    [_Mytableview registerNib:[UINib nibWithNibName:@"CollectTableViewCell" bundle:nil] forCellReuseIdentifier:@"CollectCell" ];
    
//    [_Mytableview addFooterWithCallback:^{
//        _currentpage++;
//        
//        [self requestHttp];
//        
//    }];
//    
//    [_Mytableview addHeaderWithCallback:^{
//        _currentpage = 1;
//        
//        [self requestHttp];
//    }];
//
    
}

#pragma mark------------------------------UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _CollectionArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CollectCell"];
    if(!cell)
    {
        cell=[[CollectTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CollectCell"];
    }
    else
    {
//        [cell removeFromSuperview];
    }
    cell.selectbtn.selected=NO;
    ForumModel *model=_CollectionArray[indexPath.row];
    
    cell.titleimage.hidden = NO;
    
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!180",[NSObject baseURLStr_Upy],model.upic]];
    if ([model.upic hasPrefix:@"http://"]) {
        imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.upic]];
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
    
    cell.titleimage.frame = CGRectMake(ZOOM(34), ZOOM(35), cell.titleimage.frame.size.width, cell.titleimage.frame.size.height);
    
    cell.titleimage.clipsToBounds=YES;
    cell.titleimage.layer.cornerRadius=20;
    
    cell.title.text=model.nickname;
    cell.title.font = [UIFont systemFontOfSize:ZOOM(48)];
    cell.title.textColor = kTitleColor;
    
    NSString *picstr ;
    if([_typestring isEqualToString:@"发帖"])//发的帖子
    {
        picstr = model.pic_list;
        
    }else{
        
        picstr = model.npic;
    }
    
    if(picstr ==nil || [picstr isEqualToString:@""])
    {
        cell.headimage.hidden = YES;
        
        cell.content.frame = CGRectMake(cell.headimage.frame.origin.x, cell.content.frame.origin.y, cell.headimage.frame.size.width + cell.content.frame.size.width, cell.content.frame.size.height);

        
        NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!180",[NSObject baseURLStr_Upy],model.upic]];
        if ([model.upic hasPrefix:@"http://"]) {
            imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.upic]];
        }
        [cell.headimage sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"默认头像.jpg"]];
        
        
    }else{
        NSArray *piclist=[picstr componentsSeparatedByString:@","];
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
            
            NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!180",[NSObject baseURLStr_Upy],imageurl]];

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
    cell.content.textColor = kTextColor;
    cell.content.font = [UIFont systemFontOfSize:ZOOM(44)];
    
    if(_isedit==YES)
    {
        cell.titleimage.hidden = YES;
        //选择按钮
//        cell.selectbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        cell.selectbtn.frame=CGRectMake(ZOOM(65), cell.frame.size.height/2, 20, 20);
        cell.selectbtn.clipsToBounds=YES;
        cell.selectbtn.layer.cornerRadius=10;
        cell.selectbtn.tag=2000+indexPath.row;
        
        [cell.selectbtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
        [cell.selectbtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
        
        [cell.selectbtn addTarget:self action:@selector(singleselect:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectbtn.hidden=NO;
//        [cell addSubview:_SelectBtn];
//        cell.selectbtn=_SelectBtn;
        
    }else{
        cell.selectbtn.hidden=YES;
        
//        for (id obj in cell.subviews)  {
//            if ([obj isKindOfClass:[UIButton class]]) {
//                UIButton* theButton = (UIButton*)obj;
////                [theButton setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
//                [theButton removeFromSuperview];
//            }
//        }
        
        
    }
    
    //标识按钮的状态 1为选中 0没选中
    if(_selectArray.count)
    {
        if([_selectArray[indexPath.row] isEqualToString:@"1"])
        {
            cell.selectbtn.selected=YES;
        }else{
            cell.selectbtn.selected=NO;
            
        }
    }
    
    return cell;
}
//先要设Cell可编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//进入编辑模式，按下出现的编辑按钮后
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if(editingStyle==UITableViewCellEditingStyleDelete)
//    {
//
//        CollectModel *model=_CollectionArray[indexPath.row];
//        NSString *newsid=model.news_id;
//                [self deleateHttp:newsid];


//        获取选中删除行索引值
//        NSInteger row = [indexPath row];
//        通过获取的索引值删除数组中的值
//        [_CollectionArray removeObjectAtIndex:row];
//        删除单元格的某一行时，在用动画效果实现删除过程
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
//
//}

#pragma mark------------------------------UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isedit == YES) {
        
        if ([_selectArray[indexPath.row] isEqualToString:@"0"]) {
            _selectArray[indexPath.row]=@"1";
        }else{
            _selectArray[indexPath.row]=@"0";

        }
        UIButton *selectbtn=(UIButton*)[self.view viewWithTag:2222];
        selectbtn.selected=NO;
        [self updateDeleteButtonTitle];
        

        NSIndexPath *indexPath_1=[NSIndexPath indexPathForRow:indexPath.row inSection:0];
        NSArray *indexArray=[NSArray arrayWithObject:indexPath_1];
        [_Mytableview reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationAutomatic];
//        [_Mytableview reloadData];
    }else
    {
        ForumModel *model=_CollectionArray[indexPath.row];
        
        InvitationViewController *invitation=[[InvitationViewController alloc]init];
        invitation.circle_id=[NSString stringWithFormat:@"%@",model.circle_id];
        invitation.model=model;
        [self.navigationController pushViewController:invitation animated:YES];
    }
    
}
//定义编辑样式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleDelete ;
    
}

//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}




#pragma mark 编辑
-(void)editClick:(UIButton*)sender
{
    if(_isedit==NO)
    {
        [_setting setTitle:@"取消" forState:UIControlStateNormal];
        
        [self.view addSubview:_footview];
        
        UIButton *selectbtn=(UIButton*)[self.view viewWithTag:2222];
        selectbtn.selected=NO;
//        [selectbtn setBackgroundImage:[UIImage imageNamed:@"icon_my_edit_sex_option@2x"] forState:UIControlStateNormal];
        
        _isedit=YES;
        
         _Mytableview.frame = CGRectMake(_Mytableview.frame.origin.x, _Mytableview.frame.origin.y, _Mytableview.frame.size.width, _Mytableview.frame.size.height-50);
        
    }else{
        
        [_setting setTitle:@"编辑" forState:UIControlStateNormal];
        
        UIImageView *footview=(UIImageView*)[self.view viewWithTag:9999];
        [footview removeFromSuperview];
        
        [_footview removeFromSuperview];
        
        _isedit=NO;
        
        for(int i=0;i<_selectArray.count;i++)
        {
            _selectArray[i]=@"0";
        }
        
         _Mytableview.frame = CGRectMake(_Mytableview.frame.origin.x, _Mytableview.frame.origin.y, _Mytableview.frame.size.width, _Mytableview.frame.size.height+50);
        
    }
    [self updateDeleteButtonTitle];

    [_Mytableview reloadData];
}

#pragma mark 全选
-(void)allSelect:(UIButton*)sender
{
    //全选");
    sender.selected=!sender.selected;
    if(sender.selected)
    {
        for(int i=0;i<_selectArray.count;i++)
        {
            _selectArray[i]=@"1";
        }
        
//        [sender setBackgroundImage:[UIImage imageNamed:@"icon_my_edit_sex_option_on@2x"] forState:UIControlStateNormal];
        
    }else{
        
        for(int i=0;i<_selectArray.count;i++)
        {
            _selectArray[i]=@"0";
        }
        
//        [sender setBackgroundImage:[UIImage imageNamed:@"icon_my_edit_sex_option@2x"] forState:UIControlStateNormal];
        
    }
    [self updateDeleteButtonTitle];
    [_Mytableview reloadData];
}

#pragma mark 单选
-(void)singleselect:(UIButton*)sender
{
    sender.selected=!sender.selected;
    if(sender.selected==YES)
    {
        _selectArray[sender.tag%2000]=@"1";
        
    }
    else{
        _selectArray[sender.tag%2000]=@"0";
        
    }
    [self updateDeleteButtonTitle];
    [_Mytableview reloadData];
}

#pragma mark - button
-(void)updateDeleteButtonTitle
{
    //selectArray:%d",_selectArray.count);
    NSMutableArray *array = [NSMutableArray array];
        for(int i=0;i<_selectArray.count;i++)
        {
            if ([_selectArray[i] isEqualToString:@"1"]) {
                [array addObject:_selectArray[i]];
                
                [_DeleteButton setBackgroundColor:tarbarrossred];
                _DeleteButton.userInteractionEnabled = YES;

            }
            if ([_selectArray[i]isEqualToString:@"0"]) {
                UIButton *selectbtn=(UIButton*)[self.view viewWithTag:2222];
                selectbtn.selected=NO;
                
            }
        }
    if (_selectArray.count == 0||array.count==0) {
        [_DeleteButton setBackgroundColor:kbackgrayColor];
        _DeleteButton.userInteractionEnabled = NO;

    }
    
}

#pragma mark 批量删除
-(void)deleate:(UIButton*)sender
{
    //deleate");
    
    NSMutableString *str=[NSMutableString string];
    NSMutableString *str2=[NSMutableString string];
    
    NSMutableArray *indexarray=[NSMutableArray array];
    for(int i=0;i<_selectArray.count;i++)
    {
        if([_selectArray[i] isEqualToString:@"1"])//将选中的商品提出来
        {
            ForumModel *model=_CollectionArray[i];
            
            [str appendString:[NSString stringWithFormat:@"%@",model.news_id]];
            [str appendString:@","];
            
            [str2 appendString:[NSString stringWithFormat:@"%@",model.circle_id]];
            [str2 appendString:@","];
            
            [indexarray addObject:[NSString stringWithFormat:@"%d",i]];
            
        }
        
    }
    
    NSString *ccc=[str substringToIndex:[str length]-1];
    NSString *ccc2=[str2 substringToIndex:[str2 length]-1];
    //ccc---ccc2-------%@   %@",ccc,ccc2);
    
    for(int i=0;i<2;i++)
    {
        UIButton *btn=(UIButton*)[self.view viewWithTag:8888+i];
        
        if (btn.selected == YES) {
            if(btn.tag==8888)
            {
                [self deleateHttp:ccc cid:ccc2];
            }else{
                [self deleateCollectHttp:ccc];
            }
            
        }
        
    }
    
    //    for(int i=0;i<_selectArray.count;i++)
    //    {
    //        if([_selectArray[i] isEqualToString:@"1"])
    //        {
    //            CollectModel *model=_DataArray[i];
    //            NSString *newsid=model.news_id;
    //
    //            [self deleateHttp:newsid];
    //        }
    //    }
    
    UIButton *selectbtn=(UIButton*)[self.view viewWithTag:2222];
    selectbtn.selected=NO;
//    [selectbtn setBackgroundImage:[UIImage imageNamed:@"icon_my_edit_sex_option@2x"] forState:UIControlStateNormal];
    
    
    
    
}
-(void)back
{
    NSNotification *backnote = [[NSNotification alloc]initWithName:@"backnote" object:self userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:backnote];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
