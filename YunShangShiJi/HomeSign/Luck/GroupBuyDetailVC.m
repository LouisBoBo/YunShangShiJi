//
//  GroupBuyDetailVC.m
//  YunShangShiJi
//
//  Created by YF on 2017/7/11.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "GroupBuyDetailVC.h"
#import "MakeMoneyViewController.h"
#import "TFPayStyleViewController.h"
#import "MyOrderViewController.h"
#import "OrderDetailViewController.h"
#import "TFWithdrawCashViewController.h"
#import "SpecialShopDetailViewController.h"

#import "AppDelegate.h"
#import "DShareManager.h"
#import "Signmanager.h"

#import "NoMentionView.h"
#import "GroupBuyPopView.h"
#import "CLCountDownView.h"
#import "AffirmOrderCell.h"
#import "TaskSignModel.h"

#import "TypeShareModel.h"

#pragma mark - 1️⃣➢➢➢ CFBaseTableHeaderFooterview
@interface CFBaseTableHeaderview : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UIImageView *userImg;
@property (nonatomic, strong) UIImageView *userIco;
@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) UILabel *time;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
@implementation CFBaseTableHeaderview

+ (instancetype)headerViewWithTableView:(UITableView *)tableView {
    if (tableView == nil) {
        return [[self alloc] init];
    }
    NSString *classname = NSStringFromClass([self class]);
    NSString *identifer = [classname stringByAppendingString:@"header"];
    [tableView registerClass:[self class] forHeaderFooterViewReuseIdentifier:identifer];
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifer];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CAShapeLayer *circleMask = [CAShapeLayer layer];
    circleMask.path = [UIBezierPath bezierPathWithOvalInRect:self.userImg.bounds].CGPath;
    self.userImg.layer.mask = circleMask;
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];

        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(20))];
        line.backgroundColor = kBackgroundColor;
        [self addSubview:line];

        [self addSubview:self.leftLabel];
        [self addSubview:self.userImg];
        [self addSubview:self.userIco];
        [self addSubview:self.userName];
        [self addSubview:self.time];

        [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(ZOOM6(30));
            make.centerY.equalTo(self).offset(ZOOM6(10));
        }];
        [_userImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftLabel.mas_right).offset(ZOOM6(20));
            make.width.height.offset(ZOOM6(60));
            make.centerY.equalTo(_leftLabel);
        }];
        [_userIco mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_userImg.mas_left).offset(ZOOM6(20));
            make.width.offset(ZOOM6(60));
            make.height.offset(ZOOM6(32));
            make.top.equalTo(_userImg.mas_top).offset(-ZOOM6(16));
        }];
        [_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-ZOOM6(30));
            make.centerY.equalTo(_leftLabel);
        }];
        [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_lessThanOrEqualTo(_time.mas_left).offset(-ZOOM6(10));
            make.left.equalTo(_userImg.mas_right).offset(ZOOM6(16));
            make.centerY.equalTo(_leftLabel);
        }];
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, ZOOM6(120)-1, kScreenWidth, 0.5)];
        line2.backgroundColor = kTableLineColor;
        [self addSubview:line2];
    }
    return self;
}

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.textColor = kMainTitleColor;
        _leftLabel.font = kFont6px(28);
    }
    return _leftLabel;
}
- (UIImageView *)userImg {
    if (!_userImg) {
        _userImg = [[UIImageView alloc]init];
    }
    return _userImg;
}
- (UIImageView *)userIco {
    if (!_userIco) {
        _userIco = [[UIImageView alloc]init];
        _userIco.image = [UIImage imageNamed:@"团长"];
    }
    return _userIco;
}
- (UILabel *)userName {
    if (!_userName) {
        _userName = [[UILabel alloc]init];
        _userName.textColor = kSubTitleColor;
        _userName.font = kFont6px(24);
    }
    return _userName;
}
- (UILabel *)time {
    if (!_time) {
        _time = [[UILabel alloc]init];
        _time.textColor = RGBA(168, 168, 168, 1);
        _time.font = kFont6px(24);
    }
    return _time;
}
@end
@interface CFBaseTableFooterview : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *leftLabel;

+ (instancetype)FooterViewWithTableView:(UITableView *)tableView;
@end
@implementation CFBaseTableFooterview

+ (instancetype)FooterViewWithTableView:(UITableView *)tableView {
    if (tableView == nil) {
        return [[self alloc] init];
    }
    NSString *classname = NSStringFromClass([self class]);
    NSString *identifer = [classname stringByAppendingString:@"footer"];
    [tableView registerClass:[self class] forHeaderFooterViewReuseIdentifier:identifer];
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifer];
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];

        [self addSubview:self.leftLabel];

        [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-ZOOM6(30));
            make.centerY.equalTo(self).offset(ZOOM6(15));
        }];
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, ZOOM6(30), kScreenWidth, 0.5)];
        line2.backgroundColor = kTableLineColor;
        [self addSubview:line2];
    }
    return self;
}

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.textAlignment = NSTextAlignmentRight;
        _leftLabel.textColor = kMainTitleColor;
        _leftLabel.font = kFont6px(30);
    }
    return _leftLabel;
}

