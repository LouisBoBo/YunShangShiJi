//
//  TFScreenViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/8/5.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFScreenViewController.h"
#import "WaterFlowCell.h"
#import "ShopDetailViewController.h"
#import "PopoverView.h"
#import "TFShoppingViewController.h"
#import "TFPopBackgroundView.h"
#import "CollectionImageHeaderView.h"
#import "CollectionMenuReusableView.h"
#import "DefaultImgManager.h"
#import "TFCollocationViewController.h"
#import "StickyHeaderFlowLayout.h"
#import "TFShoppingVM.h"
@interface TFScreenViewController () <PopoverViewDelegate,StickyHeaderFlowLayoutDelegate>

{
    NSString *notType;
    NSString *appendingStr;
    NSString *themeappendingStr;
}
@property (nonatomic, assign)BOOL isSort;
@property (nonatomic, assign)int page;
@property (nonatomic, strong) MenuButtonView *menuButtonView;
@property (nonatomic, strong) UIView *headerTimerView;
@property (nonatomic, strong) UIButton *explainBtn;
@property (nonatomic, strong) UILabel *messageLab;

@property (nonatomic, assign) CGFloat reduceMoney;
@property (nonatomic, copy)   NSString * shop_deduction;
@property (nonatomic, strong) NSNumber *isVip;
@property (nonatomic, strong) NSNumber *maxType;
@property (nonatomic, strong) TFShoppingVM *viewModel;
@end

@implementation TFScreenViewController

