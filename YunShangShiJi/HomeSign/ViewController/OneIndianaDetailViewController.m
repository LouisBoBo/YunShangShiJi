//
//  OneIndianaDetailViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/25.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "OneIndianaDetailViewController.h"
#import "GlobalTool.h"
#import "MultiTextView.h"
#import "AFNetworking.h"
#import "DShareManager.h"
#import "MyMD5.h"
#import "HTTPTarbarNum.h"
#import "CommentTableViewCell.h"
#import "CommenModel.h"
#import "NavgationbarView.h"
#import "SizeandColorTableViewCell.h"
#import "ContactKefuViewController.h"
#import "TFPayStyleViewController.h"
#import "OrderDetailViewController.h"

#import "AddAdressViewController.h"
#import <sqlite3.h>
#import "UserInfo.h"
#import "QRCodeGenerator.h"

#import "UIImageView+WebCache.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "ShopDetailModel.h"
#import "UIViewController+KNSemiModal.h"
#import "NavgationbarView.h"
#import "AppDelegate.h"
#import "NavgationbarView.h"
//#import "ChatViewController.h"
#import "RobotManager.h"
#import "TFStartScoreView.h"
#import "ImageTableViewCell.h"
#import "MymineViewController.h"

#import "TFCommentModel.h"
#import "TFAddCommentModel.h"
#import "TFSuppCommentModel.h"
#import "participateModel.h"

#import "OneCommentCell.h"
#import "TwoCommentCell.h"
#import "ThreeCommentCell.h"
#import "FourCommentCell.h"
#import "FiveCommentCell.h"
#import "SixCommentCell.h"
#import "ShareShopModel.h"
#import "ProduceImage.h"
#import "LoginViewController.h"
#import "ShopStoreViewController.h"

#import "FullScreenScrollView.h"
#import "TFLoginView.h"

#import "TFNoviceTaskView.h"
#import "TFDailyTaskView.h"
#import "IntelligenceViewController.h"
#import "RecordTableViewCell.h"
//#import "ComboShopDetailViewController.h"
#import "InvitationViewController.h"
#import "IndianaOweViewController.h"
#import "RecordCell.h"
#import "ManPicModel.h"
#import "ShopCarManager.h"
#import "NewShoppingCartViewController.h"
#import "TFIndianaRecordViewController.h"
#import "IndianaDetailViewController.h"
#import "OneIndianaPopView.h"
#import "IndianaPublicModel.h"
#import "YFShareModel.h"
#import "IndianaRuleTableViewCell.h"
#import "GroupBuyPopView.h"
#import "TFMyWalletViewController.h"
#import "AgoAnnounceCell.h"
#import "MyInvolvementRecordVC.h"
#define SIZE [[UIScreen mainScreen] bounds].size
#define NavigationHeight 44.0f
#define StatusTableHeight 20.0f
#define TableBarHeight 49.0f
#define handViewWidth 10
#define SHAREMODELVIEW_HEIGH ZOOM6(440)

#define OPENCENTERX SIZE.width*0.718
#define DIVIDWIDTH SIZE.width*0.718*0.25
#define COLORBTN_WITH (kApplicationWidth-(40+(ZOOM(50)*2)))/5
#define DUOBAOGUIZE_HEIGH (kApplicationWidth)*1314/1084+ZOOM6(100)

@interface OneIndianaDetailViewController ()<DShareManagerDelegate,UISearchBarDelegate, TFScreeningBackgroundDelegate>

@property (nonatomic ,strong) ShopStoreViewController  *shopStoreVC;
@property (nonatomic, strong)FullScreenScrollView *imgFullScrollView;
@property (nonatomic, strong)TFNoviceTaskView *noviceTaskView;
@property (nonatomic, strong)TFDailyTaskView *dailyTsakView;
 
@property (nonatomic, strong)UIImage *shareRandShopImage;

@end

@implementation OneIndianaDetailViewController
{
    //计时器 天 时 分 秒
    NSString *_day;
    NSString *_hour;
    NSString *_min;
    NSString *_sec;
    
    //详情 评价
    UIView *_headView;
    UIView *_footView;
    UIView *_participateFootview;
    UILabel *_statelab;
    
    ShopDetailModel *_ShopModel;
    
    //好评率
    NSString *_praise_count;
    NSArray *_SizeArray;
    NSArray *_sizeArr;
    
    //记录是否是第一次进来
    NSInteger _comeCount;
    
    //分享的模态视图
    UIView *_shareModelview;
    
    //模态视图
    UIView *_modelview;
    //关掉模态视图按钮
    UIButton *_button;
    //模态视图图像
    UIImageView *_modelimage;
    //购买数量
    UILabel *_numlable;
    //选中的色
    NSString *_selectColor;
    NSString *_selectColorID;
    //选中的尺码
    NSString *_selectSize;
    NSString *_selectSizeID;
    
    //选中商品的名称 价格
    NSString *_selectName;
    NSString *_selectPrice;
    
    UIView *_MobleView;
    //记录数组元素多少个
    int _temp;
    
    //返回按钮
    UIButton *_backbtn;
    //购物车按钮
    UIButton *_shopcartbtn;
    
    //分享按钮
    UIButton *_sharebtn;
    
    //记录图片原有的位置
    CGRect _oldframe;
    BOOL _istouch;
    
    UIPageControl *_pageview;
    
    UIView *_view;
    
    UIImageView *_shopimage;
    UIImageView *_siimage;
    
    //评论当前页数
    NSInteger  _pagecount;
    
    //评论总页数
    NSInteger  _tatalpage;
    
    //回到顶部按钮
    UIButton *_UpBtn;
    
    //tableview的footview
    UIView *_tableFootView;
    
    CALayer *_layer;
    
    //商品链接
    NSString *_shareShopurl;
    
    UIScrollView *_MYmyineScrolllview;
    
    //记录加入购物车商品是否有图片
    BOOL _isImage;
    
    ShareShopModel *_shareModel;
    
    NSString *_sharePrice;

    //数据库
    const char *_sql_stmt;
    
    UIView *_headview;
    
    //记录上一次点击的tag值
    NSInteger _btnTag;
    
    
    NSInteger _noviceTimerCount_5;
    NSTimer *_noviceTimer_5;
    
    UIAlertView *_shopDetailAlterView;
    

    NSTimer *_dailyTimer_1;
    NSTimer *_dailyTimer_2;
    
    
    //++++++++++++++++++添加++++++++++++
    CGPoint openPointCenter;
    
    NSInteger _sharenumber;
    NSInteger _sharefailnumber;
    
    NSString *_newimage;
    
    NSString *_headimageurl;
    
    NSMutableArray *_dataDictionaryArray;
    
    UIButton *_okbutton;//确定按钮
    
    NSTimer *_liketimer;
    UIImageView *_likeview;
    
    NSString *_shopmessage;
    
    AffirmOrderViewController *_publicaffirm;
    
    UIStatusBarStyle _currentStatusBarStyle;
    
    //是否开奖 0未开 3开 4进行中
    NSString *_oweStatues;
    
    //订单评价状态
    NSString *_order_status;
    
    NSString *_lasttime; //倒计时
    UILabel *_Countdowntime;
    int pubtime;
    
    NSString *_myself_incode;//我参与的夺宝号码
    NSInteger _countTrea; //总参与次数
    UILabel *_qihaolable; //参与期号
    UILabel *_discriptionlab; //描述
    UIButton * yueButton; //查看余额
    
    UIView *_sharebackview;
    ManPicDataModel *manPicModel;
    
    //分享相关
    NSString *tixianShare_link;
    NSString *tixianShare_title;
    NSString *tixianShare_discription;
    NSString *tixianShare_pic;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentStatusBarStyle = UIStatusBarStyleLightContent;
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    _isImage = NO;
    _sequenceArray = [NSMutableArray array];
    _sequenceDictionary = [[NSMutableDictionary alloc]init];
    _tagNameArray = [NSMutableArray array];
    _IDArray = [NSMutableArray array];
    _dataDictionaryArray = [NSMutableArray array];
    _participateArray = [NSMutableArray array];
    
    _comeCount = 0;
    
    _pagecount = 1;
    _httpPage = 1;
    self.backview.hidden=YES;
    
    [self createUI];
    
    self.Headimage.frame=CGRectMake(0, self.Headimage.frame.origin.y, kApplicationWidth, kApplicationHeight-180);
    
    #pragma mark 三个钩钩自适应
    _view1.frame = CGRectMake(5, 75, kApplicationWidth*8/33, 25);
    _view2.frame = CGRectMake(kApplicationWidth*8/33, 75, kApplicationWidth*12/33, 25);
    _view3.frame = CGRectMake(kApplicationWidth*20/33, 75, kApplicationWidth*13/33, 25);
    
    [self creatBIGView];
    
    [self creatSectionView];
    
    [self creatFootView];
    
    _sharenumber = 0;
    _sharefailnumber = 0;
    
    //监听购物车通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backdetailview:) name:@"backdetailview" object:nil];
    
    //监听普通分享成功通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShopDetailsharesuccess:) name:@"ShopDetailsharesuccess" object:nil];

    //监听普通分享失败通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShopDetailsharefail:) name:@"ShopDetailsharefail" object:nil];

    [self httpActivityRule];
    
    [self dataInit];
    
    [self requestHttp];
    
    //商品属性及库存分类查询
    [self requestShopHttp];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [_liketimer invalidate];
    
    [_noviceTimer_5 invalidate];
    [_dailyTimer_1 invalidate];
    [_dailyTimer_2 invalidate];
    
    if(self.searchBtn.selected == YES)
    {
        self.screenBtn.selected = NO;
    }
    
    [self.searchBar resignFirstResponder];
    
    self.contentBackgroundView.center = CGPointMake(openPointCenter.x-OPENCENTERX, openPointCenter.y);
    
    [self.searchRightView removeFromSuperview];
    [self.screenView removeFromSuperview];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [MBProgressHUD hideHUDForView:self.view];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:_currentStatusBarStyle];
    
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *shopfrom = [userdefaul objectForKey:PYSUCCESS];
    if (shopfrom!=nil) {
        if (shopfrom.intValue == 8)//夺宝
        {
            [userdefaul setObject:nil forKey:PYSUCCESS];
            [self getincode];//夺宝
        }
    }else if ([self.stringtype isEqualToString:@"我的参与"])
    {
        if (self.winnerStatue == 1)//进行中
        {
            [self GroupBuyPopView:OneIndianaMinute];
        }else if (self.winnerStatue == 2)//未中奖
        {
            NSString *str = [NSString stringWithFormat:@"%@^%@^%@",_ShopModel.shop_batch_num,self.recordsModel.in_code,self.recordsModel.in_name];
            [DataManager sharedManager].duobaoMessage = str;
            [self GroupBuyPopView:OneIndianaNotwinning];
        }else if (self.winnerStatue == 3)//中奖
        {
            [self GroupBuyPopView:OneIndianaWinning];
        }
    }
}

#pragma mark 智能分享成功
-(void)sharesuccess:(NSNotification*)note
{
    //商品属性及库存分类查询
    [self requestShopHttp];
}

#pragma mark 智能分享失败
- (void)sharefail:(NSNotification*)note
{
    //商品属性及库存分类查询
    [self requestShopHttp];
}

#pragma mark 刷新购物车数量
-(void)backdetailview:(NSNotification*)note
{
    [self markrequestHttp];
}

#pragma mark *********************公共部分**********************
//一元夺宝蒙层弹框
- (void)GroupBuyPopView:(GroupBuyPopType)poptype
{
    GroupBuyPopView *view = [[GroupBuyPopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) popType:poptype];
    kWeakSelf(self);
    view.btnBlok = ^(NSInteger tag){
        if(tag == 1)//微信好友
        {
            [self getShareData:9000 Share:YES];
        }else if (tag == 2)//朋友圈
        {
            [self getShareData:9000 Share:YES];
        }else if (tag == 6)//查看余额
        {
            [weakself gotoyue];
        }
    };
    [view show];
}
- (void)gotoyue
{
    TFMyWalletViewController *wallet = [[TFMyWalletViewController alloc]init];
    wallet.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:wallet animated:YES];
}
- (void)dataInit
{
    _noviceTimerCount_5 = MY_MINUTE*0.5;
}

-(CGFloat)getRowHeight:(NSString *)text fontSize:(CGFloat)fontSize
{
    //文字高度
    CGFloat height = 0;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(kScreenWidth-2*ZOOM(50), 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
    }
    
    return height;
}

-(CGFloat)getRullRowHeight:(NSString *)text fontSize:(CGFloat)fontSize
{
    //文字高度
    CGFloat height = 0;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(kScreenWidth-40, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
        
    }
    
    return height;
}

- (void)imageTouch:(UITapGestureRecognizer*)tap
{
    MyLog(@"ok");
    
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],_headimageurl]];
    
    NSMutableArray *imgViewArr = [NSMutableArray array];
    if(imgUrl)
    {
        [imgViewArr addObject:imgUrl];
    }
    
    if(imgViewArr.count)
    {
        [self scaleView:imgViewArr];
    }
    
}

#pragma mark 去包邮
- (void)gobaoyou:(UIButton*)sender
{
    //    ComboShopDetailViewController *detail=[[ComboShopDetailViewController alloc] initWithNibName:@"ComboShopDetailViewController" bundle:nil];
    //    detail.detailType = @"签到包邮";
    //    detail.shop_code = self.baoyou_shop_code;
    //    detail.duobao_shop_code = self.shop_code;
    //
    //    detail.hidesBottomBarWhenPushed=YES;
    //    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark 去晒单
- (void)gothesun:(UIButton*)sender
{
    MyLog(@"去晒单");
    
    IndianaOweViewController *evaluate = [[IndianaOweViewController alloc] init];
    evaluate.recordsModel = self.recordsModel;
    [self.navigationController pushViewController:evaluate animated:YES];
}

- (void)jump
{
    LoginViewController *login=[[LoginViewController alloc]init];
    
    login.tag=1000;
    [self.navigationController pushViewController:login animated:YES];
}


#pragma mark *********************网络请求**********************
-(void)requestHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    

    manager.requestSerializer.timeoutInterval = 10;
    
   
    NSString *url;
    if(token == nil)
    {
        url=[NSString stringWithFormat:@"%@shop/queryUnLogin?version=%@&treas_type=%@",[NSObject baseURLStr],VERSION,self.shop_code];
    }else{
        
        if(self.shop_code.length > 10)
        {
            url=[NSString stringWithFormat:@"%@shop/queryIndiana?version=%@&shop_code=%@&token=%@",[NSObject baseURLStr],VERSION,self.shop_code,token];
        }else{
            url=[NSString stringWithFormat:@"%@shop/queryIndiana?version=%@&treas_type=%@&token=%@",[NSObject baseURLStr],VERSION,self.shop_code,token];
        }
        
    }
    
    
    NSString *URL=[MyMD5 authkey:url];

    [[Animation shareAnimation] CreateAnimationAt:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {

        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        //商品请求 = %@",responseObject);
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            if([message isEqualToString:@"该商品已经下架啦!"])
            {
                _shopmessage = message;
            }
            
            _praise_count=responseObject[@"praise_count"];
            
            NSDictionary *dic=responseObject[@"shop"];
            
            if(statu.intValue==1)//请求成功
            {
                
                [[Animation shareAnimation] stopAnimationAt:self.view];
                
                _comeCount +=1;
                
                ShopDetailModel *model=[[ShopDetailModel alloc]init];
                
                if(![dic isEqual:[NSNull null]])
                {
                    model.actual_sales=[NSString stringWithFormat:@"%@",dic[@"actual_sales"]];
                    
                    
                    model.clicks=dic[@"clicks"];
                    model.content=dic[@"content"];
                    model.def_pic=[NSString stringWithFormat:@"%@",dic[@"def_pic"]];
                    
                    //photo = %@", [NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy], model.def_pic]);
                    
                    model.shop_id=dic[@"id"];
                    model.invertory_num=dic[@"invertory_num"];
                    model.is_hot=dic[@"is_hot"];
                    model.is_new=dic[@"is_new"];
                    model.kickback=dic[@"kickback"];
                    model.love_num=dic[@"love_num"];
                    model.remark=dic[@"remark"];
                    model.shop_code=dic[@"shop_code"];
                    model.shop_discount_time=dic[@"shop_discount_time"];
                    model.shop_name=dic[@"shop_name"];
                    model.shop_pic=dic[@"shop_pic"];
                    model.shop_price=dic[@"shop_price"];
                    model.shop_se_price=dic[@"shop_se_price"];
                    model.shop_up_time=dic[@"shop_up_time"];
                    model.supp_id=dic[@"supp_id"];
                    model.four_pic=dic[@"four_pic"];
                    
                    model.cart_count=responseObject[@"cart_count"];
                    model.like_id=responseObject[@"like_id"];
                    model.color_count=responseObject[@"color_count"];
                    model.cost_count=responseObject[@"cost_count"];
                    model.type_count=responseObject[@"type_count"];
                    model.work_count=responseObject[@"work_count"];
                    model.start_count=responseObject[@"star_count"];
                    model.eva_count=responseObject[@"eva_count"];
                    
                    model.shop_tag=responseObject[@"shop"][@"shop_tag"];
                    
                    model.core = [NSString stringWithFormat:@"%@",responseObject[@"shop"][@"core"]];
                    model.shop_batch_num = responseObject[@"shop"][@"shop_batch_num"];
                    model.active_people_num = responseObject[@"shop"][@"active_people_num"];
                    model.num = responseObject[@"num"];
                    model.sys_time = responseObject[@"shop"][@"sys_time"];
                    model.active_start_time = responseObject[@"shop"][@"active_start_time"];
                    model.active_end_time = responseObject[@"shop"][@"active_end_time"];
                    model.my_num = responseObject[@"my_num"];
                    
                    _ShopModel=model;
                    
                    
                    self.currPage = [dic[@"type1"] intValue];
                    self.shop_se_price = [NSString stringWithFormat:@"%@",dic[@"shop_se_price"]];
                }
                
                //开奖状态
                NSString *owestatue = [NSString stringWithFormat:@"%@",responseObject[@"ostatus"]];
                if([owestatue isEqualToString:@"(null)"] || owestatue == nil)
                {
                    _oweStatues = @"0";
                }else{
                    _oweStatues = owestatue;
                }
                
                //我参与的夺宝号码
                if([responseObject[@"codes"] count])
                {
                    _myself_incode = [responseObject[@"codes"] componentsJoinedByString:@","];
                }
                //总参与次数
                if(responseObject[@"countTrea"] !=nil)
                {
                    _countTrea = [responseObject[@"countTrea"] integerValue];
                }
                //虚拟参与人数
                if(responseObject[@"virtual_num"] !=nil)
                {
                    self.virtual_num = responseObject[@"virtual_num"];
                }
                
                if(_oweStatues.intValue == 0)//未开奖
                {
                    //                    //时间计时器
                    //                    NSString *timestring=[NSString stringWithFormat:@"%@",_ShopModel.active_end_time];
                    //                    _lasttime=timestring;
                    
                    //                    [NSTimer weakTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
                    
                }else if (_oweStatues.intValue == 3)//已开奖
                {
                    //                    _Countdowntime.text = [NSString stringWithFormat:@"揭晓倒计时: %@天%@小时%@分%@秒",@"0",@"0",@"0",@"0"];
                    //获奖者信息
                    TreasureRecordsModel *recordsModel = [[TreasureRecordsModel alloc]init];
                    if(responseObject[@"in_code"] !=nil)
                    {
                        recordsModel.in_code = [NSString stringWithFormat:@"%@",responseObject[@"in_code"]];
                    }
                    if(responseObject[@"in_head"] !=nil)
                    {
                        recordsModel.in_head = [NSString stringWithFormat:@"%@",responseObject[@"in_head"]];
                    }
                    if(responseObject[@"in_name"] !=nil)
                    {
                        recordsModel.in_name = [NSString stringWithFormat:@"%@",responseObject[@"in_name"]];
                    }
                    if(responseObject[@"in_uid"] !=nil)
                    {
                        recordsModel.in_uid = (NSNumber*)[NSString stringWithFormat:@"%@",responseObject[@"in_uid"]];
                    }
                    if(responseObject[@"otime"] !=nil)
                    {
                        recordsModel.otime = [NSString stringWithFormat:@"%@",responseObject[@"otime"]];
                        
                    }

                    self.recordsModel==nil?self.recordsModel=recordsModel:nil;
                }

                //订单状态
                 _order_status = [NSString stringWithFormat:@"%@",responseObject[@"order_status"]];
                
                //创建视图 第二次进来的时候只创建tableview
                if(_comeCount<2)
                {
                    UIView *footview = (UIView*)[self.view viewWithTag:8181];
                    [footview removeFromSuperview];
                    
                    [self creatBIGView];
                    
                    [self creatUI];
                    
                    [self creatFootView];
                    
//                    [self creatModleData];
                    
                    [self httpGetOthers];
                }
                
                self.backview.hidden=NO;
            
                [self indianaHttp];
            }
            else if(statu.intValue == 10030){//没登录状态
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud removeObjectForKey:USER_TOKEN];
                UIView *footview = (UIView*)[self.view viewWithTag:8181];
                [footview removeFromSuperview];
                
                LoginViewController *login=[[LoginViewController alloc]init];
                login.loginStatue = @"10030";
                login.tag = 1000;
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
                
            }else if (statu.intValue == 2)
            {
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:message Controller:self];
                
                
                UIView *footview = (UIView*)[self.view viewWithTag:8181];
                
                UIButton *shopbtn = (UIButton*)[footview viewWithTag:4001];
                
                shopbtn.enabled = NO;
            }
            else{
                
                [self creatHeadview];
                
                self.backview.hidden=YES;
                
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:message Controller:self];
                
                [NSTimer weakTimerWithTimeInterval:1.5 target:self selector:@selector(jump) userInfo:nil repeats:NO];
            }
            

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //[MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
    }];
}

#pragma mark 夺宝参与者
- (void)getManPicModel {
    NSString *shopCode = _ShopModel.shop_code;
    NSString *issueCode = _recordsModel.issue_code?:_ShopModel.shop_batch_num;
    
    [ManPicModel getManPicModelWithShopCodes:shopCode issueCode:issueCode success:^(id data) {
        ManPicModel *model = data;
        if (model.status == 1) {
            manPicModel = model.data;
            [self.MyBigtableview reloadData];
        }
    }];
}

#pragma mark 夺宝参与记录
-(void)indianaHttp
{
//    [self getManPicModel];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url;
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    url=[NSString stringWithFormat:@"%@treasures/getParticipationMan?version=%@&shop_code=%@&token=%@&page=%d&issue_code=%@",[NSObject baseURLStr],VERSION,_ShopModel.shop_code,token,(int)_pagecount,_ShopModel.shop_batch_num];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    
        [self.MyBigtableview footerEndRefreshing];
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        if (responseObject!=nil) {
            
            if ([responseObject[@"status"] intValue] == 1 && ![responseObject[@"list"] isEqual:[NSNull null]]) {
                
                if (_pagecount == 1) {
                    [_participateArray removeAllObjects];
                }
                
                if([responseObject[@"list"] count])
                {
                    for(NSDictionary *dic in responseObject[@"list"])
                    {
                        participateModel *model = [[participateModel alloc]init];
                        model.uid = [NSString stringWithFormat:@"%@",dic[@"uid"]];
                        model.atime = [NSString stringWithFormat:@"%@",dic[@"atime"]];
                        model.uhead = [NSString stringWithFormat:@"%@",dic[@"uhead"]];
                        model.nickname = [NSString stringWithFormat:@"%@",dic[@"nickname"]];
                        model.num = [NSString stringWithFormat:@"%@",dic[@"num"]];
                        model.money = [NSString stringWithFormat:@"%@",dic[@"money"]];
                        
                        if(_participateArray.count < 300)
                        {
                            [_participateArray addObject:model];
                        }
                    }
                }else{
                    [MBProgressHUD show:@"没有更多" icon:nil view:nil];
                }
                
            } else {
//                [MBProgressHUD showError:responseObject[@"message"]];
                
                [[Animation shareAnimation] stopAnimationAt:self.view];
            }
            
            if(_participateArray.count >=300 && self.slectbtn.tag==1001)
            {
                _footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, ZOOM6(100))];
                self.MyBigtableview.tableFooterView= [self participateFootview];
            }
            [self.MyBigtableview reloadData];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.MyBigtableview footerEndRefreshing];
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
}

