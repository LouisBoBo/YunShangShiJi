//
//  ShopthreeViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/5/15.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "ShopthreeViewController.h"
#import "ShopDetailViewController.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "MyMD5.h"
#import "UIImageView+WebCache.h"
#import "WaterFLayout.h"
#import "MJRefresh.h"
#import "ShopDetailModel.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "NavgationbarView.h"
#import "CollectionViewCell.h"

#import "WaterFlowCell.h"

@interface ShopthreeViewController ()
{
    UICollectionView *_Mycollectionview;
    
    NSMutableArray *_ShuxingArray;
    //数据源
    NSMutableArray *_collDataArray;
    //商品分类数据源
    NSMutableArray *_shopdirvelArray;
    
    //数据库查询到的一级分类数据
    NSMutableArray *_FindArray;
    //数据库查询到的二级分类数据
    NSMutableArray *_FindTwoArray;
    
    NSMutableArray *_DataArray;
    
    //记录当前分类
    NSString *_type1;
}
@end

@implementation ShopthreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _DataArray=[NSMutableArray array];
    _ShuxingArray=[NSMutableArray array];
    _collDataArray=[NSMutableArray array];
    _shopdirvelArray=[NSMutableArray array];
    _FindArray=[NSMutableArray array];
    _FindTwoArray=[NSMutableArray array];
    
    _type1=@"1";
    
    
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //
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
    titlelable.text=self.shoptitle;
    titlelable.textColor=[UIColor blackColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gundong:) name:@"gundong" object:nil];
    
    
    [self OpenDb];
    [self creatData];
    
}

#pragma mark 获取数据源
-(void)creatData
{
    //商品分类查询
    [self FindData];
    
    //流动界面
    [self creatView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Myview.hidden=YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
}

#pragma mark 下拉刷新
-(void)addheadFresh:(NSString*)str
{
    UICollectionView *collectionview=(UICollectionView*)[self.scroll viewWithTag:666+str.intValue];
    _Mycollectionview=collectionview;
    
    [_Mycollectionview addHeaderWithCallback:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // 结束刷新
            [_Mycollectionview headerEndRefreshing];
            
            [_Mycollectionview reloadData];
        });
    }];
    
    [_Mycollectionview headerBeginRefreshing];
}

#pragma mark 上拉刷新
-(void)addfootFresh:(NSString*)str
{
    UICollectionView *collectionview=(UICollectionView*)[self.scroll viewWithTag:666+str.intValue];
    _Mycollectionview=collectionview;
    
    [_Mycollectionview addFooterWithCallback:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_Mycollectionview reloadData];
            // 结束刷新
            [_Mycollectionview footerEndRefreshing];
        });
        
    }];
    
    
}


#pragma mark 开启数据库
-(BOOL)OpenDb
{
    if(AttrcontactDB)
    {
        return YES;
    }
    
    BOOL result=NO;
    
    /*根据路径创建数据库并创建一个表contact(id nametext addresstext phonetext)*/
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    
    _databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"attr.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    //    if ([filemgr fileExistsAtPath:_databasePath] == NO)
    {
        const char *dbpath = [_databasePath UTF8String];
        if (sqlite3_open(dbpath, &AttrcontactDB)==SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt;
            //            if([self.Sqlitetype isEqualToString:@"attr"])
            {
                sql_stmt = "CREATE TABLE IF NOT EXISTS ATTDB(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT,PHONE TEXT)";
            }
            //            if([self.Sqlitetype isEqualToString:@"type"])
            {
                
                sql_stmt = "CREATE TABLE IF NOT EXISTS TYPDB(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT,PHONE TEXT)";
            }
            //            if([self.Sqlitetype isEqualToString:@"tag"])
            {
                sql_stmt = "CREATE TABLE IF NOT EXISTS TAGDB(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT,PHONE TEXT)";
            }
            
            if (sqlite3_exec(AttrcontactDB, sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK) {
                
                result= YES;
            }
        }
        else
        {
            result= NO;
        }
    }
    
    
    return YES;
}

#pragma mark 查询数据库 商品一级分类
-(void)FindData{
    [_shopdirvelArray removeAllObjects];
    
    if([self OpenDb])
    {
        
        const char *dbpath = [_databasePath UTF8String];
        sqlite3_stmt *statement;
        
        if (sqlite3_open(dbpath, &AttrcontactDB) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat:@"SELECT id,name,phone from TYPDB where address=\"%@\"",self.parentid];
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(AttrcontactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    
                    NSString *ID= [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                    NSString *name = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                    
                    NSMutableDictionary *dictionary=[NSMutableDictionary dictionary];
                    
                    [dictionary setObject:ID forKey:name];
                    [_FindArray addObject:dictionary];
                    
                    
                    [_shopdirvelArray addObject:name];
                    
                }
                
                sqlite3_finalize(statement);
                
            }
            
            
            sqlite3_close(AttrcontactDB);
        }
        
    }
    
    if(_FindArray.count && _shopdirvelArray.count)
    {
        NSDictionary *dic=_FindArray[0];
        NSString *ID=[dic objectForKey:_shopdirvelArray[0]];
        //二级商品分类
        [self requestShopHttp:ID TAG:1];
    }
}