@end
#pragma mark - 1️⃣➢➢➢ GroupBuyDetailVC
@interface GroupBuyDetailVC ()<UITableViewDelegate,UITableViewDataSource,CLCountDownViewDelegate,DShareManagerDelegate,MiniShareManagerDelegate>
{
    UIButton *bottomBtn;
    UIImageView *headView_Img;
    UILabel *headView_Label;
    UILabel *personLeast;
    NSString *personLeastNum;

    NSInteger leastPayTime; //剩余付款时间
    NSString *payPrice;     //支付价格
    NSString *payOrderCode; //支付订单编号
    double paytime;         //支付时间
    BOOL is_vip;            //0不是 1是
    NSString *linkUrl,*imgPathUrl,*shareTitle,*shareDiscription;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *shopArray;

@property (nonatomic , strong) DShareManager *shareManager;
@property (nonatomic, strong)  CLCountDownView *countDownView;

@end

@implementation GroupBuyDetailVC
@synthesize countDownView;

- (void)dealloc {
    MyLog(@"%@ release",[self class]);
}
- (void)leftBarButtonClick
{
    for(UIViewController *vv in self.navigationController.viewControllers)
    {
        if([vv isKindOfClass:[MyOrderViewController class]] || [vv isKindOfClass:[OrderDetailViewController class]])
        {
            [self.navigationController popToViewController:vv animated:YES];
            return;
        }
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavigationItemLeft:@"拼团详情"];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.navigationView.frame.size.height-1, kApplicationWidth, 0.5)];
    line.backgroundColor = kNavLineColor;
    [self.navigationView addSubview:line];

    [self setUI];
    
//    if ([DataManager sharedManager].opengroup==1||([DataManager sharedManager].fightStatus==nil||[[DataManager sharedManager].fightStatus containsString:@"null"])) {
//        [self httpData];
//    }else
//    [self httpData2];
    
    [TaskSignModel fightinitialSuccess:self.roll_code :^(id data) {
        
        TaskSignModel *model = data;
        if(model.data != nil)
        {
            if(model.data[@"rnum"] != nil)
            {
                [Signmanager SignManarer].rnum = [NSString stringWithFormat:@"%@",model.data[@"rnum"]];
            }else{
                [Signmanager SignManarer].rnum = @"10";
            }
            [Signmanager SignManarer].DPPAYPRICE = [NSString stringWithFormat:@"%@",model.data[@"DPPAYPRICE"]];
            [Signmanager SignManarer].validHour = [NSString stringWithFormat:@"%@",model.data[@"validMin"]];
            paytime = [model.data[@"paytime"] doubleValue];
            is_vip = [model.data[@"isVip"] boolValue];
            countDownView.countDownTimeInterval = [model.data[@"validMin"] doubleValue]/1000;
            
        }
        [self httpData2];
    }];
    
    [self httpShareData];
}

- (void)setUI {
    [self.view addSubview:self.tableView];

    if ([DataManager sharedManager].opengroup==1) {
        [self creatBootomView];
    }
    self.tableView.hidden = YES;bottomBtn.hidden = YES;

}
- (void)popView:(GroupBuyPopType)type {

    if (type == GroupBuyPopType3 || type == GroupBuyPopType4 || type == GroupBuyPopType9) {
        [self httpActivityRule:type];
    }else
    if (type) {
        GroupBuyPopView *view = [[GroupBuyPopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) popType:type];
        view.num = personLeastNum;
        kSelfWeak;
        if (type==GroupBuyPopType7) {
            view.timeout=leastPayTime;
            view.timeOutBlock = ^{
                [weakSelf popView:GroupBuyPopType9];
            };
        }
        view.btnBlok = ^(NSInteger index) {
            if(type == GroupBuyPopType1)
            {
                [weakSelf goShare:index imgUrl:@"" title:@"" link:@""];
            }
            if (index == 7) {
                TFPayStyleViewController *paystyle=[[TFPayStyleViewController alloc]init];
                paystyle.urlcount=@"1";
                paystyle.shop_from = @"7";
                paystyle.price = payPrice.doubleValue;
                paystyle.order_code = payOrderCode;

                [weakSelf.navigationController pushViewController:paystyle animated:YES];
            }
        };
        [view show];
    }else
    //1开团成功 2开团中 3开团完成 4参团成功 5参团完成
    if ([DataManager sharedManager].opengroutSuccess==1) {
        [self collecLike:nil];
    }else if ([DataManager sharedManager].opengroutSuccess==4) {
//        GroupBuyPopView *view = [[GroupBuyPopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) popType:GroupBuyPopType2];
//        [view show];
        
    }
}
- (void)creatEmptyView {
    NoMentionView *nomentionView = [[NoMentionView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar) Image:@"topic_icon_no-buy" Content:@"你还没有参与过任何拼团，快去参团吧～"];
    nomentionView.backgroundColor = kBackgroundColor;
    [self.view addSubview:nomentionView];
}

- (void)countDownDidFinished {
    
}

- (void)changePopView:(NSInteger)status {
    
    if (status==0) {
        if (personLeastNum.intValue) {
            [self popView:GroupBuyPopType3];
        }else
            [self popView:GroupBuyPopType4];
    }else if (status==5) {
        [bottomBtn setTitle:@"拼团已结束" forState:UIControlStateSelected];
        bottomBtn.selected = YES;
        [self popView:GroupBuyPopType3];
    }else if (status==6) {
        [bottomBtn setTitle:@"拼团已结束" forState:UIControlStateSelected];
        bottomBtn.selected = YES;
        [self popView:GroupBuyPopType4];
    }else
        [self popView:0];
}

