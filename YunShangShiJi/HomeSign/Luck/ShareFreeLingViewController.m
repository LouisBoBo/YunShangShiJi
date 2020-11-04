//
//  ShareFreeLingViewController.m
//  YunShangShiJi
//
//  Created by hebo on 2019/9/10.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import "ShareFreeLingViewController.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "UIImageView+WebCache.h"
#import "MyMD5.h"
#import "ShopDetailViewController.h"
//#import "ChatViewController.h"
#import "RobotManager.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "tableHeadView.h"
#import "logistTableViewCell.h"
#import "OrderTableViewCell.h"
#import "AttenceTimelineCell.h"
#import "MiniShareManager.h"
#import "OneLuckdrawViewController.h"
#import "ProduceImage.h"
#import "DShareManager.h"
@interface ShareFreeLingViewController ()<UITableViewDelegate,UITableViewDataSource,MiniShareManagerDelegate,DShareManagerDelegate>
@property (strong , nonatomic) UIView *tableFootview;
@property (assign , nonatomic) UILabel*titleLab;
@property (assign , nonatomic) NSInteger shareCount;
@property (assign , nonatomic) BOOL is_share;

@property (strong , nonatomic) NSString *shareTitle;
@property (strong , nonatomic) NSString *shareImage;
@property (strong , nonatomic) NSString *sharePath;
@property (strong , nonatomic) UIImage *canvashareImage;
@end

@implementation ShareFreeLingViewController
{
    UITableView *_tableView;
    NSMutableArray *_dataSource;
    ShopDetailModel *_logisticmodel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWiteColor;
    self.is_share = NO;
    
    //获取已经分享的次数
    ShopDetailModel *model;
    if ([self.comefrome isEqualToString:@"分享免费领"]) {
        model=self.Ordermodel;
    }else if(_Ordermodel.shopsArray.count){
        model=_Ordermodel.shopsArray[0];
    }
    NSInteger shareCound = [[NSUserDefaults standardUserDefaults]integerForKey:model.shop_code];
    self.shareCount = shareCound>0?shareCound:5;
    
    [self creatNavigatview];
    [self httpGetShareShop];
}
- (void)creatNavigatview{
    [self setNavigationItemLeft:@"会员免费领"];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.navigationView.frame.size.height-1, kApplicationWidth, 0.5)];
    line.backgroundColor = kNavLineColor;
    [self.navigationView addSubview:line];
    
    [self creatMainview];
    
    [self httpGetShareShop];
}

- (void)creatMainview{
    _dataSource = [[NSMutableArray alloc] init];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"OrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];

    [_tableView registerClass:[AttenceTimelineCell class] forCellReuseIdentifier:@"logistcell"];
    
    [self GetlogHttp:self.Ordermodel.logi_code :self.Ordermodel.logi_name];
    
    [self.view addSubview:_tableView];
    
    _tableView.tableFooterView = self.tableFootview;
}

- (NSString *)exchangeTextWihtString:(NSString *)text
{
    if ([text rangeOfString:@"】"].location != NSNotFound){
        NSArray *arr = [text componentsSeparatedByString:@"】"];
        NSString *textStr;
        if (arr.count == 2) {
            textStr = [NSString stringWithFormat:@"%@%@】", arr[1], arr[0]];
        }
        return textStr;
    }
    return text;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    Myview.hidden=YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    Myview.hidden=NO;
}


-(void)GetlogHttp:(NSString*)logi_code :(NSString*)logi_name
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url = [NSString stringWithFormat:@"%@order/expQuery?version=%@&token=%@&nu=%@",[NSObject baseURLStr],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN],logi_code];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        MyLog(@"responseObject is %@",responseObject);
        
        //responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            //            if(responseObject[@"com"] !=nil)
            if(responseObject[@"data"] !=nil && [responseObject[@"data"]count]!=0)
                
            {
                ShopDetailModel *model=[[ShopDetailModel alloc]init];
                model.codenumber=responseObject[@"codenumber"];
                model.com=responseObject[@"com"];
                model.companytype=responseObject[@"companytype"];
                model.condition=responseObject[@"condition"];
                model.ischeck=responseObject[@"ischeck"];
                model.nu=responseObject[@"nu"];
                model.state=responseObject[@"state"];
                model.logisstatus=responseObject[@"status"];
                model.updatetime=responseObject[@"updatetime"];
                _logisticmodel= model;
                
                //                for(NSDictionary *dic in responseObject[@"data"])
                for(NSDictionary *dic in responseObject[@"data"][0][@"lastResult"][@"data"])
                    
                {
                    ShopDetailModel *Logisticsmodel=[[ShopDetailModel alloc]init];
                    Logisticsmodel.context=dic[@"context"];
                    //%@",Logisticsmodel.context);
                    Logisticsmodel.ftime=dic[@"ftime"];
                    Logisticsmodel.time=dic[@"time"];
                    
                    [_dataSource addObject:Logisticsmodel];
                }
                [_tableView reloadData];
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        
    }];
    
    
}

