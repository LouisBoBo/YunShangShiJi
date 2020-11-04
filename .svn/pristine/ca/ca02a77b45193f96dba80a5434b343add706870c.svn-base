//
//  TFUserCardViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/9/2.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFUserCardViewController.h"
#import "MyCardCell.h"
#import "MyCardModel.h"
#import "AffirmOrderViewController.h"
#import "HBbankcardCell.h"
//#import "ChatListViewController.h"
#import "MyCouponsCell.h"
#import "GoldCouponsManager.h"
#import "MyGoldCouponsCell.h"
#import "NSDate+Helper.h"

@interface TFUserCardViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation TFUserCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super setNavigationItemLeft:@"优惠券"];
    
    [self createTableView];
    
    [self httpGetCard];
}

- (void)returnSuccessBlock:(SuccessBlock)theBlock
{
    self.myBlock = theBlock;
}

- (void)httpGetCard
{
    [NSDate systemCurrentTime:^(long long time) {
        [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithLongLong:time] forKey:@"systemCurrentTime"];
    }];

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@coupon/queryByPage?order=desc&token=%@&version=%@&maxormin=>&is_use=1&c_cond=%.2f",[NSObject baseURLStr],token,VERSION,self.c_cond];
    NSString *URL = [MyMD5 authkey:urlStr];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                //res = %@",responseObject);
                NSArray *data = responseObject[@"data"];
                if (data.count == 0 &&self.dataArr.count == 0) {
                    if ([GoldCouponsManager goldcpManager].c_price<self.totalPrice&&![GoldCouponsManager goldcpManager].is_use&&[GoldCouponsManager goldcpManager].is_open&&[GoldCouponsManager goldcpManager].c_price) {
                        [self clearBackgroundView:self.view withTag:10000];
                        [self addGlodCouponModel];
                        [self.tableView reloadData];
                    }else{
                        CGRect frame = CGRectMake(0, kNavigationheightForIOS7, self.view.frame.size.width, kScreenHeight-kNavigationheightForIOS7);
                        [self createBackgroundView:self.view andTag:10000 andFrame:frame withImgge:nil andText:nil];
                    }
                } else {
                    [self clearBackgroundView:self.view withTag:10000];
                    for (NSDictionary *dic in data) {
                        MyCardModel *cModel = [[MyCardModel alloc] init];
                        [cModel setValuesForKeysWithDictionary:dic];
                        cModel.ID = dic[@"id"];
                        if ([cModel.ID integerValue]==[GoldCouponsManager goldcpManager].c_id&&[GoldCouponsManager goldcpManager].is_open) {
                            cModel.c_cond = [NSNumber numberWithFloat:[GoldCouponsManager goldcpManager].c_price+0.01];
                            [self.dataArr insertObject:cModel atIndex:0];
                        }else
                            [self.dataArr addObject:cModel];
                    }
                    MyCardModel *model=self.dataArr[0];
                    MyLog(@"%d ,%d, %d",[model.ID integerValue]!=[GoldCouponsManager goldcpManager].c_id,[GoldCouponsManager goldcpManager].c_price<self.c_cond,![GoldCouponsManager goldcpManager].is_use&&[GoldCouponsManager goldcpManager].is_open)
                    if ([model.ID integerValue]!=[GoldCouponsManager goldcpManager].c_id&&[GoldCouponsManager goldcpManager].c_price<self.c_cond&&![GoldCouponsManager goldcpManager].is_use&&[GoldCouponsManager goldcpManager].c_price&&[GoldCouponsManager goldcpManager].is_open) {
                        
                        [self addGlodCouponModel];
                    }
                    
                    [self.tableView reloadData];
                }
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }
        
 
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        CGRect frame = CGRectMake(0, kNavigationheightForIOS7, self.view.frame.size.width, kScreenHeight-kNavigationheightForIOS7);
        [self createBackgroundView:self.view andTag:99999 andFrame:frame withImgge:[UIImage imageNamed:@"哭脸"] andText:@"亲,没网了"];
        //        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];

    }];
}
- (void)addGlodCouponModel {
    MyCardModel *cModel = [[MyCardModel alloc] init];
    cModel.c_price = [NSNumber numberWithFloat:[GoldCouponsManager goldcpManager].c_price];
    cModel.ID = [NSNumber numberWithInteger:[GoldCouponsManager goldcpManager].c_id];
    cModel.c_cond = [NSNumber numberWithFloat:[GoldCouponsManager goldcpManager].c_price+0.01];
    cModel.c_last_time = [NSNumber numberWithLongLong:[GoldCouponsManager goldcpManager].c_last_time];
    [self.dataArr insertObject:cModel atIndex:0];
}

- (void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7, kScreenWidth, kScreenHeight-kNavigationheightForIOS7)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, kZoom6pt(10))];
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kZoom6pt(110);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    HBbankcardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
//    if (cell == nil) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"HBbankcardCell" owner:self options:nil] lastObject];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
    MyCardModel *cModel = self.dataArr[indexPath.row];
    MyGoldCouponsCellType type = indexPath.row==0&&[GoldCouponsManager goldcpManager].is_open&&[cModel.ID integerValue]==[GoldCouponsManager goldcpManager].c_id?MyGoldCouponsCellTypeGold:MyGoldCouponsCellTypeCoupon;
    MyGoldCouponsCell *cell = [MyGoldCouponsCell cellWithType:type tableView:tableView];
    cell.userButton.hidden=YES;
    [cell receiveDataModel:self.dataArr[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*选中传model*/
//    AffirmOrderViewController *affVc = [[AffirmOrderViewController alloc] init];
//    affVc.cardModel = self.dataArr[indexPath.row];
    MyCardModel *model = self.dataArr[indexPath.row];
    if (self.myBlock!=nil) {
        self.myBlock(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarButtonClick
{
    [self message];
}
- (void)message
{
    [self presentChatList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
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