- (void)fightChangePopView:(NSInteger)status {
    
    if (status==11) {
        if(personLeastNum != 0)
        {
            [self popView:GroupBuyPopType1];//开团成功
        }else{
            countDownView.countDownTimeInterval = 0;
            [bottomBtn setTitle:@"拼团已结束" forState:UIControlStateSelected];
            bottomBtn.selected = YES;
            [self popView:GroupBuyPopType3];//拼团失败
        }
    }else if (status==12) {
        
        [self popView:GroupBuyPopType2];//拼团成功
    }else if (status==13) {
        countDownView.countDownTimeInterval = 0;
        [bottomBtn setTitle:@"拼团已结束" forState:UIControlStateSelected];
        bottomBtn.selected = YES;
        [self popView:GroupBuyPopType3];//拼团失败
    }else{
        if(personLeastNum != 0)
        {
            [self popView:GroupBuyPopType1];//开团成功
        }else{
            countDownView.countDownTimeInterval = 0;
            [bottomBtn setTitle:@"拼团已结束" forState:UIControlStateSelected];
            bottomBtn.selected = YES;
            [self popView:GroupBuyPopType3];//拼团失败
        }
    }
}

- (void)httpActivityRule:(GroupBuyPopType)type
{

    NSString *URL= [NSString stringWithFormat:@"%@paperwork/paperwork.json",[NSObject baseURLStr_Upy]];
    NSURL *httpUrl=[NSURL URLWithString:URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:httpUrl];
    request.timeoutInterval = 3;

    kSelfWeak;
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        responseObject = [NSDictionary changeType:responseObject];

            if(responseObject[@"qdrwyd"] != nil)
            {
                NSDictionary *dic = responseObject[@"qdrwyd"];
                NSString *text = dic[@"text"];
                NSArray *arr = [text componentsSeparatedByString:@","];
                if (arr.count>2) {
                    GroupBuyPopView *view = [[GroupBuyPopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) popType:type];
                    view.taskNum = [NSString stringWithFormat:@"%@",arr[1]];
                    view.moneyNum = [NSString stringWithFormat:@"%@元",arr[2]];
                    view.btnBlok = ^(NSInteger index) {
                        if (index == 5) {
                            for (UIViewController *temp in weakSelf.navigationController.viewControllers) {
                                if ([temp isKindOfClass:NSClassFromString(@"MakeMoneyViewController")]) {
                                    /****  发送通知 滚动到提现任务 */
                                    [[NSNotificationCenter defaultCenter]postNotificationName:@"toTask_tixian" object:nil];
                                    [weakSelf.navigationController popToViewController:temp animated:YES];
                                    return ;
                                }
                            }
                            /****  发送通知 滚动到提现任务 */
                            [[NSNotificationCenter defaultCenter]postNotificationName:@"toTask_tixian" object:nil];
                            MakeMoneyViewController *vc = [[MakeMoneyViewController alloc] init];
                            vc.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:vc animated:YES];
                            
                        }else if (index ==55)//去提现
                        {
                            TFWithdrawCashViewController *cash = [[TFWithdrawCashViewController alloc]init];
                            [self.navigationController pushViewController:cash animated:YES];
                        }
                    };
                    [view show];
                }
            }
    }

    /*
    NSString *url= [NSString stringWithFormat:@"%@paperwork/paperwork.json",[NSObject baseURLStr_Upy]];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    kSelfWeak;
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MyLog(@"responseObject = %@", responseObject);

        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {

            if(responseObject[@"qdrwyd"] != nil)
            {
                NSDictionary *dic = responseObject[@"qdrwyd"];
                NSString *text = dic[@"text"];
                NSArray *arr = [text componentsSeparatedByString:@","];
                if (arr.count>1) {
                    GroupBuyPopView *view = [[GroupBuyPopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) popType:type];
                    view.taskNum = [NSString stringWithFormat:@"%@",arr[0]];
                    view.moneyNum = [NSString stringWithFormat:@"%@元",arr[1]];
                    view.btnBlok = ^(NSInteger index) {
                        if (index == 5) {
                            for (UIViewController *temp in weakSelf.navigationController.viewControllers) {
                                if ([temp isKindOfClass:NSClassFromString(@"MakeMoneyViewController")]) {
                                    //  发送通知 滚动到提现任务
                                    [[NSNotificationCenter defaultCenter]postNotificationName:@"toTask_tixian" object:nil];
                                    [weakSelf.navigationController popToViewController:temp animated:YES];
                                }
                            }
                        }
                    };
                    [view show];
                }
            }
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];
    */
}
/**
 "r_code": "170711pv8oPKds",
 "add_time": 开团时间,拼团过期时间就用这个来判断.
 "shop_url":商品图片链接,号间隔,
 "shop_name": 商品名称,间隔
 "shop_roll": 拼团支付价格,
 "user_name": 用户昵称,
 "user_id":用户id,
 "order_code": 订单编号,
 "status": 0待成团
 5未达到人数 6 未付款

 "user_portrait":用户头像,
 "shop_code": 商品编号 ,号间隔,
 "type": 1开团 2参团,
 "color": 商品颜色 ^间隔",
 "size": 商品尺寸 ^间隔",
 "p_price": 商品价格^间隔"
 elide_price : 划掉的价格 ^ 间隔
 
 n_status:0 人数没满 1人满了等付款
 pay_end_time 付款结束时间 n_status=1 才有值.
 (最新的版本的判断是否能付款 n_stauts=1 并且判断当前时间小于 pay_end_time )
 is_pay 是否支付 0否1是, 可以根据这个字段来判断是否已经支付过
 **/
