//
//  SubmitViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/11.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "SubmitViewController.h"
#import "MymineViewController.h"
#import "GlobalTool.h"
#import "NavgationbarView.h"
#import "LoginViewController.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "AFNetworking.h"
#import "MyMD5.h"
#import "NavgationbarView.h"
#import "TFHomeViewController.h"
#import "ShopStoreViewController.h"
#import "MyTabBarController.h"
#import "AppDelegate.h"
#import "MyTabBarController.h"

#import "MakeMoneyViewController.h"
#import "SubmitBackgroundView.h"
#import "SmileView.h"

#define NavigationHeight 44
#define SIZE [[UIScreen mainScreen] bounds].size


@interface SubmitViewController ()<SubmitBackgroundViewDelegate>

{
    NSMutableArray *_headArray;
    NSMutableArray *_DataArray;
    NSMutableArray *_countArray;
    NSMutableArray *_sectionArray;
   
    
    //列表数据源
    NSMutableArray *_tableviewDataArray;
    
    //设置喜欢数据
    NSMutableArray *_likeArray;
    //选择喜欢的ID
    NSMutableString *_likeIDstring;
    
    CGFloat _heigh;
    NSInteger _count;
    
    //记录按钮选中状态
    BOOL _isselect;
    
    NSArray * _tagCateArray;
}

@property (nonatomic ,assign)NSInteger cateCount;


@end

@implementation SubmitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _headArray=[NSMutableArray array];
    _DataArray=[NSMutableArray array];
    _countArray=[NSMutableArray array];
    _tableviewDataArray =[NSMutableArray array];
    _likeArray=[NSMutableArray array];
    _sectionArray = [NSMutableArray array];
    _likeIDstring=[NSMutableString string];
    
    _heigh=0;
    _count=0;
    _isselect=NO;
    

    if([self.typestring isEqualToString:@"完善喜好"])
    {
        //6 色系 shop/attr/sexi.png 7 sys_color
        //101 风格 shop/attr/fengge.png 3 style

        _tagCateArray = @[@[@"7", @"4", @"9", @"1045", @"1047", @"49",@"50",@"51",@"52",@"1"],
                        @[@"图案", @"场合", @"特点1", @"特点2",@"特点3", @"材质-四季",@"材质-春秋冬",@"材质-秋冬",@"材质-冬",@"年龄"],
                        @[@"shop/attr/tuan.png", @"shop/attr/changhe.png", @"shop/attr/tedian.png", @"shop/attr/tedian.png", @"shop/attr/tedian.png", @"shop/attr/caizhi.png", @"shop/attr/caizhi.png", @"shop/attr/caizhi.png",@"shop/attr/caizhi.png", @"shop/attr/nianling.png"],
                        @[@"12", @"6", @"13", @"14", @"15",@"8",@"9", @"10", @"11", @"5"],
                        @[@"pattern", @"occasion", @"trait", @"trait2", @"trait3",@"stuff",@"stuff2",@"stuff3",@"stuff4",@"age"]];
        
        
    } else if ([self.typestring isEqualToString:@"开店"]) {
        
        //4 场合 shop/attr/changhe.png 6 occasion
        //1 年龄 shop/attr/nianling.png 5 age
        
        _tagCateArray = @[@[@"5",@"3",@"2",@"6",@"101"],
                        @[@"最爱", @"定价", @"尺寸", @"色系", @"风格"],
                        @[@"shop/attr/zuiai.png", @"shop/attr/dingjia.png", @"shop/attr/chicun.png", @"shop/attr/sexi.png", @"shop/attr/fengge.png"],
                        @[@"1", @"2", @"4", @"7",@"3"],
                        @[@"favorite",@"fix_price",@"size",@"sys_color",@"style"]];

    }
    
    
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    //设置我的喜欢
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"我喜欢";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor = tarbarrossred;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    
    NSArray *categoryArr;
    
    NSMutableArray *tmpMuArr = [NSMutableArray array];
    NSMutableArray *muCharArr = [[NSMutableArray alloc] init];  //筛选特点
    
    
    NSMutableArray *idArr;
    NSMutableArray *nameArr;
    NSMutableArray *iconArr;
    NSMutableArray *sequenceArr;
    NSMutableArray *enameArr;
    if (_tagCateArray.count != 0) {
        categoryArr = [NSArray arrayWithArray:_tagCateArray];
        
    } else {
        categoryArr = [self FindDataForTAGDB:@"0"];        //筛选分类
    }
    