#pragma mark 网络请求刷新购物车数量
-(void)markrequestHttp
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    
    manager.requestSerializer.timeoutInterval = 10;
    
    
    NSString *url;
    
    if(token == nil)
    {
        url=[NSString stringWithFormat:@"%@shop/queryPUnLogin?version=%@&code=%@",[NSObject baseURLStr],VERSION,self.shop_code];
    }else{
        
        url=[NSString stringWithFormat:@"%@shop/queryPackage?version=%@&code=%@&token=%@",[NSObject baseURLStr],VERSION,self.shop_code,token];
        
    }
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            
            if(statu.intValue==1)//请求成功
            {
                
                _ShopModel.cart_count = [NSString stringWithFormat:@"%@",responseObject[@"cart_count"]];
                
                _marklable.text = [NSString stringWithFormat:@"%d",_ShopModel.cart_count.intValue>99?99:_ShopModel.cart_count.intValue];
                
                if(_marklable.text.intValue == 0)
                {
                    _marklable.hidden = YES;
                }
                
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        
    }];
}

#pragma mark 商品属性及库存分类查询
-(void)requestShopHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url;
    
    url=[NSString stringWithFormat:@"%@shop/queryAttr?version=%@&shop_code=%@",[NSObject baseURLStr],VERSION,self.shop_code];
    
    NSString *URL=[MyMD5 authkey:url];
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    //        [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //[MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        //
        
        //        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            
            if(statu.intValue==1)//请求成功
            {
                for(NSDictionary *dic in responseObject[@"stocktype"])
                {
                    ShopDetailModel *tpyemodel=[[ShopDetailModel alloc] init];
                    
                    tpyemodel.color_size=dic[@"color_size"];
                    tpyemodel.stock_type_id=dic[@"id"];
                    tpyemodel.stock=dic[@"stock"];
                    tpyemodel.pic=dic[@"pic"];
                    tpyemodel.shop_se_price=dic[@"price"];
                    tpyemodel.original_price=dic[@"original_price"];
                    tpyemodel.shop_name=dic[@"shop_name"];
                    tpyemodel.kickback=dic[@"kickback"];
                    
                    [self.stocktypeArray addObject:tpyemodel];
                }
                
                //            [self changestock];
                
                
                
            }
            //        [self creatTableview];
            
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //[MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
        
    }];
}

#pragma mark 积分商城商品库存分类查询
-(void)inventoryHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url;
    
    
    url=[NSString stringWithFormat:@"%@inteShop/queryStock?version=%@&shop_code=%@",[NSObject baseURLStr],VERSION,self.shop_code];
    
    NSString *URL=[MyMD5 authkey:url];
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    //    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        //        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            
            if(statu.intValue==1)//请求成功
            {
                for(NSDictionary *dic in responseObject[@"stocktype"])
                {
                    ShopDetailModel *tpyemodel=[[ShopDetailModel alloc] init];
                    
                    tpyemodel.color_size=dic[@"color_size"];
                    tpyemodel.stock_type_id=dic[@"id"];
                    tpyemodel.stock=dic[@"stock"];
                    tpyemodel.pic=dic[@"pic"];
                    tpyemodel.shop_se_price=dic[@"price"];
                    tpyemodel.shop_name=dic[@"shop_name"];
                    tpyemodel.shop_code=dic[@"shop_code"];
                    
                    [self.JifenshopArray addObject:tpyemodel];
                }
                
                //            [self creatModelview];
            }
            
            CGFloat YY=0;
            
            if(FourAndSevenInch || FiveAndFiveInch)
            {
                YY=300;
            }else{
                YY=200;
            }
            
            [UIView animateWithDuration:0.1 animations:^{
                
                
                _modelview.frame=CGRectMake(0, YY, kApplicationWidth, kApplicationHeight-YY+20);
                
            } completion:^(BOOL finished) {
                
                
            }];
            
            [self presentSemiView:_modelview];
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //[MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
    }];

}

#pragma mark 夺宝规则
- (void)httpActivityRule
{
    NSString *URL= [NSString stringWithFormat:@"%@paperwork/paperwork.json",[NSObject baseURLStr_Upy]];
    NSURL *httpUrl=[NSURL URLWithString:URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:httpUrl];
    request.timeoutInterval = 3;
    
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            
            if(responseObject[@"yydbgz"] != nil)
            {
                NSDictionary *dic2 = responseObject[@"yydbgz"][@"text"];
                if(dic2 !=nil)
                {
                    if(dic2[@"t0"] != nil)
                    {
                        [self.ruleDataArray addObject:dic2[@"t0"]];
                    }
                    if(dic2[@"t1"] != nil)
                    {
                        [self.ruleDataArray addObject:dic2[@"t1"]];
                    }
                    if(dic2[@"t2"] != nil)
                    {
                        [self.ruleDataArray addObject:dic2[@"t2"]];
                    }
                    if(dic2[@"t3"] != nil)
                    {
                        [self.ruleDataArray addObject:dic2[@"t3"]];
                    }
                    if(dic2[@"t4"] != nil)
                    {
                        [self.ruleDataArray addObject:dic2[@"t4"]];
                    }
                    if(dic2[@"t5"] != nil)
                    {
                        [self.ruleDataArray addObject:dic2[@"t5"]];
                    }
                }

            }
        }
        
    }else{
        
    }

}

#pragma mark 往期幸运星
- (void)httpGetOthers
{
    NSString *token = [TFPublicClass getTokenFromLocal];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@treasures/getWinParticipationList?token=%@&version=%@&page=%d&pt=1&sort=otime&order=desc", [NSObject baseURLStr], token, VERSION, (int)self.httpPage];
    NSString *URL = [MyMD5 authkey:urlStr];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        [self.MyBigtableview ffRefreshHeaderEndRefreshing];
        [self.MyBigtableview footerEndRefreshing];
        
        MyLog(@"responseObject: %@", responseObject);
        
        if (kUnNilAndNULL(responseObject)) {
            
            if ([responseObject[@"status"] intValue] == 1) {
                [NSObject saveResponseData:responseObject toPath:urlStr];
                [self tableViewGetOthersData:responseObject];
            } else {
                NavgationbarView *nv = [[NavgationbarView alloc] init];
                [nv showLable:responseObject[@"message"] Controller:self];
            }
        } else {
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        id responseObject = [NSObject loadResponseWithPath:urlStr];
        [self tableViewGetOthersData:responseObject];
        
        NavgationbarView *nv = [[NavgationbarView alloc] init];
        [nv showLable:@"网络连接失败，请检查网络设置~" Controller:self];
        
        if (!self.dataArr.count) {
            [self showBackgroundType:ShowBackgroundTypeNetError message:nil superView:nil setSubFrame:self.view.bounds];
        }
        
        [self.MyBigtableview ffRefreshHeaderEndRefreshing];
        [self.MyBigtableview footerEndRefreshing];
    }];
}

- (void)tableViewGetOthersData:(NSDictionary *)responseObject
{
    if (kUnNilAndNULL(responseObject[@"data"])) {
        
        if (self.httpPage == 1) {
            [self.dataArr removeAllObjects];
        }
        
        NSArray *data = responseObject[@"data"];
        for (NSDictionary *obj in data) {
            TreasureRecordsModel *model = [[TreasureRecordsModel alloc] init];
            [model setValuesForKeysWithDictionary:obj];
            model.OneIndiana = YES;
            [self.dataArr addObject:model];
        }
        
        if (!self.dataArr.count) {
           
        } else {

        }
        
        [self.MyBigtableview reloadData];
    }
}
#pragma mark 获取夺宝的参与号码
- (void)getincode
{
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *pay_type = [userdefaul objectForKey:PAY_TYPE];
    NSString *order_code = [userdefaul objectForKey:PAY_ORDERCODE];
    NSString *pay_num = [userdefaul objectForKey:PAY_NUM];
    
    NSString *url;
    if (pay_num.intValue>=2) {
        url=[NSString stringWithFormat:@"%@treasures/getPayCodeList?version=%@&token=%@&g_code=%@&pay_type=%@",[NSObject baseURLStr_Pay],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN],order_code,pay_type];
    }else
        url=[NSString stringWithFormat:@"%@treasures/getPayCode?version=%@&token=%@&order_code=%@&pay_type=%@",[NSObject baseURLStr_Pay],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN],order_code,pay_type];
    
    NSString *URL=[MyMD5 authkey:url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            MyLog(@"responseObject = %@   %@", responseObject,responseObject[@"message"]);
            NSString *statue = responseObject[@"status"];
            
            if(statue.intValue == 1)
            {
                //参与号码
                NSString* in_code = [NSString stringWithFormat:@"%@",responseObject[@"data"]];
                NSMutableString *newcodes = [NSMutableString string];
                if(in_code.length)
                {
                    NSArray *codes = [in_code componentsSeparatedByString:@","];
                    for(int i=0;i<(codes.count<2?codes.count:2);i++){
                        [newcodes appendString:codes[i]];
                        i==0?[newcodes appendString:@","]:nil;
                    }
                    [[NSUserDefaults standardUserDefaults] setObject:newcodes forKey:@"OneIndiana"];
                    [self getShareData:0 Share:NO];
                }
            }
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark *********************数据库**********************
#pragma mark 删除数据库属性列表
-(BOOL)deleteTable:(NSString*)tableName
{

    NSString *docsDir;
    NSArray *dirPaths;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    
    _databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"attr.db"]];
    
    //    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    //    if ([filemgr fileExistsAtPath:_databasePath] == NO)
    {
        const char *dbpath = [_databasePath UTF8String];
        if (sqlite3_open(dbpath, &AttrcontactDB)==SQLITE_OK)
        {
            
            char *errorMsg;
            //删除表
            NSString * str = [NSString stringWithFormat:@"DROP TABLE %@",tableName];
            
            const  char* sqlStatement  = [str UTF8String];
            int returnCode  =  sqlite3_exec(AttrcontactDB,  sqlStatement,  NULL,  NULL,  &errorMsg);
            if(returnCode!=SQLITE_OK)  {
                　　fprintf(stderr,
                          　　"Error  in  dropping  table  stocks.  Error:  %s",  errorMsg);
                return YES;
                
            }else{
                return NO;
            }
            
            
            
        }
        
    }
    
    return NO;
}

#pragma mark 完整的数据库插入
- (BOOL)insertIntoDocFileWithInfo:(NSString*)str
{
    BOOL result = NO;
    
    [self OpenDb];
    
    if ([self OpenDb]) {
        
        //检测表是否存在
        sqlite3_stmt *statement = nil;
        char *sqlChar = "Select Count(rowid) From sqlite_master Where tbl_name=\"DocFile\"";
        if (sqlite3_prepare_v2(AttrcontactDB, sqlChar, -1, &statement, NULL) != SQLITE_OK)
        {
            //Error:failed to Select Count(rowid) From sqlite_master Where tbl_name=\"DocFile\"");
            sqlite3_finalize(statement);
            [self closeDB];
            return result;
        }
        
        BOOL isExist = NO;
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int count = sqlite3_column_int(statement, 0);
            if (count > 0) {
                isExist = YES;
            }
        }
        sqlite3_finalize(statement);
        
        //不存在则创建表
        if (!isExist) {
            sqlite3_stmt *statement2 = nil;
            char *sqlChar2 = "Create Table If Not Exists DocFile (myId Integer Primary Key, id int default 0, title varchar default \"\", directory varchar default \"\", fileUrl varchar default \"\")";
            if (sqlite3_prepare_v2(AttrcontactDB, sqlChar2, -1, &statement2, NULL) != SQLITE_OK) {
                //Error:failed to Create Table If Not Exists DocFile");
                sqlite3_finalize(statement2);
                [self closeDB];
                return result;
            }
            if (sqlite3_step(statement2) != SQLITE_DONE) {
                //Create Table If Not Exists DocFile failed");
            }
            
            sqlite3_finalize(statement2);
        }
        
        //清除数据
        char *emptySql = "Delete From DocFile";
        int status = sqlite3_exec(AttrcontactDB, emptySql, NULL, NULL, NULL);
        if (status != SQLITE_OK) {
            //清除本地文件表失败");
//            [self closeDB];
//            return result;
        }
        
        const char *dbpath = [_databasePath UTF8String];
        
        //插入数据
        
        if([str isEqualToString:@"attr"])//属性表
        {
            if (sqlite3_open(dbpath, & AttrcontactDB)==SQLITE_OK) {
                
                _sql_stmt = "CREATE TABLE IF NOT EXISTS ATTDB(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT,PHONE TEXT)";
                char *errMsg;
                
                
                if (sqlite3_exec(AttrcontactDB, _sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK)
                {
                    
                    //__________");
                }
                
                NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO ATTDB (ID,name,address,phone) VALUES(\"%@\",\"%@\",\"%@\",\"%@\")",_shuxing_id,_attr_name,_attr_Parent_id,_is_show];
                const char *insert_stmt = [insertSQL UTF8String];
                sqlite3_prepare_v2(AttrcontactDB, insert_stmt, -1, &statement, NULL);
                if (sqlite3_step(statement)==SQLITE_DONE) {
                    
                }
                else
                {
                    
                }
                sqlite3_finalize(statement);
                sqlite3_close(AttrcontactDB);
            }
            
        }

        
        result = YES;
        [self closeDB];
    }
    
    return result;
}

- (void)closeDB
{
    if (AttrcontactDB) {
        sqlite3_close(AttrcontactDB);
        AttrcontactDB = 0x00;
    }
}

-(BOOL)OpenDb
{
    if(AttrcontactDB)
    {
        return YES;
    }
    
    BOOL result=NO;
    
    /*根据路径创建数据库并创建一个表contact(id nametext addresstext phonetext)*/
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    
    _databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"attr.db"]];
    
    //    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    //    if ([filemgr fileExistsAtPath:_databasePath] == NO)
    {
        const char *dbpath = [_databasePath UTF8String];
        if (sqlite3_open(dbpath, &AttrcontactDB)==SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt;
            
            sql_stmt=_sql_stmt;
            if (sqlite3_exec(AttrcontactDB, sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK)
            {
                
                result= YES;
            }
        }
        else
        {
            result= NO;
        }
    }
    
    
    return result;
}

#pragma mark - 查询TAG表-- 数据库查找数据
- (NSArray *)hoboFindDataForTAGDB:(NSArray *)findStr
{
    
    [_tagNameArray removeAllObjects];
    [_sequenceArray removeAllObjects];
    [_IDArray removeAllObjects];
    
    MyLog(@"findStr =  %@",findStr);
    
    for(int i = 0;i<findStr.count;i++)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if([self OpenDb])
        {
            const char *dbpath = [_databasePath UTF8String];
            sqlite3_stmt *statement;
            
            if (sqlite3_open(dbpath, &AttrcontactDB) == SQLITE_OK)
            {
                NSString *querySQL = [NSString stringWithFormat:@"SELECT name,address,phone,ico,sequence,ename from TAGDB where id=\"%@\"",findStr[i]];
                const char *query_stmt = [querySQL UTF8String];
                
                if (sqlite3_prepare_v2(AttrcontactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    
                    while (sqlite3_step(statement) == SQLITE_ROW)
                    {
                        
                        NSString *name = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                        NSString *parterid = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                        
                        MyLog(@" parterid=%@, name = %@ ",parterid, name);
                        
                        if(name !=nil && parterid !=nil)
                        {
                            
                            NSString *sequence =[self sequenceFindDataForTAGDB:parterid];
                            MyLog(@"sequence=%@",sequence);
                            if(sequence)
                            {
                                [dic setObject:name forKey:sequence];
                                [_IDArray addObject:sequence];
                                [_sequenceArray addObject:dic];
                            }
                            
                            [_tagNameArray addObject:name];
                        }
                        
                    }
                }
                
                sqlite3_close(AttrcontactDB);
            }
        }
    }
    
    MyLog(@"_IDArray = %@ ",_IDArray);
    MyLog(@"_sequenceArray = %@ ",_sequenceArray);
    
    
    return _tagNameArray;
}

- (NSString *)sequenceFindDataForTAGDB:(NSString *)findStr
{
    
    [_tagNameArray removeAllObjects];
    
    MyLog(@"findStr =  %@",findStr);
    
    
    if([self OpenDb])
    {
        const char *dbpath = [_databasePath UTF8String];
        sqlite3_stmt *statement;
        
        if (sqlite3_open(dbpath, &AttrcontactDB) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat:@"SELECT name,address,phone,ico,sequence,ename from TAGDB where id=\"%@\"",findStr];
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(AttrcontactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    
                    NSString *sequence = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                    
                    MyLog(@" sequence=%@,",sequence);
                    
                    if(sequence !=nil )
                    {
                        return sequence;
                    }
                    
                }
            }
            
            sqlite3_close(AttrcontactDB);
        }
    }
    
    
    return 0;
}

-(NSDictionary *)FindNameForTPYEDB:(NSString *)findStr
{
    //    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *mudic = [NSMutableDictionary dictionary];
    if([self OpenDb])
    {
        const char *dbpath = [_databasePath UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_open(dbpath, &AttrcontactDB) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat:@"SELECT id,name,address,phone,ico,sequence,isshow,groupflag from TYPDB where id=\"%@\"",findStr];
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(AttrcontactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    NSString *ID= [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                    NSString *name = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                    NSString *ico = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                    NSString *sequence = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                    NSString *isShow = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)];
                    NSString *groupflag = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)];
                    
                    [mudic setValue:ID forKey:@"id"];
                    [mudic setValue:name forKey:@"name"];
                    [mudic setValue:ico forKey:@"ico"];
                    [mudic setValue:sequence forKey:@"sequence"];
                    [mudic setValue:isShow forKey:@"isShow"];
                    [mudic setValue:groupflag forKey:@"groupFlag"];
                    //                    [muArr addObject:mudic];
                    
                    break;
                    
                }
                
                sqlite3_finalize(statement);
            }
            sqlite3_close(AttrcontactDB);
        }
        
    }
    
    //muDic = %@", mudic);
    
    return mudic;
}

-(NSArray *)FindDataForTAGDB:(NSString *)findStr
{
    
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    if([self OpenDb])
    {
        const char *dbpath = [_databasePath UTF8String];
        sqlite3_stmt *statement;
        
        if (sqlite3_open(dbpath, &AttrcontactDB) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat:@"SELECT id,name,phone,ico,sequence,ename from TAGDB where address=\"%@\"",findStr];
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(AttrcontactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    NSMutableDictionary *mudic = [NSMutableDictionary dictionary];
                    NSString *ID = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                    NSString *name = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                    NSString *isShow = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                    NSString *icon = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                    NSString *sequence = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                    NSString *ename = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                    //                    //sequence = %@", sequence);
                    [mudic setValue:ID forKey:@"id"];
                    [mudic setValue:name forKey:@"name"];
                    [mudic setValue:isShow forKey:@"isShow"];
                    [mudic setValue:icon forKey:@"icon"];
                    [mudic setValue:sequence forKey:@"sequence"];
                    [mudic setValue:ename forKey:@"ename"];
                    
                    [muArr addObject:mudic];
                }
                
                sqlite3_finalize(statement);
            }
            sqlite3_close(AttrcontactDB);
        }
        
        
        
    }
    return muArr;
}

-(NSArray *)FindDataForTPYEDB:(NSString *)findStr
{
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    if([self OpenDb])
    {
        const char *dbpath = [_databasePath UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_open(dbpath, &AttrcontactDB) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat:@"SELECT id,name,address,phone,ico,sequence,isshow,groupflag from TYPDB where address=\"%@\"",findStr];
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(AttrcontactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    NSMutableDictionary *mudic = [NSMutableDictionary dictionary];
                    NSString *ID= [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                    NSString *name = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                    NSString *ico = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                    NSString *sequence = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                    NSString *isShow = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)];
                    NSString *groupflag = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)];
                    
                    [mudic setValue:ID forKey:@"id"];
                    [mudic setValue:name forKey:@"name"];
                    [mudic setValue:ico forKey:@"ico"];
                    [mudic setValue:sequence forKey:@"sequence"];
                    [mudic setValue:isShow forKey:@"isShow"];
                    [mudic setValue:groupflag forKey:@"groupFlag"];
                    [muArr addObject:mudic];
                    
                    //                    //mudic = %@", mudic);
                }
                
                sqlite3_finalize(statement);
            }
            sqlite3_close(AttrcontactDB);
        }
        
    }
    return muArr;
}


