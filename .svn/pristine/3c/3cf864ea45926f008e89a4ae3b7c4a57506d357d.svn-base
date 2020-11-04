//
//  DianPumeiyiViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/17.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "DianPumeiyiViewController.h"
#import "DianpuTableViewCell.h"
#import "CollectionViewCell.h"
#import "WaterFLayout.h"
#import "GlobalTool.h"
#import "DianpuModel.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "MyMD5.h"
#import "ShopDetailViewController.h"
#import "SpecialShopDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "NavgationbarView.h"
#import "ShopDetailModel.h"
#import "MJRefresh.h"
#import "WaterFlowCell.h"
#import "TFBackgroundView.h"
#import "LoginViewController.h"
#import "TFShoppingVM.h"
//#import "ComboShopDetailViewController.h"
#import "AppDelegate.h"
@interface DianPumeiyiViewController ()<OverheadDelegate>
@property (nonatomic, strong) TFShoppingVM *viewModel;
@property (nonatomic, assign) CGFloat reduceMoney;
@property (nonatomic, copy)   NSString * shop_deduction;
@property (nonatomic, strong) NSNumber *isVip;
@property (nonatomic, strong) NSNumber *maxType;
@end

@implementation DianPumeiyiViewController
{
    //列表
//    UITableView *_MytableView;
    //数据源
    NSMutableArray *_dataArray;
    
    //失效产品数据源
    NSMutableArray *_deldataArray;
    
    NSMutableArray *_allArray;
    
    //瀑布列表
    UICollectionView *_Mycollection;
    
    CGSize _size;
    
    //商品刷新到第几页
     NSInteger _currentpage;
    
//    NSInteger _allCurrentPage;
//    NSInteger _delCurrentPage;

    //商品总页数
    NSString *_pageCount;
    
    //消失商品总页数
    NSString *_delCount;
    //全部商品总页数
    NSString *_allCount;
    
    //记录编辑按钮
    BOOL _edit;
    
    //记录失效按钮
    BOOL _isdel;
    
    UIButton *_setting;
    
    //商品分类
    UILabel *_titlelable;
    
    //选择的商品
    UIButton *_SelectBtn;
    
    NSMutableArray * _selectArray;
    UIView *_Footview;
    
    //记录选择的商品数量
    NSInteger _selectCount;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    _selectCount=0;
    _currentpage=1;
//    _allCurrentPage = 1;
//    _delCurrentPage = 1;

    _pageCount=@"1";
    _delCount = @"1";
    _allCount = @"1";
    
    _edit=NO;
    _isdel=NO;
    
    _dataArray=[NSMutableArray array];
    _deldataArray=[NSMutableArray array];
    _allArray=[NSMutableArray array];
    _selectArray=[NSMutableArray array];
    
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
    titlelable.text=self.titleString;
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    _setting=[[UIButton alloc]init];
    _setting.frame=CGRectMake(kApplicationWidth-60, 23, 50, 40);
    _setting.centerY = View_CenterY(headview);
    [_setting setTitle:@"编辑" forState:UIControlStateNormal];
    _setting.titleLabel.font=[UIFont systemFontOfSize:ZOOM(57)];
    _setting.tintColor=[UIColor blackColor];
    [_setting setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _setting.tag=1111;
    [_setting addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:_setting];

//    [self requestHTTP:_currentpage];
    [self setData];
    [self creatHeadview];
    [self creatCollectionView];

    
    
}
- (void)setData
{
    kSelfWeak;
    [self.viewModel netWorkGetBrowsePageListWithReduceMoneySuccess:^(NSDictionary *data, Response *response) {
        if(response.status == 1)
        {
            weakSelf.reduceMoney = [data[@"one_not_use_price"] floatValue];
            weakSelf.shop_deduction = data[@"shop_deduction"];
            weakSelf.isVip = data[@"isVip"];
            weakSelf.maxType = data[@"maxType"];
        }
        [weakSelf requestHTTP:_currentpage];
    } failure:^(NSError *error) {
        
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Myview.hidden=YES;
    
//    _currentpage=1;
//    [self requestHTTP:1];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
}

#pragma mark 下拉刷新
-(void)addheadFresh
{
    kSelfWeak;
    [_Mycollection addHeaderWithCallback:^{
    
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if(! (_currentpage > _pageCount.intValue) && _currentpage !=1)
            {
               [weakSelf requestHTTP:_currentpage];
                
            }
            
            // 结束刷新
            [_Mycollection headerEndRefreshing];
        });
    }];
    
    [_Mycollection headerBeginRefreshing];
}



#pragma mark 网络请求
-(void)requestHTTP:(NSInteger)page
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[NSString stringWithFormat:@"%@",[userdefaul objectForKey:USER_TOKEN]];
    NSString *storecode=[userdefaul objectForKey:STORE_CODE];
    NSString *realm =[userdefaul objectForKey:USER_REALM];

    
    
    NSString *url;
    if (page == 1) {
        [_selectArray removeAllObjects];
    }
    if([self.titleString isEqualToString:@"我的最爱"])
    {
        
        if(_isdel == NO)//全部
        {
            if (page == 1) {
                [_allArray removeAllObjects];
            }
            url = [NSString stringWithFormat:@"%@like/selLike?version=%@&token=%@&pager.curPage=%d&is_del=0",[NSObject baseURLStr],VERSION,token,(int)page];
        }else{
            if (page == 1) {
                [_deldataArray removeAllObjects];
            }
            url = [NSString stringWithFormat:@"%@like/selLike?version=%@&token=%@&pager.curPage=%d&is_del=1",[NSObject baseURLStr],VERSION,token,(int)page];

        }
       
    }else if ([self.titleString isEqualToString:@"店铺美衣"])
    {
        url = [NSString stringWithFormat:@"%@shopStore/queryStoreShop?version=%@&token=%@&store_code=%@&pager.curPage=%d",[NSObject baseURLStr],VERSION,token,storecode,(int)page];
        
    }else if ([self.titleString isEqualToString:@"我的足迹"])
    {
        
        if(_isdel == NO)//全部
        {
            if (page == 1) {
                [_allArray removeAllObjects];
            }
             url = [NSString stringWithFormat:@"%@mySteps/queryStepsList?version=%@&token=%@&isApp=true&pager.curPage=%d&realm=%@&is_del=2",[NSObject baseURLStr],VERSION,token,(int)page,realm];
        }else{//失效
            if (page == 1) {
                [_deldataArray removeAllObjects];
            }
            url = [NSString stringWithFormat:@"%@mySteps/queryStepsList?version=%@&token=%@&isApp=true&pager.curPage=%d&realm=%@&is_del=1",[NSObject baseURLStr],VERSION,token,(int)page,realm];
        }

    }
    
    NSString *URL=[MyMD5 authkey:url];

    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
        [_Mycollection headerEndRefreshing];
        [_Mycollection footerEndRefreshing];
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSDictionary *responseObjectDic = responseObject;
            
            if ([[responseObjectDic allKeys] count] == 0) {
                CGRect frame = CGRectMake(0, 94, self.view.frame.size.width, self.view.frame.size.height-94);
                [self createBackgroundView:self.view  andTag:9999 andFrame:frame withImgge:nil andText:nil];
            } else {
                [self clearBackgroundView:self.view withTag:9999];
            }
            
            NSString *statu=responseObject[@"status"];
            
            NSString *messsage=responseObject[@"message"];
            
            
            if([self.titleString isEqualToString:@"我的最爱"]){
                
                if(_isdel == NO)
                {
//                    _allCount=responseObject[@"pager"][@"pageCount"];
                    _allCount=responseObject[@"pageCount"];
                    
                }else{
//                    _delCount=responseObject[@"pager"][@"pageCount"];
                    _allCount=responseObject[@"pageCount"];
                }

//                _pageCount=responseObject[@"pageCount"];
            }else if ([self.titleString isEqualToString:@"店铺美衣"]){
                
            }else if ([self.titleString isEqualToString:@"我的足迹"]){
                
                if(_isdel == NO)
                {
                     _allCount=responseObject[@"pager"][@"pageCount"];
                    
                }else{
                     _delCount=responseObject[@"pager"][@"pageCount"];
                }

            }

            if(statu.intValue==1)
            {
                _currentpage ++;
                NSArray *tmpArr;
                
                if ([self.titleString isEqualToString:@"我的最爱"]) {
                    tmpArr = responseObject[@"likes"]; //最爱
                } else if ([self.titleString isEqualToString:@"我的足迹"]) {
                    tmpArr = responseObject[@"mysList"]; //足迹
                }
                
                //tmp = %@", tmpArr);
                
                if(tmpArr.count!=0){
                    [self clearBackgroundView:self.view withTag:9999];
                    if ([self.titleString isEqualToString:@"我的最爱"]) {
                        
//                        if(_isdel == NO)
//                        {
//                            _allCurrentPage ++;
//                            _currentpage = _allCurrentPage;
//                        }else{
//                            _delCurrentPage ++;
//                            _currentpage = _delCurrentPage;
//                        }

                        for(NSDictionary *dic in tmpArr) {
                            ShopDetailModel *model=[[ShopDetailModel alloc]init];
                            model.add_time=dic[@"add_time"];
                            model.shop_id=dic[@"id"];
                            model.isLike = @"1";
                            model.is_del = dic[@"is_del"];
                            model.isCart = dic[@"isCart"];
                            model.p_code = [NSString stringWithFormat:@"%@",dic[@"p_code"]];
                            model.shop_code=dic[@"shop_code"];
                            model.shop_codes=dic[@"shop_codes"];
                            model.shop_name=dic[@"shop_name"];
                            model.shop_price=dic[@"shop_price"];
                            model.shop_pic=dic[@"show_pic"];
                            model.ID=dic[@"user_id"];
                            model.shop_se_price=dic[@"shop_se_price"];
                            model.app_shop_group_price = dic[@"app_shop_group_price"];
                            model.isShelf=dic[@"isShelf"];
                            model.kickback=dic[@"kickback"];
                            model.isTM = [NSString stringWithFormat:@"%@",dic[@"isTM"]];
                            model.isVip = responseObject[@"isVip"];
                            model.maxType = responseObject[@"maxType"];
                            if(_isdel == NO)
                            {
                                [_allArray addObject:model];

                                _dataArray = _allArray;
                            }else{
                                
                                [_deldataArray addObject:model];
                                _dataArray = _deldataArray;
                            }
                        }
                    } else if ([self.titleString isEqualToString:@"我的足迹"]) {
                        
//                        if(_isdel == NO)
//                        {
//                            _allCurrentPage ++;
//                            _currentpage = _allCurrentPage;
//                        }else{
//                            _delCurrentPage ++;
//                            _currentpage = _delCurrentPage;
//                        }

                        for(NSDictionary *dic in tmpArr) {
                            if(dic !=NULL){
                                ShopDetailModel *model=[[ShopDetailModel alloc] init];
                                model.def_pic = dic[@"def_pic"];
                                model.isCart = dic[@"isCart"];
                                model.isLike = dic[@"isLike"];
                                model.is_del = dic[@"is_del"];
                                model.kickback = dic[@"kickback"];
                                model.shop_price=dic[@"shop_price"];
                                model.shop_code = dic[@"shop_code"];
                                model.shop_name = dic[@"shop_name"];
                                model.shop_se_price = dic[@"shop_se_price"];
                                model.app_shop_group_price = dic[@"app_shop_group_price"];
                                model.isTM = [NSString stringWithFormat:@"%@",dic[@"isTM"]];
                                model.isVip = responseObject[@"isVip"];
                                model.maxType = responseObject[@"maxType"];
                                if(_isdel == NO)
                                {
                                    [_allArray addObject:model];
                                    _dataArray = _allArray;
                                }else{
                                    [_deldataArray addObject:model];
                                    _dataArray = _deldataArray;
                                }
                                
                            }
                        }
                    }
                    
                    if (_dataArray.count == 0) {
                        CGRect frame = CGRectMake(0, 94, self.view.frame.size.width, self.view.frame.size.height-94);
                        [self createBackgroundView:self.view  andTag:9999 andFrame:frame withImgge:nil andText:nil];
                    }
                    
                } else {
                    CGRect frame = CGRectMake(0, 94, self.view.frame.size.width, self.view.frame.size.height-94);
                    [self createBackgroundView:self.view  andTag:9999 andFrame:frame withImgge:nil andText:nil];
                }
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
                NavgationbarView *alertview=[[NavgationbarView alloc] init];
                [alertview showLable:messsage Controller:self];
            }
            
            [self creatData];

            [_Mycollection reloadData];

        }
        
         [_Mycollection reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
    
        [MBProgressHUD show:@"系统繁忙，请稍后再试" icon:nil view:nil];
    }];
    

}

