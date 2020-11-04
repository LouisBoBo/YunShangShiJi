//
//  AffirmOrderViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/5/25.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//
/*
  经过多个版本的修改   目前为  夺宝下单界面
  新增  1元购下单界面
 **/

#import "AffirmOrderViewController.h"
#import "OrderDetailTableViewCell.h"
#import "ShopDetailViewController.h"
#import "AddAdressViewController.h"
#import "AdressViewController.h"
#import "PaypasswordViewController.h"
#import "HZAreaPickerView.h"
#import "AccountAddressViewController.h"
#import "AddAdressViewController.h"
#import "LoginViewController.h"

#import "SCarCell.h"
#import "TFSetPaymentPasswordViewController.h"
#import "QRCodeGenerator.h"
#import "ProduceImage.h"

#import "VoucherModel.h"

#import "GlobalTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "MyMD5.h"
#import "OrderDetailModel.h"
#import "UIImageView+WebCache.h"
#import "NavgationbarView.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AppDelegate.h"
#import "DShareManager.h"
#import "UPPayPlugin.h"
#import "AppDelegate.h"
#import "WXApi.h"

#import "WXApi.h"
#import "WXApiObject.h"
#import "payRequsestHandler.h"
#import "TFPayPasswordView.h"
//#import "PaystyleViewController.h"
#import "TFPaystyleViewController.h"
#import "TFReceivingAddressViewController.h"
#import "BuySuccessViewController.h"
#import "IntelligenceViewController.h"
#import "PayFailedViewController.h"
#import "DXAlertView.h"
#import "TFUserCardViewController.h"

#import "NewSigninViewController.h"
#import "ZeroShopShareViewController.h"
#import "TFOldPaymentViewController.h"
//#import "ComboShopDetailViewController.h"
#import "ChoseShareViewController.h"
#import "MyCardModel.h"
#import "AddressModel.h"
#import "TFDailyTaskView.h"
#import "TFNoviceTaskView.h"
#import "TFNoviceTaskView.h"
#import "BoundPhoneVC.h"
#import "TFPopBackgroundView.h"
#import "OneLuckdrawViewController.h"

#define KBtn_width        200
#define KBtn_height       80
#define KXOffSet          (self.view.frame.size.width - KBtn_width) / 2
#define KYOffSet          80
#define integralRate 50
#define left ZOOM(62)
#define right ZOOM(42)
#define cellChangNumTag  9999

#define kVCTitle          @"TN测试"
#define kBtnFirstTitle    @"获取订单，开始测试"
#define kWaiting          @"正在获取TN,请稍后..."
#define kNote             @"提示"
#define kConfirm          @"确定"
#define kErrorNet         @"网络错误"
#define kResult           @"支付结果：%@"


#define kMode             @"01"
#define kConfigTnUrl      @"http://202.101.25.178:8080/sim/app.jsp?user=%@"
#define kNormalTnUrl      @"http://202.101.25.178:8080/sim/gettn"

#define HEIGHT(height) [self heightCoefficient:height]

@interface AffirmOrderViewController ()<UITextFieldDelegate>
{
    UITableView *_ShopTableView;         //商品列表
    UIView *_addressView;
    NSMutableArray *_ShopArray;         //商品列表数据源
    NSMutableArray *_DeliverArray;      //收货地址
    
    UILabel *_numlable;
    BOOL _isnotifation;                 //是否监听到通知
    BOOL _isShare;
    //    enum WXScene _scene;
    NSString *Token;
    long token_time;
    
    UILabel *_pricelable;
    NSString *_urlcount;                //记录是单订单 还是多订单
    NSString *integralString;           //使用积分（总积分）
    NSString *_isOneBuy;                     //是否第一次0元购
    NSString *_needIntegral;            //需要的积分
    
    NSString *_requsetIntegral;
    CGFloat tempTotalprice;
    CGFloat integarlPrice;
    NSString* tempShop_num;
    
    
    UIButton *confirmButton;
    NSString *orderToken;
    
    NSString *integral_num;
    
    
    UIImageView *addressImgView;
    UILabel *addressLabel;
    
//    NSInteger _sharefailnumber;

    UILabel *discount;
    UISwitch *vouchersSwitch;
    UILabel *bottomLabel4;
    UILabel *bottomLabel5;
    UILabel *bottomMoneyLabel3;
    UILabel *bottomMoneyLabel4;
    UILabel *bottomMoneyLabel5;
    UILabel *vouchersMoney;
}
@property (nonatomic,strong)NSMutableArray *voucherArr;

//@property(nonatomic,strong)TFDailyTaskView *dailyTsakView;
@property(nonatomic,strong)UITextField *changeTextField;
@property (nonatomic, strong)UIImageView *animationView;
@property (nonatomic, strong)UIImage *shareRandShopImage;
//@property (nonatomic, strong)TFNoviceTaskView *noviceTaskView;
@end

@implementation AffirmOrderViewController

- (float)heightCoefficient:(float)height
{
    if (ThreeAndFiveInch) {
        return height*0.9;
    } else if (FourInch) {
        return height*0.9;
    } else if (FourAndSevenInch) {
        return height*1;
    } else if (FiveAndFiveInch) {
        return height*1;
    } else {
        return height*1;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [DataManager sharedManager].outAppStatistics=@"确认订单页";
//    [DataManager sharedManager].is_OneYuan=YES;

//    _sharefailnumber = 0;
    integralString=@"0";
    if (_post_money == nil || [_post_money isEqual:[NSNull null]]) {
        _post_money=@"0";
    }
    orderToken=[[NSUserDefaults standardUserDefaults]objectForKey:ORDER_TOKEN];
    

//    
//    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
//    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
//    tapGestureRecognizer.cancelsTouchesInView = NO;
//    //将触摸事件添加到当前view
//    [_Myscrollview addGestureRecognizer:tapGestureRecognizer];
//    
//    _Myscrollview.keyboardDismissMode  = UIScrollViewKeyboardDismissModeOnDrag;
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.integral.text = [NSString stringWithFormat:@""];
    
    _ShopArray=[NSMutableArray array];
    _DeliverArray=[NSMutableArray array];
    _isnotifation=NO;
    
    [self DeliveryHttp];

    //默认收货地址
    self.addressid=@"0";
    ((AppDelegate*)[UIApplication sharedApplication].delegate).takeoutPay=self;
    
   
    
    //滑动视图
    //    self.Myscrollview.contentSize=CGSizeMake(0, kApplicationHeight*2);
//    self.Myscrollview.pagingEnabled=NO;
//    self.Myscrollview.showsVerticalScrollIndicator = NO;
//    self.Myscrollview.keyboardDismissMode  = UIScrollViewKeyboardDismissModeOnDrag;
    
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeaddress:) name:@"changeaddress" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteAddress:) name:@"deleteAddress" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeIsOneBuy) name:@"isOneBuy" object:nil];
    
    //监听智能分享成功通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sharesuccess:) name:@"Intelligencesharesuccess" object:nil];
    
    //监听智能分享失败通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sharefail:) name:@"Intelligencesharefail" object:nil];


    //监听分享成功通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zeroIndexsharesuccess:) name:@"zeroIndexsharesuccess" object:nil];
    
    //监听分享失败通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zeroIndexsharefail:) name:@"zeroIndexsharefail" object:nil];
    
    

    //创建视图
    [self creatView];
    [self creatNavgationView];
    
    integarlPrice=0;
    
    
    if (_affirmType==NormalType) {
        [self httpGetIntegral];
        
        [self httpMatchCoupon:[NSString stringWithFormat:@"%@:%.1f",self.shopmodel.supp_id,memberPriceRate*self.shopmodel.shop_num.intValue*self.shopmodel.shop_se_price.floatValue]];
        [self httpVoucher];
    }
    
   
    
}
-(void)creatNavgationView
{
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //
    headview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 46, 46);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"确认订单";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, headview.frame.size.height-0.5, kApplicationWidth, 0.5)];
    line.backgroundColor = kNavLineColor;
    [headview addSubview:line];
}
-(void)changeIsOneBuy
{
    _isOneBuy=@"1";
}
-(void)viewDidAppear:(BOOL)animated
{
    
    confirmButton.userInteractionEnabled=YES;

    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"zeroindex"]) {
        //value = %@", change[@"new"]);
        
        if([gKVO.text isEqualToString:@"分享失败"])
        {
            MyLog(@"分享失败");
        }
        
        NSNumber *st = change[@"new"];
        if ([st intValue ]== 1) //第一次回调
        {
            
            MyLog(@"分享成功下单");
            _isShare=YES;
            [self OrderHttp];
            
        }
        
    }
    
    
}

- (void)zeroIndexsharesuccess:(NSNotification*)note
{
    MyLog(@"分享成功下单");
    _isShare=YES;
    [self OrderHttp];

}

- (void)zeroIndexsharefail:(NSNotification*)note
{
    NavgationbarView *mentionview = [[NavgationbarView alloc]init];
    [mentionview showLable:@"分享失败,分享成功才能购买" Controller:self];

}

/************** 判断是否第一次购买 **************/
/*
-(void)httpIsOneBuy
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@order/isOneBuy?token=%@&version=%@&packageCode=%@",[NSObject baseURLStr],token,VERSION,self.packageCode];
    NSString *URL = [MyMD5 authkey:urlStr];
    
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
//        //
 
        

        NSString *message=responseObject[@"message"];
        if([responseObject[@"status"]integerValue]==1){
            
            self.integral.text = [NSString stringWithFormat:@"(用户的积分余额：%@ )",responseObject[@"integral"]];
            self.integral.font=[UIFont systemFontOfSize:ZOOM(37)];
            integralString = [NSString stringWithFormat:@"%@",responseObject[@"integral"]];//积分总额
            _isOneBuy=[NSString stringWithFormat:@"%@",responseObject[@"isOneBuy"]];
            _needIntegral=[NSString  stringWithFormat:@"%@",responseObject[@"needIntegral"]];

            if ([responseObject[@"needIntegral"] isEqual:[NSNull null]]) {
                _needIntegral=@"0";
            }
            //            if (!_isShare) {
            //                [self checkWthereIsOneBuy];
            //            }
            
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
//        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
//        [mentionview showLable:@"网络连接失败,请检查网络设置" Controller:self];
    }];
}
*/
-(NSMutableArray *)voucherArr
{
    if (_voucherArr==nil) {
        _voucherArr = [NSMutableArray array];
    }
    return _voucherArr;
}
-(int)vouchersMatch:(ShopDetailModel *)shopModel
{
    MyLog(@"%@",self.voucherArr);

    for (VoucherModel *model2 in self.voucherArr) {
        model2.usedNum=0;
    }
    [_shopmodel.usedNunArray removeAllObjects];
    [_shopmodel.priceArray removeAllObjects];
    
    int Sum=0;
    for (VoucherModel *model in self.voucherArr) {
        if (model.price<=shopModel.kickback.integerValue*shopModel.shop_num.integerValue&&model.snum>model.usedNum) {
            int usedNum=0;
            int unUsedNum=model.snum-model.usedNum;
            for (int i=0; i<unUsedNum; i++) {
                if (Sum+model.price<=shopModel.kickback.integerValue*shopModel.shop_num.integerValue) {
                    Sum += model.price;
                    model.usedNum+=1;
                    usedNum+=1;
                    
                }
            }
            if (usedNum) {
                [shopModel.priceArray addObject:[NSString stringWithFormat:@"%f",model.price]];
                [shopModel.usedNunArray addObject:[NSString stringWithFormat:@"%d",usedNum]];
            }
        }
    }
    return Sum;
    
}
-(void)httpVoucher
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    NSString *url=[NSString stringWithFormat:@"%@coupon/queryVoucher?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            
            MyLog(@"%@",responseObject);
            for (NSDictionary *dic in responseObject[@"voucher"]) {
                VoucherModel *model = [[VoucherModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.voucherArr addObject:model];
                
            }
            [self.voucherArr sortUsingSelector:@selector(comparePerson:)];

            _shopmodel.voucher=[NSString stringWithFormat:@"%d",[self vouchersMatch:_shopmodel]];
            vouchersMoney.text=[NSString stringWithFormat:@"可抵用¥%.1f",_shopmodel.voucher.floatValue];
            [vouchersSwitch setOn:_shopmodel.voucher.floatValue>0?YES:NO];
            bottomMoneyLabel3.text=[NSString stringWithFormat:@"-¥%.1f",_shopmodel.voucher.floatValue];
            [self changTotalPrice];
//            [_myTableView reloadData];
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
-(void)changeOrderViewFrame
{
     const CGFloat cell_LabelHeight=ZOOM(130);
    if (self.cardModel.c_price.floatValue==0&&integralString.integerValue<500&&self.cardModel!=nil) {
        self.OrderView.frame=CGRectMake(0,0, kApplicationWidth, ZOOM(20)*2+ZOOM(100)*3+40+ZOOM(62)+cell_LabelHeight*6+ZOOM(32)*2);
        bottomLabel5.hidden=YES;bottomLabel4.hidden=YES;bottomMoneyLabel4.hidden=YES;bottomMoneyLabel5.hidden=YES;
    }else{
        self.OrderView.frame=CGRectMake(0,0, kApplicationWidth, ZOOM(20)*2+ZOOM(100)*5+40+ZOOM(62)+cell_LabelHeight*6+ZOOM(32)*2);
        bottomLabel5.hidden=NO;bottomLabel4.hidden=NO;bottomMoneyLabel4.hidden=NO;bottomMoneyLabel5.hidden=NO;
    }
    _ShopTableView.tableFooterView=self.OrderView;

}
#pragma mark - 获取积分
/***************    获取积分   **************/
- (void)httpGetIntegral
{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/getIntegralNum?token=%@&version=%@",[NSObject baseURLStr],token,VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            
            if ([responseObject[@"status"] intValue] == 1&&responseObject[@"integral"]!=nil) {
//                self.integral.text = [NSString stringWithFormat:@"(用户的积分余额：%@ )",responseObject[@"integral"]];
//                self.integral.font=[UIFont systemFontOfSize:ZOOM(37)];
//                integralString = [NSString stringWithFormat:@"%@",responseObject[@"integral"]];//积分总额
                
//                CGFloat totalprice=0;
//                CGFloat totalnumber=0;
//                for(int i=0;i<self.shopArray.count;i++)
//                {
//                    ShopDetailModel *shopmodel=self.shopArray[i];
//                    
//                    NSString *price=[NSString stringWithFormat:@"%@",shopmodel.shop_se_price];
//                    NSString *number=[NSString stringWithFormat:@"%@",shopmodel.shop_num];
//                    
//                    
//                    CGFloat PRICE=[price floatValue]*[number integerValue];
//                    totalprice +=PRICE;
//                    totalnumber +=number.floatValue;
//                }
//                 CGFloat price=memberPriceRate*[_selectPrice floatValue]*self.number.intValue+_post_money.floatValue;
                
                _requsetIntegral=[NSString stringWithFormat:@"%@",responseObject[@"integral"]];
                
                MyLog(@"%@",[NSString stringWithFormat:@"%d",[_shopmodel.core intValue]*self.number.intValue]);
                integralString = [_shopmodel.core intValue]*self.number.intValue < [responseObject[@"integral"]floatValue] ? [NSString stringWithFormat:@"%d",[_shopmodel.core intValue]*self.number.intValue]:[NSString stringWithFormat:@"%@",responseObject[@"integral"]];//积分总额

                CGFloat integralPrice=0;
                if(integralString.integerValue>=500) {
                    integralPrice=[integralString floatValue]/integralRate*0.1;
                }
                _integralLabel.font = [UIFont systemFontOfSize:ZOOM(37)];
                NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"可用积分:%@  可抵用¥%.1f",integralString.integerValue>=500?integralString:@"0",integralPrice]];
                _integralLabel.textColor = tarbarrossred;
                
                [_integralSwitch setOn:integralString.integerValue>=500?YES:NO];

//                bottomMoneyLabel5.text=[NSString stringWithFormat:@"-¥%.1f",integralPrice];
                bottomMoneyLabel5.text=[NSString stringWithFormat:@"-¥%.1f",_integralSwitch.on ?integralPrice:0];
//                NSRange redRange = NSMakeRange(0, [[noteStr string] rangeOfString:@"¥"].location);
//                [noteStr addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(48)]} range:redRange];
                [_integralLabel setAttributedText:noteStr] ;
                [self changeOrderViewFrame];

            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
    }];
    
}
/**************   自动匹配优惠劵    ************/
-(void)httpMatchCoupon:(NSString *)string
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    NSString *url=[NSString stringWithFormat:@"%@coupon/appMatchCoupon?version=%@&token=%@&result=%@",[NSObject baseURLStr],VERSION,token,string];
    NSString *URL=[MyMD5 authkey:url];
    
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //responseObject = [NSDictionary changeType:responseObject];
//        //responseObject is %@",responseObject);
        
        if (responseObject!=nil) {
            
            NSString *idstr = [NSString stringWithFormat:@"%@",self.shopmodel.supp_id];
            NSDictionary *dic = responseObject[idstr];
            MyCardModel *model = [[MyCardModel alloc]init];
            model.c_price = dic[@"c_price"];
            model.ID=dic[@"id"];
            self.cardModel = model;
//            //%@  %@",model.c_price,model.ID);
            [self changeOrderViewFrame];

            if(model.c_price != nil){
                _selectNumber.text=@"可使用1张优惠券";
                _discountMoney.text=[NSString stringWithFormat:@"-¥%.1f",model.c_price.floatValue];
            }else{
                _selectNumber.text=@"无可用";
                _discountMoney.text=@"";
            }
            bottomMoneyLabel4.text=[NSString stringWithFormat:@"-¥%.1f",model.c_price.floatValue];
            [self changTotalPrice];
            
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark 支付成功后跳转到分享
-(void)payFinished:(NSDictionary*)result
{
    switch([[result objectForKey:@"resultStatus"] integerValue]){
            
        case 9000://操作成功
        {
            //分享");
            
            BuySuccessViewController *successpay=[[BuySuccessViewController alloc]init];
            successpay.shopprice=_shop_seprice;
            successpay.shopArray=self.shopArray;
            successpay.orderCode = self.order_code;
            successpay.p_type = self.shopmodel.p_type;
            [self.navigationController pushViewController:successpay animated:YES];
            
            
        }
            break;
        case 4000://系统异常
        {
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"支付失败,系统异常" Controller:self];
        }
            break;
    }
    
}

