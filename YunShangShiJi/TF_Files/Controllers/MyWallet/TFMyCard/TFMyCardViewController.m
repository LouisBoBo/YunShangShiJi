//
//  TFMyCardViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/18.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFMyCardViewController.h"
//#import "ChatListViewController.h"
#import "MyCardCell.h"
#import "HBbankcardCell.h"
#import "MyCouponsCell.h"
#import "VoucherModel.h"
#import "MyGoldCouponsCell.h"
#import "NSDate+Helper.h"
#import "GoldCouponsManager.h"

@interface TFMyCardViewController () <UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UIScrollView *bgScrollView;
@property (nonatomic, assign)int index;

@property (nonatomic, strong)UITableView *tableView1;
@property (nonatomic, strong)UITableView *tableView2;
@property (nonatomic, strong)UIButton *discriptionBtn;

@property (nonatomic, strong)NSMutableArray *dataArr1;
@property (nonatomic, strong)NSMutableArray *dataArr2;
@property (nonatomic, strong) NSMutableArray *voucherArr; //抵用券数据源
@property (nonatomic, strong) NSMutableArray *GoldArr; //金券数据源failure
@property (nonatomic, strong) NSMutableArray *failureGoldArr; //失效金券数据源

@property (nonatomic, strong)NSArray *discriptionData;

@property (nonatomic, assign)int page1;
@property (nonatomic, assign)int page2;
@end

@implementation TFMyCardViewController
{
    //弹框
    UIView *_Popview;
    UIView *_InvitationCodeView;
    UIButton *_canclebtn; //弹框关闭按钮
    UIView *_backview;
    UITableView *_MytableView;
}
- (void)dealloc {
    NSLog(@"%@释放了",[self class]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [super setNavigationItemLeftAndRight:@"我的卡券"];
    
//    _discriptionData = @[@"什么是优惠券和抵用券？_优惠券和抵用券都是衣蝠发行和认可的购物券，可以在衣蝠消费付款时用来抵扣相应商品的价格（特价商品除外）。优惠券和抵用券可以叠加使用。",@"如何获取优惠券和抵用券？_优惠券可以通过参与相关活动获取，抵用券系统会每天发放给用户。",@"如何使用优惠券和抵用券？_用户选好商品，进入付款页面，系统会自动使用满足条件的抵用券和优惠券，为用户计算好最大额度的优惠。"];
    
    
    [self creatNavagationView];
    
    [self createUI];
}
- (void)creatNavagationView
{
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
    titlelable.text=@"我的卡券";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    _discriptionBtn=[[UIButton alloc]init];
    _discriptionBtn.frame=CGRectMake(kApplicationWidth-110, 23, 100, 40);
    _discriptionBtn.centerY = View_CenterY(headview);
    [_discriptionBtn setTitle:@"使用说明" forState:UIControlStateNormal];
    _discriptionBtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM6(28)];
    [_discriptionBtn setTitleColor:kTextColor forState:UIControlStateNormal];
    _discriptionBtn.tag=1111;
    [_discriptionBtn addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:_discriptionBtn];


}
- (void)createUI
{
    self.page1 = 1;
    self.page2 = 1;
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7, kScreenWidth, (40))];
    //    headView.backgroundColor = [UIColor yellowColor];
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
    lBtn.selected = YES;
    [lBtn setTitle:@"未使用" forState:UIControlStateNormal];
    lBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(50)];
    [lBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    lBtn.tag = 100;
    [headView addSubview:lBtn];
    
    UIButton *rBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rBtn.frame = CGRectMake(headView.frame.size.width/2, 0, headView.frame.size.width/2-1, headView.frame.size.height);
    [rBtn setTitleColor:RGBCOLOR_I(22,22,22) forState:UIControlStateNormal];
    [rBtn setTitleColor:COLOR_ROSERED forState:UIControlStateSelected];
    rBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(50)];
    [rBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    rBtn.tag = 101;
    [rBtn setTitle:@"已失效" forState:UIControlStateNormal];
    [headView addSubview:rBtn];
    
    self.bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,  headView.bottom, kScreenWidth, kScreenHeight- headView.bottom)];
    self.bgScrollView.contentSize = CGSizeMake(kScreenWidth*2, self.bgScrollView.frame.size.height);
    self.bgScrollView.bounces = NO;
    self.bgScrollView.pagingEnabled = YES;
    self.bgScrollView.delegate = self;
    self.bgScrollView.showsHorizontalScrollIndicator = NO;
    self.bgScrollView.userInteractionEnabled = YES;
    [self.view addSubview:self.bgScrollView];
    
    //创建tableView
    self.tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.bgScrollView.frame.size.width, self.bgScrollView.frame.size.height)];
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    self.tableView1.tag = 200;
    self.tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView1.tableFooterView = [[UIView alloc] init];
    self.tableView1.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, kZoom6pt(10))];
    self.tableView1.backgroundColor = kBackgroundColor;
    [self.bgScrollView addSubview:self.tableView1];
    
    //    [self.tableView1 registerNib:[UINib nibWithNibName:@"HBcardCell" bundle:nil] forCellReuseIdentifier:@"CardCell1"];
    
    self.tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, self.bgScrollView.frame.size.width, self.bgScrollView.frame.size.height)];
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    self.tableView2.tag = 201;
    self.tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView2.tableFooterView = [[UIView alloc] init];
    self.tableView2.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, kZoom6pt(10))];
    self.tableView2.backgroundColor = kBackgroundColor;
    [self.bgScrollView addSubview:self.tableView2];
    
    //    [self.tableView2 registerNib:[UINib nibWithNibName:@"HBcardCell" bundle:nil] forCellReuseIdentifier:@"CardCell2"];
    
    //上下拉刷新
    __weak TFMyCardViewController *myController = self;
    [self.tableView1 addHeaderWithCallback:^{
        myController.page1 = 1;
        [myController httpGetAll];
    }];
    
    [self.tableView1 addFooterWithCallback:^{
        myController.page1++;
        [myController httpGetAll];
    }];
    
    //上下拉刷新
    [self.tableView2 addHeaderWithCallback:^{
        myController.page2 = 1;
        [myController httpGetInvalid];
    }];
    
    [self.tableView2 addFooterWithCallback:^{
        myController.page2++;
        [myController httpGetInvalid];
    }];
    
    [self httpGetAll];
    
    [self httpGetDiscription];
}

