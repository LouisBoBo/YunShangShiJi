//
//  RerundViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/6/19.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//
/*尺寸拍错/不喜欢/效果不好
 颜色/款式/图案与描述不符
 商品破损/污渍/漏发/错发
 大小尺寸与商品描述不符
 材质面料与商品描述不符
 质量问题
 七天无理由退换货
 其他
 */
#import "RerundViewController.h"
#import "GlobalTool.h"
#import "KeyboardTool.h"
#import "TFCustomCamera.h"
#import "PopoverView.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "NavgationbarView.h"
#import "MyMD5.h"
#import "DoImagePickerController.h"
#import "FullScreenScrollView.h"
#import "ChangeDetailViewController.h"
#import "UpYun.h"
//#import "ChatListViewController.h"
#import "AftersaleViewController.h"
#import "LoginViewController.h"

#import "WTFPickerView.h"

@interface RerundViewController ()<DoImagePickerControllerDelegate,PopoverViewDelegate,TFCameraDelegate>
{
    NSMutableArray *_imageArray;//选取图片
    CGFloat _widh; //图片的高宽
    BOOL _isaddimage;//记录是否有加图片的按钮
    NSMutableString *_images;
    FullScreenScrollView *_fullScreenScrollView;
    BOOL _isclick;          //记录是否点击过选择退货原因按钮
    UIView *_dateView;
    UIPickerView *_pickview;
    NSArray *_titlesArray1;
    NSArray *_titlearr;
    NSArray *_titlebrr;
    UILabel *_titlelable;
    NSString *textViewString;
    
    UITextField *moneyText;//退款金额
    NSString *moneyTextStr;
}
@end

@implementation RerundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    _widh=(kApplicationWidth-ZOOM(62)*4)/4;
    
    _isaddimage=NO;
    _imageArray=[NSMutableArray array];
    _images=[NSMutableString string];
    _isclick=NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    if([self.titletext isEqualToString:@"申请退款"]){
        _titlesArray1 = @[@"发货速度慢",@"不想要了",@"改变主意了",@"商家没货了"];
    }else{
        _titlesArray1 = @[@"尺寸拍错/不喜欢/效果不好",@"颜色/款式/图案与描述不符", @"商品破损/污渍/漏发/错发", @"大小尺寸与商品描述不符",@"材质面料与商品描述不符",@"质量问题",@"七天无理由退换货",@"其他"];
    }
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"aSelected"];

    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    headview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 46, 46);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    _titlelable=[[UILabel alloc]init];
    _titlelable.frame=CGRectMake(0, 0, 300, 40);
    _titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    _titlelable.text=self.titletext;
    _titlelable.font=kNavTitleFontSize;
    _titlelable.textColor=kMainTitleColor;
    _titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:_titlelable];
    
    /*
    UIButton *searchbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    searchbtn.frame=CGRectMake(kApplicationWidth - 40, 30, 25, 25);
    searchbtn.tintColor=[UIColor blackColor];
    [searchbtn setImage:[UIImage imageNamed:@"设置"]  forState:UIControlStateNormal];
    searchbtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [searchbtn addTarget:self action:@selector(toMessage:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:searchbtn];
    
    //获得所有DB中未读消息数量
    NSInteger unReadMessageCount=[[EaseMob sharedInstance].chatManager loadTotalUnreadMessagesCountFromDatabase];
    
    UILabel *messagecount=[[UILabel alloc]initWithFrame:CGRectMake(20, -10, 20, 20)];
    messagecount.text=[NSString stringWithFormat:@"%d",unReadMessageCount];
    messagecount.font=[UIFont systemFontOfSize:15];
    messagecount.textColor=[UIColor whiteColor];
    messagecount.backgroundColor=tarbarYellowcolor;
    messagecount.clipsToBounds=YES;
    messagecount.layer.cornerRadius=10;
    messagecount.textAlignment=NSTextAlignmentCenter;
    if(unReadMessageCount !=0){
        [searchbtn addSubview:messagecount];
    }
    */
    [self creatview];

    if (self.shop_from.intValue!=1&&self.shop_from.intValue!=4) {
        _Myscrollview.hidden=YES;
        [self httpMoney];
    }

}
#pragma mark - keyboard
- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];

    CGPoint rootViewPoint = [[self.mytextview superview] convertPoint:self.mytextview.frame.origin toView:self.view];
    CGFloat height =rootViewPoint.y -keyboardFrame.origin.y;
    
    if (height>0){
        [UIView animateWithDuration:animationDuration
                         animations:^{
                             self.Myscrollview.frame=CGRectMake(0,_Myscrollview.frame.origin.y-height-64, kApplicationWidth, _Myscrollview.frame.size.height);
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
                         _Myscrollview.frame=CGRectMake(0, 64, kApplicationWidth, _Myscrollview.frame.size.height);
                     }];
}