#pragma mark 微信分享f
//-(void)share
//{
//    [[DShareManager share] shareAppWithType:ShareTypeWeixiTimeline View:nil Image:nil Title:nil WithShareType:@"combodetail"];
//}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Myview.hidden=YES;
    
    
//    //如果有选取地址就不用请求获取收货地址
//    if(_isnotifation==NO)
//    {
//        //获取收货信息
//    }
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
    
}

/*
 #pragma mark 积分兑换网络请求获取订单信息
 -(void)exchangerequestHttp
 {
 AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
 NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
 NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
 NSString *token=[userdefaul objectForKey:USER_TOKEN];
 
 NSString *url=[NSString stringWithFormat:@"%@inteOrder/getOrderShop?version=V1.0&order_code=%@&token=%@",[NSObject baseURLStr],self.order_code,token];
 
 NSString *URL=[MyMD5 authkey:url];
 
 [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
 [MBProgressHUD hideHUDForView:self.view];
 //responseObject is %@",responseObject);
 NSString *message=responseObject[@"message"];
 NSString *status=responseObject[@"status"];
 
 if(status.intValue==1)
 {
 NSDictionary *dic=responseObject[@"order"];
 OrderDetailModel *model=[[OrderDetailModel alloc]init];
 model.address=dic[@"address"];
 model.ID=dic[@"id"];
 model.consignee=dic[@"consignee"];
 model.message=dic[@"message"];
 model.order_code=dic[@"order_code"];
 model.order_name=dic[@"shop_name"];
 model.shop_num=dic[@"shop_num"];
 model.order_pic=dic[@"order_pic"];
 model.order_price=dic[@"order_price"];
 model.phone=dic[@"phone"];
 model.status=dic[@"status"];
 model.user_id=dic[@"user_id"];
 
 [_ShopArray addObject:model];
 
 //            //创建视图
 //            [self creatView];
 
 }
 
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 
 [MBProgressHUD hideHUDForView:self.view];
 UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"加载失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
 [alter show];
 
 }];
 
 
 }
 
 #pragma mark 直接购买获取订单信息网络请求
 -(void)payRequestHttp
 {
 AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
 NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
 NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
 NSString *token=[userdefaul objectForKey:USER_TOKEN];
 
 NSString *url=[NSString stringWithFormat:@"%@order/getOrder?version=V1.0&order_code=%@&token=%@&pager.curPage=1",[NSObject baseURLStr],self.order_code,token];
 
 NSString *URL=[MyMD5 authkey:url];
 
 [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
 [MBProgressHUD hideHUDForView:self.view];
 //responseObject is %@",responseObject);
 NSString *message=responseObject[@"message"];
 NSString *status=responseObject[@"status"];
 
 if(status.intValue==1)
 {
 NSDictionary *dic=responseObject[@"orders"][0];
 OrderDetailModel *model=[[OrderDetailModel alloc]init];
 
 model.address=dic[@"address"];
 model.ID=dic[@"id"];
 model.consignee=dic[@"consignee"];
 model.message=dic[@"message"];
 model.order_code=dic[@"order_code"];
 model.order_name=dic[@"order_name"];
 model.shop_num=dic[@"shop_num"];
 model.order_pic=dic[@"order_pic"];
 model.order_price=dic[@"order_price"];
 model.phone=dic[@"phone"];
 model.status=dic[@"status"];
 model.user_id=dic[@"user_id"];
 model.store_code=dic[@"store_code"];
 model.store_name=dic[@"store_name"];
 model.shop_name=dic[@"orderShops"][0][@"shop_name"];
 
 [_ShopArray addObject:model];
 
 //创建视图
 [self creatView];
 
 }
 
 
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 
 [MBProgressHUD hideHUDForView:self.view];
 UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"加载失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
 [alter show];
 
 }];
 }
 */


#pragma mark 获取默认的收货地址
-(void)DeliveryHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    
    NSString *url=[NSString stringWithFormat:@"%@address/queryDefault?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    
    NSString *URL=[MyMD5 authkey:url];
    
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        //responseObject is %@",responseObject);
        //responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
//            for (UIView *subView in _addressView.subviews) {
//                [subView removeFromSuperview];
//            }
            //%@",_addressView.subviews);
            if(str.intValue==1)
            {
                NSDictionary *dic=responseObject[@"address"];
                
                if([dic count]!=0)
                {
                    AdressModel *model=[[AdressModel alloc]init];
                    model.address=dic[@"address"];
                    model.consignee=dic[@"consignee"];
                    model.phone=dic[@"phone"];
                    model.postcode=dic[@"postcode"];
                    self.addressid=@"0";
                    [_DeliverArray addObject:model];
                    
                    if(_DeliverArray.count>0)
                    {
                        [self createDetailAddressView];
                        
                        self.name.text=[NSString stringWithFormat:@"收货人:%@   %@",model.consignee ,model.phone ];
                        
                        self.address.text=[NSString stringWithFormat:@"收货地址:%@",model.address];
                        
                    }
                    
                }else{
                    
                    
                    [self creatAddressView];
                    
                }
                
                
                
            }else{
                [self creatAddressView];
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [self creatAddressView];

//        UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"收获地址获取失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alter show];
//        [MBProgressHUD showError:@"收获地址获取失败"];
        [MBProgressHUD hideHUDForView:self.view];
        
        
    }];
    
    
}



#pragma mark 购买支付生成订单-单个商品
-(void)OrderHttp
{
    if (_affirmType==NormalType)
        [TFStatisticsClickVM handleDataWithPageType:nil withClickType:@"确认订单页面”确认下单“" success:^(id data, Response *response) {
        } failure:^(NSError *error) {
        }];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url;
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    NSString *storecode=[userdefaul objectForKey:STORE_CODE];
    
    
    MyLog(@"store_code=%@",storecode);
    
    NSString *tyeid;
    NSString *shop_code;
    NSString *shop_num;
    NSString *shop_color;
    NSString *shop_size;
    NSString *shop_pic;
    
    
    NSString *share_pic;
    NSArray *imageArr=[self.four_pic componentsSeparatedByString:@","];
    if (imageArr.count==3) {
        share_pic = imageArr[2];
    }
    
    if(_selectColorID && _selectSizeID && self.shopmodel.p_type==nil &&_affirmType!=IndianaType &&_affirmType!=SignType)//商品详情下单
    {
        
        NSMutableString *typeidString=[NSMutableString string];
        [typeidString appendString:self.selectColorID];
        [typeidString appendString:@":"];
        [typeidString appendString:_selectSizeID];
        
        //查找商品库存分类id
        for(int i=0;i<_stocktypeArray.count;i++)
        {
            ShopDetailModel *model=self.stocktypeArray[i];
            if([model.color_size isEqualToString:typeidString])
            {
                tyeid=model.stock_type_id;
            }
        }
        shop_size=[NSString stringWithString:self.size];
        shop_color=[NSString stringWithString:self.color];
        shop_code=[NSString stringWithString:self.shopmodel.shop_code];
        
        if (self.shopmodel.shop_num!=nil) {
            shop_num=[NSString stringWithString:self.shopmodel.shop_num];
        }
        if (self.shopmodel.def_pic!=nil) {
            shop_pic = [NSString stringWithString:self.shopmodel.def_pic];
        }
        //存储当前支付的shopcode
        NSUserDefaults *users=[NSUserDefaults standardUserDefaults];
        [users setObject:shop_code forKey:SHOP_CODE];
        //        [users setObject:share_pic forKey:SHOP_PIC];
        [users setObject:shop_pic forKey:SHOP_PIC];
        
        
    }
    
    
    
    NSMutableArray *arr=[NSMutableArray array];
    
    
    NSMutableDictionary *userdic = [NSMutableDictionary dictionary];
    [userdic setValue:shop_code forKey:@"shop_code"];
    [userdic setValue:shop_num forKey:@"shop_num"];
    [userdic setValue:shop_color forKey:@"color"];
    [userdic setValue:shop_size forKey:@"size"];
    [userdic setValue:tyeid forKey:@"stocktypeid"];
    [userdic setValue:shop_pic forKey:@"shop_pic"];
    
    
    [arr addObject:userdic];
    
    
    // 将数据转化为JSON格式字符串
    
    NSString *dataString;
    if ([NSJSONSerialization isValidJSONObject:arr])
    {
        NSError *error;
        NSData *jsonData=[NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&error];
        NSMutableData *tempJsonData=[NSMutableData dataWithData:jsonData];
        dataString=[[NSString alloc]initWithData:tempJsonData encoding:NSUTF8StringEncoding];
        //dataString is %@",dataString);
        
        
    }
    MyLog( @"dataString is %@",dataString);
    
    NSMutableString *result=[NSMutableString string];
    NSMutableString *message=[NSMutableString string];

    [result appendString:[NSString stringWithFormat:@"%@^%@^%@^0,",_shopmodel.shop_num,_shopmodel.shop_code,_shopmodel.stock_type_id]];
    
    NSMutableString *vouchers=[NSMutableString string];
    for (int i=0; i<_shopmodel.priceArray.count; i++) {
        [vouchers appendString:[NSString stringWithFormat:@"%d:%@-",[_shopmodel.priceArray[i]intValue],_shopmodel.usedNunArray[i]]];
    }
    if (vouchers.length==0) {
                [userdic setValue:@"0" forKey:@"voucherRes"];
            }else{
        MyLog(@"%@",[vouchers substringToIndex:[vouchers length]-1]);
        [userdic setValue:[vouchers substringToIndex:[vouchers length]-1] forKey:@"voucherRes"];
    }
    
    ShopDetailModel *shopmodel=self.shopArray[0];

     /******   新增的 1元购下单  ************/
    /**
     判断条件 [DataManager sharedManager].is_OneYuan
     */
    
    if ([DataManager sharedManager].is_OneYuan) {
        
//        url=[NSString stringWithFormat:@"%@order/addOrderListV160302?version=%@&token=%@&message=%@&cartIds=%@&integral_num=%@&result=%@&address_id=%@&couponid=%@&is_be=%d",[NSObject baseURLStr],VERSION,token,messageStr,ccc,integral_num,[result substringToIndex:[result length]-1],_addressid,couponid,myMoneySwitchSelected];
        
        url=[NSString stringWithFormat:@"%@order/addOrderListV180306?version=%@&token=%@&message=%@&result=%@&address_id=%@&integral_num=0",[NSObject baseURLStr],VERSION,token,message,[result substringToIndex:[result length]-1],_addressid];
        
        NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
        [userdefaul setObject:url forKey:@"oneOrderUrl"];
        
    }else
        
    if (_affirmType==IndianaType){
        NSString *t=@"0";
        if (_shareReductionPrice&&_shareReductionPrice.length) {
            t=@"1";
        }
        url=[NSString stringWithFormat:@"%@treasures/addTreasures?version=%@&address_id=%@&token=%@&message=%@&num=%@&t=%@&shop_code=%@",[NSObject baseURLStr],VERSION,self.addressid,token,self.Message.text,self.number,t,_shopmodel.shop_code];
    }
    else if (_affirmType==SignType) {
        url=[NSString stringWithFormat:@"%@treasures/addTreasures?version=%@&address_id=%@&token=%@&message=%@",[NSObject baseURLStr],VERSION,self.addressid,token,self.Message.text];
    }
    else if (_affirmType==MemberType) {
        url=[NSString stringWithFormat:@"%@order/addOrder98?version=%@&address_id=%@&token=%@&stocktype_id=%@&shop_code=%@&shop_num=%@&message=%@",[NSObject baseURLStr],VERSION,self.addressid,token,self.stockType,_shopmodel.shop_code,_number,self.Message.text];
    }else if(_selectColorID && _selectSizeID){  //商品详情下单
        CGFloat integral =integarlPrice;
        
        if(self.cardModel.ID != nil)
            url=[NSString stringWithFormat:@"%@order/addOrder?version=%@&address_id=%@&token=%@&store_code=%@&result=%@&coupon_id=%@&integral_num=%g&message=%@&voucherRes=%@",[NSObject baseURLStr],VERSION,self.addressid,token,storecode,dataString,self.cardModel.ID,integral,self.Message.text,[userdic objectForKey:@"voucherRes"]];
        else
            url=[NSString stringWithFormat:@"%@order/addOrder?version=%@&address_id=%@&token=%@&store_code=%@&result=%@&integral_num=%g&message=%@&voucherRes=%@",[NSObject baseURLStr],VERSION,self.addressid,token,storecode,dataString,integral,self.Message.text,[userdic objectForKey:@"voucherRes"]];
    }else{
        url=[NSString stringWithFormat:@"%@order/addOrder?version=%@&address_id=%@&token=%@&store_code=%@&result=%@&cartIds=%@&message=%@&voucherRes=%@",[NSObject baseURLStr],VERSION,self.addressid,token,storecode,dataString,shopmodel.ID,self.Message.text,[userdic objectForKey:@"voucherRes"]];
    }
    
    NSString *URL=[MyMD5 authkey:url];
//    //------- %@",URL);
//    [[Animation shareAnimation]createAnimationAt:self.view];
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //responseObject = [NSDictionary changeType:responseObject];
        
        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation]stopAnimationAt:self.view];
        confirmButton.userInteractionEnabled=YES;
        
        
        MyLog(@"%@",responseObject);
        if(responseObject[@"orderToken"]!=nil)
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"orderToken"] forKey:ORDER_TOKEN];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            _urlcount=responseObject[@"url"];
            _shop_seprice= [NSString stringWithFormat:@"%@",responseObject[@"price"]];
            
            if(statu.intValue==1)//请求成功
            {
                self.order_code=nil;
                self.order_code =responseObject[@"order_code"];
                if (_affirmType==IndianaType||_affirmType==SignType) {
                    _shop_seprice= [NSString stringWithFormat:@"%@",responseObject[@"data"][@"price"]];
                    self.order_code =responseObject[@"data"][@"order_code"];
//                    self.shopmodel.p_type=@"5";
                    
                }
                NSInteger userIdentity = 9999;
                if(self.affirmType == OneYuanType)
                {
                    userIdentity = [responseObject[@"userIdentity"] integerValue];
                }
//                PaystyleViewController *paystyle=[[PaystyleViewController alloc]init];
                TFPayStyleViewController*paystyle=[[TFPayStyleViewController alloc]init];
                paystyle.price = _shop_seprice.doubleValue;
                paystyle.urlcount=@"1";
                paystyle.order_code=_order_code;
                paystyle.sortArray=self.shopArray;
                paystyle.p_type = self.shopmodel.p_type;
                paystyle.shopmodel = self.shopmodel;
                paystyle.requestOrderDetail=1;
                
                if(_affirmType==MemberType) {
                    paystyle.shop_from = @"2";
                }else if (_affirmType == IndianaType){
                    paystyle.shop_from = @"4";
                }else if (_affirmType== SignType){
                    paystyle.shop_from=@"3";
                }else if (_affirmType == OneYuanType)
                {
                    paystyle.shop_from = @"9";
                }

                if(self.isNewbie || _shop_seprice.intValue ==0 || userIdentity ==0)//新用户不用支付直接1元抽奖
                {
                    NSNotification *notification=[NSNotification notificationWithName:@"zeroOrderChange" object:@"zeroOrderChange"];
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                    
                    OneLuckdrawViewController *oneluck = [OneLuckdrawViewController new];
                    oneluck.comefrom = @"newbie";
                    oneluck.order_code = self.order_code;
                    [self.navigationController pushViewController:oneluck animated:YES];
                }else
                    [self.navigationController pushViewController:paystyle animated:YES];
                
            }
            else if(statu.intValue == 10030){//没登录状态
                
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
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _isShare=NO;
        [MBProgressHUD hideHUDForView:self.view];
//        [[Animation shareAnimation]stopAnimationAt:self.view];
        confirmButton.userInteractionEnabled=YES;
        
        if ([error code] == kCFURLErrorTimedOut) {
            //===== 请求超时");
            
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
            
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];

}


