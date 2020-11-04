//
//  ShareFreelingPopViewController.m
//  YunShangShiJi
//
//  Created by hebo on 2019/10/11.
//  Copyright © 2019 ios-1. All rights reserved.
//

#import "ShareFreelingPopViewController.h"
#import "RawardTableViewCell.h"
#import "SUTableView.h"
@interface ShareFreelingPopViewController ()
@property (nonatomic , strong) UIView *zhezhaoview;
@end

@implementation ShareFreelingPopViewController
{
    int _ptyacount;
    BOOL _once_more;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTabview];
    
    [self creatData];
}
- (void)creatData
{
    
    RawardModel *model = [RawardModel alloc];
    [self.fictitiousPtyaArray addObjectsFromArray:[model getPtyaModel:3]];
    [self.totalPtyaArray addObjectsFromArray:self.fictitiousPtyaArray];
    
    [self geteduHttp];
}
//获取额度
- (void)geteduHttp
{
    NSString *urlStr1 = [NSString stringWithFormat:@"%@wallet/extractNewData?version=%@",[NSObject baseURLStr],VERSION];
    NSString *URL1 = [MyMD5 authkey:urlStr1];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:URL1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            
            if ([responseObject[@"status"] intValue] == 1)
            {
                if(responseObject[@"data"])
                {
                    NSArray *dataArr = responseObject[@"data"];
                    for(int i = 0;i<dataArr.count;i++)
                    {
                        NSString *jsonstr = dataArr[i];
                        
                        RawardModel*model = [self getDataFromstr:jsonstr Type:1];
                        [self.realPtyaArray addObject:model];
                    }
                }
            }
            else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
            
            [self getNeWArray];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
    }];
    
}

- (RawardModel*)getDataFromstr:(NSString*)strdata Type:(NSInteger)type
{
    //type 1是额度 2是衣豆
    NSData *jsonData = [strdata dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    MyLog(@"dic = %@",dic);
    
    if(dic)
    {
        RawardModel *model = [[RawardModel alloc]init];
        model.headpic = [NSString stringWithFormat:@"%@",dic[@"pic"]];
        
        if(type == 1)
        {
            
            model.price = [NSString stringWithFormat:@"%@",dic[@"num"]];
            model.type = [NSString stringWithFormat:@"%@",dic[@"type"]];
            model.title = [NSString stringWithFormat:@"%@ %@",dic[@"nname"],[self gettitileStr:model.type.intValue]];
            
        }
        return model;
    }
    
    return nil;
}
- (NSString*)gettitileStr:(NSInteger)type
{
    NSString *str;
    switch (type) {
        case 1:
            str = @"抽红包";
            break;
        case 2:
            str = @"抽奖退款";
            break;
        case 3:
            str = @"粉丝购物";
            break;
        case 4:
            str = @"官方赠送";
            break;
            
        default:
            break;
    }
    
    str = [NSString stringWithFormat:@"%.1f元买走了%@宝贝",[DataManager sharedManager].app_value,str];
    
    return str;
}
//真实数据 虚拟数据交替合并在一起
- (void)getNeWArray
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(self.realPtyaArray.count)
        {
            [self.totalPtyaArray removeAllObjects];
            
            for(int i = 0;i<self.fictitiousPtyaArray.count;i++)
            {
                if(self.realPtyaArray.count>i)
                {
                    RawardModel *model = self.realPtyaArray[i];
                    [self.totalPtyaArray addObject:model];
                }
                
                RawardModel *model1 = self.fictitiousPtyaArray[i];
                [self.totalPtyaArray addObject:model1];
            }
            
            [self.totalPtyaArray addObjectsFromArray:self.realPtyaArray];
            [self.ptyaRwardTableView reloadData];
        }
    });
}
//列表
- (void)creatTabview
{
    CGFloat viewHeigh = 500;
    UIView * backview = [[UIView alloc]initWithFrame:CGRectMake(ZOOM6(20), 0, kScreenWidth-ZOOM6(20)*2, viewHeigh)];
    backview.backgroundColor = [UIColor whiteColor];
    backview.layer.cornerRadius = 5;
    [self.view addSubview:backview];
    
    CGFloat imageHeigh = 0;
    UIImageView *titleimage = [[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(backview.frame)-imageHeigh*7.5)/2, 15, imageHeigh*7.5, imageHeigh)];
    [titleimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/mianfeiling_shikuang.png"]]];
    
    UITableView *tabview = [[SUTableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(backview.frame), CGRectGetHeight(backview.frame)) style:UITableViewStylePlain];
    tabview.delegate = self;
    tabview.dataSource = self;
    tabview.scrollEnabled = NO;
    tabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabview.showsVerticalScrollIndicator = NO;
    [tabview registerNib:[UINib nibWithNibName:@"RawardTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    self.ptyaRwardTableView = tabview;
    
    UIView *clearview = [[UIView alloc]initWithFrame:backview.bounds];
    clearview.backgroundColor = [UIColor clearColor];
    clearview.userInteractionEnabled = YES;
    
    [backview addSubview:tabview];
    [backview addSubview:clearview];
    
    self.mytimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
    
    [self creatZhezhao];
}

- (void)creatZhezhao
{
    UIView *zhezhaoview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height)];
    zhezhaoview.backgroundColor = RGBACOLOR_I(0, 0, 0, 0.7);
    zhezhaoview.userInteractionEnabled = YES;
    [self.view addSubview:self.zhezhaoview = zhezhaoview];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidezhezhao)];
    [zhezhaoview addGestureRecognizer:tap];
}
- (void)hidezhezhao{
    self.zhezhaoview.hidden = YES;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.totalPtyaArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier=@"Cell";
    RawardTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell=[[RawardTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    RawardModel *model = self.totalPtyaArray[indexPath.row];
    [cell refreshOneyuanData:model];
    return cell;
}

- (void)tick:(NSTimer *)time {
    
    _ptyacount ++;
    
    //(25.0 / 30.0) * (float)self.count) ---> (tableview需要滚动的contentOffset / 一共调用的次数) * 第几次调用
    //比如该demo中 contentOffset最大值为 = cell的高度 * cell的个数 ,5秒执行一个循环则调用次数为 300,没1/60秒 count计数器加1,当count=300时,重置count为0,实现循环滚动.
    if(_ptyacount == 0)
    {
        [self.ptyaRwardTableView setContentOffset:CGPointMake(0, 50 * (float)_ptyacount) animated:NO];
    }else{
        kWeakSelf(self);
        [UIView animateWithDuration:3.0 animations:^{
            
            [weakself.ptyaRwardTableView setContentOffset:CGPointMake(0, 50 * (float)_ptyacount) animated:NO];
        }];
    }
    
    if (_ptyacount >= self.totalPtyaArray.count*2) {
        
        _ptyacount = -1;
    }
}
- (NSMutableArray*)fictitiousPtyaArray{
    if(_fictitiousPtyaArray == nil){
        _fictitiousPtyaArray = [NSMutableArray array];
    }
    return _fictitiousPtyaArray;
}
- (NSMutableArray*)realPtyaArray{
    if(_realPtyaArray == nil){
        _realPtyaArray = [NSMutableArray array];
    }
    return _realPtyaArray;
}
- (NSMutableArray*)totalPtyaArray{
    if(_totalPtyaArray == nil){
        _totalPtyaArray = [NSMutableArray array];
    }
    return _totalPtyaArray;
}

@end