//    //categoryArr = %@",categoryArr);
    
    if (categoryArr.count!=0 && categoryArr.count>=5) {
        idArr = [NSMutableArray arrayWithArray:categoryArr[0]];
        nameArr = [NSMutableArray arrayWithArray:categoryArr[1]];
        iconArr = [NSMutableArray arrayWithArray:categoryArr[2]];
        sequenceArr = [NSMutableArray arrayWithArray:categoryArr[3]];
        enameArr = [NSMutableArray arrayWithArray:categoryArr[4]];
//        
//        MyLog(@"idArr: %@", idArr);
//        MyLog(@"sequenceArr: %@", sequenceArr);
//        
        if (sequenceArr.count>0) {
            for (int i= 0 ; i<sequenceArr.count-1; i++) {
                for (int j = 0; j<sequenceArr.count-1-i; j++) {
                    
                    int k1 = [sequenceArr[j] intValue];
                    int k2 = [sequenceArr[j+1] intValue];
                    
                    if (k1>k2) {
                        [sequenceArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                        [nameArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                        [idArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                        [iconArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                        [enameArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                    }
                    
                }
            }
        }
        
        [tmpMuArr addObject:idArr];
        [tmpMuArr addObject:nameArr];
        [tmpMuArr addObject:iconArr];
        [tmpMuArr addObject:sequenceArr];
        [tmpMuArr addObject:enameArr];
        
    }
    self.cateCount = idArr.count;
    
    //按固定ID查找
    for (NSString *s in idArr) {
        NSArray *arr = [self FindDataForTAGDB:s];
        [muCharArr addObject:arr];
    }
    
//    MyLog(@"tmpMuArr = %@ muCharArr = %@",tmpMuArr,muCharArr);
    
    self.submitBackgroundView = [[SubmitBackgroundView alloc] initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, self.view.frame.size.height-Height_NavBar)];
    self.submitBackgroundView.categoryArr = tmpMuArr;
    self.submitBackgroundView.charArr = muCharArr;
    self.submitBackgroundView.fontSize = (int)ZOOM6(32);
    self.submitBackgroundView.btnH = (int)ZOOM6(70);
    self.submitBackgroundView.headH = (int)ZOOM6(58);
    self.submitBackgroundView.lrMargin = (int)ZOOM6(35);
    self.submitBackgroundView.delegate = self;
    [self.view addSubview:self.submitBackgroundView];
}

- (void)closeDB
{
    if (AttrcontactDB) {
        sqlite3_close(AttrcontactDB);
        AttrcontactDB = 0x00;
        
    }
    
}

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
//                        if([self.Sqlitetype isEqualToString:@"attr"])
            {
//                sql_stmt = "CREATE TABLE IF NOT EXISTS ATTDB(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT,PHONE TEXT)";
            }
//                        if([self.Sqlitetype isEqualToString:@"type"])
            {
                
//                sql_stmt = "CREATE TABLE IF NOT EXISTS TYPDB(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT,PHONE TEXT)";
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



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Myview.hidden=YES;

#if 0
    
    [self OpenDb];
    
    //-------%@",self.nameArray);
    
    
    
    for(int i=0;i<self.nameArray.count;i++)
    {
        
        NSMutableDictionary *dic=self.array[i];
        NSString *str=[dic objectForKey:self.nameArray[i]];
        [self creatData:str TAG:i];
        
    }
    
    [self creatview];
    
    
#endif

    
    
}

#pragma mark - 查询TAG表-- 数据库查找数据 
- (NSArray *)FindDataForTAGDB:(NSString *)findStr
{
        NSMutableArray *idArr = [NSMutableArray array];
        NSMutableArray *nameArr = [NSMutableArray array];
        NSMutableArray *iconArr = [NSMutableArray array];
        NSMutableArray *sequenceArr = [NSMutableArray array];
        NSMutableArray *enameArr =[NSMutableArray array];
    
        NSMutableArray *muArr = [[NSMutableArray alloc] init];
        if([self OpenDb])
        {
            const char *dbpath = [_databasePath UTF8String];
            sqlite3_stmt *statement;
            
            if (sqlite3_open(dbpath, &AttrcontactDB) == SQLITE_OK)
            {
                NSString *querySQL = [NSString stringWithFormat:@"SELECT id,name,phone,ico,sequence,ename from TAGDB where address=\"%@\"",findStr];
                const char *query_stmt = [querySQL UTF8String];
                
                if (sqlite3_prepare_v2(AttrcontactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    
                    while (sqlite3_step(statement) == SQLITE_ROW)
                    {
                        NSString *ID = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                        NSString *name = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                        NSString *icon = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                        NSString *sequence = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                        NSString *ename = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                        
                            [idArr addObject:ID];
                            [nameArr addObject:name];
                            [iconArr addObject:icon];
                            [sequenceArr addObject:sequence];
                            [enameArr addObject:ename];
                        
                    }
                    
                    [muArr addObject:idArr];
                    [muArr addObject:nameArr];
                    [muArr addObject:iconArr];
                    [muArr addObject:sequenceArr];
                    [muArr addObject:enameArr];
                    sqlite3_finalize(statement);
                }
                sqlite3_close(AttrcontactDB);
            }
        }
    
   
    
        return muArr;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
    
}


-(void)creatData:(NSString*)str TAG:(NSInteger)tag
{
    NSMutableArray *arr=[NSMutableArray array];
    
    
    if([self OpenDb])
    {
        
        const char *dbpath = [_databasePath UTF8String];
        sqlite3_stmt *statement;
        
        if (sqlite3_open(dbpath, &AttrcontactDB) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat:@"SELECT id,name,phone from TAGDB where address=\"%@\"",str];
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(AttrcontactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    
                  
                    NSString *name = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                    
                    [arr addObject:name];
                   
                    
                }
                
                sqlite3_finalize(statement);
                
            }
            
            
            sqlite3_close(AttrcontactDB);
            
            if(arr.count)
            {
                NSMutableDictionary *dic=[NSMutableDictionary dictionary];
                [dic setObject:arr forKey:self.nameArray[tag]];
                [_tableviewDataArray addObject:dic];
                
            }

        }
    
    }
 
   
}

//失效

-(void)creatview
{

    //hyj
    UIScrollView *myscrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kApplicationWidth, kScreenHeight-Height_NavBar-40)];
    myscrollview.delegate=self;
    myscrollview.contentSize=CGSizeMake(0, 2000);
    [self.view addSubview:myscrollview];
    
    NSMutableArray *sizearray=[NSMutableArray array];
    NSMutableArray *countarray=[NSMutableArray array];
//    NSArray *imageArray=@[@"年龄",@"尺寸",@"定价",@"场合",@"最爱",@"色系",@"图案",@"材质",@"特点",@"风格"];
    NSArray *imageArray=@[@"尺寸",@"定价",@"最爱",@"色系",@"风格"];
    //UILabel *headlable;
    UIView *headView;

    for(int h=0; h<self.nameArray.count;h++)
    {
        
        if(h==0)
        {
            _heigh=0;

        }else{
            
            NSMutableDictionary *dic=_tableviewDataArray[h-1];
            NSMutableArray *arr=[dic objectForKey:self.nameArray[h-1]];
            
            if(arr.count%4==0)
            {
                _count=arr.count/4 ;
            }else{
                _count=arr.count/4+1;
            }

            _heigh = _heigh+_count*40+30;
            //heig is %f",_heigh);
        }
    
        [countarray addObject:[NSString stringWithFormat:@"%d",_count]];
        [sizearray addObject:[NSString stringWithFormat:@"%f",_heigh]];
    }
    
    int k=0;
    
    for(int h=0;h<sizearray.count;h++)
    {
        CGFloat heigh=[sizearray[h] floatValue];
        
//        headlable=[[UILabel alloc]initWithFrame:CGRectMake(0, heigh, kApplicationWidth, 30)];
//        headlable.text=[NSString stringWithFormat:@"%@",self.nameArray[h]];
//        //headlable.backgroundColor=kbackgrayColor;
//        [myscrollview addSubview:headlable];
        
        headView = [[UIView alloc] initWithFrame:CGRectMake(0, heigh, kApplicationWidth, 30)];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 20, 20)];
        imageView.image = [UIImage imageNamed:imageArray[h]];
        
        [headView addSubview:imageView];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, kApplicationWidth - 40, 30)];
        label.text = [NSString stringWithFormat:@"%@",self.nameArray[h]];
        label.textColor = kTextColor;
        [headView addSubview:label];
        
        [myscrollview addSubview:headView];

        
        UIButton *colorbtn;
        CGFloat btnwidh=(kApplicationWidth-50)/4;
        
        NSMutableDictionary *dic=_tableviewDataArray[h];
        
        NSMutableArray *arr=[dic objectForKey:self.nameArray[h]];
        //%@",self.nameArray);
        
        for(int j=1;j<arr.count+1;j++)
        {
            
            colorbtn=[[UIButton alloc]init];
            if(j<5)
            {
                colorbtn.frame=CGRectMake(10+(btnwidh+10)*(j-1), headView.frame.origin.y+headView.frame.size.height+5, btnwidh, 30);
            }else if(j<9){
                colorbtn.frame=CGRectMake(10+(btnwidh+10)*(j-5), headView.frame.origin.y+headView.frame.size.height+45, btnwidh, 30);
            }else if(j<13)
            {
                colorbtn.frame=CGRectMake(10+(btnwidh+10)*(j-9), headView.frame.origin.y+headView.frame.size.height+85, btnwidh, 30);
            }else if(j<17){
                colorbtn.frame=CGRectMake(10+(btnwidh+10)*(j-13), headView.frame.origin.y+headView.frame.size.height+125, btnwidh, 30);
            }else if(j<21){
                colorbtn.frame=CGRectMake(10+(btnwidh+10)*(j-17), headView.frame.origin.y+headView.frame.size.height+165, btnwidh, 30);
            }else{
                colorbtn.frame=CGRectMake(10+(btnwidh+10)*(j-21), headView.frame.origin.y+headView.frame.size.height+205, btnwidh, 30);
            }
            
            [colorbtn setTitle:[NSString stringWithFormat:@"%@",arr[j-1]] forState:UIControlStateNormal];
            
            
            
            colorbtn.tag=2000+k;
            colorbtn.layer.borderWidth=0.5;
            colorbtn.layer.borderColor = kTextColor.CGColor;
            colorbtn.layer.cornerRadius=15;

            [colorbtn setTitleColor:kTextColor forState:UIControlStateNormal];
            colorbtn.titleLabel.font=[UIFont systemFontOfSize:13];
            [colorbtn addTarget:self action:@selector(colorlick:) forControlEvents:UIControlEventTouchUpInside];
            [myscrollview addSubview:colorbtn];
            
            k++;
        }

    }
   
    
    //加上最后一个高度
    if(_tableviewDataArray.count>1)
    {
    
    NSMutableDictionary *dic=_tableviewDataArray[self.nameArray.count-1];
    NSMutableArray *arr=[dic objectForKey:self.nameArray[self.nameArray.count-1]];
    if(arr.count%4==0)
    {
        _count=arr.count/4 ;
    }else{
        _count=arr.count/4+1;
    }
    }
    _heigh = _heigh+_count*35+30+20;
    myscrollview.contentSize=CGSizeMake(0, _heigh);
}

