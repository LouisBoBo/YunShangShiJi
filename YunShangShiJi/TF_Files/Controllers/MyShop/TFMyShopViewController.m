//
//  TFMyShopViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/8/6.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFMyShopViewController.h"
#import "ShopDetailViewController.h"
#import "SubmitViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"

#pragma mark - 新

#define NavigationHeight 44.0f
#define StatusTableHeight 20.0f
#define TableBarHeight 49.0f
#define TitleHeight self.titleHeight

#import "TYSlidePageScrollView.h"
#import <sqlite3.h>

@interface TFMyShopViewController () <UIWebViewDelegate, TFJSObjCModelDelegate, SubmitViewControllerDelegate,NJKWebViewProgressDelegate>
{
    const char *_sql_stmt;
}

@property (nonatomic, strong) NJKWebViewProgress     *webViewProgress;
@property (nonatomic, strong) NJKWebViewProgressView *webViewProgressView;
@property (nonatomic, strong) UIWebView              *webView;
@property (nonatomic, strong) JSContext              *jsContext;
@property (nonatomic, assign) BOOL                   isFiled;
@property (nonatomic, strong) UIImageView            *startImageView;//选择喜好
@property (nonatomic, copy  ) NSString               *realm;


#pragma mark - 新
@property (nonatomic, weak   ) TYSlidePageScrollView *slidePageScrollView;
@property (nonatomic ,strong ) UIView                *nheadView;

@property (nonatomic, assign ) CGFloat               titleHeight;
@property (nonatomic, strong ) NSMutableArray        *shopDirvelArr;
@property (nonatomic, strong ) NSMutableArray        *dirvelImageArr;
@property (nonatomic, strong ) NSMutableArray        *shopAirveIDArr;
@end

@implementation TFMyShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super setNavigationItemLeft:@"店铺美衣"];

//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    //    NSString *token = [ud objectForKey:USER_TOKEN];
//    self.realm = [NSString stringWithFormat:@"%@",[ud objectForKey:USER_REALM]];
//    //self.realm = %@", self.realm);
//    [self addMyWebView];
//
    [self dataInit];
    
    [self createUI];
    
    [_slidePageScrollView reloadData];
}

- (void)dataInit
{
    self.titleHeight = kZoom6pt(35);
    
    _shopDirvelArr = [NSMutableArray array];
    _dirvelImageArr = [NSMutableArray array];
    _shopAirveIDArr = [NSMutableArray array];
    
    self.isHeadView = YES;
    self.isFootView = NO;
    
    [self creatDataWith];
}

- (void)createUI
{
    [self addSlidePageScrollView];
    [self addHeaderView];
    [self addFooterView];
    [self addTabPageMenu];
}


- (void)addSlidePageScrollView
{
    CGRect frame = CGRectMake(0, NavigationHeight+20, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-(NavigationHeight+20));
    TYSlidePageScrollView *slidePageScrollView = [[TYSlidePageScrollView alloc]initWithFrame:frame];
    
    slidePageScrollView.pageTabBarIsStopOnTop = YES;
    slidePageScrollView.tyDataSource = self;
    
    [self.view addSubview:slidePageScrollView];
    _slidePageScrollView = slidePageScrollView;
}

- (void)addHeaderView
{
    self.nheadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), 1)];
    self.nheadView.backgroundColor = [UIColor whiteColor];
    _slidePageScrollView.headerView = _isHeadView?self.nheadView:nil;
    
}

- (void)addFooterView
{
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), TableBarHeight);
    
    UIView *footerView = [[UIView alloc]initWithFrame:frame];
    footerView.backgroundColor = [UIColor clearColor];
    _slidePageScrollView.footerView = _isFootView?footerView:nil;;
}

- (void)addTabPageMenu
{
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), TitleHeight);
    
    self.nTitleView = [CustomTitleView scrollWithFrame:frame withTag:0 withIndex:0 withButtonNames:_shopDirvelArr withImage:_dirvelImageArr];
    self.nTitleView.backColor = [UIColor whiteColor];
    
    int page = (int)[_slidePageScrollView curPageIndex];
    self.nTitleView.index = page;
    
    _slidePageScrollView.pageTabBar = self.nTitleView;
}

