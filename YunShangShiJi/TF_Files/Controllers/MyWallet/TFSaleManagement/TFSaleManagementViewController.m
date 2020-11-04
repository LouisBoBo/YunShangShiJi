//
//  TFSaleManagementViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/7.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFSaleManagementViewController.h"
#import "TFButton.h"
#import "TFDrawView.h"
#import "SaleManageModel.h"

@interface TFSaleManagementViewController () <UIScrollViewDelegate>

@property (nonatomic, assign)int headIndex;
@property (nonatomic , strong)UIView *headView;
@property (nonatomic, strong)UIScrollView *bgScrollView;

@property (nonatomic, strong)UIView *bgView1;
@property (nonatomic, strong)UILabel *todayLabel;
@property (nonatomic, strong)UILabel *yesterdayLabel;
@property (nonatomic, strong)UILabel *dayLabel;
@property (nonatomic, strong)UILabel *yesterCountLabel;
@property (nonatomic, strong)UILabel *dayCountLabel;

@property (nonatomic, strong)UIView *bgView2;
@property (nonatomic, strong)UILabel *todayBackLabel;
@property (nonatomic, strong)UILabel *dayBackLabel;
@property (nonatomic, strong)UILabel *turnoverBackLabel;
@property (nonatomic, strong)UILabel *countBackLabel;

@property (nonatomic, strong)UIView *bgView3;
@property (nonatomic, strong)UILabel *yesterdayVisityLabel;
@property (nonatomic, strong)UILabel *dayVisityLabel;
@property (nonatomic, strong)UILabel *countVisityLabel;

@property (nonatomic, strong)TFDrawView *tfDV1;
@property (nonatomic, strong)TFDrawView *tfDV2;
@property (nonatomic, strong)TFDrawView *tfDV3;

@property (nonatomic, strong)NSMutableArray *data1;
@property (nonatomic, strong)NSMutableArray *data2;
@property (nonatomic, strong)NSMutableArray *data3;

//今天日期
@property (nonatomic, copy)NSString *curLineDate; //2015-07-20格式
@property (nonatomic, copy)NSString *curDate; //20150720格式

@end

@implementation TFSaleManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super setNavigationItemLeft:@"销售管理"];
    [self createUI];
    
    [self httpBgView1];
}
#pragma mark - 创建UI

- (void)createUI
{
    //首先获取今日的日期//以24小时显示
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:date];
    self.curLineDate = [dateStr substringToIndex:10];
    
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"yyyyMMdd HH:mm:ss"];
    NSString *dateStr2 = [formatter2 stringFromDate:date];
    self.curDate = [dateStr2 substringToIndex:8];
    
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7+2, kScreenWidth, (40))];
    self.headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headView];
    
    NSArray *titleArr = [NSArray arrayWithObjects:@"每日金额",@"每日奖金",@"每日访客", nil];
    //背景
    self.bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.headView.frame.origin.y+self.headView.frame.size.height, kScreenWidth, kScreenHeight-self.headView.frame.origin.y-self.headView.frame.size.height)];
    self.bgScrollView.pagingEnabled = YES;
    self.bgScrollView.bounces = YES;
    self.bgScrollView.delegate = self;
    self.bgScrollView.tag = 1000;
    self.bgScrollView.showsHorizontalScrollIndicator = NO;
    self.bgScrollView.contentSize = CGSizeMake(titleArr.count*kScreenWidth, kScreenHeight-self.headView.frame.origin.y-self.headView.frame.size.height);
    [self.view addSubview:self.bgScrollView];
    
    CGFloat W_btn = ZOOM(270);
    
    for (int i = 0; i<titleArr.count; i++) {
        TFButton *tfbtn = [[TFButton alloc] initWithFrame:CGRectMake((kScreenWidth-W_btn*titleArr.count)/6+i*W_btn+i*(kScreenWidth-W_btn*titleArr.count)/3, 0, W_btn, self.headView.frame.size.height)];
        [tfbtn setTitle:titleArr[i] forState:UIControlStateNormal];
        tfbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(50)];
        if (i == 0) {
            tfbtn.selected = YES;
        }
        [tfbtn setTitleColor:COLOR_ROSERED forState:UIControlStateSelected];
        [tfbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        tfbtn.tag = 100+i;
        [tfbtn addTarget:self action:@selector(tfBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        tfbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(50)];
        [self.headView addSubview:tfbtn];
    }
    [self createBgView1];
    [self createBgView2];
    [self createBgView3];
}

