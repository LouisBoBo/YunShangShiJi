//
//  ActivityShopOrderVC.m
//  YunShangShiJi
//
//  Created by yssj on 2016/10/17.
//  Copyright © 2016年 ios-1. All rights reserved.
//
/**
 *******************   拼团商品  活动商品下单 
 **/

#import "ActivityShopOrderVC.h"
#import "GlobalTool.h"
#import "OrderFootView.h"
#import "AffirmOrderCell.h"
#import "WTFAddressView.h"
#import "TFReceivingAddressViewController.h"
#import "UIButton+WTF.h"
#import "DefaultImgManager.h"
#import "AddressModel.h"
#import "AdressModel.h"
#import "LoginViewController.h"
#import "TFPayStyleViewController.h"
#import "ShopDetailViewController.h"
#import "LuckdrawViewController.h"
#import "TFPopBackgroundView.h"

#define DefaultImg(size) [[DefaultImgManager sharedManager] defaultImgWithSize:(size)]

@interface ActivityShopOrderVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    OrderFootView *OrderFooterView;
    WTFAddressView  *_addressView;
    UIButton *confirmButton;
    UITextField *messageTextField;
    
    BOOL _isnotifation;                 //是否监听到通知

}
@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)UITextField *message;
@property(nonatomic,strong)UILabel *totalpriceLabel;         //总计
@property (nonatomic , strong)NSString *addressid;

@end

@implementation ActivityShopOrderVC
- (void)viewWillAppear:(BOOL)animated {
    //如果有选取地址就不用请求获取收货地址
    if(_isnotifation==NO){
        //获取收货信息
        [self httpDelivery];
    }
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeaddress:) name:@"changeaddress" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteAddress:) name:@"deleteAddress" object:nil];
    
    [TFStatisticsClickVM StatisticshandleDataWithClickType:@"到达订单确认" success:nil failure:nil];
    
    [self setTableView];
    [self setBottomView];
    
    [self setNavgationView];

    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"RedMoneyLeastNum"] integerValue]!=-1) {
        [self httpGetRedMoneyLeastNum];
    }
}
/**
 获取当天还有多少次抽奖机会
 */
- (void)httpGetRedMoneyLeastNum {
    kSelfWeak;
    [[APIClient sharedManager]netWorkGeneralRequestWithApi:@"order/getOrderRaffleNum?" caches:NO cachesTimeInterval:0 token:YES success:^(id data, Response *response) {
        if (response.status == 1) {
            [[NSUserDefaults standardUserDefaults]setObject:data[@"data"] forKey:@"RedMoneyLeastNum"];
            [[NSUserDefaults standardUserDefaults]setObject:data[@"n"] forKey:@"RedMoneyAllNum"];
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",data[@"money"]] forKey:@"RedMoneyRaward"];
            
//            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"RedMoneyLeastNum"] integerValue]!=-1)
//            [weakSelf creatRedMoneyAlertView];
            
        }
    } failure:^(NSError *error) {

    }];
}
- (void)creatRedMoneyAlertView {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"余额抽奖红包"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"余额抽奖红包"] forState:UIControlStateNormal|UIControlStateHighlighted];
    [btn addTarget:self action:@selector(redViewClick) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(kScreenWidth-ZOOM6(168)-ZOOM6(20), 200, ZOOM6(168), ZOOM6(178));
//    [self.view addSubview:btn];
//    [self.view bringSubviewToFront:btn];
    
    kWeakSelf(self);
    [[DataManager sharedManager] taskListHttp:26 Success:^{
        
        [weakself.view addSubview:btn];
        [weakself.view bringSubviewToFront:btn];
    }];

}
- (void)redViewClick {
    LuckdrawViewController *vc = [[LuckdrawViewController alloc]init];
    vc.is_OrderRedLuck = [[[NSUserDefaults standardUserDefaults]objectForKey:@"RedMoneyLeastNum"] integerValue] ? YES : NO;
    vc.is_comefromeRed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - ************************** HTTP **************************
/**************************   获取默认的收货地址 *************************/
-(void)httpDelivery
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    NSString *url=[NSString stringWithFormat:@"%@address/queryDefault?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL=[MyMD5 authkey:url];
    
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject!=nil) {
            //responseObject = [NSDictionary changeType:responseObject];
            NSString *str=responseObject[@"status"];
            
            if(str.intValue==1){
                NSDictionary *dic=responseObject[@"address"];
                if([dic count]!=0) {
                    AdressModel *model=[[AdressModel alloc]init];
                    model.address=dic[@"address"];
                    model.consignee=dic[@"consignee"];
                    model.phone=dic[@"phone"];
                    model.postcode=dic[@"postcode"];
                    
                    self.addressid=@"0";
                    if(dic[@"address"]&&dic[@"consignee"]){
                        [self createDetailAddressView];
                        _addressView.nameLabel.text=[NSString stringWithFormat:@"收货人:%@   %@",model.consignee ,model.phone ];
                        _addressView.addressLabel.text=[NSString stringWithFormat:@"收货地址:%@",model.address];
                    }
                }else{
                    [self creatAddressView];
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
                [self creatAddressView];
            }
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"收货地址获取失败" Controller:self];
    }];
}