-(void)requestStoreHTTP
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    NSString *storecode=[userdefaul objectForKey:STORE_CODE];
    
    NSString *url;
    
    url=[NSString stringWithFormat:@"%@shopStore/queryStoreShop?version=%@&token=%@&store_code=%@",[NSObject baseURLStr],VERSION,token,storecode];
    
    
    NSString *URL=[MyMD5 authkey:url];
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *messsage=responseObject[@"message"];
            
            if(statu.intValue==1)
            {
                
            }else{
                
                [MBProgressHUD show:messsage icon:nil view:nil];
                
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
        [MBProgressHUD hideHUDForView:self.view];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        
        
    }];
    

}

#pragma mark 删除我的最爱
-(void)deleteLkeHttp:(NSString*)shopcode
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];

    
    NSString *url;
    
    if(_selectCount > 1)
    {
         url=[NSString stringWithFormat:@"%@like/delLike?version=%@&token=%@&shop_codes=%@",[NSObject baseURLStr],VERSION,token,shopcode];
    }else{
        
         url=[NSString stringWithFormat:@"%@like/delLike?version=%@&token=%@&shop_code=%@",[NSObject baseURLStr],VERSION,token,shopcode];
    }
   
    
    
    NSString *URL=[MyMD5 authkey:url];
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *messsage=responseObject[@"message"];
            
            if(statu.intValue==1)
            {
                messsage=@"删除成功";
                
                if(_isdel==NO)
                {
                    int shopcount = [self.shopcount intValue];
                    _titlelable.text=[NSString stringWithFormat:@"全部分类(%d)",(int)shopcount - (int)_selectCount];
                    self.shopcount = [NSString stringWithFormat:@"%d",(int)shopcount - (int)_selectCount];
                }
                
//                [_dataArray removeAllObjects];
                _selectCount=0;
                _currentpage=1;
                [self requestHTTP:1];
                
                //删除成功获取用户加喜欢商品
                AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [app getUserLikeHttp];
            }else{
                
                messsage=@"删除失败";
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:messsage Controller:self];

        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
        [MBProgressHUD hideHUDForView:self.view];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        
    }];
    

}