-(BOOL)parser:(NSString*)string
{
    //系统自带的
    NSXMLParser *par = [[NSXMLParser alloc] initWithData:[string dataUsingEncoding:NSUTF8StringEncoding]];
    [par setDelegate:self];//设置NSXMLParser对象的解析方法代理
    return [par parse];//调用代理解析NSXMLParser对象，看解析是否成功   }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 8787)
    {
        if(buttonIndex == 1)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }else{
    
    if (_isOneBuy.integerValue==5) {
        if (buttonIndex==1) {
//            TFOldPaymentViewController *tovc = [[TFOldPaymentViewController alloc] init];
//            tovc.headTitle = @"绑定手机";
//            tovc.leftStr = @"手机号码";
//            tovc.plaStr = @"输入您要绑定的手机号";
//            tovc.index = 1;
            BoundPhoneVC *tovc = [[BoundPhoneVC alloc] init];
            [self.navigationController pushViewController:tovc animated:YES];
        }
    }else if (_isOneBuy.integerValue==0){
        if (buttonIndex==1) {
            NewSigninViewController *newSign = [[NewSigninViewController alloc]init];
            [self.navigationController pushViewController:newSign animated:YES];
        }
    }
    else if(buttonIndex==0)
    {
        
    }else{
        PaypasswordViewController *password=[[PaypasswordViewController alloc]init];
        [self.navigationController pushViewController:password animated:YES];
    }
    }
}
/************  改变可用积分总数  *************/
-(void)changeIntegral
{
    integralString = [_shopmodel.core intValue]*self.number.intValue < [_requsetIntegral floatValue] ? [NSString stringWithFormat:@"%d",[_shopmodel.core intValue]*self.number.intValue]:_requsetIntegral;//积分总额

    CGFloat integralPrice=0;
    if(integralString.integerValue>=500) {
        integralPrice=[integralString floatValue]/integralRate*0.1;
    }
    _integralLabel.font = [UIFont systemFontOfSize:ZOOM(37)];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"可用积分:%@  可抵用¥%.1f",integralString.integerValue>=500?integralString:@"0",integralPrice]];
    _integralLabel.textColor = tarbarrossred;
//    bottomMoneyLabel5.text=[NSString stringWithFormat:@"-¥%.1f",integralPrice];
    bottomMoneyLabel5.text=[NSString stringWithFormat:@"-¥%.1f",_integralSwitch.on ?integralPrice:0];
//    NSRange redRange = NSMakeRange(0, [[noteStr string] rangeOfString:@"¥"].location);
//    [noteStr addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(48)]} range:redRange];
    [_integralLabel setAttributedText:noteStr] ;
}
/************  改变合计价格  *************/
-(void)changTotalPrice
{
    //    self.totalprice.text=[NSString stringWithFormat:@"¥%.2f",[_selectPrice floatValue]*self.shopmodel.shop_num.intValue];
    //    _pricelable.text = self.totalprice.text;
    //%f",memberPriceRate);
    
    
    
    [self changeIntegral];
    
    CGFloat allPrice = 0;
    if (self.shopmodel.shop_from.intValue==1) {
        allPrice=_post_money.floatValue+[_selectPrice floatValue]*self.shopmodel.shop_num.intValue-integarlPrice/integralRate*0.1-self.cardModel.c_price.floatValue;
        self.totalprice.text=[NSString stringWithFormat:@"¥%.1f",_post_money.floatValue+[_selectPrice floatValue]*self.shopmodel.shop_num.intValue];
    }else{
        allPrice=_post_money.floatValue+memberPriceRate*[_selectPrice floatValue]*self.shopmodel.shop_num.intValue-integarlPrice/integralRate*0.1-self.cardModel.c_price.floatValue;
        self.totalprice.text=[NSString stringWithFormat:@"¥%.2f",_post_money.floatValue+memberPriceRate*[_shopmodel.shop_se_price floatValue]*self.shopmodel.shop_num.intValue];
    }
    allPrice-=_shopmodel.voucher.floatValue;
    if (_shareReductionPrice&&_shareReductionPrice.length)
        allPrice-=_shareReductionPrice.floatValue;
//    if (self.cardModel.c_price!=nil || integarlPrice!=0) {
//        _pricelable.font=[UIFont systemFontOfSize:ZOOM(35)];
////        CGFloat totalprice=[[self.totalprice.text substringFromIndex:1]floatValue];
//        CGFloat totalprice=allPrice;
//        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%.2f ( 已优惠%.2f元 )",totalprice,self.cardModel.c_price.floatValue+integarlPrice/integralRate*0.1]];
//        NSRange redRange = NSMakeRange(0, [[noteStr string] rangeOfString:@" "].location);
//        [noteStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(50)]} range:redRange];
//        [_pricelable setAttributedText:noteStr] ;
//    }else{
        _pricelable.text=[NSString stringWithFormat:@"实付款:  ¥%.1f",allPrice];
        _pricelable.font=[UIFont systemFontOfSize:ZOOM(50)];
        
//    }
    
}



-(void)createDetailAddressView
{
    _address.hidden=NO;_name.hidden=NO;
    addressLabel.hidden=YES;addressImgView.hidden=YES;
}

-(void)creatAddressView
{
    addressLabel.hidden=NO;addressImgView.hidden=NO;
    _address.hidden=YES;_name.hidden=YES;
}
-(void)creatFootView
{
    //下面带有提醒功能的视图
    UIView *foorview=[[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight-50+kUnderStatusBarStartY, kApplicationWidth, 50)];
    foorview.backgroundColor=[UIColor whiteColor];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 0.5)];
    line.backgroundColor = kNavLineColor;
    [foorview addSubview:line];
    confirmButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    confirmButton.frame=CGRectMake(kApplicationWidth/2, 0, kApplicationWidth/2, foorview.frame.size.height);
    [confirmButton setTitle:@"提交下单" forState:UIControlStateNormal];
    confirmButton.titleLabel.font=[UIFont systemFontOfSize:ZOOM(46)];
    confirmButton.tintColor=[UIColor whiteColor];
    [confirmButton setBackgroundColor:tarbarrossred];
    [confirmButton addTarget:self action:@selector(affirmorder:) forControlEvents:UIControlEventTouchUpInside];
//    UILabel *pricelab = [[UILabel alloc]initWithFrame:CGRectMake(left, 5, 50, 40)];
//    pricelab.text = @"总计:";
//    pricelab.font=[UIFont systemFontOfSize:ZOOM(50)];
//    pricelab.textColor = tarbarrossred;
//    [foorview addSubview:pricelab];
    _pricelable=[[UILabel alloc]init];
//    _pricelable.frame=CGRectMake(CGRectGetMinX(confirmButton.frame)-ZOOM6(20)-200, 5,200, 40);
    CGFloat pricelableWith = kScreenWidth - CGRectGetWidth(confirmButton.frame);
    _pricelable.frame=CGRectMake(0, 5,pricelableWith, 40);
    _pricelable.font=[UIFont systemFontOfSize:ZOOM(50)];
    _pricelable.textColor=tarbarrossred;
    _pricelable.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:foorview];
    
    
    [foorview addSubview:confirmButton];
    [foorview addSubview:_pricelable];
}
-(void)creatView
{
    [self creatFootView];
    
    const CGFloat cell_LabelHeight=ZOOM(130);

    self.InforView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth,(100))];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(settingAddress:)];
    [self.InforView addGestureRecognizer:tap];
    self.InforView.userInteractionEnabled=YES;
    self.addressImg=[[UIImageView alloc]init];
    self.addressImg.image=[UIImage imageNamed:@"更多-副本-3"];
    self.addressImg.frame=CGRectMake(kApplicationWidth-right-10, (38),10, 30);
    self.addressImg.contentMode=UIViewContentModeScaleAspectFit;
    [self.InforView addSubview:self.addressImg];
    _addressView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.InforView.frame.size.width-50, self.InforView.frame.size.height)];
    [self.InforView addSubview:_addressView];
    _name = [[UILabel alloc]initWithFrame:CGRectMake(left, self.InforView.frame.origin.y+(20), kApplicationWidth-(30), (20))];
    self.address = [[UILabel alloc]initWithFrame:CGRectMake(left, _name.frame.origin.y+(25), kApplicationWidth-(60), (50))];
    self.address.numberOfLines = 0;
    _name.font=[UIFont systemFontOfSize:ZOOM(45)];
    self.address.font=[UIFont systemFontOfSize:ZOOM(45)];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, (99), kApplicationWidth, 1)];
    line.backgroundColor = kTableLineColor;
    [_addressView addSubview:line];
    _name.hidden=YES; _address.hidden=YES;
    _name.textColor=kMainTitleColor;_address.textColor=kMainTitleColor;
    [_addressView addSubview:_name];
    [_addressView addSubview:self.address];
    addressImgView = [[UIImageView alloc]initWithFrame:CGRectMake(left, self.InforView.frame.size.height/2-15, 30, 30)];
    addressImgView.image = [UIImage imageNamed:@"地址"];
    addressImgView.contentMode = UIViewContentModeScaleAspectFit;
    addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(addressImgView.frame.origin.x + addressImgView.frame.size.width + 10, self.InforView.frame.size.height/2-10, 200, 20)];
    addressLabel.text = @"请填写收货地址";
    addressLabel.textColor=kMainTitleColor;
    addressLabel.tag=99;
    addressLabel.font=[UIFont systemFontOfSize:ZOOM(45)];
    [_addressView addSubview:addressLabel];
    [_addressView addSubview:addressImgView];
    [self creatAddressView];
    

    _ShopTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,Height_NavBar, kApplicationWidth,kScreenHeight-Height_NavBar-50) style:UITableViewStylePlain];
    _ShopTableView.dataSource=self;
    _ShopTableView.delegate=self;
    _ShopTableView.rowHeight=ZOOM(62)+ZOOM(320);
    _ShopTableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    _ShopTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [_ShopTableView registerNib:[UINib nibWithNibName:@"SCarCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_ShopTableView];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [_ShopTableView addGestureRecognizer:tapGestureRecognizer];
    
    self.OrderView=[[UIView alloc]init];
//    self.OrderView.frame=CGRectMake(0,0, kApplicationWidth, 40+ZOOM(62)+cell_LabelHeight*6+ZOOM(32)*2);
    
    self.OrderView.frame=_affirmType==NormalType ?
    CGRectMake(0,0, kApplicationWidth, ZOOM(20)*2+ZOOM(100)*5+40+ZOOM(62)+cell_LabelHeight*6+ZOOM(32)*2)
    :
    CGRectMake(0,0, kApplicationWidth, ZOOM(20)*2+ZOOM(100)*3+20+ZOOM(62)+cell_LabelHeight*3+ZOOM(32)*2);
    _ShopTableView.tableFooterView=self.OrderView;
    _ShopTableView.tableHeaderView=self.InforView;
    

    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(0, ZOOM(62), kScreenWidth, 1)];
    line1.backgroundColor=kTableLineColor;
    [self.OrderView addSubview:line1];
    
    CGFloat y_point = CGRectGetMaxY(line1.frame);
    //  不是一元购添加  邮费行
    if ([DataManager sharedManager].is_OneYuan==NO) {
        _way=[[UILabel alloc]initWithFrame:CGRectMake(left,CGRectGetMaxY(line1.frame), kScreenWidth, cell_LabelHeight)];
        _way.text=@"配送方式";
        _way.textColor=kMainTitleColor;
        self.way.font=[UIFont systemFontOfSize:ZOOM(48)];
        [self.OrderView addSubview:_way];
        _wayDetail=[[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth-ZOOM(42)-200, self.way.frame.origin.y,200, cell_LabelHeight)];
        _wayDetail.textAlignment=NSTextAlignmentRight;
        _wayDetail.text=@"快递免邮";
        _wayDetail.textColor=kMainTitleColor;
        self.wayDetail.font=[UIFont systemFontOfSize:ZOOM(42)];
        [self.OrderView addSubview:_wayDetail];

        
        UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_way.frame), kScreenWidth, 1)];
        line2.backgroundColor=kTableLineColor;
        [self.OrderView addSubview:line2];
        
        y_point = CGRectGetMaxY(line2.frame);
    }
    
    