- (void)tfBtnClick:(TFButton *)sender
{
    for (int i = 0; i<3; i++) {
        TFButton *tfbtn = (TFButton *)[self.headView viewWithTag:100+i];
        tfbtn.selected = NO;
    }
    sender.selected = YES;
    if (sender.tag == 100) {
        self.headIndex = 0;
        [self.data1 removeAllObjects];
        [self httpBgView1];
    } else if (sender.tag == 101) {
        self.headIndex = 1;
        [self.data2 removeAllObjects];
        [self httpBgView2];
    } else if (sender.tag == 102) {
        self.headIndex = 2;
        [self.data3 removeAllObjects];
        [self httpBgView3];
    }
    self.bgScrollView.contentOffset = CGPointMake(kScreenWidth*self.headIndex, 0);
}
#pragma mark - scrollView滑动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.headIndex = scrollView.contentOffset.x/kScreenWidth;
    for (int i = 0; i<3; i++) {
        TFButton *btn = (TFButton *)[self.headView viewWithTag:100+i];
        btn.selected = NO;
        if (self.headIndex == btn.tag-100) {
            btn.selected = YES;
        }
    }
    if (self.headIndex == 0) {
        [self.data1 removeAllObjects];
        [self httpBgView1];
    } else if (self.headIndex == 1) {
        [self.data2 removeAllObjects];
        [self httpBgView2];
    } else if (self.headIndex == 2) {
        [self.data3 removeAllObjects];
        [self httpBgView3];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.headIndex = scrollView.contentOffset.x/kScreenWidth;
    for (int i = 0; i<3; i++) {
        TFButton *btn = (TFButton *)[self.headView viewWithTag:100+i];
        btn.selected = NO;
        if (self.headIndex == btn.tag-100) {
            btn.selected = YES;
        }
    }
//    if (self.headIndex == 0) {
//        [self.data1 removeAllObjects];
//        [self httpBgView1];
//    } else if (self.headIndex == 1) {
//        [self.data2 removeAllObjects];
//        [self httpBgView2];
//    } else if (self.headIndex == 2) {
//        [self.data3 removeAllObjects];
//        [self httpBgView3];
//    }
}

- (void)httpBgView1
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *store_code = [ud objectForKey:STORE_CODE];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/sellMoney?token=%@&store_code=%@&version=%@",[NSObject baseURLStr],token,store_code,VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];
    
    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                
                if (responseObject[@"data"]!=[NSNull null]) {
                    NSArray *dataArr = responseObject[@"data"];
                    for (NSDictionary *dic in dataArr) {
                        SaleManageModel *smModel = [[SaleManageModel alloc] init];
                        [smModel setValuesForKeysWithDictionary:dic];
                        [self.data1 addObject:smModel];
                    }
                    //self.data1 = %@",self.data1);
                    [self refreshView1];
                }
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
}

- (void)httpBgView2
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/sellKickback?token=%@&version=%@",[NSObject baseURLStr],token,VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                //
                if (responseObject[@"data"]!=[NSNull null]) {
                    NSArray *dataArr = responseObject[@"data"];
                    for (NSDictionary *dic in dataArr) {
                        SaleManageModel *smModel = [[SaleManageModel alloc] init];
                        [smModel setValuesForKeysWithDictionary:dic];
                        [self.data2 addObject:smModel];
                    }
                    [self refreshView2];
                }
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }

        }
        
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
          
          NavgationbarView *mentionview=[[NavgationbarView alloc]init];
          [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
}

- (void)httpBgView3
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *store_code = [ud objectForKey:STORE_CODE];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/sellStoreVisitor?token=%@&store_code=%@&version=%@",[NSObject baseURLStr],token,store_code,VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                
                if (responseObject[@"data"]!=[NSNull null]) {
                    NSArray *dataArr = responseObject[@"data"];
                    for (NSDictionary *dic in dataArr) {
                        SaleManageModel *smModel = [[SaleManageModel alloc] init];
                        [smModel setValuesForKeysWithDictionary:dic];
                        [self.data3 addObject:smModel];
                    }
                    [self refreshView3];
                    
                }
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }

        }
        
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
}