#pragma mark 信息
-(void)toMessage:(UIButton*)sender
{
    // begin 赵官林 2016.5.26 跳转到消息列表
    [self presentChatList];
    // end
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Myview.hidden=YES;
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
}

-(void)dismissKeyBoard{
    [self.mytextview resignFirstResponder];
}

-(void)httpMoney
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    NSString *return_type;
    if([self.titletext isEqualToString:@"申请退款"]){
        return_type=@"3";
    }
    else if([self.titletext isEqualToString:@"申请退货"]){
        return_type=@"2";
    }else if([self.titletext isEqualToString:@"申请换货"]){
        return_type=@"2";
    }

    NSString *url=[NSString stringWithFormat:@"%@returnShop/addAgo?version=%@&token=%@&order_shop_id=%@&return_type=%@",[NSObject baseURLStr],VERSION,token,self.ordermodel.ID,return_type];
    
    NSString *URL=[MyMD5 authkey:url];
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        MyLog(@"%@",responseObject);
        self.orderPrice=[NSString stringWithFormat:@"%@",responseObject[@"money"]];
        self.status=[responseObject[@"status"]integerValue];
        self.useCoupon=[responseObject[@"useCoupon"]floatValue];
        self.useIngral=[responseObject[@"useInegral"]floatValue];
        

        _Myscrollview.hidden=NO;
        [self refreshView];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:@"网络连接失败"];
        //网络连接失败");

    }];
}
-(void)changMoney:(NSString *)price
{
    UILabel *lable1 = (UILabel *)[_Myscrollview viewWithTag:9000+2];
    NSMutableAttributedString *noteStr;
    if (self.shop_from.intValue==1||self.shop_from.intValue==4) {
       
        noteStr = [[NSMutableAttributedString alloc]initWithString:price];
    }else{
        noteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%g",self.orderPrice.floatValue]];
        UILabel *moneyLabel = (UILabel *)[_Myscrollview viewWithTag:9999];
        NSMutableString *string = [NSMutableString stringWithFormat:@"(原价:%g",self.ordermodel.shop_price.floatValue];
        if (_ordermodel.voucher_money.floatValue!=0) {
            [string appendFormat:@",抵用券:%g",_ordermodel.voucher_money.floatValue];
        }
        if (self.useCoupon!=0) {
            [string appendFormat:@",优惠劵:%g",self.useCoupon];
        }
        if (self.useIngral!=0) {
            [string appendFormat:@",积分抵用:%g",self.useIngral];
        }
        [string appendFormat:@")"];
        moneyLabel.text=string;
    }
    lable1.textColor=tarbarrossred;
    [lable1 setAttributedText:noteStr];
    
//    [_Myscrollview addSubview:moneyLabel];
}

