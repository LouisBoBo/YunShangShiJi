//
//  HYJIntelgralDetalViewController.m
//  YunShangShiJi
//
//  Created by hyj on 15/9/8.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "HYJIntelgralDetalViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "HYJIntegralCell.h"
#import "IntegralModel.h"
#import "MJRefresh.h"


@interface HYJIntelgralDetalViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *bgScrollView;


@property (nonatomic, strong)UITableView *tableView1;
@property (nonatomic, strong)UITableView *tableView2;

@property (nonatomic, strong)NSMutableArray *dataArr1;
@property (nonatomic, strong)NSMutableArray *dataArr2;


@property (nonatomic, assign)int page1;
@property (nonatomic, assign)int page2;

@end

@implementation HYJIntelgralDetalViewController
{
   // NSString *_inOrOut;
    
   // UIButton *_oldBtn;
}

- (void)dealloc
{
    if (self.tableView1.topShowView) {
        [self.tableView1 removeObserver:self.tableView1 forKeyPath:observerRefreshHeaderViewKeyPath];
    }
    if (self.tableView2.topShowView) {
        [self.tableView2 removeObserver:self.tableView2 forKeyPath:observerRefreshHeaderViewKeyPath];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super setNavigationItemLeft:@"积分明细"];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, Height_NavBar-1, kScreenWidth, 1)];
    lineView.backgroundColor = lineGreyColor;
    [self.view addSubview:lineView];

    [self createUI];
    
    if (self.index == 0) {
        self.bgScrollView.contentOffset = CGPointMake(0, 0);
        self.page1 = 1;
        UIButton *btn = ( UIButton *)[self.view viewWithTag:1000];
        btn.selected = YES;
        [self httpGetIn];
    } else if (self.index == 1) {
        self.bgScrollView.contentOffset = CGPointMake(kScreenWidth, 0);
        self.page2 = 1;
        UIButton *btn = ( UIButton *)[self.view viewWithTag:1001];
        btn.selected = YES;
        [self httpGetOut];
    }
}

- (NSMutableArray*)dataArr1
{
    if (_dataArr1 ==nil) {
        _dataArr1 = [[NSMutableArray alloc] init];
    }
    return _dataArr1;
}
- (NSMutableArray*)dataArr2
{
    if (_dataArr2 ==nil) {
        _dataArr2 = [[NSMutableArray alloc] init];
    }
    return _dataArr2;
}


