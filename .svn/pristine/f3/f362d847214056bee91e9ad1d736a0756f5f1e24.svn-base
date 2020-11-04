//
//  DistributionRegistViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/10/26.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "DistributionRegistViewController.h"
#import "WithdrawalsViewController.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "MyMD5.h"
#import "KeyboardTool.h"
#import "FullScreenScrollView.h"
#import "NavgationbarView.h"
#import "LoginViewController.h"
#import "DoImagePickerController.h"
#import "DiscountViewController.h"
#import "CameraVC.h"
#import "CityModel.h"
#import "AreaModel.h"
#import "StateModel.h"
#import "UpYun.h"
#import <MapKit/MapKit.h>
#import "HZAreaPickerView.h"
#import <CoreLocation/CoreLocation.h>
#import "TFBusinessCategoryViewController.h"
#import "TFUserLocation.h"
#import "GlobalTool.h"
#import "TFBusinessCategoryViewController.h"

#define fildFont ZOOM(48)

#define IMGSIZECOMPCOEFF1 8.0f
@interface DistributionRegistViewController ()<DoImagePickerControllerDelegate,CameraDelegate,CLLocationManagerDelegate,TFUserLocationDelegate,CategoryChooseDelegate>
{
    UIScrollView *_bigScrollview;
    
    //键盘
    KeyboardTool *_keyboardtool;
    
    NSString *_actionsheettype;
    
    //业务员名称
    UITextField *_namefild;
    //机构名称
    UITextField *_organizationfild;
    //所在地区
    UITextField *_areafild;
    //详细地址
    UITextField *_addressfild;
    //LBS定位
    UISwitch *_lightswitch;
    //人均消费
    UITextField *_Consumptionfild;
    //会员折扣
    UITextField *_Discountfild;
    //会员独享服务
    UITextView *_ExclusiveTextview;
    //机构大图
    UIImageView *_bigImageview;
    //机构小图
    UIView *_organizationImageView2;
    //折扣view
    UIView *_ConsumptionView;
    //提交按钮
    UIButton *_submitbtn;
    //添加机构小图
    UIImageView *_smallImageview;
    //选择的类目
    UILabel *_categoryLable;
    //键盘高度
    CGRect _keyboardFrame;
    //添加地址按钮
    UIButton *_addressbtn;
    //选择性别按钮
    UIButton *_chooseSexbtn;
    
    NavgationbarView *_mentionview;
    
    //定位
    CLLocationManager *_locationManager;
    CGFloat lat2;//经度
    CGFloat lng2;//纬度
    int dinnumble;
    
    //定位到的城市
    NSString *_locationCity;
    
    NSString *businessName;//姓名
    NSString *Contactperson;//联系人
    NSString *businessSex;//性别
    NSString *businessPhone;//电话
    NSString *businessAge;//年龄
    NSString *businessID;//身份证号
    NSString *memberdiscount;//会员折扣
    NSString *memberConsumption;//人均消费
    NSString *discountDiscription;//折扣说明
    NSMutableString *bigImages;//大图
    NSMutableString *smallImages;//小图
    NSString *bus_type;//商家一级类别
    NSString *bus_typeTwo;//商家二级类别
    NSString *_intact_addr; //定位到的省市区街道
    
    FullScreenScrollView *_fullScreenScrollView;
}
@end

@implementation DistributionRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageArray = [NSMutableArray array];
    self.upyImageArray = [NSMutableArray array];
    _bigImageArray = [NSMutableArray array];
    _smallImageArray = [NSMutableArray array];
    _smallImageview.hidden =NO;
    
    
    
    [self creatKeyboard];
    
    [self creatNavagation];
    
    [self creatView];
    
    _intact_addr = @"";

    if(self.businessDictionary)
    {
        [self creatData];
    }
    
    _mentionview =[[NavgationbarView alloc] init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"aSelected"];
    
    if([self.statu isEqualToString:@"商家信息审核未通过"])
    {
        NavgationbarView *mentionview = [[NavgationbarView alloc] init];
        [mentionview showLable:@"商家信息审核未通过" Controller:self];
    }
    
    
    //会员折扣监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(discount:) name:@"discount" object:nil];
    
    
   #pragma mark - keyboard 键盘监听
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    
//    [self textHttprequest];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    Myview.hidden=YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    Myview.hidden=NO;
}

- (void)creatNavagation
{
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //
    headview.backgroundColor = [UIColor whiteColor];
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
    titlelable.text=@"注册";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];

}

-(void)creatKeyboard
{
    _keyboardtool = [KeyboardTool keyboardTool];
    _keyboardtool.delegate = self;
    _keyboardtool.frame=CGRectMake(0, _keyboardtool.frame.origin.y, kScreenWidth, 40);
}