#pragma mark - 获取数据
- (void)httpGetAll //获取全部
{
    [NSDate systemCurrentTime:^(long long time) {
        [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithLongLong:time] forKey:@"systemCurrentTime"];
    }];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@coupon/queryByPage?page=%d&rows=%@&Order=desc&is_use=1&maxormin=>&token=%@&version=%@&sort=%@",[NSObject baseURLStr],self.page1,@"10",token,VERSION,@"is_use ASC,C_LAST_TIME ASC,c_price"];
    NSString *URL = [MyMD5 authkey:urlStr];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"\n<<-----------返回-------------------\n Url == %@\n responseObject == %@\n------------------------------->>",URL,responseObject);
        
        [self clearBackgroundView:self.bgScrollView withTag:99999];
        [self.tableView1 headerEndRefreshing];
        [self.tableView1 footerEndRefreshing];
        if (responseObject!=nil) {
            //把数据存到模型中
            [self.voucherArr removeAllObjects];
            if (self.page1 == 1) {
                [self.dataArr1 removeAllObjects];
                [self.GoldArr removeAllObjects];
            }
            //成功
            if ([responseObject[@"status"] intValue] == 1) {
                /*
                //金券
                NSArray *goldData = responseObject[@""];
                if (goldData.count) {
                    for (NSDictionary *dic in goldData) {
                        MyCardModel *cModel = [[MyCardModel alloc] init];
                        [cModel setValuesForKeysWithDictionary:dic];
                        cModel.ID = dic[@"id"];
                        
                        [self.GoldArr addObject:cModel];
                    }
                }
                */
                //优惠券
                NSArray *data = responseObject[@"data"];
                MyLog(@"%d  %d",[GoldCouponsManager goldcpManager].is_open,data.count);

                if (data.count) {
                    for (NSDictionary *dic in data) {
                        MyCardModel *cModel = [[MyCardModel alloc] init];
                        [cModel setValuesForKeysWithDictionary:dic];
                        cModel.ID = dic[@"id"];
                        
                        if ([cModel.ID integerValue]==[GoldCouponsManager goldcpManager].c_id&&self.GoldArr.count==0&&[GoldCouponsManager goldcpManager].is_open) {
                            cModel.c_cond = [NSNumber numberWithFloat:[GoldCouponsManager goldcpManager].c_price+0.01];
                            [self.GoldArr addObject:cModel];
                        }else if (data.count==1&&[GoldCouponsManager goldcpManager].is_open){
                            [GoldCouponsManager goldcpManager].c_price = cModel.c_price.floatValue+0.01;
                            [GoldCouponsManager goldcpManager].is_use = 0;
                            [GoldCouponsManager goldcpManager].c_id = cModel.ID.integerValue;
                            cModel.c_cond = [NSNumber numberWithFloat:[GoldCouponsManager goldcpManager].c_price+0.01];
                            [self.GoldArr addObject:cModel];
                        }else
                            [self.dataArr1 addObject:cModel];
                    }
                    if (self.GoldArr.count==0&&![GoldCouponsManager goldcpManager].is_use&&[GoldCouponsManager goldcpManager].c_price&&[GoldCouponsManager goldcpManager].is_open) {
                        [self addGlodCouponModel];
                    }
                }
                //抵用券
                NSArray *voucher = responseObject[@"voucher"];
                if (voucher.count) {
                    for (NSDictionary *dic in voucher) {
                        VoucherModel *uModel = [[VoucherModel alloc] init];
                        [uModel setValuesForKeysWithDictionary:dic];
                        [self.voucherArr addObject:uModel];
                    }
                }
                //是否有数据
                if (self.dataArr1.count == 0 && self.voucherArr.count == 0 &&self.GoldArr.count == 0) {
                    CGRect frame = CGRectMake(0, 0, self.bgScrollView.frame.size.width, self.bgScrollView.frame.size.height);
                    [self createBackgroundView:self.bgScrollView andTag:10000 andFrame:frame withImgge:nil andText:nil];
                } else {
                    [self clearBackgroundView:self.bgScrollView withTag:10000];
                    [self.tableView1 reloadData];
                }
                
            } else {
                //失败
                [MBProgressHUD showError:responseObject[@"message"]];
            }
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //网络错误
        [self.tableView1 headerEndRefreshing];
        [self.tableView1 footerEndRefreshing];
        CGRect frame = CGRectMake(0, 0, self.bgScrollView.frame.size.width, self.bgScrollView.frame.size.height);
        [self createBackgroundView:self.bgScrollView andTag:99999 andFrame:frame withImgge:[UIImage imageNamed:@"哭脸"] andText:@"亲,没网了"];
    }];
}
- (void)addGlodCouponModel {
    MyCardModel *cModel = [[MyCardModel alloc] init];
    cModel.c_price = [NSNumber numberWithFloat:[GoldCouponsManager goldcpManager].c_price];
    cModel.ID = [NSNumber numberWithInteger:[GoldCouponsManager goldcpManager].c_id];
    cModel.c_cond = [NSNumber numberWithFloat:[GoldCouponsManager goldcpManager].c_price+0.01];
    cModel.c_last_time = [NSNumber numberWithLongLong:[GoldCouponsManager goldcpManager].c_last_time];
    [self.GoldArr insertObject:cModel atIndex:0];
}