-(void)httpAddOrder
{
    [TFStatisticsClickVM handleDataWithPageType:nil withClickType:@"确认订单页面”确认下单“" success:^(id data, Response *response) {
    } failure:^(NSError *error) {
    }];
    
    NSString *messageStr=messageTextField.text.length!=0?[NSString stringWithString:messageTextField.text]:@"";

    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSString *url;
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
//    NSMutableString *result=[NSMutableString string];
//    [result appendString:[NSString stringWithFormat:@"%@^%@^%@",_shopModel.shop_num,_shopModel.shop_code,_shopModel.stock_type_id]];
//    MyLog(@"%@",result);
    if (self.rollCode==nil) {
        self.rollCode=@"0";
    }
    url=[NSString stringWithFormat:@"%@order/addOrder/activity?version=%@&address_id=%@&token=%@&stocktype_id=%@&shop_code=%@&shop_num=%@&message=%@&rollCode=%@",[NSObject baseURLStr],VERSION,self.addressid,token,_shopModel.stock_type_id,_shopModel.shop_code,_shopModel.shop_num,messageStr,self.rollCode];
    
    NSString *URL=[MyMD5 authkey:url];
    MyLog(@"%@",URL);
    
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
        //responseObject = [NSDictionary changeType:responseObject];
        confirmButton.userInteractionEnabled=YES;
        if(responseObject[@"orderToken"]!=nil)
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"orderToken"] forKey:ORDER_TOKEN];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
       
            
            if(statu.intValue==1){
                [userdefaul setObject:responseObject[@"order_code"] forKey:ORDER_CODE];
                
                [TFStatisticsClickVM StatisticshandleDataWithClickType:@"跳出订单确认" success:nil failure:nil];
                
                TFPayStyleViewController *paystyle=[[TFPayStyleViewController alloc]init];
                paystyle.price=[responseObject[@"price"]doubleValue];
                paystyle.order_code=responseObject[@"order_code"];
                paystyle.urlcount=@"1";
                paystyle.shop_from = @"5";
                paystyle.shopmodel=_shopModel;
                
                paystyle.fromType = self.fromType; //何波加的2016-11-25
                paystyle.is_group = self.is_group;
                
                [self.navigationController pushViewController:paystyle animated:YES];
            }else{
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:message Controller:self];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
        confirmButton.userInteractionEnabled=YES;
        
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
    
}
#pragma mark - 设置收获地址
- (void)addressViewTap {
    TFReceivingAddressViewController *tfreceiving=[[TFReceivingAddressViewController alloc]init];
    tfreceiving.adresstype = @"选择收货地址";
    [self.navigationController pushViewController:tfreceiving animated:YES];
    
}
- (void)deleteAddress:(NSNotification *)note {
    AddressModel *model=note.object;
    NSMutableString *addressstr =[[NSMutableString alloc]init];
    if(model.addressArray.count != 0 ) {
        for(int i=0;i<model.addressArray.count;i++){
            [addressstr appendString:model.addressArray[i]];
        }
    }
    //%@  %@",_address.text,[NSString stringWithFormat:@"收货地址:%@%@",addressstr,model.address]);
    if ([_addressView.addressLabel.text isEqualToString:[NSString stringWithFormat:@"收货地址:%@%@",addressstr,model.address]]) {
        [self httpDelivery];
    }
}
#pragma mark - 更换收货地址
- (void)changeaddress:(NSNotification*)note {
    AddressModel *model=note.object;
    
    [self createDetailAddressView];
    
    NSMutableString *addressstr =[[NSMutableString alloc]init];
    if(model.addressArray.count != 0 ) {
        for(int i=0;i<model.addressArray.count;i++){
            [addressstr appendString:model.addressArray[i]];
        }
    }
    _addressid=[NSString stringWithFormat:@"%@",model.ID];
    //    //_addressid %@",_addressid);
    _addressView.nameLabel.text=[NSString stringWithFormat:@"收货人:%@   %@",model.consignee ,model.phone ];
    _addressView.addressLabel.text=[NSString stringWithFormat:@"收货地址:%@%@",addressstr,model.address];
    _isnotifation = YES;
    
}
/**************************   地址详情  *************************/
-(void)createDetailAddressView
{
    _addressView.type=WTFAddressNormal;
    _myTableView.tableHeaderView = _addressView;
    
}
/**************************   无地址  *************************/
-(void)creatAddressView
{
    _addressView.type=WTFAddressEmpty;
    _myTableView.tableHeaderView = _addressView;
}
- (void)setTableView {
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kApplicationWidth, kApplicationHeight-Height_NavBar-50+kUnderStatusBarStartY) style:UITableViewStylePlain];
    _myTableView.backgroundColor = [UIColor whiteColor];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    _myTableView.showsVerticalScrollIndicator=NO;
    self.myTableView.keyboardDismissMode  = UIScrollViewKeyboardDismissModeOnDrag;
    [_myTableView registerClass:[AffirmOrderCell class] forCellReuseIdentifier:@"cell"];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyBoard)];
    //    tapGesture.cancelsTouchesInView =NO;
    //    [_myTableView addGestureRecognizer:tapGesture];
    //    [self setupForDismissKeyboard];
    
    [self.view addSubview:_myTableView];
    
    OrderFooterView=[[OrderFootView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM(20)*2+ZOOM(100)*7+ZOOM6(20))];
    [OrderFooterView hidBottomLabel:2 hidden:YES];
    [OrderFooterView hidBottomLabel:3 hidden:YES];
    [OrderFooterView hidBottomLabel:4 hidden:YES];
    [OrderFooterView hidBottomLabel:5 hidden:YES];
    [OrderFooterView hidBottomLabel:6 hidden:YES];
    [OrderFooterView hidBottomLabel:7 hidden:YES];
    _myTableView.tableFooterView=OrderFooterView;
    [self OrderFooterViewMoney];
    
    
    __weak typeof(self) weakSelf = self;
    _addressView=[[WTFAddressView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(270))];
    _addressView.btnViewBlock=^{
        [weakSelf addressViewTap];
    };
    _addressView.type=WTFAddressEmpty;
    [_addressView setHiddenTopView:YES];
    _myTableView.tableHeaderView = _addressView;
    
}
-(void)setBottomView
{
    UIView *foorview=[[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight-50+kUnderStatusBarStartY, kApplicationWidth, 50)];
    foorview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:foorview];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 0.5)];
    line.backgroundColor = kNavLineColor;
    [foorview addSubview:line];
    
    //付款
    confirmButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    CGFloat width = ZOOM6(40)+[@"确认购买即赢千元大奖" getWidthWithFont:[UIFont systemFontOfSize:ZOOM(46)] constrainedToSize:CGSizeMake(MAXFLOAT, 50)];
    CGFloat width = kScreenWidth/2;

    confirmButton.frame=CGRectMake(kApplicationWidth-width, 0, width, foorview.frame.size.height);
    //    [confirmButton setTitle:@"确认下单" forState:UIControlStateNormal];
    //    button1.layer.cornerRadius=5;
    [confirmButton setTitle:@"提交订单" forState:UIControlStateNormal];
    confirmButton.titleLabel.font=[UIFont systemFontOfSize:ZOOM(46)];
    confirmButton.tintColor=[UIColor whiteColor];
    [confirmButton setBackgroundColor:tarbarrossred];
    [confirmButton addTarget:self action:@selector(affirmorder:) forControlEvents:UIControlEventTouchUpInside];
    [foorview addSubview:confirmButton];
    
    _totalpriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5,kScreenWidth-CGRectGetWidth(confirmButton.frame)-ZOOM6(120), 40)];
    _totalpriceLabel.textAlignment=NSTextAlignmentCenter;
    _totalpriceLabel.textColor = tarbarrossred;
    self.totalpriceLabel.font=[UIFont systemFontOfSize:ZOOM(50)];
    self.totalpriceLabel.text = [NSString stringWithFormat:@"实付款: ¥%.1f",_shopModel.shop_se_price.floatValue*_shopModel.shop_num.intValue];
    [foorview addSubview:_totalpriceLabel];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(confirmButton.frame)-ZOOM6(20)-ZOOM6(120), 5, ZOOM6(120), 40)];
    label.textAlignment=NSTextAlignmentRight;
    label.textColor=kTextColor;
    label.font=[UIFont systemFontOfSize:ZOOM6(24)];
    [foorview addSubview:label];
    

    NSString *price=[NSString stringWithFormat:@"%@",_shopModel.shop_se_price];
    NSString *oldPrice=[NSString stringWithFormat:@"%@",_shopModel.shop_price];

    label.text=[NSString stringWithFormat:@"专柜%.1f折",([price floatValue]/[oldPrice floatValue])*10];
    
}
-(void)OrderFooterViewMoney
{
    CGFloat totalprice=0;
//    CGFloat totalVoucher=0;
//    for(int i=0;i<self.sortArray.count;i++){
        ShopDetailModel *shopmodel=_shopModel;
        NSString *price=[NSString stringWithFormat:@"%@",shopmodel.shop_se_price];
        NSString *number=[NSString stringWithFormat:@"%@",shopmodel.shop_num];
        CGFloat PRICE=[price floatValue]*[number integerValue];
        totalprice +=PRICE;
//        totalVoucher += shopmodel.voucher.integerValue;
//    }
    OrderFooterView.bottomMoneyLabel1.text=[NSString stringWithFormat:@"¥%.1f",totalprice];
    OrderFooterView.bottomMoneyLabel2.text=@"-¥0.0";

    
}
#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row ==[_shopArray[indexPath.section] count]-1) {
        return ZOOM6(30)*2+ZOOM6(140);