-(void)refreshView
{
    UIView *view = (UIView *)[_Myscrollview viewWithTag:7000+2];
    UILabel *label = (UILabel *)[_Myscrollview viewWithTag:8000+2];
    UILabel *label1 = (UILabel *)[_Myscrollview viewWithTag:9000+2];
    UILabel *label2 = (UILabel *)[_Myscrollview viewWithTag:9999];
    label2.hidden=NO;
    view.hidden=NO;
    label.hidden=NO;
    label1.hidden=NO;
    label1.hidden=self.shop_from.integerValue==4?NO:YES;
    moneyText.hidden=self.shop_from.integerValue==4?YES:NO;
    
    if (self.shop_from.intValue==1||self.shop_from.intValue==4) {
        if (_Order_status.intValue==2) {
            moneyTextStr = [NSString stringWithFormat:@"%g",self.orderPrice.floatValue];
        }else
            moneyTextStr=[NSString stringWithFormat:@"%g",self.orderPrice.floatValue-_ordermodel.postage.floatValue];
    }else
        moneyTextStr=[NSString stringWithFormat:@"%g",self.orderPrice.floatValue];
    
    if([self.titletext isEqualToString:@"申请退款"]){
        _titlearr=@[@"申请服务",@"物流状态",@"退款金额"];
        _titlebrr=@[@"仅退款",@"请选择物流状态",moneyTextStr];
        _titlesArray1 = @[@"已收到货",@"未收到货"];
        textViewString=@"退款说明,最多200字";
    } else if([self.titletext isEqualToString:@"申请退货"]){
        _titlearr=@[@"申请服务",@"退货原因",@"退款金额"];
        _titlebrr=@[@"退货退款",@"请选择退货原因",moneyTextStr];
        _titlesArray1 = @[@"尺寸拍错/不喜欢/效果不好",@"颜色/款式/图案与描述不符", @"商品破损/污渍/漏发/错发", @"大小尺寸与商品描述不符",@"材质面料与商品描述不符",@"质量问题",@"七天无理由退换货",@"其他"];
        textViewString=@"退货说明,最多200字";
    }else if([self.titletext isEqualToString:@"申请换货"]){
        _titlearr=@[@"申请服务",@"换货原因"];
        _titlebrr=@[@"换货",@"请选择换货原因"];
        _titlesArray1 =@[@"尺寸拍错/不喜欢/效果不好",@"颜色/款式/图案与描述不符", @"商品破损/污渍/漏发/错发", @"大小尺寸与商品描述不符",@"材质面料与商品描述不符",@"质量问题",@"七天无理由退换货",@"其他"];
        textViewString=@"换货说明,最多200字";
        view.hidden=YES;
        label.hidden=YES;
        label1.hidden=YES;
        label2.hidden=YES;
         moneyText.hidden=YES;
    }
    self.mytextview.text=textViewString;
    moneyText.placeholder=[NSString stringWithFormat:@"最多可退款金额为%@元",moneyTextStr];
    moneyText.text=[NSString stringWithFormat:@"%@",moneyTextStr];

    for(int i=0;i<_titlebrr.count;i++){
        UILabel *label = (UILabel *)[_Myscrollview viewWithTag:8000+i];
        UILabel *label1 = (UILabel *)[_Myscrollview viewWithTag:9000+i];
        label.text=_titlearr[i];
        label1.text=_titlebrr[i];
    }
    
    [self changMoney:moneyTextStr];

    
    if([self.titletext isEqualToString:@"申请换货"] || self.shop_from.intValue==1 || self.shop_from.intValue==4){
        self.mytextview.frame=CGRectMake(ZOOM(62), _titlearr.count*70+10, kApplicationWidth-ZOOM(62)*2, self.mytextview.frame.size.height);
    }else if ([self.titletext isEqualToString:@"申请退款"]){
        self.mytextview.frame=CGRectMake(ZOOM(62), _titlearr.count*70+30+10, kApplicationWidth-ZOOM(62)*2, self.mytextview.frame.size.height);
    }
    else
        self.mytextview.frame=CGRectMake(ZOOM(62), _titlearr.count*70+10, kApplicationWidth-ZOOM(62)*2, self.mytextview.frame.size.height);
    
    
    self.addimage.frame=CGRectMake(ZOOM(62), self.mytextview.frame.origin.y+_mytextview.frame.size.height+10,self.addimage.frame.size.width, _widh);
    
    
}
-(void)creatview
{
    self.Myscrollview.delegate=self;
    _Myscrollview.frame=CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar);
    CGFloat myScrollViewHeight = kScreenHeight>568 ? kScreenHeight-Height_NavBar : 568;
    _Myscrollview.contentSize=CGSizeMake(kScreenWidth, myScrollViewHeight);

    
    
    if (self.shop_from.intValue==1||self.shop_from.intValue==4) {
        if (_Order_status.intValue==2) {
            moneyTextStr = [NSString stringWithFormat:@"%g",self.orderPrice.floatValue];
        }else
            moneyTextStr=[NSString stringWithFormat:@"%g",self.orderPrice.floatValue-_ordermodel.postage.floatValue];
    }else
        moneyTextStr=@"";
    
    if([self.titletext isEqualToString:@"申请退款"]){
        _titlearr=@[@"申请服务",@"物流状态",@"退款金额"];
        _titlebrr=@[@"仅退款",@"请选择物流状态",moneyTextStr];
        _titlesArray1 = @[@"已收到货",@"未收到货"];
        textViewString=@"退款说明,最多200字";
    }else if([self.titletext isEqualToString:@"申请退货"]){
        _titlearr=@[@"申请服务",@"退货原因",@"退款金额"];
        _titlebrr=@[@"退货退款",@"请选择退货原因",moneyTextStr];
        textViewString=@"退货说明,最多200字";
    }else if([self.titletext isEqualToString:@"申请换货"]){
        _titlearr=@[@"申请服务",@"换货原因",@"退款金额"];
        _titlebrr=@[@"换货",@"请选择换货原因",moneyTextStr];
        textViewString=@"换货说明,最多200字";
    }

    for(int i=0;i<_titlearr.count;i++)
    {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(ZOOM(62), 70*i+10, kApplicationWidth-ZOOM(62)*2, 50)];
        view.tag=7000+i;
        view.layer.cornerRadius=5;
        view.layer.borderWidth=1;
        view.layer.borderColor=lineGreyColor.CGColor;
        view.backgroundColor=[UIColor whiteColor];
        [_Myscrollview addSubview:view];
        
        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(94), 70*i+20, 150, 30)];
        lable.font=[UIFont systemFontOfSize:ZOOM(48)];
        lable.tag=8000+i;
        lable.textColor=kTextGreyColor;
        [_Myscrollview addSubview:lable];
        
        UILabel *lable1=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(300), 70*i+20, CGRectGetWidth(view.frame)-30-ZOOM(320), 30)];
        lable.font=[UIFont systemFontOfSize:ZOOM(48)];
        lable1.font=[UIFont systemFontOfSize:ZOOM(48)];
        lable1.tag=9000+i;
        lable.text=_titlearr[i];
        lable1.text=_titlebrr[i];
        [_Myscrollview addSubview:lable1];

        if(i<2)  {
            UIButton *selectbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            selectbtn.frame=CGRectMake(CGRectGetMaxX(view.frame)-ZOOM(32)-40, 70*i+11, 48, 48);
            selectbtn.tag=6666+i;
            selectbtn.layer.cornerRadius=5;
            selectbtn.backgroundColor=[UIColor whiteColor];
            [selectbtn setTintColor:[UIColor blackColor]];
            selectbtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
            [selectbtn addTarget:self action:@selector(selectclick:) forControlEvents:UIControlEventTouchUpInside];
            [_Myscrollview addSubview:selectbtn];
            
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(view.frame)-ZOOM(32)-30, 70*i+30, 30, 10)];
            img.backgroundColor=[UIColor whiteColor];
            img.image = [UIImage imageNamed:@"更多-1"];
            [_Myscrollview addSubview:img];
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(img.frame.origin.x-ZOOM(32), 70*i+10, 1, 50)];
            line.backgroundColor=lineGreyColor;
            [_Myscrollview addSubview:line];
            
        }else if (2 == i) {
            lable1.textColor=tarbarrossred;
//            UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62),CGRectGetMaxY(view.frame), view.frame.size.width, 20)];
//            moneyLabel.tag=9999;
//            moneyLabel.font=[UIFont systemFontOfSize:ZOOM(37)];
//            moneyLabel.textColor=kTextGreyColor;
//            [_Myscrollview addSubview:moneyLabel];
            
            lable1.hidden=self.shop_from.integerValue==4?NO:YES;
            
            moneyText=[[UITextField alloc]initWithFrame:CGRectMake(ZOOM(300), 70*i+20, CGRectGetWidth(view.frame)-ZOOM(320), 30)];
            moneyText.font=[UIFont systemFontOfSize:ZOOM(48)];
            moneyText.placeholder=[NSString stringWithFormat:@"最多可退款金额为%@元",moneyTextStr];
            moneyText.text=[NSString stringWithFormat:@"%@",moneyTextStr];
            moneyText.keyboardType=UIKeyboardTypeDecimalPad;
            moneyText.textColor=tarbarrossred;
            moneyText.delegate=self;
            [_Myscrollview addSubview:moneyText];
            
            [self setupForDismissKeyboard];
            moneyText.hidden=self.shop_from.integerValue==4?YES:NO;
        }
    }
    
    if([self.titletext isEqualToString:@"申请退款"]){
        UILabel * discriptionLab = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), _titlearr.count*70, kApplicationWidth-ZOOM(62)*2, 30)];
        discriptionLab.text = @"退款成功后，订单抵扣的余额与卡费也将同时退回。";
        discriptionLab.numberOfLines = 0;
        discriptionLab.font=[UIFont systemFontOfSize:ZOOM(40)];
        discriptionLab.textColor=kTextGreyColor;
        [self.Myscrollview addSubview:discriptionLab];
    }
    if([self.titletext isEqualToString:@"申请换货"]){
        UIView *view = (UIView *)[_Myscrollview viewWithTag:7000+2];
        UILabel *label = (UILabel *)[_Myscrollview viewWithTag:8000+2];
        UILabel *label1 = (UILabel *)[_Myscrollview viewWithTag:9000+2];
        UILabel *label2 = (UILabel *)[_Myscrollview viewWithTag:9999];
        view.hidden=YES;
        label.hidden=YES;
        label1.hidden=YES;
        label2.hidden=YES;
        moneyText.hidden=YES;
        _titlearr=@[@"申请服务",@"换货原因"];
        _titlebrr=@[@"换货",@"请选择换货原因"];        
    }
    
    if([self.titletext isEqualToString:@"申请换货"] || self.shop_from.intValue==1 || self.shop_from.intValue==4){
        self.mytextview.frame=CGRectMake(ZOOM(62), _titlearr.count*70+10, kApplicationWidth-ZOOM(62)*2, self.mytextview.frame.size.height);
    }else if ([self.titletext isEqualToString:@"申请退款"]){
        self.mytextview.frame=CGRectMake(ZOOM(62), _titlearr.count*70+30+10, kApplicationWidth-ZOOM(62)*2, self.mytextview.frame.size.height);
    }
    else
        self.mytextview.frame=CGRectMake(ZOOM(62), _titlearr.count*70+30, kApplicationWidth-ZOOM(62)*2, self.mytextview.frame.size.height);
    
    _mytextview.layer.borderWidth=1;
    _mytextview.layer.borderColor=lineGreyColor.CGColor;
    self.mytextview.text=textViewString;
    self.mytextview.font=[UIFont systemFontOfSize:ZOOM(40)];
    self.mytextview.textColor=kTextGreyColor;
    self.mytextview.delegate=self;
    
    KeyboardTool *tool = [KeyboardTool keyboardTool];
    tool.delegate = self;
    tool.frame=CGRectMake(0, tool.frame.origin.y, kScreenWidth, 40);
    self.mytextview.inputAccessoryView = tool;

    self.addimage.frame=CGRectMake(ZOOM(62), self.mytextview.frame.origin.y+_mytextview.frame.size.height+10,self.addimage.frame.size.width, _widh);
    _photoView.frame=CGRectMake(ZOOM(62), CGRectGetMaxY(_addimage.frame), kScreenWidth-ZOOM(62)*2, _widh);

    [self.addimage addTarget:self action:@selector(addimageclick:) forControlEvents:UIControlEventTouchUpInside];
    self.addimage.titleLabel.font=[UIFont systemFontOfSize:ZOOM(48)];
    

    UIView *footview=[[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight-ZOOM(166)+kUnderStatusBarStartY, kApplicationWidth,ZOOM(166))];
    footview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:footview];
    UIButton *submitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame=CGRectMake((kApplicationWidth-100)/2,ZOOM(23), 100,ZOOM(120));
    [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM(48)];
    submitBtn.backgroundColor=[UIColor blackColor];
    [submitBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footview addSubview:submitBtn];
    
    
    
    NSArray *titlesArray ;
    
    if (self.shop_from.integerValue==4&&_ordermodel.issue_status.integerValue==3) {
        titlesArray = @[@"退货退款",@"换货"];
    }
    else if (self.shop_from.integerValue==2||(_ordermodel.is_kick.intValue==1&&(_ordermodel.status.intValue==6||_ordermodel.status.intValue==5||_ordermodel.status.intValue==4))) {
        titlesArray = @[@"换货"];
    }
    else if(_ordermodel.orderShopStatus.intValue==0&&(_ordermodel.status.intValue==3||_ordermodel.status.intValue==4||_ordermodel.status.intValue==5||_ordermodel.status.intValue==6)){
        titlesArray = @[@"退货退款",@"换货"];
    }
    else if([self.titletext isEqualToString:@"申请退货"]) {
        titlesArray = @[@"退货退款",@"仅退款",@"换货"];
    }else if([self.titletext isEqualToString:@"申请退款"]){
        titlesArray = @[@"仅退款"];
    }else if((_ordermodel.status.intValue==6||_ordermodel.status.intValue==5||_ordermodel.status.intValue==4)&&[self.titletext isEqualToString:@"申请换货"]){
        titlesArray = @[@"换货"];
    }
    else
        titlesArray = @[@"退货退款",@"仅退款",@"换货"];
    
    self.refundArray=titlesArray;
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    if (textField.text.doubleValue>self.orderPrice.doubleValue) {
    if (textField.text.doubleValue>[moneyTextStr doubleValue]) {
        [self showHint:@"请不要输入高于可退款金额"];
        textField.text=nil;
    }
}
-(void)selectclick:(UIButton*)sender
{
    [self.view endEditing:YES];
    CGPoint point;
    if(sender.tag==6666){
        point=CGPointMake(kApplicationWidth-40, 120);
//        PopoverView *pop = [[PopoverView alloc] initWithPoint:point titles:titlesArray images:nil withSceenWith:kScreenWidth popWith:0 cellTextFont:0];
//        pop.tag=8888;
//        pop.delegate = self;
//        [pop show];
        
        WTFPickerView *myPicker = [[WTFPickerView alloc]initWithDataArr:self.refundArray];
        [myPicker didFinishSelectedString:^(NSString *selectPickerViewString) {
         
                UILabel *lable=(UILabel*)[_Myscrollview viewWithTag:9000];
                lable.text=selectPickerViewString;
                if([selectPickerViewString isEqualToString:@"退货退款"]){
                    self.titletext=@"申请退货";
                    _titlelable.text=@"申请退货";
                }else if([selectPickerViewString isEqualToString:@"仅退款"]){
                    self.titletext=@"申请退款";
                    _titlelable.text=@"申请退款";
                }else{
                    self.titletext=@"申请换货";
                    _titlelable.text=@"申请换货";
                }
                [self refreshView];
            
        }];
        
    }else{
        //选择退款原因
        WTFPickerView *myPicker = [[WTFPickerView alloc]initWithDataArr:_titlesArray1];
        [myPicker.picker selectRow:_titlesArray1.count/2 inComponent:0 animated:NO];
        myPicker.theRow=_titlesArray1.count/2;
        [myPicker didFinishSelectedString:^(NSString *selectPickerViewString) {
            UILabel *lable=(UILabel*)[_Myscrollview viewWithTag:9001];
            lable.text=selectPickerViewString;
        }];
    }

}
#pragma mark pickerView代理方法
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _titlesArray1.count;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_titlesArray1 objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *str=_titlesArray1[row];
    UILabel *lable=(UILabel*)[_Myscrollview viewWithTag:9001];
    lable.text=str;
    lable.font=[UIFont systemFontOfSize:17];
}
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *vvvvv=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 40)];
    vvvvv.textAlignment=NSTextAlignmentCenter;
    vvvvv.font=[UIFont systemFontOfSize:17];
    vvvvv.text=_titlesArray1[row];
    return vvvvv;
}