#pragma mark 商品列表网络请求
-(void)requestShopHttp:(NSString*)str TAG:(NSInteger)tag
{
    [_collDataArray removeAllObjects];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token= [userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    url=[NSString stringWithFormat:@"%@shop/queryCondition?version=%@&token=%@&code=1&type3=%@",[NSObject baseURLStr],VERSION,token,str];
    NSString *URL=[MyMD5 authkey:url];
    
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        responseObject = [NSDictionary changeType:responseObject];
        [MBProgressHUD hideHUDForView:self.view];
        
//        //
        NSString *statu=responseObject[@"status"];
        NSString *messsage=responseObject[@"message"];
        
        if(statu.intValue==1)
        {
            NSArray *arr=responseObject[@"listShop"];
            for(NSDictionary *dic in arr)
            {
                ShopDetailModel *model=[[ShopDetailModel alloc]init];
                
                model.def_pic=dic[@"def_pic"];
                model.ID=dic[@"id"];
                model.love_num=dic[@"love_num"];
                model.shop_code=dic[@"shop_code"];
                model.shop_name=dic[@"shop_name"];
                model.shop_se_price=dic[@"shop_se_price"];
                
                [_collDataArray addObject:model];
            }
            
            UICollectionView *collectionview=(UICollectionView*)[self.scroll viewWithTag:666+tag];
            _Mycollectionview=collectionview;
            [_Mycollectionview headerEndRefreshing];
            [_Mycollectionview reloadData];
            
            
        }else{
            NavgationbarView *alertview=[[NavgationbarView alloc] init];
            [alertview showLable:messsage Controller:self];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UICollectionView *collectionview=(UICollectionView*)[self.scroll viewWithTag:666+str.intValue];
        _Mycollectionview=collectionview;
        [_Mycollectionview headerEndRefreshing];
        
        [MBProgressHUD hideHUDForView:self.view];
        
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
    
    
}

#pragma mark 创建界面
-(void)creatView
{
    NSMutableArray *viewsArray=[NSMutableArray array];
    
    for(int i=0;i<_shopdirvelArray.count;i++)
    {
        UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, 94, kApplicationWidth, kApplicationHeight-94-50)];
        bottomView.backgroundColor=[UIColor redColor];
        bottomView.tag=555+i;
        
        
        WaterFLayout *flowLayout=[[WaterFLayout alloc]init];
        
        flowLayout.minimumColumnSpacing=2;
        flowLayout.minimumInteritemSpacing=2;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        UICollectionView *collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-Height_NavBar-kUnderStatusBarStartY) collectionViewLayout:flowLayout];
        collectionview.tag=666+i+1;
        collectionview.delegate=self;
        collectionview.dataSource=self;
        collectionview.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [bottomView addSubview:collectionview];
        [collectionview registerNib:[UINib nibWithNibName:@"WaterFlowCell" bundle:nil] forCellWithReuseIdentifier:@"WATERFLOWCELLID"];
        _Mycollectionview=collectionview;
        
        [viewsArray addObject:bottomView];
        
        [self addheadFresh:nil];
        [self addfootFresh:nil];
        
    }
    
    
    CGRect frame =CGRectMake(0, Height_NavBar, kApplicationWidth, kApplicationHeight -Height_NavBar+kUnderStatusBarStartY);//如果没有导航栏，则去掉64
    
    NSArray *names =[NSArray arrayWithArray:_shopdirvelArray];
    
    //创建使用
    if(viewsArray.count && names.count)
    {
        self.scroll =[XLScrollViewer scrollWithFrame:frame withViews:viewsArray withButtonNames:names withThreeAnimation:111 withTag:1 withImage:nil];//三中动画都选择
    }else{
        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake((kApplicationWidth-100)/2, 100, 100, 30)];
        lable.text=@"暂无数据";
        lable.textAlignment=NSTextAlignmentCenter;
        lable.textColor=kTextGreyColor;
        [self.view addSubview:lable];
        
    }
    //自定义各种属性。。打开查看
    self.scroll.xl_topBackColor =[UIColor whiteColor];
    self.scroll.xl_sliderColor =[UIColor orangeColor];
    self.scroll.xl_buttonColorNormal =[UIColor blackColor];
    self.scroll.xl_buttonColorSelected =[UIColor redColor];
    self.scroll.xl_buttonFont =15;
    self.scroll.xl_buttonToSlider =-10;
    self.scroll.xl_sliderHeight =5;
    self.scroll.xl_topHeight =30;
    self.scroll.xl_isSliderCorner =YES;
    
    
    
    //加入控制器视图
    [self.view addSubview:self.scroll];
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _collDataArray.count;
}

//cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaterFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WATERFLOWCELLID" forIndexPath:indexPath];
    
    ShopDetailModel *model=_collDataArray[indexPath.row];
    //    cell.backgroundColor = RGBCOLOR_I(22,22,22);
    [cell receiveDataModel:model];
    return cell;
}

#pragma mark 获取滑动视图
-(void)gundong:(NSNotification*)note
{
    NSString *index=note.object;
    
    if(_FindArray.count && _shopdirvelArray.count)
    {
        NSDictionary *dictionary=_FindArray[index.intValue];
        _type1=[dictionary objectForKey:_shopdirvelArray[index.intValue]];
    }
    [self requestShopHttp:[NSString stringWithFormat:@"%@",_type1] TAG:index.intValue+1];
    [self addheadFresh:[NSString stringWithFormat:@"%d",index.intValue+1]];
    
}


//大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShopDetailModel *model= _collDataArray[indexPath.row];
    CGFloat imgH = 0;
    CGFloat imgW = 0;
    
    CGFloat H = 0;
    CGFloat W = 0;
    
    NSString *st = [model.def_pic substringToIndex:model.def_pic.length-4];
    
    NSArray *comArr = [st componentsSeparatedByString:@"_"];
    
    //    //comArr = %@",comArr);
    
    if (comArr.count>2) {
        imgH = [comArr[2] floatValue];
        imgW = [comArr[1] floatValue];
    }
    
    W = (kScreenWidth-2)/2;
    if (imgW!=0) {
        H = W*imgH/imgW;
    } else {
        H = 0;
    }
    //    //imgH = %f",imgH);
    //    //imgW = %f",imgW);
    //    //W = %f",W);
    //    //H = %f",H);
    CGSize size = CGSizeMake(W, H);
    
    return size;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(_Mycollectionview)
    {
        //OK");
        ShopDetailViewController *detail=[[ShopDetailViewController alloc]init];
        [self.navigationController pushViewController:detail animated:YES];
        
    }else{
        //no");
    }
    
}


-(void)back:(UIButton*)sender
{
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