#pragma mark *********************UI界面**********************
#pragma mark 创建导航条
-(void)creatHeadview
{
    for (UIView *view in self.contentBackgroundView.subviews) {
        if (view.tag == 3838) {
            return;
        }
    }
    
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    headview.image = [UIImage imageNamed:@"zhezhao"];
    headview.tag = 3838;
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    _backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _backbtn.frame=CGRectMake(-10, Height_NavBar-57, 80, 44);
    _backbtn.centerY = View_CenterY(headview);
    [_backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [_backbtn setImage:[UIImage imageNamed:@"icon_fanhui"] forState:UIControlStateNormal];
    [_backbtn setImage:[UIImage imageNamed:@"icon_fanhui"] forState:UIControlStateHighlighted];
    [self.view addSubview:_backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"";
    titlelable.textColor=[UIColor blackColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    CGFloat buttonwith = ZOOM6(136);
    CGFloat buttonheigh= ZOOM6(46);
    //我的参与
    self.AnnouncedBtn=[[UIButton alloc]init];
    self.AnnouncedBtn.frame =CGRectMake(kApplicationWidth-ZOOM(20)-buttonwith, Height_NavBar-40, buttonwith, buttonheigh);
    self.AnnouncedBtn.centerY = View_CenterY(headview);
    self.AnnouncedBtn.selected = NO;
    self.AnnouncedBtn.backgroundColor = RGBCOLOR_I(249, 36, 61);
    [self.AnnouncedBtn setTitle:@"我的参与" forState:UIControlStateNormal];
    [self.AnnouncedBtn setTintColor:[UIColor whiteColor]];
    self.AnnouncedBtn.layer.cornerRadius = 3;
    self.AnnouncedBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(24)];
    [self.AnnouncedBtn addTarget:self action:@selector(Announcedclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.AnnouncedBtn];
    
    UIButton *totopbtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    totopbtn.frame=CGRectMake(60, 0, kApplicationWidth-160, 40);
    [totopbtn addTarget:self action:@selector(upToTop:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:totopbtn];
}

- (void)creatTableFootView
{
    _tableFootView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight-Height_NavBar+kUnderStatusBarStartY)];
    _tableFootView.backgroundColor=[UIColor whiteColor];
    
    [self footViewAddChildView];
}
- (void)creatUI
{
    //去包邮
    UIButton *baoyouBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    baoyouBtn.frame = CGRectMake(self.Headimage.frame.size.width-ZOOM6(150)-10, self.Headimage.frame.size.height-ZOOM6(190), ZOOM6(150), ZOOM6(150));
    
    [baoyouBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d%@",[_ShopModel.shop_se_price intValue],@"uanbaoyou_hover"]] forState:UIControlStateNormal];
    
    [baoyouBtn addTarget:self action:@selector(gobaoyou:) forControlEvents:UIControlEventTouchUpInside];
    
    if(self.baoyou_shop_code !=nil)
    {
        [self.view addSubview:baoyouBtn];
        [self.view bringSubviewToFront:baoyouBtn];
    }
    
}

#pragma mark 创建tableheadview视图
-(void)creatBIGView
{
    
    UIView *view=(UIView*)[self.view viewWithTag:3838];
    
    if(view)
    {
        [view removeFromSuperview];
        
        for(UIView *vv in view.subviews)
        {
            [vv removeFromSuperview];
        }
    }
    
    CGFloat imgheigh=900*kApplicationWidth/600;
    self.Headimage.frame=CGRectMake(0, self.Headimage.frame.origin.y, kApplicationWidth, imgheigh);
    
    CGFloat headimageYY=CGRectGetMaxY(self.Headimage.frame);
    
    self.backview.frame=CGRectMake(0, headimageYY, kApplicationWidth, self.backview.frame.size.height);
    
    //是否开奖
    UILabel *owelable = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(42), ZOOM6(20), ZOOM6(100), ZOOM6(40))];
    owelable.layer.cornerRadius = 3;
    owelable.layer.borderWidth = 1;
    owelable.font = [UIFont systemFontOfSize:ZOOM6(24)];
    owelable.textAlignment = NSTextAlignmentCenter;
    
    if(_oweStatues.intValue == 0 && _oweStatues !=nil)
    {
        owelable.text = @"进行中";
        owelable.textColor = RGBCOLOR_I(109, 194, 100);
        owelable.layer.borderColor = RGBCOLOR_I(109, 194, 100).CGColor;
        
//        self.winnerStatue = 1;
    }else if(_oweStatues.intValue == 3){
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *userid =[user objectForKey:USER_ID];
        
        owelable.text = (userid.intValue == self.recordsModel.in_uid.intValue)?@"已中奖":@"已开奖";
        owelable.textColor = tarbarrossred;
        owelable.layer.borderColor = tarbarrossred.CGColor;
        
        self.winnerStatue = (userid.intValue == self.recordsModel.in_uid.intValue)?3:2;
    }else if (_oweStatues.intValue == 4)
    {
        owelable.text = @"正在开奖";
        owelable.textColor = RGBCOLOR_I(109, 194, 100);
        owelable.font = [UIFont systemFontOfSize:ZOOM6(20)];
        owelable.layer.borderColor = RGBCOLOR_I(109, 194, 100).CGColor;
        
        self.winnerStatue = 1;
    }
    
    [self.backview addSubview:owelable];
    
    //商品名
    CGFloat shopanmeHeigh = [self getRowHeight:[NSString stringWithFormat:@"%@",_ShopModel.shop_name] fontSize:ZOOM6(30)];
    
    self.shopname.frame = CGRectMake(CGRectGetMaxX(owelable.frame)+ZOOM6(10), ZOOM6(20),kScreenWidth-2*ZOOM(42)-CGRectGetWidth(owelable.frame)-ZOOM6(10), shopanmeHeigh);
    
    self.shopname.text = [self exchangeTextWihtString:_ShopModel.shop_name];
    
    self.shopname.text = [NSString stringWithFormat:@"%@",_ShopModel.shop_name];
    
    self.shopname.textColor = RGBCOLOR_I(62, 62, 62);
    self.shopname.numberOfLines = 0;
    self.shopname.font = [UIFont systemFontOfSize:ZOOM6(30)];
    
    //lable的行间距
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:self.shopname.text];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:ZOOM6(10)];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [self.shopname.text length])];
    
    [_discriptionlab removeFromSuperview];
    //商品描述
    _discriptionlab = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(42), CGRectGetMaxY(self.shopname.frame)+ZOOM6(20), kScreenWidth-2*ZOOM(42), 0)];
    
    NSString *dusstr = [NSString stringWithFormat:@"%@",_ShopModel.content];
    
    _discriptionlab.text = dusstr;
    _discriptionlab.userInteractionEnabled = YES;
    _discriptionlab.numberOfLines = 0;
    _discriptionlab.font = [UIFont systemFontOfSize:ZOOM6(24)];
    _discriptionlab.textColor = RGBCOLOR_I(125, 125, 125);
    [self.backview addSubview:_discriptionlab];
    
    CGFloat dislabHeigh = [self getRowHeight:_discriptionlab.text fontSize:ZOOM6(24)];
    _discriptionlab.frame = CGRectMake(ZOOM(42), CGRectGetMaxY(self.shopname.frame)+ZOOM6(20), kScreenWidth-2*ZOOM(42), dislabHeigh);
    
    //出售价
    CGFloat olldpriceY = CGRectGetMaxY(_discriptionlab.frame);
    
    self.se_price.frame=CGRectMake(owelable.frame.origin.x, olldpriceY+ZOOM6(15), self.se_price.frame.size.width, ZOOM(18*3.4));
    
    self.se_price.text=[NSString stringWithFormat:@"￥%.1f",[_ShopModel.shop_se_price floatValue]];
    self.se_price.font = [UIFont systemFontOfSize:ZOOM(18*3.4)];
    
    //    [self.se_price setFont:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM(18*3.4)]];
    
    self.se_price.textColor = tarbarrossred;
    
    NSDictionary *attributes1 = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(19*3.4)]};
    CGSize se_price_textSize = [self.se_price.text boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes1 context:nil].size;
    
    self.se_price.frame=CGRectMake(owelable.frame.origin.x-ZOOM6(5), self.se_price.frame.origin.y, se_price_textSize.width, self.se_price.frame.size.height);
    
    CGFloat sepriceX = CGRectGetMaxX(self.se_price.frame);
    
    //原价
    self.oldprice.frame=CGRectMake(sepriceX , olldpriceY+ZOOM(4*3.4)+ZOOM6(15), self.oldprice.frame.size.width, ZOOM(12*3.4));
    
    self.oldprice.text=[NSString stringWithFormat:@"￥%.1f",[_ShopModel.shop_price floatValue]];
    self.oldprice.font = [UIFont systemFontOfSize:ZOOM(12*3.4)];
    self.oldprice.textColor = RGBCOLOR_I(168, 168, 168);
    
    
    NSDictionary *attributes2 = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(13*3.4)]};
    CGSize textSize = [self.oldprice.text boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes2 context:nil].size;
    
    self.oldprice.frame = CGRectMake(sepriceX, self.oldprice.frame.origin.y, textSize.width, self.oldprice.frame.size.height);
    
    self.priceline.frame=CGRectMake(sepriceX+2,self.oldprice.frame.origin.y + self.oldprice.frame.size.height/2, textSize.width-4, self.priceline.frame.size.height);

    CGFloat qihaolableY =CGRectGetMaxY(self.se_price.frame);
    
    //查看余额
    [yueButton removeFromSuperview];
    CGFloat imageH = ZOOM6(60);
    CGFloat imageW = ZOOM6(160);
    yueButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    yueButton.frame = CGRectMake(kScreenWidth-imageW-ZOOM(42), CGRectGetMinY(self.se_price.frame)-ZOOM6(10), imageW, imageH);
    yueButton.backgroundColor = tarbarrossred;
    [yueButton setTitle:@"查看余额" forState:UIControlStateNormal];
    [yueButton setTintColor:[UIColor whiteColor]];
    yueButton.layer.cornerRadius = 3;
    yueButton.hidden = YES;
    yueButton.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
    [yueButton addTarget:self action:@selector(gotoyue) forControlEvents:UIControlEventTouchUpInside];
    [self.backview addSubview:yueButton];
    
    //期号
    [_qihaolable removeFromSuperview];
    
    _qihaolable = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(42), qihaolableY+ZOOM6(15), ZOOM6(300), ZOOM6(24))];
    _qihaolable.textColor = RGBCOLOR_I(125, 125, 125);
    _qihaolable.font = [UIFont systemFontOfSize:ZOOM6(24)];
    _qihaolable.backgroundColor = [UIColor whiteColor];
    _qihaolable.text = [NSString stringWithFormat:@"期号: %@",_ShopModel.shop_batch_num];
    [self.backview addSubview:_qihaolable];
    
    
    if((_oweStatues.intValue == 0 || _oweStatues.intValue == 4)&& _oweStatues !=nil)
    {
        //倒计时
        _Countdowntime = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(42), CGRectGetMaxY(_qihaolable.frame)+ZOOM6(30), kScreenWidth-2*ZOOM(42), ZOOM6(35))];
        _Countdowntime.font = [UIFont systemFontOfSize:ZOOM6(30)];
        _Countdowntime.textColor = RGBCOLOR_I(255, 63, 139);
        _Countdowntime.text = [NSString stringWithFormat:@"已有%d人正在参与",[_ShopModel.num intValue]+self.virtual_num.intValue];
        [self.backview addSubview:_Countdowntime];
        
        UILabel *countdownback = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(42), CGRectGetMaxY(_Countdowntime.frame)+ZOOM6(10), kScreenWidth-2*ZOOM(42), ZOOM6(14))];
        countdownback.layer.borderColor = RGBCOLOR_I(255, 63, 139).CGColor;
        countdownback.layer.borderWidth = 1;
        
        //        UILabel *countlab = (UILabel*)[self.backview viewWithTag:8642];
        //        [countlab removeFromSuperview];
        
        CGFloat scale = 0;
        
        UILabel *countdownlab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(countdownback.frame)*scale, ZOOM6(14))];
        countdownlab.tag = 8642;
        countdownlab.backgroundColor = RGBCOLOR_I(255, 63, 139);
        
        //        if(scale > 0)
        {
            [countdownback addSubview:countdownlab];
        }
        [self.backview addSubview:countdownback];
        
        //总需人次
        UILabel *totalPassengers = [[UILabel alloc] initWithFrame:CGRectMake(ZOOM(42), CGRectGetMaxY(countdownback.frame)+ZOOM6(10), kScreenWidth/2, ZOOM6(30))];
        totalPassengers.backgroundColor = [UIColor whiteColor];
        totalPassengers.text = [NSString stringWithFormat:@"总需人次:%@",_ShopModel.active_people_num];
        totalPassengers.font = [UIFont systemFontOfSize:ZOOM6(24)];
        totalPassengers.textColor = RGBCOLOR_I(168, 168, 168);
        [self.backview addSubview:totalPassengers];
        
        UILabel *owelPassengers = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2, CGRectGetMaxY(countdownback.frame)+ZOOM6(10), kScreenWidth/2-ZOOM(42), ZOOM6(30))];
        owelPassengers.backgroundColor = [UIColor whiteColor];
        owelPassengers.textAlignment = NSTextAlignmentRight;
        
        //        NSString *num = [NSString stringWithFormat:@"%@",_ShopModel.num];
        
        owelPassengers.text = [NSString stringWithFormat:@"剩余人次:%d",[_ShopModel.active_people_num intValue]];
        
        NSInteger vnum = self.recordsModel.virtual_num?self.recordsModel.virtual_num.integerValue:self.virtual_num.integerValue;
        
        int activenum =(int)([_ShopModel.active_people_num intValue] - [_ShopModel.num intValue] - vnum);
        
        if(activenum > 0)
        {
            [Signmanager SignManarer].IndianaSurplusCount = activenum;
            owelPassengers.text = [NSString stringWithFormat:@"剩余人次:%d",activenum];
        }else
        {
            [Signmanager SignManarer].IndianaSurplusCount = 0;
            owelPassengers.text = [NSString stringWithFormat:@"剩余人次:%d",0];
        }
        
        owelPassengers.font = [UIFont systemFontOfSize:ZOOM6(24)];
        owelPassengers.textColor = tarbarrossred;
        
        //参与人数进度条
        if(activenum != 0)
        {
            scale = ([_ShopModel.active_people_num floatValue]-activenum)/[_ShopModel.active_people_num floatValue];
            if(scale >1)
            {
                scale = 1;
            }
        }else{
            scale = 1;
        }
        countdownlab.frame = CGRectMake(0, 0, CGRectGetWidth(countdownback.frame)*scale, ZOOM6(14));
        
        NSMutableAttributedString *noteStr ;
        if(owelPassengers.text)
        {
            noteStr = [[NSMutableAttributedString alloc]initWithString:owelPassengers.text];
        }
        [noteStr addAttribute:NSForegroundColorAttributeName value:RGBCOLOR_I(168, 168, 168) range:NSMakeRange(0, 5)];
        [owelPassengers setAttributedText:noteStr];
        [self.backview addSubview:owelPassengers];
        
        //分割线
        UILabel *lableline = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(owelPassengers.frame)+ZOOM6(30), kScreenWidth, 0.5)];
        lableline.backgroundColor = kBackgroundColor;
        [self.backview addSubview:lableline];
        
        UILabel *tisilab = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(42), CGRectGetMaxY(lableline.frame)+ZOOM6(10), kScreenWidth-2*ZOOM(42), ZOOM6(60))];
        tisilab.textColor = RGBCOLOR_I(168, 168, 168);
        tisilab.backgroundColor = [UIColor whiteColor];
        tisilab.font = [UIFont systemFontOfSize:ZOOM6(24)];
        tisilab.text = @"您还木有参加哦,赶紧试试吧,万一中了呢?";
        tisilab.numberOfLines = 0;
        
        if(_myself_incode !=nil && ![_myself_incode isEqualToString:@"(null)"])
        {
            NSString *count = [NSString stringWithFormat:@"%@",_ShopModel.my_num];
            
            NSArray *incodes = [_myself_incode componentsSeparatedByString:@","];
            if(incodes.count > 2)
            {
                tisilab.text = [NSString stringWithFormat:@"你参与了：%d人次\n参与号码:%@,%@...",count.intValue,incodes[0],incodes[1]];
            }else{
                tisilab.text = [NSString stringWithFormat:@"你参与了：%d人次\n参与号码：%@",count.intValue,_myself_incode];
            }
            
            tisilab.textColor = tarbarrossred;
            CGFloat incodelable = [self getRowHeight:tisilab.text fontSize:ZOOM6(24)];
            
            tisilab.frame =CGRectMake(ZOOM(42), CGRectGetMaxY(lableline.frame)+ZOOM6(10), kScreenWidth-2*ZOOM(42), incodelable+ZOOM6(40));
            
            NSMutableAttributedString *noteStr1 ;
            if(tisilab.text)
            {
                noteStr1 = [[NSMutableAttributedString alloc]initWithString:tisilab.text];
            }
            [noteStr1 addAttribute:NSForegroundColorAttributeName value: tarbarrossred range:NSMakeRange(5, count.length)];
            [tisilab setAttributedText:noteStr1];
            
        }
        
        [self.backview addSubview:tisilab];
        
        UILabel *spacelab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tisilab.frame)+ZOOM6(10), kScreenWidth, 10)];
        spacelab.backgroundColor = kBackgroundColor;
        [self.backview addSubview:spacelab];
        
        
        self.backview.frame = CGRectMake(0, self.backview.frame.origin.y, kApplicationWidth, qihaolableY+CGRectGetMaxY(spacelab.frame)-CGRectGetMaxY(self.se_price.frame));
        
    }
    else if (_oweStatues.intValue == 3){
        
        MyLog(@"model==== %@",self.recordsModel);
        
        UIView *baseview1 = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(42), CGRectGetMaxY(_qihaolable.frame) + ZOOM6(30), kScreenWidth - 2*ZOOM(42), ZOOM6(60))];
        baseview1.backgroundColor = tarbarrossred;
        
        UIImageView *titleimage = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM6(20), ZOOM6(10), ZOOM6(40), ZOOM6(40))];
        titleimage.image = [UIImage imageNamed:@"icon_tongzhi"];
        
        UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleimage.frame)+ZOOM6(10), ZOOM6(10), ZOOM6(600), ZOOM6(40))];
        if(self.recordsModel.in_code == nil)
        {
            titlelab.text = @"本期幸运号码:";
        }else
            titlelab.text = [NSString stringWithFormat:@"本期幸运号码:%@",self.recordsModel.in_code];
        
        titlelab.textColor = [UIColor whiteColor];
        titlelab.font = [UIFont systemFontOfSize:ZOOM6(30)];
        
        
        [baseview1 addSubview:titleimage];
        [baseview1 addSubview:titlelab];
        [self.backview addSubview:baseview1];
        
        UIView *baseview2 = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(42), CGRectGetMaxY(baseview1.frame), kScreenWidth - 2*ZOOM(42), ZOOM6(120))];
        baseview2.backgroundColor = RGBCOLOR_I(253, 246, 235);
        
        
        UIImageView *headimage = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM6(20), ZOOM6(20), ZOOM6(80), ZOOM6(80))];
        headimage.backgroundColor = tarbarrossred;
        if([self.recordsModel.in_head hasPrefix:@"http"])
        {
            [headimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.recordsModel.in_head]]];
        }else{
            [headimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],self.recordsModel.in_head]]];
        }
        
        headimage.clipsToBounds = YES;
        headimage.layer.cornerRadius = CGRectGetWidth(headimage.frame)/2;
        
        UILabel *namelab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headimage.frame)+ZOOM6(20), ZOOM6(20), ZOOM6(300), ZOOM6(40))];
        namelab.textColor = RGBCOLOR_I(168, 168, 168);
        if(self.recordsModel.in_name == nil)
        {
            namelab.text = @"获奖者:";
        }else
            namelab.text = [NSString stringWithFormat:@"获奖者:%@",self.recordsModel.in_name];
        namelab.font = [UIFont systemFontOfSize:ZOOM6(28)];
        
        NSMutableAttributedString *noteStr ;
        if(namelab.text)
        {
            noteStr = [[NSMutableAttributedString alloc]initWithString:namelab.text];
        }
        [noteStr addAttribute:NSForegroundColorAttributeName value: tarbarrossred range:NSMakeRange(0, 4)];
        [namelab setAttributedText:noteStr];
        
//        UILabel *activelab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headimage.frame)+ZOOM6(20), CGRectGetMaxY(namelab.frame), ZOOM6(400), ZOOM6(40))];
//        activelab.font = [UIFont systemFontOfSize:ZOOM6(24)];
//        activelab.textColor = kTextColor;
//        activelab.text = [NSString stringWithFormat:@"参与次数:%@",_ShopModel.my_num];
        
        UILabel *timelab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headimage.frame)+ZOOM6(20), CGRectGetMaxY(namelab.frame), ZOOM6(400), ZOOM6(40))];
        timelab.textColor = kTextColor;
        
        NSString *etime ;
        if(self.recordsModel.otime !=nil)
        {
            etime= [MyMD5 getTimeToShowWithTimestamp:[NSString stringWithFormat:@"%@",self.recordsModel.otime]];
        }
        
        if(etime == nil)
        {
            timelab.text = @"开奖时间:";
        }else
            timelab.text = [NSString stringWithFormat:@"开奖时间:%@",etime];
        
        timelab.font = [UIFont systemFontOfSize:ZOOM6(24)];
        
        UIButton *Thesunbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        Thesunbtn.frame = CGRectMake(CGRectGetWidth(baseview2.frame)-ZOOM6(20)-ZOOM6(160), ZOOM6(30), ZOOM6(160), ZOOM6(60));
        [Thesunbtn setTitle:@"去晒单" forState:UIControlStateNormal];
        Thesunbtn.tintColor = [UIColor whiteColor];
        Thesunbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
        Thesunbtn.backgroundColor = tarbarrossred;
        Thesunbtn.layer.cornerRadius = 5;
        Thesunbtn.hidden = YES;
        [Thesunbtn addTarget:self action:@selector(gothesun:) forControlEvents:UIControlEventTouchUpInside];
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *userid = [user objectForKey:USER_ID];
        
        
//        if(_order_status.integerValue !=4)
//        {
//            [Thesunbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            Thesunbtn.backgroundColor = kbackgrayColor;
//            Thesunbtn.enabled = NO;
//        }
        
        [baseview2 addSubview:headimage];
        [baseview2 addSubview:namelab];
//        [baseview2 addSubview:activelab];
        [baseview2 addSubview:timelab];
        [baseview2 addSubview:Thesunbtn];
        [self.backview addSubview:baseview2];
        
        //分割线
        UILabel *lableline = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(baseview2.frame)+ZOOM6(20), kScreenWidth, 0.5)];
        lableline.backgroundColor = kBackgroundColor;
        [self.backview addSubview:lableline];
        
        UILabel *tisilab = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(42), CGRectGetMaxY(lableline.frame)+ZOOM6(10), kScreenWidth-2*ZOOM(42), ZOOM6(40))];
        tisilab.textColor = RGBCOLOR_I(168, 168, 168);
        tisilab.font = [UIFont systemFontOfSize:ZOOM6(24)];
        
        NSString *count = [NSString stringWithFormat:@"%@",_ShopModel.my_num];
        [self.backview addSubview:tisilab];
        
        if(userid.intValue == self.recordsModel.in_uid.intValue)//中奖
        {
            tisilab.text = @"恭喜您中奖啦~";
            yueButton.hidden = NO;
        }else{
            tisilab.text = [NSString stringWithFormat:@"您参与了：%d人次",count.intValue];
            tisilab.textColor = tarbarrossred;
            NSMutableAttributedString *noteStr1 ;
            if(tisilab.text)
            {
                noteStr1 = [[NSMutableAttributedString alloc]initWithString:tisilab.text];
            }
            [noteStr1 addAttribute:NSForegroundColorAttributeName value: tarbarrossred range:NSMakeRange(5, count.length)];
            [tisilab setAttributedText:noteStr1];
        }

        UILabel *tisilab2 = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(42), CGRectGetMaxY(tisilab.frame), kScreenWidth-2*ZOOM(42), ZOOM6(40))];
        
        NSString *tistext = [NSString stringWithFormat:@"参与号码：%@",_myself_incode];
        tistext = [tistext stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        MyLog(@"tistext = %@",tistext);
        if(count.intValue > 0)
        {
            CGFloat incodelable = [self getRowHeight:tistext fontSize:ZOOM6(24)];
            
            tisilab2.frame = CGRectMake(ZOOM(42), CGRectGetMaxY(tisilab.frame), kScreenWidth-2*ZOOM(42), incodelable);
            
            tisilab2.font = [UIFont systemFontOfSize:ZOOM6(24)];
            tisilab2.text = [NSString stringWithFormat:@"%@",tistext];
//            tisilab2.textColor = RGBCOLOR_I(168, 168, 168);
            tisilab2.textColor = tarbarrossred;
            tisilab2.textAlignment = NSTextAlignmentLeft;
            tisilab2.numberOfLines = 0;
            
            [self.backview addSubview:tisilab2];
            
        }else{
            tisilab2.frame = CGRectMake(ZOOM(42), CGRectGetMaxY(tisilab.frame), kScreenWidth-2*ZOOM(42), ZOOM6(10));
        }
        
        UILabel *spacelab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tisilab2.frame)+ZOOM6(10), kScreenWidth, 10)];
        spacelab.backgroundColor = kBackgroundColor;
        [self.backview addSubview:spacelab];
        
        self.backview.frame = CGRectMake(0, self.backview.frame.origin.y, kApplicationWidth, qihaolableY+CGRectGetMaxY(spacelab.frame)-CGRectGetMaxY(self.se_price.frame));
        
    }
    
    CGFloat backviewYY=CGRectGetMaxY(self.backview.frame);
    
    self.Myscrollview.frame=CGRectMake(0, self.Myscrollview.frame.origin.y, kApplicationWidth, backviewYY);
    self.Myscrollview.backgroundColor=[UIColor whiteColor];
    
    
    //大图
    if(! _ShopModel.def_pic)
    {
        
        CGFloat imgheigh=900*kApplicationWidth/600;
        
        UIImageView *defaultimg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, IMGSIZEW(@"iconfont-icon 拷贝副本"), IMGSIZEH(@"iconfont-icon 拷贝副本"))];
        defaultimg.center=CGPointMake(self.Headimage.frame.size.width/2, imgheigh/2);
        defaultimg.tag=3737;
        defaultimg.image=[UIImage imageNamed:@"iconfont-icon 拷贝副本"];
        
        [self.Headimage addSubview:defaultimg];
        
    }else
    {
        UIImageView *defaultimg=(UIImageView*)[self.view viewWithTag:3737];
        [defaultimg removeFromSuperview];
        
        NSString *st;
        if (kDevice_Is_iPhone6Plus) {
            st = @"!450";
        } else {
            st = @"!382";
        }
        
        MyLog(@"_ShopModel.def_pic = %@",_ShopModel.def_pic);
        
        
        if(_ShopModel.def_pic)
        {
            
            NSMutableString *code = [NSMutableString stringWithString:_ShopModel.shop_code];
            
            NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
            MyLog(@"supcode =%@",supcode);
            
            _newimage = [NSString stringWithFormat:@"%@/%@/%@",supcode,_ShopModel.shop_code,_ShopModel.def_pic];
            MyLog(@"newurl = %@",_newimage);
            
            
        }
        
        
        NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],_newimage,st]];
        
        __block float d = 0;
        __block BOOL isDownlaod = NO;
        
        CGFloat imgheigh=900*kApplicationWidth/600;
        
        self.Headimage.frame=CGRectMake(0, self.Headimage.frame.origin.y, kApplicationWidth, imgheigh);
        
        [self.Headimage sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            d = (float)receivedSize/expectedSize;
            isDownlaod = YES;
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image != nil && isDownlaod == YES) {
                self.Headimage.alpha = 0;
                [UIView animateWithDuration:0.5 animations:^{
                    self.Headimage.alpha = 1;
                } completion:^(BOOL finished) {
                }];
            } else if (image != nil && isDownlaod == NO) {
                
                self.Headimage.image = image;
            }
        }];
        
        //给Headimage 添加手势
        if(imgUrl)
        {
            self.Headimage.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTouch:)];
            _headimageurl = _newimage;
            [self.Headimage addGestureRecognizer:tap];
        }
        
    }
    
    //    //去包邮
    //    UIButton *baoyouBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //    baoyouBtn.frame = CGRectMake(self.Headimage.frame.size.width-ZOOM6(150)-10, self.Headimage.frame.size.height-ZOOM6(150)-10, ZOOM6(150), ZOOM6(150));
    //
    //    [baoyouBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d%@",[_ShopModel.shop_se_price intValue],@"uanbaoyou_hover"]] forState:UIControlStateNormal];
    //
    //    [baoyouBtn addTarget:self action:@selector(gobaoyou:) forControlEvents:UIControlEventTouchUpInside];
    //    
    //    if(self.baoyou_shop_code !=nil)
    //    {
    //        [self.Headimage addSubview:baoyouBtn];
    //    }
    [self creatBigTableview];
    
    [self creatHeadview];
    
}