//开团数据
- (void)httpData {

    NSString *urlStr1 = [NSString stringWithFormat:@"%@order/queryByRoll?version=%@&token=%@&type=%zd&roll_code=%@",[NSObject baseURLStr],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN],[DataManager sharedManager].opengroup,[DataManager sharedManager].fightStatus];
    NSString *URL1 = [MyMD5 authkey:urlStr1];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.tableView.hidden = NO;bottomBtn.hidden = NO;
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1)
            {
                NSArray *data = responseObject[@"data"];
                
                NSString *user_id = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:USER_ID]];

                for (NSDictionary *dic in data) {
                    ShopDetailModel *model = [[ShopDetailModel alloc]init];
                    model.ID = dic[@"id"];
                    model.p_code = dic[@"r_code"];
                    model.add_time = dic[@"add_time"];
                    model.shop_pic = dic[@"shop_url"];
                    model.shop_name = dic[@"shop_name"];
                    model.shop_price = dic[@"shop_original"];
                    model.shop_group_price = dic[@"shop_roll"];
                    model.p_name = dic[@"user_name"];
                    model.order_code = dic[@"order_code"];
                    model.user_id = [NSString stringWithFormat:@"%@",dic[@"user_id"]];
                    if ([model.user_id isEqualToString:user_id]) {
                        payPrice = model.shop_group_price;
                        payOrderCode = model.order_code;
                    }
                    model.status = dic[@"status"];
                    model.active_end_time = dic[@"end_time"];
                    model.user_certificate = dic[@"user_portrait"];
                    model.shop_code = dic[@"shop_code"];
                    model.p_seq = dic[@"q"];
                    model.type = dic[@"type"];
                    model.color = dic[@"color"];
                    model.size = dic[@"size"];
                    model.price = dic[@"p_price"];
                    model.original_price = dic[@"elide_price"];
                    NSArray *shop_codeArr = [model.shop_code componentsSeparatedByString:@","];
                    NSArray *colorArr = [model.color componentsSeparatedByString:@"^"];
                    NSArray *sizeArr = [model.size componentsSeparatedByString:@"^"];
                    NSArray *nameArr = [model.shop_name componentsSeparatedByString:@","];
                    NSArray *priceArr = [model.price componentsSeparatedByString:@"^"];
                    NSArray *picArr = [model.shop_pic componentsSeparatedByString:@","];
                    NSArray *oldpriceArr = [model.original_price componentsSeparatedByString:@"^"];

                    for (int i=0; i<shop_codeArr.count; i++) {
                        ShopDetailModel *shopmodel = [[ShopDetailModel alloc]init];
                        shopmodel.shop_code = shop_codeArr[i];
                        shopmodel.shop_color = colorArr[i];
                        shopmodel.shop_size = sizeArr[i];
                        shopmodel.shop_name = nameArr[i];
                        shopmodel.shop_group_price = model.shop_group_price;
                        shopmodel.shop_se_price = priceArr[i];
                        shopmodel.shop_price = oldpriceArr.count>i?oldpriceArr[i]:@"";
                        shopmodel.shop_num = @"1";
                        shopmodel.def_pic = picArr[i];
                        [model.shopsArray addObject:shopmodel];
                    }
                    [self.shopArray addObject:model];
                }
                [self.tableView reloadData];

                if (data.count) {

                    MyLog(@"validHour:%@",[Signmanager SignManarer].validHour);
                    NSInteger is_pay = [responseObject[@"is_pay"]integerValue];
                    NSInteger n_status = [data[0][@"n_status"]integerValue];
                    
//                    NSTimeInterval time = n_status == 1
//                    ? ([data[0][@"pay_end_time"]doubleValue]-[responseObject[@"now"]doubleValue])/1000
//                    : (paytime+[Signmanager SignManarer].validHour.doubleValue-[responseObject[@"now"]doubleValue])/1000;
//                    countDownView.countDownTimeInterval = time;
//                    NSInteger num = [Signmanager SignManarer].rnum.integerValue >=  data.count ? [Signmanager SignManarer].rnum.integerValue - data.count : 0;
                    
                    NSInteger num = [Signmanager SignManarer].rnum.integerValue;
                    personLeastNum = [NSString stringWithFormat:@"%zd",num];
                    [personLeast setAttributedText:[NSString getOneColorInLabel:[NSString stringWithFormat:@"还差%@人，快邀请好友一起来免费领商品吧！",personLeastNum] ColorString:personLeastNum Color:tarbarrossred fontSize:ZOOM6(40)]];


                    //当拼团订单时间未到，而人数已满时，将分享蒙层去掉。
                    if (num<=0) {
                        [bottomBtn setTitle:@"邀请好友参团" forState:UIControlStateSelected];
                        bottomBtn.selected = YES;
                        headView_Img.hidden = headView_Label.hidden = YES;
                        personLeast.text = @"团员已满 ，付款人数未达到，请稍后。";
                    }
                    

                    if ( n_status==1 && is_pay==0 ) {
                        if ([responseObject[@"now"]doubleValue]<[data[0][@"pay_end_time"]doubleValue]) {
                            leastPayTime = ([data[0][@"pay_end_time"]doubleValue]-[responseObject[@"now"]doubleValue])/1000;
                            [self popView:GroupBuyPopType7];
                        }else
                            [self popView:GroupBuyPopType9];
                    }else if(time<=0 || [data[0][@"status"]integerValue]!=0) {
                        [bottomBtn setTitle:@"拼团已结束" forState:UIControlStateSelected];
                        bottomBtn.selected = YES;
                        [self changePopView:[data[0][@"status"]integerValue]];
                        
                    }
                    else if (time && personLeastNum.intValue)
                        [self popView:0];

                    
                    //分享链接
                    linkUrl = [NSString stringWithFormat:@"%@view/activity/pack.html?realm=%@&r_code=%@",[NSObject baseH5ShareURLStr],[[NSUserDefaults standardUserDefaults]objectForKey:USER_ID],data[0][@"r_code"]];


                }else {

                    [self creatEmptyView];
                }


            }
            else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];

    }];
}
//未参团数据
- (void)httpData2 {

    NSString *urlStr1 = [NSString stringWithFormat:@"%@order/queryByRollToCode?version=%@&token=%@&code=%@",[NSObject baseURLStr],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN],self.roll_code];
    NSString *URL1 = [MyMD5 authkey:urlStr1];

    kSelfWeak;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            self.tableView.hidden = NO;bottomBtn.hidden = NO;

            if ([responseObject[@"status"] intValue] == 1)
            {
                NSArray *data = responseObject[@"data"];

                //是否参过团
                BOOL joined = NO;

                NSString *user_id = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:USER_ID]];
                for (NSDictionary *dic in data) {
                    ShopDetailModel *model = [[ShopDetailModel alloc]init];
                    model.ID = dic[@"id"];
                    model.p_code = dic[@"r_code"];
                    model.add_time = dic[@"add_time"];
                    model.shop_pic = dic[@"shop_url"];
                    model.shop_name = dic[@"shop_name"];
                    model.shop_price = dic[@"shop_original"];
                    model.shop_group_price = dic[@"shop_roll"];
                    model.p_name = dic[@"user_name"];
                    model.order_code = dic[@"order_code"];
                    model.noPay = [NSString stringWithFormat:@"%@",dic[@"noPay"]];
                    
                    model.user_id = [NSString stringWithFormat:@"%@",dic[@"user_id"]];

                    if ([model.user_id isEqualToString:user_id]) {
                        joined = YES;
                        payPrice = model.shop_group_price;
                        payOrderCode = model.order_code;
                    }
                    model.status = dic[@"status"];
                    model.active_end_time = dic[@"end_time"];
                    model.user_certificate = dic[@"user_portrait"];
                    model.shop_code = dic[@"shop_code"];
                    model.p_seq = dic[@"q"];
                    model.type = dic[@"type"];
                    model.color = dic[@"color"];
                    model.size = dic[@"size"];
                    model.price = dic[@"p_price"];
                    model.original_price = dic[@"elide_price"];
                    NSArray *shop_codeArr = [model.shop_code componentsSeparatedByString:@","];
                    NSArray *colorArr = [model.color componentsSeparatedByString:@"^"];
                    NSArray *sizeArr = [model.size componentsSeparatedByString:@"^"];
                    NSArray *nameArr = [model.shop_name componentsSeparatedByString:@","];
                    NSArray *priceArr = [model.price componentsSeparatedByString:@"^"];
                    NSArray *picArr = [model.shop_pic componentsSeparatedByString:@","];
                    NSArray *oldpriceArr = [model.original_price componentsSeparatedByString:@"^"];

                    for (int i=0; i<shop_codeArr.count; i++) {
                        ShopDetailModel *shopmodel = [[ShopDetailModel alloc]init];
                        shopmodel.shop_code = shop_codeArr[i];
                        shopmodel.shop_color = colorArr[i];
                        shopmodel.shop_size = sizeArr[i];
                        shopmodel.shop_name = nameArr[i];
                        shopmodel.shop_se_price = priceArr[i];
                        shopmodel.shop_price = oldpriceArr.count>i?oldpriceArr[i]:@"";
                        shopmodel.shop_num = @"1";
                        shopmodel.noPay = model.noPay;
                        shopmodel.shop_from = @"11";
                        shopmodel.def_pic = picArr[i];
                        [model.shopsArray addObject:shopmodel];
                    }
                    [self.shopArray addObject:model];
                }
                [self.tableView reloadData];


                if (data.count) {

                    kSelfStrong;
                    
                    NSInteger num = [Signmanager SignManarer].rnum.integerValue;

                    NSInteger is_pay = [responseObject[@"is_pay"]integerValue];
                    NSInteger n_status = [data[0][@"n_status"]integerValue];
                    NSInteger status = [data[0][@"status"]integerValue];
                    //未参团
                    if (joined==NO) {

                        [strongSelf creatBootomView];
                        strongSelf.tableView.frame = CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar-ZOOM6(120));
                        [strongSelf->bottomBtn setTitle:@"你还没参与本次拼团~赶快参团吧~" forState:UIControlStateNormal];
                        [strongSelf->bottomBtn setTintColor:kSubTitleColor];
                        strongSelf->bottomBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
                        [strongSelf->bottomBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
                        strongSelf->bottomBtn.enabled = NO;

                        if (strongSelf->countDownView.countDownTimeInterval<=0) {
                            [strongSelf popView:GroupBuyPopType6];
                        }
                        else if (num<=0) {
                            [strongSelf popView:GroupBuyPopType5];
                        }
                        
                    }else if (n_status == 1 && is_pay==0 ) {
                        if ([responseObject[@"now"]doubleValue]<[data[0][@"pay_end_time"]doubleValue]) {
                            [self popView:GroupBuyPopType7];
                        }else
                            [self popView:GroupBuyPopType9];
                    }
                    else {

                        strongSelf -> personLeastNum = [NSString stringWithFormat:@"%zd",num];
                        [strongSelf -> personLeast setAttributedText:[NSString getOneColorInLabel:[NSString stringWithFormat:@"还差%@人，快邀请好友一起来免费领商品吧！",personLeastNum] ColorString:personLeastNum Color:tarbarrossred font:[UIFont boldSystemFontOfSize:ZOOM6(40)]]];
                        
                        [self fightChangePopView:status];
                    }

                    //分享链接
                   strongSelf -> linkUrl = [NSString stringWithFormat:@"%@view/activity/pack.html?realm=%@&r_code=%@",[NSObject baseH5ShareURLStr],[[NSUserDefaults standardUserDefaults]objectForKey:USER_ID],data[0][@"r_code"]];

                }else {

                    [self creatEmptyView];
                }

            }
            else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];

    }];
}