- (void)creatDataWith
{
    NSArray *type0 = [self FindDataForTPYEDB:@"0"];
    
    if(type0.count)
    {
        NSArray *sortArr = [self sortTheTitleFromArray:type0];
        
        int i = 0;
        
        for (NSDictionary *dic in sortArr) {
            if ([dic[@"isShow"] intValue] == 1) {
                [_shopAirveIDArr addObject:dic[@"id"]];
                [_shopDirvelArr addObject:dic[@"name"]];
                [_dirvelImageArr addObject:dic[@"ico"]];
                
                NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
                
                [dicc setValue:dic[@"id"] forKey:@"id"];
                [dicc setValue:dic[@"name"] forKey:@"name"];
                [dicc setValue:[NSNumber numberWithInt:i] forKey:@"index"];
                i++;
                
                [self.typeIndexArr addObject:dicc];
            }
        }
    }
    
    for (int i = 0; i<_shopAirveIDArr.count; i++) {
        [self addCollectionViewWithPage:i withTypeName:_shopDirvelArr[i] withtTypeID:_shopAirveIDArr[i]];
    }
    
    
    [self.nTitleView refreshTitleViewUI:_shopDirvelArr withImgNames:_dirvelImageArr];
    
}

- (void)addCollectionViewWithPage:(NSInteger)page withTypeName:(NSString *)typeName withtTypeID:(NSNumber *)typeID
{
    
    CollectionViewController *collectionVC = [[CollectionViewController alloc] init];
    collectionVC.page = page;
    collectionVC.typeName = typeName;
    collectionVC.typeID = typeID;
    collectionVC.fromType = @"店铺美衣";
    collectionVC.headHeight = self.titleHeight+1;
    [self addChildViewController:collectionVC];
}


- (NSInteger)numberOfPageViewOnSlidePageScrollView
{
    return self.childViewControllers.count;
}

- (UIScrollView *)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView pageVerticalScrollViewForIndex:(NSInteger)index
{
    CollectionViewController *collectionVC = self.childViewControllers[index];
    collectionVC.customDelegate = self;
    //isHeadView = %d", self.isHeadView);
    collectionVC.isHeadView = self.isHeadView;
    return collectionVC.collectionView;
}

- (void)collectionViewPullDownRefreshWithIndex:(int)index
{
    
}


#pragma mark - 数据库查询
#pragma mark - +++++++++++++数据库DB++++++++++

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
    
    //    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    //    if ([filemgr fileExistsAtPath:_databasePath] == NO)
    {
        const char *dbpath = [_databasePath UTF8String];
        if (sqlite3_open(dbpath, &AttrcontactDB)==SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt;
            
            sql_stmt=_sql_stmt;
            if (sqlite3_exec(AttrcontactDB, sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK)
            {
                
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


- (NSArray *)sortTheTitleFromArray:(NSArray *)arr
{
    NSMutableArray *muArr = [NSMutableArray arrayWithArray:arr];
    
    for (int i = 0; i<muArr.count-1; i++) {
        for (int j = 0; j<muArr.count-i-1; j++) {
            NSDictionary *dic = muArr[j];
            NSDictionary *dic2 = muArr[j+1];
            
            if ([dic[@"sequence"] intValue]>[dic2[@"sequence"] intValue]) {
                [muArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    
    return muArr;
}


-(NSArray *)FindDataForTPYEDB:(NSString *)findStr
{
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    if([self OpenDb])
    {
        const char *dbpath = [_databasePath UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_open(dbpath, &AttrcontactDB) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat:@"SELECT id,name,address,phone,ico,sequence,isshow,groupflag from TYPDB where address=\"%@\"",findStr];
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(AttrcontactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    NSMutableDictionary *mudic = [NSMutableDictionary dictionary];
                    NSString *ID= [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                    NSString *name = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                    NSString *ico = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                    NSString *sequence = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                    NSString *isShow = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)];
                    NSString *groupflag = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)];
                    
                    [mudic setValue:ID forKey:@"id"];
                    [mudic setValue:name forKey:@"name"];
                    [mudic setValue:ico forKey:@"ico"];
                    [mudic setValue:sequence forKey:@"sequence"];
                    [mudic setValue:isShow forKey:@"isShow"];
                    [mudic setValue:groupflag forKey:@"groupFlag"];
                    
                    [muArr addObject:mudic];
                    
                }
                
                
                
                sqlite3_finalize(statement);
            }
            sqlite3_close(AttrcontactDB);
        }
        
    }
    return muArr;
}

- (NSMutableArray *)typeIndexArr
{
    if (_typeIndexArr == nil) {
        _typeIndexArr = [[NSMutableArray alloc] init];
    }
    return _typeIndexArr;
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