#pragma mark 完成选择
-(void)saveBirthday
{
    [_dateView removeFromSuperview];
    //    获取选中的列中的所在的行
    NSInteger row=[_pickview selectedRowInComponent:0];
    
    //    然后是获取这个行中的值，就是数组中的值
    NSString *value=[_titlesArray1 objectAtIndex:row];
    UILabel *lable=(UILabel*)[_Myscrollview viewWithTag:9001];
    lable.text=value;
    lable.font=[UIFont systemFontOfSize:17];

    _isclick=NO;
}

#pragma mark 取消
-(void)cancle{
    [_dateView removeFromSuperview];
    _isclick=NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_dateView removeFromSuperview];
    _isclick=NO;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_dateView removeFromSuperview];
    _isclick=NO;
}

#pragma mark --PopoverView 代理
- (void)seletRowAtIndex:(PopoverView *)popoverView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_dateView removeFromSuperview];
    _isclick=NO;
    if(popoverView.tag==8888){
        if(self.refundArray.count){
            NSString *str=self.refundArray[indexPath.row];
            UILabel *lable=(UILabel*)[_Myscrollview viewWithTag:9000];
            lable.text=str;
            if([str isEqualToString:@"退货退款"])
            {
                self.titletext=@"申请退货";
                _titlelable.text=@"申请退货";
            }else if([str isEqualToString:@"仅退款"]){
                self.titletext=@"申请退款";
                _titlelable.text=@"申请退款";
            }else{
                self.titletext=@"申请换货";
                _titlelable.text=@"申请换货";
            }

            [self refreshView];
        }

    }

    if(popoverView.tag==9999) {
        if(self.statueArray.count)  {
            NSString *str=self.statueArray[indexPath.row];
            UILabel *lable=(UILabel*)[_Myscrollview viewWithTag:9001];
            lable.text=str;
        }
    }
    
}
//键盘
- (void)keyboardTool:(KeyboardTool *)keyboardTool itemClick:(KeyboardToolItemType)itemType
{
    if([self.mytextview.text isEqualToString:@" "]||self.mytextview.text.length==0){
        self.mytextview.text=textViewString;
    }
    [self.view endEditing:YES];
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [_dateView removeFromSuperview];
    _isclick=NO;

    if([self.mytextview.text isEqualToString:textViewString]) {
        self.mytextview.text=@" ";
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([self.mytextview.text isEqualToString:@" "]||self.mytextview.text.length==0) {
        self.mytextview.text=textViewString;
    }
}
#pragma mark 获取图片
-(void)addimageclick:(UIButton*)sender
{
    [self.view endEditing:YES];
    if (_imageArray.count<3) {
        UIActionSheet *actionsheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册获取", nil];
        [actionsheet showInView:self.view];
    }else
        [MBProgressHUD showError:@"最多3张"];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0){
        TFCustomCamera *camera=[[TFCustomCamera alloc]init];
        camera.delegate=self;
        camera.maxPhotoCount=3-(int)_imageArray.count;
        [self.navigationController pushViewController:camera animated:YES];
    }else if (buttonIndex==1) {
        DoImagePickerController *doimg=[[DoImagePickerController alloc]init];
        doimg.delegate=self;
        doimg.nColumnCount=4;
        doimg.nResultType=DO_PICKER_RESULT_UIIMAGE;
        doimg.nMaxCount=3-_imageArray.count;
        [self.navigationController pushViewController:doimg animated:YES];
    }
}

