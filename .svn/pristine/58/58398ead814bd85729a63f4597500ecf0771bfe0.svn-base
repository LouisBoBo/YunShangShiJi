//
//  ShopDetailSecretViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/9/14.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "ShopDetailSecretViewController.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "MBProgressHUD.h"
#import "NavgationbarView.h"
#import "DShareManager.h"
#import "ProduceImage.h"
#import "AppDelegate.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "QRCodeGenerator.h"
#import "MyMD5.h"
#import "TypeShareModel.h"

@interface ShopDetailSecretViewController ()<MiniShareManagerDelegate>

@end

@implementation ShopDetailSecretViewController
{
    CGFloat shareimageYY;
    CGFloat publicScale;
    NSString * _shareShopurl;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    publicScale = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatHeadView];
    [self creatRewardview];
    [self creatShareView];
    
    //监听普通分享失败通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShopDetailsharefail:) name:@"ShopDetailsharefail" object:nil];
}

- (void)creatHeadView
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
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"邀请好友";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
}

#pragma mark 分享说明-1
- (void)creatRewardview
{
//    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0,64+ZOOM6(60), kScreenWidth, ZOOM6(50))];
//    titlelabel.textAlignment = NSTextAlignmentCenter;
//    titlelabel.font = [UIFont systemFontOfSize:ZOOM6(32)];
//    titlelabel.textColor = tarbarrossred;
//    titlelabel.text = @"*分享商品 *好友购买 *我拿奖励";
//    [self.view addSubview:titlelabel];
    
    
    UIImageView *headimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenWidth/2.6)];
    headimage.image = [UIImage imageNamed:@"好友分享详情"];
    [self.view addSubview:headimage];
    
    //国片 描述文字 按钮
//    NSArray *dataArr =@[@"1、分享美衣到微信群，除自己外的任意好友点击后，任务奖励即到账。",@"2、好友完成赚钱小任务，每位好友最高100元余额，50元提现。",@"3、如好友购买，你可得20%提现奖励，每日最高50元封顶。"];
    
    NSArray *dataArr =@[@"1.分享微信群，邀请家人，朋友或同事来衣蝠。",@"2.好友每次消费，你可得10%奖励金。",@"3.分享到3个以上微信群，拿到奖励金的概率提升200%。",@"4.坚持分享30天，拿到200元+奖励金的概率高达98%。"];;
    [self.discriptionData addObjectsFromArray:dataArr];
    [self.view addSubview:self.discriptionTableView];
    
//    UILabel *discriptionlab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.discriptionTableView.frame)+ZOOM6(100), kScreenWidth, ZOOM6(80)*publicScale)];
//    discriptionlab.font = [UIFont systemFontOfSize:ZOOM6(30)*publicScale];
//    discriptionlab.textColor = RGBCOLOR_I(125, 125, 125);
//    discriptionlab.textAlignment = NSTextAlignmentCenter;
//    discriptionlab.text = @"快号召小伙伴们来围观\n下载衣蝠APP吧。";
//    discriptionlab.numberOfLines = 0;
//    [self.view addSubview:discriptionlab];

    UILabel *bottomlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.discriptionTableView.frame)+ZOOM6(20), kScreenWidth, ZOOM6(70)*publicScale)];
    bottomlabel.textAlignment = NSTextAlignmentCenter;
    bottomlabel.font = [UIFont systemFontOfSize:ZOOM6(28)*publicScale];
    bottomlabel.numberOfLines = 0;
    bottomlabel.textColor = tarbarrossred;
    bottomlabel.text = @"分享到3个群后，\n拿到现金奖励机率高达98%！";
    [self.view addSubview:bottomlabel];
    
    shareimageYY = CGRectGetMaxY(bottomlabel.frame);
}
#pragma mark 分享平台
- (void)creatShareView
{
    
    CGFloat with = CGRectGetWidth(self.view.frame);
    
    UIView *shareview = [[UIView alloc]initWithFrame:CGRectMake(0,shareimageYY+ZOOM6(30), with, CGRectGetHeight(self.view.frame)-shareimageYY-ZOOM6(50))];
    
    UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, with, ZOOM6(0))];
    titlelab.font = [UIFont systemFontOfSize:ZOOM6(24)*publicScale];
    titlelab.textColor = RGBCOLOR_I(125, 125, 125);
    titlelab.textAlignment = NSTextAlignmentCenter;
    titlelab.text = @"微信群";