- (void)httpGetInvalid //获取失效
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@coupon/queryByPage?page=%d&rows=%@&order=desc&token=%@&version=%@&maxormin=<&is_use=2&sort=%@",[NSObject baseURLStr],self.page2,@"10",token,VERSION,@"is_use ASC,C_LAST_TIME ASC,c_price "];
    NSString *URL = [MyMD5 authkey:urlStr];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        [self clearBackgroundView:self.bgScrollView withTag:99999];
        
        //
        [self.tableView2 headerEndRefreshing];
        [self.tableView2 footerEndRefreshing];
        
        if (responseObject!=nil) {
            //把数据存到模型中
            if (self.page2 == 1) {
                [self.dataArr2 removeAllObjects];
                [self.failureGoldArr removeAllObjects];
                [self.tableView2 reloadData];
            }
            if ([responseObject[@"status"] intValue] == 1) {
                //成功
                NSArray *data = responseObject[@"data"];
                NSArray *data2 = responseObject[@""];
                
                if (self.dataArr2.count ==0&&data.count == 0 && self.failureGoldArr.count==0&&data2.count==0) {
                    
                    CGRect frame = CGRectMake(self.bgScrollView.frame.size.width, 0, self.bgScrollView.frame.size.width, self.bgScrollView.frame.size.height);
                    [self createBackgroundView:self.bgScrollView andTag:10001 andFrame:frame withImgge:nil andText:nil];
                } else {
                    [self clearBackgroundView:self.bgScrollView withTag:10001];
                    /*
                    for (NSDictionary *dic in data2) {
                        MyCardModel *cModel = [[MyCardModel alloc] init];
                        [cModel setValuesForKeysWithDictionary:dic];
                        cModel.ID = dic[@"id"];
                        
                        [self.failureGoldArr addObject:cModel];
                    }
                    */
                    
                    for (NSDictionary *dic in data) {
                        MyCardModel *cModel = [[MyCardModel alloc] init];
                        [cModel setValuesForKeysWithDictionary:dic];
                        cModel.ID = dic[@"id"];
                        if (cModel.is_gold.integerValue==1) {
                            cModel.c_cond = [NSNumber numberWithFloat:[GoldCouponsManager goldcpManager].c_price+0.01];
                            [self.failureGoldArr addObject:cModel];
                        }else
                            [self.dataArr2 addObject:cModel];
                    }
                    [self.tableView2 reloadData];
                }
            } else {
                [self.tableView2 headerEndRefreshing];
                [self.tableView2 footerEndRefreshing];
                [MBProgressHUD showError:responseObject[@"message"]];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tableView2 headerEndRefreshing];
        [self.tableView2 footerEndRefreshing];
        
        CGRect frame = CGRectMake(kScreenWidth, 0, self.bgScrollView.frame.size.width, self.bgScrollView.frame.size.height);
        [self createBackgroundView:self.bgScrollView andTag:99999 andFrame:frame withImgge:[UIImage imageNamed:@"哭脸"] andText:@"亲,没网了"];
        
    }];
    
}