#pragma mark 设置喜欢
-(void)colorlick:(UIButton*)sender
{
    
    if(sender.selected==NO)
    {
        UIButton *button=(UIButton*)[self.view viewWithTag:sender.tag];
        
        button.backgroundColor=tarbarrossred;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.layer.borderWidth=0;
        sender.selected=YES;
        
        //将用户选择的喜好添加到数组里
        if(button.titleLabel.text)
        {
            [_likeArray addObject:button.titleLabel.text];
            
        }
        
    }else{
        UIButton *button=(UIButton*)[self.view viewWithTag:sender.tag];
        
        button.backgroundColor=[UIColor clearColor];
        [button setTitleColor:kTextColor forState:UIControlStateNormal];
        button.layer.borderWidth=0.5;
        sender.selected=NO;
        
        //如果取消选择将从数组里删除
        for(int i=0;i<_likeArray.count;i++)
        {
            if([button.titleLabel.text isEqualToString:_likeArray[i]])
            {
                [_likeArray removeObjectAtIndex:i];
                
            }
        }
    }
    
    
}



-(void)clickon:(UIButton *)sender
{
    //OK");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark 提交喜好
-(void)submit
{
    [_sectionArray removeAllObjects];
    NavgationbarView *mentionview=[[NavgationbarView alloc]init];
    
    
    for(int i=0;i<_likeArray.count;i++)
    {
        for (NSDictionary *dic in _tableviewDataArray) {
            for (int j=0;j<_nameArray.count;j++) {
                NSArray *arr = dic[_nameArray[j]];
                for (int k=0; k<arr.count; k++) {
                    if ([_likeArray[i] isEqualToString:arr[k]]) {
                        
                            [_sectionArray addObject:@(j)];
                        ////%@",_sectionArray);
                        }
                }
            }
        }
    }
    
    //去除重复元素
    NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
    
    for (unsigned i = 0; i < [_sectionArray count]; i++){
             
             if ([categoryArray containsObject:[_sectionArray objectAtIndex:i]] == NO){
                 [categoryArray addObject:[_sectionArray objectAtIndex:i]];
             }
             
    }
    //%@",categoryArray);
    
    if(_likeArray.count>=10)
    {
        [self requestHTTP];
        
    } else{
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"请选择喜好 每项必选" Controller:self];

    }
    
}
#pragma mark 提交喜好网络请求
-(void)requestHTTP
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    manager.requestSerializer.timeoutInterval = 300;

    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString*token=[user objectForKey:USER_TOKEN];


    if([self.typestring isEqualToString:@"完善喜好"])//如果是完善喜好拼接开店选择的喜好一起传给后台
    {
        NSString *oldhobby = [user objectForKey:USER_HOBBY];
        NSString *likeid = [NSString stringWithFormat:@"%@,%@",oldhobby,_likeIDstring];
        _likeIDstring = [NSMutableString stringWithString:likeid];
    }
    
    NSString *url=[NSString stringWithFormat:@"%@user/update_userinfo?version=%@&token=%@&hobby=%@",[NSObject baseURLStr],VERSION,token,_likeIDstring];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        //responseObject is %@",responseObject);
        
        
        //1234567890//
        /*
         
         message = "\U7528\U6237\U4fe1\U606f\U4fee\U6539\U6210\U529f.";
         status = 1;
         
         store =     {
         "circle_status" = 0;
         "circle_sys_pic" = "<null>";
         "circle_user_pic" = "<null>";
         "coupon_list" = 0;
         id = 1048;
         "is_up" = 1;
         "like_name" = "\U5e97\U4e3b\U6700\U7231";
         model = 1;
         notice = "<null>";
         "qr_pic" = "<null>";
         realm = 11781;
         remark = "<null>";
         "s_bg_pic" = "<null>";
         "s_clicks" = 0;
         "s_code" = 11781;
         "s_content" = "\U5e97\U4e3b\U5f88\U61d2\U3002\U3002\U3002";
         "s_fans" = 0;
         "s_name" = "\U71d5\U5b50\U7f8e\U8863\U94fa";
         "s_pic" = "<null>";
         "s_sign" = "<null>";
         "templet_code" = "2-1";
         "user_id" = 11781;
         "weixin_qq" = "<null>";
         };
         
         userinfo =     {
         account = "<null>";
         "add_admin" = "<null>";
         "add_date" = "2015-11-10 19:47:14";
         age = "<null>";
         "bg_pic" = "userinfo/bg_pic/default.jpg";
         birthday = "<null>";
         city = "<null>";
         "code_type" = 1;
         email = "<null>";
         "email_status" = 0;
         gender = "<null>";
         hobby = "21,11,31,17,36,25,750,731,84,87,92,99,58,55,67";
         hobbyList =         (
         21,
         11,
         31,
         17,
         36,
         25,
         750,
         731,
         84,
         87,
         92,
         99,
         58,
         55,
         67
         );
         "home_address" = "<null>";
         imei = "<null>";
         "is_location" = "<null>";
         model = "";
         nickname = "\U71d5\U5b50";
         "parent_id" = "<null>";
         "person_sign" = "<null>";
         phone = 13456789123;
         pic = "userinfo/head_pic/default.jpg";
         province = "<null>";
         remarks = "<null>";
         "store_time" = "2015-11-10 19:47:14";
         type = "<null>";
         "upd_admin" = "<null>";
         "upd_date" = "<null>";
         "user_id" = 11781;
         "user_ident" = "<null>";
         "user_name" = "<null>";
         "user_type" = 1;
         value = 9;
         };
         
         
         */
        
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *message=responseObject[@"message"];
            NSString *str=responseObject[@"status"];
            
            
            if(str.intValue==1)
            {
                
                NSDictionary *dic=responseObject[@"store"];
                //保存当前用户登录/注册信息
                NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
                
//                if([responseObject[@"t_time"] doubleValue] >0 && [responseObject[@"reward"] boolValue]==YES)
                if([responseObject[@"t_time"] doubleValue] >0 && [responseObject[@"s_time"] doubleValue] > 0)
                {
                    //保存余额翻倍时间
                    [userdefaul setObject:responseObject[@"s_time"] forKey:DOUBLE_S_TIME];
                    [userdefaul setObject:responseObject[@"t_time"] forKey:DOUBLE_T_TIME];
                    
                    [DataManager sharedManager].isOligible = YES;
                    [DataManager sharedManager].isOpen = NO;
                    
                    [DataManager sharedManager].endDate = ((NSNumber *)responseObject[@"t_time"]).longLongValue;
                }
                if([self.typestring isEqualToString:@"完善喜好"])
                {
                    NSString *oldhobby = [userdefaul objectForKey:USER_HOBBY];
                    
                    if(oldhobby.length !=0)
                    {
                        NSString *newhobby = [NSString stringWithFormat:@"%@",responseObject[@"userinfo"][@"hobby"]];
                        MyLog(@"newhobby= %@",newhobby);
                        [userdefaul setObject:newhobby forKey:USER_HOBBY];
                    }

                    NSNotification *notecenter = [[NSNotification alloc]initWithName:@"hobbysuccess" object:nil userInfo:nil];
                    [[NSNotificationCenter defaultCenter] postNotification:notecenter];
                    
                }else{
                    [userdefaul setObject:responseObject[@"userinfo"][@"hobby"] forKey:USER_HOBBY];
                    
                    MyLog(@"hobby=%@",responseObject[@"userinfo"][@"hobby"]);
                }
              
                [self createPopView];
                
                [self performSelector:@selector(pushtoViewControllerAnimated) withObject:self afterDelay:1.5];
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
                
                
                [MBProgressHUD hideHUDForView:self.view];
                
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:message Controller:self];
                
                if ([self.delegate respondsToSelector:@selector(submitFailure:)]) {
                    [self.delegate submitFailure:self];
                }
                
            }
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        
        
    }];

}
-(void)createPopView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    view.backgroundColor = [[UIColor colorWithRed:60/255.0 green:61/255.0 blue:62/255.0 alpha:0.8] colorWithAlphaComponent:0.7];
    //    view.alpha = 0.9;
    view.tag = 8888;
    

    UIView * smileView=[[UIView alloc]initWithFrame:CGRectMake(10, (kApplicationHeight-200)/2, kApplicationWidth-20, ZOOM(580))];
    smileView.backgroundColor=[UIColor whiteColor];
   UIImageView *smileImg = [[UIImageView alloc]initWithFrame:CGRectMake(smileView.frame.size.width/2-35, smileView.frame.size.height/2-50, 64, 56)];
    //    smileView.center = CGPointMake(kApplicationWidth/2, 100);
    smileImg.image = [UIImage imageNamed:@"表情"];
    smileImg.contentMode = UIViewContentModeScaleAspectFit;
    [smileView addSubview:smileImg];
    
   UILabel* thanksLabel = [[UILabel alloc]initWithFrame:CGRectMake(smileView.frame.size.width/2-150, smileImg.frame.origin.y+smileImg.frame.size.height+30, 300, 30)];
    thanksLabel.text = @"恭喜你,喜好选择成功!";
    thanksLabel.textColor = tarbarrossred;
    [thanksLabel setFont:[UIFont systemFontOfSize:ZOOM(56)]];
    thanksLabel.textAlignment = NSTextAlignmentCenter;
    [smileView addSubview:thanksLabel];


    
    [view addSubview:smileView];
    
    [self.view addSubview:view];

}
-(void)disapper:(NSTimer*)timer
{
    UIView *view = [self.view viewWithTag:8888];
    [view removeFromSuperview];
}