//    [shareview addSubview:titlelab];
    
    //分享平台
    for (int i=0; i<1; i++) {
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        shareBtn.frame = CGRectMake(ZOOM6(200)*i+(with-ZOOM6(300))/2,CGRectGetMaxY(titlelab.frame), ZOOM6(100), ZOOM6(100));
        
        shareBtn.frame = CGRectMake((with-ZOOM6(420))/2,CGRectGetMaxY(titlelab.frame), ZOOM6(420), ZOOM6(88));
        shareBtn.tag = 9000+i;
        shareBtn.tintColor = [UIColor clearColor];
        [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i==0) {
            
            //判断设备是否安装微信
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
//
                //判断是否有微信
                
                [shareBtn setBackgroundImage:[UIImage imageNamed:@"分享到微信群"] forState:UIControlStateNormal];
            }else {
                
                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
            }
            
        }else if (i==1){
            
            //判断设备是否安装微信
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]])
            {
                //判断是否有微信
                [shareBtn setBackgroundImage:[UIImage imageNamed:@"朋友圈-1"] forState:UIControlStateNormal];
            }else{
                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
            }
            
        }
        [shareview addSubview:shareBtn];
    }
    
    [self.view addSubview:shareview];
}

- (UIView*)tabfootView
{
    CGFloat width = kScreenWidth-2*ZOOM6(100);
    UIView *footview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, width/1.73)];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM6(20), 0, CGRectGetWidth(footview.frame)-2*ZOOM6(20), CGRectGetHeight(footview.frame))];
    imageview.image = [UIImage imageNamed:@"biaoge-mini"];
    [footview addSubview:imageview];
    return footview;
}

- (UITableView*)discriptionTableView
{
    if(_discriptionTableView == nil)
    {
        CGFloat headheigh = kScreenWidth/2.6;
        CGFloat imagewidth = CGRectGetWidth(self.view.frame)-2*ZOOM6(80);
        CGFloat imageHeigh = ZOOM6(360);
        
        _discriptionTableView = [[UITableView alloc]initWithFrame:CGRectMake(ZOOM6(80), headheigh+Height_NavBar+ZOOM6(50), imagewidth, imageHeigh) style:UITableViewStylePlain];
        _discriptionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _discriptionTableView.scrollEnabled = YES;
        _discriptionTableView.delegate= self;
        _discriptionTableView.dataSource = self;
//        _discriptionTableView.tableFooterView = [self tabfootView];
    }
    return _discriptionTableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = self.discriptionData[indexPath.row];
    CGFloat heigh = [self getRowHeight:title fontSize:ZOOM6(30)];
    
    return ZOOM6(80);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.discriptionData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.text = self.discriptionData[indexPath.row];
        cell.textLabel.textColor = RGBCOLOR_I(125, 125, 125);
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        
        NSString *textStr = cell.textLabel.text;
        NSArray *findStrArr = @[@"2元提现现金",@"提升200%",@"18元任务红包"];
        NSMutableAttributedString *nsmutable = [[NSMutableAttributedString alloc]initWithString:textStr];
        for(int i =0; i < findStrArr.count; i++)
        {
            NSString * findstr = findStrArr[i];
            NSRange range = [textStr rangeOfString:findstr];
            if(range.length >0)
            {
                [nsmutable addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(range.location, findstr.length)];
            }
            
            //左右对齐
//            NSMutableParagraphStyle *par = [[NSMutableParagraphStyle alloc]init];
//            par.alignment = NSTextAlignmentJustified;
//            NSDictionary *dic = @{NSParagraphStyleAttributeName : par,
//                                  NSFontAttributeName : [UIFont systemFontOfSize:ZOOM6(28)],
//                                  NSUnderlineStyleAttributeName : [NSNumber numberWithInteger:NSUnderlineStyleNone]};
//            [nsmutable setAttributes:dic range:NSMakeRange(0, nsmutable.length)];
            
            [nsmutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(28)] range:NSMakeRange(0, textStr.length)];
            [cell.textLabel setAttributedText:nsmutable];
        }
        
        
        
        
        cell.textLabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
        cell.textLabel.numberOfLines = 0;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

#pragma mark 选择分享的平台
-(void)shareClick:(UIButton*)sender
{
    [self shopRequest:(int)sender.tag];
}