//获取分享的商品
- (void)httpGetShareShop
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@shop/shareShop?token=%@&version=%@&getShop=true",[NSObject baseURLStr], token,VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                NSString *shop_name = responseObject[@"shop"][@"shop_name"];
                NSNumber *shop_se_price = responseObject[@"shop"][@"app_shop_group_price"];
                NSString *four_pic = responseObject[@"shop"][@"four_pic"];
                NSArray *picArr = [four_pic componentsSeparatedByString:@","];
                NSString *pic = [picArr lastObject];
                NSString *shop_code = responseObject[@"shop"][@"shop_code"];
                NSString *sup_code  = [shop_code substringWithRange:NSMakeRange(1, 3)];
                NSString *share_pic = [NSString stringWithFormat:@"%@/%@/%@", sup_code, shop_code, pic];
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];

                self.sharePath = [NSString stringWithFormat:@"/pages/shouye/detail/detail?shop_code=%@&user_id=%@&isShareFlag=true",shop_code,[user objectForKey:USER_ID]];
                self.shareTitle = [NSString stringWithFormat:@"点击购买👆【%@】今日特价%.1f元！",shop_name,shop_se_price.floatValue];
                self.shareImage = [NSString stringWithFormat:@"%@%@!450",[NSObject baseURLStr_Upy],share_pic];
                
                //合成图片
                ProduceImage *pi = [[ProduceImage alloc] init];
                UIImage *baseImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.shareImage]]];
                UIImage *zhezhaoImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/shareCanvas_price.png"]]]];
                UIImage *afterImage = [pi getShareImage:zhezhaoImg WithBaseImg:baseImg WithPrice:(NSString*)shop_se_price];
                self.canvashareImage = afterImage;
                
            }else
                [MBProgressHUD showError:responseObject[@"message"]];
        }
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