- (void)refreshView1
{
//    //%s",__func__);
    
    float turnover = 0;
    int count = 0;
    for (SaleManageModel *model in self.data1) {

        int curHour = [self calculationSecFor1970:self.curDate];
        int tHour = [self calculationSecFor1970:model.t];
        
        int t = curHour-tHour;
        
        if (t<24) {
            self.todayLabel.text = [NSString stringWithFormat:@"￥%.2f",[model.sum floatValue]];
            self.dayCountLabel.text = [NSString stringWithFormat:@"%d单",[model.count intValue]];
        } else if (t>=24&&t<48) {
            self.yesterdayLabel.text = [NSString stringWithFormat:@"￥%.2f",[model.sum floatValue]];
            self.yesterCountLabel.text = [NSString stringWithFormat:@"%d单",[model.count intValue]];
        }
        turnover = turnover+[model.sum floatValue];
        count = count+[model.count intValue];
        
    }

    
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    for (SaleManageModel *model in self.data1) {
        SaleManageModel *myModel = [[SaleManageModel alloc] init];
        myModel.t = [NSString stringWithFormat:@"%@-%@",[model.t substringWithRange:NSMakeRange(4, 2)],[model.t substringWithRange:NSMakeRange(6, 2)]];
        myModel.sum = model.sum;
        [muArr addObject:myModel];
    }
    
//    //muArr1 = %@", muArr);
    self.tfDV1.backgroundColor = [UIColor whiteColor];
    self.tfDV1.dataArr = muArr;
    self.tfDV1.color = [UIColor greenColor];
    [self.tfDV1 setNeedsDisplay];
}

- (void)refreshView2
{
    //%s",__func__);
    
    float turnoverBack = 0;
    int countBack = 0;
    for (SaleManageModel *model in self.data2) {
        
        int curHour = [self calculationSecFor1970:self.curDate];
        int tHour = [self calculationSecFor1970:model.t];
        int t = curHour-tHour;
        if (t<24) {
            self.todayBackLabel.text = [NSString stringWithFormat:@"￥%.2f",[model.sum floatValue]];
        }
        turnoverBack = turnoverBack+[model.sum floatValue];
        countBack = countBack+[model.count intValue];
    }
    self.turnoverBackLabel.text = [NSString stringWithFormat:@"￥%.2f",turnoverBack];
    self.countBackLabel.text = [NSString stringWithFormat:@"%d单",countBack];
    
    
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    for (SaleManageModel *model in self.data2) {
        SaleManageModel *myModel = [[SaleManageModel alloc] init];
        myModel.t = [NSString stringWithFormat:@"%@-%@",[model.t substringWithRange:NSMakeRange(4, 2)],[model.t substringWithRange:NSMakeRange(6, 2)]];
        myModel.sum = model.sum;
        [muArr addObject:myModel];
    }
    
//    //muArr2 = %@", muArr);
    self.tfDV2.backgroundColor = [UIColor whiteColor];
    self.tfDV2.dataArr = muArr;
    self.tfDV2.color = [UIColor redColor];
    [self.tfDV2 setNeedsDisplay];
}

- (void)refreshView3
{
    int count = 0;
    for (SaleManageModel *model in self.data3) {
        
        count = count+[model.count intValue];
        
        int oldMonth = [[model.t substringToIndex:3] intValue];
        int curMonth = [[self.curDate substringWithRange:NSMakeRange(4, 2)] intValue];
        NSString *t;
        if (oldMonth>curMonth) {
            t = [NSString stringWithFormat:@"%4d%@%@",[[self.curDate substringWithRange:NSMakeRange(0, 4)] intValue]-1,[model.t substringToIndex:2],[model.t substringFromIndex:3]];
        } else {
            t = [NSString stringWithFormat:@"%@%@%@",[self.curDate substringWithRange:NSMakeRange(0, 4)],[model.t substringToIndex:2],[model.t substringFromIndex:3]];
        }
        int curHour = [self calculationSecFor1970:self.curDate];
        int tHour = [self calculationSecFor1970:t];
        int hour = curHour-tHour;
//        MyLog(@"hour = %d",hour);
        if (hour>=24&&hour<48) {
            self.yesterdayVisityLabel.text = [NSString stringWithFormat:@"%d人",[model.sum intValue]];
        }
    }
    self.countVisityLabel.text = [NSString stringWithFormat:@"%d人",count];
    
//    //muArr3 = %@", self.data3);
    self.tfDV3.backgroundColor = [UIColor whiteColor];
    self.tfDV3.dataArr = self.data3;
    self.tfDV3.color = [UIColor blueColor];
    [self.tfDV3 setNeedsDisplay];
}