#pragma mark 获取商品链接请求
- (void)shopRequest:(int)tag
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *realm = [user objectForKey:USER_ID];
    NSString *token = [user objectForKey:USER_TOKEN];
    
    NSString *url=[NSString stringWithFormat:@"%@shop/getShopLink?version=%@&shop_code=%@&realm=%@&token=%@&share=%@&getShopMessage=true",[NSObject baseURLStr],VERSION,self.shop_code,realm,token,@"2"];
    if([self.stringtype isEqualToString:@"活动商品"])
    {
        url=[NSString stringWithFormat:@"%@shop/getShopLink?version=%@&shop_code=%@&realm=%@&token=%@&share=%@&activity=1",[NSObject baseURLStr],VERSION,self.shop_code,realm,token,@"2"];
    }
    [DataManager sharedManager].key = self.shop_code;
    
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showMessage:@"分享加载中，稍等哟~" afterDeleay:0 WithView:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        if (responseObject!=nil) {
            
            NSString *str=responseObject[@"status"];
            
            if(str.intValue==1)
            {
                _shareShopurl=@"";
                _shareShopurl=responseObject[@"link"];
                NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
                
                if(_shareShopurl)
                {
                    [userdefaul setObject:[NSString stringWithFormat:@"%@",_shareShopurl] forKey:QR_LINK];
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
                             [userdefaul setObject:[NSString stringWithFormat:@"%@",code] forKey:SHOP_CODE];
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
                    NSString *brand = [NSString stringWithFormat:@"%@",responseObject[@"shop"][@"supp_label"]];

                    if(![brand isEqual:[NSNull null]] && ![brand isEqualToString:@"null"] && brand != nil)
                    {
                        [userdefaul setObject:brand forKey:SHOP_BRAND];
                    }
                    
                    NSString *app_shop_group_price = [NSString stringWithFormat:@"%@",responseObject[@"shop"][@"app_shop_group_price"]];
                    if(![app_shop_group_price isEqual:[NSNull null]] && ![app_shop_group_price isEqualToString:@"null"] && app_shop_group_price != nil)
                    {
                        [userdefaul setObject:app_shop_group_price forKey:@"app_shop_group_price"];
                    }
                }
                
                if( !_shareShopurl)
                {
                    [MBProgressHUD hideHUDForView:self.view];
                    return;
                }
                  NSString *shop_code = responseObject[@"shop"][@"shop_code"];
                [TypeShareModel getTypeCodeWithShop_code:shop_code success:^(TypeShareModel *data) {
                    
                    if(data.status == 1 && data.type2 != nil)
                    {
                        [userdefaul setObject:[NSString stringWithFormat:@"%@",data.type2] forKey:SHOP_TYPE2];
                        [self gotoshare:tag];
                    }
                    
                }];
//                [self gotoshare:tag];
            }
            else{
                [MBProgressHUD hideHUDForView:self.view];
                
                UIButton * shopbtn = (UIButton*)[self.view viewWithTag:4001];
                shopbtn.selected = NO;
                
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:@"数据异常，操作无效" Controller:self];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        //网络连接失败");
        [[Animation shareAnimation] stopAnimationAt:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
}

-(void)gotoshare:(int)sharetag
{
    //配置分享平台信息
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app shardk];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    
    NSString *shop_pic=[user objectForKey:SHOP_PIC];
    NSString *shopprice =[user objectForKey:SHOP_PRICE];
    NSString *qrlink = [user objectForKey:QR_LINK];
    NSString *shop_code = [user objectForKey:SHOP_CODE];
    
    kSelfWeak;
    [DShareManager share].detailBlock = ^{
        [weakSelf ShopDetailsharesuccess];
    };
    
    if(sharetag==9000)//微信好友
    {
        MiniShareManager *minishare = [MiniShareManager share];

        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        NSString *shop_brand = [user objectForKey:SHOP_BRAND];
        NSString *realm = [user objectForKey:USER_ID];
        NSString *app_shop_group_price = [user objectForKey:@"app_shop_group_price"];
        NSString *shop_name = [user objectForKey:SHOP_NAME];
        if(shop_brand == nil || [shop_brand isEqualToString:@"(null)"] || [shop_brand isEqual:[NSNull null]])
        {
            shop_brand = @"衣蝠";
        }
        NSString *type2 = [user objectForKey:SHOP_TYPE2];
        
        NSString *title = [minishare taskrawardHttp:type2 Price:shopprice Brand:shop_brand];
        
        NSString *image = [NSString stringWithFormat:@"%@%@!450",[NSObject baseURLStr_Upy],shop_pic];
        NSString *path  = [NSString stringWithFormat:@"/pages/shouye/detail/detail?shop_code=%@&user_id=%@",shop_code,realm];
        minishare.delegate = self;
        
        
        
        //合成图片
        ProduceImage *pi = [[ProduceImage alloc] init];
        UIImage *baseImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:image]]];
        UIImage *zhezhaoImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/shareCanvas_price.png"]]]];
        UIImage *afterImage = [pi getShareImage:zhezhaoImg WithBaseImg:baseImg WithPrice:app_shop_group_price];
        NSData *imageData = UIImageJPEGRepresentation(afterImage,0.8f);
        
        title= [NSString stringWithFormat:@"点击购买👆【%@】今日特价%.1f元！",shop_name,[app_shop_group_price floatValue]];
        [minishare shareAppImageWithType:MINIShareTypeWeixiSession Image:imageData Title:title Discription:nil WithSharePath:path];
        