- (void)httpGetDiscription
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@help/couponRule?token=%@&version=%@",[NSObject baseURLStr],token,VERSION];
    
    NSString *URL = [MyMD5 authkey:urlStr];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                //成功
                if(responseObject[@"data"] !=nil )
                {
                    NSMutableString *dataStr = responseObject[@"data"];
                    NSArray *strArr = [dataStr componentsSeparatedByString:@"::"];
                    
                    self.discriptionData = strArr;
                }
                
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      
        
    }];

}
#pragma mark - 按钮
- (void)btnClick:(UIButton *)sender
{
    for (int i = 0; i<2; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:100+i];
        btn.selected = NO;
    }
    sender.selected = !sender.selected;
    self.index = (int)sender.tag - 100;
    if (sender.tag == 100) {
        self.bgScrollView.contentOffset = CGPointMake(0, 0);
    } else if (sender.tag == 101) {
        self.bgScrollView.contentOffset = CGPointMake(kScreenWidth, 0);
    }
    
    if (self.index == 0) {
        self.page1 = 1;
        [self httpGetAll];
    } else if (self.index == 1) {
        self.page2 = 1;
        [self httpGetInvalid];
//        self.dataArr2 = self.GoldArr;
//        self.failureGoldArr = self.GoldArr;
        [self.tableView2 reloadData];
    }
    
    
}

#pragma mark - scrollView
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.bgScrollView) {
        int oldIndex = self.index;
        self.index = scrollView.contentOffset.x/kScreenWidth;
        
        if (oldIndex!=self.index) {
            for (int i = 0; i<2; i++) {
                UIButton *btn = (UIButton *)[self.view viewWithTag:100+i];
                btn.selected = NO;
                if (self.index == i) {
                    btn.selected = YES;
                }
            }
            
            if (self.index == 0) {
                self.page1 = 1;
                [self httpGetAll];
            } else if (self.index == 1) {
                self.page2 = 1;
                [self httpGetInvalid];
            }
        }
    }
}