//    _PriceTotalLabel=[[UILabel alloc]initWithFrame:CGRectMake(left,CGRectGetMaxY(line2.frame), kScreenWidth, cell_LabelHeight)];
    _PriceTotalLabel=[[UILabel alloc]initWithFrame:CGRectMake(left,y_point, kScreenWidth, cell_LabelHeight)];
    CGFloat priceLabelHeigh = _affirmType==OneYuanType?0:self.PriceTotalLabel.frame.size.height;
    self.PriceTotalLabel.frame=CGRectMake(left, self.PriceTotalLabel.frame.origin.y, self.PriceTotalLabel.frame.size.width, priceLabelHeigh);
    _PriceTotalLabel.text=@"价格合计";
    _PriceTotalLabel.textColor=kMainTitleColor;
    self.PriceTotalLabel.font=[UIFont systemFontOfSize:ZOOM(48)];
    [self.OrderView addSubview:_PriceTotalLabel];
    _totalprice=[[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth-ZOOM(42)-200, self.PriceTotalLabel.frame.origin.y,200, _affirmType==OneYuanType?0:cell_LabelHeight)];
    _totalprice.textAlignment=NSTextAlignmentRight;
    _totalprice.textColor = kMainTitleColor;
    self.totalprice.font=[UIFont systemFontOfSize:ZOOM(42)];
    [self.OrderView addSubview:_totalprice];
    [self changTotalPrice];
    
    UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_PriceTotalLabel.frame), kScreenWidth, 1)];
    line3.backgroundColor=kTableLineColor;
    [self.OrderView addSubview:line3];
    
    _Message=[[UITextField alloc]init];
    _Message.frame=CGRectMake(left, CGRectGetMaxY(line3.frame)+ZOOM(32),kApplicationWidth-left-right, cell_LabelHeight);
    const CGFloat detailLabel_XPoint=ZOOM(250);

    if (_affirmType==NormalType) {
        UILabel *vouchers = [[UILabel alloc]initWithFrame:CGRectMake(left, CGRectGetMaxY(line3.frame), kApplicationWidth/2, cell_LabelHeight)];
        vouchers.text = @"抵用券";
        vouchers.font=[UIFont systemFontOfSize:ZOOM(48)];
        vouchers.textAlignment = NSTextAlignmentLeft;
        vouchersMoney=[[UILabel alloc]initWithFrame:CGRectMake(detailLabel_XPoint, vouchers.frame.origin.y, vouchers.frame.size.width, vouchers.frame.size.height)];
        //    vouchersMoney.text=[NSString stringWithFormat:@"可抵用¥%@",_shopmodel.kickback];
        vouchersMoney.text=[NSString stringWithFormat:@"可抵用¥%.1f",_shopmodel.voucher.floatValue];
        
        vouchersMoney.font=[UIFont systemFontOfSize:ZOOM(37)];
        vouchersMoney.textColor=tarbarrossred;
        vouchersSwitch=[[UISwitch alloc]init];
        vouchersSwitch.center=CGPointMake(kApplicationWidth-25-right, vouchers.center.y);
        [vouchersSwitch addTarget:self action:@selector(voucherSwitchClick:) forControlEvents:UIControlEventValueChanged];
        [vouchersSwitch setOn:_shopmodel.voucher.floatValue>0?YES:NO];
        [self.OrderView addSubview:vouchers];
        [self.OrderView addSubview:vouchersMoney];
        [self.OrderView addSubview:vouchersSwitch];
        
        
        UIView *line4=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(vouchers.frame), kScreenWidth, 1)];
        line4.backgroundColor=kTableLineColor;
        [self.OrderView addSubview:line4];
        
        _Message.frame=CGRectMake(left, CGRectGetMaxY(line4.frame)+ZOOM(32),kApplicationWidth-left-right, cell_LabelHeight);

    }
   

    
    self.Message.font=[UIFont systemFontOfSize:ZOOM(40)];
    self.Message.placeholder=@"给卖家留言...";
    _Message.delegate=self;
    _Message.borderStyle=UITextBorderStyleRoundedRect;
    self.Message.layer.borderWidth=1;
    self.Message.layer.cornerRadius = 5;
    self.Message.layer.borderColor=kTableLineColor.CGColor;
    [self.OrderView addSubview:_Message];

    UIView *line6=[[UIView alloc]init];
    line6.frame=CGRectMake(0, CGRectGetMaxY(_Message.frame)+ZOOM(32), kScreenWidth, 10);
    if (_affirmType==NormalType) {
        UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_Message.frame)+ZOOM(32), kApplicationWidth, 20)];
        bottomView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
        [self.OrderView addSubview:bottomView];
        
        discount = [[UILabel alloc]initWithFrame:CGRectMake(left, CGRectGetMaxY(bottomView.frame), kApplicationWidth-30, cell_LabelHeight)];
        discount.text = @"优惠劵";
        discount.font=[UIFont systemFontOfSize:ZOOM(48)];
        UITapGestureRecognizer *discountTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(discountGes:)];
        [discount addGestureRecognizer:discountTap];
        discount.userInteractionEnabled=YES;
        [self.OrderView addSubview:discount];
        _selectNumber=[[UILabel alloc]initWithFrame:CGRectMake(detailLabel_XPoint, discount.frame.origin.y, kScreenWidth/2, cell_LabelHeight)];
        _selectNumber.textColor=tarbarrossred;
        _selectNumber.text=@"无可用";
        _selectNumber.font = [UIFont systemFontOfSize:ZOOM(37)];
        [self.OrderView addSubview:_selectNumber];
        _discountMoney=[[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth-right-120, discount.frame.origin.y, 100, cell_LabelHeight)];
        _discountMoney.textColor=tarbarrossred;
        _discountMoney.textAlignment=NSTextAlignmentRight;
        _discountMoney.font = [UIFont systemFontOfSize:ZOOM(37)];
        [self.OrderView addSubview:_discountMoney];
        
        UIImageView *arrow=[[UIImageView alloc]initWithFrame:CGRectMake(kApplicationWidth-right-10, discount.frame.origin.y+cell_LabelHeight/2-15,10, 30)];
        arrow.image=[UIImage imageNamed:@"更多-副本-3"];
        arrow.contentMode=UIViewContentModeScaleAspectFit;
        [self.OrderView addSubview:arrow];
        
        UILabel *line5=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(discount.frame), kScreenWidth, 1)];
        line5.backgroundColor=kTableLineColor;
        [self.OrderView addSubview:line5];
        
        UILabel *integral=[[UILabel alloc]initWithFrame:CGRectMake(left,CGRectGetMaxY(line5.frame), kScreenWidth/2, cell_LabelHeight)];
        integral.text=@"积分";
        integral.font=[UIFont systemFontOfSize:ZOOM(48)];
        [self.OrderView addSubview:integral];
        CGFloat integralPrice=0;
        if(integralString.integerValue>=500) {
            integralPrice=[integralString floatValue]/integralRate*0.1;
        }
        _integralLabel=[[UILabel alloc]initWithFrame:CGRectMake(detailLabel_XPoint, integral.frame.origin.y, kScreenWidth, cell_LabelHeight)];
        _integralLabel.font = [UIFont systemFontOfSize:ZOOM(37)];
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"可用积分:%@  可抵用¥%.1f",integralString.integerValue>=500?integralString:@"0",integralPrice]];
        _integralLabel.textColor = tarbarrossred;
        //    NSRange redRange = NSMakeRange(0, [[noteStr string] rangeOfString:@"¥"].location);
        //    [noteStr addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(48)]} range:redRange];
        [_integralLabel setAttributedText:noteStr] ;
        _integralSwitch=[[UISwitch alloc]init];
        _integralSwitch.center=CGPointMake(kApplicationWidth-25-right, _integralLabel.center.y);
        [_integralSwitch addTarget:self action:@selector(integralSwitchClick) forControlEvents:UIControlEventValueChanged];
       // [_integralSwitch setOn:NO];
        [_integralSwitch setOn:integralString.integerValue>=500?YES:NO];
        
        [self.OrderView addSubview:_integralLabel];
        [self.OrderView addSubview:_integralSwitch];
        
        line6.frame=CGRectMake(0, CGRectGetMaxY(_integralLabel.frame), kScreenWidth, 20);
    }
    
    line6.backgroundColor=[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    [self.OrderView addSubview:line6];
    
    CGFloat yPoint=CGRectGetMaxY(line6.frame)+ZOOM(20);
    NSArray *array=_affirmType==NormalType ? @[@"商品金额",@"运费",@"抵用券"] : @[@"商品金额",@"运费"];
    
    //  1元购 不显示 运费
    if ([DataManager sharedManager].is_OneYuan) {
        array = @[@"商品金额"];
    }else
    if (_affirmType==IndianaType && _shareReductionPrice&&_shareReductionPrice.length) {
        array = @[@"商品金额",@"运费",@"分享抵扣"];
    }
    for (int i=0; i<array.count; i++) {
        UILabel *bottomLabel1=[[UILabel alloc]initWithFrame:CGRectMake(left, yPoint+ZOOM(100)*i, kScreenWidth/2, ZOOM(100))];
        bottomLabel1.font=[UIFont systemFontOfSize:ZOOM(48)];
        bottomLabel1.text=array[i];
        [self.OrderView addSubview:bottomLabel1];
    }
    UILabel *bottomMoneyLabel1=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-right, yPoint, kScreenWidth/2, ZOOM(100))];
    UILabel *bottomMoneyLabel2=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-right, yPoint+ZOOM(100), kScreenWidth/2, ZOOM(100))];
    bottomMoneyLabel1.text=[NSString stringWithFormat:@"¥%.2f",memberPriceRate*[_shopmodel.shop_se_price floatValue]*self.shopmodel.shop_num.intValue];
    bottomMoneyLabel2.text=[NSString stringWithFormat:@"-¥%.2f",_post_money.floatValue];
    if(_affirmType == OneYuanType)
    {
        bottomMoneyLabel1.text=[NSString stringWithFormat:@"¥%.1f",self.isNewbie?0:[DataManager sharedManager].app_value*self.shopmodel.shop_num.intValue];
        bottomMoneyLabel2.text=@"";
    }
    
    bottomMoneyLabel1.textColor=tarbarrossred;
    bottomMoneyLabel2.textColor=tarbarrossred;
    bottomMoneyLabel1.font=[UIFont systemFontOfSize:ZOOM(37)];
    bottomMoneyLabel2.font=[UIFont systemFontOfSize:ZOOM(37)];
    bottomMoneyLabel1.textAlignment=NSTextAlignmentRight;
    bottomMoneyLabel2.textAlignment=NSTextAlignmentRight;
    [self.OrderView addSubview:bottomMoneyLabel1];
    [self.OrderView addSubview:bottomMoneyLabel2];

    //加入分享抵扣的价格显示
    if (_shareReductionPrice&&_shareReductionPrice.length) {
        UILabel *bottomMoneyLabel3=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-right, yPoint+ZOOM(100)*2, kScreenWidth/2, ZOOM(100))];
        bottomMoneyLabel3.text=[NSString stringWithFormat:@"-¥%.2f",_shareReductionPrice.floatValue];
        bottomMoneyLabel3.textColor=tarbarrossred;
        bottomMoneyLabel3.font=[UIFont systemFontOfSize:ZOOM(37)];
        bottomMoneyLabel3.textAlignment=NSTextAlignmentRight;
        [self.OrderView addSubview:bottomMoneyLabel3];
    }

    if (_affirmType==NormalType) {
        bottomLabel4=[[UILabel alloc]initWithFrame:CGRectMake(left, yPoint+ZOOM(100)*3, kScreenWidth/2, ZOOM(100))];
        bottomLabel5=[[UILabel alloc]initWithFrame:CGRectMake(left, yPoint+ZOOM(100)*4, kScreenWidth/2, ZOOM(100))];
        bottomLabel4.text=@"优惠券";
        bottomLabel5.text=@"积分";
        bottomLabel4.font=[UIFont systemFontOfSize:ZOOM(48)];
        bottomLabel5.font=[UIFont systemFontOfSize:ZOOM(48)];
        [self.OrderView addSubview:bottomLabel4];
        [self.OrderView addSubview:bottomLabel5];
        bottomMoneyLabel3=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-right, yPoint+ZOOM(100)*2, kScreenWidth/2, ZOOM(100))];
        bottomMoneyLabel4=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-right, yPoint+ZOOM(100)*3, kScreenWidth/2, ZOOM(100))];
        bottomMoneyLabel5=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-right, yPoint+ZOOM(100)*4, kScreenWidth/2, ZOOM(100))];
        bottomMoneyLabel3.text=[NSString stringWithFormat:@"-¥%.1f",_shopmodel.voucher.floatValue];
        bottomMoneyLabel4.text=@"-¥0.0";
        bottomMoneyLabel5.text=@"-¥0.0";
        bottomMoneyLabel3.textColor=tarbarrossred;
        bottomMoneyLabel4.textColor=tarbarrossred;
        bottomMoneyLabel5.textColor=tarbarrossred;
        bottomMoneyLabel3.font=[UIFont systemFontOfSize:ZOOM(37)];
        bottomMoneyLabel4.font=[UIFont systemFontOfSize:ZOOM(37)];
        bottomMoneyLabel5.font=[UIFont systemFontOfSize:ZOOM(37)];
        bottomMoneyLabel3.textAlignment=NSTextAlignmentRight;
        bottomMoneyLabel4.textAlignment=NSTextAlignmentRight;
        bottomMoneyLabel5.textAlignment=NSTextAlignmentRight;

        [self.OrderView addSubview:bottomMoneyLabel3];
        [self.OrderView addSubview:bottomMoneyLabel4];
        [self.OrderView addSubview:bottomMoneyLabel5];
    }
   
    