#pragma mark 创建tableview section 视图
-(void)creatSectionView
{
    //详情 尺码 评价
    UIView *headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 40)];
    headview.backgroundColor=[UIColor whiteColor];
    
    
    UILabel *linelable=[[UILabel alloc]initWithFrame:CGRectMake(0, 39, kApplicationWidth, 1)];
    linelable.backgroundColor=kBackgroundColor;
    [headview addSubview:linelable];
    
    
    NSArray *titleArr=@[@"抽奖规则",@"参与记录",@"往期幸运星"];
    CGFloat btnwidh=kApplicationWidth/titleArr.count;
    for(int i=0;i<titleArr.count;i++)
    {
        //按钮
        UIButton * stateBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        stateBtn.frame=CGRectMake(btnwidh*i, 0, btnwidh, 40);
        [stateBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [stateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        stateBtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM(45)];
        stateBtn.tag = 1000+i;
        [stateBtn addTarget:self action:@selector(butclick:) forControlEvents:UIControlEventTouchUpInside];
        
        [headview addSubview:stateBtn];
        
        UILabel *linelable=[[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth/3 *(i+1), 10, 1, 20)];
        linelable.backgroundColor=kBackgroundColor;
        [headview addSubview:linelable];
        
        //状态条
        _statelab=[[UILabel alloc]initWithFrame:CGRectMake(btnwidh*i, 35, btnwidh, 5)];
        _statelab.backgroundColor=[UIColor clearColor];
        _statelab.tag=2000+i;
        [headview addSubview:_statelab];
        
        //设置进来时选中的按键
        if(0==i)
        {
            [stateBtn setTitleColor:tarbarrossred forState:UIControlStateNormal];;
            stateBtn.selected=YES;
            self.slectbtn=stateBtn;
            _btnTag = 1000;
            self.BigDataArray =[NSMutableArray arrayWithArray:self.dataArr];
            
            _footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight-DUOBAOGUIZE_HEIGH-Height_NavBar-40-50-kUnderStatusBarStartY)];
            
            self.MyBigtableview.tableFooterView=_footView;
        }
        
    }
    
    _headView=headview;
    
}

#pragma mark 创建列表视图
-(void)creatBigTableview
{
    
    for (UIView *view in self.contentBackgroundView.subviews) {
        if (view == self.MyBigtableview) {
            return;
        }
    }
    CGFloat viewHeigh = kIOSVersions >= 11 ? -20 :0;
    self.MyBigtableview = [[UITableView alloc]initWithFrame:CGRectMake(0, viewHeigh, kApplicationWidth, kApplicationHeight+kUnderStatusBarStartY-55-viewHeigh) style:UITableViewStylePlain];
    
    
    self.MyBigtableview.delegate=self;
    self.MyBigtableview.dataSource=self;
    
    self.MyBigtableview.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.Myscrollview.frame=CGRectMake(0, 0, self.Myscrollview.frame.size.width, self.Myscrollview.frame.size.height+5);
    
    
    [self.MyBigtableview setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    self.Myscrollview.clipsToBounds = YES;
    self.Myscrollview.scrollsToTop=NO;
    
    self.MyBigtableview.tableHeaderView = self.Myscrollview;
    
//    self.MyBigtableview.tableFooterView=_tableFootView;
    

    [self.view addSubview:self.MyBigtableview];

    [self.view bringSubviewToFront:self.screenBtn];
    
    [self.MyBigtableview registerNib:[UINib nibWithNibName:@"RecordTableViewCell" bundle:nil] forCellReuseIdentifier:@"recordCell"];
    
    [self.MyBigtableview registerNib:[UINib nibWithNibName:@"IndianaRuleTableViewCell" bundle:nil] forCellReuseIdentifier:@"RULECELL"];
    
    [self.MyBigtableview registerNib:[UINib nibWithNibName:@"AgoAnnounceCell" bundle:nil] forCellReuseIdentifier:@"AgoAnnounceCellID"];
}

#pragma mark 创建脚底视图
-(void)creatFootView
{
    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight-55+kUnderStatusBarStartY, kApplicationWidth, 55)];
    footView.backgroundColor=[UIColor whiteColor];
    footView.tag = 8181;
    
    [self.view addSubview:footView];
    [self.view bringSubviewToFront:footView];

    NSString *str = @"立即参与";
    NSArray *arr=@[@"联系客服",str];
    
    CGFloat btnwith = kScreenWidth / 2;
    
    //联系店主 立即参与
    for(int i=0;i<2;i++)
    {

        UIButton *shopbtn= [[UIButton alloc]init];
        shopbtn.frame=CGRectMake(btnwith*i,0, btnwith, 55);
        shopbtn.tintColor=[UIColor blackColor];
        shopbtn.tag=4000+i;
        
        [footView addSubview:shopbtn];
        
        UIImageView *shopimageview=[[UIImageView alloc] init];
        UILabel *titlelable=[[UILabel alloc]initWithFrame:CGRectMake(0, 30, btnwith, 20)];
        titlelable.textAlignment=NSTextAlignmentCenter;
        titlelable.font=[UIFont systemFontOfSize:ZOOM(34)];
        titlelable.textColor=kTextColor;
        if(i==0)
        {
            shopimageview.frame=CGRectMake((btnwith-IMGSIZEW(@"icon_lianxikefu"))/2, 5, IMGSIZEW(@"icon_lianxikefu"), IMGSIZEH(@"icon_lianxikefu"));
            shopimageview.image=[UIImage imageNamed:@"icon_lianxikefu"];
            shopimageview.contentMode=UIViewContentModeScaleAspectFit;
            
            titlelable.text=@"联系客服";
            [shopbtn addTarget:self action:@selector(shopClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }else{
            shopbtn.tintColor=[UIColor whiteColor];
            shopbtn.backgroundColor = tarbarrossred;
            
            [shopbtn setTitle:arr[i] forState:UIControlStateNormal];
            shopbtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM(50)];
            
            if(_oweStatues.intValue == 3 )
            {
                [shopbtn setTitle:@"已结束" forState:UIControlStateNormal];
                shopbtn.backgroundColor = kbackgrayColor;
//                shopbtn.enabled = NO;
            }else if(_oweStatues.intValue == 4 )
            {
                [shopbtn setTitle:@"正在开奖" forState:UIControlStateNormal];
                
            }else if (_myself_incode !=nil)
            {
                [shopbtn setTitle:@"再次参与" forState:UIControlStateNormal];
            }
           
            [shopbtn addTarget:self action:@selector(contactClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [shopbtn addSubview:shopimageview];
        [shopbtn addSubview:titlelable];
        
    }
    
    //分割线
    UILabel *butlable1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth/2+1, 1)];
    butlable1.backgroundColor=kBackgroundColor;
    
    UILabel *butlable2=[[UILabel alloc]initWithFrame:CGRectMake(btnwith, 1, 1, btnwith)];
    butlable2.backgroundColor=kBackgroundColor;
    
    UILabel *butlable3=[[UILabel alloc]initWithFrame:CGRectMake(btnwith*2, 1, 1, btnwith)];
    butlable3.backgroundColor=kBackgroundColor;
    
    [footView addSubview:butlable1];
    [footView addSubview:butlable2];
    [footView addSubview:butlable3];

}

#pragma mark 分享视图
- (void)creatShareModelView
{
    [_sharebackview removeFromSuperview];
    
    _sharebackview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight)];
   
    [self.view addSubview:_sharebackview];

    
//    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight+kUnderStatusBarStartY)];
//    backview.tag=9797;
    
    
    UITapGestureRecognizer *viewtap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disapperview:)];
    [_sharebackview addGestureRecognizer:viewtap];
    _sharebackview.userInteractionEnabled = YES;

    
    _shareModelview = [[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight+30, kApplicationWidth, SHAREMODELVIEW_HEIGH)];
    _shareModelview.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_shareModelview];
    
    
    UIView *shareBaseView = [[UIView alloc]initWithFrame:CGRectMake(0,ZOOM6(60), kScreenWidth, SHAREMODELVIEW_HEIGH+kUnderStatusBarStartY)];
    shareBaseView.backgroundColor = [UIColor whiteColor];
    [_shareModelview addSubview:shareBaseView];
    
    NSArray *titleArray = @[@"微信群",@"朋友圈",@"QQ"];
    CGFloat dismissbtnYY =0;
    //分享平台
    for (int i=0; i<3; i++) {
        
        CGFloat space = (kScreenWidth - ZOOM6(300) -ZOOM6(90)*2)/2;
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.frame = CGRectMake((space+ZOOM6(100))*i+ZOOM6(90),ZOOM6(70), ZOOM6(100), ZOOM6(100));
        shareBtn.tag = 9000+i;
        [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *sharetitle = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(shareBtn.frame)-20, CGRectGetMaxY(shareBtn.frame)+ZOOM6(10), CGRectGetWidth(shareBtn.frame)+40, 15)];
        sharetitle.text = titleArray[i];
        sharetitle.textColor = RGBCOLOR_I(168, 168, 168);
        sharetitle.font = [UIFont systemFontOfSize:ZOOM6(24)];
        sharetitle.textAlignment = NSTextAlignmentCenter;
        
        dismissbtnYY = CGRectGetMaxY(sharetitle.frame);
        
        if (i==0) {//微信好友
            
            //判断设备是否安装微信
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
                
                //判断是否有微信
                [shareBtn setBackgroundImage:[UIImage imageNamed:@"icon_weinxinqun"] forState:UIControlStateNormal];
                
            }else {
                
                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
                sharetitle.hidden = YES;
                
            }
            
        }else if (i==1){//微信朋友圈
            
            //判断设备是否安装微信
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
                
                //判断是否有微信
                [shareBtn setBackgroundImage:[UIImage imageNamed:@"朋友圈-1"] forState:UIControlStateNormal];
                
            }else {
                
                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
                sharetitle.hidden = YES;
                
            }
        }else{//QQ空间
            
            
            //判断设备是否安装QQ
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]])
            {
                //判断是否有qq
                
                [shareBtn setBackgroundImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
                
            }else{
                
                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
                sharetitle.hidden = YES;
            }
            
            
        }
        [shareBaseView addSubview:sharetitle];
        [shareBaseView addSubview:shareBtn];
        
    }
    
    
    //取消按钮
    UIButton *dismissbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dismissbtn.frame = CGRectMake(ZOOM6(90), dismissbtnYY+ZOOM6(40), kScreenWidth-ZOOM6(90)*2, ZOOM6(80));
    dismissbtn.layer.borderColor = RGBCOLOR_I(125, 125, 125).CGColor;
    dismissbtn.layer.borderWidth = 1;
    dismissbtn.layer.cornerRadius = 5;
    [dismissbtn setTitleColor:RGBCOLOR_I(125, 125, 125) forState:UIControlStateNormal];
    dismissbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
    [dismissbtn setTitle:@"取消" forState:UIControlStateNormal];
    [dismissbtn addTarget:self action:@selector(dismissShareView) forControlEvents:UIControlEventTouchUpInside];
    [shareBaseView addSubview:dismissbtn];
    
    _sharebackview.backgroundColor =[UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _sharebackview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        
        _shareModelview.frame=CGRectMake(0, kApplicationHeight-SHAREMODELVIEW_HEIGH+kUnderStatusBarStartY, kApplicationWidth, SHAREMODELVIEW_HEIGH);
        
    } completion:^(BOOL finished) {
        
        
    }];
    
}

- (void)dismissShareView
{
    _sharebtn.selected = NO;
    [self disapperShare];
}

#pragma mark 弹出模态视图
-(void)creatModelview
{
    
    //底视图
    _modelview=[[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight+100, kApplicationWidth, kApplicationHeight)];
    _modelview.backgroundColor=[UIColor whiteColor];
    
    [_modelview bringSubviewToFront:self.view];
    
    //关掉按钮
    _button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _button.frame=CGRectMake(kApplicationWidth-ZOOM(55*3.4), 0, ZOOM(55*3.4), ZOOM(55*3.4));
    _button.titleLabel.font=[UIFont systemFontOfSize:25];
    [_button addTarget:self action:@selector(dismissSemiModalView) forControlEvents:UIControlEventTouchUpInside];
    [_modelview addSubview:_button];
    
    UIImageView *closeimg = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM(55*3.4)-ZOOM(15*3.4)-ZOOM(40), 10, ZOOM(15*3.4), ZOOM(15*3.4))];
    closeimg.image = [UIImage imageNamed:@"×"];
    [_button addSubview:closeimg];
    
    
    
    //分割线
    UILabel *lableline=[[UILabel alloc]initWithFrame:CGRectMake(0, 80, kApplicationWidth, 1)];
    lableline.backgroundColor=kbackgrayColor;
    //    [_modelview addSubview:lableline];
    
    CGFloat headbtnwidh=(kApplicationWidth-(30+(ZOOM(50)*2)))/4;
    
    //头像
    _modelimage=[[UIImageView alloc]initWithFrame:CGRectMake(ZOOM(50), 10, headbtnwidh, ZOOM(280))];
    
    
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_Upy],_newimage]];
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [_modelimage sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d = (float)receivedSize/expectedSize;
        isDownlaod = YES;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod == YES) {
            _modelimage.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                _modelimage.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        } else if (image != nil && isDownlaod == NO) {
            _modelimage.image = image;
        }
    }];
    
    _modelimage.contentMode = UIViewContentModeScaleToFill;
    _modelimage.tag=3579;
    [_modelview addSubview:_modelimage];
    
    //名称
    UILabel *namelab=[[UILabel alloc]initWithFrame:CGRectMake(_modelimage.frame.origin.x+_modelimage.frame.size.width +15, _modelimage.frame.origin.y-5, kApplicationWidth-150, 30)];
    namelab.numberOfLines=0;
    namelab.font = [UIFont systemFontOfSize:ZOOM(46)];
    namelab.textColor =kTitleColor;
    namelab.tag=4321;

    
    namelab.text = [self exchangeTextWihtString:_ShopModel.shop_name];
    [_modelview addSubview:namelab];
    
    //价格
    UILabel *pricelab=[[UILabel alloc]initWithFrame:CGRectMake(_modelimage.frame.origin.x+_modelimage.frame.size.width +15, _modelimage.frame.origin.y+20, 200, 30)];
    pricelab.text=[NSString stringWithFormat:@"￥%.1f",[_ShopModel.shop_se_price  floatValue]];
    pricelab.font = [UIFont systemFontOfSize:ZOOM(46)];
    pricelab.tag=8765;
    pricelab.textColor=tarbarrossred;
    pricelab.font=[UIFont systemFontOfSize:16];
    [_modelview addSubview:pricelab];
    
    CGFloat YY;
    if(FiveAndFiveInch)
    {
        YY=300;
    }
    else if(FourAndSevenInch)
    {
        YY=300;
    }else if (FourInch)
    {
        YY=180;
    }
    
    else{
        
        YY=110;
    }

    
    CGFloat modelscrollviewY = CGRectGetMaxY(_modelimage.frame);
    //列表
    UIScrollView * modelscrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, modelscrollviewY+10, kApplicationWidth, kApplicationHeight-YY-modelscrollviewY-50)];
    
    
    modelscrollview.scrollsToTop=NO;
    
    [_modelview addSubview:modelscrollview];
    
    //尺码数据
    _sizeArr=[NSArray array];
    
    MyLog(@"self.SizeDataArray=%@",self.SizeDataArray);
    
    for(int i=0; i<self.SizeDataArray.count;i++)
    {
        NSArray *sizearr;
        NSString *str=self.SizeDataArray[i];
        NSString *cccc = [str substringToIndex:[str length] - 1];
        sizearr=[cccc componentsSeparatedByString:@","];
        if([sizearr[0] isEqualToString:@"尺码"])
        {
            _sizeArr=sizearr;
            break;
        }
        
        
    }
    
    //颜色按钮
    UILabel *colorlable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(50), 0, 60, 25)];
    colorlable.text=@"颜色";
    colorlable.textColor =kTitleColor;
    colorlable.font = [UIFont systemFontOfSize:ZOOM(40)];
    [modelscrollview addSubview:colorlable];
    
    UIButton *colorbtn;
    CGFloat btnwidh=(kApplicationWidth-(40+(ZOOM(50)*2)))/5;
    CGFloat btnheigh = btnwidh*0.6;
    
    for(int j=1;j<self.colorArray.count;j++)
    {
        
        colorbtn=[[UIButton alloc]init];
        
        if(j<6)
        {
            colorbtn.frame=CGRectMake(ZOOM(50)+(btnwidh+10)*(j-1), colorlable.frame.origin.y+colorlable.frame.size.height+5, btnwidh, btnheigh);
        }else{
            colorbtn.frame=CGRectMake(ZOOM(50)+(btnwidh+10)*(j-6), colorlable.frame.origin.y+btnwidh+35, btnwidh, btnheigh);
        }
        
        [colorbtn setTitle:self.colorArray[j] forState:UIControlStateNormal];
        colorbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
        [colorbtn setTitleColor:kTextColor forState:UIControlStateNormal];
        colorbtn.titleLabel.numberOfLines = 0;
        colorbtn.titleLabel.textAlignment = NSTextAlignmentCenter;
      
        colorbtn.tag=2000+j;
        colorbtn.layer.borderWidth=1;
        colorbtn.layer.borderColor=kbackgrayColor.CGColor;
        colorbtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM(40)];
        [colorbtn addTarget:self action:@selector(colorlick:) forControlEvents:UIControlEventTouchUpInside];
        
        //查找商品颜色ID
        NSMutableDictionary *dic=self.stock_colorArray[j];
        NSString *colorid=[dic objectForKey:self.colorArray[j]];
        
        NSMutableArray *stockarr;
        if([self.typestring isEqualToString:@"兑换"])
        {
            stockarr=[NSMutableArray arrayWithArray:self.JifenshopArray];
        }else{
            stockarr=[NSMutableArray arrayWithArray:self.stocktypeArray];
        }
        
        //根据商品颜色ID匹配图片
        for(int k=0;k<stockarr.count;k++)
        {
            ShopDetailModel *model=stockarr[k];
            NSMutableString *color_sizestring=[NSMutableString stringWithString:model.color_size];
            NSArray *arr=[color_sizestring componentsSeparatedByString:@":"];
            
            if([arr[0] isEqualToString:colorid])
            {
    
                //如果查找相同的ID就把图片匹配上去
                //id is %@",colorid);
                
                [colorbtn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                ShopDetailModel *model=stockarr[k];
                
                UIImageView *img=[[UIImageView alloc]init];
                img.frame=CGRectMake(0, 0, btnwidh, btnwidh);
                img.tag=9990;
                
                if(model.pic !=nil)
                {
                    if(j<6)
                    {
                        colorbtn.frame=CGRectMake(ZOOM(50)+(btnwidh+10)*(j-1), colorlable.frame.origin.y+colorlable.frame.size.height+5, btnwidh, btnwidh);
                    }else{
                        colorbtn.frame=CGRectMake(ZOOM(50)+(btnwidh+10)*(j-6), colorlable.frame.origin.y+btnwidh+35, btnwidh, btnwidh);
                    }
                    
                    _isImage = YES;
                    
                    NSURL *imgUrl;
                    
                    if(model.pic)
                    {
                        
                        NSMutableString *code = [NSMutableString stringWithString:_ShopModel.shop_code];
                        
                        NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
                        MyLog(@"supcode =%@",supcode);
                        
                        
                        imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@/%@!280",[NSObject baseURLStr_Upy],supcode,code,model.pic]];
                    }
                    
                    
                    MyLog(@"imgUrl&&&&&& =%@",imgUrl);
                    
                    __block float d = 0;
                    __block BOOL isDownlaod = NO;
                    [img sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                        d = (float)receivedSize/expectedSize;
                        isDownlaod = YES;
                    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        if (image != nil && isDownlaod == YES) {
                            
                            
                            img.alpha = 0;
                            [UIView animateWithDuration:0.5 animations:^{
                                img.alpha = 1;
                            } completion:^(BOOL finished) {
                            }];
                        } else if (image != nil && isDownlaod == NO) {
                            img.image = image;
                            
                        }
                    }];
                    
                    
                    [colorbtn addSubview:img];

                    
                }else{
                    
                    colorbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
                    [colorbtn setTitleColor:kTextColor forState:UIControlStateNormal];
                }
                
                
            }
        }
        
        if(CGRectGetHeight(colorbtn.frame) == COLORBTN_WITH)
        {
            colorbtn.layer.borderWidth=0;
        }
        
        if(2000+j==2001)
        {
            colorbtn.selected=YES;
            colorbtn.layer.borderWidth=0;
            colorbtn.backgroundColor=tarbarrossred;
            [colorbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            if(_isImage == YES)
            {
                colorbtn.layer.borderWidth=1;
                colorbtn.layer.borderColor = bodyrossred.CGColor;
            }
            
            
            NSMutableDictionary *dic=self.stock_colorArray[j];
            _selectColorID =[dic objectForKey:self.colorArray[j]];
            _selectColor=colorbtn.titleLabel.text;
            
            //查找商品颜色ID
            
            NSString *colorid=[dic objectForKey:self.colorArray[j]];
            
            NSMutableArray *stockarr;
            if([self.typestring isEqualToString:@"兑换"])
            {
                stockarr=[NSMutableArray arrayWithArray:self.JifenshopArray];
            }else{
                stockarr=[NSMutableArray arrayWithArray:self.stocktypeArray];
            }
            
            //根据商品颜色ID匹配图片
            for(int k=0;k<stockarr.count;k++)
            {
                ShopDetailModel *model=stockarr[k];
                NSMutableString *color_sizestring=[NSMutableString stringWithString:model.color_size];
                NSArray *arr=[color_sizestring componentsSeparatedByString:@":"];
                if([arr[0] isEqualToString:colorid])
                {
                    //如果查找相同的ID就把图片匹配上去
                    //id is %@",colorid);
                    
                    ShopDetailModel *model=stockarr[k];
                    
                    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
                    [userdefaul setObject:model.pic forKey:SELECT_PHOTO];
                    
                }
            }
            
        }
        
        
        [modelscrollview addSubview:colorbtn];
    }
    
    //分割线
    UILabel *colorline=[[UILabel alloc]initWithFrame:CGRectMake(10, colorbtn.frame.origin.y+colorbtn.frame.size.height+10, kApplicationWidth-20, 1)];
    if(_isImage == YES)
    {
        colorline.frame = CGRectMake(10, colorbtn.frame.origin.y+btnwidh+10, kApplicationWidth-20, 1);
    }
    
    colorline.backgroundColor=kbackgrayColor;
    //    [modelscrollview addSubview:colorline];
    
    //尺码按钮
    UILabel *sizelable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(50), colorline.frame.origin.y, 60, 25)];
    sizelable.text=@"尺码";
    sizelable.textColor = kTitleColor;
    sizelable.font =[UIFont systemFontOfSize:ZOOM(40)];
    [modelscrollview addSubview:sizelable];
    
    
    MyLog(@"_sizeArr = %@",_sizeArr);
    
    UIButton *sizebtn;
    for(int j=1;j<_sizeArr.count;j++)
    {
        sizebtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        if(j<6)
        {
            sizebtn.frame=CGRectMake(ZOOM(50)+(btnwidh+10)*(j-1), sizelable.frame.origin.y+sizelable.frame.size.height+5, btnwidh, btnheigh);
        }else{
            sizebtn.frame=CGRectMake(ZOOM(50)+(btnwidh+10)*(j-6), sizelable.frame.origin.y+sizelable.frame.size.height+50, btnwidh, btnheigh);
        }
        
        [sizebtn setTitle:_sizeArr[j] forState:UIControlStateNormal];
//        if(_sizeArr.count == 2)
//        {
//            [sizebtn setTitle:@"均码" forState:UIControlStateNormal];
//        }

        sizebtn.tag=1000+j;

        sizebtn.layer.borderWidth=1;
        sizebtn.layer.borderColor=kbackgrayColor.CGColor;
        sizebtn.tintColor=kTextColor;
        sizebtn.titleLabel.numberOfLines = 0;
        sizebtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        sizebtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
        [sizebtn addTarget:self action:@selector(sizeclick:) forControlEvents:UIControlEventTouchDown];
        
  
        
        if(1000+j==1001)
        {
            sizebtn.backgroundColor=tarbarrossred;
            sizebtn.tintColor=[UIColor whiteColor];
            sizebtn.layer.borderWidth=0;
            
            for(int k=0;k<self.stock_sizeArray.count;k++)
            {
                NSDictionary *dic =self.stock_sizeArray[k];
                NSString *str=[dic objectForKey:_sizeArr[j]];
                
                if(str.length>0)
                {
                    _selectSize=sizebtn.titleLabel.text;
                    _selectSizeID=str;
                    break;
                }
            }
            
            
        }
        
        
        [modelscrollview addSubview:sizebtn];
    }
    
    
    
    UILabel *sizeline=[[UILabel alloc]initWithFrame:CGRectMake(10, sizebtn.frame.origin.y+sizebtn.frame.size.height+5, kApplicationWidth-20, 1)];
    sizeline.backgroundColor=kbackgrayColor;
    //    [modelscrollview addSubview:sizeline];
    
    
    //数量
    UILabel *numlable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(50), sizeline.frame.origin.y, 60, 25)];
    numlable.text=@"数量";
    numlable.textColor =kTitleColor;
    numlable.font =[UIFont systemFontOfSize:ZOOM(46)];
    
    [modelscrollview addSubview:numlable];
    
    //数量减
    UIButton *reducebtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    reducebtn.frame=CGRectMake(ZOOM(50), numlable.frame.origin.y+numlable.frame.size.height+10, 30, 30);
    [reducebtn setBackgroundImage:[UIImage imageNamed:@"减_默认"] forState:UIControlStateNormal];
    [reducebtn setBackgroundImage:[UIImage imageNamed:@"减_选中"] forState:UIControlStateHighlighted];
    
    [reducebtn addTarget:self action:@selector(reduce:) forControlEvents:UIControlEventTouchUpInside];
    [modelscrollview addSubview:reducebtn];
    
    //显示数量
    _numlable=[[UILabel alloc]initWithFrame:CGRectMake(reducebtn.frame.origin.x+reducebtn.frame.size.width+5, reducebtn.frame.origin.y, 60, 30  )];
    _numlable.text=@"1";
    _numlable.textColor=kTextGreyColor;
    _numlable.textAlignment=NSTextAlignmentCenter;
    _numlable.layer.borderWidth=1;
    _numlable.layer.borderColor=kbackgrayColor.CGColor;
    [modelscrollview addSubview:_numlable];
    
    //数量加
    UIButton *addbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    addbtn.frame=CGRectMake(_numlable.frame.origin.x+_numlable.frame.size.width+5, reducebtn.frame.origin.y, 30, 30);
    
    [addbtn setBackgroundImage:[UIImage imageNamed:@"加_默认"] forState:UIControlStateNormal];
    [addbtn setBackgroundImage:[UIImage imageNamed:@"加_选中"] forState:UIControlStateHighlighted];
    
    [addbtn addTarget:self action:@selector(addbtn:) forControlEvents:UIControlEventTouchUpInside];
    [modelscrollview addSubview:addbtn];
    
    //显示库存
    UILabel *inventorylab=[[UILabel alloc]initWithFrame:CGRectMake(addbtn.frame.origin.x+addbtn.frame.size.width+10, reducebtn.frame.origin.y, 100, 30)];
    //    inventorylab.text=@"库存1000件";
    inventorylab.tag=9876;
    inventorylab.textColor=kTextColor;
    inventorylab.font = [UIFont systemFontOfSize:ZOOM(40)];
    [modelscrollview addSubview:inventorylab];
    
    NSString *stockstring=[self changestock];
    
    UILabel *lableline1=[[UILabel alloc]initWithFrame:CGRectMake(0, modelscrollview.frame.origin.y+modelscrollview.frame.size.height+2, kApplicationWidth, 1)];
    lableline1.backgroundColor=kbackgrayColor;
    //    [_modelview addSubview:lableline1];
    
    
    CGFloat MOdelscrollviewyy = CGRectGetMaxY(inventorylab.frame);
    modelscrollview.contentSize=CGSizeMake(0, MOdelscrollviewyy+20);
    
    
    //确定按钮
    _okbutton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _okbutton.frame=CGRectMake(ZOOM(50), modelscrollview.frame.origin.y+modelscrollview.frame.size.height+10, kApplicationWidth-ZOOM(50)*2, 40);
    
    _okbutton.tag=9191;
    _okbutton.backgroundColor=[UIColor blackColor];
    [_okbutton setTitle:@"确定" forState:UIControlStateNormal];
    _okbutton.tintColor=[UIColor whiteColor];
    if(stockstring.intValue==0)
    {
        
        _okbutton.userInteractionEnabled=NO;
        _okbutton.alpha=0.4;
    }else{
        _okbutton.userInteractionEnabled=YES;
        _okbutton.alpha=1;
        
    }
    
    [_okbutton addTarget:self action:@selector(okbtn:) forControlEvents:UIControlEventTouchUpInside];
    [_modelview addSubview:_okbutton];
    
    //判断scrollview是否滑动
    
    if(modelscrollview.contentSize.height > modelscrollview.frame.size.height+20)
    {
        modelscrollview.scrollEnabled = YES;
    }else{
        modelscrollview.scrollEnabled = NO;
    }
    
}