#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 200) {
        return [self.dataArr1 count] + [self.voucherArr count] + [self.GoldArr count];
    } else if (tableView.tag == 201) {
        return [self.dataArr2 count] + [self.failureGoldArr count];
    } else if (tableView == _MytableView)
    {
        return self.discriptionData.count;
    }
    else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _MytableView)
    {
        CGFloat Heigh = [self getRowHeight:_discriptionData[indexPath.row] fontSize:ZOOM6(34)];
        
        return Heigh+20;
    }
    
    return kZoom6pt(110);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    MyCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MYCARDCELLID"];
    //    if (tableView.tag == 200) { //全部
    //        if (cell == nil) {
    //            cell = [[[NSBundle mainBundle] loadNibNamed:@"MyCardCell" owner:self options:nil] lastObject];
    //            cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //        }
    //        [cell receiveDataModel:self.dataArr1[indexPath.row]];
    //        return cell;
    //
    //    } else if (tableView.tag == 201) { //失效
    //        if (cell == nil) {
    //            cell = [[[NSBundle mainBundle] loadNibNamed:@"MyCardCell" owner:self options:nil] lastObject];
    //            cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //        }
    //        [cell receiveDataModel:self.dataArr2[indexPath.row]];
    //        return cell;
    //    }
    
    
    //        HBbankcardCell *cell = (HBbankcardCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    /*
    // begin 赵官林 add 2016.05.19
    MyCardModel *model = nil;
    MyCouponsCellType type = MyCouponsCellTypeVoucher;
    
    if (tableView.tag == 200)
    {   //全部
        if (indexPath.row < self.voucherArr.count)
        {   // 抵用券
            model = self.voucherArr[indexPath.row];
            type = MyCouponsCellTypeVoucher;
        } else
        {   // 优惠券
            model = self.dataArr1[indexPath.row - self.voucherArr.count];
            type = MyCouponsCellTypeCoupon;
        }
    } else if (tableView.tag == 201)
    {   //失效
        model = self.dataArr2[indexPath.row];
        type = MyCouponsCellTypeCouponFail;
    }else if (tableView == _MytableView)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if(!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSMutableString *str = _discriptionData[indexPath.row];
        NSArray *arr = [str componentsSeparatedByString:@"_"];
        
        UIFont *titlefont = [UIFont systemFontOfSize:ZOOM6(32)];
        NSString *titlestr = [NSString stringWithFormat:@"%@",arr[0]];
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@\n%@",arr[0],arr[1]];
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.textColor=kTextColor;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
        
        //lable的行间距
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:cell.detailTextLabel.text];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:4];
        
        
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [cell.detailTextLabel.text length])];
        [attributedString1 addAttribute:NSForegroundColorAttributeName value: tarbarrossred range:NSMakeRange(0, titlestr.length)];
        
        [attributedString1 addAttribute:NSFontAttributeName value:titlefont range:NSMakeRange(0, titlestr.length)];
        
        [cell.detailTextLabel setAttributedText:attributedString1];
        [cell.detailTextLabel sizeToFit];
        
        return cell;

    }
    
    MyCouponsCell *cell = [MyCouponsCell cellWithType:type tableView:tableView];
    [cell receiveDataModel:model];
    return cell;
    //end
    */
    
    
    //begin 刘兵 add 2016.10.9
    MyCardModel *model = nil;
    MyGoldCouponsCellType type = MyGoldCouponsCellTypeVoucher;
    
    if (tableView.tag == 200)
    {   //全部
        if (indexPath.row < self.GoldArr.count)
        {
            // 金券
            model = self.GoldArr[indexPath.row];
            type = MyGoldCouponsCellTypeGold;
        }
        else if (indexPath.row < self.dataArr1.count+self.GoldArr.count)
        {
            // 优惠券
            model = self.dataArr1[indexPath.row-self.GoldArr.count];
            type = MyGoldCouponsCellTypeCoupon;
        } else
        {
            // 抵用券
            model = self.voucherArr[indexPath.row-self.dataArr1.count-self.GoldArr.count];
            type = MyGoldCouponsCellTypeVoucher;

        }
    } else if (tableView.tag == 201)
    {
        if (indexPath.row < self.failureGoldArr.count){
            model = self.failureGoldArr[indexPath.row];
            type = MyGoldCouponsCellTypeGoldFail;
        }else{
            //失效
            model = self.dataArr2[indexPath.row-self.failureGoldArr.count];
            type = MyGoldCouponsCellTypeCouponFail;
        }
    }else if (tableView == _MytableView)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if(!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSMutableString *str = _discriptionData[indexPath.row];
        NSArray *arr = [str componentsSeparatedByString:@"_"];
        
        UIFont *titlefont = [UIFont systemFontOfSize:ZOOM6(32)];
        NSString *titlestr = [NSString stringWithFormat:@"%@",arr[0]];
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@\n%@",arr[0],arr[1]];
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.textColor=kTextColor;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
        
        //lable的行间距
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:cell.detailTextLabel.text];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:4];
        
        
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [cell.detailTextLabel.text length])];
        [attributedString1 addAttribute:NSForegroundColorAttributeName value: tarbarrossred range:NSMakeRange(0, titlestr.length)];
        
        [attributedString1 addAttribute:NSFontAttributeName value:titlefont range:NSMakeRange(0, titlestr.length)];
        
        [cell.detailTextLabel setAttributedText:attributedString1];
        [cell.detailTextLabel sizeToFit];
        
        return cell;
        
    }
    
    MyGoldCouponsCell *cell = [MyGoldCouponsCell cellWithType:type tableView:tableView];
    [cell receiveDataModel:model];
    cell.UseBtnBlock=^{
        Mtarbar.selectedIndex=0;
        [self.navigationController popToRootViewControllerAnimated:NO];
    };
    cell.GoldTimeoutBlock=^{
        [self.GoldArr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    };
    return cell;
    //end
}