#pragma mark 删除我的足迹
-(void)deletefootprintHttp:(NSString*)shopcode
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    NSString *realm =[userdefaul objectForKey:USER_REALM];
    
    NSString *url;
    
    if(_selectCount > 1)
    {
        url=[NSString stringWithFormat:@"%@mySteps/delSteps?version=%@&token=%@&shop_codes=%@&realm=%@",[NSObject baseURLStr],VERSION,token,shopcode,realm];
    }else{
        url=[NSString stringWithFormat:@"%@mySteps/delSteps?version=%@&token=%@&shop_code=%@&realm=%@",[NSObject baseURLStr],VERSION,token,shopcode,realm];
    }
    
    
    
    
    NSString *URL=[MyMD5 authkey:url];
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *messsage=responseObject[@"message"];
            //%@  %@",statu,messsage);
            if(statu.intValue==1&&statu!=nil)
            {
                messsage=@"删除成功";
                //1111111%@  2222222%@",statu,messsage);
                
                int shopcount = [self.shopcount intValue];
                
                if(_isdel == NO)
                {
                    _titlelable.text=[NSString stringWithFormat:@"全部分类(%d)",(int)shopcount - (int)_selectCount];
                    self.shopcount = [NSString stringWithFormat:@"%d",(int)shopcount - (int)_selectCount];
                }
                
//                [_dataArray removeAllObjects];
//                [_selectArray removeAllObjects];
                _selectCount=0;
                
                _currentpage=1;
                [self requestHTTP:1];
            }else{
                //1111111%@  2222222%@",statu,messsage);
                messsage=@"删除失败";
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:messsage Controller:self];

        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
        [MBProgressHUD hideHUDForView:self.view];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        
    }];
    

}

