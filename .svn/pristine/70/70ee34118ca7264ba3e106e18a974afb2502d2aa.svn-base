//
//  MyintegralViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/21.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "MyintegralViewController.h"
#import "GlobalTool.h"
#import "WaterFLayout.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "AFNetworking.h"
#import "ShopDetailModel.h"
#import "NavgationbarView.h"
#import "MyMD5.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "CollectionViewCell.h"
#import "ShopDetailViewController.h"
#import "LoginViewController.h"
@interface MyintegralViewController ()

@end

@implementation MyintegralViewController
{
    UIImageView *_imageView;
    
    //列表
    UICollectionView *_Mycollectionview;
    //数据源
    NSMutableArray *_collDataArray;
    
    //商品分类数据源
    NSMutableArray *_shopdirvelArray;
    //数据库查询到的一级分类数据
    NSMutableArray *_FindArray;
    
    //记录当前分类
    NSString *_type1;

}
- (void)viewDidLoad {
    [super viewDidLoad];

    _shopdirvelArray=[NSMutableArray array];
    _FindArray=[NSMutableArray array];
    _collDataArray=[NSMutableArray array];
    
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
    
    
    [self requestShopHttp:_type1];
    
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Myview.hidden=YES;
    
    //头上按钮
    [self creatnavView];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
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
    
    NSArray *arr=@[@"首页",@"最新"];
    for(int i=0;i<2;i++)
    {
        [_shopdirvelArray addObject:arr[i]];
    }
    
    if([self OpenDb])
    {
        
        const char *dbpath = [_databasePath UTF8String];
        sqlite3_stmt *statement;
        
        if (sqlite3_open(dbpath, &AttrcontactDB) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat:@"SELECT id,name,phone from TYPDB where address=\"%@\"",@"0"];
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(AttrcontactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    
                    NSString *ID= [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                    NSString *name = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                    
                    NSMutableDictionary *dictionary=[NSMutableDictionary dictionary];
                    
                    
                    [_shopdirvelArray addObject:name];
                    
                }
                
                sqlite3_finalize(statement);
                
            }
            
            
            sqlite3_close(AttrcontactDB);
        }
        
    }
}



-(void)creatnavView
{
    
    NSArray *titlearr=@[@"我的店铺",@"客户管理"];
    CGFloat btnwidh=80;
    for(int i=0;i<titlearr.count;i++)
    {
        //按钮
        self.statuebtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.statuebtn.frame=CGRectMake(100*i+80, 30, btnwidh, 30);
        [self.statuebtn setTitle:titlearr[i] forState:UIControlStateNormal];
        [self.statuebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.statuebtn.titleLabel.font=kNavigationItemFontSize;
        self.statuebtn.tag=8888+i;
        [self.statuebtn addTarget:self action:@selector(click1:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:self.statuebtn];
        
        
        //设置进来时选中的按键
        if(i==0)
        {
            [self.statuebtn setTitleColor:tarbarYellowcolor forState:UIControlStateNormal];;
            self.statuebtn.selected=YES;
            self.selectbtn=self.statuebtn;
        }
    }
    
}

#pragma mark 创建界面
-(void)creatView
{
    NSMutableArray *viewsArray=[NSMutableArray array];
    
  
    for(int i=0;i<_shopdirvelArray.count;i++)
    {
        UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, 94, kApplicationWidth, kApplicationHeight-94+kUnderStatusBarStartY)];
        bottomView.backgroundColor=[UIColor redColor];
        bottomView.tag=555+i;
        
        if(i==0)
        {
            UIScrollView *scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight-94+kUnderStatusBarStartY)];
            scrollview.backgroundColor=[UIColor purpleColor];
            [bottomView addSubview:scrollview];
        
        }else if (i==1){
        
            UIScrollView *scrollview1=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight-94+kUnderStatusBarStartY)];
            scrollview1.backgroundColor=[UIColor yellowColor];
            [bottomView addSubview:scrollview1];

        }else{
        
        WaterFLayout *flowLayout=[[WaterFLayout alloc]init];
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 2, 0, 2);
        UICollectionView *collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kApplicationHeight-94+kUnderStatusBarStartY) collectionViewLayout:flowLayout];
        collectionview.tag=666+i;
        collectionview.delegate=self;
        collectionview.dataSource=self;
        collectionview.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [bottomView addSubview:collectionview];
        [collectionview registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
        _Mycollectionview=collectionview;
        
        [self addheadFresh:nil];
        [self addfootFresh:nil];
            
        }
        
        [viewsArray addObject:bottomView];

       
        
    }
    
    
    
    CGRect frame =CGRectMake(0, Height_NavBar, kApplicationWidth, kApplicationHeight -Height_NavBar+kUnderStatusBarStartY);//如果没有导航栏，则去掉64
    
    NSArray *names =[NSArray arrayWithArray:_shopdirvelArray];
    
    //创建使用
    if(viewsArray.count && names.count)
    {
        self.scroll =[XLScrollViewer scrollWithFrame:frame withViews:viewsArray withButtonNames:names withThreeAnimation:111 withTag:nil withImage:nil];//三中动画都选择
    }else{
        
        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake((kApplicationWidth-100)/2, 100, 100, 30)];
        lable.text=@"暂无数据";
        lable.textAlignment=NSTextAlignmentCenter;
        lable.textColor=kTextGreyColor;
        [self.view addSubview:lable];
        
    }
    //自定义各种属性。。打开查看
    self.scroll.xl_topBackColor =[UIColor redColor];
    self.scroll.xl_sliderColor =[UIColor orangeColor];
    self.scroll.xl_buttonColorNormal =[UIColor whiteColor];
    self.scroll.xl_buttonColorSelected =[UIColor yellowColor];
    self.scroll.xl_buttonFont =15;
    self.scroll.xl_buttonToSlider =-10;
    self.scroll.xl_sliderHeight =5;
    self.scroll.xl_topHeight =30;
    self.scroll.xl_isSliderCorner =YES;
    
    //加入控制器视图
    [self.view addSubview:self.scroll];
    
    self.Myscrollview=(UIScrollView*)self.scroll;
    
}