#pragma mark 创建主界面
-(void)creatView
{
    _bigScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kApplicationWidth, kApplicationHeight-Height_NavBar+kUnderStatusBarStartY)];
    _bigScrollview.userInteractionEnabled=YES;
    _bigScrollview.delegate = self;
    _bigScrollview.scrollEnabled=YES;
    _bigScrollview.backgroundColor = kBackgroundColor;
    _bigScrollview.contentSize=CGSizeMake(0, 20000);
    [self.view addSubview:_bigScrollview];
    
    //认真填写资料
    UILabel *datatitlelab = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(40), ZOOM(85), kApplicationWidth-2*ZOOM(40), ZOOM(60))];
    datatitlelab.text = @"请认真填写以下资料予以系统审核";
    datatitlelab.font = [UIFont systemFontOfSize:ZOOM(57)];
    [_bigScrollview addSubview:datatitlelab];
    
    CGFloat datalabY = CGRectGetMaxY(datatitlelab.frame);
    UIView *dataView = [[UIView alloc]initWithFrame:CGRectMake(0, datalabY+ZOOM(77), kApplicationWidth, ZOOM(300))];
    dataView.backgroundColor =[UIColor whiteColor];
    [_bigScrollview addSubview:dataView];
    
    _namefild =[[UITextField alloc]initWithFrame:CGRectMake(ZOOM(40), (ZOOM(150)-ZOOM(30*3.4))/2, kApplicationWidth - 2*ZOOM(40), ZOOM(30*3.4))];
    _namefild.placeholder = @"注册业务员名称";
    _namefild.textColor = kTextColor;
    _namefild.delegate = self;
    _namefild.tag = 7000;
    _namefild.font = [UIFont systemFontOfSize:fildFont];
    _namefild.inputAccessoryView = _keyboardtool;
    [dataView addSubview:_namefild];
    
    UILabel *nameline = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(40), ZOOM(150), kApplicationWidth-ZOOM(40), 1)];
    nameline.backgroundColor = kBackgroundColor;
    [dataView addSubview:nameline];
    
    CGFloat organizationY = CGRectGetMaxY(nameline.frame);
    _organizationfild =[[UITextField alloc]initWithFrame:CGRectMake(ZOOM(40), organizationY+(ZOOM(150)-ZOOM(30*3.4))/2, kApplicationWidth - 2*ZOOM(40), ZOOM(30*3.4))];
    _organizationfild.placeholder = @"机构名称";
    _organizationfild.delegate = self;
    _organizationfild.textColor = kTextColor;
    _organizationfild.tag = 7001;
    _organizationfild.font = [UIFont systemFontOfSize:fildFont];
    _organizationfild.inputAccessoryView = _keyboardtool;
    [dataView addSubview:_organizationfild];
    
    //机构信息
    CGFloat organizationInformationlableY =CGRectGetMaxY(dataView.frame);
    UILabel *organizationInformationlable =[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(40), organizationInformationlableY+ZOOM(60), kApplicationWidth-2*ZOOM(40), ZOOM(60))];
    organizationInformationlable.text = @"机构信息";
    organizationInformationlable.font = [UIFont systemFontOfSize:ZOOM(57)];
    [_bigScrollview addSubview:organizationInformationlable];
    
    UIView *CategoryView =[[UIView alloc]initWithFrame:CGRectMake(0, organizationInformationlableY+ZOOM(180), kApplicationWidth, ZOOM(150))];
    CategoryView.backgroundColor =[UIColor whiteColor];
    [_bigScrollview addSubview:CategoryView];
    
    UIImageView *titleImage =[[UIImageView alloc]initWithFrame:CGRectMake(ZOOM(40), (ZOOM(150)-IMAGEH(@"类目列表"))/2, IMAGEW(@"类目列表"), IMAGEH(@"类目列表"))];
    titleImage.image = [UIImage imageNamed:@"类目列表"];
    [CategoryView addSubview:titleImage];
    
    CGFloat CategoryListX = CGRectGetMaxX(titleImage.frame);
    UILabel *CategoryListLable = [[UILabel alloc]initWithFrame:CGRectMake(CategoryListX+ZOOM(43), ZOOM(40), ZOOM(80*3.4), ZOOM(60))];
    CategoryListLable.text = @"类目列表";
    CategoryListLable.font = [UIFont systemFontOfSize:ZOOM(57)];
    [CategoryView addSubview:CategoryListLable];
    
    CGFloat categoryX =CGRectGetMaxX(CategoryListLable.frame);
    _categoryLable = [[UILabel alloc]initWithFrame:CGRectMake(categoryX, ZOOM(30), kApplicationWidth-ZOOM(70)-categoryX-ZOOM(60), ZOOM(90))];
    _categoryLable.textColor = kTextColor;
    _categoryLable.textAlignment = NSTextAlignmentRight;
    _categoryLable.font = [UIFont systemFontOfSize:fildFont];
    [CategoryView addSubview:_categoryLable];
    
    UIImageView *moreimage = [[UIImageView alloc]initWithFrame:CGRectMake(kApplicationWidth-ZOOM(70)-IMAGEW(@"更多-副本-3"), (ZOOM(150)-IMAGEH(@"更多-副本-3"))/2, IMAGEW(@"更多-副本-3"),IMAGEH(@"更多-副本-3"))];
    moreimage.image = [UIImage imageNamed:@"更多-副本-3"];
    [CategoryView addSubview:moreimage];
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreCategory:)];
    
    CategoryView.userInteractionEnabled = YES;
    [CategoryView addGestureRecognizer:tap];
    
    
    UILabel *organizationUserInfo=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(40), CGRectGetMaxY(CategoryView.frame)+ZOOM(60), kApplicationWidth-2*ZOOM(40), ZOOM(60))];
    organizationUserInfo.text = @"机构联系人";
    organizationUserInfo.font = [UIFont systemFontOfSize:ZOOM(57)];
    [_bigScrollview addSubview:organizationUserInfo];

    //用户信息
    CGFloat userInformationViewY = CGRectGetMaxY(organizationUserInfo.frame);
    UIView *userInformationView = [[UIView alloc]initWithFrame:CGRectMake(0, userInformationViewY+ZOOM(60), kApplicationWidth, ZOOM(740))];
    userInformationView.backgroundColor = [UIColor whiteColor];
    [_bigScrollview addSubview:userInformationView];
    
    
    NSArray *userArray =@[@"姓名",@"性别",@"电话",@"年龄",@"身份证号"];
    for(int i =0 ;i<userArray.count ; i++)
    {
        UITextField *titlefild =[[UITextField alloc]initWithFrame:CGRectMake(ZOOM(40), (ZOOM(150)-ZOOM(30*3.4))/2+ZOOM(150)*i, kApplicationWidth - 2*ZOOM(40), ZOOM(30*3.4))];
        titlefild.placeholder = userArray[i];
        titlefild.delegate = self;
        titlefild.textColor = kTextColor;
        titlefild.font = [UIFont systemFontOfSize:fildFont];
        titlefild.inputAccessoryView = _keyboardtool;
       
        titlefild.tag = 8001+i;
       
        [userInformationView addSubview:titlefild];
//        if( i==0)
//        {
//            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, titlefild.frame.size.width, titlefild.frame.size.height)];
//            [titlefild addSubview:view];
//        }
        
        if(i == 1)
        {
            titlefild.inputView = [[UIView alloc]initWithFrame:CGRectZero];
            
            _chooseSexbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _chooseSexbtn.frame = CGRectMake(0, 0, titlefild.frame.size.width, titlefild.frame.size.height);
            [titlefild addSubview:_chooseSexbtn];
            [_chooseSexbtn addTarget:self action:@selector(createPopView) forControlEvents:UIControlEventTouchUpInside];
        }
        
        if (i!=userArray.count) {
            UILabel *labline = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(40), ZOOM(150)+ZOOM(150)*i, kApplicationWidth-ZOOM(40), 1)];
            labline.backgroundColor = kBackgroundColor;
            [userInformationView addSubview:labline];
        }
       
        
       
    }
    
    //机构地址
    CGFloat organizationAdressY =CGRectGetMaxY(userInformationView.frame);
    UILabel *organizationAdresslable =[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(40), organizationAdressY+ZOOM(60), kApplicationWidth-2*ZOOM(40), ZOOM(60))];
    organizationAdresslable.text = @"机构地址";
    organizationAdresslable.font = [UIFont systemFontOfSize:ZOOM(57)];
    [_bigScrollview addSubview:organizationAdresslable];
    
    //LBS定位
    _lightswitch=[[UISwitch alloc]initWithFrame:CGRectMake(kApplicationWidth-60, organizationAdresslable.frame.origin.y-10, 100, 20)];
    _lightswitch.center = CGPointMake(_lightswitch.frame.origin.x+20, organizationAdresslable.center.y);
    [_lightswitch addTarget:self action:@selector(Location) forControlEvents:UIControlEventValueChanged];
    [_lightswitch setOn:NO];
    [_bigScrollview addSubview:_lightswitch];
    
    UILabel *LBSlable = [[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth-170, organizationAdresslable.frame.origin.y, 100, ZOOM(60))];
    LBSlable.text = @"LBS定位";
    LBSlable.font = [UIFont systemFontOfSize:ZOOM(57)];
    LBSlable.textAlignment = NSTextAlignmentRight;
    [_bigScrollview addSubview:LBSlable];
    
    UIView *organizationAdressView = [[UIView alloc]initWithFrame:CGRectMake(0, organizationAdressY+ZOOM(180), kApplicationWidth, ZOOM(300))];
    organizationAdressView.backgroundColor = [UIColor whiteColor];
    [_bigScrollview addSubview:organizationAdressView];
    
    _areafild =[[UITextField alloc]initWithFrame:CGRectMake(ZOOM(40), (ZOOM(150)-ZOOM(30*3.4))/2, kApplicationWidth - 2*ZOOM(40), ZOOM(30*3.4))];
    _areafild.placeholder = @"所在地区";
    _areafild.delegate = self;
    _areafild.textColor = kTextColor;
    _areafild.tag = 7003;
    _areafild.font = [UIFont systemFontOfSize:fildFont];
    _areafild.inputView = [[UIView alloc]initWithFrame:CGRectZero];
    [organizationAdressView addSubview:_areafild];
    
    _addressbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addressbtn.frame = CGRectMake(_areafild.frame.origin.x, _areafild.frame.origin.y, _areafild.frame.size.width, _areafild.frame.size.height);
    [organizationAdressView addSubview:_addressbtn];
    [_addressbtn addTarget:self action:@selector(addressBtnClick:) forControlEvents:UIControlEventTouchUpInside];


    
    UILabel *arealableline = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(40), ZOOM(150), kApplicationWidth-ZOOM(40), 1)];
    arealableline.backgroundColor = kBackgroundColor;
    [organizationAdressView addSubview:arealableline];
    
    CGFloat addressY = CGRectGetMaxY(arealableline.frame);
    _addressfild =[[UITextField alloc]initWithFrame:CGRectMake(ZOOM(40), addressY+(ZOOM(150)-ZOOM(30*3.4))/2, kApplicationWidth - 2*ZOOM(40), ZOOM(30*3.4))];
    _addressfild.placeholder = @"详细地址";
    _addressfild.delegate = self;
    _addressfild.textColor = kTextColor;
    _addressfild.tag = 7004;
    _addressfild.font = [UIFont systemFontOfSize:fildFont];
    _addressfild.inputAccessoryView = _keyboardtool;
    [organizationAdressView addSubview:_addressfild];
    
    //机构大图
    CGFloat organizationImageY =CGRectGetMaxY(organizationAdressView.frame);
    UILabel *organizationImagelable =[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(40), organizationImageY+ZOOM(60), kApplicationWidth-2*ZOOM(40), ZOOM(60))];
    organizationImagelable.text = @"机构大图(列表页的主图,尺寸538*800)";
    organizationImagelable.font = [UIFont systemFontOfSize:ZOOM(57)];
    [_bigScrollview addSubview:organizationImagelable];

    UIView *organizationImageView = [[UIView alloc]initWithFrame:CGRectMake(0, organizationImageY+ZOOM(180), kApplicationWidth, IMAGEH(@"列表图框")+ZOOM(200))];
    organizationImageView.backgroundColor = [UIColor whiteColor];
    [_bigScrollview addSubview:organizationImageView];
    
    _bigImageview =[[UIImageView alloc]initWithFrame:CGRectMake((kApplicationWidth-IMAGEW(@"列表图框"))/2, ZOOM(100), IMAGEW(@"列表图框"), IMAGEH(@"列表图框"))];
    _bigImageview.image = [UIImage imageNamed:@"列表图框"];
    [organizationImageView addSubview:_bigImageview];
    
    UITapGestureRecognizer *addBigimagetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addBigImage:)];
    [_bigImageview addGestureRecognizer:addBigimagetap];
    _bigImageview.userInteractionEnabled =YES;
    
    //机构大图2
    CGFloat organizationImageYY =CGRectGetMaxY(organizationImageView.frame);
    UILabel *organizationImagelable2 =[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(40), organizationImageYY+ZOOM(60), kApplicationWidth-2*ZOOM(40), ZOOM(140))];
    organizationImagelable2.text = @"机构大图(首页横播图及商家页顶部大图,最多不超过15张,尺寸1080*750)";
    organizationImagelable2.numberOfLines = 0;
    organizationImagelable2.font = [UIFont systemFontOfSize:ZOOM(57)];
    [_bigScrollview addSubview:organizationImagelable2];
    
    _organizationImageView2 = [[UIView alloc]initWithFrame:CGRectMake(0, organizationImageYY+ZOOM(260), kApplicationWidth, IMAGEH(@"顶图框")+ZOOM(120))];
    _organizationImageView2.backgroundColor = [UIColor whiteColor];
    [_bigScrollview addSubview:_organizationImageView2];
    
    _smallImageview =[[UIImageView alloc]initWithFrame:CGRectMake(ZOOM(40), ZOOM(60), IMAGEW(@"顶图框"), IMAGEH(@"顶图框"))];
    _smallImageview.image = [UIImage imageNamed:@"顶图框"];
    [_organizationImageView2 addSubview:_smallImageview];
    
    UITapGestureRecognizer *addSmallimagetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addSmallimagetap:)];
    [_smallImageview addGestureRecognizer:addSmallimagetap];
    _smallImageview.userInteractionEnabled =YES;
    
    //人均消费 折扣
    CGFloat ConsumptionY = CGRectGetMaxY(_organizationImageView2.frame);
    _ConsumptionView = [[UIView alloc]initWithFrame:CGRectMake(0, ConsumptionY+ZOOM(180), kApplicationWidth, ZOOM(500))];
    _ConsumptionView.backgroundColor = [UIColor whiteColor];
    _ConsumptionView.userInteractionEnabled = YES;
    [_bigScrollview addSubview:_ConsumptionView];
    
    UILabel *consumptionlable =[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(40), ZOOM(30), ZOOM(220), ZOOM(90))];
    consumptionlable.text = @"人均消费:";
    consumptionlable.textColor = kTextColor;
    consumptionlable.font = [UIFont systemFontOfSize:fildFont];
    [_ConsumptionView addSubview:consumptionlable];
    
    _Consumptionfild =[[UITextField alloc]initWithFrame:CGRectMake(ZOOM(40)+consumptionlable.frame.size.width, (ZOOM(150)-ZOOM(30*3.4))/2, kApplicationWidth - ZOOM(40)-ZOOM(140), ZOOM(30*3.4))];