-(void)pushtoViewControllerAnimated
{
//                [self rootviewcontroller];
    
    
    if ([self.typestring isEqualToString:@"开店"]) {
        UINavigationController *nc = Mtarbar.viewControllers[2];
        
        MakeMoneyViewController *hsVC = (MakeMoneyViewController *)[nc.viewControllers firstObject];
        hsVC.fromType = @"小店";
        Mtarbar.selectedIndex = 2;
    }
    
    
    if ([self.delegate respondsToSelector:@selector(submitSuccess:)]) {
        [self.delegate submitSuccess:self];
        
    }
    

    [self.navigationController popViewControllerAnimated:YES];

}
#pragma mark - 代理
- (void)selectBtnEnd:(SubmitBackgroundView *)screeningBackgroundView withChooseArray:(NSArray *)chooseArray
{
    NavgationbarView *nv =[[NavgationbarView alloc] init];
    
    _likeIDstring =[NSMutableString stringWithString:@""];
    
    if (chooseArray.count == self.cateCount) {
        
        NSMutableArray *sectionArray = [[NSMutableArray alloc] init];
        NSMutableArray *idArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in chooseArray) {
            [sectionArray addObject:dic[@"cate"]];
            [idArray addObject:dic[@"chac"]];
        }
        
        for (NSString *ID in idArray) {
            if(ID)
            {
                [_likeIDstring appendString:ID];
                [_likeIDstring appendString:@","];
            }
        }
        
        [self requestHTTP];
        
    } else {
        [nv showLable:@"每一类至少选择一项" Controller:self];
    }
    
}


-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