- (void)creatData
{
    if (_edit) {
        NSInteger num = _dataArray.count - _selectArray.count;
        for(int i=0;i<num;i++)
        {
            [_selectArray addObject:@"0"];
        }
    } else {
        [_selectArray removeAllObjects];
        
        for(int i=0;i<_dataArray.count;i++)
        {
            [_selectArray addObject:@"0"];
        }
    }
}

-(void)creatHeadview
{
    UIView *headview=[[UIView alloc]initWithFrame:CGRectMake(0, 64, kApplicationWidth, 30)];
    [self.view addSubview:headview];
    
    _titlelable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(42), 5, 200, 20)];
    if (self.shopcount==nil) {
        self.shopcount=@"";
    }
    _titlelable.text=[NSString stringWithFormat:@"全部分类( %@ )",self.shopcount];
     _titlelable.font = [UIFont systemFontOfSize:ZOOM(47)];
    [headview addSubview:_titlelable];
    
    UIButton *button=[[UIButton alloc]init];
    button.frame=CGRectMake(kApplicationWidth-60, 5, 50, 20);
    [button setTitle:@"失效" forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:ZOOM(47)];

    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(headclick:) forControlEvents:UIControlEventTouchUpInside];
    
    [headview addSubview:button];
    
}

-(void)creatCollectionView
{
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    WaterFLayout *flowLayout=[[WaterFLayout alloc]init];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
    flowLayout.minimumColumnSpacing=5;
    flowLayout.minimumInteritemSpacing=0;
    
    
    _Mycollection=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 94,kApplicationWidth,kApplicationHeight-94+kUnderStatusBarStartY) collectionViewLayout:flowLayout];
    _Mycollection.alwaysBounceVertical = YES;
    _Mycollection.backgroundColor=[UIColor groupTableViewBackgroundColor];
    _Mycollection.delegate=self;
    _Mycollection.dataSource=self;
    [_Mycollection registerClass:[WaterFlowCell class] forCellWithReuseIdentifier:@"WATERFLOWCELLID"];
    
    
    [self.view addSubview:_Mycollection];
    //[_Mycollection registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    [_Mycollection registerNib:[UINib nibWithNibName:@"WaterFlowCell" bundle:nil] forCellWithReuseIdentifier:@"WATERFLOWCELLID"];
    
    
    [_Mycollection addHeaderWithCallback:^{
        _currentpage = 1;
       
        if([self.titleString isEqualToString:@"我的足迹"] || [self.titleString isEqualToString:@"我的最爱"])
        {
//            if(_isdel == NO)
//            {
//                _allCurrentPage = 1;
//            }else{
//                _delCurrentPage = 1;
//            }

            if(_currentpage==1){
                
                if(_isdel == NO)
                {
                    [_allArray removeAllObjects];
                }else{
                    [_deldataArray removeAllObjects];
                }
            }
        }
        else{
            
            [_dataArray removeAllObjects];
        }
        

        [self requestHTTP:_currentpage];
    }];
    
    
    [_Mycollection addFooterWithCallback:^{
        
        if([self.titleString isEqualToString:@"我的足迹"] || [self.titleString isEqualToString:@"我的最爱"])
        {
            if(_isdel == NO)
            {
                _pageCount = _allCount;
                
            }else{
                _pageCount = _delCount;
            }

        }
        
        if(! (_currentpage > _pageCount.intValue))
        {
            
            [self requestHTTP:_currentpage];
            
        }else{
            [_Mycollection footerEndRefreshing];
        }
        
        
    }];

    
    [_Mycollection reloadData];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaterFlowCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"WATERFLOWCELLID" forIndexPath:indexPath];
    cell.selectBtn.hidden = YES;
    
    if(_dataArray.count)
    {
        ShopDetailModel *model=_dataArray[indexPath.item];
        model.reduceMoney = self.reduceMoney;
        model.shop_deduction = self.shop_deduction;
        model.isVip = self.isVip;
        model.maxType = self.maxType.stringValue;
        [cell receiveDataModel:model];
    }
    
    //选择按钮
    _SelectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _SelectBtn.frame=CGRectMake(cell.frame.size.width/2-35, cell.frame.size.height/2-35, 70, 70);
    _SelectBtn.clipsToBounds=YES;
    _SelectBtn.layer.cornerRadius=35;
    _SelectBtn.tag=2000+indexPath.row;
    
    [_SelectBtn setBackgroundImage:[UIImage imageNamed:@"未选中_黑"] forState:UIControlStateNormal];
    [_SelectBtn setBackgroundImage:[UIImage imageNamed:@"选中_白"] forState:UIControlStateSelected];
    [_SelectBtn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:_SelectBtn];
    cell.selectBtn=_SelectBtn;
    cell.selectBtn.hidden = !_edit;
    
    
    //标识按钮的状态 1为选中 0没选中
    
    if(_selectArray.count && _selectArray.count > indexPath.row)
    {
        if([_selectArray[indexPath.row] isEqualToString:@"1"])
        {
            cell.selectBtn.selected=YES;
        }else{
            cell.selectBtn.selected=NO;
            
        }
    }
    
    return cell;
}