//    _Consumptionfild.placeholder = @"人均消费";
    _Consumptionfild.delegate = self;
    _Consumptionfild.textColor = kTextColor;
    _Consumptionfild.tag = 7005;
    _Consumptionfild.font = [UIFont systemFontOfSize:fildFont];
    _Consumptionfild.inputAccessoryView = _keyboardtool;
    _Consumptionfild.userInteractionEnabled = YES;
    [_ConsumptionView addSubview:_Consumptionfild];
    
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(40), ZOOM(150), kApplicationWidth-ZOOM(40), 1)];
    line1.backgroundColor = kBackgroundColor;
    [_ConsumptionView addSubview:line1];
    
    _Discountfild =[[UITextField alloc]initWithFrame:CGRectMake(ZOOM(40), (ZOOM(150)-ZOOM(30*3.4))/2+ZOOM(150), kApplicationWidth - 2*ZOOM(40), ZOOM(30*3.4))];
    _Discountfild.placeholder = @"会员折扣";
    _Discountfild.delegate = self;
    _Discountfild.textColor = kTextColor;
    _Discountfild.tag = 7006;
    _Discountfild.font = [UIFont systemFontOfSize:fildFont];
    _Discountfild.inputView = [[UIView alloc]initWithFrame:CGRectZero];
    [_ConsumptionView addSubview:_Discountfild];
    
    
    UIImageView *Discountimage = [[UIImageView alloc]initWithFrame:CGRectMake(kApplicationWidth-ZOOM(70)-IMAGEW(@"更多-副本-3"), (ZOOM(150)-IMAGEH(@"更多-副本-3"))/2+ZOOM(150), IMAGEW(@"更多-副本-3"),IMAGEH(@"更多-副本-3"))];
    Discountimage.image = [UIImage imageNamed:@"更多-副本-3"];
    [_ConsumptionView addSubview:Discountimage];
    
    UIButton *Discountbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    Discountbtn.frame = CGRectMake(_Discountfild.frame.origin.x, _Discountfild.frame.origin.y, _Discountfild.frame.size.width, _Discountfild.frame.size.height);
    [_ConsumptionView addSubview:Discountbtn];
    [Discountbtn addTarget:self action:@selector(discountClick:) forControlEvents:UIControlEventTouchUpInside];
    

    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(40), ZOOM(300), kApplicationWidth-ZOOM(40), 1)];
    line2.backgroundColor = kBackgroundColor;
    [_ConsumptionView addSubview:line2];
    
    _ExclusiveTextview =[[UITextView alloc]initWithFrame:CGRectMake(ZOOM(20), (ZOOM(200)-ZOOM(50*3.4))/2+ZOOM(300), kApplicationWidth - 2*ZOOM(40), ZOOM(50*3.4))];
    _ExclusiveTextview.text = @"会员独享服务(限制30字内)";
    _ExclusiveTextview.textColor = RGBCOLOR_I(152,152,152);
    _ExclusiveTextview.font = [UIFont systemFontOfSize:fildFont];;
    _ExclusiveTextview.delegate = self;
    _ExclusiveTextview.inputAccessoryView = _keyboardtool;
    [_ConsumptionView addSubview:_ExclusiveTextview];
    
    
    //提交审核按钮
    
    CGFloat submitbtnY =CGRectGetMaxY(_ConsumptionView.frame);
    _submitbtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _submitbtn.frame =CGRectMake(ZOOM(77), submitbtnY+ZOOM(129), kApplicationWidth - 2*ZOOM(77), ZOOM(50*3.4));
    _submitbtn.backgroundColor = tarbarrossred;
    [_submitbtn setTitle:@"提交审核" forState:UIControlStateNormal];
    _submitbtn.titleLabel.textColor = [UIColor whiteColor];
    _submitbtn.tintColor = [UIColor whiteColor];
    _submitbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(60)];
    [_submitbtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    
    [_bigScrollview addSubview:_submitbtn];
    
    _bigScrollview.contentSize = CGSizeMake(0, _submitbtn.frame.origin.y+_submitbtn.frame.size.height+ZOOM(50));
    
}

#pragma mark 审核未通过信息处理
- (void)creatData
{
    
    //businessDic = %@", self.businessDictionary);
    
    _namefild.text = self.businessDictionary[@"salesman_name"];
    _organizationfild.text = self.businessDictionary[@"bus_name"];
    _areafild.text = self.businessDictionary[@""];
    _addressfild.text = self.businessDictionary[@"addr"];
    _Consumptionfild.text = [NSString stringWithFormat:@"%@",self.businessDictionary[@"svg_price"]];
    
    if (![self.businessDictionary[@"vip_dis"] isEqual:[NSNull null]]) {
         _Discountfild.text = [NSString stringWithFormat:@"会员折扣:%.1f",[self.businessDictionary[@"vip_dis"] floatValue]];
        memberdiscount = [NSString stringWithFormat:@"%.1f",[self.businessDictionary[@"vip_dis"] floatValue]];
    }
    
    discountDiscription = [NSString stringWithFormat:@"%@",self.businessDictionary[@"dis_note"]];
    
    if (![self.businessDictionary[@"content"] isEqual:[NSNull null]]) {
        _ExclusiveTextview.text = self.businessDictionary[@"content"];
    }
    
    if (![self.businessDictionary[@"dis_note"] isEqual:[NSNull null]]) {
        discountDiscription = self.businessDictionary[@"dis_note"];
    }
    
    //地区
    self.stateID = self.businessDictionary[@"province"];
    self.cityID = self.businessDictionary[@"city"];
    self.areaID = self.businessDictionary[@"area"];
    self.streetID = self.businessDictionary[@"street"];
    
    //通过地址ID查询确切地址
    NSMutableString *addressString=[NSMutableString string];
    [addressString appendString:[NSString stringWithFormat:@"%@",self.stateID]];
    [addressString appendString:@"_"];
    [addressString appendString:[NSString stringWithFormat:@"%@",self.cityID]];
    [addressString appendString:@"_"];
    [addressString appendString:[NSString stringWithFormat:@"%@",self.areaID]];
    if(self.streetID !=nil)
    {
        [addressString appendString:@"_"];
        [addressString appendString:[NSString stringWithFormat:@"%@",self.streetID]];
    }
    
    HZAreaPickerView *pickview=[[HZAreaPickerView alloc]init];
    NSString *addStr= [pickview fromIDgetAddress:addressString];
    
    _areafild.text = [NSString stringWithFormat:@"%@",addStr];
    
    for(int i =1; i<6;i++)
    {
        UITextField *fild =(UITextField*)[self.view viewWithTag:8000+i];
        if(i==1)
        {
            fild.text = self.businessDictionary[@"real_name"];
            
        }else if (i==2)//姓别
        {

            if([self.businessDictionary[@"sex"] isEqualToString:@"0"])
            {
                fild.text = @"男";
            }else{
                fild.text = @"女";
            }

            
        }else if (i==3)
        {
            
            if (![self.businessDictionary[@"phone"] isEqual:[NSNull null]]) {
                fild.text = self.businessDictionary[@"phone"];
            }
            
        }else if (i==4)
        {
            fild.text = [NSString stringWithFormat:@"%@",self.businessDictionary[@"age"]];
        }else if (i==5)
        {
            fild.text = self.businessDictionary[@"idcard"];
        }
    }
    
}

- (void)discount:(NSNotification*)note
{
    NSArray *arr = note.object;
    if(arr.count)
    {
        NSString * str = arr[0];
        
        _Discountfild.text = [NSString stringWithFormat:@"会员折扣: %.1f",str.floatValue];
    
        memberdiscount = [NSString stringWithFormat:@"%.1f",str.floatValue];
    }
    
    if(arr.count == 2)
    {
        discountDiscription =[NSString stringWithFormat:@"%@",arr[1]];
    }
}

//省市区
- (void)addressBtnClick:(UIButton *)sender
{
    if(!_lightswitch.on)
    {
        [self.view endEditing:YES];
        
        UITextField *fild = (UITextField*)[self.view viewWithTag:7003];
        CGPoint rootViewPoint = [[fild superview] convertPoint:fild.frame.origin toView:self.view];
        //%f  %f",self.message.frame.origin.y,rootViewPoint.y);
        
        CGFloat height =rootViewPoint.y - (kApplicationHeight -216);
        
        CGFloat moveheigh = _bigScrollview.contentOffset.y;
        if (height>0)
        {
            
            [UIView animateWithDuration:0.3 animations:^{
                
                _bigScrollview.contentOffset = CGPointMake(0, height+moveheigh+80);
            }];
            
            
        }
        
        [self createPickView];

    }
    
}