//    }else
//        return ZOOM6(30)+ZOOM6(140);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AffirmOrderCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    ShopDetailModel *model = _shopModel;
    cell.shop_model = model;
    cell.color_size.text=[NSString stringWithFormat:@"颜色:%@  尺码:%@",model.shop_color,model.shop_size];
    cell.title.text=[NSString stringWithFormat:@"%@",[self exchangeTextWihtString:model.shop_name]];
    cell.price.text=[NSString stringWithFormat:@"¥%.1f",[model.shop_se_price floatValue]];
    
    NSString *oldPrice = [NSString stringWithFormat:@" ¥%.1f",[model.shop_price floatValue]];
    
    cell.returnMoney.hidden = NO;
    cell.returnMoney.text = [NSString stringWithFormat:@"返%.1f元=0元购",[model.shop_se_price floatValue]];
    
//    NSUInteger length = [oldPrice length];
//    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
//    [attri addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlinePatternSolid | NSUnderlineStyleSingle] range:NSMakeRange(0, length)];
//    [attri addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),NSBaselineOffsetAttributeName:@(0)} range:NSMakeRange(0, length)];

//    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, length)];
//    [cell.shop_oldPrice setAttributedText:attri];

    NSString *str=[NSString stringWithFormat:@"¥%.1f ¥%.1f",[model.shop_se_price floatValue],[model.shop_price floatValue]];
    NSMutableAttributedString *attriStr = [NSString getOneColorInLabel:str ColorString:oldPrice Color:kTextColor fontSize:ZOOM6(24)];