#pragma mark 选择颜色
-(void)colorlick:(UIButton*)sender
{
    for(int i=0;i<self.colorArray.count;i++)
    {
        
        UIButton *button=(UIButton*)[_modelview viewWithTag:2000+i];
        CGFloat btnwith = CGRectGetHeight(button.frame);
        
        if(2000+i==sender.tag)
        {
            
            button.backgroundColor=tarbarrossred;
            button.tintColor=[UIColor whiteColor];
            button.layer.borderWidth=0;
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            if(btnwith == COLORBTN_WITH)
            {
                button.layer.borderWidth=1;
                button.layer.borderColor = bodyrossred.CGColor;
            }
            
            NSMutableDictionary *dic=self.stock_colorArray[i];
            _selectColorID =[dic objectForKey:self.colorArray[i]];
            
            _selectColor=button.titleLabel.text;
            //根据button tag 找button上的图片
            UIImageView *sendimg=(UIImageView*)[button viewWithTag:9990];
            //头像的图片更换成所点击button的图片
            UIImageView *titleimg=(UIImageView*)[_modelview viewWithTag:3579];
            
            titleimg.frame = CGRectMake(titleimg.frame.origin.x, titleimg.frame.origin.y, titleimg.frame.size.width, titleimg.frame.size.width);
            
            MyLog(@"sendimg.image = %@",sendimg.image);
            
            
            if(sendimg.image)
            {
                titleimg.image=sendimg.image;
                MyLog(@"************");
                
            } else{

                            
                NSURL *imgUrl;
                
                if(_ShopModel.def_pic)
                {
                    
                    NSMutableString *code = [NSMutableString stringWithString:_ShopModel.shop_code];
                    
                    NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
                    MyLog(@"supcode =%@",supcode);
                    
                    
                    imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@/%@!280",[NSObject baseURLStr_Upy],supcode,code,_ShopModel.def_pic]];
                }
               
                __block float d = 0;
                __block BOOL isDownlaod = NO;
                [_modelimage sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                    d = (float)receivedSize/expectedSize;
                    isDownlaod = YES;
                } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (image != nil && isDownlaod == YES) {
                        _modelimage.alpha = 0;
                        [UIView animateWithDuration:0.5 animations:^{
                            _modelimage.alpha = 1;
                        } completion:^(BOOL finished) {
                        }];
                    } else if (image != nil && isDownlaod == NO) {
                        _modelimage.image = image;
                    }
                }];
            }
            
            //查找商品颜色ID
            NSMutableDictionary *photodic=self.stock_colorArray[i];
            NSString *colorid=[photodic objectForKey:self.colorArray[i]];
            
            NSMutableArray *stockarr;
            if([self.typestring isEqualToString:@"兑换"])
            {
                stockarr=[NSMutableArray arrayWithArray:self.JifenshopArray];
            }else{
                stockarr=[NSMutableArray arrayWithArray:self.stocktypeArray];
            }
            
            //根据商品颜色ID匹配图片
            for(int k=0;k<stockarr.count;k++)
            {
                ShopDetailModel *model=stockarr[k];
                NSMutableString *color_sizestring=[NSMutableString stringWithString:model.color_size];
                NSArray *arr=[color_sizestring componentsSeparatedByString:@":"];
                if([arr[0] isEqualToString:colorid])
                {
                    //如果查找相同的ID就把图片匹配上去

                    
                    ShopDetailModel *model=stockarr[k];
                    
                    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
                    
                    if(model.pic !=nil)
                    {
                        [userdefaul setObject:model.pic forKey:SELECT_PHOTO];
                    }else{
                        [userdefaul setObject:_ShopModel.def_pic forKey:SELECT_PHOTO];
                    }
                    
                }
            }
            
            
            
        }else{
            
            button.backgroundColor=[UIColor clearColor];
            button.tintColor=kTextColor;
            button.layer.borderWidth=1;
            button.layer.borderColor=kbackgrayColor.CGColor;
            [button setTitleColor:kTextColor forState:UIControlStateNormal];
            
            if(btnwith == COLORBTN_WITH)
            {
                button.layer.borderWidth=0;
            }

        }
        
    }
    
    if(_selectColorID!=nil &&_selectSizeID!=nil)
    {
        
        [self changestock];
    }
    
}
#pragma mark 选择尺码
-(void)sizeclick:(UIButton*)sender
{
    for(int i=0;i<_sizeArr.count;i++)
    {
        
        UIButton *button=(UIButton*)[_modelview viewWithTag:1000+i];
        
        
        if(1000+i==sender.tag)
        {
            button.backgroundColor=tarbarrossred;
            button.tintColor=[UIColor whiteColor];
            button.layer.borderWidth=0;
            
            
            _selectSize=button.titleLabel.text;
            
            for(int j=0;j<self.stock_sizeArray.count;j++)
            {
                NSDictionary *dic =self.stock_sizeArray[j];
                NSString *str=[dic objectForKey:_sizeArr[i]];
                
                if(str.length>0)
                {
                    _selectSizeID=str;
                    break;
                }
            }
            
        }else{
            button.backgroundColor=[UIColor clearColor];
            button.tintColor=kTextColor;
            button.layer.borderWidth=1;
            button.layer.borderColor=kbackgrayColor.CGColor;
        }
    }
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    [userdefaul setObject:_ShopModel.def_pic forKey:SELECT_PHOTO];
    
    if(_selectColorID!=nil &&_selectSizeID!=nil)
    {
        
        [self changestock];
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
        
        NSMutableArray *stockarr;
        if([self.typestring isEqualToString:@"兑换"])
        {
            stockarr=[NSMutableArray arrayWithArray:self.JifenshopArray];
        }else{
            stockarr=[NSMutableArray arrayWithArray:self.stocktypeArray];
        }
        for(int i=0;i<stockarr.count;i++)
        {
            ShopDetailModel *model=stockarr[i];
            if([model.color_size isEqualToString:typeidString])
            {
                //商品名称
                UILabel *namelabel=(UILabel*)[_modelview viewWithTag:4321];
                namelabel.text = [self exchangeTextWihtString:_ShopModel.shop_name];
                _selectName=namelabel.text;
                
                //商品价格
                UILabel *pricelable=(UILabel*)[_modelview viewWithTag:8765];
                pricelable.text=[NSString stringWithFormat:@"￥%.1f",[model.shop_se_price floatValue]];
                pricelable.textColor=tarbarrossred;
                pricelable.font =[UIFont systemFontOfSize:15];
                _selectPrice=[NSString stringWithFormat:@"%.1f",[model.shop_se_price floatValue]];
                
                //商品库存
                UILabel *stocklable=(UILabel*)[_modelview viewWithTag:9876];
                stocklable.text=[NSString stringWithFormat:@"库存%@件",model.stock];
                stockstring=[NSString stringWithFormat:@"%@",model.stock];
                
                if(stockstring.intValue >0)
                {
                    UIButton *button=(UIButton*)[_modelview viewWithTag:9191];
                    button.userInteractionEnabled=YES;
                    button.alpha=1;
                    
                }else{
                    UIButton *button=(UIButton*)[_modelview viewWithTag:9191];
                    button.userInteractionEnabled=NO;
                    button.alpha=0.4;
                    
                }
            }
        }
        
    }
    
    return stockstring;
    
}

#pragma mark 数量减
-(void)reduce:(UIButton*)sender
{
    if(_numlable.text.intValue>1)
    {
        _numlable.text=[NSString stringWithFormat:@"%d",_numlable.text.intValue-1];
    }
}

-(void)addbtn:(UIButton*)sender
{
    NSString *stock=[self changestock];
    if(_numlable.text.intValue < stock.intValue)
    {
        _numlable.text=[NSString stringWithFormat:@"%d",_numlable.text.intValue+1];
    }else{
        
        [MBProgressHUD show:@"已是最大库存" icon:nil view:nil];
    }
}

- (void)creatModleData
{
    [self.dataArr removeAllObjects];
    [self.colorArray removeAllObjects];
    
    //获取供应商编号
    
    NSMutableString *code = [NSMutableString stringWithString:_ShopModel.shop_code];
    
    NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
    
    //详情数据源
    NSArray *array = [_ShopModel.shop_pic componentsSeparatedByString:@","];
    self.dataArr=[NSMutableArray arrayWithArray:array];
    
    NSMutableArray *imageArray=[NSMutableArray array];
    for(int i=0;i<self.dataArr.count;i++)
    {
        NSString *str =self.dataArr[i];
        
        if([str rangeOfString:@"realShot"].location !=NSNotFound)
        {
            continue;
        }
        if([str rangeOfString:@"reveal"].location !=NSNotFound ||
           [str rangeOfString:@"detail"].location !=NSNotFound ||
           [str rangeOfString:@"real"].location !=NSNotFound)//_roaldSearchText
        {
            
            //修改后的图片地址
            NSArray *comArr = [NSArray array];
            NSString *pubstr ;
            
            if([str rangeOfString:@"reveal"].location !=NSNotFound)
            {
                comArr = [str componentsSeparatedByString:@"reveal"];
                pubstr = @"reveal";
                
            }else if ([str rangeOfString:@"detail"].location !=NSNotFound)
            {
                comArr = [str componentsSeparatedByString:@"detail"];
                pubstr = @"detail";
                
            }else if ([str rangeOfString:@"real"].location !=NSNotFound){
                
                comArr = [str componentsSeparatedByString:@"real"];
                pubstr = @"real";
                
            }
            
            if(comArr.count > 0)
            {
                NSString *comstr = [NSString stringWithFormat:@"%@/%@/%@%@",supcode,_ShopModel.shop_code,pubstr,comArr[1]];
                
                MyLog(@"comstr =%@",comstr);
                
                [imageArray addObject:comstr];
            }
            
            
        }
        else
        {
            //no");
        }
        
    }
    
    
    self.dataArr = imageArray;
    
    MyLog(@"self.dataArr = %@",self.dataArr);
    
    [self.MyBigtableview reloadData];
    

    //尺码数据源 从数据库中查询
    NSMutableArray *sizearr=[NSMutableArray array];
    
    MyLog(@"11111self.sizeArray = %@",self.sizeArray);
    
    //按id从小到大排序
    for(int k=0;k<self.sizeArray.count;k++)
    {
        NSMutableArray *arr=[NSMutableArray arrayWithArray:[self.sizeArray[k] componentsSeparatedByString:@","]];
        MyLog(@"arr1 = %@",arr);
        
        NSComparator cmptr = ^(id obj1, id obj2){
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        };
        //排序后数组
        NSArray *afterarray = [arr sortedArrayUsingComparator:cmptr];
        
        MyLog(@"afterarray = %@",afterarray);
    }
    
    MyLog(@"self.sizeArray = %@",self.sizeArray);
    
    [self OpenDb];
    
    NSMutableString *newsizestring = [[NSMutableString alloc]init];
    
    for(int i=0;i<self.sizeArray.count;i++)
    {
        NSArray *arr=[self.sizeArray[i] componentsSeparatedByString:@","];
        MyLog(@"arr = %@",arr);
        if(arr.count)
        {
            
            NSString *str=[NSString stringWithFormat:@"%@",arr[0]];
            if([str isEqualToString:@"0"])//色
            {
                for(int j=1;j<arr.count;j++)
                {
                    for(NSDictionary *colordic in _dataDictionaryArray)
                    {
                        if(colordic)
                        {
                            if([colordic[@"id"] isEqualToString:arr[j]])
                            {
                            
                                NSMutableDictionary *dic =[NSMutableDictionary dictionary];
                                
                                NSString *addressField = colordic[@"attr_name"];
                                
                                MyLog(@"addressField = %@",addressField);
                                
                                [dic setObject:arr[j] forKey:addressField];
                                
                                [self.stock_colorArray addObject:dic];
                                
                                [self.colorArray addObject:addressField];
                            }
                        
                        }
                    }
                    
                    
                    
                }
                
            }
            
            
            if([str isEqualToString:@"501"])//尺码
            {
                if(sizearr.count)
                {
                    [sizearr removeAllObjects];
                    
                    [newsizestring appendString:@";"];
                    
                }
                
                for(int j=1;j<arr.count;j++)
                {
                    MyLog(@"str******* = %@",arr[j]);
                    
                    for(NSDictionary *sizedic in _dataDictionaryArray)
                    {
                        if(sizedic)
                        {
                            if([sizedic[@"id"] isEqualToString:arr[j]])
                            {
                                
                                NSString *addressField = sizedic[@"attr_name"];
                                
                                NSMutableDictionary *dic =[NSMutableDictionary dictionary];
                                [dic setObject:arr[j] forKey:addressField];
                                
                                [self.stock_sizeArray addObject:dic];
                                
                                MyLog(@"addressField = %@",addressField);
                                
                                [newsizestring appendString:addressField];
                                [newsizestring appendString:@","];
                                [sizearr addObject:addressField];

                            }
                            
                        }
                    }
                    
                }
                
                
            }else{
                
            }
            
        }
        
        MyLog(@"_sizestring= %@",newsizestring);
        if(newsizestring.length>0)
        {
            NSArray *brr=[newsizestring componentsSeparatedByString:@";"];
            _SizeArray =[NSMutableArray arrayWithArray:brr];
            self.SizeDataArray=[NSMutableArray arrayWithArray:brr];
        }
        
    }
    
    NSMutableArray *textsizeArray = [NSMutableArray array];
    NSMutableArray *dataArr=[NSMutableArray array];
    for (int j=0;j<_SizeArray.count;j++) {
        
        NSMutableString *ss=[NSMutableString stringWithString:_SizeArray[j]];
        
        NSArray *brr=[ss componentsSeparatedByString:@","];
        NSMutableArray *size=[NSMutableArray arrayWithArray:brr];
        
        
        if(size.count>5)
        {
            for(int i=0;i<4;i++)
            {
                [size removeObjectAtIndex:1];
            }
            
            [dataArr addObject:size];
            
        }else{
            
            for(int i =0;i<size.count;i++)
            {
                [size removeObjectAtIndex:1];
            }
            
            [dataArr addObject:size];
        }
        
    }
    
    MyLog(@"self.stock_colorArray=%@",self.stock_colorArray);

    for(NSArray *arr in dataArr)
    {
        NSMutableString *sss=[NSMutableString string];
        for(int j=0 ;j<arr.count;j++)
        {
            [sss appendString:arr[j]];
            [sss appendString:@","];
        }
        [textsizeArray addObject:sss];
    }
    
    for (int j=0;j<_SizeArray.count;j++) {
        
        NSMutableString *ss=[NSMutableString stringWithString:_SizeArray[j]];
        
        NSString *cccc ;
        if(ss.length>1)
        {
            cccc = [ss substringToIndex:[ss length] - 1];
        }
        
        NSArray *brr=[cccc componentsSeparatedByString:@","];
        NSMutableArray *size=[NSMutableArray arrayWithArray:brr];
        
        
        if(size.count > 5)
        {
            if(textsizeArray.count)
            {
                for(NSString *str in textsizeArray)
                {
                    [self.SizeDataArray addObject:str];
                }
                
            }
            
            return;
        }
        
        MyLog(@"self.SizeDataArray = %@",self.SizeDataArray);
    }
    
    
}
- (void)getImg:(UIImage *)img withIndex:(int)index
{
    //下载一张显示一张
    dispatch_sync(dispatch_get_main_queue(), ^{ // 主线程刷新UI
        
        
        if(img)
        {
            self.ImageArray[index]=img;
            
            CGSize size=img.size;
            
            if(size.width>0 &&  size.height>0)
            {
                
                
                CGFloat proportion=1;
                
                proportion=size.height/size.width;
                
                int Imageheigh;
                
                if (proportion !=0) {
                    
                    Imageheigh=kApplicationWidth*proportion;
                }else{
                    Imageheigh=300;
                }
                
                
                if(Imageheigh)
                {
                    
                    [self.ImageHeighArray replaceObjectAtIndex:index withObject:[NSString stringWithFormat:@"%d",Imageheigh]];
                }
                
                [self.MyBigtableview reloadData];
                
            }
            
            
        }
        
        
    });
}