-(CGFloat)getRowHeight:(NSString *)text fontSize:(CGFloat)fontSize
{
    //文字高度
    CGFloat height;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(CGRectGetWidth(_MytableView.frame), 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
        
    }
    else{
        
    }
    
    return height;
}

#pragma mark - 懒加载数据
- (NSMutableArray *)dataArr1
{
    if (_dataArr1 == nil) {
        _dataArr1 = [[NSMutableArray alloc] init];
    }
    return _dataArr1;
}

- (NSMutableArray *)dataArr2
{
    if (_dataArr2 == nil) {
        _dataArr2 = [[NSMutableArray alloc] init];
    }
    return _dataArr2;
}
- (NSArray *)discriptionData
{
    if (_discriptionData == nil) {
        _discriptionData = [[NSArray alloc] init];
    }
    return _discriptionData;
}
- (NSMutableArray *)failureGoldArr
{
    if (_failureGoldArr == nil) {
        _failureGoldArr = [[NSMutableArray alloc] init];
    }
    return _failureGoldArr;
}

- (NSMutableArray *)voucherArr {
    if (nil == _voucherArr) {
        _voucherArr = [NSMutableArray array];
    }
    return _voucherArr;
}

- (NSMutableArray *)GoldArr {
    if (nil == _GoldArr) {
        _GoldArr = [NSMutableArray array];
    }
    return _GoldArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightBarButtonClick
{
    [self message];
}
//消息盒子
- (void)message
{
    //begin 赵官林 2016.5.26 跳转到消息列表
    [self presentChatList];
    //end
}


-(void)edit:(UIButton*)sender
{
    if([_discriptionData count])
    {
        UIButton *button=(UIButton*)[self.view viewWithTag:sender.tag];
        
        sender.selected=!sender.selected;
        
        
        //编辑");
        if(sender.selected)
        {
            [button setTitle:@"如何使用" forState:UIControlStateNormal];
            _discriptionBtn.selected=YES;
            
            [self creatPopView];
        }else{
            [button setTitle:@"使用说明" forState:UIControlStateNormal];
            _discriptionBtn.selected=NO;
            
            [self tapClick];
        }
    }
    
}

-(void)creatPopView
{
    _Popview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    
    _Popview.userInteractionEnabled = YES;
    
    //弹框内容
    _InvitationCodeView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM6(100), ZOOM6(460)-(IMGSIZEW(@"icon-guanbi")/2), kScreenWidth-ZOOM6(100)*2, kScreenHeight-ZOOM6(460)*2+IMGSIZEW(@"icon-guanbi"))];
    _InvitationCodeView.backgroundColor = [UIColor whiteColor];
    _InvitationCodeView.clipsToBounds = YES;
    _InvitationCodeView.layer.cornerRadius = 5;
    [_Popview addSubview:_InvitationCodeView];
    
    UIImageView *bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _InvitationCodeView.frame.size.width, _InvitationCodeView.frame.size.height/8)];
    bgImg.image = [UIImage imageNamed:@"shiyongshuoming_bg"];
    [_InvitationCodeView addSubview:bgImg];
    
    //关闭按钮
    CGFloat btnwidth = ZOOM6(80);
    
    _canclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _canclebtn.frame=CGRectMake(CGRectGetWidth(_InvitationCodeView.frame)-btnwidth, (CGRectGetHeight(bgImg.frame)-btnwidth)/2, btnwidth, btnwidth);