//    NSRange rang=[str rangeOfString:oldPrice];
//    [attriStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlinePatternSolid | NSUnderlineStyleSingle] range:rang];
//    [attri addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),NSBaselineOffsetAttributeName:@(0)} range:rang];

//    [attriStr addAttribute:NSStrikethroughColorAttributeName value:[UIColor lightGrayColor] range:rang];
    [cell.price setAttributedText:attriStr];
    cell.brand.text = [model.supp_label isEqualToString:@"(null)"]||[model.supp_label isEqual:[NSNull null]]
    ? @""
    : [NSString stringWithFormat:@"%@",model.supp_label];
    //    cell.shop_oldPrice.text=[NSString stringWithFormat:@"¥%.1f",[model.shop_price floatValue]];
    cell.number.text=[NSString stringWithFormat:@"x%@",model.shop_num];
    
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM6(30)]};
    CGSize textSize = [[NSString stringWithFormat:@"¥%.1f",[model.shop_se_price floatValue]] boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    cell.line.frame = CGRectMake(cell.price.frame.origin.x+textSize.width, cell.line.frame.origin.y, [NSString widthWithString:oldPrice font:kFont6px(24) constrainedToHeight:20], cell.line.frame.size.height);
    cell.line.backgroundColor = kTextColor;
    
    
    
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@!180",[NSObject baseURLStr_Upy],[MyMD5 pictureString:model.shop_code],model.def_pic]];
    
    //    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!180",[NSObject baseURLStr_Upy],model.def_pic]];
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [cell.headimage sd_setImageWithURL:imgUrl placeholderImage:DefaultImg(cell.headimage.bounds.size) options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
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
    
    return cell;
}

#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AffirmOrderCell *cell = (AffirmOrderCell*)[tableView cellForRowAtIndexPath:indexPath];
    UIImage *image= cell.headimage.image;
    
    ShopDetailViewController *shopdetail=[[ShopDetailViewController alloc]init];
    shopdetail.shop_code=_shopModel.shop_code;
    shopdetail.bigimage = image;
    shopdetail.stringtype = @"活动商品";
    shopdetail.browseCount = -1;
    shopdetail.isNOFightgroups = self.isNOFightgroups;
    [self.navigationController pushViewController:shopdetail animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
//    if (section == [_shopArray count]-1) {
//        return [DataManager sharedManager].isOpen?340+ZOOM6(20)+50:340+ZOOM6(20);
//    }
    return  80;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView* sectionFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 80)];