#pragma mark 定位
- (void)Location
{
    if(_lightswitch.on)
    {
        _addressbtn.enabled = NO;
        MyLog(@"YES");
        dinnumble = 0;
        
        TFUserLocation *tfp = [TFUserLocation shareLocation];

        tfp.userLocationDelegate = self;
        
        [tfp startLocation];
        
        [MBProgressHUD showMessage:@"正在定位中" afterDeleay:0 WithView:self.view];
        
//        [self dinwei];
    }{
        MyLog(@"NO");
        
        _addressbtn.enabled = YES;
        
        _areafild.text = nil;
        _intact_addr = @"";
    }
}

- (UIView*)createPickView
{
    [self.view endEditing:YES];
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.bgView.backgroundColor = RGBACOLOR_F(0.5,0.5,0.5,0.6);
    [window addSubview:self.bgView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bgView.frame.size.height-216, kScreenWidth, 216)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.bgView addSubview:bottomView];
    
    //创建PickView
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 216)];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
    self.pickerView = pickerView;
    [bottomView addSubview:self.pickerView];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(barButton:)];
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolBar.items = @[spaceItem,spaceItem,spaceItem,spaceItem,spaceItem,spaceItem,spaceItem,spaceItem,item,spaceItem];
    [bottomView addSubview:toolBar];
    
    return bottomView;
}

#pragma mark 姓别选择框
-(void)createPopView
{
    [self.view endEditing:YES];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    view.backgroundColor = [[UIColor colorWithRed:60/255.0 green:61/255.0 blue:62/255.0 alpha:0.8] colorWithAlphaComponent:0.7];
    //    view.alpha = 0.9;
    view.tag = 8888;
    
    
    UIView * smileView=[[UIView alloc]initWithFrame:CGRectMake(20, (kApplicationHeight-ZOOM(300))/2, kApplicationWidth-40, ZOOM(300))];
    smileView.backgroundColor=[UIColor whiteColor];
    
    
    CGFloat width = smileView.frame.size.width/2;
    CGFloat heigh = smileView.frame.size.height;
    
    NSArray *imageArray = @[@"employee",@"woman-avatar"];
    NSArray *sexArray = @[@"男",@"女"];
    
    for(int i=0;i<2;i++)
    {
        UIView *backview =[[UIView alloc]initWithFrame:CGRectMake(width*i, 0, width, smileView.frame.size.height)];
        backview.tag = 7000+i;
        

        [smileView addSubview:backview];
        
        UIImageView *image =[[UIImageView alloc]initWithFrame:CGRectMake(30, (heigh-IMAGEH(@"employee"))/2, IMAGEW(@"employee"), IMAGEH(@"employee"))];
        
        image.image =[UIImage imageNamed:imageArray[i]];

        [backview addSubview:image];
        
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

//完成按钮
- (void)barButton:(UIBarButtonItem *)sender
{
    self.state = nil;
    self.city = nil;
    self.area = nil;
    self.street = nil;
    
    NSInteger com0Row = [self.pickerView selectedRowInComponent:0]; //获取0列点行
    NSInteger com1Row = [self.pickerView selectedRowInComponent:1];
    NSInteger com2Row = [self.pickerView selectedRowInComponent:2];
    NSInteger com3Row = [self.pickerView selectedRowInComponent:3];
    
    StateModel *model;
    CityModel *model1;
    AreaModel *model2;
    StreetModel *model3;
    
    if (self.dataArr.count>com0Row) {
        model = self.dataArr[com0Row];
        self.state = model.state;
        self.stateID = model.ID;
    }
    if (model.CITIES.count>com1Row) {
        model1 = model.CITIES[com1Row];
        self.city = model1.city;
        self.cityID = model1.ID;
    }
    if (model1.AREAS.count>com2Row) {
        model2 = model1.AREAS[com2Row];
        self.area = model2.area;
        self.areaID = model2.ID;
    }
    if (model2.STREETS.count>com3Row) {
        model3 = model2.STREETS[com3Row];
        self.street = model3.street;
        self.streetID = model3.ID;
    }
    
    //判断
    if (self.areaID == nil) {
        self.areaID = @0;
    }
    if (self.streetID == nil) {
        self.streetID = @0;
    }
    
    if (self.area!=nil&&self.street!=nil) {
        self.addressStr = [NSString stringWithFormat:@"%@-%@-%@-%@",self.state,self.city,self.area,self.street];
    } else if (self.street == nil&&self.area!=nil) {
        self.addressStr = [NSString stringWithFormat:@"%@-%@-%@",self.state,self.city,self.area];
    } else if (self.area == nil) {
        self.addressStr = [NSString stringWithFormat:@"%@-%@",self.state,self.city];
    }
    
    _areafild.text = self.addressStr;
    [self.bgView removeFromSuperview];
}



#pragma mark - PickView相关
//返回多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}

//返回某一列多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {           //第0列
        return [self.dataArr count];
    } else if (component == 1) {    //第1列
        NSInteger zeroRow = [self.pickerView selectedRowInComponent:0];         //第0列选择的行
        if (self.dataArr.count>zeroRow) {
            StateModel *model = self.dataArr[zeroRow];
            return [model.cities count];
        }
    } else if (component == 2) {
        NSInteger zeroRow = [self.pickerView selectedRowInComponent:0];         //第0列选中的行
        NSInteger firstRow = [self.pickerView selectedRowInComponent:1];        //第1列选中的行
        if (self.dataArr.count>zeroRow) {
            StateModel *model = self.dataArr[zeroRow];
            if (model.CITIES.count>firstRow) {
                CityModel *sModel = model.CITIES[firstRow];
                return [sModel.areas count];
            }
        }
    } else if (component == 3) {
        NSInteger zeroRow = [self.pickerView selectedRowInComponent:0];         //第0列选中的行
        NSInteger firstRow = [self.pickerView selectedRowInComponent:1];        //第1列选中的行
        NSInteger twoRow = [self.pickerView selectedRowInComponent:2];          //第2列选中的行
        if (self.dataArr.count>zeroRow) {
            StateModel *sModel = self.dataArr[zeroRow];
            if (sModel.CITIES.count>firstRow) {
                CityModel *cModel = sModel.CITIES[firstRow];
                if (cModel.AREAS.count>twoRow) {
                    AreaModel *aModel = cModel.AREAS[twoRow];
                    return [aModel.streets count];
                }
            }
        }
    } else {
        return 0;
    }
    return 0;
}
//某一行显示的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        StateModel *model = self.dataArr[row];
        return model.state;
    } else if (component == 1) {
        //第0列选择的行
        NSInteger zeroRow = [self.pickerView selectedRowInComponent:0];
        if (self.dataArr.count>zeroRow) {
            StateModel *model = self.dataArr[zeroRow];
            if (model.CITIES.count>row) {
                CityModel *sModel = model.CITIES[row];
                return sModel.city;
            }
        }
    } else if (component == 2) {
        NSInteger zeroRow = [self.pickerView selectedRowInComponent:0];
        NSInteger firstRow = [self.pickerView selectedRowInComponent:1];
        
        if (self.dataArr.count>zeroRow) {
            StateModel *model = self.dataArr[zeroRow];
            if (model.CITIES.count>firstRow) {
                CityModel *sModel = model.CITIES[firstRow];
                if (sModel.AREAS.count>row) {
                    AreaModel *ssModel = sModel.AREAS[row];
                    return ssModel.area;
                }
            }
        }
    } else if (component == 3) {
        NSInteger zeroRow = [self.pickerView selectedRowInComponent:0];         //第0列选中的行
        NSInteger firstRow = [self.pickerView selectedRowInComponent:1];        //第1列选中的行
        NSInteger twoRow = [self.pickerView selectedRowInComponent:2];          //第2列选中的行
        
        if (self.dataArr.count>zeroRow) {
            StateModel *model = self.dataArr[zeroRow];
            if (model.CITIES.count>firstRow) {
                CityModel *sModel = model.CITIES[firstRow];
                if (sModel.AREAS.count>twoRow) {
                    AreaModel *ssModel = sModel.AREAS[twoRow];
                    if (ssModel.STREETS.count>row) {
                        StreetModel *stModel = ssModel.STREETS[row];
                        return stModel.street;
                    }
                }
            }
        }
        
    }
    return nil;
}

//调整字体
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:16]];
    }
    // Fill the label text here
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

//滑动事件
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) { //第0列
        [self.pickerView selectRow:0 inComponent:1 animated:NO];
        [self.pickerView selectRow:0 inComponent:2 animated:NO];
        [self.pickerView selectRow:0 inComponent:3 animated:NO];
        [self.pickerView reloadComponent:1];
        [self.pickerView reloadComponent:2];
        [self.pickerView reloadComponent:3];
    } else if (component == 1) {
        [self.pickerView selectRow:0 inComponent:2 animated:NO];
        [self.pickerView selectRow:0 inComponent:3 animated:NO];
        [self.pickerView reloadComponent:2];
        [self.pickerView reloadComponent:3];
    } else if (component == 2) {
        [self.pickerView selectRow:0 inComponent:3 animated:NO];
        [self.pickerView reloadComponent:3];
    }
}



#pragma mark - 懒加载数据
- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"areatbl" ofType:@"plist"]];
        for (NSDictionary *dic in array) { //存储模型
            StateModel *model = [[StateModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            model.ID = dic[@"id"];
            [_dataArr addObject:model];
        }
    }
    return _dataArr;
}


#pragma mark - 键盘出现和消失
////键盘出现
//- (void)keyboardWillShow:(NSNotification *)noti
//{
//    //键盘高度
//    //    CGFloat keyboardHeight = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
//    
//}
//
////键盘消失,其他坐标归位
//- (void)keyboardWillHide:(NSNotification *)noti
//{
//    [UIView animateWithDuration:0.8 animations:^{
//        self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
//    }];
//}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.8 animations:^{
        self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }];
}