#pragma mark *********************TableViewDelegate**********************
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView!=self.searchTableView) {
        return 1;
    } else
        return self.searchDataArr.count;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView!=self.searchTableView) {
        return _headView;
    } else {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 25)];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = RGBCOLOR_I(167,167,167);
        label.backgroundColor = RGBCOLOR_I(22,22,22);
        label.font = kFont6px(32);
        if (self.searchCateArr.count>section) {
            NSDictionary *tmpdic = self.searchCateArr[section];
            label.text = [NSString stringWithFormat:@"    %@",tmpdic[@"name"]];
        }
        return label;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView!=self.searchTableView) {
        if(self.slectbtn.tag==1002)
        {
            return self.dataArr.count;
        
        }else if (self.slectbtn.tag==1001)
        {
            
            return _participateArray.count+1;
            
        }else{
            
            return self.ruleDataArray.count+1;
        }
    } else
        return [self.searchDataArr[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView!=self.searchTableView) {
        return 40;
    } else
        return ZOOM(80);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView!=self.searchTableView) {
    
        if(self.slectbtn.tag==1002)
        {
            return kZoom6pt(120);
        }
        else if (self.slectbtn.tag==1001)
        {
            if(indexPath.row == 0)
            {
                return ZOOM6(70);
            }else if (indexPath.row > 0)
            {
                return 60;
            }
            return 0;
        }
        else
        {
            CGFloat heigh = 0;
            if(indexPath.row == 0)
            {
                heigh = ZOOM6(120);
            }else{
                heigh = [self getRullRowHeight:self.ruleDataArray[indexPath.row-1] fontSize:ZOOM6(30)]+10;
            }
            return heigh;
        }
    } else
        return ZOOM(150);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView!=self.searchTableView) {
        if(self.slectbtn.tag == 1002)
        {
            TreasureRecordsModel *model = self.dataArr[indexPath.row];
            if ([model.status intValue] == 2) {
                return;
            }
            
            OneIndianaDetailViewController *shopdetail=[[OneIndianaDetailViewController alloc]init];
            shopdetail.shop_code= model.shop_code;
            shopdetail.recordsModel = model;
            [self.navigationController pushViewController:shopdetail animated:YES];
        }
    } else {
        NSDictionary *dic = [self.searchDataArr[indexPath.section] objectAtIndex:indexPath.row];
        
        NSString *ID = dic[@"id"];
        //ID = %@",ID);
        NSString *title = dic[@"name"];
        //title = %@",title);
        
        TFSearchViewController *svc = [[TFSearchViewController alloc] init];
        svc.parentID = ID;
        svc.shopTitle = title;
        svc.typeName = self.typeName;
        svc.typeID = self.typeID;
        svc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:svc animated:YES];
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view bringSubviewToFront:self.screenBtn];
    
    if (tableView!=self.searchTableView) {
        if(self.slectbtn.tag==1002)
        {
            self.MyBigtableview.separatorStyle = UITableViewCellSelectionStyleNone;
            AgoAnnounceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AgoAnnounceCellID"];
            cell.indexPath = indexPath;
            if(self.dataArr)
            {
                cell.model = self.dataArr[indexPath.row];
            }
            return cell;
        }else if (self.slectbtn.tag==1001)
        {
            self.MyBigtableview.separatorStyle = UITableViewCellSelectionStyleNone;
            if(indexPath.row ==0 )
            {
                UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"tabCell"];
                if(!cell)
                {
                    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"tabCell"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    UILabel *titlelable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, ZOOM6(240), ZOOM6(70))];
                    titlelable.tag = 8899;
                    titlelable.text = @"所有参与记录";
                    titlelable.numberOfLines = 0;
                    titlelable.font = [UIFont systemFontOfSize:ZOOM(43)];
                    titlelable.textColor = kTextColor;
                    [cell.contentView addSubview:titlelable];
                    
                    UILabel *timelable = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-ZOOM6(400)-10, 0, ZOOM6(400), ZOOM6(70))];
                    timelable.tag = 8898;
                    timelable.numberOfLines = 0;
                    timelable.font = [UIFont systemFontOfSize:ZOOM(41)];
                    timelable.textColor = kTextColor;
                    timelable.textAlignment = NSTextAlignmentRight;
                    [cell.contentView addSubview:timelable];
                    
                    UILabel *lableline = [[UILabel alloc]initWithFrame:CGRectMake(0, 34, kScreenWidth, 0.5)];
                    lableline.tag = 8897;
                    lableline.backgroundColor = kBackgroundColor;
                    [cell.contentView addSubview:lableline];
                    
                }
                
                UILabel *timelable = [cell viewWithTag:8898];
                NSString *starttime = [MyMD5 getTimeToShowWithTimestampSecond:_ShopModel.active_start_time];
                timelable.text = [NSString stringWithFormat:@"%@开始",starttime];
                return cell;
                
            }else if(indexPath.row > 0) {
                RecordTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"recordCell"];
                if(!cell)
                {
                    cell=[[RecordTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"recordCell"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if(_participateArray >0)
                {
                    participateModel *model = _participateArray[indexPath.row-1];
                    [cell refreshData:model];
                }
                return cell;
            }
            
            return nil;
            
        } else if(self.slectbtn.tag == 1000)
        {
            self.MyBigtableview.separatorStyle = UITableViewCellSelectionStyleNone;
            
            if(indexPath.row == 0)
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                if(!cell)
                {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
                }
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

                CGFloat imageHeigh = IMAGEH(@"indiana_抽奖规则");
                CGFloat imageWidth = IMAGEW(@"indiana_抽奖规则");
                UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-imageWidth)/2, (ZOOM6(120)-imageHeigh)/2, imageWidth, imageHeigh)];
                imageview.clipsToBounds = YES;
                imageview.contentMode = UIViewContentModeScaleAspectFit;
                imageview.image = [UIImage imageNamed:@"indiana_抽奖规则"];

                [cell.contentView addSubview:imageview];
                
                return cell;
                //                [imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@duobao/huodongguize.png",[NSObject baseURLStr_Upy]]]];
            }else{
                
                IndianaRuleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RULECELL"];
                if(!cell)
                {
                    cell = [[IndianaRuleTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"RULEcell"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.headLab.text = [NSString stringWithFormat:@"%d、",(int)indexPath.row];
                cell.headLab.textColor = tarbarrossred;
                [cell.headLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(28)]];
                
                cell.titleLab.text = self.ruleDataArray[indexPath.row-1];
                cell.titleLab.textColor = RGBCOLOR_I(125, 125, 125);
                cell.titleLab.font = [UIFont systemFontOfSize:ZOOM6(30)];
                cell.titleLab.numberOfLines = 0;
                return cell;
            }
            
            return nil;
        }
        
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELLID"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELLID"];
            cell.backgroundColor = RGBCOLOR_I(22,22,22);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(ZOOM(62), (CGRectGetHeight(cell.frame)-ZOOM(100))/2, ZOOM(67), ZOOM(100))];
            iv.tag = 500;
            //        iv.contentMode = UIViewContentModeScaleAspectFit;
            [cell.contentView addSubview:iv];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(iv.frame.origin.x+iv.frame.size.width+ZOOM(62), 0, ZOOM(300), CGRectGetHeight(cell.frame))];
            titleLabel.tag = 501;
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.font = kFont6px(34);
            [cell.contentView addSubview:titleLabel];
            
            UIImageView *iiv = [[UIImageView alloc] initWithFrame:CGRectMake(tableView.frame.size.width-ZOOM(62)-ZOOM(27), (CGRectGetHeight(cell.frame)-ZOOM(55))/2, ZOOM(27), ZOOM(55))];
            iiv.image = [UIImage imageNamed:@"搜索更多"];
            iiv.contentMode = UIViewContentModeScaleAspectFit;
            [cell.contentView addSubview:iiv];
        }
        UIImageView *iv = (UIImageView *)[cell.contentView viewWithTag:500];
        UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:501];
        NSDictionary *dic = [self.searchDataArr[indexPath.section] objectAtIndex:indexPath.row];
        //    iv.image = [UIImage imageNamed:dic[@"name"]];
        
        [iv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy], dic[@"ico"]]]];
        
        titleLabel.text = dic[@"name"];
        return cell;
        
    }
    
    return 0;
}

#pragma mark 点击商品图片缩放效果
- (void)scaleView:(NSMutableArray*)imgViewArr
{
    self.imgFullScrollView = [[FullScreenScrollView alloc] initWithPicutreArray:imgViewArr withCurrentPage:1];
    
    self.imgFullScrollView.backgroundColor = kBackgroundColor;
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight-ZOOM(150)+20, kApplicationWidth, ZOOM(150))];
    
    footView.backgroundColor = [UIColor whiteColor];
    [self.imgFullScrollView addSubview:footView];
    
    NSString *str = @"立即参与";
    NSArray *titleArray = @[str];
    for (int i=0; i<titleArray.count; i++) {
        UIButton *imgbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        imgbtn.frame = CGRectMake((kApplicationWidth-ZOOM(100*3.4))/2, (CGRectGetHeight(footView.frame)-ZOOM(120))*0.5, ZOOM(100*3.4), ZOOM(120));
        imgbtn.tag = 5858+i;
    
        imgbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(57)];
        imgbtn.tintColor = [UIColor whiteColor];
        imgbtn.backgroundColor = tarbarrossred;
        [imgbtn setTitle:titleArray[i] forState:UIControlStateNormal];
        
        if(_oweStatues.intValue == 3 )
        {
            [imgbtn setTitle:@"已结束" forState:UIControlStateNormal];
            imgbtn.backgroundColor = kbackgrayColor;
//            imgbtn.enabled = NO;
        }else if(_oweStatues.intValue == 4 )
        {
            [imgbtn setTitle:@"正在开奖" forState:UIControlStateNormal];
            
        }else if (_myself_incode !=nil)
        {
            [imgbtn setTitle:@"再次参与" forState:UIControlStateNormal];
//            imgbtn.backgroundColor = kbackgrayColor;
//            imgbtn.enabled = NO;
        }

        [imgbtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:imgbtn];
        
    }
    
    self.imgFullScrollView.alpha = 0;
    
    [self.view addSubview:self.imgFullScrollView];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.imgFullScrollView.frame=CGRectMake(0,0, kApplicationWidth,kApplicationHeight+kUnderStatusBarStartY);
        
        self.imgFullScrollView.alpha=1;
        
    } completion:^(BOOL finished) {
        
    }];

}

- (UIView*)creatTagView
{
    UIView *tagView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 0)];
    
    UIView *titleview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 30)];
    [tagView addSubview:titleview];
    
    UIImageView *tagimage = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM(50), 0, 20, 20)];
    tagimage.image = [UIImage imageNamed:@"sale-tag"];
    [tagView addSubview:tagimage];
    
    UILabel *taglable =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(tagimage.frame)+10, ZOOM(20), 80, 20)];
    taglable.text = @"商品标签";
    [tagView addSubview:taglable];
    
    NSMutableString *tagstring;
    if(_ShopModel.shop_tag !=nil)
    {
        tagstring = [NSMutableString stringWithString:_ShopModel.shop_tag];
    }
    NSArray *tagArray = [tagstring componentsSeparatedByString:@","];
    
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 0)];
    [tagView addSubview:backview];
    
    
    UIButton *colorbtn;
    
    int xx =0;
    int yy =0;
    CGFloat btnwidh=(kApplicationWidth-(30+(ZOOM(50)*2)))/4;
    CGFloat heigh = 30;
    
    CGFloat titleViewYY = CGRectGetMaxY(taglable.frame);
    
    MyLog(@"tagArray=%@",tagArray);
    
    //通过ID查询名称
    NSArray *nameArr = [self hoboFindDataForTAGDB:tagArray];
    
    MyLog(@"nameArr = %@",nameArr);
    
    //将_IDArray里面的sequence按从小到大排序
    NSComparator cmptr = ^(id obj1, id obj2){
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    //排序后数组
    NSArray *afterarray = @[@"1",@"8,9,10,11",@"4",@"7",@"5",@"2",@"3",@"6",@"12",@"13,14,15"];

    NSMutableArray *titlenameArray = [NSMutableArray array];
    for(int j =0;j<afterarray.count;j++)
    {
        for(NSDictionary *dic in _sequenceArray)
        {
            NSMutableString *sequenceid = [NSMutableString stringWithString:afterarray[j]];
            
            NSArray *sequenceArr =[NSArray array];
            if(sequenceid)
            {
                sequenceArr =[sequenceid componentsSeparatedByString:@","];
            }
            MyLog(@"sequenceArr=%@",sequenceArr);
            
            for(int k =0 ;k<sequenceArr.count;k++)
            {
                NSString *title = [dic objectForKey:sequenceArr[k]];
                if(title !=nil)
                {
                    [titlenameArray addObject:title];
                    break;
                }
            }
        }
        
    }
    
    MyLog(@"titlenameArray=%@",titlenameArray);
    
    for(int j=0;j<titlenameArray.count;j++)
    {
        
        xx = j%4;
        yy = j/4;
        
        colorbtn=[[UIButton alloc]init];
        
        colorbtn.frame=CGRectMake(ZOOM(50)+(btnwidh+10)*xx, titleViewYY+15+(heigh+10)*yy, btnwidh, heigh);
        
        [colorbtn setTitle:titlenameArray[j] forState:UIControlStateNormal];
        
        colorbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(46)];
        [colorbtn setTitleColor:tarbarrossred forState:UIControlStateNormal];
        
        colorbtn.layer.borderWidth=0.5;
        colorbtn.layer.borderColor=tarbarrossred.CGColor;
        colorbtn.tintColor=tarbarrossred;
        colorbtn.layer.cornerRadius = 5;
        colorbtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM(46)];
        
        [backview addSubview:colorbtn];
    }
    
    
    backview.frame=CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(colorbtn.frame));

    tagView.frame = CGRectMake(0, 5, kApplicationWidth, backview.frame.size.height);
    
    
    return tagView;
}

#pragma mark 点击评论图片
-(void)imageclick:(UITapGestureRecognizer*)tap
{
    //创建底视图
    UIView *photoview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight+kUnderStatusBarStartY)];
    photoview.tag=8888;
    photoview.backgroundColor=[UIColor blackColor];
    
    //获得图片数据源
    CommenModel *model= self.commentDataArray[tap.view.tag/10000-1];
    NSArray *imageArray=[model.pic componentsSeparatedByString:@","];
    
    //图片加在photoscrollview上
    self.photoscrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, (kApplicationHeight-300)/2, kApplicationWidth, 300)];
    self.photoscrollview.pagingEnabled=YES;
    self.photoscrollview.delegate=self;
    self.photoscrollview.contentSize=CGSizeMake(imageArray.count*kApplicationWidth, 0);
    
    if(kScreenWidth==320)
    {
        _pageview=[[UIPageControl alloc]initWithFrame:CGRectMake(0, kScreenHeight-30, kScreenWidth, 25)];
    }else{
        _pageview=[[UIPageControl alloc]initWithFrame:CGRectMake(0, kScreenHeight-40, kScreenWidth-50, 25)];
    }
    _pageview.numberOfPages=imageArray.count;
    _pageview.currentPage=tap.view.tag%10000;
    _pageview.userInteractionEnabled = NO;
    [photoview addSubview:_pageview];
    
    self.photoscrollview.contentOffset=CGPointMake(_pageview.currentPage*kApplicationWidth, 0);
    
    
    for(int i=0;i<imageArray.count;i++)
    {
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(kApplicationWidth*i, 0, kApplicationWidth, 300)];
        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PHOTOhttp,imageArray[i]]]];
        image.tag=111+i;
        [self.photoscrollview addSubview:image];
        
        UITapGestureRecognizer *imagetap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(commonimgClick:)];
        [image addGestureRecognizer:imagetap];
        image.userInteractionEnabled=YES;
    }
    
    [photoview addSubview:self.photoscrollview];
    [self.view addSubview:photoview];
    
    //    将当前view放到首层
    [self.view bringSubviewToFront:photoview];
    
    
}

-(void)commonimgClick:(UITapGestureRecognizer*)imagetap
{
    UIView *view=(UIView*)[self.view viewWithTag:8888];
    
    [UIView animateWithDuration:0.5 animations:^{
        [view removeFromSuperview];
        
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView!=self.searchTableView) {

        if(scrollView==self.MyBigtableview)
        {
            //让导航条渐变色
            UIImageView *headview=(UIImageView*)[self.view viewWithTag:3838];

            if(scrollView.contentOffset.y > 50 ){
            
                
                [_backbtn setImage:[UIImage imageNamed:@"icon_fanhui_black"] forState:UIControlStateNormal];
                
                _siimage.image = [UIImage imageNamed:@"icon_fenxiang_black"];
                _shopimage.image = [UIImage imageNamed:@"icon_gouwuche_black"];
                
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
                _currentStatusBarStyle = UIStatusBarStyleDefault;
                
                headview.image = [UIImage imageNamed:@""];
                headview.backgroundColor = [UIColor whiteColor];
                headview.alpha = scrollView.contentOffset.y/ZOOM(450*3.4);
                
               
            }else{
                
                [_backbtn setImage:[UIImage imageNamed:@"icon_fanhui"] forState:UIControlStateNormal];
                
                _siimage.image = [UIImage imageNamed:@"icon_fenxiang"];
                _shopimage.image = [UIImage imageNamed:@"icon_gouwuche"];
                
                 [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
                _currentStatusBarStyle = UIStatusBarStyleLightContent;
                headview.backgroundColor = [UIColor clearColor];
                headview.image = [UIImage imageNamed:@"zhezhao"];
                
                [UIView animateWithDuration:1.0 animations:^{
                    
                    headview.alpha = 1;
                    
                   
                } completion:^(BOOL finished) {
                    
                    
                }];
            }
            
            //sectionview顶置
            CGFloat sectionHeaderHeight = Height_NavBar;
            if (scrollView.contentOffset.y<=sectionHeaderHeight && scrollView.contentOffset.y>=0) {
                scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
            }
            else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
                scrollView.contentInset = UIEdgeInsetsMake(sectionHeaderHeight, 0, 0, 0);
            }
            
            
        }
        
        
        
#pragma mark scrollview滑动到 3000 _UpBtn显示
        
        //scrollview滑动一半
        CGPoint contentOffsetPoint = self.MyBigtableview.contentOffset;
        if (contentOffsetPoint.y == 3000  || contentOffsetPoint.y > 3000 ) {
            
            [_UpBtn setHidden:NO];
            
        }else{
            
            [_UpBtn setHidden:YES];
            
        }
        
//        CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
        
        UIView *footview = (UIView *)[self.view viewWithTag:8181];
        footview.clipsToBounds =YES;
        footview.userInteractionEnabled=YES;
        
//        //上滑隐藏footview 下滑显示
//        if(translation.y>0)
//        {
//            
//            [UIView animateWithDuration:0.3 animations:^{
//                
//                footview.frame=CGRectMake(0, kApplicationHeight-50+kUnderStatusBarStartY, kApplicationWidth, 50);
//                
//            } completion:^(BOOL finished) {
//                
//                
//            }];
//            
//        }else if(translation.y<0){
//            
//            [UIView animateWithDuration:0.3 animations:^{
//                
//                footview.frame=CGRectMake(0, kApplicationHeight+30, kApplicationWidth, footview.frame.size.height);
//                
//            } completion:^(BOOL finished) {
//                
//                
//            }];
//            
//            
//        }else{
//            
//            footview.hidden=NO;
//        
//        }
        
    }
}

#pragma mark 夺宝规则 参与记录 图文详情
-(void)butclick:(UIButton*)sender
{

    [self.view bringSubviewToFront:self.screenBtn];
    
    if (_btnTag == sender.tag) return ;
    _btnTag = sender.tag;

    
    UIView *view=(UIView*)[self.view viewWithTag:9876];
    
    if(view)
    {
        [view removeFromSuperview];
        
        for(UIView *vv in view.subviews)
        {
            [vv removeFromSuperview];
        }
    }
    
    UIView *view1=(UIView*)[self.view viewWithTag:8766];
    
    if(view1)
    {
        [view1 removeFromSuperview];
        
        for(UIView *vv in view1.subviews)
        {
            [vv removeFromSuperview];
        }
    }
    
    UIView *view2=(UIView*)[self.view viewWithTag:8761];
    
    if(view2)
    {
        [view2 removeFromSuperview];
        
        for(UIView *vv in view2.subviews)
        {
            [vv removeFromSuperview];
        }
    }
    
    UIView *footview =(UIView*)[self.view viewWithTag:8181];
    footview.hidden = NO;
    
    for(int i=0;i<3;i++)
    {
        UIButton *btn=(UIButton*)[self.view viewWithTag:1000+i];
        UILabel *lable=(UILabel*)[self.view viewWithTag:2000+i];
        if(i+1000==sender.tag)
        {
            [btn setTitleColor:tarbarrossred forState:UIControlStateNormal];
            btn.backgroundColor=[UIColor clearColor];
            
            if(i==2)
            {
                [self.MyBigtableview removeFooter];
                kWeakSelf(self);
                [self.MyBigtableview addFooterWithCallback:^{
                    weakself.httpPage++;
                    [weakself httpGetOthers];
                }];

                
            }else if (i==1)
            {
                kWeakSelf(self);
                [self.MyBigtableview addFooterWithCallback:^{
                    _pagecount++;
                    [weakself indianaHttp];
                }];

            }else if (i==0)
            {
                
            }
            
        }else{
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            lable.backgroundColor=[UIColor clearColor];
        }
        
    }
    
    self.slectbtn.selected=NO;
    sender.selected=YES;
    self.slectbtn=sender;
    self.MyBigtableview.tableFooterView=_tableFootView;
    CGFloat viewHeigh = kIOSVersions >= 11 ? -20 :0;
    //加footview
    if(self.slectbtn.tag==1002)
    {
        self.MyBigtableview.frame = CGRectMake(0, viewHeigh, kApplicationWidth, kApplicationHeight+kUnderStatusBarStartY-55-viewHeigh);
        self.MyBigtableview.tableFooterView=_tableFootView;
    }
    else if (self.slectbtn.tag==1001)
    {
        CGFloat spaceHeigh = 0;
        
        CGFloat heigh = ZOOM6(100)*self.participateArray.count;
        CGFloat normalHeigh = kApplicationHeight-Height_NavBar-kUnderStatusBarStartY-55;
        if(heigh < normalHeigh)
        {
            spaceHeigh = normalHeigh-heigh;
        }else if (self.participateArray.count >=300)
        {
            spaceHeigh = ZOOM6(100);
        }
        
        _footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, spaceHeigh)];
        
        self.MyBigtableview.frame = CGRectMake(0, viewHeigh, kApplicationWidth, kApplicationHeight+kUnderStatusBarStartY-55-viewHeigh);
        self.MyBigtableview.tableFooterView= self.participateArray.count >=300?[self participateFootview]:_footView;
        
    }else{
        
        _footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, ZOOM6(200))];
        self.MyBigtableview.frame = CGRectMake(0, viewHeigh, kApplicationWidth, kApplicationHeight+kUnderStatusBarStartY-55-viewHeigh);
        self.MyBigtableview.tableFooterView= _footView;
    }
    
    CGFloat temH = self.MyBigtableview.tableHeaderView.frame.size.height;
    
    self.MyBigtableview.contentOffset = CGPointMake(0, temH - 40 - 30 + 8);
    
    [self.MyBigtableview reloadData];
}
- (UIView*)participateFootview
{
    if(_participateFootview == nil)
    {
        _participateFootview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(100))];
        
        UILabel *linelable = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(150), ZOOM6(50), kScreenWidth-ZOOM6(300), 1)];
        linelable.backgroundColor = RGBCOLOR_I(62, 62, 62);
        
        UILabel *textlable = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(200), 0, kScreenWidth-ZOOM6(400), CGRectGetHeight(_participateFootview.frame))];
        textlable.backgroundColor = [UIColor whiteColor];
        textlable.textAlignment = NSTextAlignmentCenter;
        textlable.font = [UIFont systemFontOfSize:ZOOM6(26)];
        textlable.textColor = RGBCOLOR_I(62, 62, 62);
        textlable.text = @"只显示最新300条记录哦~";
        
        [_participateFootview addSubview:linelable];
        [_participateFootview addSubview:textlable];
    }
    return _participateFootview;
}

#pragma mark 购物车 联系卖家
-(void)shopClick:(UIButton*)sender
{
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *token = [userdefaul objectForKey:USER_TOKEN];
    
    if(token == nil)
    {
        [self ToLoginView];
        
        return;
    }

    MyLog(@"联系卖家");
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString* suppid = [user objectForKey:PTEID];
    
//    NSString *suppid=[NSString stringWithFormat:@"%@",@"915"];
    
    [self Message:suppid];
    
}

#pragma mark 聊天
-(void)Message:(NSString*)suppid
{
    ContactKefuViewController *contact = [[ContactKefuViewController alloc]init];
    contact.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:contact animated:YES];
}


#pragma mark  立即参与夺宝
-(void)contactClick:(UIButton*)sender
{
    if(_oweStatues.intValue == 3)
    {
        [MBProgressHUD show:@"当期活动已结束，请留意下期哦~" icon:nil view:nil];
        return;
    }else if (_oweStatues.intValue == 4)
    {
        [MBProgressHUD show:@"档期活动已结束，正在开奖，请稍后再来。" icon:nil view:nil];
        return;
    }

    //埋点
    [YFShareModel getShareModelWithKey:@"duobao" type:StatisticalTypeIndianaMustParticipate tabType:StatisticalTabTypeIndiana success:nil];
    
    [self creatIndianaPopView];
}

- (void)togoAffirm:(NSString*)se_price Num:(NSString*)num ReductionPrice:(NSString*)ReductionPrice
{
    AffirmOrderViewController *affirm=[[AffirmOrderViewController alloc]init];
    affirm.affirmType=IndianaType;
    
    _ShopModel.shop_num = @"1";

    //何波修改2017-6-30
    affirm.selectPrice = se_price;
    affirm.shareReductionPrice = ReductionPrice;
    _ShopModel.shop_num = num;
//    _ShopModel.shop_se_price = se_price;
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:_ShopModel];
    
    UIImageView *headimg=(UIImageView*)[_modelview viewWithTag:3579];
    affirm.headimage.image=headimg.image;
    
    UILabel *pricelable=(UILabel*)[_modelview viewWithTag:8765];
    affirm.price=pricelable.text;
    affirm.order_code=self.order_code;
    affirm.shopmodel=_ShopModel;
    affirm.color=_selectColor;
    affirm.size=_selectSize;
    affirm.number=_ShopModel.shop_num;
    affirm.selectName=_selectName;
    affirm.selectPrice=_ShopModel.shop_se_price;
    affirm.selectColorID=[NSString stringWithFormat:@"%@",_selectColorID];
    affirm.selectSizeID=[NSString stringWithFormat:@"%@",_selectSizeID];
    affirm.stocktypeArray=self.stocktypeArray;
    affirm.JifenshopArray=self.JifenshopArray;
    affirm.four_pic=_ShopModel.four_pic;

    
    [self.navigationController pushViewController:affirm animated:YES];
}


//差掉模态视图
-(void)deletebtn:(UIButton *)sender
{
    [UIView animateWithDuration:0.1 animations:^{
        
        _modelview.frame=CGRectMake(0, kApplicationHeight+100, kApplicationWidth, kApplicationHeight-180);
        
    } completion:^(BOOL finished) {
        
        
    }];
}