- (void)dealloc
{
    MyLog(@"%@ release", [self class]);
    if (self.collectionView.topShowView) {
        [self.collectionView removeObserver:self.collectionView forKeyPath:observerRefreshHeaderViewKeyPath];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


//    [self addSortView];
    
    self.isbrowse?[self addHeaderTimerView]:nil;
    [self setupUI];
    self.page = 1;
    
//    [self httpGetDataSource];
    
    [self setData];
    
    __weak TFScreenViewController *tf = self;
    //加下拉刷新
//    [self.collectionView addHeaderWithCallback:^{
//        //
//        tf.page = 1;
//        [tf httpGetDataSource];
//    }];

    [self.collectionView registerClass:[CollectionImageHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    //新加的2017-9-19
    [self.collectionView registerClass:[CollectionMenuReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MenuHeadView"];
    
    
    [self.collectionView addTopHeaderWithCallback:^{
        tf.page = 1;
        [tf httpGetDataSource];
    }];
    
    //加上拉刷新
    [self.collectionView addFooterWithCallback:^{
        tf.page++;
        [tf httpGetDataSource];
    }];

    self.isSort = NO;
    
    if ([self.dataStatistics hasPrefix:@"风格"]) {
        [DataManager sharedManager].outAppStatistics = [NSString stringWithFormat:@"%@列表页", self.dataStatistics];
    } else if ([self.dataStatistics isEqualToString:@"自定义喜好筛选结果"]) {
        [DataManager sharedManager].outAppStatistics = [NSString stringWithFormat:@"%@列表页", self.dataStatistics];
    } else if ([self.dataStatistics isEqualToString:@"搜索下—输入后确定"]) {
        [DataManager sharedManager].outAppStatistics = [NSString stringWithFormat:@"%@列表页", @"搜索结果"];
    }
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
        
        [weakSelf httpGetDataSource];
    } failure:^(NSError *error) {
        
    }];
}
- (void)setupUI
{
    CGFloat H_V = 0;
    if(self.isbrowse)//浏览
    {
        H_V = ZOOM6(60);
    }else{
        H_V = 0;
    }
    self.collectionView.frame = CGRectMake(0, kNavigationheightForIOS7+H_V, kScreenWidth, kScreenHeight-kNavigationheightForIOS7-H_V);
    
    //新加的2017-9-19
    [self.collectionView setCollectionViewLayout:[self layout]];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    

//    ESWeakSelf;
//    [self.view addSubview:self.menuButtonView];
//    [self.menuButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
//        if(__weakSelf.isbrowse)
//        {
//            make.top.equalTo(__weakSelf.headerTimerView.mas_bottom);
//        }else{
//            make.top.equalTo(__weakSelf.navigationView.mas_bottom);
//        }
//        make.left.right.equalTo(__weakSelf.view);
//        make.height.mas_equalTo(ZOOM6(70));
//    }];
//    
//    __weak typeof(self) weakSelf = self;
//    [self.menuButtonView setMenuBtnClickBlock:^(NSInteger btnClickIndex) {
//        
//        [weakSelf httpSelectIndex:btnClickIndex];
//    }];
//    [self.menuButtonView show];
}


- (void)viewDidAppear:(BOOL)animated
{
    if (self.MainViewStatusNormal) {
        self.MainViewStatusNormal();
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    if (self.MainViewStatusNormal) {
        [self tabBarStatusToRight];
    }
}

- (void)tabBarStatusToRight
{
    //    Mtarbar.tabBar.center = CGPointMake(kScreenWidth/2.0+OPENCENTERX, kScreenHeight-49);
    Mtarbar.tabBar.frame=CGRectMake(OPENCENTERX, kScreenHeight-Height_TabBar, kScreenWidth, Height_TabBar);
}


- (void)addSortView
{
    UIButton *setbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    setbtn.frame=CGRectMake(kScreenWidth-50, 20, 50, 44);
    [setbtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //    setbtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [setbtn setImage:[UIImage imageNamed:@"搜索排序按钮_正常"] forState:UIControlStateNormal];
    [setbtn setImage:[UIImage imageNamed:@"搜索排序按钮_正常"] forState:UIControlStateHighlighted];
    [self.navigationView addSubview:setbtn];
    
}

- (void)rightBtnClick
{
    CGPoint point = CGPointMake(kApplicationWidth-25, 64);
    PopoverView *pop = [[PopoverView alloc] initWithPoint:point titles:@[@"上新时间排序",@"价格从低到高",@"价格从高到低"] images:nil withSceenWith:kScreenWidth popWith:0 cellTextFont:0];
    pop.tag=8888;
    pop.delegate = self;
    [pop show];
}

#pragma mark --PopoverView 代理

- (void)httpSelectIndex:(NSInteger)index
{
       switch (index) {
        case 1: {
            //            //0");
            self.page = 1;
            appendingStr=@"pager.sort=virtual_sales&pager.order=desc";
            themeappendingStr = @"sortArr=virtual_sales:desc";
        }
            break;
        case 0: {
            //            //0");
            self.page = 1;
            appendingStr=@"pager.sort=audit_time&pager.order=desc";
            themeappendingStr = @"sortArr=audit_time:desc";
        }
            break;
        case 2: {
            //            //1");
            self.page = 1;
            appendingStr=@"pager.sort=shop_se_price&pager.order=asc";
            themeappendingStr = @"sortArr=shop_se_price:asc";
        }
            break;
        case 3: {
            //            //2");
            self.page = 1;
            appendingStr=@"pager.sort=shop_se_price&pager.order=desc";
            themeappendingStr = @"sortArr=shop_se_price:desc";
        }
            break;
        default:
            break;
    }
    
    self.isSort = YES;
    
    [self httpGetDataSource];
}

- (void)seletRowAtIndex:(PopoverView *)popoverView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self httpSelectIndex:indexPath.row];
}

- (void)httpGetDataSource
{
    if(self.page == 0)
    {
        self.page = 1;
    }
    
    if (self.index == 0) { //文本搜索
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *token = [ud objectForKey:USER_TOKEN];
        NSString *urlStr;
        if (token != nil) {
            if (self.class_id) {
                urlStr = [NSString stringWithFormat:@"%@shop/queryCondition?token=%@&version=%@&class_id=%@&pager.curPage=%d&pager.pageSize=10",[NSObject baseURLStr],token,VERSION,self.class_id,self.page];
            }else
            if(self.type2!=nil)
            {
                urlStr = [NSString stringWithFormat:@"%@shop/queryCondition?token=%@&version=%@&type2=%@&pager.curPage=%d&pager.pageSize=10&notType=true",[NSObject baseURLStr],token,VERSION,self.type2,self.page];
            } else{
                //搜索
                if (self.currTitlePage == 1)//特价
                {
                    urlStr = [NSString stringWithFormat:@"%@shop/queryPackageList?version=%@&pager.curPage=%d&pager.order=%@&pager.pageSize=%@&p_type=0&package=%@",[NSObject baseURLStr],VERSION, (int)self.page,@"desc",@"10",self.muStr];
                }else if(self.currTitlePage == 0)//正价
                {
                    urlStr = [NSString stringWithFormat:@"%@shop/queryCondition?token=%@&version=%@&shop_name=%@&pager.curPage=%d&pager.pageSize=10&notType=true",[NSObject baseURLStr],token,VERSION,self.muStr,self.page];
                }
            }
          
        } else {
            if (self.class_id) {
                urlStr = [NSString stringWithFormat:@"%@shop/queryConUnLogin?version=%@&class_id=%@&pager.curPage=%d&pager.pageSize=10",[NSObject baseURLStr],VERSION,self.class_id,self.page];
            }else
            if(self.type2!=nil)
            {
                urlStr = [NSString stringWithFormat:@"%@shop/queryConUnLogin?version=%@&type2=%@&pager.curPage=%d&pager.pageSize=10",[NSObject baseURLStr],VERSION,self.type2,self.page];

            }else{
                
                urlStr = [NSString stringWithFormat:@"%@shop/queryConUnLogin?version=%@&shop_name=%@&pager.curPage=%d&pager.pageSize=10",[NSObject baseURLStr],VERSION,self.muStr,self.page];
            }


        }
        if (appendingStr) {
            urlStr = [urlStr stringByAppendingFormat:@"&%@",appendingStr];
        }
        
        //urlStr = %@",urlStr);
        
        NSString *URL = [MyMD5 authkey:urlStr];
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            responseObject = [NSDictionary changeType:responseObject];
            [self.collectionView footerEndRefreshing];   //停止刷新
//            [self.collectionView headerEndRefreshing];   //停止刷新
            [self.collectionView ffRefreshHeaderEndRefreshing];
            
            MyLog(@"responseObject: %@", responseObject);
            
            if (responseObject!=nil) {
                if ([responseObject[@"status"] intValue] == 1) {
                    if (self.page == 1) { //上拉
                        [self.waterFlowDataArray removeAllObjects];
                    }
                    NSArray *arr = self.currTitlePage==1?responseObject[@"pList"]: responseObject[@"listShop"];
                    
                    if (arr.count == 0&&self.waterFlowDataArray.count == 0) {
                        CGFloat bannerImgHeight = self.bannerImage.length?ZOOM6(360):0;
                        CGRect frame = CGRectMake(0, kNavigationheightForIOS7+ZOOM6(70)+bannerImgHeight, self.view.frame.size.width, self.view.frame.size.height-kNavigationheightForIOS7-ZOOM6(70)-bannerImgHeight);
                        
                        [self createBackgroundView:self.view  andTag:9999 andFrame:frame withImgge:nil andText:nil];
                    } else {
                        [self clearBackgroundView:self.view withTag:9999];
                        if(self.currTitlePage == 1)
                        {
                            for (NSDictionary *dic in arr) {
                                ShopDetailModel *sModel = [[ShopDetailModel alloc] init];
                                [sModel setValuesForKeysWithDictionary:dic];
                                NSDictionary *dicc = dic[@"shop_list"][0];
                                sModel.four_pic=[NSString stringWithFormat:@"%@",dicc[@"four_pic"]];
                                sModel.shop_code=[NSString stringWithFormat:@"%@",dicc[@"shop_code"]];
                                sModel.shop_name=[NSString stringWithFormat:@"%@",dicc[@"shop_name"]];
                                sModel.shop_price=[NSString stringWithFormat:@"%@",dicc[@"shop_price"]];
                                sModel.shop_se_price=[NSString stringWithFormat:@"%@",dicc[@"shop_se_price"]];
                                sModel.isTM = @"1";
                                [self.waterFlowDataArray addObject:sModel];
                            }
                        }else{
                            for (NSDictionary *dic in arr) {
                                ShopDetailModel *sModel = [[ShopDetailModel alloc] init];
                                [sModel setValuesForKeysWithDictionary:dic];
                                [self.waterFlowDataArray addObject:sModel];
                            }
                        }
                        
                        
                        Response *responseObj=[Response yy_modelWithJSON:responseObject];
                        if (self.waterFlowDataArray.count >= responseObj.pager.rowCount && self.page > 1 && arr.count == 0) {
                            NavgationbarView *nv = [[NavgationbarView alloc] init];
                            [nv showLable:@"没有更多商品了哦~" Controller:self];
                        }
                        
                  
                    }
                    //刷新数据
                    [self.collectionView reloadData];
                } else {
                    [MBProgressHUD showError:responseObject[@"message"]];
                }
            }
            
        
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self.collectionView footerEndRefreshing];   //停止刷新
//            [self.collectionView headerEndRefreshing];   //停止刷新
            [self.collectionView ffRefreshHeaderEndRefreshing];
//            [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }];
    
    }
    else if (self.index == 1) { //热图筛选
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *token = [ud objectForKey:USER_TOKEN];
        NSString *version = VERSION;
        NSString *urlStr;
        
        if (token != nil) {
            
            urlStr = [NSString stringWithFormat:@"%@shop/queryCondition?&pager.curPage=%d&pager.pageSize=50&token=%@&version=%@&style=%@&notType=true&%@",[NSObject baseURLStr],self.page,token,version,self.muStr,appendingStr];
           
        } else {
            
            urlStr = [NSString stringWithFormat:@"%@shop/queryConUnLogin?&pager.curPage=%d&pager.pageSize=50&version=%@&%@&notType=true&%@",[NSObject baseURLStr],self.page,version,self.muStr,appendingStr];
        }

        NSString *URL = [MyMD5 authkey:urlStr];

        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            responseObject = [NSDictionary changeType:responseObject];
            [self.collectionView footerEndRefreshing];   //停止刷新
//            [self.collectionView headerEndRefreshing];   //停止刷新
            [self.collectionView ffRefreshHeaderEndRefreshing];
            
            
//            MyLog(@"首页热图筛选: %@",responseObject);
            
            MyLog(@"responseObject: %@", responseObject);

            
            if (responseObject!=nil) {
                if ([responseObject[@"status"] intValue] == 1) {
                    if (self.page == 1) { //上拉
                        [self.waterFlowDataArray removeAllObjects];

                    }
                    NSArray *arr = responseObject[@"listShop"];
                    if (arr.count == 0&&self.waterFlowDataArray.count == 0) {
                        CGFloat bannerImgHeight = self.bannerImage.length?ZOOM6(360):0;

                        CGRect frame = CGRectMake(0, kNavigationheightForIOS7+ZOOM6(70)+bannerImgHeight, self.view.frame.size.width, self.view.frame.size.height-kNavigationheightForIOS7-ZOOM6(70)-bannerImgHeight);
                        
                        [self createBackgroundView:self.view  andTag:9999 andFrame:frame withImgge:nil andText:nil];
                    } else {
                        [self clearBackgroundView:self.view withTag:9999];
                        for (NSDictionary *dic in arr) {
                            ShopDetailModel *sModel = [[ShopDetailModel alloc] init];
                            [sModel setValuesForKeysWithDictionary:dic];
                            [self.waterFlowDataArray addObject:sModel];
                        }
                        
                        Response *responseObj=[Response yy_modelWithJSON:responseObject];
                        
                        if (self.waterFlowDataArray.count >= responseObj.pager.rowCount && self.page > 1 && arr.count == 0) {
                            NavgationbarView *nv = [[NavgationbarView alloc] init];
                            [nv showLable:@"没有更多商品了哦~" Controller:self];
                        }
                        

                        
                        //刷新数据
                        [self.collectionView reloadData];
                        if (self.isSort) {
                            self.isSort = NO;
                            [self.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
                        }
                    }
                } else {
                    [MBProgressHUD showError:responseObject[@"message"]];
                }
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self.collectionView footerEndRefreshing];   //停止刷新
//            [self.collectionView headerEndRefreshing];   //停止刷新
            [self.collectionView ffRefreshHeaderEndRefreshing];
//            [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
            
//            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
//            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }];
        
    }
    else if (self.index == 2) { //WTF首页筛选
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *token = [ud objectForKey:USER_TOKEN];
        NSString *urlStr;
        
        if(token != nil){
            urlStr = [NSString stringWithFormat:@"%@shop/queryCondition?&pager.curPage=%d&pager.pageSize=10&token=%@&version=%@%@&type1=%@&type_name=%@&notType=true&%@",[NSObject baseURLStr],self.page,token,VERSION,_muStr,_type1,_type_name, appendingStr];
        } else
            urlStr = [NSString stringWithFormat:@"%@shop/queryConUnLogin?&pager.curPage=%d&pager.pageSize=10&version=%@%@&type1=%@&type_name=%@&notType=true&%@",[NSObject baseURLStr],self.page,VERSION,_muStr,_type1,_type_name, appendingStr];
        
        
        NSString *URL = [MyMD5 authkey:urlStr];
        //        //
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            responseObject = [NSDictionary changeType:responseObject];
            [self.collectionView footerEndRefreshing];   //停止刷新
//            [self.collectionView headerEndRefreshing];   //停止刷新
            [self.collectionView ffRefreshHeaderEndRefreshing];
            
            
//            MyLog(@"首页筛选: %@",responseObject);
            MyLog(@"responseObject: %@", responseObject);


            if (responseObject!=nil) {
                if ([responseObject[@"status"] intValue] == 1) {
                    if (self.page == 1) { //上拉
                        [self.waterFlowDataArray removeAllObjects];
                    }
                    NSArray *arr = responseObject[@"listShop"];
                    if (arr.count == 0&&self.waterFlowDataArray.count == 0) {
                        CGFloat bannerImgHeight = self.bannerImage.length?ZOOM6(360):0;

                        CGRect frame = CGRectMake(0, kNavigationheightForIOS7+ZOOM6(70)+bannerImgHeight, self.view.frame.size.width, self.view.frame.size.height-kNavigationheightForIOS7-ZOOM6(70)-bannerImgHeight);
                        
                        [self createBackgroundView:self.view  andTag:9999 andFrame:frame withImgge:nil andText:nil];
                    } else {
                        [self clearBackgroundView:self.view withTag:9999];
                        for (NSDictionary *dic in arr) {
                            ShopDetailModel *sModel = [[ShopDetailModel alloc] init];
                            [sModel setValuesForKeysWithDictionary:dic];
                            [self.waterFlowDataArray addObject:sModel];
                        }
                        //刷新数据
                        //刷新数据");
                        
                        
                        Response *responseObj=[Response yy_modelWithJSON:responseObject];

                        if (self.waterFlowDataArray.count >= responseObj.pager.rowCount && self.page > 1 && arr.count == 0) {
                            NavgationbarView *nv = [[NavgationbarView alloc] init];
                            [nv showLable:@"没有更多商品了哦~" Controller:self];
                        }
                        
                        [self.collectionView reloadData];
                        
                        if (self.isSort) {
                            self.isSort = NO;
                            [self.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
                        }
                        

                    }
                } else {
                    [MBProgressHUD showError:responseObject[@"message"]];
                }
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self.collectionView footerEndRefreshing];   //停止刷新
//            [self.collectionView headerEndRefreshing];   //停止刷新
            [self.collectionView ffRefreshHeaderEndRefreshing];
            //            [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
            
//            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
//            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }];
        
    }
    else if (self.index == 3)
    {
       
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *token = [ud objectForKey:USER_TOKEN];
        NSString *urlStr;
        
        if(token != nil){
            urlStr = [NSString stringWithFormat:@"%@fc/QueryTRSList?&pager.curPage=%d&pager.pageSize=10&token=%@&version=%@&theme_id=%@&only_id=%@&",[NSObject baseURLStr],self.page,token,VERSION,self.theme_id,_muStr];
        } else
            urlStr = [NSString stringWithFormat:@"%@fc/QueryTRSList?&pager.curPage=%d&pager.pageSize=10&version=%@&theme_id=%@&only_id=%@",[NSObject baseURLStr],self.page,VERSION,self.theme_id,_muStr];
        
        if (themeappendingStr) {
            urlStr = [urlStr stringByAppendingFormat:@"&%@",themeappendingStr];
        }

        NSString *URL = [MyMD5 authkey:urlStr];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            responseObject = [NSDictionary changeType:responseObject];
            [self.collectionView footerEndRefreshing];   //停止刷新
            [self.collectionView ffRefreshHeaderEndRefreshing];
            
            MyLog(@"responseObject: %@", responseObject);
        
            if (responseObject!=nil) {
                if ([responseObject[@"status"] intValue] == 1) {
                    if (self.page == 1) { //上拉
                        [self.waterFlowDataArray removeAllObjects];
                    }
                    NSArray *arr = responseObject[@"shop_list"];
                    if (arr.count == 0&&self.waterFlowDataArray.count == 0) {
                        CGFloat bannerImgHeight = self.bannerImage.length?ZOOM6(360):0;

                        CGRect frame = CGRectMake(0, kNavigationheightForIOS7+ZOOM6(70)+bannerImgHeight, self.view.frame.size.width, self.view.frame.size.height-kNavigationheightForIOS7-ZOOM6(70)-bannerImgHeight);
                        
                        [self createBackgroundView:self.view  andTag:9999 andFrame:frame withImgge:nil andText:nil];
                    } else {
                        [self clearBackgroundView:self.view withTag:9999];
                        for (NSDictionary *dic in arr) {
                            ShopDetailModel *sModel = [[ShopDetailModel alloc] init];
                            [sModel setValuesForKeysWithDictionary:dic];
                            [self.waterFlowDataArray addObject:sModel];
                        }
                        //刷新数据
                        //刷新数据");
                        
                        Response *responseObj=[Response yy_modelWithJSON:responseObject];
                        
                        if (self.waterFlowDataArray.count >= responseObj.pager.rowCount && self.page > 1 && arr.count == 0) {
                            NavgationbarView *nv = [[NavgationbarView alloc] init];
                            [nv showLable:@"没有更多商品了哦~" Controller:self];
                        }
                        
                        [self.collectionView reloadData];
                        
                        if (self.isSort) {
                            self.isSort = NO;
                            [self.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
                        }
                    }
                } else {
                    [MBProgressHUD showError:responseObject[@"message"]];
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self.collectionView footerEndRefreshing];   //停止刷新
            [self.collectionView headerEndRefreshing];   //停止刷新
            [self.collectionView ffRefreshHeaderEndRefreshing];
        }];
    }else if (self.index == 4)
    {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *token = [ud objectForKey:USER_TOKEN];
        NSString *urlStr;
        
        if(token != nil){
            urlStr = [NSString stringWithFormat:@"%@shop/queryCondition?&pager.curPage=%d&pager.pageSize=10&token=%@&version=%@&type1=%@&type_name=%@&notType=true&%@",[NSObject baseURLStr],self.page,token,VERSION,_type1,_type_name, appendingStr];
        } else
            urlStr = [NSString stringWithFormat:@"%@shop/queryConUnLogin?&pager.curPage=%d&pager.pageSize=10&version=%@&type1=%@&type_name=%@&notType=true&%@",[NSObject baseURLStr],self.page,VERSION,_type1,_type_name, appendingStr];
        
        
        NSString *URL = [MyMD5 authkey:urlStr];
        //        //
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            responseObject = [NSDictionary changeType:responseObject];
            [self.collectionView footerEndRefreshing];   //停止刷新
            //            [self.collectionView headerEndRefreshing];   //停止刷新
            [self.collectionView ffRefreshHeaderEndRefreshing];
            
            
            //            MyLog(@"首页筛选: %@",responseObject);
            MyLog(@"responseObject: %@", responseObject);
            
            
            if (responseObject!=nil) {
                if ([responseObject[@"status"] intValue] == 1) {
                    if (self.page == 1) { //上拉
                        [self.waterFlowDataArray removeAllObjects];
                    }
                    NSArray *arr = responseObject[@"listShop"];
                    if (arr.count == 0&&self.waterFlowDataArray.count == 0) {
                        CGFloat bannerImgHeight = self.bannerImage.length?ZOOM6(360):0;
                        
                        CGRect frame = CGRectMake(0, kNavigationheightForIOS7+ZOOM6(70)+bannerImgHeight, self.view.frame.size.width, self.view.frame.size.height-kNavigationheightForIOS7-ZOOM6(70)-bannerImgHeight);
                        
                        [self createBackgroundView:self.view  andTag:9999 andFrame:frame withImgge:nil andText:nil];
                    } else {
                        [self clearBackgroundView:self.view withTag:9999];
                        for (NSDictionary *dic in arr) {
                            ShopDetailModel *sModel = [[ShopDetailModel alloc] init];
                            [sModel setValuesForKeysWithDictionary:dic];
                            [self.waterFlowDataArray addObject:sModel];
                        }
                        //刷新数据
                        //刷新数据");
                        
                        
                        Response *responseObj=[Response yy_modelWithJSON:responseObject];
                        
                        if (self.waterFlowDataArray.count >= responseObj.pager.rowCount && self.page > 1 && arr.count == 0) {
                            NavgationbarView *nv = [[NavgationbarView alloc] init];
                            [nv showLable:@"没有更多商品了哦~" Controller:self];
                        }
                        
                        [self.collectionView reloadData];
                        
                        if (self.isSort) {
                            self.isSort = NO;
                            [self.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
                        }
                        
                        
                    }
                } else {
                    [MBProgressHUD showError:responseObject[@"message"]];
                }
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self.collectionView footerEndRefreshing];   //停止刷新
            //            [self.collectionView headerEndRefreshing];   //停止刷新
            [self.collectionView ffRefreshHeaderEndRefreshing];
            //            [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
            
            //            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            //            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }];
        
    }


}

#pragma mark - collectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if(indexPath.section == 0)
        {
            CollectionImageHeaderView * headerView =(CollectionImageHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
            [headerView.headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@!450", [NSObject baseURLStr_Upy], self.bannerImage]]placeholderImage:[[DefaultImgManager sharedManager] defaultImgWithSize:headerView.frame.size]];
            return headerView;
        }else if (indexPath.section == 1)//新加的2017-9-19
        {
            CollectionMenuReusableView *menuHeadView =(CollectionMenuReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MenuHeadView" forIndexPath:indexPath];
            [self.menuButtonView removeFromSuperview];
            
//            [menuHeadView addSubview:self.menuButtonView];
//            __weak typeof(self) weakSelf = self;
//            [self.menuButtonView setMenuBtnClickBlock:^(NSInteger btnClickIndex) {
//                
//                [weakSelf httpSelectIndex:btnClickIndex];
//            }];
//            [self.menuButtonView show];
            kWeakSelf(self);
            [menuHeadView.menubackview setMenuBtnClickBlock:^(NSInteger btnClickIndex) {
                
                [weakself httpSelectIndex:btnClickIndex];
            }];

            return menuHeadView;
        }
    }
    return [UICollectionReusableView new];

}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section{
    return self.bannerImage.length ? kScreenWidth/1.7 : 0;
}

#pragma mark **************新加的2017-9-19***************
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return self.bannerImage!=nil?CGSizeMake(0, kScreenWidth/1.7):CGSizeZero;
    }else if (section == 1)
    {
        return CGSizeMake(0, ZOOM6(70));
    }
    
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat imgH = 900;
    CGFloat imgW = 600;
    
    CGFloat W = (kScreenWidth-15)/2.0;
    CGFloat H = imgH*W/imgW;
    
    CGSize size = CGSizeMake(W, H+5);
    
    return size;
}

#pragma mark - 指定固定组
- (BOOL)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout stickyHeaderForSectionAtIndex:(NSInteger)section
{
    if (section == 1 ) {
        return YES;
    }
    return NO;
}
//新加的2017-9-19
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 0;
    }else if (section == 1)
    {
        return self.waterFlowDataArray.count;
    }
    return 0;
}
//新加的2017-9-19
- (UICollectionViewFlowLayout *)layout
{
    StickyHeaderFlowLayout *layout = [[StickyHeaderFlowLayout alloc] init];
    
    layout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    // 全部固定设为YES, 局部固定则设为NO, 并实现代理方法
    layout.stickyHeader = NO;
    
    return layout;
}

//cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
    {
        WaterFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WATERFLOWCELLID" forIndexPath:indexPath];
        cell.selectBtn.hidden = YES;
        ShopDetailModel *model=self.waterFlowDataArray[indexPath.row];
        model.isVip = self.isVip;
        model.maxType = self.maxType.stringValue;
        model.shop_deduction = self.shop_deduction;
        model.reduceMoney = self.reduceMoney;
        [cell receiveDataModel:model];
        return cell;
    }
    return nil;
}

//点击
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.dataStatistics.length) { // 搜索
        if ([self.dataStatistics isEqualToString:@"搜索下—输入后确定"]) {
            [TFStatisticsClickVM handleDataWithPageType:nil withClickType:@"搜索结果列表页商品图片" success:nil failure:nil];
        } else if([self.dataStatistics hasPrefix:@"风格"]) { // 风格

            [TFStatisticsClickVM handleDataWithPageType:nil withClickType:[NSString stringWithFormat:@"%@列表页商品图片", self.dataStatistics] success:nil failure:nil];
        }
    }
    
    WaterFlowCell *cell = (WaterFlowCell*)[collectionView cellForItemAtIndexPath:indexPath];
    UIImage *image= cell.shop_pic.image;
    
    ShopDetailModel *model=self.waterFlowDataArray[indexPath.row];
    ShopDetailViewController *detail=[[ShopDetailViewController alloc]init];
    detail.shop_code=model.shop_code;
    detail.bigimage = image;
    detail.stringtype = @"筛选搜索";
    detail.isTM = [model.isTM boolValue];
    
    if(self.randomNum > 0)
    {
        detail.stringtype = @"签到领现金";
        detail.index_id = self.indexid;
        detail.index_day = self.day;
        detail.rewardCount = self.rewardCount;
        detail.rewardType = self.rewardType;
        detail.rewardValue = self.rewardValue;
        detail.Browsedic = self.Browsedic;
        detail.browseCount = self.browseCount;
        detail.currTimeCount = self.currTimeCount;
        
        if ((self.browseCount == self.randomNum) && !self.showGetMoneyWindow) {
            detail.showGetMoneyWindow = YES;
        }
        ESWeakSelf;
        detail.browseCountBlock = ^() {
            if (![__weakSelf.selectShopArray containsObject:model.shop_code]) {
                if (self.browseCount == self.randomNum) {
                    self.showGetMoneyWindow = YES;
                }
                __weakSelf.browseCount++; //计数
                [__weakSelf.selectShopArray addObject:model.shop_code];
                
            }
            
        };
    }
    
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)leftBarButtonClick
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *count = [user objectForKey:TASK_LIULAN_SHOPCOUNT];
    if(count.intValue >= self.randomNum)
    {
        self.showGetMoneyWindow = YES;
        [user removeObjectForKey:TASK_LIULAN_SHOPCOUNT];
    }

    if(self.isliulan == YES )//浏览分钟数
    {
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"is_read"] == YES)
        {
            TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] init];
            popView.title = @"亲~确定要离开吗？";
            popView.message = @"你正在进行浏览商品任务，浏览时长还未完成，你可以选择去浏览其它商品，浏览时长达到任务要求即可完成任务喔~";
            popView.leftText = @"不了,谢谢";
            popView.rightText = @"其他商品";
            
            [popView showCancelBlock:^{
                [self.navigationController popViewControllerAnimated:YES];
            } withConfirmBlock:^{
                [Mtarbar selectedToIndexViewController:0];
            } withNoOperationBlock:^{
                
            }];
        }else{
//            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"is_read"];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }else{
        if (!self.showGetMoneyWindow) {
            
            if (self.isbrowse == YES)
            {
                TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] init];
                popView.title = @"亲~确定要离开吗？";
                popView.message = @"再逛一下下就可以获得任务奖励噢~";
                popView.leftText = @"不了,谢谢";
                popView.rightText = @"再逛逛";
                
                [popView showCancelBlock:^{
                    [self.navigationController popViewControllerAnimated:YES];
                } withConfirmBlock:^{
                    
                } withNoOperationBlock:^{
                    
                }];
            }
            
        }
        else{
            [self.navigationController popViewControllerAnimated:YES];
        }

    }
    
    NSUserDefaults *stand = [NSUserDefaults standardUserDefaults];
    [stand setObject:@"筛选搜索" forKey:@"suaixuansousuo"];
    
}