#pragma mark cameradelegate
-(void)SelectPhotoEnd:(TFCustomCamera *)Manager WithPhotoArray:(NSArray *)PhotoArray
{
    for(int i =0 ;i<PhotoArray.count;i++) {
        [_imageArray addObject:PhotoArray[i]];
    }
    [self changePhotoView:PhotoArray];
}

#pragma mark DoImagePickerControllerDelegate
-(void)didCancelDoImagePickerController
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)didSelectPhotosFromDoImagePickerController:(DoImagePickerController *)picker result:(NSArray *)aSelected
{
    for(int i =0 ;i<aSelected.count;i++){
        [_imageArray addObject:aSelected[i]];
    }
    [self changePhotoView:aSelected];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)delateimage:(UIButton*)sender
{
    [_imageArray removeObjectAtIndex:(sender.tag%3000)];
    UIImageView *imgView = [_photoView viewWithTag:(2000+sender.tag%3000)];
    [imgView removeFromSuperview];
    for (int i=(sender.tag%3000); i<_imageArray.count; i++) {
            UIImageView *imgView = [_photoView viewWithTag:i+2001];
        UIButton *btn = [imgView viewWithTag:3001+i];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        imgView.frame=CGRectMake((_widh+10)*i, 0, _widh, _widh);
        imgView.tag=i+2000;
        btn.tag=i+3000;
        [UIView commitAnimations];
    }
}