#pragma mark 确定 是加入购物车还是购买
-(void)okbtn:(UIButton*)sender
{
    
    if (self.tag==3001 || self.tag == 5858)//加入购物车
    {
        _okbutton.enabled = NO;
        //加入购物车动画
                
        UIImageView *imageView=[[UIImageView alloc]init];
        if(_modelimage.image !=nil)
        {
            imageView.image = _modelimage.image;
        }else{
            imageView.image = [UIImage imageNamed:@"16 logo"];
        }
        imageView.contentMode=UIViewContentModeScaleToFill;
        imageView.frame=CGRectMake(0, 0, 20, 20);
        imageView.layer.masksToBounds=YES;
        imageView.userInteractionEnabled=YES;
//        imageView.layer.cornerRadius=10;
        imageView.hidden=NO;
        imageView.tag=7000;
        
        
        
        //        [imageView bringSubviewToFront:self.view];
        
        CGPoint point=CGPointMake(40, 20);
        imageView.center=point;
        _layer=[[CALayer alloc]init];
        _layer.contents=imageView.layer.contents;
        _layer.frame=imageView.frame;
        _layer.opacity=1;
        _layer.masksToBounds=YES;
//        _layer.cornerRadius=10;
        [_modelview.layer addSublayer:_layer];
        
        
        CGFloat YY=0;
        
        if(FourAndSevenInch || FiveAndFiveInch)
        {
            YY=300;
        }else if(FourInch){
            YY=200;
        }else{
            YY=110;
        }
        
        CGPoint point1=CGPointMake(0, -YY+15);
        
        
        UIView *hideview=[[UIView alloc]init];
        CGRect rect=_sharebtn.frame;
        rect.origin.x=_sharebtn.frame.origin.x+70;
        hideview.backgroundColor=[UIColor clearColor];
        hideview.frame=rect;
        [self.view addSubview:hideview];
        
        
        //动画 终点 都以sel.view为参考系
        CGPoint endpoint=[self.view convertPoint:point1 fromView:_shopcartbtn];
        UIBezierPath *path=[UIBezierPath bezierPath];
        
        //动画起点
        CGPoint startPoint=[_modelview convertPoint:point fromView:_modelimage];
        [path moveToPoint:startPoint];
        //贝塞尔曲线中间点
        float sx=startPoint.x;
        float sy=startPoint.y;
        float ex=endpoint.x;
        float ey=endpoint.y;
        float x=sx+(ex-sx)/3;
        float y=sy+(ey-sy)*0.5-200;
        CGPoint centerPoint=CGPointMake(x,y);
        [path addQuadCurveToPoint:endpoint controlPoint:centerPoint];
        
        CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
        animation.path = path.CGPath;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.duration=0.5;
        animation.delegate=self;
        animation.autoreverses= NO;
        animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [_layer addAnimation:animation forKey:@"buy"];
        
        
        
//        NSTimer *timer=[NSTimer weakTimerWithTimeInterval:0.5 target:self selector:@selector(request:) userInfo:nil repeats:NO];
        
        
    }else{//购买或者是积分兑换
        
        [MobClick event:SHOP_QUEDING];
        
        [self dismissSemiModalView];
        
        AdressModel *model;
        if(self.DeliverArray.count)
        {
            model=self.DeliverArray[0];
        }
        //%@",_ShopModel.original_price);
        AffirmOrderViewController *affirm=[[AffirmOrderViewController alloc]init];
        
        
        NSMutableString *typeidString=[NSMutableString string];
        [typeidString appendString:_selectColorID];
        [typeidString appendString:@":"];
        [typeidString appendString:_selectSizeID];
        
        //查找商品库存分类id
        for(int i=0;i<self.stocktypeArray.count;i++)
        {
            ShopDetailModel *model=self.stocktypeArray[i];
            if([model.color_size isEqualToString:typeidString])
            {
                _ShopModel.stock_type_id=model.stock_type_id;
                _ShopModel.original_price=model.original_price;
            }
        }
        
        _ShopModel.shop_num = _numlable.text;
        _ShopModel.shop_color = _selectColor;
        _ShopModel.shop_size = _selectSize;
        
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:_ShopModel];
       
        UIImageView *headimg=(UIImageView*)[_modelview viewWithTag:3579];
        affirm.headimage.image=headimg.image;
        
        UILabel *pricelable=(UILabel*)[_modelview viewWithTag:8765];
        affirm.price=pricelable.text;
        affirm.order_code=self.order_code;
        if([self.typestring isEqualToString:@"兑换"])
        {
            affirm.typestring=@"兑换";
        }
        affirm.addressmodel=model;
        affirm.shopmodel=_ShopModel;
        affirm.color=_selectColor;
        affirm.size=_selectSize;
        affirm.number=_numlable.text;
        affirm.selectName=_selectName;
        affirm.selectPrice=_selectPrice;
        affirm.selectColorID=[NSString stringWithFormat:@"%@",_selectColorID];
        affirm.selectSizeID=[NSString stringWithFormat:@"%@",_selectSizeID];
        affirm.stocktypeArray=self.stocktypeArray;
        affirm.JifenshopArray=self.JifenshopArray;
        affirm.four_pic=_ShopModel.four_pic;

        _publicaffirm = affirm;
        
        [self performSelector:@selector(gotoorder:) withObject:self afterDelay:0.5];

    }
    
}

- (void)gotoorder:(UIViewController*)controller
{
    [self.navigationController pushViewController:_publicaffirm animated:YES];
}

-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark 进入购物车界面
-(void)cartclick:(UIButton*)sender
{
    [MobClick event:SHOP_GOUWUCHE];
    
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *token = [userdefaul objectForKey:USER_TOKEN];
    
    if(token == nil)
    {
        [self ToLoginView];
        
        return;
    }
    
    NewShoppingCartViewController *shoppingcart =[[NewShoppingCartViewController alloc]init];
    shoppingcart.ShopCart_Type = ShopCart_NormalType;
    shoppingcart.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:shoppingcart animated:YES];
}

#pragma mark *****************scrollviewdelegate**************

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //删除加购物车动画
    for (CALayer *calye in _modelview.layer.sublayers) {
        calye.frame = CGRectMake(0, 0, 0, 0);
    }
   
    if(_likeview)
    {
        [UIView animateWithDuration:1 animations:^{
            _likeview.frame=CGRectMake((kApplicationWidth-40)/2, (kApplicationHeight-40)/2, 40, 40);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1 animations:^{
                [_likeview removeFromSuperview];
            }];
        }];
        
    }

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    if(!decelerate){
        
        //这里写上停止时要执行的代码
        
        if (scrollView!=self.searchTableView) {
            
            CGPoint offset = scrollView.contentOffset;
            
            CGRect bounds = scrollView.bounds;
            
            CGSize size = scrollView.contentSize;
            
            UIEdgeInsets inset = scrollView.contentInset;
            
            CGFloat currentOffset = offset.y + bounds.size.height - inset.bottom;
            
            CGFloat maximumOffset = size.height;
            
            
            CGFloat currentOffsetNew = [[NSString stringWithFormat:@"%.f",currentOffset] floatValue];
            CGFloat maximumOffsetNew = [[NSString stringWithFormat:@"%.f",maximumOffset] floatValue];
            
            CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
            //当currentOffset与maximumOffset的值相等时，说明scrollview已经滑到底部了。也可以根据这两个值的差来让他做点其他的什么事情
            
            if(currentOffsetNew +_tableFootView.frame.size.height >= maximumOffsetNew && translation.y < 0)
            {
                if(self.slectbtn.tag==1002)
                {
                    CGFloat viewHeigh = kIOSVersions >= 11 ? -20 :0;

                    [UIView animateWithDuration:0.5 animations:^{
                        
                        self.MyBigtableview.contentOffset = CGPointMake(0, self.MyBigtableview.contentSize.height-_tableFootView.frame.size.height-60+viewHeigh);
                        
                    } completion:^(BOOL finished) {
                        
                    }];
                }
            }
        }
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //删除加购物车动画
    for (CALayer *calye in _modelview.layer.sublayers) {
        calye.frame = CGRectMake(0, 0, 0, 0);
    }
    
    if (scrollView!=self.searchTableView) {
        
        UIView *footview = (UIView *)[self.view viewWithTag:8181];
        footview.clipsToBounds =YES;
        footview.userInteractionEnabled=YES;
        
        
        [UIView animateWithDuration:0.3 animations:^{
            
            footview.frame=CGRectMake(0, kApplicationHeight-55+kUnderStatusBarStartY, kApplicationWidth, 55);
            
        } completion:^(BOOL finished) {
            
            
        }];
        
        
//        if(!_tableFootView)
//        {
//            
//            CGPoint offset = scrollView.contentOffset;
//            
//            CGRect bounds = scrollView.bounds;
//            
//            CGSize size = scrollView.contentSize;
//            
//            UIEdgeInsets inset = scrollView.contentInset;
//            
//            CGFloat currentOffset = offset.y + bounds.size.height - inset.bottom;
//            
//            CGFloat maximumOffset = size.height;
//            
//            
//            CGFloat currentOffsetNew = [[NSString stringWithFormat:@"%.f",currentOffset] floatValue];
//            CGFloat maximumOffsetNew = [[NSString stringWithFormat:@"%.f",maximumOffset] floatValue];
//            
//            //当currentOffset与maximumOffset的值相等时，说明scrollview已经滑到底部了。也可以根据这两个值的差来让他做点其他的什么事情
//            
//            if(currentOffsetNew > maximumOffsetNew  || currentOffsetNew == maximumOffsetNew)
//                
//            {
//                
//                //-----我要刷新数据-----");
//                if(self.slectbtn.tag==1002)
//                {
////                    [self creatTableFootView];
//                    self.MyBigtableview.tableFooterView= _tableFootView;
//                
//                    int index = 0;
//                    for (NSDictionary *dic in self.shopStoreVC.typeIndexArr) {
//                        if ([dic[@"id"] intValue] == self.currPage) {
//                            index = [dic[@"index"] intValue];
//                            break;
//                        }
//                    }
//                    [self.shopStoreVC.slidePageScrollView scrollToPageIndex:index animated:NO];
//                    [self.shopStoreVC.slidePageScrollView.pageTabBar switchToPageIndex:index];
//                    
//                    [UIView animateWithDuration:0.5 animations:^{
//                        
//                        
//                        self.MyBigtableview.contentOffset = CGPointMake(0, self.MyBigtableview.tableFooterView.frame.origin.y-kApplicationHeight+kUnderStatusBarStartY+_tableFootView.frame.size.height-40);
//                        
//                    } completion:^(BOOL finished) {
//                        
//                        
//                    }];
//                    
//                    
//                }
//                
//            }
//            
//        }
    }

}

#pragma mark - TYSlidePageScrollViewDelegate

- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView verticalScrollViewDidScroll:(UIScrollView *)pageScrollView
{
    
    UIView *footview =(UIView*)[self.view viewWithTag:8181];
    
    CGPoint translation = [pageScrollView.panGestureRecognizer translationInView:pageScrollView.superview];
    int i=0;
    
    if(translation.x == 0)
    {
        if (translation.y > 0 )//下滑
        {
            //滑到底部
            if(i==0 && pageScrollView.contentOffset.y <= 0)
            {
                [UIView animateWithDuration:1 animations:^{
                    
                    [self scrollTableToFoot:NO];
                } completion:^(BOOL finished) {
                    
                    footview.hidden = NO;
                }];
                
                i++;
            }
        }else{//上滑
            //滑到顶部
            if(i == 0)
            {
                CGFloat viewHeigh = kIOSVersions >= 11 ? -20 :0;

                [UIView animateWithDuration:0.5 animations:^{
                    
                    self.MyBigtableview.contentOffset = CGPointMake(0, self.MyBigtableview.contentSize.height-_tableFootView.frame.size.height-60+viewHeigh);
                    
                }];
                
                i++;
            }
        }
    }
}

#pragma mark  - 滑到最底部
- (void)scrollTableToFoot:(BOOL)animated
{
    NSInteger s = [self.MyBigtableview numberOfSections];  //有多少组
    if (s<1) return;  //无数据时不执行 要不会crash
    NSInteger r = [self.MyBigtableview numberOfRowsInSection:s-1]; //最后一组有多少行
    if (r<1) return;
    NSIndexPath *ip = [NSIndexPath indexPathForRow:r-1 inSection:s-1];  //取最后一行数据
    [self.MyBigtableview scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:animated]; //滚动到最后一行
}


#pragma mark 获取分享的文案
- (void)getShareData:(NSInteger)tag Share:(BOOL)isShare
{
    
    NSString *URL= [NSString stringWithFormat:@"%@paperwork/paperwork.json",[NSObject baseURLStr_Upy]];
    NSURL *httpUrl=[NSURL URLWithString:URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:httpUrl];
    request.timeoutInterval = 3;
    
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            
            if(responseObject[@"yydb"] != nil && isShare)
            {
                tixianShare_title= [NSString stringWithFormat:@"%@",responseObject[@"yydb"][@"title"]];
                tixianShare_title = [tixianShare_title stringByReplacingOccurrencesOfString:@"${replace}" withString:[NSString stringWithFormat:@"%.0f",_ShopModel.shop_price.floatValue]];
                tixianShare_discription = [NSString stringWithFormat:@"%@",responseObject[@"yydb"][@"text"]];
                tixianShare_pic = [NSString stringWithFormat:@"%@",_newimage];
                //获取商品链接
                [self shopRequest:(int)tag success:^{
                    
                }];
            }
            
            if(responseObject[@"yydbfxmc"] != nil && !isShare)
            {
                NSString *shareText1 = [NSString stringWithFormat:@"%@",responseObject[@"yydbfxmc"][@"text1"]];
                NSString *shareText2 = [NSString stringWithFormat:@"%@",responseObject[@"yydbfxmc"][@"text2"]];
                
                [[NSUserDefaults standardUserDefaults] setObject:shareText1 forKey:@"shareText1"];
                [[NSUserDefaults standardUserDefaults] setObject:shareText2 forKey:@"shareText2"];
                //夺宝分享弹框
                [self GroupBuyPopView:OneIndianaSuccess];
            }
        }
        
    }
}

#pragma mark 获取商品链接请求
- (void)shopRequest:(int)tag success:(void(^)())success
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *realm = [user objectForKey:USER_ID];
    NSString *token = [user objectForKey:USER_TOKEN];
    [DataManager sharedManager].key = _ShopModel.shop_code;
    NSString *url=[NSString stringWithFormat:@"%@shop/getShopLink?version=%@&shop_code=%@&realm=%@&token=%@&share=%@&getShop=true&indiana=1",[NSObject baseURLStr],VERSION,_ShopModel.shop_code,realm,token,@"2"];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showMessage:@"分享加载中，稍等哟~" afterDeleay:0 WithView:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        _sharebtn.userInteractionEnabled = YES;
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            
            NSString *str=responseObject[@"status"];
            
            if(str.intValue==1)
            {
                _shareModel=[ShareShopModel alloc];
                _shareModel.shopUrl=responseObject[@"link"];
                
                _shareShopurl=@"";
                _shareShopurl=responseObject[@"link"];
                
                NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
                
                if(_shareShopurl)
                {
                    [userdefaul setObject:[NSString stringWithFormat:@"%@",_shareShopurl] forKey:QR_LINK];
                }
                
                NSString * duobaoTitle = [NSString stringWithFormat:@"%@",responseObject[@"duobaoTitle"]];
                if(duobaoTitle != nil && ![duobaoTitle isEqualToString:@"<null>"])
                {
                    [DataManager sharedManager].sharetitle = duobaoTitle;
                }else{
                    [DataManager sharedManager].sharetitle = nil;
                }
                
                NSString * duobaoTxt = [NSString stringWithFormat:@"%@",responseObject[@"duobaoTxt"]];
                if(duobaoTxt != nil && ![duobaoTxt isEqualToString:@"<null>"])
                {
                    [DataManager sharedManager].sharecontent = duobaoTxt;
                }else{
                    [DataManager sharedManager].sharecontent = nil;
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
                            
                            _shareModel.shopImage = imageArray[2];
                            
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
            
                if( !_shareShopurl)
                {
                    [MBProgressHUD hideHUDForView:self.view];
                    return;
                }
                
                [self gotoshare:tag success:^{
                    
                    if(success)
                    {
                        success();
                    }
                }];
            }
            else{
                [MBProgressHUD hideHUDForView:self.view];
                
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:@"网络异常，请稍后重试" Controller:self];
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

/**
 * @brief 生成当天的某个点（返回的是伦敦时间，可直接与当前时间[NSDate date]比较）
 * @param hour 如hour为“8”，就是上午8:00（本地时间）
 */
- (NSDate *)getCustomDateWithHour:(NSInteger)hour
{
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    
    //设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return [resultCalendar dateFromComponents:resultComps];
}


-(void)createPopView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    view.backgroundColor = [[UIColor colorWithRed:60/255.0 green:61/255.0 blue:62/255.0 alpha:0.8] colorWithAlphaComponent:0.7];
    //    view.alpha = 0.9;
    view.tag = 8888;
    
    
    UIView * smileView=[[UIView alloc]initWithFrame:CGRectMake(20, (kApplicationHeight-200)/2, kApplicationWidth-40, ZOOM(580))];
    smileView.backgroundColor=[UIColor whiteColor];
    UIImageView *smileImg = [[UIImageView alloc]initWithFrame:CGRectMake(smileView.frame.size.width/2-35, smileView.frame.size.height/2-70, 64, 56)];
    
    smileImg.image = [UIImage imageNamed:@"表情"];
    smileImg.contentMode = UIViewContentModeScaleAspectFit;
    
    //    [smileView addSubview:smileImg];
    
    UILabel* thanksLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, smileImg.frame.origin.y,kApplicationWidth-40-40, 80)];
    
    thanksLabel.text = @"今天的分享次数已经全部使用了哦，明天再来吧~";
    thanksLabel.textColor = [UIColor blackColor];
    thanksLabel.numberOfLines=0;
    [thanksLabel setFont:[UIFont systemFontOfSize:ZOOM(56)]];
    thanksLabel.textAlignment = NSTextAlignmentCenter;
    [smileView addSubview:thanksLabel];
    
    CGFloat okbtnY = CGRectGetMaxY(thanksLabel.frame);
    
    UIButton *okbutton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    okbutton.frame=CGRectMake(smileView.frame.size.width/2-50, okbtnY+20, 100, 40);
    [okbutton setTitle:@"确定" forState:UIControlStateNormal];
    okbutton.tintColor=[UIColor whiteColor];
    [okbutton setBackgroundColor:[UIColor blackColor]];
    [okbutton addTarget:self action:@selector(okbtn) forControlEvents:UIControlEventTouchUpInside];
    [smileView addSubview:okbutton];
    
    
    [view addSubview:smileView];
    
    [self.view addSubview:view];
    
}

-(void)okbtn
{
    UIView *view =(UIView*)[self.view viewWithTag:8888];
    [view removeFromSuperview];
}

-(void)share
{
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *token = [userdefaul objectForKey:USER_TOKEN];
    
    if(token == nil)
    {
        [self ToLoginView];
        
        return;
    }

    
    [[DShareManager share] shareAppWithType:ShareTypeWeixiTimeline View:nil Image:nil Title:nil WithShareType:@"detail"];
}

//回到顶部按钮
- (void)upToTop
{
    _UpBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _UpBtn.frame = CGRectMake(kScreenWidth-40, kScreenHeight-100, 30, 30);
    [_UpBtn setBackgroundImage:[UIImage imageNamed:@"组-2"] forState:UIControlStateNormal];
    
    [_UpBtn.layer setMasksToBounds:YES];
    _UpBtn.alpha=0.9;
    [_UpBtn.layer setCornerRadius:15.0];
    [self.view addSubview:_UpBtn];
    [_UpBtn addTarget:self action:@selector(UpScroll:) forControlEvents:UIControlEventTouchUpInside];
    [_UpBtn setHidden:YES];
}

// 让tableview滑动到顶部
-(void)UpScroll:(id)sender{
    
    UIView *headview=(UIView*)[self.view viewWithTag:3838];
    headview.backgroundColor=[UIColor clearColor];
    
    [self.MyBigtableview setContentOffset:CGPointMake(0,0) animated:YES];
}

-(void)upToTop:(UIButton*)sender
{
    [self.MyBigtableview setContentOffset:CGPointMake(0,0) animated:YES];
}

#pragma mark - TFTFTFTFTFTFTFTFTFTFTFTFTFTFTFTFTFTFTFTFTFTFTFTFTFTFTFTFTFTFTFTFTF
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        //json解析失败:%@",err);
        return nil;
    }
    return dic;
}

- (CGFloat)getCellHeight:(UITableViewCell*)cell
{
    [cell layoutIfNeeded];
    [cell updateConstraintsIfNeeded];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height;
}

- (void)footViewAddChildView
{
    
    _tableFootView.clipsToBounds = YES;
    self.shopStoreVC = [[ShopStoreViewController alloc] init];
    self.shopStoreVC.isHeadView = NO;
    self.shopStoreVC.isFootView = NO;
    self.shopStoreVC.isVseron = YES;
    
    [self.shopStoreVC.view setFrame:CGRectMake(0, -NavigationHeight-StatusTableHeight, CGRectGetWidth(_tableFootView.frame), CGRectGetHeight(_tableFootView.frame))];
    
    self.shopStoreVC.view.backgroundColor = [UIColor whiteColor];

    self.shopStoreVC.slidePageScrollView.pageTabBar.index = (int)self.currPage;
    [self addChildViewController:_shopStoreVC];
    self.shopStoreVC.view.backgroundColor = [UIColor whiteColor];
    [_tableFootView addSubview:self.shopStoreVC.view];
    
    self.shopStoreVC.slidePageScrollView.tyDelegate = self;
    [self.MyBigtableview reloadData];
    
}


    
#pragma mark 选择分享的平台
-(void)shareClick:(UIButton*)sender
{
    
    if(_shareModelview)
    {
       
        [UIView animateWithDuration:0.5 animations:^{
            
            _sharebackview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
            
            _shareModelview.frame=CGRectMake(0, kApplicationHeight+30, kApplicationWidth, SHAREMODELVIEW_HEIGH);
            
        } completion:^(BOOL finished) {
            
            [_sharebackview removeFromSuperview];
            [_shareModelview removeFromSuperview];
            
            int tag = (int)sender.tag;
            //获取商品链接
            [self shopRequest:tag success:^{
                
                
            }];

            
        }];
        
    }else{
        
        [_sharebackview removeFromSuperview];
    }

    
}

-(void)gotoshare:(int)sharetag success:(void(^)())success
{
    //配置分享平台信息
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app shardk];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    [user setObject:tixianShare_title forKey:TIXIAN_SHARE_TITLE];
    [user setObject:tixianShare_discription forKey:TIXIAN_SHARE_DISCRIPTION];
    
    if(sharetag==9000)//微信好友
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            UIImage *shopimage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_Upy],tixianShare_pic]]]];
            [MBProgressHUD hideHUDForView:self.view];
            
            [[DShareManager share] shareAppWithType:ShareTypeWeixiSession View:nil Image:shopimage WithShareType:@"OneIndiandetail"];

            
            [DShareManager share].ShareSuccessBlock = ^{
                [MBProgressHUD show:@"分享成功" icon:nil view:self.view];
            };
            
            [DShareManager share].ShareFailBlock = ^{
                [MBProgressHUD show:@"分享失败" icon:nil view:self.view];
            };
        });
        
    }else if (sharetag==9001)//微信朋友圈
    {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *shopimage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_Upy],tixianShare_pic]]]];
            if(shopimage == nil)
            {
                NavgationbarView *mentionview = [[NavgationbarView alloc]init];
                [mentionview showLable:@"数据获取异常" Controller:self];
                
                return ;
            }
            
            [MBProgressHUD hideHUDForView:self.view];
            
            [[DShareManager share] shareAppWithType:ShareTypeWeixiTimeline View:nil Image:shopimage WithShareType:@"OneIndiandetail"];
            [DShareManager share].ShareSuccessBlock = ^{
                [MBProgressHUD show:@"分享成功" icon:nil view:self.view];
            };
            
            [DShareManager share].ShareFailBlock = ^{
                [MBProgressHUD show:@"分享失败" icon:nil view:self.view];
            };
        });
    
    }

}


- (void)disapperview:(UITapGestureRecognizer*)tap
{
    _sharebtn.selected = NO;
    
    [self disapperShare];
}

- (void)disapperShare
{
    [_sharebtn becomeFirstResponder];

    if(_shareModelview)
    {
        [UIView animateWithDuration:0.5 animations:^{
            
            _sharebackview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
            
            _shareModelview.frame=CGRectMake(0, kApplicationHeight+30, kApplicationWidth, SHAREMODELVIEW_HEIGH);
            
        } completion:^(BOOL finished) {
            
            [_sharebackview removeFromSuperview];
            [_shareModelview removeFromSuperview];
            
        }];
        
    }else{
        
        [_sharebackview removeFromSuperview];
    }
    
}

#pragma mark 立即参与
-(void)buttonClick:(UIButton*)sender
{
    if(_oweStatues.intValue == 3)
    {
        [MBProgressHUD show:@"当期活动已结束，请留意下期哦~" icon:nil view:nil];
        return;
    }else if (_oweStatues.intValue == 4)
    {
        [MBProgressHUD show:@"档期活动已结束，正在开奖，请稍后再来。" icon:nil view:nil];
        return;
    }

    //埋点
    [YFShareModel getShareModelWithKey:@"duobao" type:StatisticalTypeIndianaMustParticipate tabType:StatisticalTabTypeIndiana success:nil];

    [self creatIndianaPopView];
}