//        [minishare shareAppWithType:MINIShareTypeWeixiSession Image:image Title:title Discription:nil WithSharePath:path];
        
    }else if (sharetag==9001)//微信朋友圈
    {
        
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            
            UIImage *shopimage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],shop_pic]]]];
            if(shopimage == nil)
            {
                NavgationbarView *mentionview = [[NavgationbarView alloc]init];
                [mentionview showLable:@"数据获取异常" Controller:self];
                
                return ;
            }
            
            [MBProgressHUD hideHUDForView:self.view];
            
            //            UIImage *qrpicimage =[[UIImage alloc]init];
            //    直接创建二维码图像
            UIImage *qrpicimage = [QRCodeGenerator qrImageForString:qrlink imageSize:165];
            
            NSData *data = UIImagePNGRepresentation(qrpicimage);
            NSString *st = [NSString stringWithFormat:@"%@/Documents/abc.png", NSHomeDirectory()];
            
            //st = %@", st);
            
            [data writeToFile:st atomically:YES];
            
            
            ProduceImage *pi = [[ProduceImage alloc] init];
            UIImage *newimg = [pi getImage:shopimage withQRCodeImage:qrpicimage withText:@"detail" withPrice:shopprice WithTitle:nil];
            MyLog(@"newimg = %@",newimg);
            
            
            [[DShareManager share] shareAppWithType:ShareTypeWeixiTimeline View:nil Image:newimg WithShareType:@"detail"];
        });
    }
}

#pragma mark 普通分享失败
- (void)ShopDetailsharefail:(NSNotification*)note
{
    NavgationbarView *mentionview = [[NavgationbarView alloc]init];
    [mentionview showLable:@"分享失败" Controller:self];
}
#pragma mark 普通分享成功
- (void)ShopDetailsharesuccess
{
    NavgationbarView *mentionview = [[NavgationbarView alloc]init];
    [mentionview showLable:@"分享成功" Controller:self];
}
//小程序分享回调
- (void)MinihareManagerStatus:(MINISHARESTATE)shareStatus withType:(NSString *)type
{
    NSString *sstt = @"";
    switch (shareStatus) {
        case MINISTATE_SUCCESS:{
            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
            [mentionview showLable:@"分享成功" Controller:self];
        }
            break;
        case MINISTATE_FAILED:
            sstt = @"分享失败";
            break;
        case MINISTATE_CANCEL:
            sstt = @"分享取消";
            break;
        default:
            break;
    }
    if(shareStatus != MINISTATE_SUCCESS)
    {
        NavgationbarView *mentionview = [[NavgationbarView alloc]init];
        [mentionview showLable:sstt Controller:self];
    }
}

#pragma mark 获取文字高度
-(CGFloat)getRowHeight:(NSString *)text fontSize:(CGFloat)fontSize
{
    text = [text stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    text = [text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    //文字高度
    CGFloat height;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(_discriptionTableView.frame.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
        
    }
    else{
        
    }
    
    return height+ZOOM6(15);
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

- (NSMutableArray*)discriptionData
{
    if(_discriptionData == nil)
    {
        _discriptionData = [NSMutableArray array];
    }
    return _discriptionData;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