#pragma mark 检测商家是否添加信息
-(void)textHttprequest
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *token =[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    url=[NSString stringWithFormat:@"%@merchantAlliance/checkIsBus?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [[Animation shareAnimation] createAnimationAt:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *messsage=responseObject[@"message"];
            
            NavgationbarView *mentionview =[[NavgationbarView alloc]init];
            
            NSDictionary *dic;
            if(responseObject[@"business"] !=NULL)
            {
                dic = responseObject[@"business"];
            }
            
            if(statu.intValue==1060)//没有添加商家信息
            {
                //            DistributionRegistViewController *distribution = [[DistributionRegistViewController alloc]init];
                //
                //            distribution.hidesBottomBarWhenPushed = YES;
                //            [self.navigationController pushViewController:distribution animated:YES];
                
            }else if (statu.intValue==1061)//商家信息正在审核中
            {
                
                
            }else if (statu.intValue==1062)//商家信息审核未通过
            {
                
            }else if (statu.intValue==1)//商家信息审核通过
            {
                
            }
            else{
                
                [mentionview showLable:messsage Controller:self];
            }

        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
    
}


#pragma mark 提交商家注册信息——网络请求
- (void)requestHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString*token=[user objectForKey:USER_TOKEN];
    
    NSArray *busArray = @[@"bus_name",
                          @"bus_type",
                          @"bus_type_two",
                          @"def_pic",
                          @"phone",
                          @"salesman_name",
                          @"real_name",
                          @"sex",
                          @"idcard",
                          @"age",
                          @"content",
                          @"svg_price",
                          @"province",
                          @"city",
                          @"area",
                          @"street",
                          @"addr",
                          @"lng",
                          @"lat",
                          @"bus_pic",
                          @"vip_dis",
                          @"dis_note",
                          @"intact_addr"
                          ];
    
    NSString *str ;
    if([businessSex isEqualToString:@"男"])
    {
        str = @"0";
    }else{
        str = @"1";
    }
    
    if(_lightswitch.on)
    {
        self.stateID = @0;
        self.cityID = @0;
        self.areaID = @0;
        self.streetID = @0;
    }
    
    NSArray *contentArray =@[[NSString stringWithFormat:@"%@",_organizationfild.text],
                             [NSString stringWithFormat:@"%d",bus_type.intValue],
                             [NSString stringWithFormat:@"%d",bus_typeTwo.intValue],
                             [NSString stringWithFormat:@"%@",bigImages],
                             [NSString stringWithFormat:@"%@",businessPhone],
                             [NSString stringWithFormat:@"%@",_namefild.text],
                             [NSString stringWithFormat:@"%@",businessName],
                             [NSString stringWithFormat:@"%@",str],
                             [NSString stringWithFormat:@"%@",businessID],
                             [NSString stringWithFormat:@"%@",businessAge],
                             [NSString stringWithFormat:@"%@",_ExclusiveTextview.text],
                             [NSString stringWithFormat:@"%.2f",[_Consumptionfild.text floatValue]],
                             [NSString stringWithFormat:@"%@",self.stateID],
                             [NSString stringWithFormat:@"%@",self.cityID],
                             [NSString stringWithFormat:@"%@",self.areaID],
                             [NSString stringWithFormat:@"%@",self.streetID],
                             [NSString stringWithFormat:@"%@",_addressfild.text],
                             [NSString stringWithFormat:@"%f",lat2],
                             [NSString stringWithFormat:@"%f",lng2],
                             [NSString stringWithFormat:@"%@",smallImages],
                             [NSString stringWithFormat:@"%@",memberdiscount],
                             [NSString stringWithFormat:@"%@",discountDiscription],
                             [NSString stringWithFormat:@"%@",_intact_addr],
                             ];
    
    NSMutableString *businessString =[[NSMutableString alloc]init];
    for(int i =0;i<busArray.count;i++)
    {
        NSString *str = [NSString stringWithFormat:@"%@=%@",busArray[i],contentArray[i]];
        
        [businessString appendString:str];
        [businessString appendString:@"&"];
        
    }
    
    NSString *cccc = [businessString substringToIndex:[businessString length] - 1];
    businessString = [NSMutableString stringWithString:cccc];
    
    NSString *url;
    
    if([self.statu isEqualToString:@"商家信息审核未通过"] || [self.statu isEqualToString:@"商家信息审核通过"])//修改
    {
        url=[NSString stringWithFormat:@"%@merchantAlliance/updateBusiness?version=%@&token=%@&%@&bus_code=%@",[NSObject baseURLStr],VERSION,token,businessString,self.businessDictionary[@"bus_code"]];
    }else{
        url=[NSString stringWithFormat:@"%@merchantAlliance/addBusiness?version=%@&token=%@&%@",[NSObject baseURLStr],VERSION,token,businessString];
    }
    
    NSString *URL=[MyMD5 authkey:url];
    
//    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    [[Animation shareAnimation] createAnimationAt:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *message=responseObject[@"message"];
            NSString *str=responseObject[@"status"];
            
            
            if(str.intValue==1)//注册成功
            {
                
                message = @"注册成功,请等待审核！";
                
                [self performSelector:@selector(popToView) withObject:nil afterDelay:3.0];
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
                
                [MBProgressHUD hideHUDForView:self.view];
                
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
        }
        
        

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];

    }];

}

#pragma mark 注册成功返回上一界面
-(void)popToView
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    _actionsheettype = [NSString stringWithFormat:@"%d",(int)actionSheet.tag];
    
    if(actionSheet.tag == 8888)//大图
    {
        if(buttonIndex==0)
        {
            [self performSelector:@selector(choosePhotoCamera) withObject:nil afterDelay:0.5];
            
            
        }else if (buttonIndex==1)
        {
            DoImagePickerController *doimg=[[DoImagePickerController alloc]init];
            doimg.delegate=self;
            doimg.nColumnCount = 4;
            doimg.nResultType = DO_PICKER_RESULT_UIIMAGE;
            doimg.nMaxCount = 1;
            [self.navigationController pushViewController:doimg animated:YES];
        }

    
    }else{//小图
        
        if(buttonIndex==0)
        {
            [self performSelector:@selector(choosePhotoCamera) withObject:nil afterDelay:0.5];
            
            
        }else if (buttonIndex==1)
        {
            DoImagePickerController *doimg=[[DoImagePickerController alloc]init];
            doimg.delegate=self;
            doimg.nColumnCount = 4;
            doimg.nResultType = DO_PICKER_RESULT_UIIMAGE;
            doimg.nMaxCount = 15 - _smallImageArray.count;
            [self.navigationController pushViewController:doimg animated:YES];
        }

    }
    
}
-(void)choosePhotoCamera
{
    if(_actionsheettype.intValue == 8888)
    {
        CameraVC *camera=[[CameraVC alloc]init];
        camera.delegate=self;
        camera.MaxImageNum = 1-_imageArray.count;
        [self.navigationController pushViewController:camera animated:YES];
        
    }else{
        
        CameraVC *camera=[[CameraVC alloc]init];
        camera.delegate=self;
        camera.MaxImageNum = 15-_smallImageArray.count;
        [self.navigationController pushViewController:camera animated:YES];

    }
    
}

#pragma mark cameradelegate
-(void)SelectPhotoEnd:(CameraVC *)Manager WithPhotoArray:(NSArray *)PhotoArray
{
    if(_actionsheettype.intValue == 8888)//添加机构大图
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSData *saveMenulistDaate = [defaults objectForKey:@"aSelected"];
        
        if (nil == saveMenulistDaate) {
            NSMutableArray *menulistarry = [[NSMutableArray alloc]init];
            
            _imageArray = menulistarry;
        }
        else
        {
            _imageArray = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:saveMenulistDaate];
        }
        
        
        if(PhotoArray.count)
        {
            UIImage *bigimage =PhotoArray[0];
            
            CGFloat imagewidth= (_bigImageview.frame.size.height*bigimage.size.width)/bigimage.size.height;
            
            _bigImageview.frame = CGRectMake((kApplicationWidth-imagewidth)/2, _bigImageview.frame.origin.y, imagewidth, _bigImageview.frame.size.height);
            
            _bigImageview.image = bigimage;
            
            [_bigImageArray addObject:bigimage];
            
            NSData *encodemenulist = [NSKeyedArchiver archivedDataWithRootObject:_imageArray];
            NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
            
            [defaults1 setObject:encodemenulist forKey:@"aSelected"];
            
        }
 
    
    }
    else{//机构小图
        
        CGFloat widh =(kApplicationWidth-50)/4;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSData *saveMenulistDaate = [defaults objectForKey:@"aSelected"];
        
        if (nil == saveMenulistDaate) {
            NSMutableArray *menulistarry = [[NSMutableArray alloc]init];
            
            _smallImageArray = menulistarry;
        }
        else
        {
            _smallImageArray = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:saveMenulistDaate];
        }
        
        UIImage *imagge=[UIImage imageNamed:@"加_默认"];
        for(int i=0 ;i<PhotoArray.count;i++)
        {
            [_smallImageArray addObject:PhotoArray[i]];
            
        }
        [_smallImageArray addObject:imagge];
        
        //ok");
        
        NSInteger count=0;
        
        
        if(_smallImageArray.count%4==0)
        {
            count=_smallImageArray.count/4;
        }else{
            count=_smallImageArray.count/4+1;
        }
        
        int k=0;
        for(int i=0;i<count;i++)
        {
            
            for(int j=0;j<4;j++)
            {
                
                UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(10+(widh+10)*j, 10+(widh+10)*i, widh, widh)];
                
                if(k<_smallImageArray.count)
                {
                    imageview.image=_smallImageArray[k];
                    imageview.clipsToBounds = YES;
                    imageview.contentMode = UIViewContentModeScaleAspectFill;
                    
                    imageview.tag=2000+k;
                    
                    k++;
                    
                    [_organizationImageView2 addSubview:imageview];
                    
                    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageclick:)];
                    [imageview addGestureRecognizer:tap];
                    imageview.userInteractionEnabled=YES;
                    
                }else{
                    
                }
                
            }
        }
        
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:1.0];
        
        _organizationImageView2.frame=CGRectMake(_organizationImageView2.frame.origin.x, _organizationImageView2.frame.origin.y, kApplicationWidth, (widh+10)*count+10);
        CGFloat ConsumptionViewY =CGRectGetMaxY(_organizationImageView2.frame);
        
        _ConsumptionView.frame = CGRectMake(0, ConsumptionViewY+ZOOM(180), _ConsumptionView.frame.size.width, _ConsumptionView.frame.size.height);
        
        CGFloat submitbtnY =CGRectGetMaxY(_ConsumptionView.frame);
        
        _submitbtn.frame =CGRectMake(ZOOM(77), submitbtnY+ZOOM(129), kApplicationWidth - 2*ZOOM(77), ZOOM(50*3.4));
        
        _bigScrollview.contentSize = CGSizeMake(0, _submitbtn.frame.origin.y+_submitbtn.frame.size.height+ZOOM(50));
        
        
        if(_smallImageArray.count)
        {
            _smallImageview.hidden = YES;
            
            [_smallImageArray removeObjectAtIndex:_smallImageArray.count-1];
            NSData *encodemenulist = [NSKeyedArchiver archivedDataWithRootObject:_smallImageArray];
            NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
            
            [defaults1 setObject:encodemenulist forKey:@"aSelected"];
            
        }

        
    }
    
    
}