#pragma mark - 1️⃣➢➢➢ UITableViewDataSource、 UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return ZOOM6(110);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    CFBaseTableFooterview *footerView = [CFBaseTableFooterview FooterViewWithTableView:tableView];
    ShopDetailModel *model = self.shopArray[section];
    NSString *str = @"实付：";
    footerView.leftLabel.attributedText = [NSString getOneColorInLabel:[NSString stringWithFormat:@"%@¥%@",str,model.shop_group_price] ColorString:[NSString stringWithFormat:@"¥%@",model.shop_group_price] Color:tarbarrossred fontSize:ZOOM6(30)];
    return footerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return ZOOM6(120);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    CFBaseTableHeaderview *headerView = [CFBaseTableHeaderview headerViewWithTableView:tableView];
    ShopDetailModel *model = self.shopArray[section];

    headerView.leftLabel.text = model.type.integerValue==1 ? @"拼团发起人:" : @"拼团参与人:";
    headerView.userIco.hidden = model.type.integerValue!=1;

    NSURL *imgUrl ;
    if ([model.user_certificate hasPrefix:@"http"]) {
        imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.user_certificate]];
    } else {
        if ([model.user_certificate hasPrefix:@"/"]) {
            imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],[model.user_certificate substringFromIndex:1]]];
        } else {
            imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.user_certificate]];
        }
    }
