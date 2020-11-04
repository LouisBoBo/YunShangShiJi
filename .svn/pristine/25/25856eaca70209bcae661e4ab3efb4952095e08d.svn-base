//
//  AskforSaleViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/7/17.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "AskforSaleViewController.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "NavgationbarView.h"
#import "MyMD5.h"
#import "OrderModel.h"
#import "MJRefresh.h"

#import "OrderDetailViewController.h"
#import "OrderTableViewCell.h"
#import "RefundAndReturnViewController.h"
#import "RerundViewController.h"
#import "LoginViewController.h"
#import "TFPopBackgroundView.h"

@interface AskforSaleViewController ()
{
    //商品列表
    UITableView *_MytableView;
    
    
    
    //商品总页数
    NSString *_pageCount;

    OrderModel *_Ordermodel;
}
@end

@implementation AskforSaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _currentpage=1;
    _pageCount=@"1";
    _dataArray=[NSMutableArray array];
    
    [self creatView];
    
    
    _currentpage = 1;
    [self requestHttp:_currentpage];
   
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [_dataArray removeAllObjects];


    Myview.hidden=YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
}

-(void)creatBackview
{
    //没有订单的相关界面
    
    UIView *backview=[[UIView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kApplicationWidth, kApplicationHeight-Height_NavBar+kUnderStatusBarStartY)];
    backview.backgroundColor = [UIColor whiteColor];
    backview.tag=8789;
    
    
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(kApplicationWidth/2-40, 50, 80, 150)];
    if (kScreenHeight>=568) {
        imageview.frame = CGRectMake(kApplicationWidth/2-40, kScreenHeight/4-75, 80, 150);
    }
    imageview.image=[UIImage imageNamed:@"组-32"];
    [backview addSubview:imageview];
    
    for(int i=0;i<2; i++)
    {
        
        UILabel *marklable=[[UILabel alloc]initWithFrame:CGRectMake(0, imageview.frame.origin.y+imageview.frame.size.height+ 20 +40*i, backview.frame.size.width, 40)];
        marklable.textAlignment=NSTextAlignmentCenter;
        //        marklable.font=[UIFont systemFontOfSize:ZOOM(46)];
        if(i==0)
        {
            marklable.text=@"你还没有相关订单";
            
        }else{
            marklable.text=@"可以去看看有哪些想买的";
            marklable.textColor=kTextGreyColor;
        }
        
        [backview addSubview:marklable];
        
    }
    
    UIButton *shoppintbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    shoppintbtn.frame=CGRectMake(50, imageview.frame.origin.y+imageview.frame.size.height+120, kApplicationWidth-100, 40);
    [shoppintbtn setTitle:@"随便逛逛" forState:UIControlStateNormal];
    //    shoppintbtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM(46)];
    [shoppintbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shoppintbtn.layer.borderWidth=1;
    shoppintbtn.layer.cornerRadius = 5;
    [backview addSubview:shoppintbtn];
    
    [shoppintbtn addTarget:self action:@selector(shoppinggo:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backview];
    
}
#pragma mark 逛逛
-(void)shoppinggo:(UIButton*)sender
{
    // 跳转到衣服
    Mtarbar.selectedIndex=0;
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    
    
}
#pragma mark 网络请求(买单)
-(void)requestHttp:(NSInteger)page
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    
    NSString *cutpage=[NSString stringWithFormat:@"%ld",(long)page];
    
    NSString *url=[NSString stringWithFormat:@"%@order/getBuyOrder?version=%@&token=%@&page=%@&status=-1&order=desc",[NSObject baseURLStr],VERSION,token,cutpage];
    
    NSString *URL=[MyMD5 authkey:url];
    
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        MyLog(@"responseObject is %@",responseObject);
        if (_currentpage==1) {
            [_dataArray removeAllObjects];
        }
        
        //responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            _pageCount=responseObject[@"pageCount"];
            
            if(str.intValue==1)
            {
                
                NSArray *arr=responseObject[@"orders"];
                for(NSDictionary *dic in arr)
                {
                    OrderModel *model=[[OrderModel alloc]init];
                    
                    model.is_kick=dic[@"is_kick"];
                    model.add_time=dic[@"add_time"];
                    model.address=dic[@"address"];
                    model.back=dic[@"back"];
                    model.consignee=dic[@"consignee"];
                    model.free=dic[@"free"];
                    model.lasttime=dic[@"last_time"];
                    model.now=responseObject[@"now"];
                    model.user_id=dic[@"user_id"];
                    model.order_pic=dic[@"order_pic"];
                    model.phone=dic[@"phone"];
                    model.message=dic[@"order_name"];
                    model.status=dic[@"status"];
                    model.order_code=dic[@"order_code"];
                    model.order_price=dic[@"order_price"];
                    model.shop_price=dic[@"order_price"];

                    model.shop_num=dic[@"shop_num"];
                    model.address=dic[@"address"];
                    model.consignee=dic[@"consignee"];
                    model.phone=dic[@"phone"];
                    model.change=dic[@"status"];
                    model.order_code=dic[@"order_code"];
                    model.order_name=dic[@"order_name"];
                    
                    model.bak=dic[@"bak"];
                    model.shop_from=dic[@"shop_from"];
                    model.postage=dic[@"postage"];
                    model.postcode=dic[@"postcode"];
                    
                    model.issue_status=dic[@"issue_status"];
                    model.issue_code=dic[@"issue_code"];
                    model.requestNow_time=responseObject[@"now"];
                    
                    model.order_price=dic[@"pay_money"];

                    
                    model.is_free=[[NSString stringWithFormat:@"%@",dic[@"is_free"]]integerValue];
                    model.is_roll=[[NSString stringWithFormat:@"%@",dic[@"is_roll"]]integerValue];
                    model.whether_prize = [NSString stringWithFormat:@"%@",dic[@"whether_prize"]];
                    model.roll_code=dic[@"roll_code"];
                    
                    if(![dic[@"page4_shop"] isEqual:[NSNull null]])
                    {
                        model.isTM = [NSString stringWithFormat:@"%@",dic[@"page4_shop"]];
                    }
                    
                    NSArray *brr=dic[@"orderShops"];
                    for(NSDictionary *dicc in brr)
                    {
                        OrderModel *shopmodel=[[OrderModel alloc]init];
                        
                        shopmodel.shop_color=dicc[@"color"];
                        shopmodel.ID=dicc[@"id"];
                        shopmodel.order_code=dicc[@"order_code"];
                        shopmodel.shop_code=dicc[@"shop_code"];
                        shopmodel.shop_name=dicc[@"shop_name"];
                        shopmodel.shop_num=dicc[@"shop_num"];
                        shopmodel.shop_pic=dicc[@"shop_pic"];
                        shopmodel.shop_price=dicc[@"shop_price"];
                        shopmodel.shop_size=dicc[@"size"];
                        shopmodel.suppid=dicc[@"supp_id"];
                        shopmodel.orderShopStatus=dicc[@"status"];
                        shopmodel.change=dicc[@"change"];
                        
                        shopmodel.status=dic[@"status"];
                        shopmodel.lasttime=dicc[@"last_time"];
                        shopmodel.voucher_money=[NSString stringWithFormat:@"%@",dicc[@"voucher_money"]];
                        shopmodel.issue_status = dicc[@"issue_status"];

                        model.orderShopStatus=dicc[@"status"];
                        model.change=dicc[@"change"];
                        model.status=dic[@"status"];
                        shopmodel.postage=dic[@"postage"];
                        shopmodel.is_kick=dic[@"is_kick"];
                        
                        if(![dic[@"page4_shop"] isEqual:[NSNull null]])
                        {
                            shopmodel.isTM = [NSString stringWithFormat:@"%@",dic[@"page4_shop"]];
                        }
                        [model.shopsArray addObject:shopmodel];
                        
                    }
                    
                    if(model.status.intValue !=1 && model.shop_from.intValue != 10)
                    {
                        _Ordermodel=model;
                        [_dataArray addObject:model];
                    }
                }
                
                if (_dataArray.count==0) {
                    [self creatBackview];
                }
                
            }
            else if(str.intValue == 10030){//没登录状态
                
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud removeObjectForKey:USER_TOKEN];
                
                LoginViewController *login=[[LoginViewController alloc]init];
                
                login.tag=1000;
                login.loginStatue = @"10030";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
                
            }
            else{
                
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:message Controller:self];
            }
            
            [_MytableView reloadData];

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        
        if(page<1)
        {
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
}