- (void)createUI
{
    self.page1 = 1;
    self.page2 = 1;
    
    UIView *integralview = [[UIView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, ZOOM6(400))];
    UIImageView *integralimage = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-ZOOM6(140)*1.43)/2, ZOOM6(60), ZOOM6(140)*1.43, ZOOM6(140))];
    integralimage.image = [UIImage imageNamed:@"-icon_jinfen_mingxi"];
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), CGRectGetMaxY(integralimage.frame)+ZOOM6(20), kScreenWidth-ZOOM6(20)*2, ZOOM6(30))];
    lab1.text = @"当前积分";
    lab1.font = [UIFont systemFontOfSize:ZOOM6(28)];
    lab1.textColor = RGBCOLOR_I(62, 62, 62);
    lab1.textAlignment = NSTextAlignmentCenter;
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), CGRectGetMaxY(lab1.frame)+ZOOM6(20), kScreenWidth-ZOOM6(20)*2, ZOOM6(72))];
    lab2.text = self.jifen;
    lab2.textAlignment = NSTextAlignmentCenter;
    lab2.font = [UIFont systemFontOfSize:ZOOM6(72)];
    lab2.textColor = tarbarrossred;

    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(integralview.frame)-ZOOM6(20), kScreenWidth, ZOOM6(20))];
    lab3.backgroundColor = RGBCOLOR_I(240, 240, 240);
    
    [self.view addSubview:integralview];
    [integralview addSubview:integralimage];
    [integralview addSubview:lab1];
    [integralview addSubview:lab2];
    [integralview addSubview:lab3];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(integralview.frame), kScreenWidth, (40))];
    [self.view addSubview:headView];
    UIView *vView = [[UIView alloc] initWithFrame:CGRectMake(headView.frame.size.width/2-0.5, (10), 1, (20))];
    vView.backgroundColor = RGBCOLOR_I(220,220,220);
    [headView addSubview:vView];
    
    UIView *hView = [[UIView alloc] initWithFrame:CGRectMake(0, headView.frame.size.height-1, headView.frame.size.width, 1)];
    hView.backgroundColor = RGBCOLOR_I(220,220,220);
    [headView addSubview:hView];
    
    UIButton *lBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lBtn.frame = CGRectMake(0, 0, headView.frame.size.width/2-1, headView.frame.size.height);
    [lBtn setTitleColor:RGBCOLOR_I(22,22,22) forState:UIControlStateNormal];
    [lBtn setTitleColor:COLOR_ROSERED forState:UIControlStateSelected];
    [lBtn setTitle:@"积分收入" forState:UIControlStateNormal];
    lBtn.titleLabel.font = kFont6px(34);
    [lBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    lBtn.tag = 1000;
    [headView addSubview:lBtn];
    
    UIButton *rBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rBtn.frame = CGRectMake(headView.frame.size.width/2, 0, headView.frame.size.width/2-1, headView.frame.size.height);
    [rBtn setTitleColor:RGBCOLOR_I(22,22,22) forState:UIControlStateNormal];
    [rBtn setTitleColor:COLOR_ROSERED forState:UIControlStateSelected];
    [rBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    rBtn.titleLabel.font = kFont6px(34);
    rBtn.tag = 1001;
    [rBtn setTitle:@"积分支出" forState:UIControlStateNormal];
    [headView addSubview:rBtn];
    
    self.bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,  headView.bottom, kScreenWidth, kScreenHeight- headView.bottom)];
    self.bgScrollView.contentSize = CGSizeMake(kScreenWidth*2, self.bgScrollView.frame.size.height);
    self.bgScrollView.bounces = NO;
    self.bgScrollView.pagingEnabled = YES;
    self.bgScrollView.delegate = self;
    self.bgScrollView.showsHorizontalScrollIndicator = NO;
    //    self.bgScrollView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.bgScrollView];
    
    //创建tableView
    self.tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.bgScrollView.frame.size.width, self.bgScrollView.frame.size.height)];
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    self.tableView1.tag = 200;
    [self.tableView1 registerNib:[UINib nibWithNibName:@"HYJIntegralCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView1.tableFooterView = [[UIView alloc] init];
    [self.bgScrollView addSubview:self.tableView1];
    
    self.tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, self.bgScrollView.frame.size.width, self.bgScrollView.frame.size.height)];
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    self.tableView2.tag = 201;
    [self.tableView2 registerNib:[UINib nibWithNibName:@"HYJIntegralCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView2.tableFooterView = [[UIView alloc] init];
    [self.bgScrollView addSubview:self.tableView2];
    
    
    
    __weak HYJIntelgralDetalViewController *myController = self;
//    [self.tableView1 addHeaderWithCallback:^{
//        myController.page1 = 1;
//        [myController httpGetIn];
//    }];
    
    
    [self.tableView1 addTopHeaderWithCallback:^{
        myController.page1 = 1;
        [myController httpGetIn];
    }];
    
    [self.tableView1 addFooterWithCallback:^{
        myController.page1++;
        [myController httpGetIn];
    }];
    
    
//    //上下拉刷新
//    [self.tableView2 addHeaderWithCallback:^{
//        myController.page2 = 1;
//        [myController httpGetOut];
//    }];
    
    [self.tableView2 addTopHeaderWithCallback:^{
        myController.page2 = 1;
        [myController httpGetOut];
    }];
    
    [self.tableView2 addFooterWithCallback:^{
        myController.page2++;
        [myController httpGetOut];
    }];
    
    
}

- (void)btnClick:(UIButton *)sender
{
    for (int i = 0; i<2; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:1000+i];
        btn.selected = NO;
    }
    sender.selected = !sender.selected;
    self.index = (int)sender.tag - 1000;
    if (sender.tag == 1000) {
        self.bgScrollView.contentOffset = CGPointMake(0, 0);
    } else if (sender.tag == 1001) {
        self.bgScrollView.contentOffset = CGPointMake(kScreenWidth, 0);
    }
    
    if (self.index == 0) {
        self.page1 = 1;
        [self httpGetIn];
    } else if (self.index == 1) {
        self.page2 = 1;
        [self httpGetOut];
    }
}


#pragma mark - 积分收入
- (void)httpGetIn
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/queryIntegralList?token=%@&version=%@&expenses=>&page=%@&sort=%@&order=desc",[NSObject baseURLStr],token,VERSION,@(_page1),@"add_time"];
    
    NSString *URL = [MyMD5 authkey:urlStr];
    //URL = %@",URL);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        responseObject = [NSDictionary changeType:responseObject];
        
        [self clearBackgroundView:self.bgScrollView withTag:99999];
        
        [self.tableView1 ffRefreshHeaderEndRefreshing];