//    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@!180",[NSObject baseURLStr_Upy],model.user_certificate]];
    [headerView.userImg sd_setImageWithURL:imgUrl completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    headerView.userName.text = model.p_name;
    headerView.time.text = [MyMD5 getTimeToShowWithTimestamp:model.add_time];

    return headerView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.shopArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ShopDetailModel *model = self.shopArray[section];
    return model.shopsArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ZOOM6(30)+ZOOM6(140);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    AffirmOrderCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];

    ShopDetailModel *model = self.shopArray[indexPath.section];
    ShopDetailModel *shopmodel = model.shopsArray[indexPath.row];
    shopmodel.isTM = [NSString stringWithFormat:@"%zd",self.isTM];
//    cell.shop_model = model;
    
    [cell loadDataModel:shopmodel];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopDetailModel *model = self.shopArray[indexPath.section];
    ShopDetailModel *shopmodel = model.shopsArray[indexPath.row];
    
    if(self.isTM == 1)
    {
//        SpecialShopDetailViewController *specialshopdetail = [[SpecialShopDetailViewController alloc]init];
//        specialshopdetail.shop_code = shopmodel.shop_code;
//        [self.navigationController pushViewController:specialshopdetail animated:YES];
        
        ShopDetailViewController *shopdetail = [[ShopDetailViewController alloc]init];
        shopdetail.isTM = YES;
        shopdetail.shop_code = shopmodel.shop_code;
        [self.navigationController pushViewController:shopdetail animated:YES];
        
    }else{
        ShopDetailViewController *shopdetail = [[ShopDetailViewController alloc]init];
        shopdetail.shop_code = shopmodel.shop_code;
        [self.navigationController pushViewController:shopdetail animated:YES];
    }
}
#pragma mark - 1️⃣➢➢➢ Share  分享
- (void)httpShareData {
    NSString *url= [NSString stringWithFormat:@"%@paperwork/paperwork.json",[NSObject baseURLStr_Upy]];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;

    kSelfWeak;
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject!=nil) {
            kSelfStrong;
            strongSelf->shareDiscription=responseObject[@"ptgfx"][@"text"];
            strongSelf->shareTitle=responseObject[@"ptgfx"][@"title"];
            strongSelf->imgPathUrl=[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy], responseObject[@"ptgfx"][@"icon"]];
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];
}
- (void)collecLike:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    GroupBuyPopView *view = [[GroupBuyPopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) popType:GroupBuyPopType1];
    kSelfWeak;
    view.btnBlok = ^(NSInteger index) {
        [weakSelf goShare:index imgUrl:@"" title:@"" link:@""];
    };
    view.num=personLeastNum;
    [view show];
}
- (void)goShare:(NSInteger)tag imgUrl:(NSString *)imgUrl title:(NSString *)title link:(NSString *)link
{

    if(!self.shopArray.count)
    {
        return;
    }
    ShopDetailModel *model = self.shopArray[0];
    
    if(!model.shopsArray.count)
    {
        return;
    }
    ShopDetailModel *shopmodel = model.shopsArray[0];
    
    if(shopmodel.def_pic)
    {
        NSMutableString *code = [NSMutableString stringWithString:shopmodel.shop_code];
        
        NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
        MyLog(@"supcode =%@",supcode);
        
        imgPathUrl = [NSString stringWithFormat:@"%@/%@/%@",supcode,shopmodel.shop_code,shopmodel.def_pic];
    }
    
    MiniShareManager *minishare = [MiniShareManager share];
    
    NSString *image = [NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_Upy],imgPathUrl];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *realm = [user objectForKey:USER_ID];
    NSString *path  = [NSString stringWithFormat:@"/pages/shouye/detail/detail?shop_code=%@&user_id=%@&roll_code=%@",shopmodel.shop_code,realm,self.roll_code];
    
    [TypeShareModel getTypeCodeWithShop_code:shopmodel.shop_code success:^(TypeShareModel *data) {
        
        if(data.status == 1)
        {
            NSString *type2 = [NSString stringWithFormat:@"%@",data.type2];
            
            SqliteManager *manager = [SqliteManager sharedManager];
            TypeTagItem *item = [manager getSuppLabelItemForId:data.supp_label_id];
        
            NSString *sqsupp_label = @"";
            if(item != nil)
            {
                sqsupp_label = item.class_name;
            }
            
            
            NSString *supp_label = (sqsupp_label == nil || [sqsupp_label isEqual:[NSNull null]])?@"衣蝠":sqsupp_label;
            NSString *sharetitle = @"";
            if(![type2 isEqual:[NSNull null]] && ![type2 isEqualToString:@"(null)"] && type2 != nil)
            {
                sharetitle = [NSString stringWithFormat:@"快来%.1f元拼【%@正品%@】专柜价%.1f元！",[model.shop_group_price floatValue],supp_label,type2,[shopmodel.shop_price floatValue]];
            }else{
                sharetitle = [NSString stringWithFormat:@"快来%.1f元拼【%@】专柜价%.1f元！",[model.shop_group_price floatValue],shopmodel.shop_name,[shopmodel.shop_price floatValue]];
            }
           
            
            minishare.delegate = self;
            [minishare shareAppWithType:MINIShareTypeWeixiSession Image:image Title:sharetitle Discription:nil WithSharePath:path];
            
            kWeakSelf(self);
            minishare.MinishareSuccess = ^{
                [MBProgressHUD show:@"分享成功" icon:nil view:weakself.view];
            };
            
        }
        
    }];
    
}
- (void)DShareManagerStatus:(SHARESTATE)shareStatus withType:(NSString *)type {
    if(shareStatus != STATE_BEGAN){
        if (shareStatus == STATE_SUCCESS) {
            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
            [mentionview showLable:@"分享成功" Controller:self];
//            [self shareSuccess:YES];

        }else if (shareStatus == STATE_FAILED|| shareStatus==STATE_CANCEL) {
            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
            [mentionview showLable:@"分享失败" Controller:self];
        }
    }
}
#pragma mark - 1️⃣➢➢➢ 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat bottomHeight = [DataManager sharedManager].opengroup==1 ? ZOOM6(120) : 0;
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar-bottomHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[AffirmOrderCell class] forCellReuseIdentifier:@"cell"];
        _tableView.tableHeaderView = [self HeadView:[DataManager sharedManager].opengroup==1];
    }
    return _tableView;
}