//    self.OrderView.frame=CGRectMake(0,0, kApplicationWidth, ZOOM(20)*2+ZOOM(100)*5+40+ZOOM(62)+cell_LabelHeight*6+ZOOM(32)*2);

//    [_ShopTableView beginUpdates];
//    [_ShopTableView setTableFooterView:_OrderView];
//    [_ShopTableView endUpdates];
    
    if (_affirmType==MemberType) {
        _integralLabel.hidden=YES;
        _integralSwitch.hidden=YES;
        discount.hidden=YES;
        _spaceView.hidden=YES;

    }
//    [self fontAndSize];
}
-(void)voucherSwitchClick:(UISwitch*)sch
{
    if (sch.on) {
        
            _shopmodel.voucher=[NSString stringWithFormat:@"%d",[self vouchersMatch:_shopmodel]];
        
    }else{

        for (int i=0; i<_shopmodel.usedNunArray.count; i++) {
            for (VoucherModel *model2 in self.voucherArr) {
                if ([_shopmodel.priceArray[i]integerValue]==model2.price) {
                    model2.usedNum -= [_shopmodel.usedNunArray[i]intValue];
                    _shopmodel.voucher=@"0";
                }
            }
        }
        [_shopmodel.usedNunArray removeAllObjects];
        [_shopmodel.priceArray removeAllObjects];

        
    }
    
    vouchersMoney.text=[NSString stringWithFormat:@"可抵用¥%.1f",_shopmodel.voucher.floatValue];
    bottomMoneyLabel3.text=[NSString stringWithFormat:@"-¥%.1f",_shopmodel.voucher.floatValue];
    
    [self changTotalPrice];
}
-(void)fontAndSize
{

    
    self.couponImg.frame=CGRectMake(kApplicationWidth-right-self.couponImg.frame.size.width, self.couponImg.frame.origin.y, self.couponImg.frame.size.width, self.couponImg.frame.size.height);
    self.couponLabel.font=[UIFont systemFontOfSize:ZOOM(48)];
    //    self.integralLabel.font=[UIFont systemFontOfSize:ZOOM(48)];
    
    self.subIntegral.font=[UIFont systemFontOfSize:ZOOM(35)];
    
    self.subIntegral.frame=CGRectMake(left, self.subIntegral.frame.origin.y, self.subIntegral.frame.size.width, self.subIntegral.frame.size.height);
    self.couponLabel.frame=CGRectMake(left, self.couponLabel.frame.origin.y, self.couponLabel.frame.size.width, self.couponLabel.frame.size.height);

}
-(void)integralSwitchClick
{
    if (integralString.integerValue<500) {
        [MBProgressHUD showError:@"至少使用500积分"];
        [_integralSwitch setOn:NO];
    }else{
        integarlPrice = _integralSwitch.on ? integralString.integerValue :0;
        [self changTotalPrice];
    }
}
-(void)deleteAddress:(NSNotification *)note
{
    AddressModel *model=note.object;
    NSMutableString *addressstr =[[NSMutableString alloc]init];
    if(model.addressArray.count != 0 )
    {
        for(int i=0;i<model.addressArray.count;i++)
        {
            [addressstr appendString:model.addressArray[i]];
        }
    }
    //%@  %@",_address.text,[NSString stringWithFormat:@"收货地址:%@%@",addressstr,model.address]);
    if ([self.address.text isEqualToString:[NSString stringWithFormat:@"收货地址:%@%@",addressstr,model.address]]) {
        [self DeliveryHttp];
    }
}
#pragma mark - ************* 更换收货地址
-(void)changeaddress:(NSNotification*)note
{
  
    
    [self createDetailAddressView];
    
    AddressModel *model=note.object;
    
    NSMutableString *addressstr =[[NSMutableString alloc]init];
    if(model.addressArray.count != 0 )
    {
        for(int i=0;i<model.addressArray.count;i++)
        {
            [addressstr appendString:model.addressArray[i]];
        }
    }
    
    self.addressid=[NSString stringWithFormat:@"%@",model.ID];
    self.name.text=[NSString stringWithFormat:@"收货人:%@   %@",model.consignee ,model.phone ];
    self.address.text=[NSString stringWithFormat:@"收货地址:%@%@",addressstr,model.address];
    _isnotifation =YES;
}


#pragma mark - 设置收获地址
-(void)settingAddress:(UITapGestureRecognizer*)tap
{

    TFReceivingAddressViewController *tfreceiving=[[TFReceivingAddressViewController alloc]init];
    tfreceiving.adresstype = @"选择收货地址";
    [self.navigationController pushViewController:tfreceiving animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.shopArray.count){
        return  self.shopArray.count;
    }
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [MBProgressHUD hideHudForView:self.view];
    
    if (_affirmType==IndianaType||_affirmType==SignType) {
        return;
    }
    if(self.shopmodel.p_type!=nil){
        
//        ComboShopDetailViewController *detail=[[ComboShopDetailViewController alloc] initWithNibName:@"ComboShopDetailViewController" bundle:nil];
//        detail.shop_code = self.shopmodel.shop_code;
//        detail.stringtype=@"订单详情";
//        detail.hidesBottomBarWhenPushed=YES;
//        [self.navigationController pushViewController:detail animated:YES];
    }else{

        ShopDetailViewController *shopdetail=[[ShopDetailViewController alloc]init];
        ShopDetailModel *shopdetailmodel=self.shopmodel;
        shopdetail.stringtype = @"订单详情";
        SCarCell *cell = (SCarCell*)[tableView cellForRowAtIndexPath:indexPath];
        shopdetail.bigimage=cell.headimage.image;
        shopdetail.shop_code=shopdetailmodel.shop_code;
        [self.navigationController pushViewController:shopdetail animated:NO];
        
    }
    
    
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCarCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell=[[SCarCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }else{

        NSURL *imgUrl;
        if(_affirmType==NormalType){
            cell.title.text=[NSString stringWithFormat:@"%@",[self exchangeTextWihtString: _selectName]];
            cell.zeroTypeLabel.hidden=YES;
            cell.color_size.hidden=NO;
            cell.shop_oldPrice.hidden=NO;
            cell.line.hidden=NO;

            if (_affirmType==MemberType) {
                cell.changeNumTextField.hidden=YES;
                cell.minusBtn.hidden=YES;
                cell.plusBtn.hidden=YES;
            }
            cell.color_size.text=[NSString stringWithFormat:@"颜色:%@  尺码:%@",self.color,self.size];
            cell.shop_oldPrice.text = [NSString stringWithFormat:@"¥%.1f",[self.shopmodel.shop_price floatValue]];
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(46)]};
            CGSize textSize = [cell.shop_oldPrice.text boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
            cell.line.frame = CGRectMake(cell.shop_oldPrice.frame.origin.x, cell.line.frame.origin.y, textSize.width, cell.line.frame.size.height);
            cell.line.center = cell.shop_oldPrice.center;
            //        cell.changeNum.text = [NSString stringWithFormat:@"%@",self.number];
            cell.changeNum.hidden=YES;
            cell.changeNumTextField.text = [NSString stringWithFormat:@"%@",self.number];
            cell.changeNumTextField.delegate=self;
            cell.changeNumTextField.tag=cellChangNumTag;
            
            NSMutableString *code = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",self.shopmodel.shop_code]];
            NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
            MyLog(@"supcode =%@",supcode);
            NSString *codestr = [NSString stringWithFormat:@"%@/%@",supcode,code];
            imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@!180",[NSObject baseURLStr_Upy],codestr,self.shopmodel.def_pic]];

            cell.price.text=[NSString stringWithFormat:@"¥%.1f",[_selectPrice floatValue]];
            cell.number.text=[NSString stringWithFormat:@"x%@",self.number];
            cell.number.textColor=kTextGreyColor;
            
            [cell.minusBtn addTarget:self action:@selector(minusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.plusBtn addTarget:self action:@selector(plusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            cell.zeroTypeLabel.hidden=YES;
            cell.color_size.hidden=_affirmType==OneYuanType?NO:YES;
            cell.shop_oldPrice.hidden=_affirmType==OneYuanType?NO:YES;
        
//            cell.line.hidden=_affirmType==OneYuanType?YES:NO;
            cell.changeNumTextField.hidden=YES;
            cell.minusBtn.hidden=YES;
            cell.plusBtn.hidden=YES;
            
            NSMutableString *code = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",self.shopmodel.shop_code]];
            NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
            NSString *codestr = [NSString stringWithFormat:@"%@/%@",supcode,code];
            imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@!180",[NSObject baseURLStr_Upy],codestr,self.shopmodel.def_pic]];
            cell.title.text=[NSString stringWithFormat:@"%@",_shopmodel.shop_name];
            cell.color_size.text=[NSString stringWithFormat:@"颜色:%@  尺码:%@",self.color,self.size];

            cell.number.text=[NSString stringWithFormat:@"x%@",self.number];
            cell.number.textColor=kTextGreyColor;

            NSString *oldPrice = [NSString stringWithFormat:@" ¥%.2f",[_shopmodel.shop_price floatValue]];
            NSString *str=[NSString stringWithFormat:@"¥%.2f  ¥%.2f",[_shopmodel.shop_se_price floatValue],[_shopmodel.shop_price floatValue]];
            if(_affirmType == OneYuanType)//1元购
            {
                str=[NSString stringWithFormat:@"¥%.1f",self.isNewbie?0: [DataManager sharedManager].app_value];
                CGFloat priceWith = [self getRowWidth:str fontSize:ZOOM6(30)];
                CGFloat oldpriceWith = [self getRowWidth:oldPrice fontSize:ZOOM6(24)];
                cell.shop_oldPrice.frame = CGRectMake(CGRectGetMinX(cell.price.frame)+priceWith+ZOOM6(20), cell.shop_oldPrice.origin.y, oldpriceWith, cell.shop_oldPrice.size.height);
                cell.shop_oldPrice.text = oldPrice;
                cell.price.text = str;
                if(self.shopmodel.supp_label.length >0)
                {
                    cell.brandLabel.text = self.shopmodel.supp_label;
                }
                cell.line.width = oldpriceWith;
                cell.line.center = cell.shop_oldPrice.center;
            }else{
                NSMutableAttributedString *attriStr = [NSString getOneColorInLabel:str ColorString:oldPrice Color:kTextColor fontSize:ZOOM6(24)];
                [cell.price setAttributedText:attriStr];
                
                NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM6(30)]};
                CGSize textSize = [[NSString stringWithFormat:@"¥%.2f  ",[_shopmodel.shop_se_price floatValue]] boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
                cell.line.frame = CGRectMake(cell.price.frame.origin.x+textSize.width, cell.line.frame.origin.y, [NSString widthWithString:oldPrice font:kFont6px(24) constrainedToHeight:20], cell.line.frame.size.height);
            }
            
//            NSMutableAttributedString *attriStr = [NSString getOneColorInLabel:str ColorString:oldPrice Color:kTextColor fontSize:ZOOM6(24)];
//            NSRange rang=[str rangeOfString:oldPrice];
//            [attriStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlinePatternSolid | NSUnderlineStyleSingle] range:rang];
//            [attriStr addAttribute:NSStrikethroughColorAttributeName value:[UIColor lightGrayColor] range:rang];
//            [cell.price setAttributedText:attriStr];
//            cell.price.frame = CGRectMake(cell.price.frame.origin.x, cell.price.frame.origin.y, [NSString widthWithString:oldPrice font:kFont6px(24) constrainedToHeight:20], cell.price.frame.size.height);
            
//            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM6(30)]};
//            CGSize textSize = [[NSString stringWithFormat:@"¥%.2f  ",[_shopmodel.shop_se_price floatValue]] boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
//            cell.line.frame = CGRectMake(cell.price.frame.origin.x+textSize.width, cell.line.frame.origin.y, [NSString widthWithString:oldPrice font:kFont6px(24) constrainedToHeight:20], cell.line.frame.size.height);
            
            cell.line.backgroundColor = kTextColor;
        }


        
        __block float d = 0;
        __block BOOL isDownlaod = NO;
        [cell.headimage sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            d = (float)receivedSize/expectedSize;
            isDownlaod = YES;
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image != nil && isDownlaod == YES) {
                cell.headimage.alpha = 0;
                [UIView animateWithDuration:0.5 animations:^{
                    cell.headimage.alpha = 1;
                } completion:^(BOOL finished) {
                }];
            } else if (image != nil && isDownlaod == NO) {
                cell.headimage.image = image;
            }
        }];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

-(CGFloat)getRowWidth:(NSString *)text fontSize:(CGFloat)fontSize
{
    //文字高度
    CGFloat width;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(kScreenWidth, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        width=rect.size.width;
        
    }
    else{
        
    }
    
    return width;
}

#pragma mark - 减
-(void)minusBtnClick:(UIButton *)sender
{
    SCarCell * cell;
    if (kIOSVersions >= 7.0 && kIOSVersions < 8) {
        cell = [[(SCarCell *)[sender superview]superview]superview] ;
    }else{
        cell = (SCarCell *)[[sender superview] superview];
    }
    //    SCarCell * cell = (SCarCell *)[[sender superview] superview];
    NSIndexPath * path = [_ShopTableView indexPathForCell:cell];
    if(cell.changeNumTextField.text.intValue>1)
    {
        self.shopmodel.shop_num = [NSString stringWithFormat:@"%d",cell.changeNumTextField.text.intValue -1];
        cell.changeNumTextField.text=[NSString stringWithFormat:@"%d",cell.changeNumTextField.text.intValue-1];
        cell.number.text=[NSString stringWithFormat:@"x%d",cell.changeNumTextField.text.intValue];
        [self httpMatchCoupon:[NSString stringWithFormat:@"%@:%.1f",self.shopmodel.supp_id,memberPriceRate*self.shopmodel.shop_num.intValue*self.shopmodel.shop_se_price.floatValue]];
        _number=cell.changeNumTextField.text;
        
        [self changeVouchers];
        
        [self changTotalPrice];
    }

}
-(void)changeVouchers
{
//    vouchersSwitch.on=YES;
    if (vouchersSwitch.on) {
        _shopmodel.voucher=[NSString stringWithFormat:@"%d",[self vouchersMatch:_shopmodel]];
        [vouchersSwitch setOn:_shopmodel.voucher.floatValue>0?YES:NO];
        vouchersMoney.text=[NSString stringWithFormat:@"可抵用¥%.1f",_shopmodel.voucher.floatValue];
        bottomMoneyLabel3.text=[NSString stringWithFormat:@"-¥%.1f",_shopmodel.voucher.floatValue];
    }
}
-(void)plusBtnClick:(UIButton * )sender
{
    SCarCell * cell;
    if (kIOSVersions >= 7.0 && kIOSVersions < 8) {
        cell = [[(SCarCell *)[sender superview]superview]superview] ;
    }else{
        cell = (SCarCell *)[[sender superview] superview];
    }

    if(cell.changeNumTextField.text.intValue<[self changestock].intValue){
        self.shopmodel.shop_num = [NSString stringWithFormat:@"%d",cell.changeNumTextField.text.intValue +1];
        cell.changeNumTextField.text=[NSString stringWithFormat:@"%d",cell.changeNumTextField.text.intValue+1];
        cell.number.text=[NSString stringWithFormat:@"x%d",cell.changeNumTextField.text.intValue];
        [self httpMatchCoupon:[NSString stringWithFormat:@"%@:%.1f",self.shopmodel.supp_id,memberPriceRate*self.shopmodel.shop_num.intValue*self.shopmodel.shop_se_price.floatValue]];
        _number=cell.changeNumTextField.text;
        
        [self changeVouchers];
        
       
        [self changTotalPrice];
        
    }else{
        [MBProgressHUD showError:@"库存不足" toView:self.view];
    }

}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.changeTextField = textField;
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.tag==cellChangNumTag)
    {
        SCarCell * cell;
        if (kIOSVersions >= 7.0 && kIOSVersions < 8) {
            cell = [[(SCarCell *)[textField superview]superview]superview] ;
        }else{
            cell = (SCarCell *)[[textField superview] superview];
        }
        
        if (cell.changeNumTextField.text.intValue==0||cell.changeNumTextField.text.length==0) {
            cell.changeNumTextField.text=[NSString stringWithFormat:@"%@",self.number];
        }
        else if(cell.changeNumTextField.text.intValue<=[self changestock].intValue) {
            self.number=[NSString stringWithFormat:@"%d",textField.text.intValue];
            
            self.shopmodel.shop_num = [NSString stringWithFormat:@"%@",self.number];
            cell.changeNumTextField.text=[NSString stringWithFormat:@"%@",self.number];
            cell.number.text=[NSString stringWithFormat:@"x%d",cell.changeNumTextField.text.intValue];
            
            [self changTotalPrice];
            
        }
        else {
            cell.changeNumTextField.text=[NSString stringWithFormat:@"%@",self.number];
            [MBProgressHUD showError:@"库存不足" toView:self.view];
            
        }
        
        [self changeVouchers];
        
        
        //        [self changeshopHttp:path.row typeid:model.stock_type_id withIndex:path];
    }
    else if (textField == self.Message)
    {
        
    }
}
#pragma mark 数量减
-(void)reduce:(UIButton*)sender
{
    SCarCell * cell;
    if (kIOSVersions >= 7.0 && kIOSVersions < 8) {
        cell = [[(SCarCell *)[sender superview]superview]superview] ;
    }else{
        cell = (SCarCell *)[[sender superview] superview];
    }
    //    SCarCell * cell = (SCarCell *)[[sender superview] superview];
    
    if(cell.changeNum.text.intValue>1)
    {
        NSIndexPath * path = [_ShopTableView indexPathForCell:cell];
        ShopDetailModel *model=self.shopArray[path.row];
        NSString *str = [cell.price.text substringFromIndex:1];
        tempTotalprice = [[self.totalprice.text substringFromIndex:1] floatValue]-([str intValue]*model.shop_num.intValue);
        tempShop_num =[NSString stringWithFormat:@"%d",model.shop_num.intValue-1];
        [self changeshopHttp:cell.shop_model typeid:cell.shop_model.stock_type_id withIndex:path shop_num:tempShop_num];
        
    }
    
}