#pragma mark DoImagePickerControllerDelegate
-(void)didCancelDoImagePickerController
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)didSelectPhotosFromDoImagePickerController:(DoImagePickerController *)picker result:(NSArray *)aSelected
{
    if(_actionsheettype.intValue == 8888)//添加机构大图
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSData *saveMenulistDaate = [defaults objectForKey:@"aSelected"];
        
        
        if (nil == saveMenulistDaate) {
            
            NSMutableArray *menulistarry = [[NSMutableArray alloc]init];
            
            _imageArray = menulistarry;
            
        }
        else
        {
            _imageArray = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:saveMenulistDaate];
        }
        
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:1.0];
        
        if(aSelected.count)
        {
            
            UIImage *bigimage =aSelected[0];
            
            CGFloat imagewidth= (_bigImageview.frame.size.height*bigimage.size.width)/bigimage.size.height;
            
            _bigImageview.frame = CGRectMake((kApplicationWidth-imagewidth)/2, _bigImageview.frame.origin.y, imagewidth, _bigImageview.frame.size.height);
            
            _bigImageview.image = bigimage;
            
            [_bigImageArray addObject:bigimage];
            
            NSData *encodemenulist = [NSKeyedArchiver archivedDataWithRootObject:_imageArray];
            NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
            
            [defaults1 setObject:encodemenulist forKey:@"aSelected"];
            
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        CGFloat widh =(kApplicationWidth-50)/4;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSData *saveMenulistDaate = [defaults objectForKey:@"aSelected"];
        
        if (nil == saveMenulistDaate) {
            NSMutableArray *menulistarry = [[NSMutableArray alloc]init];
            
            _smallImageArray = menulistarry;
        }
        else
        {
            _smallImageArray = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:saveMenulistDaate];
        }
        
        UIImage *imagge=[UIImage imageNamed:@"加_默认"];
        for(int i=0 ;i<aSelected.count;i++)
        {
            [_smallImageArray addObject:aSelected[i]];
            
        }
        [_smallImageArray addObject:imagge];
        
        //ok");
        
        NSInteger count=0;
        
        
        if(_smallImageArray.count%4==0)
        {
            count=_smallImageArray.count/4;
        }else{
            count=_smallImageArray.count/4+1;
        }
        
        int k=0;
        for(int i=0;i<count;i++)
        {
            
            for(int j=0;j<4;j++)
            {
                
                UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(10+(widh+10)*j, 10+(widh+10)*i, widh, widh)];
                
                if(k<_smallImageArray.count)
                {
                    imageview.image=_smallImageArray[k];
                    imageview.clipsToBounds = YES;
                    imageview.contentMode = UIViewContentModeScaleAspectFill;
                    
                    imageview.tag=2000+k;
                    
                    k++;
                    
                    [_organizationImageView2 addSubview:imageview];
                    
                    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageclick:)];
                    [imageview addGestureRecognizer:tap];
                    imageview.userInteractionEnabled=YES;
                    
                }else{
                    
                }
                
            }
        }
        
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:1.0];
        
        _organizationImageView2.frame=CGRectMake(_organizationImageView2.frame.origin.x, _organizationImageView2.frame.origin.y, kApplicationWidth, (widh+10)*count+10);
        CGFloat ConsumptionViewY =CGRectGetMaxY(_organizationImageView2.frame);
        
        _ConsumptionView.frame = CGRectMake(0, ConsumptionViewY+ZOOM(180), _ConsumptionView.frame.size.width, _ConsumptionView.frame.size.height);
        
        CGFloat submitbtnY =CGRectGetMaxY(_ConsumptionView.frame);
        
        _submitbtn.frame =CGRectMake(ZOOM(77), submitbtnY+ZOOM(129), kApplicationWidth - 2*ZOOM(77), ZOOM(50*3.4));
        
        _bigScrollview.contentSize = CGSizeMake(0, _submitbtn.frame.origin.y+_submitbtn.frame.size.height+ZOOM(50));
        
        
        if(_smallImageArray.count)
        {
            _smallImageview.hidden = YES;
            
            [_smallImageArray removeObjectAtIndex:_smallImageArray.count-1];
            NSData *encodemenulist = [NSKeyedArchiver archivedDataWithRootObject:_smallImageArray];
            NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
            
            [defaults1 setObject:encodemenulist forKey:@"aSelected"];
            
        }
        
        [self.navigationController popViewControllerAnimated:YES];

    }
    
    
}

-(void)imageclick:(UITapGestureRecognizer*)tap
{
    
    if (_smallImageArray.count<15) {
        
        UIImageView *imageview=(UIImageView*)[self.view viewWithTag:tap.view.tag];
        
        if(imageview.tag== 2000+_smallImageArray.count)
        {
            UIActionSheet *actionsheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册获取", nil];
            [actionsheet showInView:self.view];
            
            
        } else{
            
//            NSInteger image_page=imageview.tag%2000+1;
//            
//            UIView *Screenwindow = [[UIApplication sharedApplication].delegate window];
//            
//            _fullScreenScrollView = [[FullScreenScrollView alloc]initWithPicutreArray:_imageArray withCurrentPage:image_page];
//            
//            _fullScreenScrollView.backgroundColor = [UIColor blackColor];
//            
//            [Screenwindow addSubview:_fullScreenScrollView];
            
        }
    } else {
        [MBProgressHUD showError:@"最多可选择15图片"];
    }
    
    
}

