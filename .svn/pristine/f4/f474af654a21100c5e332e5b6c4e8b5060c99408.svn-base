//
//  WaterFallFlowViewModel.m
//  FJWaterfallFlow
//
//  Created by fujin on 16/1/8.
//  Copyright © 2016年 fujin. All rights reserved.
//

#import "WaterFallFlowViewModel.h"
#import "GlobalTool.h"
#import "HobbyModel.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import <sqlite3.h>
@implementation WaterFallFlowViewModel
{
    //数据库
    sqlite3 *AttrcontactDB;
    NSString* _databasePath ;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        self.contentAndidArray = [NSMutableArray array];
        self.dataArray = [NSMutableArray array];
        self.saleArray = [NSMutableArray array];
        self.styleArry = [NSMutableArray array];
        self.agesArray = [NSMutableArray array];
        self.titleArry = [NSMutableArray array];
    }
    return self;
}

- (void)getData:(void (^)())success Fail:(void (^)())fail{
    NSArray *sectionArr =@[@"为了能让衣蝠更加了解你，从而智能为你推荐美衣，所以需要填写一下信息。填写完成后可以随时到个人中心进行修改。\n\n1.消费习惯（多选）",@"2.喜爱风格（多选）",@"3.年龄段（单选）"];
    [self.titleArry addObjectsFromArray:sectionArr];
    
    [self requestHTTP:^{
        if(success)
        {
            success();
        }
    } Fail:^{
        if(fail)
        {
            fail();
        }
    }];
    
//    [self getCategoryArr];
}

#pragma mark 获取喜好网络请求
-(void)requestHTTP:(void (^)())success Fail:(void(^)())fail
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    manager.requestSerializer.timeoutInterval = 300;
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString*token=[user objectForKey:USER_TOKEN];
    
    NSString *url=[NSString stringWithFormat:@"%@shop/getUserHobbyData?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject!=nil) {
        
            NSString *str=responseObject[@"status"];
            
            if(str.intValue==1)
            {
                if([responseObject[@"1"] count] > 0)//消费习惯
                {
                    [self getDatafromHttp:responseObject[@"1"] Index:1];
                }
                
                if([responseObject[@"2"] count] > 0)//喜爱风格
                {
                    [self getDatafromHttp:responseObject[@"2"] Index:2];
                }

                if([responseObject[@"3"] count] > 0)//年龄段
                {
                    [self getDatafromHttp:responseObject[@"3"] Index:3];
                }
                
                if(success){
                    success();
                }
            }else{
                if(fail){
                    fail();
                }
            }
            
        }else{
            if(fail){
                fail();
            }

        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if(fail){
            fail();
        }

    }];
    
}