- (float)calculationSecFor1970:(NSString *)theDate
{
    NSString *fromDate = [NSString stringWithFormat:@"%@ 23:59:59",theDate];
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyyMMdd HH:mm:ss"];
    NSDate *d=[date dateFromString:fromDate];
    NSTimeInterval late=[d timeIntervalSince1970]/3600;
    return late;
}

#pragma mark - 创建UI
- (void)createBgView1
{
    self.bgView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-self.headView.frame.origin.y-self.headView.frame.size.height)];
    self.bgView1.backgroundColor = [UIColor whiteColor];
    [self.bgScrollView addSubview:self.bgView1];
    

    self.tfDV1 = [[TFDrawView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, (int)ZOOM(620))];
    self.tfDV1.backgroundColor = [UIColor whiteColor];
    [self.bgView1 addSubview:self.tfDV1];
    
    //++++++
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.tfDV1.frame.origin.y+self.tfDV1.frame.size.height, kScreenWidth, ZOOM(110))];
    [self.bgView1 addSubview:view1];
    

//    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake((20), 0, (80), view1.frame.size.height-1)];
//    label1.text = @"今日";
//    label1.font = [UIFont systemFontOfSize:(18)];
//    [view1 addSubview:label1];
//    self.todayLabel = [[UILabel alloc] initWithFrame:CGRectMake(view1.frame.size.width/2-(20)-(80), 0, (80), view1.frame.size.height-1)];
//    self.todayLabel.text = @"0.00";
//    self.todayLabel.adjustsFontSizeToFitWidth = YES;
//    self.todayLabel.font = [UIFont systemFontOfSize:(18)];
//    self.todayLabel.textAlignment = NSTextAlignmentRight;
//    [view1 addSubview:self.todayLabel];
    
    /*
     CGRectMake(view1.frame.size.width/2+(20), label1.frame.origin.y, (80), view1.frame.size.height-1)
     
     CGRectMake(view1.frame.size.width-(20)-(80), 0, (80), view1.frame.size.height-1)
     */
    
    CGFloat Margin_lr = ZOOM(62);
    

    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(Margin_lr, 0, (80), view1.frame.size.height-1)];
    label2.text = @"昨日";
    label2.font = [UIFont systemFontOfSize:ZOOM(46)];
    [view1 addSubview:label2];
    self.yesterdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(view1.frame.size.width/2-Margin_lr-(80), 0, (80), view1.frame.size.height-1)];
    self.yesterdayLabel.text = @"￥0.00";
    self.yesterdayLabel.adjustsFontSizeToFitWidth = YES;
    self.yesterdayLabel.font = [UIFont systemFontOfSize:ZOOM(46)];
    self.yesterdayLabel.textAlignment = NSTextAlignmentLeft;
    [view1 addSubview:self.yesterdayLabel];
    
    self.yesterCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(view1.frame.size.width-Margin_lr-(80), 0, (80), view1.frame.size.height-1)];
    self.yesterCountLabel.text = @"0单";
    self.yesterCountLabel.adjustsFontSizeToFitWidth = YES;
    self.yesterCountLabel.font = [UIFont systemFontOfSize:ZOOM(46)];
    self.yesterCountLabel.textAlignment = NSTextAlignmentRight;
    [view1 addSubview:self.yesterCountLabel];
    