-(void)changePhotoView:(NSArray *)PhotoArray
{
    for(UIView *vv in _photoView.subviews) {
        [vv  removeFromSuperview];
    }
    
    for(int i=0;i<_imageArray.count;i++){
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake((_widh+10)*i, 0, _widh, _widh)];
        imageview.image=_imageArray[i];
        imageview.clipsToBounds = YES;
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        imageview.tag=2000+i;
        UIButton *deleatebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleatebtn.tag = 3000+i;
        deleatebtn.frame = CGRectMake(0, 0, 20, 20);
        [deleatebtn setImage:[UIImage imageNamed:@"删除图片"] forState:UIControlStateNormal];
        [deleatebtn addTarget:self action:@selector(delateimage:) forControlEvents:UIControlEventTouchUpInside];
        [imageview addSubview:deleatebtn];
        [_photoView addSubview:imageview];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageclick:)];
        [imageview addGestureRecognizer:tap];
        imageview.userInteractionEnabled=YES;
    }
    if(_imageArray.count<3){
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:_imageArray] forKey:@"aSelected"];
    }
}
-(void)imageclick:(UITapGestureRecognizer*)tap
{
    [self.view endEditing:YES];
    UIImageView *imageview=(UIImageView*)[_Myscrollview viewWithTag:tap.view.tag];
    if(imageview.tag==2000+_imageArray.count){
        UIActionSheet *actionsheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册获取", nil];
        [actionsheet showInView:self.view];
    }else{
        
        NSInteger image_page=imageview.tag%2000+1;
        
        UIView *Screenwindow = [[UIApplication sharedApplication].delegate window];
        
        _fullScreenScrollView = [[FullScreenScrollView alloc]initWithPicutreArray:_imageArray withCurrentPage:image_page];
        
        _fullScreenScrollView.backgroundColor = [UIColor blackColor];
        
        [Screenwindow addSubview:_fullScreenScrollView];
        
    }
    
}
#pragma mark 提交退款 退货信息
-(void)submitBtnClick:(UIButton*)sender
{
    NSString *message;
    UILabel *label = (UILabel *)[_Myscrollview viewWithTag:9001];
    if ([label.text isEqualToString:_titlebrr[1]]) {
        message=_titlebrr[1];
        NavgationbarView *view=[[NavgationbarView alloc]init];
        [view showLable:message Controller:self];
    }else if (moneyText.hidden==NO&&moneyText.text.length==0){
        NavgationbarView *view=[[NavgationbarView alloc]init];
        [view showLable:@"请输入退款金额" Controller:self];
    }
    else if([self.mytextview.text isEqualToString:textViewString]||self.mytextview.text.length==0){
        message=@"添加说明，更容易帮你处理哦";
        NavgationbarView *view=[[NavgationbarView alloc]init];
        [view showLable:message Controller:self];
    }else if(_imageArray.count){
        [self creatUPY];
    }else{
        [self rerundHttp];
    }
}