#pragma mark 一级按钮监听事件
-(void)click1:(UIButton*)sender
{
    for(int i=0;i<2;i++)
    {
        UIButton *btn=(UIButton*)[self.view viewWithTag:8888+i];
        
        if(i+8888==sender.tag)
        {
            [btn setTitleColor:tarbarYellowcolor forState:UIControlStateNormal];
            btn.backgroundColor=[UIColor clearColor];
            
        }else{
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
    }
    
    self.selectbtn.selected=NO;
    sender.selected=YES;
    self.selectbtn=sender;
    
}



#pragma mark 获取滑动视图
-(void)gundong:(NSNotification*)note
{
    NSString *index=note.object;
    
    if(index.intValue >1)
    {
        _type1=[NSString stringWithFormat:@"%d",index.intValue-1];
        [self requestShopHttp:[NSString stringWithFormat:@"%d",index.intValue-1]];
        [self addheadFresh:[NSString stringWithFormat:@"%d",index.intValue]];
    }
    
}

#pragma mark 商品列表网络请求
-(void)requestShopHttp:(NSString*)str
{
    [_collDataArray removeAllObjects];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token= [userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    url=[NSString stringWithFormat:@"%@shop/queryCondition?version=%@&token=%@&code=1&type1=%@",[NSObject baseURLStr],VERSION,token,str];
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
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
                
                UICollectionView *collectionview=(UICollectionView*)[self.scroll viewWithTag:666+str.intValue+1];
                _Mycollectionview=collectionview;
                
                [_Mycollectionview reloadData];
                
                
            }
            else if(str.intValue == 10030){//没登录状态
                
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

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    
        [MBProgressHUD hideHUDForView:self.view];
        
    }];
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _collDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"Cell";
    CollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if(cell==nil)
    {
        cell=[[CollectionViewCell alloc]init];
        
    }
    
    ShopDetailModel *model=_collDataArray[indexPath.item];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //GCD加载图片
//            [cell.titleImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PHOTOhttp,model.def_pic]]];
            
            NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PHOTOhttp,model.def_pic]];
            __block float d = 0;
            __block BOOL isDownlaod = NO;
            [cell.titleImage sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                d = (float)receivedSize/expectedSize;
                isDownlaod = YES;
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image != nil && isDownlaod == YES) {
                    cell.titleImage.alpha = 0;
                    [UIView animateWithDuration:0.5 animations:^{
                        cell.titleImage.alpha = 1;
                    } completion:^(BOOL finished) {
                    }];
                } else if (image != nil && isDownlaod == NO) {
                    cell.titleImage.image = image;
                }
            }];
            
            CGFloat imgwidh;
            CGFloat imgheigh;
            
            NSString *str=model.def_pic;
            str=[str substringToIndex:[str length]-4];
            NSArray *arr=[str componentsSeparatedByString:@"_"];
            if(arr.count)
            {
                imgheigh=[arr[1] floatValue];
                imgwidh=[arr[2] floatValue];
            }
            
            CGFloat f=imgheigh/imgwidh;
            
            cell.titleImage.frame=CGRectMake(0, 0, cell.titleImage.frame.size.width, cell.titleImage.frame.size.width/f);
            
