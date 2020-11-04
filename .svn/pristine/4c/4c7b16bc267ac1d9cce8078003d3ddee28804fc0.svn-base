//
//  TFBusinessCategoryViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/10/27.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "TFBusinessCategoryViewController.h"
#import "TFBusinessCategoryBackgroundView.h"

#import "NavgationbarView.h"
@interface TFBusinessCategoryViewController () <TFBusinessCategoryBackgroundDelegate>

@property (nonatomic, strong)TFBusinessCategoryBackgroundView *businessCategoryView;

@end

@implementation TFBusinessCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super setNavigationItemLeft:@"选择类目"];
    [self createUserInterface];
    
}

- (void)createUserInterface
{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, Height_NavBar-1, kScreenWidth, 1)];
    lineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.view addSubview:lineView];
    
    NSArray *categoryFindArr = [self FindDataForBUSDB:@"0"];   
    
    //排序...
//    NSArray *sortArr = [self sortTheTitleFromArray:categoryFindArr];
    
    NSArray *sortArr = categoryFindArr;
    
    NSMutableArray *categoryArr = [NSMutableArray array];
    for (NSDictionary *dic in sortArr) {
        if ([dic[@"isShow"] intValue] == 1) {
            [categoryArr addObject:dic];
        }
    }
    
    NSMutableArray *muCharArr = [[NSMutableArray alloc] init];  //筛选特点
    if (categoryArr.count!=0) {
        NSArray *idArr = [self getArrayFindFromArray:categoryArr withKey:@"id"];
        for (NSString *s in idArr) {
            NSArray *arr = [self FindDataForBUSDB:s];
            NSMutableArray *charMuArr = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                if ([dic[@"isShow"] intValue] == 1) {
                    [charMuArr addObject:dic];
                }
            }
            [muCharArr addObject:charMuArr];
        }
    }
    
    self.businessCategoryView = [[TFBusinessCategoryBackgroundView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7+1, kScreenWidth, kScreenHeight-kNavigationheightForIOS7-1)];
    self.businessCategoryView.backgroundColor = [UIColor whiteColor];
    
    self.businessCategoryView.categoryArr = categoryArr;
    self.businessCategoryView.charArr = muCharArr;
    
    self.businessCategoryView.titleFontSize = ZOOM(48);
    self.businessCategoryView.btnH = ZOOM(100);
    self.businessCategoryView.btnFontSize  = ZOOM(44);
    self.businessCategoryView.v_Margin = ZOOM(41);
    self.businessCategoryView.headH = ZOOM(80);
    self.businessCategoryView.lrMargin = ZOOM(50);
    self.businessCategoryView.h_Margin = ZOOM(32);
    self.businessCategoryView.cate_v_Margin = ZOOM(50);
    self.businessCategoryView.delegate = self;
    [self.view addSubview:self.businessCategoryView];
    
}

- (void)selectBtnEnd:(TFBusinessCategoryBackgroundView *)screeningBackgroundView withChooseArray:(NSArray *)chooseArray
{
//    //chooseArr = %@", chooseArray);
    if (chooseArray.count) {
        if ([self.delegate respondsToSelector:@selector(selectBtnEnd:)]) {
            [self.delegate selectBtnEnd:chooseArray];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        NavgationbarView *nv = [[NavgationbarView alloc] init];
        [nv showLable:@"请选择类目" Controller:self];
    }
}

//从一个存着字典的数组中 找对应 key的Velue值 存在数组
- (NSArray *)getArrayFindFromArray:(NSArray *)sourceArr withKey:(NSString *)key
{
    NSMutableArray *muArr = [NSMutableArray array];
    for (NSDictionary *dic in sourceArr) {
        [muArr addObject:dic[key]];
    }
    return muArr;
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
#pragma mark - 数据库操作
- (void)closeDB
{
    if (AttrcontactDB) {
        sqlite3_close(AttrcontactDB);
        AttrcontactDB = 0x00;
        
    }
}

//开启数据库
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


#pragma mark - 查询TAG表
-(NSArray *)FindDataForBUSDB:(NSString *)findStr
{
    
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    if([self OpenDb])
    {
        const char *dbpath = [_databasePath UTF8String];
        sqlite3_stmt *statement;
        
        if (sqlite3_open(dbpath, &AttrcontactDB) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat:@"SELECT id,name,phone,ico from BUSDB where address=\"%@\"",findStr];
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(AttrcontactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    NSMutableDictionary *mudic = [NSMutableDictionary dictionary];
                    NSString *ID = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                    NSString *name = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                    NSString *isShow = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                    NSString *icon = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
//                    NSString *sequence = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
//                    //sequence = %@", sequence);
                    [mudic setValue:ID forKey:@"id"];
                    [mudic setValue:name forKey:@"name"];
                    [mudic setValue:isShow forKey:@"isShow"];
                    [mudic setValue:icon forKey:@"icon"];
//                    [mudic setValue:sequence forKey:@"sequence"];
                    [muArr addObject:mudic];
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(AttrcontactDB);
        }
        
        
        
    }
    return muArr;
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