//分享完调用后台接口
-(void)afterShareHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url = [NSString stringWithFormat:@"%@order/updateOrderFriendsShare?version=%@&token=%@&order_code=%@",[NSObject baseURLStr],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN],self.order_code];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        MyLog(@"responseObject is %@",responseObject);
        
        if (responseObject!=nil) {
            NSString *status = [NSString stringWithFormat:@"%@",responseObject[@"status"]];
            if(status.intValue == 1)
            {
                OneLuckdrawViewController *oneLuck = [OneLuckdrawViewController new];
                oneLuck.comefrom = @"paysuccess";
                oneLuck.order_code = self.order_code;
                [self.navigationController pushViewController:oneLuck animated:YES];
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        
    }];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 140;
    }
    ShopDetailModel *model=_dataSource[indexPath.row];
    NSString *content=[NSString stringWithFormat:@"%@\n%@",model.context,model.time];
    
    return [AttenceTimelineCell cellHeightWithString:content isContentHeight:NO];
    return 55;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailModel *model=self.Ordermodel.shopsArray[indexPath.row];
    
    ShopDetailViewController *shopdetail=[[ShopDetailViewController alloc]initWithNibName:@"ShopDetailViewController" bundle:nil];
    
    OrderTableViewCell *cell = (OrderTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    shopdetail.bigimage=cell.headimage.image;
    
    shopdetail.shop_code=model.shop_code;
    shopdetail.stringtype = @"订单详情";
    
    [self.navigationController pushViewController:shopdetail animated:YES];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    OrderTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(!cell)
    {
        cell=[[OrderTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    if ([self.comefrome isEqualToString:@"分享免费领"]) {
        ShopDetailModel *model=self.Ordermodel;
        model.status = @"9999";
        model.shop_pic = model.def_pic;
        model.orderShopStatus = @"0";
        [cell refreshData:model];
    }else if(_Ordermodel.shopsArray.count){
        
        ShopDetailModel *model=_Ordermodel.shopsArray[indexPath.row];
        model.status = @"9999";
        [cell refreshData:model];
    }
    cell.zeroLabel.hidden=YES;
    cell.color_size.hidden=NO;
    cell.statue.hidden=NO;
    
    
    return cell;
}

- (void)leftBarButtonClick{
    
    UIViewController *vc=(UIViewController *)self.navigationController.viewControllers[self.navigationController.viewControllers.count-2];
    if ([vc isKindOfClass:NSClassFromString(@"OrderTableViewController")]) {
        
        [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count-3] animated:YES];
    }else{
       [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)getBalancemutable:(UILabel*)lab Text:(NSString*)text FromIndex:(int)index
{
    NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:lab.text];
    [mutable addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(index, text.length)];
    [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(40)] range:NSMakeRange(index, text.length)];
    [lab setAttributedText:mutable];
    
}

#pragma 分享
- (void)shareclick:(UIButton*)sender{
    
    MiniShareManager *minishare = [MiniShareManager share];
    minishare.delegate = self;
    self.is_share = YES;

    NSString *path  = self.sharePath;
    NSString *title = self.shareTitle;
    NSData *imageData = UIImageJPEGRepresentation(self.canvashareImage,0.8f);
    [minishare shareAppImageWithType:MINIShareTypeWeixiSession Image:imageData Title:title Discription:nil WithSharePath:path];

    kWeakSelf(self);
    minishare.MinishareSuccess = ^{
        
        [weakself afterShareHandle];
    };
    minishare.MinishareFail = ^{
        
        [weakself afterShareHandle];
    };
}
- (void)afterShareHandle
{
    self.shareCount --;
    self.is_share = NO;
    NSString *sharecount = [NSString stringWithFormat:@"%zd",self.shareCount>1?self.shareCount:1];
    self.titleLab.text = [NSString stringWithFormat:@"再分享%@件美衣到微信群，可免费领本商品",sharecount];
    [self getBalancemutable:self.titleLab Text:sharecount FromIndex:3];
    
    if(self.shareCount == 0)
    {
        [self afterShareHttp];
    }else{
        [self httpGetShareShop];
    }
    
    ShopDetailModel *model;
    if ([self.comefrome isEqualToString:@"分享免费领"]) {
        model=self.Ordermodel;
    }else if(_Ordermodel.shopsArray.count){
        model=_Ordermodel.shopsArray[0];
    }
    [[NSUserDefaults standardUserDefaults]setInteger:self.shareCount forKey:model.shop_code];
}
- (UIView*)tableFootview
{
    if(_tableFootview == nil){
        
        _tableFootview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(600))];

        UILabel *titleLab = [[UILabel alloc]init];
        titleLab.text = [NSString stringWithFormat:@"再分享%zd件美衣到微信群，可免费领本商品",self.shareCount];
        
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.font = [UIFont systemFontOfSize:ZOOM6(34)];
        [self getBalancemutable:titleLab Text:@"5" FromIndex:3];
        [_tableFootview addSubview:self.titleLab = titleLab];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 15, kApplicationWidth, 0.5)];
        line.backgroundColor = kNavLineColor;
        [_tableFootview addSubview:line];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(ZOOM6(80));
            make.width.mas_offset(kScreenWidth-ZOOM6(20)*2);
            make.height.mas_offset(ZOOM6(50));
            make.centerX.equalTo(_tableFootview);
        }];
        
        UIButton *sharebtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [sharebtn1 setTitle:@"分享其它微信群" forState:UIControlStateNormal];
        sharebtn1.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(32)];
        sharebtn1.clipsToBounds = YES;
        sharebtn1.layer.cornerRadius = 5;
        sharebtn1.backgroundColor = tarbarrossred;
        sharebtn1.titleLabel.textColor = kWiteColor;
        [sharebtn1 addTarget:self action:@selector(shareclick:) forControlEvents:UIControlEventTouchUpInside];
        [_tableFootview addSubview:sharebtn1];
        [sharebtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLab).offset(ZOOM6(100));
            make.width.mas_offset(kScreenWidth - ZOOM6(30)*2);
            make.height.mas_offset(ZOOM6(80));
            make.centerX.equalTo(_tableFootview);
        }];
        
        UILabel *titleLab1 = [[UILabel alloc]init];
        titleLab1.text = @"群友点击绑定成为您下级，消费即得10%奖励金";
        titleLab1.textAlignment = NSTextAlignmentCenter;
        titleLab1.font = [UIFont systemFontOfSize:ZOOM6(30)];
        titleLab1.textColor = kTextColor;
        [_tableFootview addSubview:titleLab1];

        [titleLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(sharebtn1).offset(ZOOM6(90));
            make.width.mas_offset(kScreenWidth-ZOOM6(20)*2);
            make.height.mas_offset(ZOOM6(50));
            make.centerX.equalTo(_tableFootview);
        }];

        UIButton *sharebtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [sharebtn2 setTitle:@"分享自己的微信群" forState:UIControlStateNormal];
        sharebtn2.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(32)];
        sharebtn2.clipsToBounds = YES;
        sharebtn2.layer.cornerRadius = 5;
        sharebtn2.backgroundColor = tarbarrossred;
        sharebtn2.titleLabel.textColor = kWiteColor;
        [sharebtn2 addTarget:self action:@selector(shareclick:) forControlEvents:UIControlEventTouchUpInside];
        [_tableFootview addSubview:sharebtn2];
        [sharebtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLab1).offset(ZOOM6(100));
            make.width.mas_offset(kScreenWidth - ZOOM6(30)*2);
            make.height.mas_offset(ZOOM6(80));
            make.centerX.equalTo(_tableFootview);
        }];

        UILabel *titleLab2 = [[UILabel alloc]init];
        titleLab2.text = @"定期推荐新款唤醒群友，消费即得10%奖励金";
        titleLab2.textAlignment = NSTextAlignmentCenter;
        titleLab2.font = [UIFont systemFontOfSize:ZOOM6(30)];
        titleLab2.textColor = kTextGreyColor;
        [_tableFootview addSubview:titleLab2];

        [titleLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(sharebtn2).offset(ZOOM6(90));
            make.width.mas_offset(kScreenWidth-ZOOM6(20)*2);
            make.height.mas_offset(ZOOM6(50));
            make.centerX.equalTo(_tableFootview);
        }];
    }
    return _tableFootview;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