#pragma mark 将图片上传到upyun
-(void)creatUPY
{
    [MBProgressHUD showMessage:@"正在上传图片" afterDeleay:0 WithView:self.view];
    __block int count=_imageArray.count;
    UpYun *uy = [[UpYun alloc] init];
    uy.successBlocker = ^(id data){
        NSString *imgurl=data[@"url"];
        if(imgurl){
            [_images appendString:imgurl];
            [_images appendString:@","];
            count=count-1;
            if(count==0){
                NavgationbarView *view=[[NavgationbarView alloc]init];
                [view showLable:@"上传成功" Controller:self];
                [MBProgressHUD hideHUDForView:self.view];
                [self rerundHttp];
            }
        }
    };
    
    uy.failBlocker = ^(NSError * error){
        [MBProgressHUD hideHUDForView:self.view];
        NSString *message = [error.userInfo objectForKey:@"message"];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络开小差啦，请退出重进" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        count=count-1;
    };
    
    for(int i=0;i<_imageArray.count;i++){
        UIImage * image1 =_imageArray[i];
        [uy uploadFile:image1 saveKey:[self getSaveKey]];
    }
}

-(NSString * )getSaveKey {
    NSString *UID=[self getNumber];
    NSDate *d = [NSDate date];
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    return [NSString stringWithFormat:@"/returnShop/%@/%@%d%.0f.jpg",[formatter stringFromDate:[NSDate date]],UID,[self getSecond:d],[[NSDate date] timeIntervalSince1970]];
}

