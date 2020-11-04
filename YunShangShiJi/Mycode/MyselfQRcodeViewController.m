//
//  MyselfQRcodeViewController.m
//  YunShangShiJi
//
//  Created by hebo on 2019/7/24.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import "MyselfQRcodeViewController.h"
#import "GlobalTool.h"
#import "MyMD5.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+NJ.h"
#import "ProduceImage.h"
@interface MyselfQRcodeViewController ()
@property (nonatomic , strong) UIImageView *codeImage;
@property (nonatomic , strong) UIImageView *logoImage;
@property (nonatomic , strong) UIImage *afterImage;
@end

@implementation MyselfQRcodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatNavagationView];
    [self creatMainView];
    
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID];
    NSString *str = [NSString stringWithFormat:@"%@,%@,%@",user_id,@"ThreePage",@"QRcode"];
    NSString *page = [NSString stringWithFormat:@"pages/shouye/redHongBao?scene=%@",str];
    [self getQRcodeHttp:page];
}

- (void)creatNavagationView
{
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    headview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"邀请码";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
}
- (void)creatMainView{
    UIImageView *backImageview = [[UIImageView alloc]init];
    [backImageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/newmyself_spacehongbao.png"]]];
    [self.view addSubview:self.codeImage = backImageview];
    
//    UIImageView *codeImageview = [[UIImageView alloc]init];
//    [backImageview addSubview:self.codeImage = codeImageview];
    
    UIButton *savebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    savebtn.backgroundColor = tarbarrossred;
    savebtn.titleLabel.textColor = [UIColor whiteColor];
    savebtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(40)];
    [savebtn setTitle:@"保存二维码" forState:UIControlStateNormal];
    [savebtn addTarget:self action:@selector(saveImage:) forControlEvents:UIControlEventTouchUpInside];
    savebtn.layer.cornerRadius = 5;
    [self.view addSubview:savebtn];
    
    [backImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(Height_NavBar);
//        make.left.mas_offset(30);
//        make.right.mas_offset(-30);
        make.width.mas_offset(ZOOM6(640));
        make.height.mas_offset(ZOOM6(840));
        make.centerX.equalTo(self.view);
    }];
    
//    [codeImageview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(ZOOM6(200));
//        make.height.mas_equalTo(ZOOM6(220));
//        make.bottom.equalTo(backImageview).mas_offset(ZOOM6(-60));
//        make.centerX.equalTo(backImageview.mas_centerX);
//    }];
    
    [savebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backImageview.mas_bottom).offset(30);
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
        make.height.mas_offset(ZOOM6(90));
    }];
    
}
//- (void)getQRcodeImg_logoImg
//{
//    ProduceImage *pi = [[ProduceImage alloc] init];
//
//    UIImage *codeImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/newmyself_QRcode.png"]]]];
//    UIImage *logoImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/newqrcodde_smallredhongbao.png"]]]];
//
//    UIImage *afterImage = [pi getQRImage:codeImg withQRCodeImage:logoImg];
//    self.codeImage.image = afterImage;
//}
-(void)getQRcodeHttp:(NSString*)page
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSString *url=[NSString stringWithFormat:@"%@wxcxPush/createQRCode?version=%@&token=%@&page=%@",@"http://www.52yifu.wang/cloud-wxcx/",VERSION,token,page];
    
    NSString *URL=[MyMD5 authkey:url];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject!=nil) {
            //合成图片
            ProduceImage *pi = [[ProduceImage alloc] init];
            UIImage *baseImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/newmyself_spacehongbao.png"]]]];
            
            UIImage *codeImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],responseObject[@"imageUrl"]]]]];
            UIImage *logoImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/newqrcodde_smallredhongbao.png"]]]];
            UIImage *zhezhaoImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/newmyself_qrcodehongbao.png"]]]];
            
            UIImage *afterImage = [pi getQRImage:codeImg withQRCodeImage:logoImg WithzhezhaoImg:zhezhaoImg WithBaseImg:baseImg];
            self.codeImage.image = afterImage;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //测试用后面删除
        //合成图片
        ProduceImage *pi = [[ProduceImage alloc] init];
        UIImage *baseImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/newmyself_spacehongbao.png"]]]];
        UIImage *codeImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"/user/QRCode/createQRCode_1562724.jpg"]]]];
        UIImage *logoImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/newqrcodde_smallredhongbao.png"]]]];
        
        UIImage *zhezhaoImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/newmyself_qrcodehongbao.png"]]]];
        
        UIImage *afterImage = [pi getQRImage:codeImg withQRCodeImage:logoImg WithzhezhaoImg:zhezhaoImg WithBaseImg:baseImg];
        self.codeImage.image = afterImage;
    }];
    
}

- (void)saveImage:(UIButton*)sender{
    
    kWeakSelf(self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImageWriteToSavedPhotosAlbum(weakself.codeImage.image, weakself, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    });
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [MBProgressHUD showSuccess:@"保存失败" toView:nil];
    } else {
        [MBProgressHUD showSuccess:@"成功保存到相册" toView:nil];
    }
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
@end