- (void)addHeaderTimerView
{
    [self.view addSubview:self.headerTimerView];
    
    ESWeakSelf;
    [_headerTimerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(__weakSelf.navigationView.mas_bottom);
        make.left.right.equalTo(__weakSelf.view);
        make.height.mas_equalTo(ZOOM6(60));
    }];
}

- (UIView *)headerTimerView
{
    if (!_headerTimerView) {
        _headerTimerView = [UIView new];
        _headerTimerView.backgroundColor = RGBCOLOR_I(62, 62, 62);
        CGFloat W_img = ZOOM6(140);
        
        UIButton *explainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [explainBtn setTitleColor:RGBCOLOR_I(255, 231, 24) forState:UIControlStateNormal];
        [explainBtn setTitle:@"任务说明" forState:UIControlStateNormal];
        explainBtn.titleLabel.font = [UIFont boldSystemFontOfSize:ZOOM6(24)];
        explainBtn.backgroundColor = RGBCOLOR_I(255, 89, 79);
        [explainBtn addTarget:self action:@selector(explainBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_headerTimerView addSubview:_explainBtn = explainBtn];
        [explainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.and.right.equalTo(_headerTimerView);
            make.width.mas_equalTo(W_img);
        }];
        
        UIImageView *imgV = [UIImageView new];
        imgV.image = [UIImage imageNamed:@"browse_icon_tongzhi"];
        [_headerTimerView addSubview:imgV];
        
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_headerTimerView.mas_centerY);
            make.left.mas_equalTo(ZOOM6(10));
            make.size.mas_equalTo(CGSizeMake(ZOOM6(30), ZOOM6(30)));
        }];
        
        
        UILabel *messageLab = [UILabel new];
        messageLab.font = [UIFont boldSystemFontOfSize:ZOOM6(24)];
        messageLab.textColor = RGBCOLOR_I(168, 168, 168);
        messageLab.textAlignment = NSTextAlignmentCenter;
        [_headerTimerView addSubview:_messageLab = messageLab];
        [messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(_headerTimerView);
            make.right.equalTo(explainBtn.mas_left);
            make.left.equalTo(imgV.mas_right).offset(ZOOM6(10));
        }];