- (void)getDatafromHttp:(NSArray*)dataArr Index:(int)index
{
    //已经选择的喜好
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSMutableString *idstr = [userdefaul objectForKey:USER_HOBBY];
    NSArray *idArr = [idstr componentsSeparatedByString:@"_"];
    NSMutableString *choseStr;NSMutableString *heighweigh;
    if(idArr.count == 2)
    {
        choseStr = idArr[0];
        heighweigh = idArr[1];
    }else{
        choseStr = idArr[0];
    }
    NSArray *choseArray = [choseStr componentsSeparatedByString:@","];
    
    for(NSDictionary *dic in dataArr)
    {
        HobbyModel *moddel = [[HobbyModel alloc]init];
        moddel.ID = [NSString stringWithFormat:@"%@",dic[@"like_id"]];
        moddel.title = [NSString stringWithFormat:@"%@",dic[@"like_name"]];
        moddel.pic = [NSString stringWithFormat:@"%@",dic[@"like_pic"]];
        
        for(int k=0;k<choseArray.count;k++)
        {
            if([choseArray[k] intValue] == moddel.ID.intValue)
            {
                if(index==2)
                {
                    moddel.is_Select = YES;
                }else{
                    moddel.is_SaleMark = YES;
                }
                break;
            }
        }

        if(index == 1)
        {
            [self.saleArray addObject:moddel];
        }else if (index == 2)
        {
            [self.styleArry addObject:moddel];
        }else if (index == 3)
        {
            [self.agesArray addObject:moddel];
        }
    }

    if(index == 3)
    {
        NSArray *dataArr = @[self.saleArray,self.styleArry,self.agesArray];
        [self.dataArray addObjectsFromArray:dataArr];
        
        if(heighweigh.length>0)
        {
            NSArray *heightweightArr = [heighweigh componentsSeparatedByString:@","];
            if(heightweightArr.count >= 2)
            {
                self.height = heightweightArr[0];
                self.weight = heightweightArr[1];
            }
        }
    }
}
- (void)getCategoryArr
{
    NSArray *categoryArr = [self FindDataForTAGDB:@"0"];        //筛选分类
    NSMutableArray *tmpMuArr = [NSMutableArray array];
    NSMutableArray *muCharArr = [NSMutableArray array] ;  //筛选特点
    
    NSMutableArray *idArr;
    NSMutableArray *nameArr;
    NSMutableArray *iconArr;
    NSMutableArray *sequenceArr;
    NSMutableArray *enameArr;
    
    if (categoryArr.count!=0 && categoryArr.count>=5) {
        idArr = [NSMutableArray arrayWithArray:categoryArr[0]];
        nameArr = [NSMutableArray arrayWithArray:categoryArr[1]];
        iconArr = [NSMutableArray arrayWithArray:categoryArr[2]];
        sequenceArr = [NSMutableArray arrayWithArray:categoryArr[3]];
        enameArr = [NSMutableArray arrayWithArray:categoryArr[4]];
        
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
    
    //按固定ID查找
    for (NSString *s in idArr) {
        NSArray *arr = [self FindDataForTAGDB:s];
        [muCharArr addObject:arr];
    }

    for (int i = 0; i<[tmpMuArr[0] count]; i++) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSArray * contentArray = [NSArray array];
        NSArray * contentIDArray = [NSArray array];
        
        contentArray = [muCharArr[i] objectAtIndex:1];
        contentIDArray = [muCharArr[i] objectAtIndex:0];
        
        NSString *title = [tmpMuArr[1] objectAtIndex:i];
        
        if([title isEqualToString:@"定价"] || [title isEqualToString:@"风格"] || [title isEqualToString:@"年龄"])
        {
            [dic setObject:contentArray forKey:@"content"];
            [dic setObject:contentIDArray forKey:@"contentID"];
            [self.contentAndidArray addObject:dic];
        }
    }
    
    [self getModelData];
}

- (void)getModelData
{
    //已经选择的喜好
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSMutableString *idstr = [userdefaul objectForKey:USER_HOBBY];
    NSArray *idArr = [idstr componentsSeparatedByString:@"_"];
    NSMutableString *choseStr;NSMutableString *heighweigh;
    if(idArr.count == 2)
    {
        choseStr = idArr[0];
        heighweigh = idArr[1];
    }else{
        choseStr = idArr[0];
    }
    NSArray *choseArray = [choseStr componentsSeparatedByString:@","];
    
    for(int i = 0;i<self.contentAndidArray.count;i++)
    {
        NSDictionary *dic = self.contentAndidArray[i];
        NSMutableArray *contentArr = [dic objectForKey:@"content"];
        NSMutableArray *contentID  = [dic objectForKey:@"contentID"];
        for(int j =0;j<contentArr.count;j++)
        {
            HobbyModel *model = [[HobbyModel alloc]init];
            model.is_Select = NO;
            model.is_SaleMark = NO;
            model.ID = [NSString stringWithFormat:@"%@",contentID[j]];
            model.title = [NSString stringWithFormat:@"%@",contentArr[j]];
            
            for(int k=0;k<choseArray.count;k++)
            {
                if([choseArray[k] intValue] == model.ID.intValue)
                {
                    if(i==1)
                    {
                        model.is_Select = YES;
                    }else{
                        model.is_SaleMark = YES;
                    }
                    break;
                }
            }
            
            if(i == 0)
            {
                [self.saleArray addObject:model];
            }else if (i == 1)
            {
                [self.styleArry addObject:model];
            }else if (i == 2)
            {
                [self.agesArray addObject:model];
            }

        }
    }
    
    self.dataArray = @[self.saleArray,self.styleArry,self.agesArray];

    if(heighweigh.length>0)
    {
        NSArray *heightweightArr = [heighweigh componentsSeparatedByString:@","];
        if(heightweightArr.count == 2)
        {
            self.height = heightweightArr[0];
            self.height = heightweightArr[1];
        }
    }
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

@end