#pragma mark 获取毫秒数
- (int)getSecond:(NSDate *) date{
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    int second = [comps second];
    return second;
}

#pragma mark 获取UID
-(NSString*)getNumber
{
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    NSMutableString *strNum=[NSMutableString string];
    
    for (int i=0; i<token.length; i++) {
        NSString *character=[token substringWithRange:NSMakeRange(i, 1)];//循环取每个字符
        
        if ([character isEqual: @"0"]|
            [character isEqual: @"1"]|
            [character isEqual: @"2"]|
            [character isEqual: @"3"]|
            [character isEqual: @"4"]|
            [character isEqual: @"5"]|
            [character isEqual: @"6"]|
            [character isEqual: @"7"]|
            [character isEqual: @"8"]|
            [character isEqual: @"9"]) {
            
            strNum=[strNum stringByAppendingString:character];//是数字的累加起来
        }
    }
    return strNum;
}

#pragma mark 退款 退货网络请求
-(void)rerundHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    UILabel *lable=(UILabel*)[_Myscrollview viewWithTag:9001];//原因
    NSString *casue=lable.text;
    NSString *titlestr;
    NSString *returntype;
    if([self.titletext isEqualToString:@"申请退货"]){
        returntype=@"2";
        titlestr=@"退货详情";
    }else if ([self.titletext isEqualToString:@"申请换货"]){
        returntype=@"1";
        titlestr=@"换货详情";
    }else if ([self.titletext isEqualToString:@"申请退款"]) {
        returntype=@"3";
        titlestr=@"退款详情";
    }
    
//    url=[NSString stringWithFormat:@"%@returnShop/add?version=%@&token=%@&explain=%@&return_type=%@&order_code=%@&cause=%@",[NSObject baseURLStr],VERSION,token,self.mytextview.text,returntype,ordercode,casue];
    
    NSString *url;
    if (self.shop_from.intValue==1) {
        url=[NSString stringWithFormat:@"%@returnShop/addZero?version=%@&token=%@&explain=%@&return_type=%@&order_code=%@&cause=%@&money=%@",[NSObject baseURLStr],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN],self.mytextview.text,returntype,self.order_code,casue,moneyText.text];
    }else if (self.shop_from.intValue==4){
        url=[NSString stringWithFormat:@"%@treasures/addReturn?version=%@&token=%@&explain=%@&return_type=%@&order_code=%@&cause=%@",[NSObject baseURLStr],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN],self.mytextview.text,returntype,self.order_code,casue];
    }
    else
        url=[NSString stringWithFormat:@"%@returnShop/add?version=%@&token=%@&explain=%@&return_type=%@&order_shop_id=%@&order_shop_status=%@&cause=%@&money=%@",[NSObject baseURLStr],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN],self.mytextview.text,returntype,self.ordermodel.ID,_ordermodel.status,casue,moneyText.text];
    
    NSString *URL=[MyMD5 authkey:url];
//    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            NSDictionary *dic=responseObject[@"returnShop"];
            MyLog(@"%@",responseObject[@"returnShop"]);
            if(statu.intValue==1){
                message=@"恭喜你，申请成功！";
                ChangeDetailViewController *change=[[ChangeDetailViewController alloc]init];
                change.titlestring=titlestr;
                change.ordercode=responseObject[@"order_code"];
                change.dic=dic;
                [self.navigationController pushViewController:change animated:YES];
            }
            else if (statu.intValue==10030) {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_TOKEN];
                LoginViewController *login=[[LoginViewController alloc]init];
                login.tag=1000;
                login.loginStatue = @"10030";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud removeObjectForKey:USER_TOKEN];
            }
            else{
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:message Controller:self];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络连接失败"];
    }];
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
//    for (UIViewController *controller in self.navigationController.viewControllers) {
//        if ([controller isKindOfClass:[AftersaleViewController class]]) {
//            [self.navigationController popToViewController:controller animated:YES];
//        }else{
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