-(void)creatView
{
   
    _MytableView=[[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kApplicationWidth, kApplicationHeight-Height_NavBar+kUnderStatusBarStartY) style:UITableViewStyleGrouped];
    _MytableView.backgroundColor=[UIColor whiteColor];
    _MytableView.dataSource=self;
    _MytableView.delegate=self;
    _MytableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_MytableView];
    
    [_MytableView registerNib:[UINib nibWithNibName:@"OrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    //刷新
    [self addheadFresh];
    [self addfootFresh];
    
    [self creatHeadview];
}

-(void)creatHeadview
{
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    headview.backgroundColor=[UIColor whiteColor];

    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 46, 46);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"请选择退款商品";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];

}

#pragma mark 下拉刷新
-(void)addheadFresh
{
    __weak typeof(self) weakself = self;
    __weak UITableView *weaktable = _MytableView;
    [_MytableView addHeaderWithCallback:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            

//            if(! (_currentpage > _pageCount.intValue))
//            {
           weakself.currentpage = 1;
//            [weakself.dataArray removeAllObjects];
                [weakself requestHttp:weakself.currentpage];
//            }else{
//                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
//                [mentionview showLable:@"已经没有更多" Controller:self];
//            }
            
            // 结束刷新
            [weaktable headerEndRefreshing];
        });
    }];
    