/**
 参团的情况下  不显示还差多少人

 @param normal NO代表 未参团
 @return <#return value description#>
 */
- (UIView *)HeadView:(bool)normal {
    
    CGFloat headviewHeigh = is_vip ? ZOOM6(300):ZOOM6(200);
    CGFloat countViewHeigh = is_vip ? ZOOM6(60):ZOOM6(0);
    CGFloat countViewY = is_vip ? ZOOM6(40) : ZOOM6(0);
    CGFloat personLeastY = is_vip ? ZOOM6(130):ZOOM6(35);
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, normal?headviewHeigh:ZOOM6(240))];
    headView.backgroundColor = [UIColor whiteColor];
    CLCountDownView *countView =  [[CLCountDownView alloc] initWithFrame:CGRectMake(kScreenWidth/2-ZOOM6(150)+ZOOM6(70), countViewY, ZOOM6(300), countViewHeigh) fromHour:YES];
    countView.delegate = self;
    countView.themeColor = [UIColor blackColor];
    countView.textTimeColor = [UIColor whiteColor];
    countView.countDownType=CountDownUseChar;
    [headView addSubview:countView];
    countDownView = countView;
    UILabel *lastTime = [[UILabel alloc]init];
    lastTime.text = is_vip ? @"剩余:" : @"";
    lastTime.textColor = kMainTitleColor;
    lastTime.font = kFont6px(28);
    [headView addSubview:lastTime];
    
    [countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lastTime.mas_right).offset(ZOOM6(24));
        make.centerX.equalTo(headView.mas_centerX).offset(ZOOM6(50));
        make.top.offset(ZOOM6(40));
        make.width.offset(ZOOM6(300));
        make.height.offset(countViewHeigh);
    }];
    [lastTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(countView.mas_top);
        make.height.equalTo(countView.mas_height);
    }];
    
    if (normal) {
        headView_Img = [[UIImageView alloc]init];
        [headView addSubview:headView_Img];
        headView_Label = [[UILabel alloc]init];
        headView_Label.textColor = tarbarrossred;
        headView_Label.font =  [UIFont boldSystemFontOfSize:ZOOM6(32)];
        [headView addSubview:headView_Label];
        personLeast = [[UILabel alloc]init];
        personLeast.textColor = kMainTitleColor;
        personLeast.font = kFont6px(32);
       
        [headView addSubview:personLeast];
        [headView_Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(headView).offset(ZOOM6(20));
            make.left.equalTo(headView_Img.mas_right).offset(ZOOM6(10));
            make.top.equalTo(headView_Img);
        }];
        [headView_Img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.offset(ZOOM6(32));
            make.top.equalTo(countView.mas_bottom).offset(ZOOM6(30));
        }];
        [personLeast mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headView).offset(personLeastY);
            make.centerX.equalTo(headView);
        }];
    }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, headView.height-ZOOM6(80), kScreenWidth, 0.5)];
    line.backgroundColor = kTableLineColor;
    [headView addSubview:line];
    UILabel *label2 = [[UILabel alloc]init];
    label2.textColor = kMainTitleColor;
    label2.font = kFont6px(28);
    label2.text = @"拼团须知";
    [headView addSubview:label2];
    UILabel *label3 = [[UILabel alloc]init];
    label3.textColor = kSubTitleColor;
    label3.font = kFont6px(24);
    label3.text = @"・邀请好友 ・好友免费领 ・团长免费领";
    label3.textAlignment = NSTextAlignmentRight;
    [headView addSubview:label3];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(ZOOM6(80));
        make.left.offset(ZOOM6(30));
        make.bottom.equalTo(headView);
    }];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(label2);
        make.top.equalTo(label2);
        make.right.offset(-ZOOM6(30));
    }];
    
    return headView;
}