-(void)addbtn:(UIButton*)sender
{
    SCarCell * cell;
    if (kIOSVersions >= 7.0 && kIOSVersions < 8) {
        cell = [[(SCarCell *)[sender superview]superview]superview] ;
    }else{
        cell = (SCarCell *)[[sender superview] superview];
    }
    //    SCarCell * cell = (SCarCell *)[[sender superview] superview];
    NSIndexPath * path = [_ShopTableView indexPathForCell:cell];
    ShopDetailModel *model=self.shopArray[path.row];
    NSString *str = [cell.price.text substringFromIndex:1];
    tempTotalprice = [[self.totalprice.text substringFromIndex:1] floatValue]-([str intValue]*model.shop_num.intValue);
    tempShop_num =[NSString stringWithFormat:@"%d",model.shop_num.intValue+1];
    [self changeshopHttp:cell.shop_model typeid:cell.shop_model.stock_type_id withIndex:path shop_num: tempShop_num ];
    
}
#pragma mark 改变购物车商品网络请求
-(void)changeshopHttp:(ShopDetailModel *)model typeid:(NSString*)typeid withIndex:(NSIndexPath*)index shop_num:(NSString*)shop_num;
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString*token=[user objectForKey:USER_TOKEN];
    NSString*user_id=[user objectForKey:USER_ID];
    
    NSString *url=[NSString stringWithFormat:@"%@shopCart/update?version=%@&token=%@&id=%@&size=%@&color=%@&shop_num=%@&stock_type_id=%@",[NSObject baseURLStr],VERSION,token,model.ID,model.shop_size,model.shop_color,shop_num,typeid];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       // responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            
            NSString *message=responseObject[@"message"];
//            //
            NSString *statu=responseObject[@"status"];
            
            if(statu.intValue==1)//请求成功
            {
                [self func:YES with:index];
                
            }else{
                NSString *str=[NSString stringWithFormat:@"%@,请稍后重试",message];
                UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                //            [alter show];
                [self func:NO with:index];
            }
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
//            //===== 请求超时");
            
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
            
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
    
    
    
}

- (void)func:(BOOL)bl with:(NSIndexPath*)index
{
    if (bl) {
        SCarCell * cell = (SCarCell *)[_ShopTableView cellForRowAtIndexPath:index];
        ShopDetailModel *model=self.shopArray[index.row];
        model.shop_num =[NSString stringWithFormat:@"%@",tempShop_num];
        cell.changeNum.text=[NSString stringWithFormat:@"%@",tempShop_num];
        cell.number.text=[NSString stringWithFormat:@"x%d",cell.changeNum.text.intValue ];
        self.totalprice.text=[NSString stringWithFormat:@"¥%.1f",tempTotalprice+[cell.shop_model.shop_se_price floatValue]*cell.changeNum.text.intValue];
        _pricelable.text = self.totalprice.text;
        
        [self httpMatchCoupon:[NSString stringWithFormat:@"%@:%.1f",self.shopmodel.supp_id,model.shop_num.intValue*self.shopmodel.shop_se_price.floatValue]];
    }
}

#pragma mark 商品库存分类
-(NSString*)changestock
{
    NSString *stockstring;
    if(_selectColorID!=nil &&_selectSizeID!=nil)
    {
        NSMutableString *typeidString=[NSMutableString string];
        [typeidString appendString:_selectColorID];
        [typeidString appendString:@":"];
        [typeidString appendString:_selectSizeID];
        
        NSMutableArray *stockarr=[NSMutableArray array];
        if([self.typestring isEqualToString:@"兑换"])
        {
            stockarr=[NSMutableArray arrayWithArray:_JifenshopArray];
        }else{
            stockarr=[NSMutableArray arrayWithArray:_stocktypeArray];
        }
        for(int i=0;i<stockarr.count;i++)
        {
            ShopDetailModel *model=stockarr[i];
            if([model.color_size isEqualToString:typeidString])
            {
                //商品库存
                stockstring=[NSString stringWithFormat:@"%@",model.stock];
            }
        }
        
    }
    
    return stockstring;
    
}


#pragma mark 获取商品链接请求
- (void)shopRequest
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *realm = [user objectForKey:USER_ID];
    NSString *token = [user objectForKey:USER_TOKEN];
    
    [DataManager sharedManager].key = self.shopmodel.share_shop;
    
    NSString *url=[NSString stringWithFormat:@"%@shop/getpShopLink?version=%@&p_code=%@&realm=%@&token=%@&share=%@&getPShop=true",[NSObject baseURLStr],VERSION,self.shopmodel.shop_code,realm,token,@"2"];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [[Animation shareAnimation] CreateAnimationAt:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        //responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            
            NSString *str=responseObject[@"status"];
            
            if(str.intValue==1)
            {
                if(self.shopmodel.p_type != nil)//非正价商品
                {
                    NSArray * shoparr =responseObject[@"Pshop"];
                    
                    if(shoparr.count)
                    {
                        int dex = arc4random() % shoparr.count;
                        
                        NSDictionary *shopdic  = shoparr[dex];
                        
                        NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
                        
                        if(shopdic !=NULL || shopdic!=nil)
                        {
                            if(shopdic[@"four_pic"])
                            {
                                [userdefaul setObject:[NSString stringWithFormat:@"%@",shopdic[@"four_pic"]] forKey:SHOP_PIC];
                            }
                        }
                        
                        if(responseObject[@"link"])
                        {
                            [userdefaul setObject:[NSString stringWithFormat:@"%@",responseObject[@"link"]] forKey:QR_LINK];
                        }
                        
                        if(responseObject[@"price"])
                        {
                            CGFloat price = [responseObject[@"price"] floatValue]/shoparr.count;
                            
                            [userdefaul setObject:[NSString stringWithFormat:@"%f",price] forKey:SHOP_PRICE];
                        }
                        
                        
                        if( [shopdic[@"four_pic"] isEqualToString:@"null"] || !responseObject[@"link"])
                        {
                            
                            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
                            [mentionview showLable:@"数据获取异常，稍后重试" Controller:self];
                            
                            return;
                        }

                    }
                
                }else{
                    
                    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
                    
                    NSString *shareShopurl=@"";
                    shareShopurl=responseObject[@"link"];
                    if(shareShopurl)
                    {
                        [userdefaul setObject:[NSString stringWithFormat:@"%@",shareShopurl] forKey:QR_LINK];
                    }
                    
                    NSDictionary *shopdic  = responseObject[@"shop"];
                    
                    if(shopdic !=NULL || shopdic!=nil)
                    {
                        
                        if(shopdic[@"four_pic"])
                        {
                            
                            NSArray *imageArray = [shopdic[@"four_pic"] componentsSeparatedByString:@","];
                            
                            NSString *imgstr;
                            if(imageArray.count > 2)
                            {
                                imgstr = imageArray[2];
                        
                            }else if (imageArray.count > 0)
                            {
                                imgstr = imageArray[0];
                            }
                            
                            //获取供应商编号
                            
                            NSMutableString *code ;
                            NSString *supcode  ;
                            
                            if(shopdic[@"shop_code"])
                            {
                                code = [NSMutableString stringWithString:shopdic[@"shop_code"]];
                                supcode  = [code substringWithRange:NSMakeRange(1, 3)];
                            }
                            
                            [userdefaul setObject:[NSString stringWithFormat:@"%@/%@/%@",supcode,code,imgstr] forKey:SHOP_PIC];
                        }
                        
                        NSString *price = shopdic[@"shop_se_price"];
                        
                        if(price)
                        {
                            [userdefaul setObject:price forKey:SHOP_PRICE];
                        }
                        
                        NSString *name = shopdic[@"shop_name"];
                        
                        if(name !=nil && ![name isEqual:[NSNull null]])
                        {
                            [userdefaul setObject:name forKey:SHOP_NAME];
                        }
                    }
                    
                    
                    if( !shareShopurl)
                    {
                        return;
                    }

                }
                
                //判断设备是否安装微信
                
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]){
                    
                    [self shareToWeiXin];
                    
                }else{
                    NavgationbarView *mentionview = [[NavgationbarView alloc]init];
                    [mentionview showLable:@"亲,还没有安装微信暂不能分享" Controller:self];
                }

            }
            else if(str.intValue==1050)
            {
                
                
            }
            
            else{
                
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:@"网络异常，请稍后重试" Controller:self];
            }
            
            
        }
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        //网络连接失败");
        [[Animation shareAnimation] stopAnimationAt:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
        
    }];
    
    
}


-(void)shareToWeiXin
{
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]])//是否安装微信
    {
        
        if (self.shopmodel.p_type!=nil || _affirmType==IndianaType||_affirmType==SignType) {
            ZeroShopShareViewController *zeroShop = [[ZeroShopShareViewController alloc]init];
            zeroShop.shop_seprice = _shop_seprice;
            zeroShop.urlcount=_urlcount;
            zeroShop.order_code=_order_code;
            zeroShop.shopArray=self.shopArray;
            zeroShop.p_type = @"5";
            zeroShop.p_code = self.shopmodel.shop_code;
            
            zeroShop.typestr = @"夺宝";
            
            NSUserDefaults *users=[NSUserDefaults standardUserDefaults];
            [users setObject:self.shopmodel.shop_code forKey:SHOP_CODE];
            
            [self.navigationController pushViewController:zeroShop animated:YES];
        }else{
            
            NSUserDefaults *users=[NSUserDefaults standardUserDefaults];
            [users setObject:self.shopmodel.shop_code forKey:SHOP_CODE];
            [users setObject:self.shopmodel.voucher forKey:KICKBACK];
        
            IntelligenceViewController *intell=[[IntelligenceViewController alloc]init];
        
            intell.isshare = @"yes";
            
            [self.navigationController pushViewController:intell animated:YES];
        }
        
    }else{
         confirmButton.userInteractionEnabled=YES;
        NSString *message;
        if(self.shopmodel.p_type!=nil)
        {
            message = @"亲,购买0元购商品需要分享,请先安装微信再来哦~";
        }else{
            message = @"亲,使用抵用劵购买需要分享,请先安装微信再来哦~";
        }
        
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alter show];
        
    }
}
-(void)checkAddressNormal
{
    if(_DeliverArray.count>0 || (_name.text.length!=0 && _address.text.length!=0  && ![_address.text isEqualToString:@"收货地址:null"]) )
    {
        confirmButton.userInteractionEnabled=NO;
        
//        if(vouchersSwitch.on == YES||_affirmType==IndianaType||_affirmType==SignType)
        //修改  夺宝商品不需分享  直接跳转下单界面
        if(vouchersSwitch.on == YES||_affirmType==SignType)
        {
            [self shareToWeiXin];
        }else{
            [self OrderHttp];

        }
    
        
//        [self OrderHttp];
        
        
    }else{
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"你还没有设置收货地址,请设置" Controller:self];
    }
}
/**
 * @brief 生成当天的某个点（返回的是伦敦时间，可直接与当前时间[NSDate date]比较）
 * @param hour 如hour为“8”，就是上午8:00（本地时间）
 */