//    sectionFooterView.backgroundColor=DRandomColor;
//    if (section == [_shopArray count]-1) {
//        sectionFooterView.frame = [DataManager sharedManager].isOpen?CGRectMake(0, 0, kApplicationWidth, 50+340+ZOOM6(20)):CGRectMake(0, 0, kApplicationWidth, 340+ZOOM6(20));
//    }
    sectionFooterView.tag = section + 500;
    
    CGFloat left = ZOOM(62); CGFloat right = ZOOM(42);
    /**********  配送方式   ********/
    /*
    UILabel *mail = [[UILabel alloc]initWithFrame:CGRectMake(left, 10, kApplicationWidth/2, 30)];
    mail.text = @"配送方式";
    mail.textColor=kMainTitleColor;
    mail.textAlignment = NSTextAlignmentLeft;
    mail.font = [UIFont systemFontOfSize:ZOOM(48)];
    UILabel *way = [[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth/2, 10, kApplicationWidth/2-right, 30)];
    way.font = [UIFont systemFontOfSize:ZOOM(48)];
    way.text = @"快递包邮";
    way.textColor=kMainTitleColor;
    way.textAlignment = NSTextAlignmentRight;
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, way.frame.origin.y+way.frame.size.height+10, kApplicationWidth, 0.5)];
    line.backgroundColor = kTableLineColor;
    [sectionFooterView addSubview:line];
    
    //**********  价格合计   ********
    UILabel *moneyTotal = [[UILabel alloc]initWithFrame:CGRectMake(left, line.frame.origin.y+line.frame.size.height+10, kApplicationWidth/2, 30)];
    moneyTotal.text = @"价格合计";
    moneyTotal.textColor=kMainTitleColor;
    moneyTotal.font=[UIFont systemFontOfSize:ZOOM(48)];
    moneyTotal.textAlignment = NSTextAlignmentLeft;
    UILabel *money = [[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth/2, line.frame.origin.y+line.frame.size.height+10, kApplicationWidth/2-right, 30)];
    money.font = [UIFont systemFontOfSize:ZOOM(48)];
    money.text = @"¥";
    money.textColor=kMainTitleColor;
    money.tag = 100+section;
    money.textAlignment = NSTextAlignmentRight;
//    CGFloat vouchersNum=0;
//    if(_shopArray.count)
//    {
        CGFloat totalprice=0;
        
//        NSArray *array = _shopArray[section];
//        for (int j=0; j<array.count; j++) {
            ShopDetailModel *shopmodel=_shopModel;
//
            NSString *price=[NSString stringWithFormat:@"%@",shopmodel.shop_se_price];
            NSString *number=[NSString stringWithFormat:@"%@",shopmodel.shop_num];
//
            CGFloat PRICE=[price floatValue]*[number integerValue]*memberPriceRate;
            totalprice +=PRICE;
//            vouchersNum += shopmodel.voucher.floatValue;
//            
//        }
        money.text=[NSString stringWithFormat:@"¥%.1f",totalprice];
//    }
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, moneyTotal.frame.origin.y+moneyTotal.frame.size.height+10, kApplicationWidth, 0.5)];
    line2.backgroundColor = kTableLineColor;
    [sectionFooterView addSubview:line2];
*/
    
    
    /**********  给卖家留言   ********/
    //    UITextField *message = [[UITextField alloc]initWithFrame:CGRectMake(left, line3.frame.origin.y+line3.frame.size.height+20, kApplicationWidth-left-right, 60)];
    //messageTextField = [[UITextField alloc]initWithFrame:CGRectMake(left, line2.frame.origin.y+line2.frame.size.height+20, kApplicationWidth-left-right, 60)];
    messageTextField = [[UITextField alloc]initWithFrame:CGRectMake(left, 10, kApplicationWidth-left-right, 60)];

    messageTextField.borderStyle = UITextBorderStyleRoundedRect;
    messageTextField.layer.borderWidth = 0.5;
    messageTextField.layer.cornerRadius = 5;
    messageTextField.layer.borderColor = kTableLineColor.CGColor;
    messageTextField.font = fortySize;
    messageTextField.placeholder=@"给卖家留言...";