//    UIView *centerLineView = [[UIView alloc] initWithFrame:CGRectMake(view1.frame.size.width/2-0.5, 0, 1, view1.frame.size.height)];
//    centerLineView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.4];
//    [view1 addSubview:centerLineView];
    
    UIView *bottomlineView = [[UIView alloc] initWithFrame:CGRectMake(0, view1.frame.size.height-1, view1.frame.size.width, 1)];
    bottomlineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [view1 addSubview:bottomlineView];
    
    //++++++
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, view1.frame.origin.y+view1.frame.size.height, kScreenWidth, ZOOM(150))];
    [self.bgView1 addSubview:view2];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(Margin_lr, 0, (80), view2.frame.size.height-1)];
    label3.text = @"成交金额";
    label3.font = [UIFont systemFontOfSize:ZOOM(46)];
    [view2 addSubview:label3];
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width-Margin_lr-(80), 0, (80), view2.frame.size.height-1)];
    label4.text = @"成交单数";
    label4.textAlignment = NSTextAlignmentRight;
    label4.font = [UIFont systemFontOfSize:ZOOM(46)];
    [view2 addSubview:label4];
    
    UIView *bottomlineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, view2.frame.size.height-1, view2.frame.size.width, 1)];
    bottomlineView2.backgroundColor = RGBCOLOR_I(220,220,220);
    [view2 addSubview:bottomlineView2];
    
    //+++++++
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, view2.frame.origin.y+view2.frame.size.height, kScreenWidth, ZOOM(204))];
    [self.bgView1 addSubview:view3];
    self.dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(Margin_lr, 0, (100), view3.frame.size.height/2)];
    self.dayLabel.text = @"2015-01-01";
    self.dayLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.6];
    self.dayLabel.font = [UIFont systemFontOfSize:(14)];
    [view3 addSubview:self.dayLabel];
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(label4.frame.origin.x, 0, (80), view3.frame.size.height/2)];
    label5.text = @"合计";
    label5.textAlignment = NSTextAlignmentRight;
    label5.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.6];
    label5.font = [UIFont systemFontOfSize:(14)];
    [view3 addSubview:label5];
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(self.dayLabel.frame.origin.x, self.dayLabel.frame.size.height, (60), self.dayLabel.frame.size.height-1)];
    label6.text = @"营业额";
    label6.textColor = [UIColor blackColor];
    label6.font = [UIFont systemFontOfSize:ZOOM(42)];
    [view3 addSubview:label6];
    

    self.todayLabel = [[UILabel alloc] initWithFrame:CGRectMake(label6.frame.origin.x+label6.frame.size.width+(5), label6.frame.origin.y, (150), label6.frame.size.height)];
    self.todayLabel.textColor = COLOR_ROSERED;
    self.todayLabel.text = @"￥0.00";
    self.todayLabel.adjustsFontSizeToFitWidth = YES;
    self.todayLabel.font = [UIFont systemFontOfSize:ZOOM(42)];
    [view3 addSubview:self.todayLabel];
    

    self.dayCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(view3.frame.size.width-Margin_lr-(100),label6.frame.origin.y,(100),label5.frame.size.height-1)];
    self.dayCountLabel.text = @"0单";
    self.dayCountLabel.adjustsFontSizeToFitWidth = YES;
    self.dayCountLabel.textAlignment = NSTextAlignmentRight;
    self.dayCountLabel.textColor = [UIColor blackColor];
    self.dayCountLabel.font = [UIFont systemFontOfSize:ZOOM(42)];
    [view3 addSubview:self.dayCountLabel];
    UIView *bottomlineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, view3.frame.size.height-1, view3.frame.size.width, 1)];
    bottomlineView3.backgroundColor = RGBCOLOR_I(220,220,220);
    [view3 addSubview:bottomlineView3];
    
    self.dayLabel.text = self.curLineDate;
}
- (void)createBgView2
{
    self.bgView2 = [[UIView alloc] initWithFrame:CGRectMake(1*kScreenWidth, 0, kScreenWidth, kScreenHeight-self.headView.frame.origin.y-self.headView.frame.size.height)];
    self.bgView2.backgroundColor = [UIColor whiteColor];
    [self.bgScrollView addSubview:self.bgView2];

    self.tfDV2 = [[TFDrawView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, (int)ZOOM(620))];
    self.tfDV2.backgroundColor = [UIColor whiteColor];
    [self.bgView2 addSubview:self.tfDV2];
    
    CGFloat Margin_lr = ZOOM(62);
    
    //++++++
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.tfDV2.frame.origin.y+self.tfDV2.frame.size.height, kScreenWidth, ZOOM(110))];
    [self.bgView2 addSubview:view1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(Margin_lr, 0, (80), view1.frame.size.height-1)];
    label.text = @"今日";
    label.font = [UIFont systemFontOfSize:ZOOM(46)];
    [view1 addSubview:label];
    self.todayBackLabel = [[UILabel alloc] initWithFrame:CGRectMake(view1.frame.size.width-Margin_lr-(80), 0, (80), view1.frame.size.height-1)];
    self.todayBackLabel.text = @"￥0.00";
    self.todayBackLabel.adjustsFontSizeToFitWidth = YES;
    self.todayBackLabel.textAlignment = NSTextAlignmentRight;
    self.todayBackLabel.font = [UIFont systemFontOfSize:ZOOM(46)];
    [view1 addSubview:self.todayBackLabel];
    UIView *bottomlineView = [[UIView alloc] initWithFrame:CGRectMake(0, view1.frame.size.height-1, view1.frame.size.width, 1)];
    bottomlineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [view1 addSubview:bottomlineView];
    //++++++
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, view1.frame.origin.y+view1.frame.size.height, kScreenWidth, ZOOM(150))];
    [self.bgView2 addSubview:view2];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(Margin_lr, 0, (80), view2.frame.size.height-1)];
    label3.text = @"回佣金额";
    label3.font = [UIFont systemFontOfSize:ZOOM(46)];
    [view2 addSubview:label3];
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width-Margin_lr-(80), 0, (80), view2.frame.size.height-1)];
    label4.text = @"回佣单数";
    label4.textAlignment = NSTextAlignmentRight;
    label4.font = [UIFont systemFontOfSize:ZOOM(46)];
    [view2 addSubview:label4];
    UIView *bottomlineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, view2.frame.size.height-1, view2.frame.size.width, 1)];
    bottomlineView2.backgroundColor = RGBCOLOR_I(220,220,220);
    [view2 addSubview:bottomlineView2];
    
    //+++++++
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, view2.frame.origin.y+view2.frame.size.height, kScreenWidth, ZOOM(204))];
    [self.bgView2 addSubview:view3];
    self.dayBackLabel = [[UILabel alloc] initWithFrame:CGRectMake(Margin_lr, 0, (100), view3.frame.size.height/2)];
    self.dayBackLabel.text = @"2015-01-01";
    self.dayBackLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.6];
    self.dayBackLabel.font = [UIFont systemFontOfSize:(14)];
    [view3 addSubview:self.dayBackLabel];
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(view3.frame.size.width-Margin_lr-(80), 0, (80), view3.frame.size.height/2)];
    label5.text = @"合计";
    label5.textAlignment = NSTextAlignmentRight;
    label5.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.6];
    label5.font = [UIFont systemFontOfSize:(14)];
    [view3 addSubview:label5];
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(self.dayBackLabel.frame.origin.x, self.dayBackLabel.frame.size.height, (60), self.dayBackLabel.frame.size.height-1)];
    label6.text = @"回佣";
    label6.textColor = [UIColor blackColor];
    label6.font = [UIFont systemFontOfSize:ZOOM(42)];
    [view3 addSubview:label6];
    self.turnoverBackLabel = [[UILabel alloc] initWithFrame:CGRectMake(label6.frame.origin.x+label6.frame.size.width+(5), label6.frame.origin.y, (150), label6.frame.size.height)];
    self.turnoverBackLabel.textColor = COLOR_ROSERED;
    self.turnoverBackLabel.text = @"￥0.00";
    self.turnoverBackLabel.adjustsFontSizeToFitWidth = YES;
    self.turnoverBackLabel.font = [UIFont systemFontOfSize:ZOOM(42)];
    [view3 addSubview:self.turnoverBackLabel];
    self.countBackLabel = [[UILabel alloc] initWithFrame:CGRectMake(view3.frame.size.width-Margin_lr-(100), label5.frame.size.height,(100), label5.frame.size.height-1)];
    self.countBackLabel.text = @"0单";
    self.countBackLabel.adjustsFontSizeToFitWidth = YES;
    self.countBackLabel.textAlignment = NSTextAlignmentRight;
    self.countBackLabel.textColor = [UIColor blackColor];
    self.countBackLabel.font = [UIFont systemFontOfSize:ZOOM(42)];
    [view3 addSubview:self.countBackLabel];
    UIView *bottomlineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, view3.frame.size.height-1, view3.frame.size.width, 1)];
    bottomlineView3.backgroundColor = RGBCOLOR_I(220,220,220);
    [view3 addSubview:bottomlineView3];


    self.dayBackLabel.text = self.curLineDate;
    
}