- (NSDate *)getCustomDateWithHour:(NSInteger)hour
{
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    
    //设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return [resultCalendar dateFromComponents:resultComps];
}
#pragma mark 判断某个时间是否在7~14点
- (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour
{
    NSDate *date7 = [self getCustomDateWithHour:7];
    NSDate *date14 = [self getCustomDateWithHour:14];
    
    NSDate *currentDate = [NSDate date];
    
    if ([currentDate compare:date7]==NSOrderedDescending && [currentDate compare:date14]==NSOrderedAscending)
    {
//        //该时间在 %d:00-%d:00 之间！", fromHour, toHour);
        return YES;
    }
    return NO;
}
/*
-(void)showAlertView2:(NSString *)ShareString
{
    TFNoviceTaskView *noviceTaskView = [[TFNoviceTaskView alloc] init];
    [noviceTaskView returnClick:^(NSInteger type) {
        
        [self httpGetRandShopWithType:ShareString];

    } withCloseBlock:^(NSInteger type) {
        
    }];
    [noviceTaskView showWithType:@"10"];
}
-(void)showAlertView
{
    self.dailyTsakView = [[TFDailyTaskView alloc] init];
    [self.dailyTsakView returnClick:^(NSInteger type) {
        NewSigninViewController *newSign = [[NewSigninViewController alloc]init];
        [self.navigationController pushViewController:newSign animated:YES];

    } withCloseBlock:^(NSInteger type) {
        
    }];
    [self.dailyTsakView showWithType:@"8_3"];
}
*/
#pragma mark 确认订单到支付界面
-(void)affirmorder:(UIButton*)sender
{
    [MobClick event:SHOP_ORDER];
  
//    if (self.shopmodel.p_type!=nil) {
//        if (_isShare) {
//            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
//            [mentionview showLable:@"请勿重复下单" Controller:self];
//        }else{
//            [self checkWthereIsOneBuy];
//            
//            if(_isOneBuy.integerValue==1||(integralString.floatValue >= _needIntegral.floatValue&&_isOneBuy.integerValue!=3&&_isOneBuy.integerValue!=5))
//                [self checkAddress];
//        }
//    }else
    
        [self checkAddressNormal];

}
/*
-(void)checkWthereIsOneBuy
{
    switch (_isOneBuy.intValue) {
        case 0:     //不是第一次购买
        {
            if (_needIntegral==nil) {
                _needIntegral=@"0";
            }
            
            if(integralString.floatValue >= _needIntegral.floatValue)
            {
                //                [self checkAddress];
                NSMutableAttributedString *noteStr ;
                
                NSString *str = [NSString stringWithFormat:@"已自动使用%@积分",_needIntegral];
                
                if([str isEqual:@"已自动使用0积分"])
                {
                    noteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"本单最多可使用%@积分,抵用0.00元",_needIntegral]];
                    
                    }else{
                    
                        noteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"已自动使用%@积分",_needIntegral]];
                        
                        [noteStr addAttributes:@{NSForegroundColorAttributeName:tarbarrossred} range:NSMakeRange(5, _needIntegral.length)];

                }
                
                [self.subIntegral setAttributedText:noteStr];
            }else{
                self.subIntegral.text=[NSString stringWithFormat:@"本单最低需%d积分，积分不足",_needIntegral.intValue];
                BOOL result = [self isBetweenFromHour:7 toHour:14];
                NSDictionary *currDic = [NSDictionary dictionaryWithObjectsAndKeys:[MyMD5 getCurrTimeString:@"year-month-day"], @"year-month-day", nil];
                if(result == YES) //上午分享美衣到朋友圈
                {
                    NSDictionary *oldDic = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:USER_ID],DailyTaskMorningShare]];
                    if (oldDic == nil||![oldDic[@"year-month-day"] isEqualToString:currDic[@"year-month-day"]]) { //不是同一天
                        [self showAlertView2:DailyTaskMorningShare];
                    }else{
                        [self showAlertView];
                    }
                }else if(result == NO)//下午分享美衣到朋友圈
                {
                    NSDictionary *oldDic = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:USER_ID],DailyTaskAfternoonShare]];
                    if (oldDic == nil||![oldDic[@"year-month-day"] isEqualToString:currDic[@"year-month-day"]]) { //不是同一天
                        [self showAlertView2:DailyTaskAfternoonShare];
                    } else{
                        [self showAlertView];
                    }
                }
            }
            
        }
            break;
        case 1:     //是第一次
            //            [self checkAddress];
            //            [self shareToWeiXin];
            
            MyLog(@"是第一次");
            
            break;
        case 3:     //不在售（套餐已关闭）
        {   NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"此套餐已关闭" Controller:self];
        }
            break;
        case 5:     //非手机用户
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"购买0元商品请先绑定手机哦" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
            
        }
            break;
        default:
            
            //            [self shareToWeiXin];
            //            [self checkAddress];
            
            
            break;
    }
}
*/
-(void)checkAddress
{
    if(_DeliverArray.count>0 || (_name.text.length!=0 && _address.text.length!=0  && ![_address.text isEqualToString:@"收货地址:null"]) )
    {
        confirmButton.userInteractionEnabled=NO;
        //        [self OrderHttp];
        
        [self shopRequest];
    }else{
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"你还没有设置收货地址,请设置" Controller:self];
    }
}


- (void)zeroBuyRemindView {
    TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] initWithTitle:@"温馨提示" message:@"每日仅有一次0元购美衣的机会哦。错过就木有啦。" showCancelBtn:NO leftBtnText:@"0元也不要" rightBtnText:@"要要要"];
    popView.textAlignment=NSTextAlignmentCenter;
    popView.isManualDismiss = YES;
    popView.showView = self.view;
    
    kSelfWeak;
    [popView showCancelBlock:^{
        [popView dismissAlert:YES];

        [weakSelf.navigationController popViewControllerAnimated:YES];

    } withConfirmBlock:^{
        [popView dismissAlert:YES];
    } withNoOperationBlock:^{

    }];

}
-(void)back:(UIButton*)sender
{
//    [self zeroBuyRemindView];
    
    
    [self.view endEditing:YES];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:nil message:@"这么好的宝贝,确定不要了吗?"  preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"我再想想" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }];
        [alertCtrl addAction:cancelAction];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertCtrl addAction:okAction];
        [self presentViewController:alertCtrl animated:YES completion:nil];
        
    }else{
        
        UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:nil message:@"这么好的宝贝,确定不要了吗?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"我再想想",@"确定", nil];
        alterview.delegate = self;
        alterview.tag = 8787;
        [alterview show];
    }
}

#if 0
#pragma mark 去留选择框
-(void)createPopView
{
    [self.view endEditing:YES];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    view.backgroundColor = [[UIColor colorWithRed:60/255.0 green:61/255.0 blue:62/255.0 alpha:0.8] colorWithAlphaComponent:0.7];
    //    view.alpha = 0.9;
    view.tag = 8888;
    
    
    UIView * smileView=[[UIView alloc]initWithFrame:CGRectMake(20, (kApplicationHeight-ZOOM(600))/2, kApplicationWidth-40, ZOOM(600))];
    smileView.backgroundColor=[UIColor whiteColor];
    
    
    CGFloat width = smileView.frame.size.width/2;
    CGFloat heigh = smileView.frame.size.height;
    
    NSArray *imageArray = @[@"employee",@"woman-avatar"];
    NSArray *sexArray = @[@"男",@"女"];
    
    UILabel *titlelable = [[UILabel alloc]initWithFrame:CGRectMake(0, ZOOM(50), smileView.frame.size.width, ZOOM(50))];
    titlelable.text = @"便宜不等人,请三思而行~";
    titlelable.font = [UIFont systemFontOfSize:ZOOM(47)];
    [smileView addSubview:titlelable];
    
    UILabel *linelable = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titlelable.frame), CGRectGetWidth(smileView.frame)-20, 1)];
    linelable.backgroundColor = kBackgroundColor;

    
    
    for(int i=0;i<2;i++)
    {
        UIView *backview =[[UIView alloc]initWithFrame:CGRectMake(width*i, 0, width, smileView.frame.size.height)];
        backview.tag = 7000+i;
        
        [smileView addSubview:backview];
        
//        UIImageView *image =[[UIImageView alloc]initWithFrame:CGRectMake(30, (heigh-IMAGEH(@"employee"))/2, IMAGEW(@"employee"), IMAGEH(@"employee"))];
//        
//        image.image =[UIImage imageNamed:imageArray[i]];
//        
//        [backview addSubview:image];
        
        CGFloat lableY =CGRectGetMaxX(image.frame);
        
        UILabel *lable =[[UILabel alloc]initWithFrame:CGRectMake(lableY+10, image.frame.origin.y, IMAGEW(@"employee"), IMAGEH(@"employee"))];
        lable.text = sexArray[i];
        lable.font = [UIFont systemFontOfSize:ZOOM(57)];
        [backview addSubview:lable];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sexclick:)];
        [backview addGestureRecognizer:tap];
        backview.userInteractionEnabled = YES;
        
        
        
        
        
    }
    
    
    [view addSubview:smileView];
    
    [self.view addSubview:view];
    
}

-(void)sexclick:(UITapGestureRecognizer*)tap
{
    
    UIView *view =(UIView*)[self.view viewWithTag:8888];
    [view removeFromSuperview];
    
    UITextField *fild =(UITextField*)[self.view viewWithTag:8002];
    
    UIView *baview = tap.view;
    if(baview.tag == 7000)
    {
        fild.text = @"男";
    }else{
        fild.text = @"女";
    }
    
}
#endif

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -支付宝支付
#pragma mark   ==============产生随机订单号==============
- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

-(void)payorder
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app zhifubaoArgumentHttp:self.order_code];
    
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    
    NSString *partner = [userdefaul objectForKey:PAY_PARTNER];
    NSString *seller = [userdefaul objectForKey:PAY_SELLER];
    NSString *privateKey = [userdefaul objectForKey:PAY_PRIVATE_KEY];
    NSString *payurl = [userdefaul objectForKey:PAY_URL];
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    
#if 0
    NSString *partner = @"2088911598493391";
    NSString *seller = @"yssj@91kwd.com";
    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAL7stj/CKUfmbQPogHn9DZtEuxLwSAy9FHsao0USmqRrbvAkMg+DMMhh9dSqHUCuN1DExbgAvhHto9jnsznh27vcFfMikdaGBZqUB1Te4I3fMhirbeSPdbGVE7AMOqvJq/girZDhJ6ieMQXC5+YuUQQT+ovzKvkNUjpvkKKl+a7ZAgMBAAECgYAvbK8MgVcts/AKU3tuUcxKcDUjzCmpeGIY/hHmO2vMQZ9p6SPCNK0uaR7eN29SvLOizW3recu8ulHDtDIRw6eHwT8YbRDwd9qBW58GnL1d8PfC6uw+/7f+YoHTkqrNIZvD1adDJJjyX9NSH662xyITuzpaL5NXbpYKYn8IVKWOvQJBAO++V2djL3pxH67L583EAdlGV39JzP21oMxCRqRCuVTS0DjcRjg/lG4cEW69t3sIN+V2+8pnULBBmO5xP1o41XsCQQDL3u8PPxvoIm7xHWLZSQpLv4EILG2O94ddXETmGWIeZ8AVzRCKHTN0ShOvmNZnCEbelBWb/pkIM4LYrVzqkdq7AkAQ+yhxuELKp2yZEvROTM3ct/DGoVGVvuGu1hru05MRAQWioWeP4GEBE5fggiuW2VQsOqtHAN5kPaE5cmgMWe41AkEAxhtIKoSk1ZpAPETV/VcgjiL1e7/QZpDaFTrIKOCZm/otigHPBKcDjQk+v+/AyDYex8MWjJOGmZWUnIE6PSamaQJBAKDxW+KJN3ihQx8NwU/wKKuPZe4hhtZNJ39VhzLUwhoYdrPXipoPT8qHnlVz73WSPesizGvGHTBLZWyeZy6iahI=";
#endif
    
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 || [seller length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    ShopDetailModel *model=self.shopmodel;
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    //    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.tradeNO =[NSString stringWithFormat:@"%@",self.order_code];
    //    order.productName = model.content; //商品标题
    //    order.productDescription = model.shop_name; //商品描述
    //    NSString* shop_price=@"0.01";
    
    if(! _shop_seprice)
    {
        _shop_seprice=@"0";
    }
    
    order.amount = [NSString stringWithFormat:@"%.2f",[_shop_seprice floatValue]]; //商品价格
    
    
    //    order.amount = @"0.01"; //商品价格
    order.productName = @"衣蝠——好的衣服没那么贵"; //商品标题
    order.productDescription = @"衣蝠——好的衣服没那么贵"; //商品描述
    //    order.notifyURL =  @"http://183.61.166.16:9090/cloud-api/alipay/appNotify "; //回调URL
    if(_urlcount.intValue > 1)
    {
        
        order.notifyURL = [NSString stringWithFormat:@"%@alipay/appNotifyList",payurl];
    }else{
        
        order.notifyURL = [NSString stringWithFormat:@"%@alipay/appNotify",payurl];
    }
    
    
    //    order.notifyURL = [NSString stringWithFormat:@"%@alipay/appNotify",[NSObject baseURLStr]];
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"YunShangShiJi";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    //orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            //reslut = %@",resultDic);
            NSLog(@"resultDic = %@",resultDic);
            
        }];
        
        
    }
    
    
}

#pragma mark 微信支付++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//微信支付
-(void)Winpay:(NSMutableDictionary*)dic Orderno:(NSString*)orderno
{
    AppDelegate *app=[[UIApplication sharedApplication] delegate];
    [app weixinArgumentHttp];
    
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    
    //本实例只是演示签名过程， 请将该过程在商户服务器上实现
    //创建支付签名对象
    payRequsestHandler *req = [payRequsestHandler alloc] ;
    //初始化支付签名对象
    
    
    [req init:[userdefaul objectForKey:APP_ID] mch_id:[userdefaul objectForKey:MCH_ID]];
    //设置密钥
    [req setKey:[userdefaul objectForKey:PARTNER_ID]];
    
    //获取到实际调起微信支付的参数后，在app端调起支付
    NSMutableDictionary *dict = [req sendPay_demo :dic :orderno];
    
    if(dict == nil){
        //错误提示
        NSString *debug = [req getDebugifo];
        
        [self alert:@"提示信息" msg:debug];
        
        //%@\n\n",debug);
    }else{
        //%@\n\n",[req getDebugifo]);
        //[self alert:@"确认" msg:@"下单成功，点击OK后调起支付！"];
        
        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
        
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = [dict objectForKey:@"appid"];
        req.partnerId           = [dict objectForKey:@"partnerid"];
        req.prepayId            = [dict objectForKey:@"prepayid"];
        req.nonceStr            = [dict objectForKey:@"noncestr"];
        req.timeStamp           = stamp.intValue;
        req.package             = [dict objectForKey:@"package"];
        req.sign                = [dict objectForKey:@"sign"];

        [WXApi sendReq:req];
    }
    
}

-(void) onResp:(BaseResp*)resp
{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];

        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                //支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;

            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                //错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
}


//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [alter show];
    
}