//        messageLab.text = @"亲，任务奖励就藏在这些商品详情页里噢，快去领取吧~";
        if(self.isTiXian)
        {
            messageLab.text = [NSString stringWithFormat:@"每浏览%zd件衣服即得%zd元提现额度哦，快去领取吧",[Signmanager SignManarer].everyLinlanCount,[Signmanager SignManarer].everyLiulanRaward];
        }else
            messageLab.text = @"亲，任务奖励就藏在这些商品详情页里噢，快去领取吧~";
    }
    return _headerTimerView;
}
- (void)explainBtnClick
{
    [MobClick event:BrowseShop_ExplainButton];
    [self showPopView];
}
- (void)showPopView
{
    NSString *rewardstr = [NSString stringWithFormat:@"每浏览%zd件美衣，即可得到%zd元提现额度，任务奖励就藏在商品里，快去领取吧~",[Signmanager SignManarer].everyLinlanCount,[Signmanager SignManarer].everyLiulanRaward];
    NSString *title = self.isTiXian?rewardstr:@"任务奖励就藏在商品里面噢~";
    TFPopBackgroundView *popBackgV = [[TFPopBackgroundView alloc] initWithTitle:nil message:title showCancelBtn:NO leftBtnText:nil rightBtnText:@"知道啦~"];
    popBackgV.textAlignment = NSTextAlignmentCenter;
    [popBackgV setCancelBlock:^{
        
    } withConfirmBlock:^{
        
    } withNoOperationBlock:^{
        
    }];
    
    [popBackgV show];
    
}