- (void)createBgView3
{
    self.bgView3 = [[UIView alloc] initWithFrame:CGRectMake(2*kScreenWidth, 0, kScreenWidth, kScreenHeight-self.headView.frame.origin.y-self.headView.frame.size.height)];
    [self.bgScrollView addSubview:self.bgView3];
    

    self.tfDV3 = [[TFDrawView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, (int)ZOOM(620))];
    self.tfDV3.backgroundColor = [UIColor whiteColor];
    [self.bgView3 addSubview:self.tfDV3];
    
    CGFloat Margin_lr = ZOOM(62);

    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.tfDV3.frame.origin.y+self.tfDV3.frame.size.height, kScreenWidth, ZOOM(110))];
    [self.bgView3 addSubview:view1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(Margin_lr, 0, (80), view1.frame.size.height-1)];
    label.text = @"昨日";
    label.font = [UIFont systemFontOfSize:ZOOM(46)];
    [view1 addSubview:label];
    self.yesterdayVisityLabel = [[UILabel alloc] initWithFrame:CGRectMake(view1.frame.size.width-Margin_lr-(80), 0, (80), view1.frame.size.height-1)];
    self.yesterdayVisityLabel.text = @"0人";
    self.yesterdayVisityLabel.adjustsFontSizeToFitWidth = YES;
    self.yesterdayVisityLabel.textAlignment = NSTextAlignmentRight;
    self.yesterdayVisityLabel.font = [UIFont systemFontOfSize:ZOOM(46)];
    [view1 addSubview:self.yesterdayVisityLabel];
    UIView *bottomlineView = [[UIView alloc] initWithFrame:CGRectMake(0, view1.frame.size.height-1, view1.frame.size.width, 1)];
    bottomlineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [view1 addSubview:bottomlineView];
    

    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, view1.frame.origin.y+view1.frame.size.height, kScreenWidth, ZOOM(150))];
    [self.bgView3 addSubview:view2];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(Margin_lr, 0, (80), view2.frame.size.height-1)];
    label3.text = @"统计日期";
    label3.font = [UIFont systemFontOfSize:ZOOM(46)];
    [view2 addSubview:label3];
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(view2.frame.size.width-Margin_lr-(80), 0, (80), view2.frame.size.height-1)];
    label4.text = @"访客总量";
    label4.textAlignment = NSTextAlignmentRight;
    label4.font = [UIFont systemFontOfSize:ZOOM(46)];
    [view2 addSubview:label4];
    UIView *bottomlineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, view2.frame.size.height-1, view2.frame.size.width, 1)];
    bottomlineView2.backgroundColor = RGBCOLOR_I(220,220,220);
    [view2 addSubview:bottomlineView2];
    
    //+++++++
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, view2.frame.origin.y+view2.frame.size.height, kScreenWidth, (60))];
    [self.bgView3 addSubview:view3];
    self.dayVisityLabel = [[UILabel alloc] initWithFrame:CGRectMake(Margin_lr, 0, (100), view3.frame.size.height/2)];
    self.dayVisityLabel.text = @"2015-01-01";
    self.dayVisityLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.6];
    self.dayVisityLabel.font = [UIFont systemFontOfSize:(14)];
    [view3 addSubview:self.dayVisityLabel];
    self.countVisityLabel = [[UILabel alloc] initWithFrame:CGRectMake(view3.frame.size.width-Margin_lr-(80), 0, (80), view3.frame.size.height/2)];
    self.countVisityLabel.text = @"0人";
    self.countVisityLabel.adjustsFontSizeToFitWidth = YES;
    self.countVisityLabel.textAlignment = NSTextAlignmentRight;
    self.countVisityLabel.font = [UIFont systemFontOfSize:(14)];
    [view3 addSubview:self.countVisityLabel];
    
    UIView *bottomlineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, view3.frame.size.height-1, view3.frame.size.width, 1)];
    bottomlineView3.backgroundColor = RGBCOLOR_I(220,220,220);
    [view3 addSubview:bottomlineView3];
    

    self.dayVisityLabel.text = self.curLineDate;
    
}


- (NSMutableArray *)data1
{
    if (_data1 == nil) {
        _data1 = [[NSMutableArray alloc] init];
    }
    return _data1;
}
- (NSMutableArray *)data2
{
    if (_data2 == nil) {
        _data2 = [[NSMutableArray alloc] init];
    }
    return _data2;
}
- (NSMutableArray *)data3
{
    if (_data3 == nil) {
        _data3 = [[NSMutableArray alloc] init];
    }
    return _data3;
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