#pragma mark 银联支付 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-(void)normalPayAction
{
    if ([self.mode isEqualToString:@"00"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"重要提示" message:@"您现在即将进行的是一笔真实的消费,消费金额0.01元,点击确定开始支付." delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        
    }
    else
    {
        NSURL* url = [NSURL URLWithString:self.tnURL];
        NSMutableURLRequest * urlRequest=[NSMutableURLRequest requestWithURL:url];
        NSURLConnection* urlConn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
        [urlConn start];
    }
    
}

- (void)showAlertWait
{
    mAlert = [[UIAlertView alloc] initWithTitle:kWaiting message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [mAlert show];
    UIActivityIndicatorView* aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    aiv.center = CGPointMake(mAlert.frame.size.width / 2.0f - 15, mAlert.frame.size.height / 2.0f + 10 );
    [aiv startAnimating];
    [mAlert addSubview:aiv];
    
}

- (void)showAlertMessage:(NSString*)msg
{
    mAlert = [[UIAlertView alloc] initWithTitle:kNote message:msg delegate:nil cancelButtonTitle:kConfirm otherButtonTitles:nil, nil];
    [mAlert show];
    
}
- (void)hideAlert
{
    if (mAlert != nil)
    {
        [mAlert dismissWithClickedButtonIndex:0 animated:YES];
        mAlert = nil;
    }
}

#pragma mark - UPPayPlugin Test


- (void)userPayAction:(id)sender
{
    if (![self.mode isEqualToString:@"00"])
    {
        NSURL* url = [NSURL URLWithString:self.configURL];
        NSMutableURLRequest * urlRequest=[NSMutableURLRequest requestWithURL:url];
        NSURLConnection* urlConn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
        [urlConn start];
        [self showAlertWait];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse*)response
{
    NSHTTPURLResponse* rsp = (NSHTTPURLResponse*)response;
    int code = [rsp statusCode];
    if (code != 200)
    {
        [self hideAlert];
        [self showAlertMessage:kErrorNet];
        [connection cancel];
        
        connection = nil;
    }
    else
    {
        if (mData != nil)
        {
            
            mData = nil;
        }
        mData = [[NSMutableData alloc] init];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [mData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self hideAlert];
    NSString* tn = [[NSMutableString alloc] initWithData:mData encoding:NSUTF8StringEncoding];
    if (tn != nil && tn.length > 0)
    {
        //tn=%@",tn);
        [UPPayPlugin startPay:tn mode:self.mode viewController:self delegate:self];
    }
    connection = nil;
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self hideAlert];
    [self showAlertMessage:kErrorNet];
    connection = nil;
}


- (void)UPPayPluginResult:(NSString *)result
{
    NSString* msg = [NSString stringWithFormat:kResult, result];
    [self showAlertMessage:msg];
}

#pragma mark - keyboard

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}
- (void)keyboardWillShow:(NSNotification *)notification {
    
    
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    //    CGFloat height =self.changeTextField.frame.origin.y + self.OrderView.frame.origin.y+64 -keyboardFrame.origin.y;
    
    CGPoint rootViewPoint = [[self.changeTextField superview] convertPoint:self.changeTextField.frame.origin toView:self.view];
//    //%f  %f",self.changeTextField.frame.origin.y,rootViewPoint.y);
    
    CGFloat height =rootViewPoint.y -keyboardFrame.origin.y;
    //    if(self.Message.frame.origin.y + self.OrderView.frame.origin.y+64 > keyboardFrame.origin.y)
    if (height>0)
    {
        [UIView animateWithDuration:animationDuration
                         animations:^{
                             _ShopTableView.frame=CGRectMake(0,_ShopTableView.frame.origin.y-height-Height_NavBar, kApplicationWidth, _ShopTableView.frame.size.height);
                         }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         _ShopTableView.frame=CGRectMake(0, 64, kApplicationWidth, _ShopTableView.frame.size.height);
                         
                     }];
}

#pragma mark 优惠券
-(void)discountGes:(UITapGestureRecognizer*)tap
{

    TFUserCardViewController *card=[[TFUserCardViewController alloc]init];
    card.c_cond=memberPriceRate*[_selectPrice floatValue]*self.number.intValue;
    
    [card returnSuccessBlock:^(MyCardModel *model) {
        
        //        //model.ID = %@", model.ID);
        self.cardModel = model;
//        self.selectNumber.text = [NSString stringWithFormat:@"( 已选择一张优惠劵,优惠%@元 )",model.c_price];
        _selectNumber.text=@"可使用1张优惠券";
        _discountMoney.text=[NSString stringWithFormat:@"-¥%.1f",model.c_price.floatValue];
        bottomMoneyLabel4.text=[NSString stringWithFormat:@"-¥%.1f",model.c_price.floatValue];
        [self changTotalPrice];

    }];
    
    [self.navigationController pushViewController:card animated:YES];
    
}

#pragma mark 分享成功就去下单
-(void)zerosharesuccess:(NSNotification*)note
{
    MyLog(@"分享成功下单");
    _isShare=YES;
    [self OrderHttp];
    
}


- (void)httpGetRandShopWithType:(NSString *)myType
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *realm = [ud objectForKey:USER_ID];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    NSString *urlStr;
    
    if ([myType isEqualToString:DailyTaskMorningShare]||[myType isEqualToString:DailyTaskAfternoonShare]) {
        urlStr = [NSString stringWithFormat:@"%@shop/shareShop?token=%@&version=%@&realm=%@",[NSObject baseURLStr], token,VERSION, realm];
    }
    NSString *URL = [MyMD5 authkey:urlStr];
    [MBProgressHUD showMessage:@"启动分享中,请稍后" afterDeleay:0 WithView:self.view];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //分享商品 = %@", responseObject);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        //responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            
            if ([responseObject[@"status"] intValue] == 1) {
                NSString *QrLink = responseObject[@"QrLink"];
                NSNumber *shop_se_price = responseObject[@"shop"][@"shop_se_price"];
                NSString *four_pic = responseObject[@"shop"][@"four_pic"];
                NSArray *picArr = [four_pic componentsSeparatedByString:@","];
                
                NSString *pic = [picArr lastObject];
                NSString *shop_code = responseObject[@"shop"][@"shop_code"];
                NSString *sup_code  = [shop_code substringWithRange:NSMakeRange(1, 3)];
                NSString *share_pic = [NSString stringWithFormat:@"%@/%@/%@", sup_code, shop_code, pic];
                
                [self httpGetShareImageWithPrice:shop_se_price QRLink:QrLink sharePicUrl:share_pic type:myType];
                
            }else
                [MBProgressHUD showError:responseObject[@"message"]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

- (void)httpGetShareImageWithPrice:(NSNumber *)shop_price QRLink:(NSString *)qrLink sharePicUrl:(NSString *)picUrl type:(NSString *)myType
{
    [MBProgressHUD showMessage:@"启动分享中,请稍后" afterDeleay:0 WithView:self.view];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy], picUrl];
//    //url = %@", url);
    
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //responseObject = [NSDictionary changeType:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (responseObject!=nil) {
            
            NSData *imgData = UIImagePNGRepresentation(responseObject);
            self.shareRandShopImage = [UIImage imageWithData:imgData];
            
            [self shareRandShopWithPrice:shop_price QRLink:qrLink sharePicUrl:picUrl type:myType];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}
- (void)shareRandShopWithPrice:(NSNumber *)shop_price QRLink:(NSString *)qrLink sharePicUrl:(NSString *)picUrl type:(NSString *)myType
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate shardk];
        
        UIImage *QRImage =[[UIImage alloc] init];
        QRImage = [QRCodeGenerator qrImageForString:qrLink imageSize:160];
        
        ProduceImage *pi = [[ProduceImage alloc] init];
        UIImage *newimg = [pi getImage:self.shareRandShopImage withQRCodeImage:QRImage withText:nil withPrice:[NSString stringWithFormat:@"%@",shop_price] WithTitle:nil];
        
        DShareManager *ds = [DShareManager share];
        ds.delegate = self;
        
        [ds shareAppWithType:ShareTypeWeixiTimeline withImageShareType:myType withImage:newimg];
    } else {
        
        NavgationbarView *nv = [[NavgationbarView alloc] init];
        [nv showLable:@"请安装微信,再分享" Controller:self];
    }
}

- (void)DShareManagerStatus:(SHARESTATE)shareStatus withType:(NSString *)type
{
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    
    if ([type isEqualToString:DailyTaskMorningShare]||[type isEqualToString:DailyTaskAfternoonShare]) {
        if (shareStatus == 1) {
            
            
            [self httpShareSuccessWithType:type];
            
        } else if (shareStatus == 2) {
            
            
            [nv showLable:@"分享失败" Controller:self];
            
            
        } else if (shareStatus == 3) {
            
            
            
//            [nv showLable:@"分享取消" Controller:self];
            
        }
    }
}

#pragma mark 分享成功后
-(void)httpShareSuccessWithType:(NSString *)type
{
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    //	NSString *realm = [NSString stringWithFormat:@"%@",[ud objectForKey:USER_REALM]];
    NSString *token = [NSString stringWithFormat:@"%@",[ud objectForKey:USER_TOKEN]];
    
    NSString *urlStr;
    if ([type isEqualToString:DailyTaskMorningShare]) {
        urlStr = [NSString stringWithFormat:@"%@mission/doMission?version=%@&token=%@&m_id=7",[NSObject baseURLStr], VERSION,token];
    } else if ([type isEqualToString:DailyTaskAfternoonShare]) {
        urlStr = [NSString stringWithFormat:@"%@mission/doMission?version=%@&token=%@&m_id=8",[NSObject baseURLStr], VERSION,token];
    }
    
    NSString *URL=[MyMD5 authkey:urlStr];
    
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        //分享调用接口 res = %@",responseObject);
        //responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            
            if ([responseObject[@"status"] intValue] == 1) {
                
                if ([type isEqualToString:DailyTaskMorningShare]) {
                    int flag = [responseObject[@"flag"] intValue];
                    int num = [responseObject[@"num"] intValue];
                    
                    int newFlag = [responseObject[@"newFlag"] intValue];
                    int newNum = [responseObject[@"newNum"] intValue];
                    
                    if (flag == 0) {
                        [nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", num] Controller:self];
                    }
                    
                    
                    
                    NSDictionary *currDic = [NSDictionary dictionaryWithObjectsAndKeys:[MyMD5 getCurrTimeString:@"year-month-day"], @"year-month-day", nil];
                    
                    [ud setObject:currDic forKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],DailyTaskMorningShare]];
                    [ud setObject:currDic forKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],DailyTaskAfternoonShare]];
                    
                    [ud synchronize];
                } else if ([type isEqualToString:DailyTaskAfternoonShare]) {
                    int flag = [responseObject[@"flag"] intValue];
                    int num = [responseObject[@"num"] intValue];
                    
                    int newFlag = [responseObject[@"newFlag"] intValue];
                    int newNum = [responseObject[@"newNum"] intValue];
                    
                    if (flag == 0) {
                        [nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", num] Controller:self];
                    }
                    
                    NSDictionary *currDic = [NSDictionary dictionaryWithObjectsAndKeys:[MyMD5 getCurrTimeString:@"year-month-day"], @"year-month-day", nil];
                    
                    [ud setObject:currDic forKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],DailyTaskMorningShare]];
                    [ud setObject:currDic forKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],DailyTaskAfternoonShare]];
                    
                    [ud synchronize];
                }
                
            } else {
                [nv showLable:responseObject[@"message"] Controller:self];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //网络连接失败");
    }];
    
}
#pragma mark 智能分享成功下单
- (void)sharesuccess:(NSNotification*)note
{
    [self OrderHttp];
}
#pragma mark 智能分享失败
- (void)sharefail:(NSNotification*)note
{
    MyLog(@"分享失败");
    [self OrderHttp];
//        if(_sharefailnumber < 1) {
//            [self vouchersSwitchClick];
//            self.noviceTaskView = [[TFNoviceTaskView alloc] init];
//    
//            [self.noviceTaskView returnClick:^(NSInteger type) {
//                if (type == 9) {
//                    //给钱也不要");
//    
//                    [self removeNoviceTaskView];
//    
//                } else if (type == 509) {
//    
//                    //现在去分享");
//    
//                    NavgationbarView *mentionview = [[NavgationbarView alloc]init];
//                    [mentionview showLable:@"分享中，请稍等哦~" Controller:self];
//    
//                    [self performSelector:@selector(sharetishi) withObject:nil afterDelay:0.3];
//    
//                }
//    
//            } withCloseBlock:^(NSInteger type) {
//    
//                //关闭");
//                [self removeNoviceTaskView];
//            }];
//    
//            [self.noviceTaskView showWithType:@"9"];
            
//            _sharefailnumber ++;
//        }
    

}

- (void)sharetishi
{
    //配置分享平台信息
    AppDelegate *app=[[UIApplication sharedApplication] delegate];
    [app shardk];
    
    [[DShareManager share] shareAppWithType:ShareTypeWeixiTimeline View:nil Image:nil WithShareType:@"index"];
}
/*
- (void)removeNoviceTaskView
{
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[TFNoviceTaskView class]]||[view isKindOfClass:[TFDailyTaskView class]]) {
            
            [view removeFromSuperview];
        }
    }
    
}
*/
-(void)vouchersSwitchClick
{
    NSString *message = [NSString stringWithFormat:@"分享就能使用%.0f元抵用券哦，\n确定不使用吗？",[_shopmodel.voucher floatValue]];
//    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:nil contentText:message leftButtonTitle:@"暂不使用" rightButtonTitle:@"继续分享"];
    DXAlertView *alert =[DXAlertView shareWTF];
    [alert setWithTitle:nil contentText:message leftButtonTitle:@"暂不使用" rightButtonTitle:@"继续分享"];
    alert.layer.cornerRadius=5;
    alert.leftBtn.layer.cornerRadius=5;
    alert.rightBtn.layer.cornerRadius=5;
    alert.alertContentLabel.font=[UIFont systemFontOfSize:ZOOM(48)];
    alert.leftBtn.layer.borderColor=tarbarrossred.CGColor;
    alert.leftBtn.layer.borderWidth=1;
    alert.leftBtn.backgroundColor=[UIColor whiteColor];
    alert.rightBtn.backgroundColor=tarbarrossred;
    [alert.leftBtn setTitleColor:tarbarrossred forState:UIControlStateNormal];
    [alert.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [alert show];
    
    alert.leftBlock = ^() {
        //暂不使用
        vouchersSwitch.on = NO;
        for (VoucherModel *model2 in self.voucherArr) {
            model2.usedNum=0;
        }
        _shopmodel.voucher=@"0";
        [_shopmodel.usedNunArray removeAllObjects];
        [_shopmodel.priceArray removeAllObjects];
        vouchersMoney.text=[NSString stringWithFormat:@"可抵用¥%.1f",_shopmodel.voucher.floatValue];
        bottomMoneyLabel3.text=[NSString stringWithFormat:@"-¥%.1f",_shopmodel.voucher.floatValue];
        [self changTotalPrice];
    };
    alert.rightBlock = ^() {
        
        //现在去分享
        NavgationbarView *mentionview = [[NavgationbarView alloc]init];
        [mentionview showLable:@"分享中，请稍等哦~" Controller:self];
        
        [self performSelector:@selector(sharetishi) withObject:nil afterDelay:0.3];
    };
    alert.dismissBlock = ^() {
        
    };
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