- (MenuButtonView *)menuButtonView
{
    if (!_menuButtonView) {
        _menuButtonView = [[MenuButtonView alloc] init];
        //新加的2017-9-19
        _menuButtonView.frame = CGRectMake(0, 0, kScreenWidth, ZOOM6(70));
        _menuButtonView.titleArray = @[@"最新", @"热销", @"价格↑",@"价格↓"];
    }
    return _menuButtonView;
}

- (TFShoppingVM *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[TFShoppingVM alloc] init];
    }
    return _viewModel;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

@implementation MenuButtonView

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray normalImgArray:(NSArray *)normalImgArray selectImgArray:(NSArray *)selectImgArray
{
    if (self = [super init]) {
        _titleArray = titleArray;
        _normalImgArray = normalImgArray;
        _selectImgArray = selectImgArray;
    }
    return self;
}

- (void)show
{
    ESWeakSelf;
    if (_titleArray.count) {
//        CGFloat W_btn = CGRectGetWidth(self.frame)/self.titleArray.count;
//        CGFloat H_btn = CGRectGetHeight(self.frame);

//        MyLog(@"w: %f, h: %f", W_btn, H_btn);
        
        CGFloat scal = (CGFloat)1/self.titleArray.count;
        
        UIButton *lastBtn =  nil;
        for (int i = 0; i<self.titleArray.count; i++) {
            UIButton *btn = [UIButton new];
//            btn.backgroundColor = COLOR_RANDOM;
            [btn setTitle:self.titleArray[i] forState:UIControlStateNormal];
            [btn setTitle:self.titleArray[i] forState:UIControlStateSelected];
            btn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
            [btn setTitleColor:COLOR_ROSERED forState:UIControlStateSelected];
            [btn setTitleColor:RGBCOLOR_I(68, 68, 68) forState:UIControlStateNormal];
//            [btn setImage:self.selectImgArray[i] forState:UIControlStateSelected];
//            [btn setImage:self.normalImgArray[i] forState:UIControlStateNormal];
            btn.tag = 100 + i;
            [btn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:btn];
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                if (!lastBtn) {
                    make.left.equalTo(__weakSelf.mas_left);
                } else {
                    make.left.equalTo(lastBtn.mas_right);
                }
                make.centerY.equalTo(__weakSelf.mas_centerY);
                make.width.equalTo(__weakSelf.mas_width).multipliedBy(scal);
                make.height.equalTo(__weakSelf.mas_height);
//                make.size.mas_equalTo(CGSizeMake(100, ZOOM6(80)));
            }];
            lastBtn = btn;
        }
        
    }
}

- (void)menuBtnClick:(UIButton *)sender
{
    for (int i = 0; i<self.titleArray.count; i ++) {
        UIButton *btn = (UIButton *)[self viewWithTag:100+i];
        btn.selected = NO;
    }
    sender.selected = YES;
    
    NSInteger index = sender.tag - 100;
    if (self.menuBtnClickBlock) {
        self.menuBtnClickBlock(index);
    }
}


@end