//    ShopDetailModel *messageModel = _shopArray[section][0];
//    if (messageModel.message!=nil&&messageModel.message.length!=0) {
//        message.text=[NSString stringWithFormat:@"%@",messageModel.message];
//    }
    messageTextField.delegate = self;
    messageTextField.tag=600+section;
    
    UIView *topline = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 0.5)];
    topline.backgroundColor = kTableLineColor;
    [sectionFooterView addSubview:topline];
    
//    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(message.frame)+20, kApplicationWidth, ZOOM6(20))];
//    bottomView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
//    [sectionFooterView addSubview:bottomView];

//    [sectionFooterView addSubview:mail];
//    [sectionFooterView addSubview:way];
//    [sectionFooterView addSubview:moneyTotal];
//    [sectionFooterView addSubview:money];
    
    [sectionFooterView addSubview:messageTextField];
    
    return sectionFooterView;
}


-(void)setNavgationView
{
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    headview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 46, 46);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"确认订单";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, headview.frame.size.height-1, kApplicationWidth, 0.5)];
    line.backgroundColor = kNavLineColor;
    [headview addSubview:line];
    
}
#pragma mark 确认订单到支付界面
- (void)affirmorder:(UIButton*)sender {
    if(_addressView.nameLabel.text.length!=0 && _addressView.addressLabel.text.length !=0 && ![_addressView.addressLabel.text isEqualToString:@"收货地址:null"]){
        confirmButton.userInteractionEnabled=NO;
        [self httpAddOrder];
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
- (void)goBack:(UIButton*)sender
{
//    [self zeroBuyRemindView];
    
    [self.view endEditing:YES];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"这么好的宝贝,确定不要了吗?"  preferredStyle:UIAlertControllerStyleAlert];
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
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 1){
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    UIView *view = [_myTableView viewWithTag:500];
    UITextField *message = (UITextField *)[view viewWithTag:600];
    if (textField == message) {
        _shopModel.message=textField.text;
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.message = textField;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    return YES;
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