-(CGFloat)getRowHeight:(NSString *)text
{
    //文字高度
    CGFloat height;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(230, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:20] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
        
    }
    else{
        
    }
    return height;
}


#pragma mark item 大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

#if 0
    CGFloat imgwidh;
    CGFloat imgheigh;
    
    ShopDetailModel *model=_dataArray[indexPath.item];
    NSString *str=model.shop_pic;
    str=[str substringToIndex:[str length]-4];
    NSArray *arr=[str componentsSeparatedByString:@"_"];
    if(arr.count)
    {
        imgheigh=[arr[1] floatValue];
        imgwidh=[arr[2] floatValue];
    }
    
    CGFloat f=imgwidh/imgheigh;

#endif
    
//    ShopDetailModel *model= _dataArray[indexPath.row];
//    CGFloat imgH = 0;
//    CGFloat imgW = 0;
//    
//    CGFloat H = 0;
//    CGFloat W = 0;
//    
//    NSString *st = [model.def_pic substringToIndex:model.def_pic.length-4];
//    
//    NSArray *comArr = [st componentsSeparatedByString:@"_"];
//    
//    //    //comArr = %@",comArr);
//    
//    if (comArr.count>2) {
//        imgH = [comArr[2] floatValue];
//        imgW = [comArr[1] floatValue];
//    }
//    
//    W = (kScreenWidth-2)/2;
//    if (imgW!=0) {
//        H = W*imgH/imgW;
//    } else {
//        H = 0;
//    }
    
    CGFloat imgH = 900;
    CGFloat imgW = 600;
    
    CGFloat W = (kScreenWidth-18)/2.0;
    CGFloat H = imgH*W/imgW;
    
    CGSize size = CGSizeMake(W, H+5);
    
    return size;

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([_dataArray count] == 0)
    {
        return;
    }

    ShopDetailModel *model=_dataArray[indexPath.row];
    
    NSString *codestr = [NSString stringWithFormat:@"%@",model.p_code];
    MyLog(@"codestr =%@",codestr);
    
    if(codestr.length > 8)
    {
//        ComboShopDetailViewController *detail=[[ComboShopDetailViewController alloc] init];
//        detail.shop_code = model.p_code;
//        
//        detail.hidesBottomBarWhenPushed=YES;
//        [self.navigationController pushViewController:detail animated:YES];

    }else{
        
//        if(model.isTM.intValue == 1)
//        {
//            SpecialShopDetailViewController *detail=[[SpecialShopDetailViewController alloc]init];
//            detail.shop_code=model.shop_code;
//            detail.stringtype = @"最爱足迹";
//
//            WaterFlowCell *cell = (WaterFlowCell*)[collectionView cellForItemAtIndexPath:indexPath];
//            detail.bigimage=cell.shop_pic.image;
//            [self.navigationController pushViewController:detail animated:YES];
//        }else{
//            ShopDetailViewController *detail=[[ShopDetailViewController alloc]init];
//            detail.shop_code=model.shop_code;
//            detail.stringtype = @"最爱足迹";
//            if(model.kickback.intValue == 0)
//            {
//                detail.stringtype = @"活动商品";
//                detail.browseCount = -1;
//            }
//            WaterFlowCell *cell = (WaterFlowCell*)[collectionView cellForItemAtIndexPath:indexPath];
//            detail.bigimage=cell.shop_pic.image;
//            [self.navigationController pushViewController:detail animated:YES];
//        }
        
        ShopDetailViewController *detail=[[ShopDetailViewController alloc]init];
        detail.shop_code=model.shop_code;
        detail.stringtype = @"最爱足迹";
        detail.isTM = model.isTM.intValue == 1?YES:NO;
        if(model.kickback.intValue == 0)
        {
            detail.stringtype = @"活动商品";
            detail.browseCount = -1;
        }
        WaterFlowCell *cell = (WaterFlowCell*)[collectionView cellForItemAtIndexPath:indexPath];
        detail.bigimage=cell.shop_pic.image;
        [self.navigationController pushViewController:detail animated:YES];
    }
}