//键盘
- (void)keyboardTool:(KeyboardTool *)keyboardTool itemClick:(KeyboardToolItemType)itemType
{
    if (itemType == KeyboardToolItemTypePrevious) { // 上一个
        //----上一个----");
    } else if (itemType == KeyboardToolItemTypeNext) { // 下一个
        //----下一个----");
    } else { // 完成
        //----完成----");
        if(_ExclusiveTextview.text.length == 0)
        {
            _ExclusiveTextview.text =@"会员独享服务(限制30字内)";
        }
        
        [self.view endEditing:YES];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    [self.view endEditing:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    [self.view endEditing:YES];
}

#pragma mark 类目列表
-(void)moreCategory:(UITapGestureRecognizer*)tap
{
//    MyLog(@"more");
    
    TFBusinessCategoryViewController *tb = [[TFBusinessCategoryViewController alloc] init];
    tb.delegate = self;
    [self.navigationController pushViewController:tb animated:YES];
    
}

#pragma mark 获取类目参数
- (void)selectBtnEnd:(NSArray *)chooseArray
{
    MyLog(@"is %@",chooseArray);
    
    if(chooseArray.count)
    {
        NSDictionary *dic =chooseArray[0];
        
        bus_type = [NSString stringWithFormat:@"%@",dic[@"bus_type"]];
        bus_typeTwo = [NSString stringWithFormat:@"%@",dic[@"bus_type_two"]];
        _categoryLable.text = [NSString stringWithFormat:@"%@",dic[@"title"]];
    }
    
}

#pragma mark 添加机构大图
-(void)addBigImage:(UITapGestureRecognizer*)tap
{
    MyLog(@"addbig");
    
    UIActionSheet *actionsheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册获取", nil];
    actionsheet.tag =8888;
    [actionsheet showInView:self.view];
}

#pragma mark 添加机构小图
-(void)addSmallimagetap:(UITapGestureRecognizer*)tap
{
    MyLog(@"addsmall");
    UIActionSheet *actionsheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册获取", nil];
    actionsheet.tag =9999;
    [actionsheet showInView:self.view];
    
}

-(void)discountClick:(UIButton*)sender
{
    MyLog(@"discount");
    
    DiscountViewController *discount = [[DiscountViewController alloc]init];
    discount.discount = _Discountfild.text;
    discount.discountCription = discountDiscription;
    [self.navigationController pushViewController:discount animated:YES];
}

#pragma mark 提交审核
- (void)submit:(UIButton*)sender
{
    MyLog(@"submit");
    NSString *message;
    
     NavgationbarView *mentionview =[[NavgationbarView alloc]init];
    
    if(_namefild.text.length == 0)
    {
        message = @"业务员名称不能为空";
        
        [mentionview showLable:message Controller:self];
        
        return;
        
    }else if (_organizationfild.text.length == 0)
    {
        message = @"机构名称不能为空";
        [mentionview showLable:message Controller:self];
        return;
    }else if (_categoryLable.text.length == 0)
    {
        message = @"请选择类目";
        [mentionview showLable:message Controller:self];
        return;

    }
    else if (_areafild.text.length == 0)
    {
        message = @"地区不能为空";
        [mentionview showLable:message Controller:self];
        return;
    }else if (_addressfild.text.length == 0)
    {
        message = @"详细地址不能为空";
        [mentionview showLable:message Controller:self];
        return;
    }else if (_Consumptionfild.text.length == 0)
    {
        message = @"人均消费不能为空";
        [mentionview showLable:message Controller:self];
        return;
    }
    else if (_Discountfild.text.length == 0)
    {
        message = @"会员折扣不能为空";
        [mentionview showLable:message Controller:self];
        return;
    }
    else if (_ExclusiveTextview.text.length == 0)
    {
        message = @"会员独享服务不能为空";
        [mentionview showLable:message Controller:self];
        return;
    }else if (! _bigImageArray.count)
    {
        message = @"机构大图不能为空";
        [mentionview showLable:message Controller:self];
        return;
    }else if (! _smallImageArray.count)
    {
        message = @"机构小图不能为空";
        [mentionview showLable:message Controller:self];
        return;
    }
    else{
        
        for(int i =0;i<6;i++)
        {
            
            
            UITextField *fild =(UITextField*)[self.view viewWithTag:8000+i];
            

            switch (i) {
                case 1:
                    if(fild.text.length == 0)
                    {
                        message = @"姓名不能为空";
                        [mentionview showLable:message Controller:self];
                        return;
                    }else{
                        if(fild.text.length < 2 || fild.text.length > 6)
                        {
                            message = @"姓名需在2到6个汉字内";
                            [mentionview showLable:message Controller:self];
                            return;
                            
                        }else{
                            
                            businessName = fild.text;
                        }
                        
                    }
                    break;
                case 2:
                    if(fild.text.length == 0)
                    {
                        message = @"性别不能为空";
                        [mentionview showLable:message Controller:self];
                        return;
                    }else{
                        businessSex = fild.text;
                    }
                    break;
                case 3:
                    if(fild.text.length == 0)
                    {
                        message = @"电话不能为空";
                        [mentionview showLable:message Controller:self];
                        return;
                        
                    }else{//验证手机号码
                        
                        BOOL result = [self isValidateMobile:fild.text];
                        if(result)
                        {
                            businessPhone = fild.text;
                        }else{
                            message = @"请填写正确的手机号码";
                            [mentionview showLable:message Controller:self];
                            return;
                        }
                    }
                    break;
                case 4:
                    if(fild.text.length == 0)
                    {
                        message = @"年龄不能为空";
                        [mentionview showLable:message Controller:self];
                        return;
                    }else{//验证是年龄
                        
                        BOOL result = [self isPureNumandCharacters:fild.text];
                        if(result == NO)
                        {
                            message = @"请输入合法的年龄";
                            [mentionview showLable:message Controller:self];
                            return;

                        }else{
                            
                            businessAge = fild.text;
                        }
                    }
                    break;
                case 5:
                    if(fild.text.length == 0)
                    {
                        message = @"身份证号不能为空";
                        [mentionview showLable:message Controller:self];
                        return;
                    }else{//验证是身份证号
                        
                        BOOL result = [self validateIdentityCard:fild.text];
                        if(result == NO)
                        {
                            message = @"请输入合法的身份证号";
                            [mentionview showLable:message Controller:self];
                            return;
                        }else{
                            businessID = fild.text;
                        }
                        
                        
                    }
                    break;
   
                    
                default:
                    break;
            }
        }
        
        //判断长度
        if(_namefild.text.length <2 || _namefild.text.length >6)
        {
            message = @"业务员名称需在2到6个汉字内";
            
            [mentionview showLable:message Controller:self];
            
            return;
            
        }else if (_organizationfild.text.length > 50)
        {
            message = @"机构名称过长";
            [mentionview showLable:message Controller:self];
            return;
        }
        else if (_Consumptionfild.text.length > 5)
        {
            message = @"人均消费金额过高";
            [mentionview showLable:message Controller:self];
            return;
        }
            else if (_ExclusiveTextview.text.length > 30)
        {
            message = @"会员独享服务长度过长";
            [mentionview showLable:message Controller:self];
            return;
        }
        
    }
    
//    [self requestHttp];
    
    if(_bigImageArray.count)
    {
        [self.upyImageArray removeAllObjects];
        
        [self.upyImageArray addObject:_bigImageArray[0]];
        
        if(_smallImageArray.count >2)
        {
            for(int i =0 ;i<3;i++)
            {
                [self.upyImageArray addObject:_smallImageArray[i]];
            }
            
            [self creatUPY];
            
        }else{
            [_mentionview showLable:@"请至少上传3张图片" Controller:self];
        }
    }else{
        [_mentionview showLable:@"请上传机构大图" Controller:self];
    }

}
-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ***************上传图像到UPY*******************

-(void)creatUPY
{
    bigImages = [[NSMutableString alloc]init];
    smallImages = [[NSMutableString alloc]init];
    
    [bigImages setString:@""];
    [smallImages setString:@""];
    
    __block int count=(int)self.upyImageArray.count;

    
    UpYun *uy = [[UpYun alloc] init];
    [MBProgressHUD showMessage:@"正在上传图片" afterDeleay:0 WithView:self.view];
//    uy.successBlocker = ^(id data)
//    {
//        
//        NSString *imgurl=[NSString stringWithFormat:@"%@",data[@"url"]];
//        //imgurl--%@",imgurl);
//        
//        UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],imgurl]]]];
//        
//        CGFloat scale = 1.0 ;
//        if(image)
//        {
//            scale = image.size.width/image.size.height;
//        }
//        
//        if(imgurl)
//        {
//            NSString *string1 = @"default";
//            NSString *string2 = [NSString stringWithString:imgurl];
//
//            NSRange range = [string2 rangeOfString:string1];
//            
//            
//            
//            if(range.length >0)
//            {
//                [bigImages appendString:imgurl];
//                [bigImages appendString:@":"];
//                [bigImages appendString:[NSString stringWithFormat:@"%.2f",scale]];
//
//                
//            }else{
//                
//                [smallImages appendString:imgurl];
//                [smallImages appendString:@":"];
//                [smallImages appendString:[NSString stringWithFormat:@"%.2f",scale]];
//                [smallImages appendString:@","];
//
//            }
//            
//            count=count-1;
//            if(count==0)
//            {
//                [MBProgressHUD hideHUDForView:self.view];
//                
//                [self requestHttp];
//                
//            }
//            
//        }
//        
//    };
    
    
    uy.successBlocker = ^(id data)
    {
        NSString *imgurl=[NSString stringWithFormat:@"%@",data[@"url"]];
        //imgurl--%@",imgurl);
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],imgurl]]]];
            
            CGFloat scale = 1.0 ;
            if(image)
            {
                scale = image.size.width/image.size.height;
            }
            
            if(imgurl)
            {
                NSString *string1 = @"default";
                NSString *string2 = [NSString stringWithString:imgurl];
                
                NSRange range = [string2 rangeOfString:string1];
                
                
                
                if(range.length >0)
                {
                    [bigImages appendString:imgurl];
                    [bigImages appendString:@":"];
                    [bigImages appendString:[NSString stringWithFormat:@"%.2f",scale]];
                    
                    
                }else{
                    
                    [smallImages appendString:imgurl];
                    [smallImages appendString:@":"];
                    [smallImages appendString:[NSString stringWithFormat:@"%.2f",scale]];
                    [smallImages appendString:@","];
                    
                }
                
                count=count-1;
                if(count==0)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{ // 主线程刷新UI
                        
                        [MBProgressHUD hideHUDForView:self.view];
                        
                        [self requestHttp];
                    });

                    
                }
                
            }
            
            
        });
        
    };

    
    
    uy.failBlocker = ^(NSError * error)
    {
        [MBProgressHUD hideHUDForView:self.view];
        NSString *message = [error.userInfo objectForKey:@"message"];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"error" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        //%@",error);
        
        count=count-1;
    };
    
    
    for(int i=0;i<self.upyImageArray.count;i++)
    {
        if(i==0)//第一张传大图
        {
            UIImage * image1 =[self compressionImage:self.upyImageArray[i]];
            
            [uy uploadFile:image1 saveKey:[self getSaveKey:@"default" with:i]];
        
        }else{
            
            UIImage * image1 =[self compressionImage:self.upyImageArray[i]];
            
            [uy uploadFile:image1 saveKey:[self getSaveKey:@"pic" with:i]];
        }
        
        
    }
    
    
}

-(NSString * )getSaveKey:(NSString*)str with:(int)index{
    
//    NSString *UID=[self getNumber];
//    NSDate *d = [NSDate date];
//    float a = ([d timeIntervalSince1970]-(int)[d timeIntervalSince1970]);
//    int inta = a *100000;
    //%d",inta);
    
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *userid =[userdefaul objectForKey:USER_ID];
    
    NSString *ptahstr= [NSString stringWithFormat:@"%@%@/%@/%@%d.jpg",@"business/",[self getDate],str,userid,index];
    
    return ptahstr;
}

#pragma mark 获取毫秒数
- (int)getSecond:(NSDate *) date{
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitMonth;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    int second = (int)[comps second];
    return second;
    
}

#pragma mark 获取当前时间
-(NSString*)getDate
{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYYMMdd"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    //locationString:%@",locationString);
    
    return locationString;
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
            
            strNum=[[strNum stringByAppendingString:character] copy];//是数字的累加起来
        }
        
    }
    return strNum;
}