//    _canclebtn.backgroundColor = [UIColor yellowColor];
//    [_canclebtn setImage:[UIImage imageNamed:@"icon-guanbi"] forState:UIControlStateNormal];
    _canclebtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    _canclebtn.layer.cornerRadius=btnwidth/2;
    [_canclebtn addTarget:self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
    [_InvitationCodeView addSubview:_canclebtn];
    
    CGFloat cancleimagewidth = IMAGEW(@"icon-guanbi");
    UIImageView *cancleimage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(_InvitationCodeView.frame)-cancleimagewidth-ZOOM6(30), (CGRectGetHeight(bgImg.frame)-cancleimagewidth)/2, cancleimagewidth, cancleimagewidth)];
    cancleimage.image = [UIImage imageNamed:@"icon-guanbi"];
    [_InvitationCodeView addSubview:cancleimage];

    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(bgImg.frame), CGRectGetHeight(bgImg.frame))];
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.backgroundColor = [UIColor clearColor];
    titlelabel.font = [UIFont systemFontOfSize:ZOOM6(34)];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    [_InvitationCodeView addSubview:titlelabel];
    
    
    titlelabel.text = @"使用规则";
    
    _MytableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bgImg.frame)+5, CGRectGetWidth(bgImg.frame), CGRectGetHeight(_InvitationCodeView.frame)-CGRectGetHeight(bgImg.frame)-10) style:UITableViewStylePlain];
    _MytableView.delegate = self;
    _MytableView.dataSource = self;
    
    _MytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _MytableView.showsVerticalScrollIndicator = YES;
    [_MytableView registerNib:[UINib nibWithNibName:@"PartnerCardCell" bundle:nil] forCellReuseIdentifier:@"CardCell"];
    [_InvitationCodeView addSubview:_MytableView];
    
    
    [_Popview addSubview:_InvitationCodeView];
    
    [self.view addSubview:_Popview];
    
    
    _InvitationCodeView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    _InvitationCodeView.alpha = 0.5;
    
    _Popview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
//    [UIView animateWithDuration:0.5 animations:^{
//        
//        _Popview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
//        
//        _InvitationCodeView.transform = CGAffineTransformMakeScale(1, 1);
//        _InvitationCodeView.alpha = 1;
//        
//    } completion:^(BOOL finish) {
//        
//    }];
    
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _Popview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        _InvitationCodeView.transform = CGAffineTransformMakeScale(1, 1);
        _InvitationCodeView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)tapClick
{
    [_discriptionBtn setTitle:@"使用说明" forState:UIControlStateNormal];
    _discriptionBtn.selected = NO;
    
    [_canclebtn removeFromSuperview];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _Popview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
        _InvitationCodeView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        _InvitationCodeView.alpha = 0;
        
    } completion:^(BOOL finish) {
        
        [_Popview removeFromSuperview];
    }];
    
    
}


- (void)back:(UIButton*)seder
{
    if (self.navigationController == [Mtarbar.viewControllers objectAtIndex:3]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
//        [self.navigationController popToRootViewControllerAnimated:YES];
    }

//    [self.navigationController popViewControllerAnimated:YES];
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