-(void)edit:(UIButton*)sender
{
    UIButton *button=(UIButton*)[self.view viewWithTag:sender.tag];
    
    sender.selected=!sender.selected;

    _Footview=[[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight-ZOOM(100)-10+kUnderStatusBarStartY, kApplicationWidth, ZOOM(100)+10)];
    _Footview.tag=9898;
    
    UIButton *canclebtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    canclebtn.frame=CGRectMake(kApplicationWidth/2-100, 5, 80, ZOOM(100));
    [canclebtn setTitle:@"取消" forState:UIControlStateNormal];
    canclebtn.backgroundColor=[UIColor blackColor];
    [canclebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [canclebtn addTarget:self action:@selector(cancleclick:) forControlEvents:UIControlEventTouchUpInside];
    
//    [_Footview addSubview:canclebtn];
    
    UIButton *okbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    okbtn.frame=CGRectMake((kApplicationWidth-80)/2, 5, 80, ZOOM(100));
    [okbtn setTitle:@"删除" forState:UIControlStateNormal];
    okbtn.backgroundColor=tarbarrossred;
    [okbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [okbtn addTarget:self action:@selector(oklick:) forControlEvents:UIControlEventTouchUpInside];
    [_Footview addSubview:okbtn];
    
    
    //编辑");
    if(sender.selected)
    {
        [button setTitle:@"完成" forState:UIControlStateNormal];
        _setting.selected=YES;
        _edit=YES;
        
        CGRect rect=_Mycollection.frame;
        
        rect.size.height=kApplicationHeight-94+kUnderStatusBarStartY-ZOOM(100)-10;
        
        _Mycollection.frame=rect;
        
        [_Mycollection reloadData];
        
        [self.view addSubview:_Footview];
        
        _Mycollection.headerHidden = YES;
//        _Mycollection.footerHidden = YES;
        
    }else{
        [button setTitle:@"编辑" forState:UIControlStateNormal];
        _setting.selected=NO;
        _edit=NO;
        
        for(int i=0; i<_selectArray.count;i++)
        {
            _selectArray[i]=@"0";
        }
        
        
        CGRect rect=_Mycollection.frame;
        
        rect.size.height=kApplicationHeight-94+kUnderStatusBarStartY;
        
        _Mycollection.frame=rect;
        [_Mycollection reloadData];
        
        UIView *view=(UIView*)[self.view viewWithTag:9898];
        [view removeFromSuperview];
        _Mycollection.headerHidden = NO;
//        _Mycollection.footerHidden = NO;
    }
}

#pragma mark 删除
-(void)Overhead:(NSInteger)index
{
    //index is %d",index);
    
    ShopDetailModel *model=_dataArray[index];
    NSString *shopcode=model.shop_code;
    
    
    
    if([self.titleString isEqualToString:@"我的足迹"])
    {

#if 0
        NSUserDefaults *nsuserdefaul=[NSUserDefaults standardUserDefaults];
        NSMutableArray* UserDataArray=[NSMutableArray arrayWithArray:[nsuserdefaul objectForKey:SHOP_INFORMATION]];
        [UserDataArray removeObjectAtIndex:index];//删除其中一个元素
        
        NSArray *userArray=[NSArray arrayWithArray:UserDataArray];//新的数据
        
        [nsuserdefaul removeObjectForKey:SHOP_INFORMATION];//1.删除所有元素
        
        [nsuserdefaul setObject:userArray forKey:SHOP_INFORMATION];//2.保存新的数据
        
        
        [_dataArray removeObjectAtIndex:index];
        [_Mycollection reloadData];
#endif
        
        [self deletefootprintHttp:shopcode];
        
    }else{
    
       
        
        [self deleteLkeHttp:shopcode];

    }
    
    
}

-(void)cancleclick:(UIButton*)sender
{
    MyLog(@"取消");
    
    for(int i=0;i<_selectArray.count;i++)
    {
        _selectArray[i]=@"0";
    }
    
    [_Mycollection reloadData];
}

-(void)oklick:(UIButton*)sender
{
    MyLog(@"删除");
    
    NSMutableString *shopcodes=[NSMutableString string];
    
    for(int i=0;i<_selectArray.count;i++)
    {
        if([_selectArray[i] isEqualToString:@"1"])
        {
            ShopDetailModel *model=_dataArray[i];
            NSString *shopcode=model.shop_code;
            
            [shopcodes appendString:shopcode];
            [shopcodes appendString:@","];
            
            _selectCount++;
        }
    }
    
    if(_selectCount>1 || _selectCount==1)
    {
    
        NSString *ccc=[shopcodes substringToIndex:[shopcodes length]-1];
    
        if([self.titleString isEqualToString:@"我的足迹"])
        {
        
        
            [self deletefootprintHttp:ccc];
        
        }else{
        
        
        
            [self deleteLkeHttp:ccc];
        
        }
    }else{
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"你还没有选择商品" Controller:self];
    }
    
}

#pragma mark 失效
-(void)headclick:(UIButton*)sender
{
    sender.selected=!sender.selected;
    if(sender.selected)
    {
        _isdel=YES;
        [sender setTitle:@"全部" forState:UIControlStateNormal];
        
        if(!_deldataArray.count){
            
            [self requestHTTP:1];
        }else{
            _dataArray = _deldataArray;

        }
        
    }else{

        _dataArray = _allArray;
        _isdel=NO;
        [sender setTitle:@"失效" forState:UIControlStateNormal];
        
    }
    [_selectArray removeAllObjects];
    [self creatData];
     [_Mycollection reloadData];
    
    
    if (_dataArray.count == 0) {
        CGRect frame = CGRectMake(0, 94, self.view.frame.size.width, self.view.frame.size.height-94);
        [self createBackgroundView:self.view  andTag:9999 andFrame:frame withImgge:nil andText:nil];
    } else {
        
        UIView *headview = (UIView*)[self.view viewWithTag:9999];
        [headview removeFromSuperview];
    }
    
   
}

-(void)select:(UIButton*)sender
{
    sender.selected=!sender.selected;
    
    if(sender.selected)
    {
        
        sender.selected=YES;
        _selectArray[sender.tag - 2000]=@"1";
        
    }else{
        sender.selected=NO;
        _selectArray[sender.tag - 2000]=@"0";

        
    }
}

- (void)createBackgroundView:(UIView *)view andTag:(NSInteger)tag andFrame:(CGRect)frame withImgge:(UIImage *)img andText:(NSString *)text
{
    TFBackgroundView *tb = [[[NSBundle mainBundle] loadNibNamed:@"TFBackgroundView" owner:self options:nil] lastObject];
    tb.frame = frame;
    tb.tag = tag;
    //    tb.backgroundColor = [UIColor yellowColor];
    if (img != nil) {
        tb.headImageView.image = img;
    } else {
        tb.headImageView.image = [UIImage imageNamed:@"笑脸21"];
    }

    if (text != nil) {
        tb.textLabel.text = text;
    } else {
        tb.textLabel.text = @"亲,暂时没有相关数据哦";
    }
    for (UIView *vv in view.subviews) {
        if ([vv isKindOfClass:[TFBackgroundView class]] && tag == view.tag) {
            [view bringSubviewToFront:vv];
            return;
        }
    }
    if([view viewWithTag:9999]==nil){
        [view addSubview:tb];
        [view bringSubviewToFront:tb];
    }
}
- (void)clearBackgroundView:(UIView *)view withTag:(NSInteger)tag
{
    
    
//    for (UIView *subView in view.subviews) {
//        if (subView.tag == tag && [subView isKindOfClass:[TFBackgroundView class]]) {
//            [subView removeFromSuperview];
//        }
//    }
    TFBackgroundView *tb = (TFBackgroundView *)[view viewWithTag:tag];
    if (tb!=nil) {
        [tb removeFromSuperview];
    }
}
- (TFShoppingVM *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[TFShoppingVM alloc] init];
    }
    return _viewModel;
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