//    [_MytableView headerBeginRefreshing];
}

#pragma mark 上拉刷新
-(void)addfootFresh
{
    __weak typeof(self) weakself = self;
    __weak UITableView *weaktable = _MytableView;
    [_MytableView addFooterWithCallback:^{
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            weakself.currentpage++;
            if(! (weakself.currentpage > _pageCount.intValue))
            {
                [weakself requestHttp:weakself.currentpage];
                
            }else{
                
//                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
//                [mentionview showLable:@"已经没有更多" Controller:self];
                
            }
            // 结束刷新
            [weaktable footerEndRefreshing];
        });
        
    }];
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /***   用户每日首次申请售后弹弹窗3.5.9   ***/
    NSDate *date = [[NSUserDefaults standardUserDefaults]objectForKey:@"returnMoneyRemindView"];
    if (![[MyMD5 compareDate:date]isEqualToString:@"今天"]) {
        [[NSUserDefaults standardUserDefaults]setObject:[NSDate date] forKey:@"returnMoneyRemindView"];
        [self returnMoneyRemindView];
        return;
    }

    OrderModel *model=_dataArray[indexPath.section];
    
    OrderModel *model1;
     if(model.shop_from.intValue==4||model.shop_from.intValue==6){
         return;
    }
    if (model.shopsArray.count!=0) {
        model1 =  model.shopsArray[indexPath.row];
        if (model1.orderShopStatus.intValue!=0) {
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"该商品已申请过售后" Controller:self];
            return;
        }
    }else
        model1=model;
   
    
    /*1待付款2代发货3待收货4待评价5退款中6已完结7延长收货9取消订单
     */
    //%@ %@  %@",model1.status,model.now,model1.lasttime);
     if (model.shop_from.integerValue==2)//会员商品
    {
        if(model.status.intValue==2){  //待发货的
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"会员商品待发货状态不能申请售后" Controller:self];
        }else{
            RerundViewController *rerund=[[RerundViewController alloc]init];
            rerund.shop_from=model.shop_from;
            rerund.orderPrice=model.order_price;
            rerund.ordermodel=model1;
            rerund.order_code=model.order_code;
            rerund.titletext=@"申请换货";
            
            [self.navigationController pushViewController:rerund animated:YES];
        }
    }
     else if (model.is_kick.integerValue==0&&model1.lasttime!=nil&&![model1.lasttime isEqual:[NSNull null]]&&model.now.floatValue>=model1.lasttime.floatValue)
    {
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"该商品已错过申请售后的时间" Controller:self];
        
    }else if (model.shop_from.integerValue==4){
        if (model.issue_status.integerValue==0||model.issue_status.integerValue==1||model.issue_status.integerValue==2||model.issue_status.integerValue==4) {
            return;
        }
        RefundAndReturnViewController *refund=[[RefundAndReturnViewController alloc]init];
        refund.shop_from=model.shop_from;
        refund.ordermodel=model1;
        refund.orderPrice=model.order_price;
        [self.navigationController pushViewController:refund animated:YES];
        
    }
    else if (model.status.intValue==2)//待发货的直接退款
    {
        
        RerundViewController *rerund=[[RerundViewController alloc]init];
        rerund.shop_from=model.shop_from;
        rerund.orderPrice=model.order_price;
        rerund.Order_status=model.status;
        rerund.ordermodel=model1;
        rerund.order_code=model.order_code;
        rerund.titletext=@"申请退款";
        
        [self.navigationController pushViewController:rerund animated:YES];
        
    }
    else if(model.status.intValue==3 || model.status.intValue==4 || model.status.intValue==7 || model.status.intValue==5 || model.status.intValue==6){
        
        RefundAndReturnViewController *refund=[[RefundAndReturnViewController alloc]init];
        refund.shop_from=model.shop_from;
        refund.ordermodel=model1;
        refund.orderPrice=model.order_price;
        [self.navigationController pushViewController:refund animated:YES];
        
    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    OrderModel *model=_dataArray[section];
    if (model.shop_from.intValue==1||model.shop_from.intValue==4||model.shop_from.intValue==6) {
        return 1;
    }
    return model.shopsArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

#pragma mark footview 高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    OrderModel *model=_dataArray[section];
    if(model.status.intValue==6 || model.status.intValue==9)
    {
        return 30;
    }
    
    return 30+ZOOM(32);
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    OrderModel *model=_dataArray[section];
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 30+ZOOM(32))];
    view.backgroundColor=[UIColor whiteColor];