//        [self.tableView1 headerEndRefreshing];
        [self.tableView1 footerEndRefreshing];
        
        //积分收入 res = %@", responseObject);
        
        
        if (responseObject!=nil) {
            if (self.page1 == 1) {
                [self.dataArr1 removeAllObjects];
                [self.tableView1 reloadData];
            }
            
            if ([responseObject[@"status"] isEqualToString:@"1"]) {
                
                NSArray *data = responseObject[@"data"];
                
                
                if (self.dataArr1.count ==0&&data.count == 0) {
                    CGRect frame = CGRectMake(0, 0, self.bgScrollView.frame.size.width, self.bgScrollView.frame.size.height);
                    [self createBackgroundView:self.bgScrollView andTag:10000 andFrame:frame withImgge:nil andText:nil];
                    
                } else {
                    [self clearBackgroundView:self.bgScrollView withTag:10000];
                    
                    for (NSDictionary *dic in data) {
                        IntegralModel *model = [[IntegralModel alloc] init];
                        model.desc = dic[@"type"];
                        model.time = dic[@"add_time"];
                        model.count = dic[@"num"];
                        [_dataArr1 addObject:model];
                        
                    }
                    [self.tableView1 reloadData];
                }
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.tableView1 ffRefreshHeaderEndRefreshing];
//        [self.tableView1 headerEndRefreshing];
        [self.tableView1 footerEndRefreshing];
        
        CGRect frame = CGRectMake(0, 0, self.bgScrollView.frame.size.width, self.bgScrollView.frame.size.height);
        [self createBackgroundView:self.bgScrollView andTag:99999 andFrame:frame withImgge:[UIImage imageNamed:@"哭脸"] andText:@"亲,没网了"];
    }];
}

- (void)httpGetOut
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/queryIntegralList?token=%@&version=%@&expenses=<&page=%@&sort=%@&order=desc",[NSObject baseURLStr],token,VERSION,@(_page2),@"add_time"];
    NSString *URL = [MyMD5 authkey:urlStr];
    //URL = %@",URL);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        responseObject = [NSDictionary changeType:responseObject];
        [self clearBackgroundView:self.bgScrollView withTag:99999];
        
        [self.tableView2 ffRefreshHeaderEndRefreshing];
//        [self.tableView2 headerEndRefreshing];
        [self.tableView2 footerEndRefreshing];
        
        //积分支出 res = %@", responseObject);
        
        if (responseObject!=nil) {
            if (self.page2 == 1) {
                [self.dataArr2 removeAllObjects];
                [self.tableView2 reloadData];
            }
            
            if ([responseObject[@"status"] isEqualToString:@"1"]) {
                
                NSArray *data = responseObject[@"data"];
                
                //data = %@", data);
                
                
                if (self.dataArr2.count ==0&&data.count == 0) {
                    CGRect frame = CGRectMake(self.bgScrollView.frame.size.width, 0, self.bgScrollView.frame.size.width, self.bgScrollView.frame.size.height);
                    
                    [self createBackgroundView:self.bgScrollView andTag:10001 andFrame:frame withImgge:nil andText:nil];
                    
                } else {
                    [self clearBackgroundView:self.bgScrollView withTag:10001];
                    
                    for (NSDictionary *dic in data) {
                        IntegralModel *model = [[IntegralModel alloc] init];
                        model.desc = dic[@"type"];
                        model.time = dic[@"add_time"];
                        model.count = dic[@"num"];
                        [_dataArr2 addObject:model];
                        
                    }
                    [self.tableView2 reloadData];
                }
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.tableView2 ffRefreshHeaderEndRefreshing];
//        [self.tableView2 headerEndRefreshing];
        [self.tableView2 footerEndRefreshing];
        
        CGRect frame = CGRectMake(self.bgScrollView.frame.size.width, 0, self.bgScrollView.frame.size.width, self.bgScrollView.frame.size.height);
        [self createBackgroundView:self.bgScrollView andTag:99999 andFrame:frame withImgge:[UIImage imageNamed:@"哭脸"] andText:@"亲,没网了"];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 200) {
        return [self.dataArr1 count];
    } else if (tableView.tag == 201) {
        return [self.dataArr2 count];
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (70);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYJIntegralCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    IntegralModel *model;
    if (tableView.tag == 200) {
       model = _dataArr1[indexPath.row];
        
    } else if (tableView.tag == 201) {
        model = _dataArr2[indexPath.row];
    }
    [cell refreshWithModel:model];
    return cell;
}

#pragma mark - scrollView
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.bgScrollView) {
        
        int oldIndex = (int)self.index;
        self.index = scrollView.contentOffset.x/kScreenWidth;
        if (oldIndex!=self.index) {
            for (int i = 0; i<2; i++) {
                UIButton *btn = (UIButton *)[self.view viewWithTag:1000+i];
                btn.selected = NO;
                if (self.index == i) {
                    btn.selected = YES;
                }
            }
            
            if (self.index == 0) {
                self.page1 = 1;
                [self httpGetIn];
            } else if (self.index == 1) {
                self.page2 = 1;
                [self httpGetOut];
            }

        }
    }
}

- (void)leftBarButtonClick
{
    if (self.navigationController == [Mtarbar.viewControllers objectAtIndex:Mtarbar.viewControllers.count-1]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