//            cell.titleImage.layer.cornerRadius=5;
//            cell.titleImage.layer.masksToBounds = YES;
//            cell.titleImage.layer.borderColor = [UIColor brownColor].CGColor;
//            cell.titleImage.layer.borderWidth = 1;
            
            //文字
            cell.title.text=model.shop_name;
            cell.title.numberOfLines=0;
            cell.title.font=[UIFont systemFontOfSize:15];
            
            CGFloat titleHeigh=0;
            titleHeigh=[self getRowHeight:cell.title.text];
            cell.title.frame=CGRectMake(0, cell.titleImage.frame.origin.y+cell.titleImage.frame.size.height+5, 145, titleHeigh);
            
            //分割线
            cell.lableline.frame=CGRectMake(cell.lableline.frame.origin.x, cell.title.frame.origin.y+cell.title.frame.size.height+2, cell.lableline.frame.size.width, cell.lableline.frame.size.height);
            
            //价格
            cell.shopprice.text=[NSString stringWithFormat:@"￥%.2f",[model.shop_se_price floatValue]];
            cell.shopprice.frame=CGRectMake(0, cell.title.frame.origin.y+cell.title.frame.size.height, cell.shopprice.frame.size.width, 25);
            //星
            cell.lovenum.frame=CGRectMake(cell.lovenum.frame.origin.x, cell.title.frame.origin.y+cell.title.frame.size.height+3, cell.lovenum.frame.size.width, cell.lovenum.frame.size.height);
            //喜欢数
            cell.lovenumber.text=[NSString stringWithFormat:@"%@",model.love_num];
            cell.lovenumber.frame=CGRectMake(cell.lovenumber.frame.origin.x, cell.title.frame.origin.y+cell.title.frame.size.height, cell.lovenumber.frame.size.width, 25);
            
        });
        
    });
    
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
    CGFloat imgwidh;
    CGFloat imgheigh;
    
    ShopDetailModel *model=_collDataArray[indexPath.item];
    NSString *str=model.def_pic;
    str=[str substringToIndex:[str length]-4];
    NSArray *arr=[str componentsSeparatedByString:@"_"];
    if(arr.count)
    {
        imgheigh=[arr[1] floatValue];
        imgwidh=[arr[2] floatValue];
    }
    
    CGFloat f=imgwidh/imgheigh;
    
    CGSize _size;
    
    _size=CGSizeMake(145, 145/f+55);
    
    return _size;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(_Mycollectionview)
    {
        //OK");
        ShopDetailViewController *detail=[[ShopDetailViewController alloc]init];
        CollectionViewCell *cell = (CollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
        detail.bigimage=cell.titleImage.image;

        [self.navigationController pushViewController:detail animated:YES];
        
    }else{
        //no");
    }
    
}



-(void)clickon:(UIButton*)sender
{
    //tag is %@",sender);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


#pragma mark 下拉刷新
-(void)addheadFresh:(NSString*)str
{
    UICollectionView *collectionview=(UICollectionView*)[self.scroll viewWithTag:666+str.intValue];
    _Mycollectionview=collectionview;
    
    __weak UICollectionView *weakCollect = _Mycollectionview;
    
    [_Mycollectionview addHeaderWithCallback:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakCollect reloadData];
            // 结束刷新
            [weakCollect headerEndRefreshing];
        });
    }];
    
    [_Mycollectionview headerBeginRefreshing];
}

#pragma mark 上拉刷新
-(void)addfootFresh:(NSString*)str
{
    UICollectionView *collectionview=(UICollectionView*)[self.scroll viewWithTag:666+str.intValue];
    _Mycollectionview=collectionview;
    
    __weak UICollectionView *weakCollect = _Mycollectionview;
    
    [_Mycollectionview addFooterWithCallback:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakCollect reloadData];
            // 结束刷新
            [weakCollect footerEndRefreshing];
        });
        
    }];
    
    
}

-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