#pragma mark 跳转到登录界面
- (void)ToLogin :(NSInteger)tag
{
    LoginViewController *login=[[LoginViewController alloc]init];
    login.tag = tag;
    login.loginStatue=@"toBack";
    login.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:login animated:YES];
}

- (void)ToLoginView
{
    TFLoginView *tf = [[TFLoginView alloc] initWithHeadImage:nil contentText:nil upButtonTitle:nil downButtonTitle:nil];
    [tf show];
    
    tf.upBlock = ^() { //注册
        //上键");
        
        [self ToLogin:2000];
    };
    
    tf.downBlock = ^() {// 登录
        //下键");
        
        [self ToLogin:1000];
    };
}

- (float)widthCoefficient:(float)width
{
    if (ThreeAndFiveInch) {
        return width*1;
    } else if (FourInch) {
        return width*1;
    } else if (FourAndSevenInch) {
        return width*1.172;
    } else if (FiveAndFiveInch) {
        return width*1.294;
    } else {
        return width*1;
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

#pragma mark *********************分享部分**********************
- (void)httpGetRandShopWithType:(NSString *)myType
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *realm = [ud objectForKey:USER_ID];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    NSString *urlStr;
    
    if ([myType isEqualToString:DailyTaskMorningShare]||[myType isEqualToString:DailyTaskAfternoonShare]) {
        urlStr = [NSString stringWithFormat:@"%@shop/shareShop?token=%@&version=%@&realm=%@",[NSObject baseURLStr], token,VERSION, realm];
    } else if ([myType isEqualToString:NoviciateTask_Seven_Eight]) {
      urlStr =  [NSString stringWithFormat:@"%@shop/getShopLink?version=%@&shop_code=%@&realm=%@&token=%@&share=%@&getShopMessage=true",[NSObject baseURLStr],VERSION,_ShopModel.shop_code,realm,token,@"2"];
    }
    NSString *URL = [MyMD5 authkey:urlStr];
    [MBProgressHUD showMessage:@"启动分享中,请稍后" afterDeleay:0 WithView:self.view];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //分享商品 = %@", responseObject);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        responseObject = [NSDictionary changeType:responseObject];
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
    //url = %@", url);
    
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        responseObject = [NSDictionary changeType:responseObject];
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
        
        UIImage *QRImage = [QRCodeGenerator qrImageForString:qrLink imageSize:160];
        
        ProduceImage *pi = [[ProduceImage alloc] init];
        UIImage *newimg = [pi getImage:self.shareRandShopImage withQRCodeImage:QRImage withText:nil withPrice:[NSString stringWithFormat:@"%@",shop_price] WithTitle:nil];
        
        DShareManager *ds = [DShareManager share];
        ds.delegate = self;
        
        [ds shareAppWithType:ShareTypeWeixiTimeline withImageShareType:myType withImage:newimg];
    } else {
        
        NavgationbarView *nv = [[NavgationbarView alloc] init];
        [nv showLable:@"没有安装微信" Controller:self];
    }
}

- (void)DShareManagerStatus:(SHARESTATE)shareStatus withType:(NSString *)type
{
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    
    //type = %@", type);
    
    if ([type isEqualToString:DailyTaskMorningShare]||[type isEqualToString:DailyTaskAfternoonShare]) {
        if (shareStatus == 1) {
            
            
            
            
        } else if (shareStatus == 2) {
            
            [nv showLable:@"分享失败" Controller:self];
            
            
        } else if (shareStatus == 3) {
            
//            [nv showLable:@"分享取消" Controller:self];
            
        }
    } else if ([type isEqualToString:NoviciateTask_Seven_Eight]) {
        
        if (shareStatus == 1) {
            
            
            
            
        } else if (shareStatus == 2) {
            
            [nv showLable:@"分享失败" Controller:self];
            
            
        } else if (shareStatus == 3) {
            
            [nv showLable:@"分享取消" Controller:self];
            
        }
        
    }

}

#pragma mark - +++++++++++++++++++添加+++++++++++++++++++

- (void)createTableData
{
    
    self.searchCateArr = [NSMutableArray arrayWithArray:[self FindDataForTPYEDB:@"0"]];
    NSMutableArray *tmpArr = [NSMutableArray array];
    for (NSDictionary *tmpDic in self.searchCateArr) {
        if ([tmpDic[@"name"] isEqualToString:@"特卖"] || [tmpDic[@"name"] isEqualToString:@"热卖"] ) {
            [tmpArr addObject:tmpDic];
        }
    }
    [self.searchCateArr removeObjectsInArray:tmpArr];
    
    if (self.searchCateArr.count!=0) {
        NSArray *idArr = [self getArrayFindFromArray:self.searchCateArr withKey:@"id"];
        for (NSString *s in idArr) {
            NSArray *arr = [self FindDataForTPYEDB:s];
            [self.searchDataArr addObject:arr];
        }
    }
    
    [self.searchTableView reloadData];
}



//- (void)addSearchRightView
//{
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    NSArray *subViewsArr = window.subviews;
//    __block BOOL bl = NO;
//    [subViewsArr enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
//        if (view == self.searchRightView) {
//            [window bringSubviewToFront:self.searchRightView];
//            bl = YES;
//            return;
//            *stop = YES;
//        }
//    }];
//    
//    if (bl == NO) {
//        self.searchRightView = [[UIView alloc] initWithFrame:CGRectMake(OPENCENTERX, StatusTableHeight, kScreenWidth-OPENCENTERX, kScreenHeight-StatusTableHeight)];
//        self.searchRightView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0];
//        [window addSubview:self.searchRightView];
//        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGRClick:)];
//        [self.searchRightView addGestureRecognizer:tapGR];
//        
//        UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGRClick:)];
//        [self.searchRightView addGestureRecognizer:panGR];
//        
//        UISwipeGestureRecognizer *swipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGRClick:)];
//        swipeGR.direction = UISwipeGestureRecognizerDirectionLeft;
//        [self.searchRightView addGestureRecognizer:swipeGR];
//        
//        [window bringSubviewToFront:self.searchRightView];
//    }
//    
//    
//}

- (void)createUI
{
    self.leftBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, StatusTableHeight, OPENCENTERX+2, kScreenHeight-StatusTableHeight)];
    self.leftBackgroundView.backgroundColor = RGBCOLOR_I(22,22,22);

#pragma mark - *************去掉左滑搜索*************
//    [self createSearch];
//    [self.view addSubview:self.leftBackgroundView];
#pragma mark - +++++++++++++去掉左滑搜索+++++++++++++
    [self.leftBackgroundView removeFromSuperview];
    
    self.contentBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.contentBackgroundView.backgroundColor = RGBCOLOR_I(22,22,22);
#pragma mark - *************去掉左滑搜索*************
//    [self.view addSubview:self.contentBackgroundView];
#pragma mark - +++++++++++++去掉左滑搜索+++++++++++++
    [self.contentBackgroundView removeFromSuperview];
    
    
    self.searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.searchBtn.frame=CGRectMake(kApplicationWidth-42, kApplicationHeight-130, 32, 32);
    [self.searchBtn setImage:[UIImage imageNamed:@"详情_search"] forState:UIControlStateNormal];
    [self.searchBtn addTarget:self action:@selector(TFSearchClick:) forControlEvents:UIControlEventTouchUpInside];
    
#pragma mark - *************去掉左滑搜索*************
//    [self.contentBackgroundView addSubview:self.searchBtn];
//    [self.contentBackgroundView bringSubviewToFront:self.searchBtn];
    
    self.screenBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.screenBtn.frame=CGRectMake(kApplicationWidth-42, kApplicationHeight-80, 32, 32);
    [self.screenBtn setImage:[UIImage imageNamed:@"详情_shaixuan"] forState:UIControlStateNormal];
    [self.screenBtn addTarget:self action:@selector(TFScreenClick:) forControlEvents:UIControlEventTouchUpInside];

    
//#pragma mark - +++++++++++++去掉左滑搜索+++++++++++++
//    [self.view addSubview:self.screenBtn];
//    [self.view bringSubviewToFront:self.screenBtn];
   
}

#pragma mark 夺宝记录
- (void)Recordclick:(UIButton*)sender
{
    TFIndianaRecordViewController *tiVC = [[TFIndianaRecordViewController alloc] init];
    tiVC.type = IndianaRecords;
    tiVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tiVC animated:YES];
}
#pragma mark 我的参与
- (void)Announcedclick:(UIButton*)sender
{
    MyInvolvementRecordVC *tiVC = [[MyInvolvementRecordVC alloc] init];
    tiVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tiVC animated:YES];
}

#pragma mark 立即购买弹框
- (void)creatIndianaPopView
{
    OneIndianaPopView * extrabonusview = [[OneIndianaPopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) Surplus:[Signmanager SignManarer].IndianaSurplusCount ToalCount:_ShopModel.active_people_num.integerValue];
    
    __weak OneIndianaPopView *view = extrabonusview;
    view.tapHideMindBlock = ^{
        [view remindViewHiden];
    };
    
    kWeakSelf(self);
    view.weixinBlock = ^{
        [weakself shopRequest:9000 success:^{
            [extrabonusview shareData];
        }];
    };
    
    //一元夺宝下单支付
    view.confirmOrderBlock = ^(NSString* price,NSString *num,NSString *ReductionPrice){
        [weakself httpMakeOrder:num];
    };
    [self.view addSubview:extrabonusview];
}

- (void)httpMakeOrder:(NSString *)num {

    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *url=[NSString stringWithFormat:@"%@treasures/addTreasures?version=%@&token=%@&num=%@&shop_code=%@",[NSObject baseURLStr],VERSION,token,num,_ShopModel.shop_code];

    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];

    NSString *URL=[MyMD5 authkey:url];
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {

        [MBProgressHUD hideHUDForView:self.view];

        MyLog(@"%@",responseObject);
        if(responseObject[@"orderToken"]!=nil)
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"orderToken"] forKey:ORDER_TOKEN];

        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];

            if(statu.intValue==1)//请求成功
            {
                self.order_code=nil;
                self.order_code =responseObject[@"order_code"];
                 NSString *_shop_seprice= [NSString stringWithFormat:@"%@",responseObject[@"data"][@"price"]];
                    self.order_code =responseObject[@"data"][@"order_code"];

                TFPayStyleViewController*paystyle=[[TFPayStyleViewController alloc]init];
                paystyle.price = _shop_seprice.doubleValue;
                paystyle.urlcount=@"1";
                paystyle.order_code=_order_code;
                paystyle.shopmodel = _ShopModel;
                paystyle.requestOrderDetail=1;
                paystyle.shop_from = @"8";
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

        [MBProgressHUD hideHUDForView:self.view];

        if ([error code] == kCFURLErrorTimedOut) {
            //===== 请求超时");

            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];

        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];

}

- (NSArray *)getArrayFindFromArray:(NSArray *)sourceArr withKey:(NSString *)key
{
    NSMutableArray *muArr = [NSMutableArray array];
    for (NSDictionary *dic in sourceArr) {
        [muArr addObject:dic[key]];
    }
    return muArr;
}
- (NSArray *)sortTheTitleFromArray:(NSArray *)arr
{
    NSMutableArray *muArr = [NSMutableArray arrayWithArray:arr];
    
    for (int i = 0; i<muArr.count-1; i++) {
        for (int j = 0; j<muArr.count-i-1; j++) {
            NSDictionary *dic = muArr[j];
            NSDictionary *dic2 = muArr[j+1];
            
            if ([dic[@"sequence"] intValue]>[dic2[@"sequence"] intValue]) {
                [muArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    
    return muArr;
}

//- (void)selectBtnEnd:(TFScreeningBackgroundView *)screeningBackgroundView withChooseArray:(NSArray *)chooseArray
//{
//    //chooseArray = %@",chooseArray);
//    if (chooseArray.count!=0) {
//        [self httpScreeningRequest:chooseArray];
//        [MBProgressHUD showMessage:@"正在筛选" toView:self.screeningScrollView];
//    } else {
//        [MBProgressHUD showError:@"亲,请至少选择一项吧"];
//    }
//}
//- (void)httpScreeningRequest:(NSArray *)arr
//{
//    
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    NSString *token = [ud objectForKey:USER_TOKEN];
//    NSString *version = VERSION;
//    
//    
//    NSMutableString *muStr = [NSMutableString string];
//    for (NSDictionary *dic in arr) {
//        [muStr appendString:@"&"];
//        [muStr appendString:dic[@"cate"]];
//        [muStr appendString:@"="];
//        [muStr appendString:dic[@"chac"]];
//    }
//    
////    NSString *type1;
////    NSString *type_name;
//    
////    if (self.typeID == nil||self.typeName == nil) {
////        type1 = @"6";
////        type_name = @"热卖";
////    } else {
////        type1= [NSString stringWithFormat:@"%@", self.typeID];
////        type_name = [NSString stringWithFormat:@"%@",self.typeName];
////    }
//    
//    NSString *type1 = [NSString stringWithFormat:@"%d", (int)self.currPage];
//    NSString *type_name = [NSString stringWithFormat:@"%@", [self FindNameForTPYEDB:type1][@"name"]];
//    
//    //type_id = %@, type_name = %@", type1, type_name);
//    
//    
//    NSString *urlStr;
//    if(token != nil){
//        urlStr = [NSString stringWithFormat:@"%@shop/queryCondition?&pager.curPage=1&pager.pageSize=10&token=%@&version=%@%@&type1=%@&type_name=%@",[NSObject baseURLStr],token,VERSION,muStr,type1,type_name];
//    } else
//        urlStr = [NSString stringWithFormat:@"%@shop/queryConUnLogin?&pager.curPage=1&pager.pageSize=10&version=%@%@&type1=%@&type_name=%@",[NSObject baseURLStr],VERSION,muStr,type1,type_name];
//    
//    NSString *URL = [MyMD5 authkey:urlStr];
////    //URL = %@", URL);
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [MBProgressHUD hideHUDForView:self.screeningScrollView];
//        //res = %@",responseObject);
//        if ([responseObject[@"status"] intValue] == 1) {
//            [MBProgressHUD showSuccess:@"筛选成功"];
//            NSArray *dataArr = responseObject[@"listShop"];
//            NSMutableArray *muArr = [NSMutableArray array];
//            for (NSDictionary *dic in dataArr) {
//                ShopDetailModel *sModel = [[ShopDetailModel alloc] init];
//                [sModel setValuesForKeysWithDictionary:dic];
//                [muArr addObject:sModel];
//            }
//            
//            TFScreenViewController *svc = [[TFScreenViewController alloc] init];
//            svc.receiveArray = muArr;
//            svc.muStr = muStr;
//            svc.type1 = [NSString stringWithFormat:@"%@",type1];
//            svc.type_name = [NSString stringWithFormat:@"%@",type_name];
//            svc.index = 2;
//            svc.titleText = @"筛选结果";
////            svc.view.backgroundColor = [UIColor whiteColor];
//            svc.hidesBottomBarWhenPushed=YES;
//            [self.navigationController pushViewController:svc animated:YES];
//            
//        } else {
//            [MBProgressHUD showError:responseObject[@"message"]];
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD hideHUDForView:self.screeningScrollView];
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
//    }];
//}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
//    self.screenBtn.selected = NO;
//    //开始搜索 = %@",searchBar.text);
//    
//    
    NSString *typeID = [self FindDataForTypeDB:searchBar.text];
//
//    MyLog(@"typearr=%@",typeID);
//    
//    [self httpSearchTextRequest:typeID];

//    self.searchBtn.selected = NO;
    
    self.searchBtn.selected = YES;
    [self.searchBar resignFirstResponder];
    
    
    TFScreenViewController *svc = [[TFScreenViewController alloc] init];
    svc.index = 0;
    if ([typeID isEqualToString:searchBar.text]) {
        svc.muStr = searchBar.text;
    } else { //类型
        //        svc.type2 = typeID;
        
        svc.muStr = searchBar.text;
        
    }
    svc.titleText = self.searchBar.text;
    svc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:svc animated:YES];
    
}

// 查询三级分类
-(NSString*)FindDataForTypeDB:(NSString *)findStr
{
    NSString *typestring=findStr;
    
    if([self OpenDb])
    {
        const char *dbpath = [_databasePath UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_open(dbpath, &AttrcontactDB) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat:@"SELECT id,name,phone,groupflag from TYPDB where name=\"%@\"",findStr];
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(AttrcontactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
                    
                    NSString *ID= [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                    NSString *name = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                    
                    MyLog(@"id=%@ name=%@",ID,name);
                    
                    [dic setObject:ID forKey:name];
                    
                    typestring = ID;
                    
                }
                
                sqlite3_finalize(statement);
            }
            sqlite3_close(AttrcontactDB);
        }
    }
    return typestring;
}


- (void)httpSearchTextRequest:(NSString*)str
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    
    NSString *urlStr;
    
    if(token !=nil)
    {
        if([str isEqualToString:self.searchBar.text])
        {
            urlStr = [NSString stringWithFormat:@"%@shop/queryCondition?token=%@&version=%@&shop_name=%@&pager.curPage=1&pager.pageSize=10",[NSObject baseURLStr],token,VERSION,self.searchBar.text];
        }else{
            
            urlStr = [NSString stringWithFormat:@"%@shop/queryCondition?token=%@&version=%@&type2=%@&pager.curPage=1&pager.pageSize=10",[NSObject baseURLStr],token,VERSION,str];
        }
        
    }else{
        
        
        if([str isEqualToString:self.searchBar.text])
        {
            urlStr = [NSString stringWithFormat:@"%@shop/queryConUnLogin?token=%@&version=%@&shop_name=%@&pager.curPage=1&pager.pageSize=10",[NSObject baseURLStr],token,VERSION,self.searchBar.text];
        }else{
            
            urlStr = [NSString stringWithFormat:@"%@shop/queryConUnLogin?token=%@&version=%@&type2=%@&pager.curPage=1&pager.pageSize=10",[NSObject baseURLStr],token,VERSION,str];
        }
        
    }
    
    
    NSString *URL = [MyMD5 authkey:urlStr];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //res = %@",responseObject);
        [MBProgressHUD hideHUDForView:self.view];
        if ([responseObject[@"status"] intValue] == 1) {
            self.searchBtn.selected = NO;
            [MBProgressHUD showSuccess:@"搜索成功"];
            [self.searchBar resignFirstResponder];
            
            
            NSArray *dataArr = responseObject[@"listShop"];
            NSMutableArray *muArr = [NSMutableArray array];
            for (NSDictionary *dic in dataArr) {
                ShopDetailModel *sModel = [[ShopDetailModel alloc] init];
                [sModel setValuesForKeysWithDictionary:dic];
                [muArr addObject:sModel];
            }
            
            TFScreenViewController *svc = [[TFScreenViewController alloc] init];
            svc.receiveArray = muArr;
            svc.index = 0;
            svc.muStr = str;
            svc.titleText = self.searchBar.text;
            svc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:svc animated:YES];
            
            
        } else {
            [MBProgressHUD showError:responseObject[@"message"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:_currentStatusBarStyle];
    _sharenumber = 0;
    
}

-(void)viewDidLayoutSubviews
{
    if ([self.MyBigtableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.MyBigtableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.MyBigtableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.MyBigtableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}
#pragma mark - 数据懒加载
- (NSMutableArray *)searchDataArr
{
    if (_searchDataArr == nil) {
        _searchDataArr = [[NSMutableArray alloc] init];
    }
    return _searchDataArr;
}

- (NSMutableArray *)searchCateArr {
    if (_searchCateArr == nil) {
        _searchCateArr = [[NSMutableArray alloc] init];
    }
    return _searchCateArr;
}

- (NSMutableArray *)screenDataArr {
    if (_screenDataArr == nil) {
        _screenDataArr = [[NSMutableArray alloc] init];
    }
    return _screenDataArr;
}

- (NSMutableArray *)screenCateArr {
    if (_screenCateArr == nil) {
        _screenCateArr = [[NSMutableArray alloc] init];
    }
    return _screenCateArr;
}


//懒加载
- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    
    return _dataArr;
}

- (NSMutableArray *)sizeArray
{
    if (_sizeArray == nil) {
        _sizeArray = [[NSMutableArray alloc] init];
    }
    
    return _sizeArray;
}

- (NSMutableArray *)SizeDataArray
{
    if (_SizeDataArray == nil) {
        _SizeDataArray = [[NSMutableArray alloc] init];
    }
    
    return _SizeDataArray;
}

- (NSMutableArray *)colorArray
{
    if (_colorArray == nil) {
        _colorArray = [[NSMutableArray alloc] init];
    }
    
    return _colorArray;
}

- (NSMutableArray *)commentArray
{
    if (_commentArray == nil) {
        _commentArray = [[NSMutableArray alloc] init];
    }
    
    return _commentArray;
}

- (NSMutableArray *)stock_id_nameArray
{
    if (_tagNameArray == nil) {
        _tagNameArray = [[NSMutableArray alloc] init];
    }
    
    return _tagNameArray;
}
- (NSMutableArray *)commentDataArray
{
    if (_commentDataArray == nil) {
        _commentDataArray = [[NSMutableArray alloc] init];
    }
    
    return _commentDataArray;
}

- (NSMutableArray *)stocktypeArray
{
    if (_stocktypeArray == nil) {
        _stocktypeArray = [[NSMutableArray alloc] init];
    }
    
    return _stocktypeArray;
}

- (NSMutableArray *)stock_colorArray
{
    if (_stock_colorArray == nil) {
        _stock_colorArray = [[NSMutableArray alloc] init];
    }
    
    return _stock_colorArray;
}

- (NSMutableArray *)stock_sizeArray
{
    if (_stock_sizeArray == nil) {
        _stock_sizeArray = [[NSMutableArray alloc] init];
    }
    
    return _stock_sizeArray;
}

- (NSMutableArray *)JifenshopArray
{
    if (_JifenshopArray == nil) {
        _JifenshopArray = [[NSMutableArray alloc] init];
    }
    
    return _JifenshopArray;
}
- (NSMutableArray *)DeliverArray
{
    if (_DeliverArray == nil) {
        _DeliverArray = [[NSMutableArray alloc] init];
    }
    
    return _DeliverArray;
}

- (NSMutableArray *)ImageArray
{
    if (_ImageArray == nil) {
        _ImageArray = [[NSMutableArray alloc] init];
    }
    
    return _ImageArray;
}

- (NSMutableArray *)ImageDataArray
{
    if (_ImageDataArray == nil) {
        _ImageDataArray = [[NSMutableArray alloc] init];
    }
    
    return _ImageDataArray;
}

- (NSMutableArray *)ImageHeighArray
{
    if (_ImageHeighArray == nil) {
        _ImageHeighArray = [[NSMutableArray alloc] init];
    }
    
    return _ImageHeighArray;
}

- (NSMutableArray *)BigDataArray
{
    if (_BigDataArray == nil) {
        _BigDataArray = [[NSMutableArray alloc] init];
    }
    
    return _BigDataArray;
}

- (NSMutableArray *)shopAirveIDArr
{
    if (_shopAirveIDArr == nil) {
        _shopAirveIDArr = [[NSMutableArray alloc] init];
    }
    
    return _shopAirveIDArr;
}

- (NSMutableArray *)shopDirvelArr
{
    if (_shopDirvelArr == nil) {
        _shopDirvelArr = [[NSMutableArray alloc] init];
    }
    
    return _shopDirvelArr;
}

- (NSMutableArray *)ruleDataArray
{
    if(_ruleDataArray == nil)
    {
        _ruleDataArray = [[NSMutableArray alloc] init];
    }
    
    return _ruleDataArray;
}

- (NSMutableArray *)participateArray
{
    if(_participateArray == nil)
    {
        _participateArray = [[NSMutableArray alloc]init];
    }
    
    return _participateArray;
}

#pragma mark 普通分享失败
- (void)ShopDetailsharefail:(NSNotification*)note
{
    NavgationbarView *mentionview = [[NavgationbarView alloc]init];
    [mentionview showLable:@"分享失败" Controller:self];
}

#pragma mark 普通分享成功
- (void)ShopDetailsharesuccess:(NSNotification*)note
{
    [IndianaPublicModel saveShareStaue:_shop_code success:^(id data) {
        IndianaPublicModel *model = data;
        if(model.status == 1)
        {
            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
            [mentionview showLable:@"分享成功" Controller:self];
        }
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