//    UILabel *pricelable=[[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth-100-ZOOM(42), 5, 100, 20)];
//    pricelable.textAlignment=NSTextAlignmentRight;
//    pricelable.font=[UIFont systemFontOfSize:ZOOM(46)];
//    pricelable.text=[NSString stringWithFormat:@"实付:¥%@",model.order_price];;
    
    UILabel *countlable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(42), 5, kScreenWidth-ZOOM(42)*2, 20)];
    countlable.textAlignment=NSTextAlignmentRight;
    countlable.font=[UIFont systemFontOfSize:ZOOM(46)];
    if (model.shop_from.intValue==4||model.shop_from.intValue==6) {
        countlable.text=[NSString stringWithFormat:@"共1件商品   实付:¥%.2f",model.order_price.floatValue];
    }else
        countlable.text=[NSString stringWithFormat:@"共%@件商品    实付:¥%.2f",model.shop_num,model.order_price.floatValue];
    
    //状态按钮的数量
//    int statecount;
    //状态按钮的title
//    NSArray *titlearr;
    
    //订单状态
    NSString *statue;
    statue=model.status;
//    if([_titlestring isEqualToString:@"已买商品"])
    {
        switch (statue.intValue) {
            case 1:
//                statecount=3;
//                titlearr=@[@"付款",@"取消订单",@"联系卖家"];
                break;
            case 2:
//                statecount=2;
//                titlearr=@[@"提醒发货",@"退款"];
                break;
            case 3:
//                statecount=2;
//                titlearr=@[@"确认收货",@"查看物流"];
                break;
            case 4:
//                statecount=2;
//                titlearr=@[@"评价订单",@"删除订单"];
                break;
            case 5:
//                statecount=1;
//                titlearr=@[@"钱款去向"];
                break;
            case 6:
//                statecount=0;
                
                break;
            case 7:
//                statecount=2;
//                titlearr=@[@"确认收货",@"查看物流"];
                break;
            case 8:
//                statecount=1;
//                titlearr=@[@"钱款去向"];
                break;
            case 9:
//                statecount=0;
                
                break;
            default:
                break;
        }
    }
    
    
   /*
    for(int i=0; i<statecount; i++)
    {
        UIButton *statebutton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        statebutton.frame=CGRectMake(kApplicationWidth-90-90*i, 30, 80, 30);
        statebutton.backgroundColor=[UIColor blackColor];
        statebutton.tag=10000*(section+1)+i;
        [statebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [statebutton setTitle:titlearr[i] forState:UIControlStateNormal];
        [statebutton addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
        
//        [view addSubview:statebutton];
    }
  */
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, view.frame.size.height-1, kApplicationWidth, 1)];
    line.backgroundColor=lineGreyColor;
    [view addSubview:line];
    