/**
 *  图片压缩
 *
 *  @param img 传入的图片
 *
 *  @return 返回压缩后的图片
 */
- (UIImage *)compressionImage:(UIImage *)img
{
    CGSize imagesize = img.size;
    imagesize.height = imagesize.height/IMGSIZECOMPCOEFF1;
    imagesize.width = imagesize.width/IMGSIZECOMPCOEFF1;
    UIImage *newImg = [self imageWithImage:img scaledToSize:imagesize];
    NSData *imageData = UIImageJPEGRepresentation(newImg, 0.2);
    return [UIImage imageWithData:imageData];
}

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize

{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}


#pragma mark *******************定位***********************
- (void)getUserLocationSuccess:(TFUserLocation *)tfUserLocation withPotion:(NSDictionary *)info withLatitude:(CGFloat)latitude Longitude:(CGFloat)longitude
{
    
   [MBProgressHUD hideHUDForView:self.view animated:YES];
    
//    NSString *str = info[@"FormattedAddressLines"][0];
    
    
    lat2=longitude;
    lng2=latitude;
    
    NSString* state = info[@"State"];
    NSString* city = info[@"City"];
    NSString* sublocacity = info[@"SubLocality"];
    NSString* street = info[@"Street"];
//    NSString* regionname=info[@"Name"];
    
    
    if(state !=nil && city !=nil && sublocacity !=nil && street !=nil)
    {
        _locationCity=[NSString stringWithFormat:@"%@%@%@%@",state,city,sublocacity,street];
        _intact_addr =[NSString stringWithFormat:@"%@,%@,%@,%@",state,city,sublocacity,street];
        _areafild.text = _locationCity;
        _areafild.font = [UIFont systemFontOfSize:ZOOM(44)];
        
    }else{
        
        NavgationbarView *mentionview =[[NavgationbarView alloc]init];
        [mentionview showLable:@"定位失败，请重试" Controller:self];

    }
    
    
}
- (void)getUserLocationFailed:(TFUserLocation *)tfUserLocation withMessage:(NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    NavgationbarView *mentionview =[[NavgationbarView alloc]init];
    [mentionview showLable:@"定位失败，请重试" Controller:self];
    
}

#if 0
#pragma mark *******************定位***********************弃用
-(void)dinwei
{
    //定位管理器
    _locationManager=[[CLLocationManager alloc]init];
    _locationManager.delegate=self;
    
    if (![CLLocationManager locationServicesEnabled]) {
        //定位服务当前可能尚未打开，请设置打开！");
        return;
    }
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    //如果没有授权则请求用户授权
    if (status==kCLAuthorizationStatusRestricted ||status==kCLAuthorizationStatusDenied){
        [_locationManager requestWhenInUseAuthorization];
//        Alert_Show(@"请打开你的位置服务");
        
        NavgationbarView *mentionview =[[NavgationbarView alloc]init];
        [mentionview showLable:@"" Controller:self];
    }else  { //设置代理
        
        //设置定位精度
        _locationManager.desiredAccuracy=kCLLocationAccuracyThreeKilometers;
        [_locationManager startUpdatingLocation];
        
    }
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location=[locations firstObject];//取出第一个位置
    //location===%@",location);
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    //经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    lat2=coordinate.latitude;
    lng2=coordinate.longitude;
    
    if (lat2>0) {
        dinnumble++;
        if (dinnumble==2) {
            [self getAddressByLatitude:lat2 longitude:lng2];
        }
    }
}

#pragma mark 根据坐标取得地名
-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    //反地理编码
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    
    //    CLLocation *c = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
    //创建位置
    CLGeocoder *revGeo = [[CLGeocoder alloc] init];
    [revGeo reverseGeocodeLocation:location
                 completionHandler:^(NSArray *placemarks, NSError *error) {
                     if (!error && [placemarks count] > 0)
                     {
                         NSDictionary *dict =[[placemarks objectAtIndex:0] addressDictionary];
                        
                         NSString* state = dict[@"State"];
                         NSString* city = dict[@"City"];
                         NSString* sublocacity = dict[@"SubLocality"];
                         NSString* street = dict[@"Street"];
                         NSString* regionname=dict[@"Name"];
                        
                         //                         regionname=[str substringToIndex:str.length-1];
                         _locationCity=[NSString stringWithFormat:@"%@%@%@%@",state,city,sublocacity,street];
                         
                         _areafild.text = _locationCity;
                         _areafild.font = [UIFont systemFontOfSize:ZOOM(44)];
                         
//                         [PublicClss AlertViewToWindowAndHiddenWithMessage:citystr WithAnimation:jianyinAnimatin];
//                           regionid = [[DBManager sharedDBManager] select101AreaWithtitle:regionname];
                         
//                         [self setwenzirequest];
//                         //cityid===%d",(int)regionid);
                         
                         [_locationManager stopUpdatingLocation];
                     }
                     else
                     {
                         //ERROR===: %@", error);
                         [_locationManager stopUpdatingLocation];
                     }
                 }];
    
}

#endif
#pragma mark 键盘处理

- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    _keyboardFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    CGPoint rootViewPoint = [[self.message superview] convertPoint:self.message.frame.origin toView:self.view];
    //%f  %f",self.message.frame.origin.y,rootViewPoint.y);
    
    CGFloat height =rootViewPoint.y -_keyboardFrame.origin.y;
    
    CGFloat moveheigh = _bigScrollview.contentOffset.y;
    if (height>0)
    {
        [UIView animateWithDuration:animationDuration
                         animations:^{
                             
                             
//                             _bigScrollview.frame=CGRectMake(0,_bigScrollview.frame.origin.y-height-40, kApplicationWidth, _bigScrollview.frame.size.height);
                             
                             _bigScrollview.contentOffset = CGPointMake(0, height+moveheigh+80);

                             
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
                         
                         _bigScrollview.frame = CGRectMake(0, Height_NavBar, kScreenWidth, kApplicationHeight-Height_NavBar+kUnderStatusBarStartY);
                     }];
}

#pragma mark - textField

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag < 203) {
        //注销当前文本为第一响应者 (此时无文本编辑，键盘会自动收起)
        //        [textField resignFirstResponder];
        //成为第一响应者，（让键盘出来）
        //        [textField becomeFirstResponder];
        UITextField *tf = (UITextField *)[self.view viewWithTag:textField.tag+1];

        //再让其成为第一响应者 , (此时自动弹出键盘)
        [tf becomeFirstResponder];
    } else if (textField.tag == 203){
        [self.view endEditing:YES];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ((textField.tag == 200)||(textField.tag == 201)) {
        [UIView animateWithDuration:0.8 animations:^{
            self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        }];
    } else if (textField.tag == 202) {
        if (kDevice_Is_iPhone4) {
            [UIView animateWithDuration:0.8 animations:^{
                self.view.frame = CGRectMake(0, -40, kScreenWidth, kScreenHeight);
            }];
        } else if (kDevice_Is_iPhone5||kDevice_Is_iPhone6||kDevice_Is_iPhone6Plus) {
            [UIView animateWithDuration:0.8 animations:^{
                self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
            }];
        }
    } else if (textField.tag == 203) {
        if (kDevice_Is_iPhone4||kDevice_Is_iPhone5) {
            [UIView animateWithDuration:0.8 animations:^{
                self.view.frame = CGRectMake(0, -110, kScreenWidth, kScreenHeight);
            }];
        } else if (kDevice_Is_iPhone6||kDevice_Is_iPhone6Plus) {
            [UIView animateWithDuration:0.8 animations:^{
                self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
            }];
        }
    }
    return YES;
}


#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.message = textField;
    
    if(textField.tag == 7005)
    {
        CGPoint rootViewPoint = [[textField superview] convertPoint:textField.frame.origin toView:self.view];
        //%f  %f",self.message.frame.origin.y,rootViewPoint.y);
        
        
        CGFloat height =rootViewPoint.y - (kApplicationHeight - _keyboardFrame.origin.y);
        
        CGFloat moveheigh = _bigScrollview.contentOffset.y;
        if (height>0)
        {
            
            [UIView animateWithDuration:0.3 animations:^{
                
                _bigScrollview.contentOffset = CGPointMake(0, height+moveheigh+100);
            }];
            
            
        }else{
            
            [UIView animateWithDuration:0.3 animations:^{
                
                _bigScrollview.contentOffset = CGPointMake(0, 50+moveheigh+60);
            }];
            
        }
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{

    textView.text = @"";
    
    CGPoint rootViewPoint = [[textView superview] convertPoint:textView.frame.origin toView:self.view];
    //%f  %f",self.message.frame.origin.y,rootViewPoint.y);
    
    
    CGFloat height =rootViewPoint.y - (kApplicationHeight - _keyboardFrame.origin.y);
    
    CGFloat moveheigh = _bigScrollview.contentOffset.y;
    if (height>0)
    {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            _bigScrollview.contentOffset = CGPointMake(0, height+moveheigh+60);
        }];
        
        
    }

}


//第三种方式则是使用NSString的trimming方法 验证是数字
- (BOOL)isPureNumandCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    } 
    return YES;
}

#pragma mark 验证手机号
/*
-(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    //phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}
*/
-(BOOL) isValidateMobile:(NSString *)mobile
{
    //        手机号以13， 15，18开头，八个 \d 数字字符
    //11位数字
    NSString *phoneRegex = @"^\\d{11}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    //phoneTest is %@",phoneTest);
    
    //phoneBl = %d", [phoneTest evaluateWithObject:mobile]);
    return [phoneTest evaluateWithObject:mobile];
}

#pragma mark 身份证号验证
- (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