- (void)creatBootomView {
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-ZOOM6(120)+1, kScreenWidth, 0.5)];
    line.backgroundColor = kNavLineColor;
    [self.view addSubview:line];

    bottomBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    bottomBtn.frame = CGRectMake(ZOOM6(20), kScreenHeight-ZOOM6(100), kScreenWidth-ZOOM6(40), ZOOM6(80));
    [bottomBtn setTintColor:[UIColor whiteColor]];
    bottomBtn.layer.cornerRadius = 5;
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
    NSString *title = @"邀请好友免费领";
    [bottomBtn setTitle:title forState:UIControlStateNormal];
    [bottomBtn setBackgroundImage:[UIImage imageWithColor:tarbarrossred] forState:UIControlStateNormal];
    [bottomBtn setTitle:@"拼团已结束" forState:UIControlStateSelected];
    [bottomBtn setTitle:@"拼团已结束" forState:UIControlStateSelected|UIControlStateHighlighted];
    [bottomBtn setBackgroundImage:[UIImage imageWithColor:kTextColor] forState:UIControlStateSelected];
    [bottomBtn setBackgroundImage:[UIImage imageWithColor:kTextColor] forState:UIControlStateSelected|UIControlStateHighlighted];

    [bottomBtn addTarget:self action:@selector(collecLike:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];

}
- (NSMutableArray *)shopArray {
    if (!_shopArray) {
        _shopArray = [NSMutableArray array];
    }
    return _shopArray;
}
- (DShareManager*)shareManager
{
    if(_shareManager == nil)
    {
        AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        [app shardk];
        _shareManager = [DShareManager share];
        _shareManager.delegate = self;
//        kSelfWeak;
//        _shareManager.ShareSuccessBlock=^{
//            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
//            [mentionview showLable:@"分享成功" Controller:weakSelf];
////            [weakSelf shareSuccess:YES];
//        };
//        _shareManager.ShareFailBlock = ^{
//
////            if(weakSelf.ISInvit)
////            {
////                [weakSelf shareSuccess:NO];//集赞邀请没有分享成功也算完成任务
////            }else{
//                NavgationbarView *mentionview = [[NavgationbarView alloc]init];
//                [mentionview showLable:@"分享失败" Controller:weakSelf];
////            }
//        };
    }
    return _shareManager;
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