//    [view addSubview:pricelable];
    [view addSubview:countlable];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ZOOM(62)*2+ZOOM(350);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell=[[OrderTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    if(_dataArray)
    {
        ShopDetailModel *model=_dataArray[indexPath.section];
        
        if (model.shop_from.intValue==4||model.shop_from.intValue==6) {
            [cell refreshIndianaData:model];
            cell.zeroLabel.hidden=YES;
            cell.color_size.hidden=YES;
        }
        if (model.shop_from.intValue==1) {
            [cell refreshZeroData:model];
            cell.zeroLabel.hidden=NO;
            cell.color_size.hidden=YES;
            
        }else if(model.shopsArray.count)
        {
            ShopDetailModel *shopmodel=model.shopsArray[indexPath.row];
            //%@",shopmodel.shop_pic);
            [cell refreshData:shopmodel];
            cell.zeroLabel.hidden=YES;
            cell.color_size.hidden=NO;
        }
//        if(model.shopsArray.count)
//        {
//            OrderModel *shopmodel=model.shopsArray[indexPath.row];
//            [cell refreshAfterSaleData:shopmodel];
//        }
        
        /*
        //订单状态
        NSString *statue;
        statue=model.status;
        if(statue !=nil)
        {
            switch (statue.intValue) {
                case 1:
                    cell.statue.text=@"待付款";
                    break;
                case 2:
                    cell.statue.text=@"待发货";
                    break;
                case 3:
                    cell.statue.text=@"待收货";
                    break;
                case 4:
                    cell.statue.text=@"待评价";
                    break;
                case 5:
                    cell.statue.text=@"追评";
                    break;
                case 6:
                    cell.statue.text=@"已经完结";
                    
                    break;
                case 7:
                    cell.statue.text=@"已延长收货";
                    break;
                case 8:
                    cell.statue.text=@"退款成功";
                    break;
                case 9:
                    cell.statue.text=@"已取消";
                    
                    break;
                default:
                    break;
            }
        }
        */
    }
    
   
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}


/**
 用户每日首次申请售后弹弹窗3.5.9
 */
- (void)returnMoneyRemindView {
    TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] initWithTitle:@"温馨提示" message:@"您确实不喜欢这个宝贝吗？非质量问题随意退款超过3次，7日内不能参与0元购。所有抽奖类任务中奖率减半。提现提升至60元起提。请不要随意退款哦。" showCancelBtn:NO leftBtnText:@"我再想想" rightBtnText:@"不退了"];
    popView.textAlignment=NSTextAlignmentCenter;
    popView.isManualDismiss = YES;

    kSelfWeak;
    [popView showCancelBlock:^{
        [popView dismissAlert:YES];
    } withConfirmBlock:^{
        [popView dismissAlert:YES];
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    } withNoOperationBlock:^{

    }];

}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
