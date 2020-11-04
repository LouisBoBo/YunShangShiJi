//
//  ComboShopDetailViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/12/1.
//  Copyright © 2015年 ios-1. All rights reserved.
//  签到包邮  特卖

#import "ComboShopDetailViewController.h"
#import "ShopDetailViewController.h"
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
#import "WTFCartViewController.h"

#import "OrderDetailViewController.h"
#import "AffirmOrderViewController1.h"
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
#import "ChatViewController.h"
#import "RobotManager.h"
#import "TFStartScoreView.h"
#import "ImageTableViewCell.h"
#import "MymineViewController.h"

#import "TFCommentModel.h"
#import "TFAddCommentModel.h"
#import "TFSuppCommentModel.h"

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
#import "TFScreenViewController.h"
#import "IndianaDetailViewController.h"

#import "TFNoviceTaskView.h"
#import "TFDailyTaskView.h"
#import "tagTableViewCell.h"
#import "ShopCarCountModel.h"
#import "YFShopCarView.h"
#import "MyOrderViewController.h"
#import "ShopCarModel.h"
#import "ShopCarManager.h"
#import "ShareAnimationView.h"
#import "NewShoppingCartViewController.h"

#define SIZE [[UIScreen mainScreen] bounds].size
#define NavigationHeight 44.0f
#define StatusTableHeight 20.0f
#define TableBarHeight 49.0f
#define handViewWidth 10
#define SHAREMODELVIEW_HEIGH ZOOM6(440)

@interface ComboShopDetailViewController ()<ChatViewControllerDelegate, DShareManagerDelegate>

@property (nonatomic, strong)TFNoviceTaskView *noviceTaskView;
@property (nonatomic, strong)TFDailyTaskView *dailyTsakView;

@property (nonatomic ,strong) ShopStoreViewController  *shopStoreVC;
@property (nonatomic, strong)FullScreenScrollView *imgFullScrollView;

@property (nonatomic, strong)UIImage *shareRandShopImage;
@property (nonatomic, strong) YFShopCarView *carBtn; //购物车
@property (nonatomic, assign)NSInteger pubCartcount;  //购物车数量
@property (nonatomic, strong)ShopSaleModel *shopSaleModel;//购物车数据
@property (strong, nonatomic) ShareAnimationView *aView; //分享动画

@end

@implementation ComboShopDetailViewController
{
    //计时器 天 时 分 秒
    NSString *_day;
    NSString *_hour;
    NSString *_min;
    NSString *_sec;
    int pubtime;
    
    //详情 评价
    UIView *_headView;
    UIView *_footView;
    
    //按钮 状态条
    UIButton *_statebtn;
    UILabel *_statelab;
    
    ShopDetailModel *_ShopModel;
    
    //好评率
    NSString *_praise_count;
    //列表
    UITableView *_MytableView;
    
    NSArray *_SizeArray;
    NSArray *_sizeArr;
    NSMutableString *_sizestring;
    
       
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
    NSString *_selectColorID2;
    NSString *_selectColorID3;
    //选中的尺码
    NSString *_selectSize;
    NSString *_selectSizeID;
    NSString *_selectSizeID2;
    NSString *_selectSizeID3;
    
    //选中商品的名称 价格
    NSString *_selectName;
    NSString *_selectPrice;
    
    UIView *_MobleView;
    //记录数组元素多少个
    int _temp;
    
    //购物车按钮
    UIButton *_shopcartbtn;
    
    //分享按钮
    UIButton *_sharebtn;
    
    //返回按钮
    UIButton *_backbtn;
    
    UIImageView *_shopimage;
    UIImageView *_siimage;

    
    //记录图片原有的位置
    CGRect _oldframe;
    BOOL _istouch;
    
    UIPageControl *_pageview;
    
    UIView *_view;
    
    //大图片数据源
    //    NSMutableArray *_ImageDataArray;
    
    //评论当前页数
    NSInteger  _pagecount;
    
    //评论总页数
    NSInteger  _tatalpage;
    
    //回到顶部按钮
    UIButton *_UpBtn;
    
    //tableview的footview
    UIView *_tableFootView;
    
    CALayer *_layer;
    
    //商品分类数据源
    //    NSMutableArray *_shopDirvelArr;
    //商品分类ID
    //    NSMutableArray *_shopAirveIDArr;
    
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
    
    //详情标签名称
    NSMutableArray *_TagDataArray;
    NSMutableArray *_tagNameArray;
    
    NSMutableArray *_colorIDarray;
    NSMutableArray *_sizeIDarray;
    
    NSMutableArray *_Carray;
    NSMutableArray *_Sarray;
    
    //套餐类型
    NSString *p_type;
    NSString *p_seq;
    
    //套餐库存
    NSString *_stocknum;
    
    //星级指数
    NSString *_startcount;
    
    //套餐售价
    NSString *_seprice;
    
    //套餐原价
    NSString *_price;
    
    //套餐邮费
    NSString *_postage;
    
    //套餐主图
    NSString *_def_pic;
    
    //套餐总原价
    CGFloat _totalShop_price;
    //套餐总售价
    CGFloat _totalShop_Se_price;
    
    NSString* _clickbutType;
    
    int _typeCount;
    
    UIAlertView *_combBoAlterView;
 
    NSTimer *_dailyTimer_1;
    NSTimer *_dailyTimer_2;
    
    //套餐最终价格
    NSString *_combo_price;
    
    NSString *_newimage;
    
    NSString *_Shop_Code;//套餐下的商品编号
    
    NSString *_headimageurl;
    
    UIButton *_okbutton;//确认按钮
    
    NSString *_packageStock;
    
    NSString *_pubstock;
    
    UIStatusBarStyle _currentStatusBarStyle;
    
    UIView *_promptview;//加购物车成功立即结算弹框
    NSTimer *_mytimer;
    UILabel *_daojishilab;//倒计时
    NSInteger _cutdowntime;
    
    BOOL _isMove;
    
    NSString *c_time;
    NSString *s_time;
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
    
    //    NSString *path = NSHomeDirectory();//主目录
    //    //NSHomeDirectory:%@",path);
    
    self.view.backgroundColor=[UIColor whiteColor];
    _comobDataArray = [NSMutableArray array];
    _pubcolorArray = [NSMutableArray array];
    _tagDataArray1 = [NSMutableArray array];
    _tagDataArray2 = [NSMutableArray array];
    _tagDataArray3 = [NSMutableArray array];
    _tagNameArray = [NSMutableArray array];
    _TagDataArray =[NSMutableArray array];
    _colorIDarray = [NSMutableArray array];
    _sizeIDarray = [NSMutableArray array];
    _selectColorArray = [NSMutableArray array];
    _selectSizeArray = [NSMutableArray array];
    _hostDataArray = [NSMutableArray array];
    _atrrListArray = [NSMutableArray array];
    _attrDataArray = [NSMutableArray array];
    _selectIDarray = [NSMutableArray array];
    
    _isImage = NO;
    
    _sizestring=[NSMutableString stringWithCapacity:10000];
    _comeCount=0;
    
    _pagecount = 1;
    
    _currentStatusBarStyle = UIStatusBarStyleLightContent;
    
#pragma mark 三个钩钩自适应
    
    _view1.frame = CGRectMake(5, 75, kApplicationWidth*8/33, 25);
    _view2.frame = CGRectMake(kApplicationWidth*8/33, 75, kApplicationWidth*12/33, 25);
    _view3.frame = CGRectMake(kApplicationWidth*20/33, 75, kApplicationWidth*13/33, 25);
    
    self.backview.hidden=YES;
    
    [self creatBIGView];
    
    [self creatSectionView];
    
    [self creatFootView];
    
    //监听购物车通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backdetailview:) name:@"backdetailview" object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Combsharesuccess:) name:@"ComboShopsharesuccess" object:nil];

   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Combsharefail:) name:@"ComboShopsharefail" object:nil];
    
//    //监听包邮支付成功
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paysuccess:) name:@"paysuccess" object:nil];
    
    if([self.detailType isEqualToString:@"会员商品"])
    {
         [self MemberrequestHttp];
    }else{
         [self requestHttp];
    }
    
    
    [self HostrequestHttp];
}

////签到包邮支付成功回调
//- (void)paysuccess:(NSNotification*)note {
//    
//    id shopfrom = note.object;
//
//    if (_paysuccessBlock) {
//        _paysuccessBlock(shopfrom);
//    }
//}

#pragma mark - 每日任务上下午分享
- (void)dailyTaskView2
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    
    if (token!=nil) {
        NSDictionary *oldDic = [ud objectForKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],DailyTaskAfternoonShare]];
        NSDictionary *currDic = [NSDictionary dictionaryWithObjectsAndKeys:[MyMD5 getCurrTimeString:@"year-month-day"], @"year-month-day", nil];
        if (oldDic == nil||![oldDic[@"year-month-day"] isEqualToString:currDic[@"year-month-day"]]) { //不是同一天
            //判断时间是不是12-19
            /*******一天就弹出一次****/
            
            NSString *hour = [MyMD5 getCurrTimeString:@"hour"];
            if ((hour.intValue <= 23&&hour.intValue>12)||(hour.intValue < 7&&hour.intValue>=0)) {
                
                if ([_dailyTimer_2 isValid]) {
                    [_dailyTimer_2 invalidate];
                }
                
                _dailyTimer_2 = [NSTimer scheduledTimerWithTimeInterval:6*SEC_5 target:self selector:@selector(goShareShop:) userInfo:DailyTaskAfternoonShare repeats:NO];
            }
        }
    }
}
- (void)dailyTaskView1
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    if (token!=nil) {
        NSDictionary *oldDic = [ud objectForKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],DailyTaskMorningShare]];
        NSDictionary *currDic = [NSDictionary dictionaryWithObjectsAndKeys:[MyMD5 getCurrTimeString:@"year-month-day"], @"year-month-day", nil];
        if (oldDic == nil||![oldDic[@"year-month-day"] isEqualToString:currDic[@"year-month-day"]]) { //不是同一天
            //判断时间是不是7-12
            /*******一天就弹出一次****/
            NSString *hour = [MyMD5 getCurrTimeString:@"hour"];
            if (hour.intValue <= 12&& hour.intValue>=7) {
                
                if ([_dailyTimer_1 isValid]) {
                    [_dailyTimer_1 invalidate];
                }
                _dailyTimer_1 = [NSTimer scheduledTimerWithTimeInterval:6*SEC_5 target:self selector:@selector(goShareShop:) userInfo:DailyTaskMorningShare repeats:NO];
            }
        }
    }
}
- (void)goShareShop:(NSTimer *)timer
{
    //userInfo = %@", timer.userInfo);
    NSString *myType;
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    if ([timer.userInfo isEqualToString:DailyTaskMorningShare]) {
        myType = @"2";
    } else if ([timer.userInfo isEqualToString:DailyTaskAfternoonShare]) {
        myType = @"3";
    }
    kSelfWeak;
    self.dailyTsakView = [[TFDailyTaskView alloc] init];
    [self.dailyTsakView returnClick:^(NSInteger type) {
        
        NSString *theType;
        if (type == 2) {
            theType = DailyTaskMorningShare;
        } else if (type == 3) {
            theType = DailyTaskAfternoonShare;
        }
        
        //获取时间
        NSDictionary *currDic = [NSDictionary dictionaryWithObjectsAndKeys:[MyMD5 getCurrTimeString:@"year-month-day"], @"year-month-day", nil];
        //存储状态
//        [ud setObject:currDic forKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],theType]];
        
        //存储状态
        [ud setObject:currDic forKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],DailyTaskMorningShare]];
        [ud setObject:currDic forKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],DailyTaskAfternoonShare]];
        
        [ud synchronize];
        
        [weakSelf httpGetRandShopWithType:theType];
    } withCloseBlock:^(NSInteger type) {
        
        NSString *theType;
        if (type == 2) {
            theType = DailyTaskMorningShare;
        } else if (type == 3) {
            theType = DailyTaskAfternoonShare;
        }
        //获取时间
        NSDictionary *currDic = [NSDictionary dictionaryWithObjectsAndKeys:[MyMD5 getCurrTimeString:@"year-month-day"], @"year-month-day", nil];
        //存储状态
//        [ud setObject:currDic forKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],theType]];
        
        //存储状态
        [ud setObject:currDic forKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],DailyTaskMorningShare]];
        [ud setObject:currDic forKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],DailyTaskAfternoonShare]];
        
        [ud synchronize];
        
    }];
    [self.dailyTsakView showWithType:myType];
    [timer invalidate];
}


- (void)DShareManagerStatus:(SHARESTATE)shareStatus withType:(NSString *)type
{
    
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    
    //type = %@", type);
    
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
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                [HTTPTarbarNum httpRedCount];

                if ([type isEqualToString:DailyTaskMorningShare]) {
                    int flag = [responseObject[@"flag"] intValue];
                    int num = [responseObject[@"num"] intValue];
                    
                    int newFlag = [responseObject[@"newFlag"] intValue];
                    int newNum = [responseObject[@"newNum"] intValue];
                    
                    if (flag == 0) {
                        [nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", num] Controller:self];
                    }
                } else if ([type isEqualToString:DailyTaskAfternoonShare]) {
                    int flag = [responseObject[@"flag"] intValue];
                    int num = [responseObject[@"num"] intValue];
                    
                    int newFlag = [responseObject[@"newFlag"] intValue];
                    int newNum = [responseObject[@"newNum"] intValue];
                    
                    if (flag == 0) {
                        [nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", num] Controller:self];
                    }
                }
                
            } else {
                [nv showLable:responseObject[@"message"] Controller:self];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //网络连接失败");
    }];
    
}
- (void)httpGetRandShopWithType:(NSString *)myType
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *realm = [ud objectForKey:USER_REALM];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@shop/shareShop?token=%@&version=%@&realm=%@",[NSObject baseURLStr], token,VERSION, realm];
    NSString *URL = [MyMD5 authkey:urlStr];
    [MBProgressHUD showMessage:@"启动分享中,请稍后" afterDeleay:0 WithView:self.view];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //分享商品 = %@", responseObject);
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
        
    }];
    
}
- (void)httpGetShareImageWithPrice:(NSNumber *)shop_price QRLink:(NSString *)qrLink sharePicUrl:(NSString *)picUrl type:(NSString *)myType
{
    
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

- (NSMutableArray *)comboSizeArray
{
    if (_comboSizeArray == nil) {
        _comboSizeArray = [[NSMutableArray alloc] init];
    }
    return _comboSizeArray;
}

- (NSMutableArray *)comobDataArray
{
    if(_comobDataArray == nil)
    {
        _comobDataArray = [[NSMutableArray alloc] init];
    }
    
    return _comobDataArray;
}

- (NSMutableArray *)hostDataArray
{
    if(_hostDataArray == nil)
    {
        _hostDataArray = [[NSMutableArray alloc] init];
    }

    return _hostDataArray;
}

#pragma mark 普通分享成功
- (void)Combsharesuccess:(NSNotification*)note
{
    NavgationbarView *mentionview = [[NavgationbarView alloc]init];
    [mentionview showLable:@"分享成功" Controller:self];
    
    NSString *hour = [MyMD5 getCurrTimeString:@"hour"];
    if (hour.intValue <= 12&& hour.intValue>=7) {
        [self httpShareSuccessWithType:DailyTaskMorningShare];
    }else if ((hour.intValue <= 23&&hour.intValue>12)||(hour.intValue < 7&&hour.intValue>=0)){
        [self httpShareSuccessWithType:DailyTaskAfternoonShare];
        
    }else
        [self ShareSuccessHttp];
}

#pragma mark 普通分享失败
- (void)Combsharefail:(NSNotification*)note
{
    NavgationbarView *mentionview = [[NavgationbarView alloc]init];
    [mentionview showLable:@"分享失败" Controller:self];

}


- (void)startAnimation
{
    UIView *pigview =[self creatKickbackAnimationwithDurtime:1];
    [self.view addSubview:pigview];
    
    //    [self performSelector:@selector(makeVisiblebgView) withObject:self afterDelay:4.85];
    
}

-(void)zerosharesuccess:(NSNotification*)note
{
    NSString *str =note.object;
    
    if([str isEqualToString:@"zerosharesuccess"])
    {
        UIImageView *shareImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight+kUnderStatusBarStartY)];
        shareImage.image = [UIImage imageNamed:@"share0020"];
        shareImage.tag = 7171;
        [self.view addSubview:shareImage];
        
        [self performSelector:@selector(startactive) withObject:nil afterDelay:3];
        
        
    }
}

-(void)startactive
{
    UIImageView *shareimage = (UIImageView*)[self.view viewWithTag:7171];
    [shareimage removeFromSuperview];
    
    UIView *pigview =[self creatKickbackAnimationwithDurtime:1];
    [self.view addSubview:pigview];
}

#pragma mark 分享动画
- (UIView*)creatKickbackAnimationwithDurtime:(int)time
{
    
    
    UIView *animationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight+kUnderStatusBarStartY)];
    animationView.backgroundColor = [UIColor clearColor];
    animationView.alpha = 1;
    animationView.tag = 888;
    
    [self.view addSubview:animationView];
    
    [self.view bringSubviewToFront:animationView];
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight+kUnderStatusBarStartY)];
    iv.contentMode = UIViewContentModeScaleAspectFit;
    iv.center = CGPointMake(animationView.center.x, animationView.frame.size.height/2);
    
    iv.tag = 778;
    iv.userInteractionEnabled=YES;
    iv.layer.cornerRadius=iv.frame.size.width/2;
    [animationView addSubview:_animationView = iv];
    
    NSMutableArray *anArr = [NSMutableArray array];
    
    for (int i = 1 ; i<30; i++) {
        NSString *gStr = [NSString stringWithFormat:@"%@%d",@"share00",i+20];
        
        NSString *file = [[NSBundle mainBundle] pathForResource:gStr ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:file];
        [anArr addObject:image];
    }
    iv.animationImages = anArr;    //动画图片数组
    iv.animationDuration = 1.5;      //执行一次完整动画所需的时长
    iv.animationRepeatCount = time;   //无限
    [iv startAnimating];
    
    
    [self performSelector:@selector(removehareImage) withObject:nil afterDelay:1.7];
    
    return animationView;
    
}

- (void)removehareImage
{
    UIView *animationView=(UIView*)[self.view viewWithTag:888];
    
    
    [UIView animateWithDuration:1 animations:^{
        
        animationView.frame =CGRectMake(kApplicationWidth+20,animationView.frame.origin.y, animationView.frame.size.width, animationView.frame.size.height);
        
        
    } completion:^(BOOL finished) {
        
        [animationView removeFromSuperview];
        
    }];
    
}


#pragma mark 删除分享动画
- (void)makeVisiblebgView
{
    
    UIView *animationView=(UIView*)[self.view viewWithTag:888];
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        animationView.frame =CGRectMake(kApplicationWidth+20,animationView.frame.origin.y, animationView.frame.size.width, animationView.frame.size.height);
        
        
    } completion:^(BOOL finished) {
        
        [animationView removeFromSuperview];
        
    }];
    
    
    
}

#pragma mark 检测是否登录
- (void)TestLogingHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url=[NSString stringWithFormat:@"%@shop/queryUnLogin?version=%@&shop_code=%@",[NSObject baseURLStr],VERSION,self.shop_code];
    
    
    NSString *URL=[MyMD5 authkey:url];
    
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            
            if(str.intValue==1)
            {
                
            }
            
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        
    }];
    
    
}

#pragma mark 网络请求商品详情
-(void)requestHttp
{
    _totalShop_price = 0;
    _totalShop_Se_price = 0;
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    
    manager.requestSerializer.timeoutInterval = 10;
    
    
    NSString *url;
    if([self.detailType isEqualToString:@"会员商品"])
    {
        url=[NSString stringWithFormat:@"%@vip/queryShop?version=%@&code=%@&token=%@",[NSObject baseURLStr],VERSION,self.shop_code,token];
    }else if ([self.detailType isEqualToString:@"签到包邮"])
    {

        url=[NSString stringWithFormat:@"%@shop/queryPackage?version=%@&code=%@&token=%@",[NSObject baseURLStr],VERSION,self.shop_code,token];
    }
    else{
        
        if(token == nil)
        {
            url=[NSString stringWithFormat:@"%@shop/queryPUnLogin?version=%@&code=%@",[NSObject baseURLStr],VERSION,self.shop_code];
        }else{
            
            url=[NSString stringWithFormat:@"%@shop/queryPackage?version=%@&code=%@&token=%@",[NSObject baseURLStr],VERSION,self.shop_code,token];
            
        }
    }
    
    
    NSString *URL=[MyMD5 authkey:url];
    
    [[Animation shareAnimation] CreateAnimationAt:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            _praise_count=responseObject[@"praise_count"];
            
            NSDictionary *dic=responseObject[@"shopList"];
            
            if(statu.intValue==1)//请求成功
            {
                
                [[Animation shareAnimation] stopAnimationAt:self.view];
                
                _comeCount +=1;
                
                NSString *shopname =@" ";
                NSString *def_pic = @" ";
                NSString *shop_se_price = @"";
                
                if([responseObject[@"shopList"] count])
                {
                    for(NSDictionary *shopdic in responseObject[@"shopList"])
                    {
                        
                        ShopDetailModel *model=[[ShopDetailModel alloc]init];

                        MyLog(@"shopdic is %@",shopdic);
                        
                        model.shop_name=[NSString stringWithFormat:@"%@",shopdic[@"shop_name"]];
                        model.shop_code=[NSString stringWithFormat:@"%@",shopdic[@"shop_code"]];
                        _Shop_Code = model.shop_code;
                        
                        model.shop_pic=[NSString stringWithFormat:@"%@",shopdic[@"shop_pic"]];
                        model.shop_se_price=[NSString stringWithFormat:@"%@",shopdic[@"shop_se_price"]];
                        model.shop_price =[NSString stringWithFormat:@"%@",shopdic[@"shop_price"]];
                        
                        model.age = [NSString stringWithFormat:@"%@",shopdic[@"age"]];
                        model.favorite = [NSString stringWithFormat:@"%@",shopdic[@"favorite"]];
                        model.occasion = [NSString stringWithFormat:@"%@",shopdic[@"occasion"]];
                        model.pattern = [NSString stringWithFormat:@"%@",shopdic[@"pattern"]];
                        model.size = [NSString stringWithFormat:@"%@",shopdic[@"size"]];
                        model.stuff = [NSString stringWithFormat:@"%@",shopdic[@"stuff"]];
                        model.stuff2 = [NSString stringWithFormat:@"%@",shopdic[@"stuff2"]];
                        model.stuff3 = [NSString stringWithFormat:@"%@",shopdic[@"stuff3"]];
                        model.stuff4 = [NSString stringWithFormat:@"%@",shopdic[@"stuff4"]];
                        model.style = [NSString stringWithFormat:@"%@",shopdic[@"style"]];
                        model.trait = [NSString stringWithFormat:@"%@",shopdic[@"trait"]];
                        model.trait2 = [NSString stringWithFormat:@"%@",shopdic[@"trait2"]];
                        model.trait3 = [NSString stringWithFormat:@"%@",shopdic[@"trait3"]];
                        
                        
                        NSString *attr_Data = responseObject[@"attr_data"];
                        
                        [userdefaul setObject:attr_Data forKey:ATTR_DATA];
                        
                        NSMutableString *str=[NSMutableString stringWithFormat:@"%@",shopdic[@"shop_attr"]];
                        
                        NSArray *arr=[str componentsSeparatedByString:@"_"];
                        
                        

                        NSMutableArray *arr11=[NSMutableArray array];
                        
                        for(NSString *sizestr in arr)
                        {
                            [arr11 addObject:sizestr];
                        }
                        
                        [self.attrDataArray addObject:arr11];
                        
                    
                        [_comobDataArray addObject:model];
                        
                        shopname = [NSString stringWithFormat:@"%@",shopdic[@"shop_name"]];
                        def_pic = [NSString stringWithFormat:@"%@",shopdic[@"def_pic"]];
                        shop_se_price = model.shop_se_price;

                        _totalShop_price += [model.shop_price floatValue];
                        
                        _totalShop_Se_price += [model.shop_se_price floatValue];
                        
                    }
                
                    
                }
                
                
                
                if([responseObject[@"attrList"]count])
                {
                    
                    self.stock_colorArray = [NSMutableArray arrayWithArray:responseObject[@"attrList"]];
                    
                }
                
                if(responseObject[@"pShop"])
                {
                    ShopDetailModel *model =[[ShopDetailModel alloc]init];
                    
                    self.shop_code = [NSString stringWithFormat:@"%@",responseObject[@"pShop"][@"code"]];
                    
                    p_type = [NSString stringWithFormat:@"%@",responseObject[@"pShop"][@"type"]];
                    p_seq = [NSString stringWithFormat:@"%@",responseObject[@"pShop"][@"seq"]];
                    _stocknum = [NSString stringWithFormat:@"%@",responseObject[@"pShop"][@"r_num"]];
                    _startcount =[NSString stringWithFormat:@"%@",responseObject[@"star_count"]];
                    _postage = [NSString stringWithFormat:@"%@",responseObject[@"pShop"][@"postage"]];
                    
                    _price = [NSString stringWithFormat:@"%@",responseObject[@"pShop"][@"price"]];
                    
                    _def_pic = [NSString stringWithFormat:@"%@",responseObject[@"pShop"][@"def_pic"]];
                    
                    NSString *num = [NSString stringWithFormat:@"%@",responseObject[@"pShop"][@"r_num"]] ;
                    self.r_num=[NSNumber numberWithInt:num.intValue];
//                    self.p_status = [NSNumber numberWithInt:[[NSString stringWithFormat:@"%@",responseObject[@"pShop"][@"p_status"]] intValue]];
                    
                    model.shop_code = self.shop_code;
                    model.def_pic = _def_pic;
                    model.p_type = p_type;
                    
                    
                    _ShopModel=model;
                    
                    
                    [userdefaul setObject:p_type forKey:P_TYPE];
                    
                    
                }
                
                MyLog(@"_ShopModel.name =%@",_ShopModel.shop_name);
                
                //判断是单商品还是多商品来获取价格
                if([responseObject[@"shopList"] count] >1)//多商品
                {
                    _combo_price = [NSString stringWithFormat:@"%@",_price];
                    
                    _ShopModel.shop_name =[NSString stringWithFormat:@"%@",responseObject[@"pShop"][@"name"]];
                    
                }else if ([responseObject[@"shopList"] count] ==1)
                {//单商品
                    
                    if([responseObject[@"shopList"] count])
                    {
                        _combo_price = [NSString stringWithFormat:@"%@",_price];
                        
                        _ShopModel.shop_name = shopname;
                        
                        if([self.detailType isEqualToString:@"签到包邮"])
                        {
                            _def_pic = def_pic;
                            _combo_price = shop_se_price;
                        }
                    }
                    
                }
                
                _ShopModel.shop_se_price = _combo_price;
                
                
                MyLog(@"_combo_price = %@",_combo_price);
                
                _ShopModel.cart_count = [NSString stringWithFormat:@"%@",responseObject[@"cart_count"]];
                
                _ShopModel.c_time = [NSString stringWithFormat:@"%@",responseObject[@"c_time"]];
                _ShopModel.s_time = [NSString stringWithFormat:@"%@",responseObject[@"s_time"]];
                
                
                //创建视图 第二次进来的时候只创建tableview
                if(_comeCount<2)
                {
                    UIView *footview = (UIView*)[self.view viewWithTag:8181];
                    [footview removeFromSuperview];
                    
                    [self creatBIGView];
                    [self creatUI];
                    [self creatFootView];
                    [self creatAttrData];
                    
                }
                
                self.backview.hidden=NO;
                
                
                UIImageView *shopimageview=(UIImageView*)[self.view viewWithTag:6666];
                
                NSString *likeid=[NSString stringWithFormat:@"%@",_ShopModel.like_id];
                NSString *shopcode=[NSString stringWithFormat:@"%@",_ShopModel.shop_code];
                
                //加喜欢
                if(![likeid isEqualToString:shopcode])
                {
                    
                    shopimageview.image=[UIImage imageNamed:@"喜欢"];
                    
                    self.likebtn.selected=NO;
                }else{
                    
                    shopimageview.image=[UIImage imageNamed:@"喜欢-33"];
                    
                    self.likebtn.selected=YES;
                }
                
                //商品属性及库存分类查询
                [self requestShopHttp];
                
//                if([_ShopModel.c_time intValue] >0)
//                {
//                    //关闭定时器
//                    [_mytimer invalidate];
//                    
//                    [self performSelector:@selector(addpop:) withObject:nil afterDelay:0.5];
//                }

                
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
            }
            else{
                
                [self creatHeadview];
                
                self.backview.hidden=YES;
                
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:message Controller:self];
                
                
//                [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(jump) userInfo:nil repeats:NO];
                [self performSelector:@selector(jump) withObject:nil afterDelay:1.5];
            }
            
            
        }
        
        [_MyBigtableview reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //[MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
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
    if([self.detailType isEqualToString:@"会员商品"])
    {
        url=[NSString stringWithFormat:@"%@vip/queryShop?version=%@&code=%@&token=%@",[NSObject baseURLStr],VERSION,self.shop_code,token];
    }else{
        
        if(token == nil)
        {
            url=[NSString stringWithFormat:@"%@shop/queryPUnLogin?version=%@&code=%@",[NSObject baseURLStr],VERSION,self.shop_code];
        }else{
            
            url=[NSString stringWithFormat:@"%@shop/queryPackage?version=%@&code=%@&token=%@",[NSObject baseURLStr],VERSION,self.shop_code,token];
            
        }
    }
    
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            
            if(statu.intValue==1)//请求成功
            {
                _ShopModel.cart_count = [NSString stringWithFormat:@"%@",responseObject[@"cart_count"]];
            
                _carBtn.markNumber = _ShopModel.cart_count.intValue>99?99:_ShopModel.cart_count.intValue;
                
                _pubCartcount = _carBtn.markNumber;
            }

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
    
    }];
}



- (void)MemberrequestHttp
{
    _totalShop_price = 0;
    _totalShop_Se_price = 0;
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    
    manager.requestSerializer.timeoutInterval = 10;
    
    
    NSString *url;
        url=[NSString stringWithFormat:@"%@vip/queryShop?version=%@&code=%@&token=%@",[NSObject baseURLStr],VERSION,self.shop_code,token];
       
    
    NSString *URL=[MyMD5 authkey:url];
    
    [[Animation shareAnimation] CreateAnimationAt:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            _praise_count=responseObject[@"praise_count"];
            
            NSDictionary *dic=responseObject[@"shop"];
            
            if(statu.intValue==1)//请求成功
            {
                
                [[Animation shareAnimation] stopAnimationAt:self.view];
                
                _comeCount +=1;
                
                NSString *shopname;
                
                if(responseObject[@"shop"] !=nil)
                {

                    NSDictionary *shopdic = responseObject[@"shop"];
                    {
                        
                        ShopDetailModel *model=[[ShopDetailModel alloc]init];
                        
                        MyLog(@"shopdic is %@",shopdic);
                        
                        model.shop_name=[NSString stringWithFormat:@"%@",shopdic[@"shop_name"]];
                        model.shop_code=[NSString stringWithFormat:@"%@",shopdic[@"shop_code"]];
                        _Shop_Code = model.shop_code;
                        
                        model.shop_pic=[NSString stringWithFormat:@"%@",shopdic[@"shop_pic"]];
                        model.def_pic = [NSString stringWithFormat:@"%@",shopdic[@"def_pic"]];
                        model.shop_se_price=[NSString stringWithFormat:@"%@",shopdic[@"shop_se_price"]];
                        model.shop_price =[NSString stringWithFormat:@"%@",shopdic[@"shop_price"]];
                        
                        model.age = [NSString stringWithFormat:@"%@",shopdic[@"age"]];
                        model.favorite = [NSString stringWithFormat:@"%@",shopdic[@"favorite"]];
                        model.occasion = [NSString stringWithFormat:@"%@",shopdic[@"occasion"]];
                        model.pattern = [NSString stringWithFormat:@"%@",shopdic[@"pattern"]];
                        model.size = [NSString stringWithFormat:@"%@",shopdic[@"size"]];
                        model.stuff = [NSString stringWithFormat:@"%@",shopdic[@"stuff"]];
                        model.stuff2 = [NSString stringWithFormat:@"%@",shopdic[@"stuff2"]];
                        model.stuff3 = [NSString stringWithFormat:@"%@",shopdic[@"stuff3"]];
                        model.stuff4 = [NSString stringWithFormat:@"%@",shopdic[@"stuff4"]];
                        model.style = [NSString stringWithFormat:@"%@",shopdic[@"style"]];
                        model.trait = [NSString stringWithFormat:@"%@",shopdic[@"trait"]];
                        model.trait2 = [NSString stringWithFormat:@"%@",shopdic[@"trait2"]];
                        model.trait3 = [NSString stringWithFormat:@"%@",shopdic[@"trait3"]];
                        
                        _ShopModel=model;
                        
                        NSMutableString *str=[NSMutableString stringWithFormat:@"%@",shopdic[@"shop_attr"]];
                        
                        NSArray *arr=[str componentsSeparatedByString:@"_"];
                
                        NSMutableArray *arr11=[NSMutableArray array];
                        
                        for(NSString *sizestr in arr)
                        {
                            [arr11 addObject:sizestr];
                        }
                        
                        [self.attrDataArray addObject:arr11];
                        
                        
                        [_comobDataArray addObject:model];
                        
                        MyLog(@"self.attrDataArray = %@",self.attrDataArray);
                        
                        
                        shopname = [NSString stringWithFormat:@"%@",shopdic[@"shop_name"]];
                        
                        MyLog(@"_ShopModel.name =%@",shopname);
                        
                    }
                    
                }
                
                if([responseObject[@"attrList"]count])
                {
                    
                    self.stock_colorArray = [NSMutableArray arrayWithArray:responseObject[@"attrList"]];
                    
                }
                
                if([responseObject[@"shop"][@"stockList"] count])
                {
                    for(NSDictionary *stockdic in responseObject[@"shop"][@"stockList"])
                    {
                    
                        ShopDetailModel *model =[[ShopDetailModel alloc]init];
                        
                        self.shop_code = [NSString stringWithFormat:@"%@",stockdic[@"shop_code"]];
                       
                        _stocknum = [NSString stringWithFormat:@"%@",stockdic[@"stock"]];
                                                
                        _price = [NSString stringWithFormat:@"%@",stockdic[@"shop_price"]];
                        _seprice = [NSString stringWithFormat:@"%@",stockdic[@"price"]];
                        
                        _def_pic = [NSString stringWithFormat:@"%@",stockdic[@"pic"]];
                        
                        
                        
                        model.shop_name = [NSString stringWithFormat:@"%@",responseObject[@"shop"][@"shop_name"]];
                        
                        model.shop_price =[NSString stringWithFormat:@"%@",stockdic[@"shop_price"]];
                        model.shop_se_price=[NSString stringWithFormat:@"%@",stockdic[@"price"]];
                        
                        MyLog(@"model.shop_se_price=%@",model.shop_se_price);
                        
                        model.stock_type_id =stockdic[@"id"];
                        model.shop_code = self.shop_code;
                        model.def_pic = _def_pic;
                        model.p_type = p_type;
                        
                        
//                        _ShopModel=model;
                        
                        
                        [userdefaul setObject:p_type forKey:P_TYPE];
                    }
                }
                MyLog(@"_ShopModel.name =%@",_ShopModel.shop_name);
                
                //判断是单商品还是多商品来获取价格
                if([responseObject[@"shopList"] count] >1)//多商品
                {
                    _combo_price = [NSString stringWithFormat:@"%@",_price];
                    
                    _ShopModel.shop_name =[NSString stringWithFormat:@"%@",responseObject[@"pShop"][@"name"]];
                    
                }else{//单商品
                    
                    if([responseObject[@"shopList"] count])
                    {
                        _combo_price = [NSString stringWithFormat:@"%f",_totalShop_Se_price];
                        
                        _ShopModel.shop_name = shopname;
                    }
                    
                }
                
                _ShopModel.shop_se_price = _combo_price;
                
                
                MyLog(@"_combo_price = %@",_combo_price);
                
                _ShopModel.cart_count = [NSString stringWithFormat:@"%@",responseObject[@"cart_count"]];
                
                //创建视图 第二次进来的时候只创建tableview
                if(_comeCount<2)
                {
                    UIView *footview = (UIView*)[self.view viewWithTag:8181];
                    [footview removeFromSuperview];
                    
                    
                    [self creatBIGView];
                    [self creatFootView];
                    
                    [self creatAttrData];
                    
                    
                }
                
                self.backview.hidden=NO;
                
                
                UIImageView *shopimageview=(UIImageView*)[self.view viewWithTag:6666];
                
                NSString *likeid=[NSString stringWithFormat:@"%@",_ShopModel.like_id];
                NSString *shopcode=[NSString stringWithFormat:@"%@",_ShopModel.shop_code];
                
                
                //商品属性及库存分类查询
                [self requestShopHttp];
                
                
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
            }
            else{
                
                [self creatHeadview];
                
                self.backview.hidden=YES;
                
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:message Controller:self];
                
                
//                [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(jump) userInfo:nil repeats:NO];
                [self performSelector:@selector(jump) withObject:nil afterDelay:1.5];
            }
        }
        
        [_MyBigtableview reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //[MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        
        
    }];

}


#pragma mark 删除数据库属性列表
-(void)deleteTable:(NSString*)tableName
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
            }
            
            
            
        }
        
    }
    
    
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
            [self closeDB];
            return result;
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

#pragma mark - 数据库

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
    
    
    return YES;
}


- (void)jump
{
    LoginViewController *login=[[LoginViewController alloc]init];
    
    login.tag=1000;
    [self.navigationController pushViewController:login animated:YES];
    
    //    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //    app.window.rootViewController = login;
    //    UINavigationController *navv=[[UINavigationController alloc] initWithRootViewController:login];
    //    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //    app.window.rootViewController = navv;
}

#pragma mark //保存所有看过的商品信息
-(void)AddmystepsHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url;
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    NSString *realm = [userdefaul objectForKey:USER_REALM];
    
    url=[NSString stringWithFormat:@"%@mySteps/addSteps?version=%@&token=%@&shop_code=%@&realm=%@",[NSObject baseURLStr],VERSION,token,self.shop_code,realm];
    
    NSString *URL=[MyMD5 authkey:url];
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    //    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //[MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        //
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            
            if(statu.intValue==1)//请求成功
            {
                
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //[MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
    }];
    
    
    
}

#pragma mark 商品属性及库存分类查询
-(void)requestShopHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSMutableString *codestring=[[NSMutableString alloc]init];
    if(_comobDataArray.count)
    {
        for(int i=0;i<_comobDataArray.count;i++)
        {
            ShopDetailModel *model = _comobDataArray[i];
            [codestring appendString:model.shop_code];
            [codestring appendString:@","];
        }
    }
    NSString *ccc;
    
    if(codestring.length>1)
    {
        ccc=[codestring substringToIndex:[codestring length]-1];
        codestring = [NSMutableString stringWithString:ccc];
    }
    

    NSString *url;
    
    url=[NSString stringWithFormat:@"%@shop/queryPAttr?version=%@&shop_codes=%@",[NSObject baseURLStr],VERSION,codestring];
    
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
                    tpyemodel.shop_name=dic[@"shop_name"];
                    tpyemodel.shop_price=dic[@"shop_price"];
                    tpyemodel.kickback=dic[@"two_kickback"];
                    tpyemodel.shop_code=dic[@"shop_code"];
                    tpyemodel.supp_id = dic[@"supp_id"];
                    
                    
                    [self.stocktypeArray addObject:tpyemodel];
                }
                
            }
            
        }
        
        
        MyLog(@"库存self.stocktypeArray = %@",self.stocktypeArray);
        
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

#pragma mark 热卖推荐网络请求
-(void)HostrequestHttp
{
    [_hostDataArray removeAllObjects];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url;
    
    url=[NSString stringWithFormat:@"%@shop/queryOption?version=%@&type=2",[NSObject baseURLStr],VERSION];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        responseObject = [NSDictionary changeType:responseObject];
    
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            
            if(statu.intValue==1)//请求成功
            {
                NSArray *arr = responseObject[@"centShops"];
                
                if(arr.count)
                {
                    for(NSDictionary *dic in arr)
                    {
                        ShopDetailModel *model = [[ShopDetailModel alloc]init];
                        
                        model.shop_id = [NSString stringWithFormat:@"%@",dic[@"id"]];
                        model.remark = [NSString stringWithFormat:@"%@",dic[@"remark"]];
                        model.shop_code = [NSString stringWithFormat:@"%@",dic[@"shop_code"]];
                        model.shop_name = [NSString stringWithFormat:@"%@",dic[@"shop_name"]];
                        model.type = [NSString stringWithFormat:@"%@",dic[@"type"]];
                        model.pic = [NSString stringWithFormat:@"%@",dic[@"url"]];
                        
                        [_hostDataArray addObject:model];
                        
                    }
                
                }
                
                 _typeCount = (int)_hostDataArray.count/2 + _hostDataArray.count%2;
                
                [_MyBigtableview reloadData];
                
            }
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
    
    
}



#pragma mark 评论网络请求
-(void)commentHttp
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url;
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    
    url=[NSString stringWithFormat:@"%@shopComment/selCommentByShop?version=%@&shop_code=%@&token=%@&page=%d&pager.order=%@",[NSObject baseURLStr],VERSION,self.shop_code,token,(int)_pagecount,@"desc"];
    
    NSString *URL=[MyMD5 authkey:url];
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    //    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        MyLog(@"商品评论 res = %@",responseObject);
        
        [self.MyBigtableview footerEndRefreshing];
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            
            if ([responseObject[@"status"] intValue] == 1) {
                
//                _pagecount ++;
                
                if (_pagecount == 1) {
                    [self.commentDataArray removeAllObjects];
                }
                
                
                
                for (NSDictionary *comments in responseObject[@"comments"]) {
                    
                    NSDictionary *dic = comments;
                    
                    if(![responseObject[@"pager"] isEqual:[NSNull null]] )
                    {
                        NSString *str =[NSString stringWithFormat:@"%@",responseObject[@"pager"][@"pageCount"] ];
                        
                        _tatalpage = str.intValue;
                    }else{
                        _tatalpage =1 ;
                    }
                    
                    
                    TFCommentModel *cModel = [[TFCommentModel alloc] init];
                    [cModel setValuesForKeysWithDictionary:dic];
                    cModel.ID = dic[@"id"];
                    
                    if (cModel.commentModel.isComment == NO&&cModel.suppCommentModel.isComment == NO&&cModel.suppEndCommentModel.isComment == NO) {
                        //
                        cModel.cellType = 1; //评
                    }
                    if (cModel.commentModel.isComment == NO&&cModel.suppCommentModel.isComment == YES&&cModel.suppEndCommentModel.isComment == NO) {
                        cModel.cellType = 2; //评+回
                    }
                    if (cModel.commentModel.isComment == YES&&cModel.suppCommentModel.isComment == NO&&cModel.suppEndCommentModel.isComment == NO) {
                        cModel.cellType = 3; //评+追
                    }
                    if (cModel.commentModel.isComment == YES&&cModel.suppCommentModel.isComment == YES&&cModel.suppEndCommentModel.isComment == NO) {
                        cModel.cellType = 4; //评+回+追
                    }
                    if (cModel.commentModel.isComment == YES&&cModel.suppCommentModel.isComment==NO&&cModel.suppEndCommentModel.isComment == YES) {
                        cModel.cellType = 5; //评+追+回
                    }
                    if (cModel.commentModel.isComment == YES&&cModel.suppCommentModel.isComment == YES&&cModel.suppEndCommentModel.isComment == YES) {
                        cModel.cellType = 6; //评+回+追＋回
                    }
                    //                //%@",cModel);
                    [self.commentDataArray addObject:cModel];
                }
                
                //            UIButton *button=(UIButton*)[self.view viewWithTag:1002];
                //            [button setTitle:[NSString stringWithFormat:@"评论(%d)",(int)_commentDataArray.count-1] forState:UIControlStateNormal];
                
                [self.MyBigtableview reloadData];
                
                
                
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
                
                [[Animation shareAnimation] stopAnimationAt:self.view];
            }
            
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
#pragma mark 网络请求包邮是否下过单
- (void)isBaoyouHttpRequest
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    
    NSString *url;
    url=[NSString stringWithFormat:@"%@order/ckOneActivity?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    NSString *URL=[MyMD5 authkey:url];
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            
            if(statu.intValue==1)
            {
                if(responseObject[@"flag"])
                {
                    self.flag = responseObject[@"flag"];
                }
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
    }];
    
}

#pragma mark 获取购物车ID
-(void)getshopCartID:(NSString*)typeid withKickback:(NSString*)shopkickback andOriginal_price:(NSString *)original_price
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    
    NSString *url=[NSString stringWithFormat:@"%@shopCart/getCartData?num=%@&version=%@&token=%@",[NSObject baseURLStr],@"1",VERSION,token];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            
            if(str.intValue==1)
            {
                NSString *ID = responseObject[@"id"];
                
                [self insertToDB:ID expired:NO num:0];
                
            }else{
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:@"添加商品失败" Controller:self];
            }
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        
    }];
    
}
#pragma mark 同步数据到数据库
-(void)insertToDB:(NSString*)ID expired:(BOOL)expired num:(NSInteger)num
{
    _okbutton.enabled = YES;
    
    NSMutableArray *muarray = [NSMutableArray array];
    NSArray *shopstoryarr = [_ShopModel.stock_type_id componentsSeparatedByString:@","];
    for(int i = 0 ;i<shopstoryarr.count;i++)
    {
        for(int j =0;j<self.stocktypeArray.count;j++)
        {
            
            ShopDetailModel *model =self.stocktypeArray[j];
            if([model.stock_type_id isEqualToString:shopstoryarr[i]])
            {
                NSString *selectcolor = [self getColor:model.color_size];
                SaleListModel *smodel = [SaleListModel new];
                smodel.color = selectcolor;        //颜色
                smodel.expired = NO;         //是否失效
                smodel.shop_code = model.shop_code;    //商品编号
                smodel.shop_price = [model.shop_price floatValue];   //商品价格
                smodel.stock_type_id = [model.stock_type_id integerValue];//库存ID
                smodel.supp_id = [model.supp_id integerValue];      //供应商ID
                [muarray addObject:smodel];
                break;
            }
        }
    }
    
    _shopSaleModel = [ShopSaleModel new];
    _shopSaleModel.ID = [ID integerValue];
    _shopSaleModel.p_code = self.shop_code;//
    _shopSaleModel.p_type = [p_type integerValue];//
    _shopSaleModel.p_name = _ShopModel.shop_name;
    _shopSaleModel.def_pic = _ShopModel.def_pic;
    _shopSaleModel.shop_num = 1;//
    _shopSaleModel.shop_price = [@(_totalShop_price) floatValue];//
    _shopSaleModel.shop_se_price = [_combo_price floatValue];//
    _shopSaleModel.p_s_t_id = p_seq;//
    _shopSaleModel.postage = [_postage floatValue];//
    _shopSaleModel.valid = NO;
    _shopSaleModel.expired = NO;
    _shopSaleModel.date_time = [NSDate date].timeIntervalSince1970;//
    _shopSaleModel.shop_list = muarray;
    BOOL isSuc = [ShopCarManager insertToDB:_shopSaleModel];
    
    if (!isSuc) {
        NSLog(@"大于20件");
    }
    
    //加购物车成功之后的方法
    [self cartReady];
    if(!expired)
        [self addshopcartHttp:nil withKickback:nil];

}

#pragma mark 加入购物车网络请求
-(void)addshopcartHttp:(NSString*)typeids withKickback:(NSString*)shopkickback
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString*token=[user objectForKey:USER_TOKEN];
    NSString *storecode=[user objectForKey:STORE_CODE];
    
    
    NSMutableString *datastring = [[NSMutableString alloc]init];
    NSMutableArray *newdataArray = [NSMutableArray array];
    
    CGFloat totalPrice ;
    CGFloat totalShopSeprice;
    NSMutableString *stockID = [[NSMutableString alloc]init];
    

    NSArray *shopstoryarr = [_ShopModel.stock_type_id componentsSeparatedByString:@","];
    MyLog(@"shopstoryarr = %@",shopstoryarr);
    
    NSString *supp_id;
    
    for(int i = 0 ;i<shopstoryarr.count;i++)
    {
       
        MyLog(@"self.stocktypeArray = %@",self.stocktypeArray);
        
        for(int j =0;j<self.stocktypeArray.count;j++)
        {
        
            ShopDetailModel *model =self.stocktypeArray[j];
            
            
            if([model.stock_type_id isEqualToString:shopstoryarr[i]])
            {
                NSString *selectcolor = [self getColor:model.color_size];

                NSMutableDictionary *userdic = [NSMutableDictionary dictionary];
                [userdic setValue:model.shop_code forKey:@"shop_code"];
                [userdic setValue:selectcolor forKey:@"color"];
                
                [userdic setValue:[NSString stringWithFormat:@"%@",model.stock_type_id] forKey:@"stock_type_id"];
                [userdic setValue:[NSString stringWithFormat:@"%@",model.supp_id] forKey:@"supp_id"];
                
                supp_id = [NSString stringWithFormat:@"%@",model.supp_id];
                
                [newdataArray addObject:userdic];
                
                [userdic setValue:model.shop_price forKey:@"shop_price"];
                [userdic setValue:model.shop_se_price forKey:@"price"];
                
                totalPrice += [model.shop_price floatValue];
                totalShopSeprice += [model.shop_se_price floatValue];
                
                [stockID appendString:[NSString stringWithFormat:@"%@",model.stock_type_id]];
                [stockID appendString:@","];
                
                break;
            }
        }
        
        p_seq = stockID;
    }
    
    if(p_seq.length>0)
    {
        p_seq = [p_seq substringToIndex:[p_seq length] - 1];
    
    }
    
    MyLog(@"p_seq = %@",p_seq);
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:newdataArray options:0 error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    datastring = [NSMutableString stringWithString:jsonStr];
    
    
    int shopnum = 1;
    
    NSString *url;

    NSString *ID = [NSString stringWithFormat:@"%ld",_shopSaleModel.ID];
    
    url=[NSString stringWithFormat:@"%@shopCart/addList?version=%@&token=%@&p_code=%@&store_code=%@&cartJson=%@&p_type=%d&shop_price=%.2f&shop_se_price=%.2f&p_s_t_id=%@&shop_num=%d&postage=%@&supp_id=%@&id=%@",[NSObject baseURLStr],VERSION,token,self.shop_code,storecode,datastring,p_type.intValue,_totalShop_price ,[_combo_price floatValue],p_seq,shopnum,_postage,supp_id,ID];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
         _okbutton.enabled = YES;
        
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

#pragma mark 加购物车成功之后的方法
- (void)cartReady
{
    _okbutton.enabled = YES;
    
    NavgationbarView *mentionview=[[NavgationbarView alloc]init];
    [mentionview showLable:@"添加商品成功" Controller:self];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"RFTCart"];//用于刷新tabbar的购物车
    
    int cart1= (int)[ShopCarManager sharedManager].s_count ;
    int cart2= (int)[ShopCarManager sharedManager].p_count ;
    
    if(cart2>0)
    {
        //购物车商品数量加1
        _carBtn.isAnimation = YES;
        _carBtn.markNumber = cart2;
        
        //tarbar上面购物车的数量
        [Mtarbar showBadgeOnItemIndex:3];
//        [Mtarbar changeBadgeNumOnItemIndex:3 withNum:[NSString stringWithFormat:@"%d",cart1+cart2]];
        [Mtarbar changeBadgeNumOnItemIndex:3 withNum:[NSString stringWithFormat:@"%d",cart2]];

    }
    
//    NSDate *date = [NSDate date];
//    [[NSUserDefaults standardUserDefaults]setObject:date forKey:CARTENDDATE];//用于刷新tabbar的购物车
    
    [self performSelector:@selector(addpop:) withObject:nil afterDelay:0.5];
    
    if(self.imgFullScrollView)
    {
        [UIView animateWithDuration:0.5 animations:^{
            
            self.imgFullScrollView.alpha=0;
            
        } completion:^(BOOL finished) {
            
            [self.imgFullScrollView removeFromSuperview];
            
        }];
        
    }


}

- (void)addpop:(NSString *)type
{
    if(![type isEqualToString:@"商品详情"])
    {
        //加购物车成功提示框
        _carBtn.isAnimation = NO;
        [_carBtn animationCar];
        [self showTishiview];
    }
    
    pubtime = 0;
    
    if(_isMove == NO)
    {
        _isMove = YES;
    }
    
    //加购物车成功倒计时
    [self loadTime];
    
    [self performSelector:@selector(userinrerYES) withObject:nil afterDelay:0.5];
}

- (void)userinrerYES
{
    //加入购物车按钮可点
    UIButton *buyBtn = (UIButton*)[self.view viewWithTag:3000];
    buyBtn.userInteractionEnabled = YES;
}

- (void)markmessage:(id)object
{
    NavgationbarView *mentionview=[[NavgationbarView alloc]init];
    [mentionview showLable:object Controller:self];
}

#pragma mark 普通分享成功后调用接口
-(void)ShareSuccessHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    
    NSString *url=[NSString stringWithFormat:@"%@order/ integralDoShare?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            
            if(str.intValue==1)
            {
                
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        //        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
    
    
}

#pragma mark 加喜欢
-(void)likerequestHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url;
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    
    url=[NSString stringWithFormat:@"%@like/addPLike?version=%@&p_code=%@&token=%@",[NSObject baseURLStr],VERSION,self.shop_code,token];
    
    NSString *URL=[MyMD5 authkey:url];

    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            
            NavgationbarView *alertview=[[NavgationbarView alloc] init];
            if(statu.intValue==1)//请求成功
            {
                
                
                UIImageView *shopimageview=(UIImageView*)[self.view viewWithTag:6666];
                
                
                shopimageview.image= [UIImage imageNamed:@"喜欢-33"];
                
                self.likebtn.selected=YES;
                
                
                UIImageView *view= [[UIImageView alloc]initWithFrame:CGRectMake(kApplicationWidth/2, 0, 0, 0)];
                view.tag=9999;
                view.image=[UIImage imageNamed:@"加心效果"];
                
                [self.view addSubview:view];
                //    将当前view放到首层
                [self.view bringSubviewToFront:view];
                
                
                _oldframe=view.frame;
                
                [UIView animateWithDuration:0.5 animations:^{
                    view.center=CGPointMake(kApplicationWidth/2, kApplicationHeight/2);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.5 animations:^{
                        view.frame = CGRectMake((kApplicationWidth-100)/2, (kApplicationHeight-100)/2, 100, 100);
                    }];
                }];
                
                
//                NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(disapper:) userInfo:nil repeats:NO];
                [self performSelector:@selector(disapper:) withObject:nil afterDelay:3];
            }else{
                
                
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:@"加喜欢失败" Controller:self];
            }
            
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

#pragma mark 取消喜欢
-(void)dislikerequestHttp
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url;
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSMutableString *shopcodestr = [[NSMutableString alloc]init];
    for(int i=0;i<_comobDataArray.count;i++)
    {
        ShopDetailModel *model = _comobDataArray[i];
        
        [shopcodestr appendString:[NSString stringWithFormat:@"%@",model.shop_code]];
        [shopcodestr appendString:@","];
        
    }
    
    NSString *codestr = [shopcodestr substringToIndex:[shopcodestr length]-1];
    
    url=[NSString stringWithFormat:@"%@like/delLike?version=%@&shop_code=%@&token=%@&p_code=%@",[NSObject baseURLStr],VERSION,codestr,token,self.shop_code];
    
    NSString *URL=[MyMD5 authkey:url];
   
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(statu.intValue==1)//请求成功
            {
                
                UIImageView *shopimage=(UIImageView*)[self.view viewWithTag:6666];
                
                
                shopimage.image = [UIImage imageNamed:@"喜欢"];
                
                self.likebtn.selected=NO;
                
                message=@"不再喜欢此宝贝";
                
                
            }else{
                message=@"取消喜欢失败";
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
            
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

#pragma mark 创建导航条
-(void)creatHeadview
{
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 64)];
    headview.image = [UIImage imageNamed:@"zhezhao"];
    headview.tag = 3838;
    
    [self.view addSubview:headview];
    headview.backgroundColor=[UIColor clearColor];
    headview.userInteractionEnabled=YES;
    
    _backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _backbtn.frame=CGRectMake(-10, 20, 80, 44);
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
    
    
    
    
    CGFloat scale = 2;
    CGFloat imagescale = 1;
    
    
    if([self.detailType isEqualToString:@"会员商品"] || [self.detailType isEqualToString:@"签到包邮"])
    {
        //分享
        _sharebtn=[[UIButton alloc]init];
        _sharebtn.frame =CGRectMake(kApplicationWidth-SE(19)-IMGSIZEW(@"icon_fenxiang")-ZOOM(20), 16, IMGSIZEW(@"icon_fenxiang")*scale, IMGSIZEH(@"icon_fenxiang")*scale);
        
        _sharebtn.backgroundColor = [UIColor clearColor];
        [_sharebtn addTarget:self action:@selector(shareclick:) forControlEvents:UIControlEventTouchUpInside];
        
        _siimage = [[UIImageView alloc]initWithFrame:CGRectMake((_sharebtn.frame.size.width-IMGSIZEW(@"icon_fenxiang")*imagescale)/2, 13, IMGSIZEW(@"icon_fenxiang")*imagescale, IMGSIZEH(@"icon_fenxiang")*imagescale)];
        _siimage.image = [UIImage imageNamed:@"icon_fenxiang"];
 
    }else{
        
        //联系客服
        _sharebtn=[[UIButton alloc]init];
        _sharebtn.frame =CGRectMake(kApplicationWidth-SE(19)-IMGSIZEW(@"shop_lxkf-")-ZOOM(20), 18, IMGSIZEW(@"shop_lxkf-")*scale, IMGSIZEH(@"shop_lxkf-")*scale);
        
        _sharebtn.backgroundColor = [UIColor clearColor];
        [_sharebtn addTarget:self action:@selector(shareclick:) forControlEvents:UIControlEventTouchUpInside];
        
        _siimage = [[UIImageView alloc]initWithFrame:CGRectMake((_sharebtn.frame.size.width-IMGSIZEW(@"shop_lxkf-")*imagescale)/2, 13, IMGSIZEW(@"shop_lxkf-")*imagescale, IMGSIZEH(@"shop_lxkf-")*imagescale)];
        _siimage.image = [UIImage imageNamed:@"shop_lxkf-"];

    }
    
    [_sharebtn addSubview:_siimage];

    [self.view addSubview:_sharebtn];
    
    
    //购物车
    _shopcartbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _shopcartbtn.frame=CGRectMake(_sharebtn.frame.origin.x-SE(37.5)-IMGSIZEW(@"icon_fenxiang")+ZOOM(40), 15, IMGSIZEW(@"icon_gouwuche")*scale, IMGSIZEH(@"icon_gouwuche")*scale);
    _shopcartbtn.backgroundColor = [UIColor clearColor];
    
    [_shopcartbtn addTarget:self action:@selector(cartclick:) forControlEvents:UIControlEventTouchUpInside];
    
    _shopimage = [[UIImageView alloc]initWithFrame:CGRectMake((_shopcartbtn.frame.size.width-IMGSIZEW(@"icon_gouwuche")*imagescale)/2, 13, IMGSIZEW(@"icon_gouwuche"), IMGSIZEH(@"icon_gouwuche"))];
    _shopimage.image = [UIImage imageNamed:@"icon_gouwuche"];
    
    [_shopcartbtn addSubview:_shopimage];
    
    
//    _carBtn.markNumber = _ShopModel.cart_count.intValue;
    
    if([self.detailType isEqualToString:@"会员商品"] || [self.detailType isEqualToString:@"签到包邮"])
    {
        [self.view addSubview:_shopcartbtn];
    }
    
    
    UIButton *totopbtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    totopbtn.frame=CGRectMake(60, 0, kApplicationWidth-160, 40);
    [totopbtn addTarget:self action:@selector(upToTop:) forControlEvents:UIControlEventTouchUpInside];
    
    [headview addSubview:totopbtn];
    
    if([self.detailType isEqualToString:@"会员商品"])
    {
        _shopcartbtn.hidden = YES;
        _sharebtn.hidden = YES;
    }else if ([self.detailType isEqualToString:@"签到包邮"]){
        _shopcartbtn.hidden = NO;
    }
    
    
}

- (void)creatTableFootView
{
    _tableFootView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight-64+kUnderStatusBarStartY)];
    _tableFootView.backgroundColor=tarbarrossred;
    
    [self footViewAddChildView];
    
}


- (void)creatUI
{
    if([self.detailType isEqualToString:@"签到包邮"])
    {
        //去夺宝
        UIButton *baoyouBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        baoyouBtn.frame = CGRectMake(self.Headimage.frame.size.width-ZOOM6(150)-10, self.Headimage.frame.size.height-ZOOM6(190), ZOOM6(150), ZOOM6(150));
        
        [baoyouBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d%@",[_combo_price intValue],@"yuanduobao_hover"]] forState:UIControlStateNormal];
        
        [baoyouBtn addTarget:self action:@selector(goduobao:) forControlEvents:UIControlEventTouchUpInside];
        
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
    
//    _carBtn.markNumber = _ShopModel.cart_count.intValue;
    
    //评论数
    if(_ShopModel.eva_count.intValue>0)
    {
        UIButton *commentbtn=(UIButton*)[_headView viewWithTag:1002];
        //        NSString *str =[NSString stringWithFormat:@"评论(%d)",_ShopModel.eva_count.intValue];
        NSString *str =[NSString stringWithFormat:@"评论"];
        [commentbtn setTitle:str forState:UIControlStateNormal];
        
    }
    
    
    CGFloat imgheigh=900*kApplicationWidth/600;
    self.Headimage.frame=CGRectMake(0, self.Headimage.frame.origin.y, kApplicationWidth, imgheigh);
    
    CGFloat headimageYY=CGRectGetMaxY(self.Headimage.frame);
    
    self.backview.frame=CGRectMake(0, headimageYY, kApplicationWidth, self.backview.frame.size.height);
    
    //商品名
    
    self.shopname.frame = CGRectMake(ZOOM(42), ZOOM(15*3.375), kScreenWidth-2*ZOOM(42), ZOOM(15*3.375));
    self.shopname.numberOfLines = 0;
    
    self.shopname.text = [self exchangeTextWihtString:_ShopModel.shop_name];
    self.shopname.textColor = RGBCOLOR_I(62, 62, 62);
    
    if([self.detailType isEqualToString:@"签到包邮"])
    {
        self.shopname.textColor = tarbarrossred;
        self.shopname.text = [NSString stringWithFormat:@"%@%@",_ShopModel.shop_name,@"(购买成功后即可完成签到任务)"];
        
        NSMutableAttributedString *noteStr ;
        if(self.shopname.text)
        {
            noteStr = [[NSMutableAttributedString alloc]initWithString:self.shopname.text];
        }
        
        [noteStr addAttribute:NSForegroundColorAttributeName value:RGBCOLOR_I(62, 62, 62) range:NSMakeRange(0, _ShopModel.shop_name.length)];
        
        [self.shopname setAttributedText:noteStr];
        
        _postage = @"0";
    }
    
    self.shopname.font = [UIFont systemFontOfSize:ZOOM(15*3.375)];
    
    //星级指数
    
    self.startview.frame = CGRectMake(kScreenWidth-ZOOM(342)-ZOOM(100), ZOOM(40), ZOOM(300), ZOOM(60));
    self.startview.hidden = YES;
    
    MyLog(@"%f",self.startview.frame.origin.x);
    
    TFStartScoreView *tav = [[TFStartScoreView alloc] initWithFrame:CGRectMake(0, 0, ZOOM(320), ZOOM(60))];
    [self.startview addSubview:tav];
    CGFloat startfolt=[_startcount floatValue];
    [tav setScore:startfolt];
    
    //打分
    
    self.posttage.frame=CGRectMake(kScreenWidth-ZOOM(100)-ZOOM(42), self.shopname.frame.origin.y-3, ZOOM(100), ZOOM(60));
    self.posttage.hidden = YES;
    
    self.posttage.text=[NSString stringWithFormat:@"%@",_startcount];
    
    self.posttage.font = [UIFont systemFontOfSize:ZOOM(60)];
    
    self.posttage.textColor = tarbarrossred;
    
    
    if([self.typestring isEqualToString:@"兑换"])
    {
        CGFloat olldpriceY = CGRectGetMaxY(self.shopname.frame);
        
        //实价
        self.se_price.text=[NSString stringWithFormat:@"%.1f分",[_combo_price floatValue]];
        
        //原价
        self.oldprice.frame=CGRectMake(ZOOM(67), olldpriceY+ZOOM(69), self.oldprice.frame.size.width, self.oldprice.frame.size.height);
        
        self.oldprice.text=[NSString stringWithFormat:@"%@分",[_combo_price floatValue]];
        //回佣
        //        NSString *kickback=_ShopModel.kickback;
        
        //        self.huiyong.text=[NSString stringWithFormat:@"回佣%@元",kickback];
        
        
    }else{
        
        CGFloat olldpriceY = CGRectGetMaxY(self.shopname.frame);
        
        //出售价
        
        self.se_price.frame=CGRectMake(_shopname.frame.origin.x, olldpriceY+ZOOM(10*3.4), self.se_price.frame.size.width, ZOOM(18*3.4));
        
        self.se_price.text=[NSString stringWithFormat:@"￥%.1f",[_combo_price floatValue]];
        if([self.detailType isEqualToString:@"会员商品"])
        {
            self.se_price.text=[NSString stringWithFormat:@"￥%.1f",[_seprice floatValue]];
        }

        self.se_price.font = [UIFont systemFontOfSize:ZOOM(18*3.4)];
        self.se_price.textColor = tarbarrossred;
        [self.se_price setFont:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM(18*3.4)]];
        
        UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:ZOOM(19*3.4)];
        
        NSDictionary *attributes1 = @{NSFontAttributeName:font};
        
        CGSize se_price_textSize = [self.se_price.text boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes1 context:nil].size;
        self.se_price.frame=CGRectMake(_shopname.frame.origin.x, self.se_price.frame.origin.y, se_price_textSize.width, self.se_price.frame.size.height);
        
        CGFloat sepriceX = CGRectGetMaxX(self.se_price.frame);
        
        
        //原价
        self.oldprice.frame=CGRectMake(sepriceX , olldpriceY+ZOOM(10*3.4)+ZOOM(5*3.4), self.oldprice.frame.size.width, ZOOM(12*3.4));
        
        self.oldprice.text=[NSString stringWithFormat:@"￥%.1f",_totalShop_price];
        if([self.detailType isEqualToString:@"会员商品"])
        {
            self.oldprice.text=[NSString stringWithFormat:@"￥%.1f",[_ShopModel.shop_price floatValue]];
        }

        self.oldprice.font = [UIFont systemFontOfSize:ZOOM(12*3.4)];
        self.oldprice.textColor = RGBCOLOR_I(168, 168, 168);
        
        NSDictionary *attributes2 = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(13*3.4)]};
        CGSize textSize = [self.oldprice.text boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes2 context:nil].size;
        
        self.oldprice.frame = CGRectMake(sepriceX , self.oldprice.frame.origin.y, textSize.width, self.oldprice.frame.size.height);
        
        self.priceline.frame=CGRectMake(sepriceX+2,self.oldprice.frame.origin.y + self.oldprice.frame.size.height/2, textSize.width-4, self.priceline.frame.size.height);

        //回佣
        
        CGFloat discountY = CGRectGetMinY(self.se_price.frame);
    
        UIView *view = (UIView*)[self.view viewWithTag:1919];
        [view removeFromSuperview];
        
        
        self.discountCount.tag=1919;
        
        self.discountCount.text = [NSString stringWithFormat:@"邮费:%.1f元",[_postage floatValue]];
        
        
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(46)]};
        CGSize textSize1 = [self.discountCount.text boundingRectWithSize:CGSizeMake(1000, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
        
    
        self.discountCount.frame=CGRectMake(kScreenWidth-ZOOM(42)-textSize1.width-10,discountY+2, textSize1.width+10, ZOOM(50));
        
        self.discountCount.textAlignment =NSTextAlignmentRight;
        
        self.discountCount.font = [UIFont systemFontOfSize:ZOOM(46)];
        
        self.discountCount.textColor = tarbarrossred;
        
        NSMutableAttributedString *noteStr ;
        if(self.discountCount.text)
        {
            noteStr = [[NSMutableAttributedString alloc]initWithString:self.discountCount.text];
        }
        
        [noteStr addAttribute:NSForegroundColorAttributeName value:kTextColor range:NSMakeRange(0, 3)];
        [self.discountCount setAttributedText:noteStr];
        
        [self.backview addSubview:self.discountCount];

        
    }
    
    CGFloat lineY =CGRectGetMaxY(self.se_price.frame);
    
    self.line1.frame = CGRectMake(0, lineY+20, kApplicationWidth, 1);
    self.view1.frame = CGRectMake(ZOOM(50), lineY+25, self.image1.frame.size.width + ZOOM(170), self.view1.frame.size.height);
    
    self.view1.center=CGPointMake(kApplicationWidth/4, lineY+25+15);
    
    self.title1.text = @"全场特价";
    self.title1.font = [UIFont systemFontOfSize:ZOOM(40)];
    
    
    UILabel *lableLine = [[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth/2, self.view1.frame.origin.y+2.5, 1, self.view1.frame.size.height-5)];
    lableLine.backgroundColor=kBackgroundColor;
    [self.backview addSubview:lableLine];
    
    UILabel *lableline2 =[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view1.frame)+7, kApplicationWidth, 1)];
    lableline2.backgroundColor = kBackgroundColor;
    [self.backview addSubview:lableline2];

    
    CGFloat view2X = CGRectGetMaxX(self.view1.frame);
    self.view2.frame = CGRectMake(view2X+ZOOM(50) , lineY+25, ZOOM(360), self.view2.frame.size.height);
    
    self.view2.center =CGPointMake(kApplicationWidth - kApplicationWidth/4-ZOOM(40), lineY+25+15);
    
    self.title2.frame = CGRectMake(self.title2.frame.origin.x, self.title2.frame.origin.y, ZOOM(360), self.title2.frame.size.height);
    
    self.title2.font = [UIFont systemFontOfSize:ZOOM(40)];
    
    
    CGFloat view3X = CGRectGetMaxX(self.view2.frame);
    self.view3.frame = CGRectMake(view3X, lineY+25, ZOOM(320), self.view3.frame.size.height);
    self.title3.frame = CGRectMake(self.title3.frame.origin.x, self.title3.frame.origin.y, ZOOM(320), self.title3.frame.size.height);
    self.title3.font = [UIFont systemFontOfSize:ZOOM(34)];
    
    self.backview.frame = CGRectMake(0, self.backview.frame.origin.y, kApplicationWidth, lineY+20 +self.view3.frame.size.height +10);
    
    self.view3.hidden = YES;
    
    
    //是会员商品做如下处理
    
    CGFloat smallbackheigh = 0;
    if([self.detailType isEqualToString:@"会员商品"])
    {
        self.view1.hidden = YES;
        self.view2.hidden = YES;

        smallbackheigh = 35;
        
//        _ShopModel.def_pic =_ShopModel.def_pic;
        
    }else{
        _ShopModel.def_pic =_def_pic;
    }
    
    
    CGFloat backviewYY=CGRectGetMaxY(self.backview.frame);
    
    self.Myscrollview.frame=CGRectMake(0, self.Myscrollview.frame.origin.y, kApplicationWidth, backviewYY-smallbackheigh);


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
        
        
        MyLog(@"_ShopModel.def_pic = %@ _shop_code=%@",_ShopModel.def_pic,_Shop_Code);
        
        if(_ShopModel.def_pic)
        {
            
            MyLog(@"_Shop_Code = %@",_Shop_Code);
            
            NSMutableString *code = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",_Shop_Code]];
            
            NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
            MyLog(@"supcode =%@",supcode);
            
            _newimage = [NSString stringWithFormat:@"%@/%@/%@",supcode,_Shop_Code,_ShopModel.def_pic];
            MyLog(@"newurl = %@",_newimage);
            
        }
        
        
        NSURL *imgUrl ;
        
        if([self.detailType isEqualToString:@"会员商品"] || [self.detailType isEqualToString:@"签到包邮"])
        {
            imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],_newimage,st]];
        }else{
            imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],_ShopModel.def_pic,st]];
        }
        
        __block float d = 0;
        __block BOOL isDownlaod = NO;
        
        CGFloat imgheigh=900*kApplicationWidth/600;
        
        MyLog(@"imgheigh is %f",imgheigh);
        
        
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
           
            
            if([self.detailType isEqualToString:@"会员商品"] || [self.detailType isEqualToString:@"签到包邮"])
            {
                 _headimageurl = _newimage;
            }else{
                _headimageurl = _ShopModel.def_pic;
            }

            
            [self.Headimage addGestureRecognizer:tap];

        }
        
        
    }
    

    [self creatBigTableview];
    
    [self creatHeadview];
    
    
    [self upToTop];
    
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

#pragma mark 去夺宝
- (void)goduobao:(UIButton*)sender
{
    IndianaDetailViewController *shopdetail=[[IndianaDetailViewController alloc]init];
    shopdetail.shop_code=self.duobao_shop_code;
    shopdetail.baoyou_shop_code = self.shop_code;
    shopdetail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:shopdetail animated:YES];

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
    
    
    //    NSString *comstr=[NSString stringWithFormat:@"评论(%d)",_ShopModel.eva_count.intValue];
    NSString *comstr=[NSString stringWithFormat:@"热卖推荐"];
    
    NSArray *titleArr=@[@"商品详情",@"参数",comstr];
    CGFloat btnwidh=kApplicationWidth/titleArr.count;
    for(int i=0;i<titleArr.count;i++)
    {
        //按钮
        _statebtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _statebtn.frame=CGRectMake(btnwidh*i, 0, btnwidh, 40);
        [_statebtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [_statebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _statebtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM(45)];
        _statebtn.tag=1000+i;
        [_statebtn addTarget:self action:@selector(butclick:) forControlEvents:UIControlEventTouchDown];
        [headview addSubview:_statebtn];
        
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
            [_statebtn setTitleColor:tarbarrossred forState:UIControlStateNormal];;
            _statebtn.selected=YES;
            self.slectbtn=_statebtn;
            
            self.BigDataArray =[NSMutableArray arrayWithArray:self.dataArr];
        }
        
    }
    
    _headView=headview;
    
}

#pragma mark 创建列表视图
-(void)creatBigTableview
{
    
    self.MyBigtableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight+kUnderStatusBarStartY) style:UITableViewStylePlain];
    
    self.MyBigtableview.delegate=self;
    self.MyBigtableview.dataSource=self;
    
    self.MyBigtableview.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.Myscrollview.frame=CGRectMake(0, 0, kScreenWidth, self.Myscrollview.frame.size.height+5);
    
    [self.MyBigtableview setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    self.Myscrollview.clipsToBounds = YES;
    
    
    self.MyBigtableview.tableHeaderView=self.Myscrollview;
    
    self.MyBigtableview.tableFooterView=_tableFootView;
    
    [self.view addSubview:self.MyBigtableview];
    
    
    [self.MyBigtableview registerNib:[UINib nibWithNibName:@"OneCommentCell" bundle:nil] forCellReuseIdentifier:@"ONECOMMENTCELL"];
    [self.MyBigtableview registerNib:[UINib nibWithNibName:@"TwoCommentCell" bundle:nil] forCellReuseIdentifier:@"TWOCOMMENTCELL"];
    [self.MyBigtableview registerNib:[UINib nibWithNibName:@"ThreeCommentCell" bundle:nil] forCellReuseIdentifier:@"THREECOMMENTCELL"];
    [self.MyBigtableview registerNib:[UINib nibWithNibName:@"FourCommentCell" bundle:nil] forCellReuseIdentifier:@"FOURCOMMENTCELL"];
    [self.MyBigtableview registerNib:[UINib nibWithNibName:@"FiveCommentCell" bundle:nil] forCellReuseIdentifier:@"FIVECOMMENTCELL"];
    [self.MyBigtableview registerNib:[UINib nibWithNibName:@"SixCommentCell" bundle:nil] forCellReuseIdentifier:@"SIXCOMMENTCELL"];

    
}

#pragma mark 加购物车成功提示弹框
- (void)creatTishiview
{
    _promptview = [[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight+40+kUnderStatusBarStartY, kApplicationWidth, 40)];
    _promptview.backgroundColor = [UIColor blackColor];
    _promptview.alpha = 0.9;
    _promptview.userInteractionEnabled = YES;
    [self.view addSubview:_promptview];
    [self.view bringSubviewToFront:_promptview];
    
    UITapGestureRecognizer *carttap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cartgo:)];
    [_promptview addGestureRecognizer:carttap];
    
    
    UILabel *titlelable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_promptview.frame)-150, 40)];
    titlelable.text = @" 商品将保留30分钟";
    titlelable.font = [UIFont systemFontOfSize:ZOOM(47)];
    titlelable.textColor = [UIColor whiteColor];
    [_promptview addSubview:titlelable];
    
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-20-10, 10, 20, 20)];
    image.image = [UIImage imageNamed:@"shop-go-"];
    [_promptview addSubview:image];
    
    UILabel *settlementlable = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-30-80, 0, 80, 40)];
    settlementlable.text = @"立即结算";
    settlementlable.font = [UIFont systemFontOfSize:ZOOM(47)];
    settlementlable.textColor = tarbarrossred;
    [_promptview addSubview:settlementlable];
    
}

- (void)showTishiview
{
    if (!_promptview) {
        [self creatTishiview];
        
        UIView *footview = (UIView *)[self.view viewWithTag:8181];
        [self.view bringSubviewToFront:footview];
    }
    [UIView animateKeyframesWithDuration:1.0 delay:1.1 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        _promptview.frame = CGRectMake(0, kApplicationHeight-50-40+kUnderStatusBarStartY, kApplicationWidth, 40);
    } completion:^(BOOL finished) {
        
    }];
    [self performSelector:@selector(dismissPromptview) withObject:nil afterDelay:60];
}
- (void)dismissPromptview
{
    if (!_promptview) {
        return;
    }
    
    [UIView animateWithDuration:1.0 animations:^{
        
        
        _promptview.frame = CGRectMake(0, kApplicationHeight+30+kUnderStatusBarStartY, kApplicationWidth, 40);
        
    } completion:^(BOOL finished) {
        
        [_promptview removeFromSuperview];
        _promptview = nil;
        
    }];
    
    
}

- (void)cartgo:(UITapGestureRecognizer*)tap
{
    kSelfWeak;
    [self loginVerifySuccess:^{
//        WTFCartViewController *shoppingcart =[[WTFCartViewController alloc]init];
//        shoppingcart.segmentSelect = CartSegment_ZeroType;
//        shoppingcart.CartType = Cart_NormalType;
//        [weakSelf.navigationController pushViewController:shoppingcart animated:YES];
        NewShoppingCartViewController *shoppingcart =[[NewShoppingCartViewController alloc]init];
        shoppingcart.ShopCart_Type = ShopCart_NormalType;
        shoppingcart.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:shoppingcart animated:YES];

    }];
}

#pragma mark 加购物车成功倒计时
- (void)timerFireMethod:(NSTimer*)time
{
    if(pubtime > 0) {
        int min = pubtime/60;
        int sec = pubtime%60;
        _carBtn.time = [NSString stringWithFormat:@"%02d:%02d",min,sec];
        pubtime--;
    } else {
        [_mytimer invalidate];
        _mytimer = nil;
        _carBtn.time = @"00:00";
        _isMove = NO;
        [self getShopCartFromDB:NO];
    }
}

- (void)loadTime {
    pubtime = (int)[ShopCarManager sharedManager].s_deadline;
   
    if (_mytimer==nil) {
        _mytimer = [NSTimer weakTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    }
}

#pragma mark 创建脚底视图
-(void)creatFootView
{
//    [self creatTishiview];
    
    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight-50+kUnderStatusBarStartY, kApplicationWidth, 50)];
    footView.backgroundColor=[UIColor whiteColor];
    footView.tag = 8181;
    [self.view addSubview:footView];
    
    [self.view bringSubviewToFront:footView];
    
    NSArray *arr=[NSArray alloc];
    
    if([self.detailType isEqualToString:@"会员商品"]){
        
        arr=@[@"立即购买"];
        
    }else if ([self.detailType isEqualToString:@"签到包邮"])
    {
        arr=@[@"签到专享,立即疯抢!"];
    }
    else{

        arr=@[@"加入购物车"];
    }
    
    CGFloat likebtn ;
    if([self.detailType isEqualToString:@"会员商品"]){
        
        likebtn = ZOOM(150*3.4);
    }else{
        likebtn = ZOOM(100*3.4);
    }


    //分割线
    UILabel *butlable1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth-100, 1)];
    butlable1.backgroundColor=kBackgroundColor;
    
    UILabel *butlable2=[[UILabel alloc]initWithFrame:CGRectMake(likebtn, 1, 1, 49)];
    butlable2.backgroundColor=kBackgroundColor;
    
    UILabel *butlable3=[[UILabel alloc]initWithFrame:CGRectMake(likebtn*2, 1, 1, 49)];
    butlable3.backgroundColor=kBackgroundColor;
    
    [footView addSubview:butlable1];
    [footView addSubview:butlable2];
//    [footView addSubview:butlable3];
    
    
    CGFloat space;
    if (ThreeAndFiveInch) {
        space=0;
    } else if (FourInch) {
        space=0;
    } else if (FourAndSevenInch) {
        space=30;;
    } else if (FiveAndFiveInch) {
        space=40;;
    }
    
       //分享 购物车
    for(int i=0;i<2;i++)
    {
        if(i==0)
        {
            UIButton *shopbtn= [[UIButton alloc]init];
            shopbtn.frame=CGRectMake(likebtn*i,0, likebtn, 50);
            shopbtn.tintColor=[UIColor blackColor];
            shopbtn.tag=4000+i;
            
            [footView addSubview:shopbtn];
            
            UIImageView *shopimageview=[[UIImageView alloc] init];
            UILabel *titlelable=[[UILabel alloc]initWithFrame:CGRectMake(0, 30, likebtn, 20)];
            titlelable.textAlignment=NSTextAlignmentCenter;
            titlelable.font=[UIFont systemFontOfSize:ZOOM(34)];
            titlelable.textColor=kTextColor;
            [shopbtn addSubview:shopimageview];
            [shopbtn addSubview:titlelable];
            if([self.detailType isEqualToString:@"会员商品"] || [self.detailType isEqualToString:@"签到包邮"])
            {
                shopimageview.frame=CGRectMake((likebtn-IMGSIZEW(@"icon_lianxikefu"))/2, 8, IMGSIZEW(@"icon_lianxikefu"), IMGSIZEH(@"icon_lianxikefu"));
                shopimageview.image=[UIImage imageNamed:@"icon_lianxikefu"];
                shopimageview.contentMode=UIViewContentModeScaleAspectFit;
                
                titlelable.text=@"联系客服";
            }else{
            
                shopimageview.frame=CGRectMake((likebtn-IMGSIZEW(@"shop_fenxiang-"))/2, 8, IMGSIZEW(@"shop_fenxiang-"), IMGSIZEH(@"shop_fenxiang-"));
                shopimageview.image=[UIImage imageNamed:@"shop_fenxiang-"];
                shopimageview.contentMode=UIViewContentModeScaleAspectFit;
                
                titlelable.text=@"分享";

                shopbtn.selected = NO;
                
                _aView = [[ShareAnimationView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
                [shopimageview addSubview:_aView];
                NSString *time = [[NSUserDefaults standardUserDefaults] objectForKey:ShareAnimationTime];
                NSString *currTime = [MyMD5 getCurrTimeString:@"year-month-day"];
                if (time == nil || ![time isEqualToString:currTime]) {
                    [_aView animationStart:YES];
                } else {
                    [_aView animationStart:NO];
                }
            }
            
            
            [shopbtn addTarget:self action:@selector(shopClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }else{
            _carBtn = [[YFShopCarView alloc] initWithFrame:CGRectMake(likebtn*i,0, likebtn, 50)];
            _carBtn.tag = 4000+i;
            _carBtn.markNumber = _pubCartcount;
            
            kSelfWeak;
            _carBtn.btnClick = ^(YFShopCarView *view){
                [weakSelf shopClick:(UIButton *)view];
            };
            [footView addSubview:_carBtn];
        }
    }
    
    CGFloat Shopbtnwidh=(kApplicationWidth-likebtn*2);
    CGFloat contactbtnXX = likebtn*2;
    if([self.detailType isEqualToString:@"会员商品"] || [self.detailType isEqualToString:@"签到包邮"])
    {
        Shopbtnwidh=(kApplicationWidth-likebtn);
        contactbtnXX = likebtn;
    }

    for(int i=0;i<arr.count;i++)
    {
        UIButton *contactbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        contactbtn.frame=CGRectMake(contactbtnXX, 0, Shopbtnwidh, 50);
        
        contactbtn.tintColor=tarbarrossred;
        [contactbtn setTitle:arr[i] forState:UIControlStateNormal];
        contactbtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM(50)];
        contactbtn.tag=3000+i;
        [contactbtn addTarget:self action:@selector(contactClick:) forControlEvents:UIControlEventTouchUpInside];
                
        if(i==0)
        {
           
            if(self.r_num.intValue == 0 || self.isSaleOut == YES )
            {
                contactbtn.enabled = NO;
                
                [contactbtn setTitleColor:RGBCOLOR_I(197, 197, 197) forState:UIControlStateNormal];
            }
            
            if([self.detailType isEqualToString:@"会员商品"]){
                contactbtn.backgroundColor=tarbarrossred;
                contactbtn.tintColor=[UIColor whiteColor];
            }else if ([self.detailType isEqualToString:@"签到包邮"]){
            
                contactbtn.backgroundColor=tarbarrossred;
                contactbtn.tintColor=[UIColor whiteColor];
                contactbtn.tag=3001;
                
                [contactbtn setImage:[UIImage imageNamed:@"icon_go"] forState:UIControlStateNormal];
                
                NSDictionary *attributes1 = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(50)]};
                
                CGSize strSize = [contactbtn.titleLabel.text boundingRectWithSize:CGSizeMake(300, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes1 context:nil].size;

                
               
                CGFloat totalLen = strSize.width + 10 + IMAGEW(@"icon_go");
                CGFloat titleRightInset = (CGRectGetWidth(contactbtn.frame)- totalLen) / 2;
                
                [contactbtn setImageEdgeInsets:UIEdgeInsetsMake(0, CGRectGetWidth(contactbtn.frame)-titleRightInset-IMAGEW(@"icon_go"), 0, 10-strSize.width)];
                
                [contactbtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10-IMAGEW(@"icon_go"), 0, titleRightInset)];
            }else{
            
                contactbtn.backgroundColor=tarbarrossred;
                contactbtn.tintColor=[UIColor whiteColor];
                
                if(self.r_num.intValue == 0 || self.isSaleOut == YES )
                {
                    contactbtn.enabled = NO;
                    contactbtn.backgroundColor=RGBCOLOR_I(197, 197, 197);
                    [contactbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }
            }
            
        }
//        else if(i==1)
//        {
//            contactbtn.backgroundColor=tarbarrossred;
//            contactbtn.tintColor=[UIColor whiteColor];
//            
//            if(self.r_num.intValue == 0 && self.r_num !=nil)
//            {
//                contactbtn.enabled = NO;
//                contactbtn.backgroundColor=RGBCOLOR_I(197, 197, 197);
//                [contactbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//                
//            }
//            
//        }
        
        [footView addSubview:contactbtn];
    }
    
    int cart1= (int)[ShopCarManager sharedManager].s_count ;
    
    if(cart1>0)
//    if(_ShopModel.cart_count.intValue > 0)
    {
        [_mytimer invalidate];
        _mytimer = nil;
        [self addpop:@"商品详情"];
    }
    
}

//#pragma mark 分享视图
//- (void)creatShareModelView
//{
//    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight)];
//    backview.backgroundColor = [UIColor blackColor];
//    backview.tag=9797;
//    backview.alpha=0.8;
//    [self.view addSubview:backview];
//    
//    UITapGestureRecognizer *viewtap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disapperview:)];
//    [backview addGestureRecognizer:viewtap];
//    backview.userInteractionEnabled = YES;
//
//    
//    _shareModelview = [[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight+30, kApplicationWidth, ZOOM(680))];
//    _shareModelview.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:_shareModelview];
//    [_shareModelview bringSubviewToFront:self.view];
//    
//    UILabel *titlelable = [[UILabel alloc]initWithFrame:CGRectMake(10, ZOOM(100), kApplicationWidth-20, 30)];
//    titlelable.text = @"亲,福利手慢则无,快分享给其他姐妹吧";
//    titlelable.textAlignment = NSTextAlignmentCenter;
//    titlelable.font = [UIFont systemFontOfSize:ZOOM(51)];
//    titlelable.textColor = kTitleColor;
//    [_shareModelview addSubview:titlelable];
//    
//    CGFloat titlelable1Y = CGRectGetMaxY(titlelable.frame);
//    
//    UILabel *titlelable1 = [[UILabel alloc]initWithFrame:CGRectMake(10, titlelable1Y+ZOOM(30), kApplicationWidth-20, 40)];
//    titlelable1.text = [NSString stringWithFormat:@"可提现的%.1f元现金红包在等着您",_ShopModel.kickback.floatValue];
//    
//    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(51)]};
//    CGSize textSize = [titlelable1.text boundingRectWithSize:CGSizeMake(1000, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
//    
//    CGSize cSize = [[UIScreen mainScreen] bounds].size;
//    
//    titlelable1.frame=CGRectMake((cSize.width-textSize.width-20)/2, titlelable1Y+ZOOM(20), textSize.width+20, 30);
//    
//    titlelable1.textAlignment = NSTextAlignmentCenter;
//    titlelable1.font = [UIFont systemFontOfSize:ZOOM(51)];
//    titlelable1.textColor = [UIColor whiteColor];
//    titlelable1.backgroundColor=tarbarrossred;
//    titlelable1.clipsToBounds=YES;
//    titlelable1.layer.cornerRadius=titlelable1.frame.size.height/2;
//    
////    [_shareModelview addSubview:titlelable1];
//    
//    
//    CGFloat lablelineY =CGRectGetMaxY(titlelable.frame);
//    
//    UILabel *lableline = [[UILabel alloc]initWithFrame:CGRectMake(0, lablelineY+ZOOM(50), kApplicationWidth, 1)];
//    lableline.backgroundColor = kBackgroundColor;
//    
//    [_shareModelview addSubview:lableline];
//    
//
//    NSArray *titleArray = @[@"微信好友",@"朋友圈",@"QQ"];
//    
//    //分享平台
//    for (int i=0; i<3; i++) {
//        
//        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        shareBtn.frame = CGRectMake(100*i+(kApplicationWidth-260)/2,CGRectGetMaxY(lableline.frame)+ZOOM(80), 60, 60);
//        shareBtn.tag = 9000+i;
//        [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
//        
//        UILabel *sharetitle = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(shareBtn.frame)-20, CGRectGetMaxY(shareBtn.frame), CGRectGetWidth(shareBtn.frame)+40, 30)];
//        sharetitle.text = titleArray[i];
//        sharetitle.font = [UIFont systemFontOfSize:ZOOM(40)];
//        sharetitle.textAlignment = NSTextAlignmentCenter;
//        
//        if (i==0) {//微信好友
//            
//            
//            //判断设备是否安装微信
//            
//            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
//                
//                //判断是否有微信
//                
//                
//                [shareBtn setBackgroundImage:[UIImage imageNamed:@"微信好友"] forState:UIControlStateNormal];
//                
//            }else {
//                
//                shareBtn.userInteractionEnabled=NO;
//                shareBtn.hidden=YES;
//                sharetitle.hidden = YES;
//                
//            }
//            
//        }else if (i==1){//微信朋友圈
//            
//            
//            //判断设备是否安装微信
//            
//            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
//                
//                //判断是否有微信
//                
//                
//                [shareBtn setBackgroundImage:[UIImage imageNamed:@"朋友圈-1"] forState:UIControlStateNormal];
//                
//            }else {
//                
//                shareBtn.userInteractionEnabled=NO;
//                shareBtn.hidden=YES;
//                sharetitle.hidden = YES;
//                
//            }
//            
//            
//            
//        }else{//QQ空间
//            
//            
//            //判断设备是否安装QQ
//            
//            if ([QQApi isQQInstalled])
//            {
//                //判断是否有qq
//                
//                
//                [shareBtn setBackgroundImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
//                
//            }else{
//                
//                shareBtn.userInteractionEnabled=NO;
//                shareBtn.hidden=YES;
//                sharetitle.hidden = YES;
//            }
//            
//            
//        }
//        [_shareModelview addSubview:sharetitle];
//        [_shareModelview addSubview:shareBtn];
//        
//    }
//
//    [UIView animateWithDuration:0.3 animations:^{
//        
//        _shareModelview.frame=CGRectMake(0, kApplicationHeight-ZOOM(680)+kUnderStatusBarStartY,   kApplicationWidth, ZOOM(680));
//        
//    } completion:^(BOOL finished) {
//        
//        
//    }];
//    
//    
//}

#pragma mark 分享视图
- (void)creatShareModelView
{
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight+kUnderStatusBarStartY)];
    backview.tag=9797;
    
    
    UITapGestureRecognizer *viewtap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disapperview:)];
    [backview addGestureRecognizer:viewtap];
    backview.userInteractionEnabled = YES;
    
    [self.view addSubview:backview];
    
    _shareModelview = [[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight+30, kApplicationWidth, SHAREMODELVIEW_HEIGH)];
    _shareModelview.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_shareModelview];
    

    UIView *shareBaseView = [[UIView alloc]initWithFrame:CGRectMake(0,ZOOM6(60), kScreenWidth, SHAREMODELVIEW_HEIGH+kUnderStatusBarStartY)];
    shareBaseView.backgroundColor = [UIColor whiteColor];
    [_shareModelview addSubview:shareBaseView];
    
    NSArray *titleArray = @[@"微信好友",@"朋友圈",@"QQ"];
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
                [shareBtn setBackgroundImage:[UIImage imageNamed:@"微信好友"] forState:UIControlStateNormal];
                
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
    
    backview.backgroundColor =[UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        backview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        
        _shareModelview.frame=CGRectMake(0, kApplicationHeight-SHAREMODELVIEW_HEIGH+kUnderStatusBarStartY, kApplicationWidth, SHAREMODELVIEW_HEIGH);
        
    } completion:^(BOOL finished) {
        
        
    }];
    
    
}

- (void)dismissShareView
{
//    UIButton * shopbtn = (UIButton*)[self.view viewWithTag:4001];
//    shopbtn.selected = NO;
    
    [self disapperShare];
    
}


- (void)creatAttrModelView:(NSString*)viewtype
{

    [_selectIDarray removeAllObjects];
    
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
    
    NSURL *imgUrl;
    NSString *st = @"!280";
    
    if([self.detailType isEqualToString:@"会员商品"] || [self.detailType isEqualToString:@"签到包邮"])
    {
        imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],_newimage,st]];
    }else{
        imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],_ShopModel.def_pic,st]];
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
    
    _modelimage.contentMode = UIViewContentModeScaleToFill;
    _modelimage.tag=3579;
    [_modelview addSubview:_modelimage];
    
    //名称
    UILabel *namelab=[[UILabel alloc]initWithFrame:CGRectMake(_modelimage.frame.origin.x+_modelimage.frame.size.width +15, _modelimage.frame.origin.y-5, kApplicationWidth-180, 30)];
    namelab.numberOfLines=0;
    namelab.font = [UIFont systemFontOfSize:ZOOM(46)];
    namelab.textColor =kTitleColor;
    namelab.tag=4321;
    namelab.text = [self exchangeTextWihtString:_ShopModel.shop_name];
    [_modelview addSubview:namelab];
    
    //价格
    UILabel *pricelab=[[UILabel alloc]initWithFrame:CGRectMake(_modelimage.frame.origin.x+_modelimage.frame.size.width +15, _modelimage.frame.origin.y+20, 200, 30)];
    pricelab.text=[NSString stringWithFormat:@"￥%.1f",[_combo_price floatValue]];
    
    if([self.detailType isEqualToString:@"会员商品"])
    {
        pricelab.text=[NSString stringWithFormat:@"￥%.1f",[_seprice floatValue]];
    }
    pricelab.font = [UIFont systemFontOfSize:ZOOM(46)];
    pricelab.tag=8765;
    pricelab.textColor=tarbarrossred;
    pricelab.font=[UIFont systemFontOfSize:16];
    [_modelview addSubview:pricelab];
    
    //邮费
    UILabel *postagelable = [[UILabel alloc]initWithFrame:CGRectMake(pricelab.frame.origin.x, CGRectGetMaxY(pricelab.frame), 150, 30)];
    postagelable.text = [NSString stringWithFormat:@"邮费:%.1f元",[_postage floatValue]];
    postagelable.textColor = tarbarrossred;
    postagelable.font = [UIFont systemFontOfSize:ZOOM(46)];
    [_modelview addSubview:postagelable];
    
    NSMutableAttributedString *noteStr ;
    if(postagelable.text)
    {
        noteStr = [[NSMutableAttributedString alloc]initWithString:postagelable.text];
    }
    [noteStr addAttribute:NSForegroundColorAttributeName value:kTextColor range:NSMakeRange(0, 3)];
    [postagelable setAttributedText:noteStr];
    
    
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
    modelscrollview.contentSize = CGSizeMake(0, 300);

    [_modelview addSubview:modelscrollview];
    
    //商品积分类属性
    
    CGFloat scrollviewHeigh=0;
    CGFloat bigviewYY =0;
    CGFloat titleviewHeigh = 25;

    if([self.detailType isEqualToString:@"签到包邮"]){
        titleviewHeigh = 0;
    }
    
    for(int i =0;i<self.atrrListArray.count;i++)//整个套餐下的商品
    {
        NSMutableString *attrstr = self.atrrListArray[i];
        
        NSArray *attrArr = [attrstr componentsSeparatedByString:@";"];
        MyLog(@"attrArr is ******%@",attrArr);
        
        UIView *bigbackview =[[UIView alloc]init];
        bigbackview.frame =CGRectMake(0, 300*i, kScreenWidth, 300);
        [modelscrollview addSubview:bigbackview];
        
        //商品标题
        
        UILabel *titleview = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(50), 10, 80, titleviewHeigh)];
        titleview.backgroundColor=[UIColor blackColor];
        titleview.text = [NSString stringWithFormat:@"商品%d",i+1];
        titleview.textColor = [UIColor whiteColor];
        titleview.textAlignment = NSTextAlignmentCenter;
        titleview.font = [UIFont systemFontOfSize:ZOOM(51)];
        [bigbackview addSubview:titleview];

        CGFloat yPoint = CGRectGetHeight(titleview.frame);
        UIView *backview;
        
        NSMutableArray *attr_typearr= [NSMutableArray array];
        
        int attrcount = 0;
        if([self.detailType isEqualToString:@"会员商品"])
        {
            attrcount = 2;
        }else{

            attrcount = (int)attrArr.count-1;
        }
        
        for(int j =0;j<attrcount;j++)//商品下的分类
        {
           
            backview = [[UIView alloc]initWithFrame:CGRectMake(0, yPoint, kApplicationWidth, 0)];
            [bigbackview addSubview:backview];
            
            
            UIButton *colorbtn;
            CGFloat btnwidh=(kScreenWidth-(20+ZOOM(50)*2))/5;
            CGFloat btnheigh = 35;
            CGFloat spacewith = 5;
            
            MyLog(@"attrArrstr =%@",attrArr[j]);
            NSString *ttt=attrArr[j];
            NSArray *brr;
            if(ttt !=nil || ![ttt isEqualToString:@""])
            {
                brr= [ttt componentsSeparatedByString:@","];
            }
            
            MyLog(@"brr=%@ brr.count=%d",brr,brr.count);
            
            if(brr.count >1)
            {
                for(int k=1;k<brr.count-1;k++)//分类下的属性
                {
                    
                    //分类标题
                    UILabel *colorlable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(50), 10, 200, 25)];
                    colorlable.text=[self findNamefromID:brr[0]];
                    
                    colorlable.textColor =kTextColor;
                    colorlable.font = [UIFont systemFontOfSize:ZOOM(40)];
                    [backview addSubview:colorlable];
                    
                    colorbtn=[[UIButton alloc]init];
                    
                    int XX = (k-1)%5;
                    int YY = (k-1)/5;
                    
                    colorbtn.frame=CGRectMake(ZOOM(50)+(btnwidh+spacewith)*XX, CGRectGetMaxY(colorlable.frame)+(btnwidh*0.6+10)*YY+5, btnwidh, btnwidh*0.6);
                    
                    MyLog(@"brr[k]=%@",brr[k]);
                    
                    NSString *st = [self findNamefromID:brr[k]];
                    
                    MyLog(@"st = %@",st);
                    if([MyMD5 asciiLengthOfString:st] > 16)
                    {
                        colorbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(30)];
                    }else{
                        colorbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
                    }
                    
                    [colorbtn setTitle:st forState:UIControlStateNormal];
//                    if([colorlable.text isEqualToString:@"尺码"])
//                    {
//                        if(brr.count == 3)
//                        {
//                            [colorbtn setTitle:@"均码" forState:UIControlStateNormal];
//                        }
//                    }
                    
                    [colorbtn setTitleColor:kTextColor forState:UIControlStateNormal];
                    colorbtn.selected=NO;
                    colorbtn.tag=2000*(j+i+1)*(i+1)+k;
                    colorbtn.layer.borderWidth=1;
                    colorbtn.layer.borderColor=kbackgrayColor.CGColor;
                    colorbtn.tintColor=kTextColor;
                    [colorbtn addTarget:self action:@selector(colorlick:) forControlEvents:UIControlEventTouchUpInside];
                    colorbtn.titleLabel.numberOfLines = 0;
                    colorbtn.titleLabel.textAlignment = NSTextAlignmentCenter;
                    
                    if(colorbtn.tag%2000 == 1)
                    {
                        colorbtn.selected=YES;
                        colorbtn.layer.borderWidth=0;
                        colorbtn.backgroundColor=tarbarrossred;
                        [colorbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        
                        [attr_typearr addObject:brr[k]];
                        
                    }
                    
                    [backview addSubview:colorbtn];
                }
            }
            
            backview.frame=CGRectMake(0, yPoint, kScreenWidth, CGRectGetMaxY(colorbtn.frame));
            
            yPoint += backview.frame.size.height;
        }
        
        MyLog(@"attr_typearr***** = %@",attr_typearr);
        _selectIDarray=attr_typearr;
        
        
        UILabel *stocklable = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(50), CGRectGetMaxY(backview.frame), kApplicationWidth-2*ZOOM(50), 30)];
        stocklable.textColor = kTextColor;
        stocklable.font = [UIFont systemFontOfSize:ZOOM(40)];
        stocklable.tag = 9875+i;
        [bigbackview addSubview:stocklable];
        
        //查找库存
        NSString *stockstring;
        if(_selectIDarray.count)
        {
//            [self changestock:9875+i];
        }
        
        bigbackview.frame = CGRectMake(0, bigviewYY, kScreenWidth, CGRectGetMaxY(backview.frame)+stocklable.frame.size.height);
        bigviewYY +=bigbackview.frame.size.height;
        
        scrollviewHeigh += bigbackview.frame.size.height;
        
        modelscrollview.contentSize=CGSizeMake(0, scrollviewHeigh+10);
        
        //查找商品分类下所选择的属性
        [self findBtnAttr];

    }

    MyLog(@"_selectColorArray=%@",_selectColorArray);
//    if(![self.detailType isEqualToString:@"会员商品"])
//    {
//        if([viewtype isEqualToString:@"加购物车"])
//        {
//            //加减数量
//            //数量
//            UILabel *numlable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(50), bigviewYY, 60, 25)];
//            numlable.text=@"数量";
//            numlable.textColor =kTitleColor;
//            numlable.font =[UIFont systemFontOfSize:ZOOM(46)];
//            
//            [modelscrollview addSubview:numlable];
//            
//            
//            //数量减
//            UIButton *reducebtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//            reducebtn.frame=CGRectMake(ZOOM(50), numlable.frame.origin.y+numlable.frame.size.height+10, 30, 30);
//            [reducebtn setBackgroundImage:[UIImage imageNamed:@"减_默认"] forState:UIControlStateNormal];
//            [reducebtn setBackgroundImage:[UIImage imageNamed:@"减_选中"] forState:UIControlStateHighlighted];
//            
//            [reducebtn addTarget:self action:@selector(reduce:) forControlEvents:UIControlEventTouchUpInside];
//            [modelscrollview addSubview:reducebtn];
//            
//            //显示数量
//            _numlable=[[UILabel alloc]initWithFrame:CGRectMake(reducebtn.frame.origin.x+reducebtn.frame.size.width+5, reducebtn.frame.origin.y, 60, 30  )];
//            _numlable.text=@"1";
//            _numlable.textColor=kTextGreyColor;
//            _numlable.textAlignment=NSTextAlignmentCenter;
//            _numlable.layer.borderWidth=1;
//            _numlable.layer.borderColor=kTextGreyColor.CGColor;
//            [modelscrollview addSubview:_numlable];
//            
//            //数量加
//            UIButton *addbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//            addbtn.frame=CGRectMake(_numlable.frame.origin.x+_numlable.frame.size.width+5, reducebtn.frame.origin.y, 30, 30);
//            
//            [addbtn setBackgroundImage:[UIImage imageNamed:@"加_默认"] forState:UIControlStateNormal];
//            [addbtn setBackgroundImage:[UIImage imageNamed:@"加_选中"] forState:UIControlStateHighlighted];
//            
//            [addbtn addTarget:self action:@selector(addbtn:) forControlEvents:UIControlEventTouchUpInside];
//            [modelscrollview addSubview:addbtn];
//            
//            //显示库存
//            UILabel *inventorylab=[[UILabel alloc]initWithFrame:CGRectMake(addbtn.frame.origin.x+addbtn.frame.size.width+10, reducebtn.frame.origin.y, 100, 30)];
//            inventorylab.text = [NSString stringWithFormat:@"库存%d套",[_packageStock intValue]];
//            inventorylab.tag=999666;
//            inventorylab.textColor=kTextColor;
//            inventorylab.font = [UIFont systemFontOfSize:ZOOM(40)];
//            [modelscrollview addSubview:inventorylab];
//            
//            
//            modelscrollview.contentSize=CGSizeMake(0, scrollviewHeigh+80);
//        }
//
//    }
   
    //确定按钮
  
    _okbutton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _okbutton.frame=CGRectMake(ZOOM(50), modelscrollview.frame.origin.y+modelscrollview.frame.size.height+10, kApplicationWidth-ZOOM(50)*2, 40);
    
    _okbutton.tag=9191;
    _okbutton.backgroundColor=[UIColor blackColor];
    [_okbutton setTitle:@"确定" forState:UIControlStateNormal];
    _okbutton.tintColor=[UIColor whiteColor];
    
    [_okbutton addTarget:self action:@selector(okbtn:) forControlEvents:UIControlEventTouchUpInside];
    [_modelview addSubview:_okbutton];
    
    if(_packageStock.intValue == 0)
    {
        _okbutton.userInteractionEnabled=NO;
        _okbutton.alpha=0.4;
    }
    
    //判断scrollview是否滑动
    
    if(modelscrollview.contentSize.height > modelscrollview.frame.size.height+10)
    {
        modelscrollview.scrollEnabled = YES;
    }else{
        modelscrollview.scrollEnabled = NO;
    }

}



#pragma mark 根据id找名称
-(NSString*)findNamefromID:(NSString*)ID
{
    MyLog(@"self.stock_colorArray =%@",self.stock_colorArray);
    
    
    NSString *stringName;
    for(NSDictionary*dic in self.stock_colorArray)
    {
    
        if([ID isEqualToString:dic[@"id"]])
        {
            stringName = dic[@"attr_name"];
        }
    }
    
    MyLog(@"stringName=%@",stringName);
    
    return stringName;
}

#pragma mark 选择颜色
-(void)colorlick:(UIButton*)sender
{
    MyLog(@"sender.tag=%d",sender.tag);
    

    for(int i =0;i<self.atrrListArray.count;i++)
    {
        NSMutableString *attrstr = self.atrrListArray[i];
        
        NSArray *attrArr = [attrstr componentsSeparatedByString:@";"];
        
        for(int j=0;j<attrArr.count-1;j++)
        {
            
            NSString *ttt=attrArr[j];
            NSArray *brr= [ttt componentsSeparatedByString:@","];
            
            int count = (int)sender.tag/2000;
            
            for(int k=1;k<brr.count-1;k++)
            {
                
                UIButton *button=(UIButton*)[_modelview viewWithTag:2000*count+k];
                
                MyLog(@"button.tag =%d",(int)button.tag);
                
                if(button.tag==sender.tag)
                {
                    
                    button.backgroundColor=tarbarrossred;
                    button.tintColor=[UIColor whiteColor];
                    button.layer.borderWidth=0;
                    button.selected=YES;
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
                    MyLog(@"button.text =%@",button.titleLabel.text);
                    if(_isImage == YES)
                    {
                        button.layer.borderWidth=1;
                        button.layer.borderColor = tarbarrossred.CGColor;
                    }
                    
                    NSString *colorID;
                    NSString *selectcolorID ;
                    
                    for(NSMutableDictionary *dic in self.stock_colorArray)
                    {
                        selectcolorID =[dic objectForKey:[NSString stringWithFormat:@"%@",attrArr[j]]];
                    }
                    
                    
                    _selectColor=button.titleLabel.text;
                    MyLog(@"_selectColor = %@",_selectColor);
                    
                    //查找商品颜色ID
                    NSMutableDictionary *photodic=self.stock_colorArray[i];
                    NSString *colorid=[photodic objectForKey:attrArr[j]];
                    
                    NSMutableArray *stockarr=[NSMutableArray array];
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
                    button.selected=NO;
                    
                    if(_isImage == YES)
                    {
                        button.layer.borderWidth=0;
                    }

                }
                
            }
            
            MyLog(@"text is %@",sender.titleLabel.text);
            
        }
        
    }
    
    //查找商品分类下所选择的属性
    [self findBtnAttr];
    
    
    
    NSMutableString *clorstring = [[NSMutableString alloc]init];
    for(int k =0 ; k<_selectIDarray.count ;k++)
    {
        if(_selectIDarray[k])
        {
            [clorstring appendString:_selectIDarray[k]];
            [clorstring appendString:@","];
        }
    }
    [clorstring appendString:@";"];
    
    [_selectColorArray addObject:clorstring];

    MyLog(@"_selectColorArray=%@",_selectColorArray);

}

#pragma mark 查找此商品所选择分类属性
-(void)findBtnAttr
{
    MyLog(@"idex=%d",index);
    
   _pubstock = @"1000000";
    
    NSMutableString *stocktypeIDstring=[[NSMutableString alloc]init];
    
    MyLog(@"self.atrrListArray = %@",self.atrrListArray);
    
    for(int i =0;i<self.atrrListArray.count;i++)
    {
        [_selectIDarray removeAllObjects];
        
        NSMutableString *attrstr = self.atrrListArray[i];
        
        NSArray *attrArr = [attrstr componentsSeparatedByString:@";"];
        
        
        for(int j=0;j<attrArr.count-1;j++)
        {
            
            NSString *ttt=attrArr[j];
            NSArray *brr= [ttt componentsSeparatedByString:@","];
            
            for(int k=1;k<brr.count-1;k++)
            {
                
                UIButton *button=(UIButton*)[_modelview viewWithTag:2000*(j+i+1)*(i+1)+k];
                MyLog(@"but.tag==================%d",button.tag);
                
                if(button.selected==YES)
                {
                    MyLog(@"button.text = %@",button.titleLabel.text);

                    //查找商品分类id
                    
                    NSString *selectcolorID = brr[k];
                    [_selectIDarray addObject:selectcolorID];
                    
                }
                
            }
        }
        
        
        if(_selectIDarray.count)
        {
           NSString *stocktypeID=[self changestock:9875+i];
            
            if(stocktypeID)
            {
                [stocktypeIDstring appendString:stocktypeID];
                [stocktypeIDstring appendString:@","];
            }
        }

    }
    
    MyLog(@"stocktypeIDstring = %@",stocktypeIDstring);
    if(stocktypeIDstring.length>0)
    {
        _ShopModel.stock_type_id = [stocktypeIDstring substringToIndex:[stocktypeIDstring length]-1];
    }
    MyLog(@"_ShopModel.stock_type_id=%@",_ShopModel.stock_type_id);
    
    //判断套餐是否有库存
    [self getCombostock];
    
    
}

-(void)getCombostock
{

    if([self.detailType isEqualToString:@"会员商品"])
    {
        UILabel *stocklable =(UILabel*)[_modelview viewWithTag:9875];
        MyLog(@"stocklable is %@",stocklable.text);
        
        if([stocklable.text isEqualToString:@"现有库存0件"])
        {
            UIButton *button=(UIButton*)[_modelview viewWithTag:9191];
            button.userInteractionEnabled=NO;
            button.alpha=0.4;
            
            return;

        }
        else{
            
            UIButton *button=(UIButton*)[_modelview viewWithTag:9191];
            button.userInteractionEnabled=YES;
            button.alpha=1;
            
        }

    }else{
        
        
        for(int i=0;i<self.atrrListArray.count;i++)
        {
            
            UILabel *stocklable =(UILabel*)[_modelview viewWithTag:9875+i];
            MyLog(@"stocklable is %@",stocklable.text);
            
            if([stocklable.text isEqualToString:@"现有库存0件"])
            {
                UIButton *button=(UIButton*)[_modelview viewWithTag:9191];
                button.userInteractionEnabled=NO;
                button.alpha=0.4;
                
                _packageStock = @"0";
                UILabel *inventorylab = (UILabel*)[_modelview viewWithTag:999666];
                inventorylab.text = [NSString stringWithFormat:@"库存%d套",[_packageStock intValue]];
                
                return;
            }
            else{
                
                UIButton *button=(UIButton*)[_modelview viewWithTag:9191];
                button.userInteractionEnabled=YES;
                button.alpha=1;
                
            }
            
        }

    
    }
    
    
}
#pragma mark 商品库存
-(NSString*)changestock:(int)tag
{
    
    NSString *stockstring =@"0";
    NSString *stocktypeID =@"0";
    
    NSMutableString *stockid = [[NSMutableString alloc]init];
    
    if(_selectIDarray.count)
    {
        NSMutableString *typeidString=[[NSMutableString alloc]init];
       
        for(int j=0;j<_selectIDarray.count;j++)
        {
            NSString *str =_selectIDarray[j];
            
            if(str)
            {
                [typeidString appendString:str];
                if(j!=_selectIDarray.count-1)
                {
                    [typeidString appendString:@":"];
                }
            }
        
        }
    
        
        MyLog(@"typeidString is %@",typeidString);
        [_selectColorArray addObject:typeidString];
        
        NSMutableArray *stockarr=[NSMutableArray array];
        stockarr=[NSMutableArray arrayWithArray:self.stocktypeArray];
        
        MyLog(@"stockarr = %@",stockarr);
        
        for(int i=0;i<stockarr.count;i++)
        {
            
            ShopDetailModel *model=stockarr[i];
            if([model.color_size isEqualToString:typeidString])
            {
                ShopDetailModel *shopmodel = _comobDataArray[tag-9875];
                
                if([model.shop_code isEqualToString:shopmodel.shop_code]){
                
                    MyLog(@"model.stock =%@",model.stock);
                    //商品名称
                    UILabel *namelabel=(UILabel*)[_modelview viewWithTag:4321];
                    //                namelabel.text=[NSString stringWithFormat:@"%@",_ShopModel.shop_name];
                    namelabel.text = [self exchangeTextWihtString:_ShopModel.shop_name];
                    _selectName=namelabel.text;
                    
                    MyLog(@"_selectName = %@",_selectName);
                    
                    //商品价格
                    UILabel *pricelable=(UILabel*)[_modelview viewWithTag:8765];
                    pricelable.text=[NSString stringWithFormat:@"￥%.1f",[_combo_price floatValue]];
                    if([self.detailType isEqualToString:@"会员商品"])
                    {
                        pricelable.text=[NSString stringWithFormat:@"￥%.1f",[_seprice floatValue]];
                    }
                    
                    pricelable.textColor=tarbarrossred;
                    pricelable.font =[UIFont systemFontOfSize:15];
                    _selectPrice=[NSString stringWithFormat:@"%.1f",[model.shop_se_price floatValue]];
                    
                    //商品库存
                    UILabel *stocklable=(UILabel*)[_modelview viewWithTag:tag];
                    stocklable.text=[NSString stringWithFormat:@"现有库存%@件",model.stock];
                    stockstring=[NSString stringWithFormat:@"%@",model.stock];
                    
                    stocktypeID = [NSString stringWithFormat:@"%@",model.stock_type_id];
                    
                    //取库存中最小的一个
                    if (_pubstock.intValue > model.stock.intValue)
                    {
                        _pubstock = model.stock;
                        _packageStock = _pubstock;
                    }
                    
                    MyLog(@"_packageStock = %@",_packageStock);

                }
                
            }else{
                
                UILabel *stocklable=(UILabel*)[_modelview viewWithTag:tag];
                stocklable.text=[NSString stringWithFormat:@"现有库存%@件",stockstring];
//                _packageStock = stockstring;
            }
        }
        
    }
    
    UILabel *inventorylab = (UILabel*)[_modelview viewWithTag:999666];
    inventorylab.text = [NSString stringWithFormat:@"库存%d套",[_packageStock intValue]];


    return stocktypeID;
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
    NSString *stock= _packageStock;
    if(_numlable.text.intValue < stock.intValue)
    {
        _numlable.text=[NSString stringWithFormat:@"%d",_numlable.text.intValue+1];
    }else{
        
        [MBProgressHUD show:@"已是最大库存" icon:nil view:nil];
        
    }
}

#pragma mark 数据源
-(void)creatData
{
    //tableviewheadview
    
#if 0
    
    [self.dataArr removeAllObjects];
    [self.colorArray removeAllObjects];
    
    //详情数据源
    if(_comobDataArray.count)
    {
          NSMutableArray *imageArray=[NSMutableArray array];
        
        for(int i = 0 ;i<_comobDataArray.count ; i++)
        {
            ShopDetailModel *shopmodel = _comobDataArray[i];
            
            NSArray *array = [shopmodel.shop_pic componentsSeparatedByString:@","];
            self.dataArr=[NSMutableArray arrayWithArray:array];
            
            
            [imageArray addObject:[NSString stringWithFormat:@"商品%d",i+1]];
            for(int i=0;i<self.dataArr.count;i++)
            {
                NSString *str =self.dataArr[i];
                
                if([str rangeOfString:@"reveal"].location !=NSNotFound ||
                   [str rangeOfString:@"detail"].location !=NSNotFound ||
                   [str rangeOfString:@"real"].location !=NSNotFound)//_roaldSearchText
                {
                    //yes");
                    
                    [imageArray addObject:str];
            
                    
                }
                else
                {
                    //no");
                }
                
            }
            
            
        }
        
        self.dataArr = imageArray;
    }
    
    MyLog(@"self.dataArr is %@",self.dataArr);
    
    [self.MyBigtableview reloadData];
    
    
    
    //尺码数据源 从数据库中查询
    NSMutableArray *sizearr=[NSMutableArray array];
    MyLog(@"self.sizeArray is %@",self.sizeArray);
    
    for(int i=0;i<self.sizeArray.count;i++)
    {
        NSArray *arr=[self.sizeArray[i] componentsSeparatedByString:@","];
        
        if(arr.count)
        {
            
            NSString *str=[NSString stringWithFormat:@"%@",arr[0]];
//            if([str isEqualToString:@"0"])//色
            {
                for(int j=1;j<arr.count;j++)
                {
                    const char *dbpath = [_databasePath UTF8String];
                    sqlite3_stmt *statement;
                    
                    if (sqlite3_open(dbpath, &AttrcontactDB) == SQLITE_OK)
                    {
                        NSString *querySQL = [NSString stringWithFormat:@"SELECT address,name,phone from ATTDB where id=\"%@\"",arr[j]];
                        
                        const char *query_stmt = [querySQL UTF8String];
                        
                        if (sqlite3_prepare_v2(AttrcontactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
                        {
                            
                            if (sqlite3_step(statement) == SQLITE_ROW)
                            {
                                
                                NSMutableDictionary *dic =[NSMutableDictionary dictionary];
                                
                                
                                NSString *addressField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                                
                                [dic setObject:arr[j] forKey:addressField];
                                
                                [self.stock_colorArray addObject:dic];
                        
                                
                                MyLog(@"addressField is %@",addressField);
                                
                                [_pubcolorArray addObject:addressField];
                            }
                            
                            else {
                                
                            }
                            sqlite3_finalize(statement);
                            
                        }
                        
                        
                        sqlite3_close(AttrcontactDB);
                    }
                    
                    
                }
                
                
                
            }
//            if([str isEqualToString:@"501"])//尺码
            {
                
                if(sizearr.count)
                {
                    [sizearr removeAllObjects];
                    
                    [_sizestring appendString:@";"];
                    
                }
                
                for(int j=1;j<arr.count;j++)
                {
                    const char *dbpath = [_databasePath UTF8String];
                    sqlite3_stmt *statement;
                    
                    if (sqlite3_open(dbpath, &AttrcontactDB) == SQLITE_OK)
                    {
                        NSString *querySQL = [NSString stringWithFormat:@"SELECT address,name,phone from ATTDB where id=\"%@\"",arr[j]];
                        const char *query_stmt = [querySQL UTF8String];
                        
                        if (sqlite3_prepare_v2(AttrcontactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
                        {
                            
                            if (sqlite3_step(statement) == SQLITE_ROW)
                            {
                                
                                
                                
                                NSString *addressField = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                                
                                NSMutableDictionary *dic =[NSMutableDictionary dictionary];
                                [dic setObject:arr[j] forKey:addressField];
                                
                                [self.stock_sizeArray addObject:dic];
                                
                                [_sizestring appendString:addressField];
                                [_sizestring appendString:@","];
                                [sizearr addObject:addressField];
                                
                            }
                            else {
                                
                            }
                            sqlite3_finalize(statement);
                            
                        }
                        
                        
                        sqlite3_close(AttrcontactDB);
                    }
                    
                    
                }
                
                
                
            }
            
        }
        
    }
    
    if(_sizestring.length>0)
    {
        NSMutableString *strstr = [[NSMutableString alloc]init];
        NSMutableArray *strarr = [[NSMutableArray alloc]init];

        
        MyLog(@"_sizestring is %@",_sizestring);
        
        NSArray *arr = [_sizestring componentsSeparatedByString:@";"];
        MyLog(@"arr is %@",arr);
        strarr = [NSMutableArray arrayWithArray:arr];
        
        for(int i =0;i<strarr.count;i++)
        {
            NSString *str =@"尺码";
            NSRange rnage = [strarr[i] rangeOfString:str];
            
            if(rnage.length>0)
            {
                [strstr appendString:[NSString stringWithFormat:@"商品%d",i+11]];
                [strstr appendString:@";"];
                [strstr appendString:strarr[i]];
                [strstr appendString:@";"];
                
            }else{
                [strstr appendString:strarr[i]];
                [strstr appendString:@";"];

            }
            

        }
        MyLog(@"strstr is %@",strstr);
        
        _sizestring = strstr;
        NSArray *brr=[_sizestring componentsSeparatedByString:@";"];
        _SizeArray =[NSMutableArray arrayWithArray:brr];
        self.SizeDataArray=[NSMutableArray arrayWithArray:brr];
    
    }

    //删除空的元素
    NSMutableArray *mutarr =[NSMutableArray arrayWithArray:_SizeArray];
    for(int k=0;k<mutarr.count;k++)
    {
        NSString *str = mutarr[k];
        if([str isEqualToString:@""])
        {
            [mutarr removeObjectAtIndex:k];
        }
    }
    _SizeArray =[NSMutableArray arrayWithArray:mutarr];
    self.SizeDataArray=[NSMutableArray arrayWithArray:mutarr];
    
        
    //标签数据源处理
    NSMutableArray *tagArray = [NSMutableArray array];
    NSMutableArray *muCharArr = [NSMutableArray array];
    
    int l =0;
    for(int b =0 ;b<_comobDataArray.count;b++)
    {
        NSMutableArray *IDarray = [[NSMutableArray alloc]init];
        
        ShopDetailModel *model = _comobDataArray[b];
        
        [IDarray addObject:model.age];
        [IDarray addObject:model.size];
        [IDarray addObject:model.occasion];
        [IDarray addObject:model.favorite];
        [IDarray addObject:model.pattern];
        [IDarray addObject:model.stuff];
        [IDarray addObject:model.stuff2];
        [IDarray addObject:model.stuff3];
        [IDarray addObject:model.stuff4];
        [IDarray addObject:model.trait];
        [IDarray addObject:model.trait2];
        [IDarray addObject:model.trait3];
        [IDarray addObject:model.style];
        
        [muCharArr addObject:IDarray];
        
        NSArray*arr= [self FindDataForTAGDB:IDarray];
        
        
        MyLog(@"arr is %@",arr);
        if(l==0)
        {
            l++;
            _tagDataArray1 =[NSMutableArray arrayWithArray:arr];
            
        }else if (l==1)
        {
            l++;
            _tagDataArray2 =[NSMutableArray arrayWithArray:arr];
            
        }else{
            _tagDataArray3 =[NSMutableArray arrayWithArray:arr];
        }
        
    }
    
#endif
    
    
    
}

#pragma mark 根据id查找属性
- (NSString*)getColor:(NSString*)selectID
{
    
    NSArray *idarray = [selectID componentsSeparatedByString:@":"];
    
    NSMutableString *selectcolor = [[NSMutableString alloc]init];
    for(int k=0;k<idarray.count;k++)
    {
        
        for(NSDictionary *colordic in self.stock_colorArray)
        {
            if([idarray[k] isEqualToString:colordic[@"id"]]){
                
                [selectcolor appendString:colordic[@"attr_name"]];
                [selectcolor appendString:@" "];
            }
        }
  
    }
    
    MyLog(@"selectcolor = %@",selectcolor);
    return selectcolor;
}

-(void)creatAttrData
{
    [self.dataArr removeAllObjects];
    [self.colorArray removeAllObjects];
    [self.SizeDataArray removeAllObjects];
    
    //获取供应商编号
    
    NSMutableString *code = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",_ShopModel.shop_code]];
    NSString *supcode;
    if(code)
    {
        supcode  = [code substringWithRange:NSMakeRange(1, 3)];
        MyLog(@"supcode =%@",supcode);
    }
    
    //详情数据源
    if(_comobDataArray.count)
    {
        NSMutableArray *imageArray=[NSMutableArray array];
        
        for(int i = 0 ;i<_comobDataArray.count ; i++)
        {
            ShopDetailModel *shopmodel = _comobDataArray[i];
            
            NSArray *array = [shopmodel.shop_pic componentsSeparatedByString:@","];
            self.dataArr=[NSMutableArray arrayWithArray:array];
            
            //获取供应商编号
            
            NSMutableString *code ;
            NSString *supcode  ;
            
            if(shopmodel.shop_code)
            {
                code = [NSMutableString stringWithString:shopmodel.shop_code];
                supcode  = [code substringWithRange:NSMakeRange(1, 3)];
            }
            
            MyLog(@"supcode =%@",supcode);

            
            [imageArray addObject:[NSString stringWithFormat:@"商品%d",i+1]];
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
                    //yes");
                    
//                    [imageArray addObject:str];
                    
                    MyLog(@"str = %@",str);
                    
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
                        NSString *comstr = [NSString stringWithFormat:@"%@/%@/%@%@",supcode,shopmodel.shop_code,pubstr,comArr[1]];
                        
                        MyLog(@"comstr =%@",comstr);
                        
                        [imageArray addObject:comstr];
                    }

                    
                }
                else
                {
                    //no");
                }
                
            }
            
            
        }
        
        self.dataArr = imageArray;
    }
    
    MyLog(@"self.dataArr is %@",self.dataArr);
    MyLog(@"self.attrDataArray is %@",self.attrDataArray);
    
    [self.MyBigtableview reloadData];
    
    //attr数据源 从数据库中查询

    
    for(int p=0;p<self.attrDataArray.count;p++)
    {
        
        self.sizeArray = self.attrDataArray[p];
        
        MyLog(@"self.sizeArray is %@",self.sizeArray);
        
        for(int i=0;i<self.sizeArray.count;i++)
        {
            NSArray *arr=[self.sizeArray[i] componentsSeparatedByString:@","];
            NSMutableArray *attrArr = [NSMutableArray array];
            NSMutableArray *strbrr = [NSMutableArray array];
            
            MyLog(@"arr=%@",arr);
            
            if(arr.count)
            {
                
                for(int kk=1;kk<arr.count;kk++)
                {
                    NSString *sss = arr[kk];
                    if(sss)
                    {
                        [_sizestring appendString:sss];
                        [_sizestring appendString:@","];
                    }
                }
                
            }
          
                [_sizestring appendString:@";"];
        }
        
            [_sizestring appendString:@"CM"];

    }
    
    MyLog(@"_sizestring=%@",_sizestring);
    
    if(_sizestring.length>0)
    {
        NSMutableString *strstr = [[NSMutableString alloc]init];
        NSMutableArray *strarr = [[NSMutableArray alloc]init];
        
        
        MyLog(@"_sizestring is %@",_sizestring);
        
        NSArray *arr = [_sizestring componentsSeparatedByString:@"CM"];
        strarr = [NSMutableArray arrayWithArray:arr];
        [strarr removeObjectAtIndex:strarr.count-1];
        
        self.atrrListArray = strarr;

        
        for(int i =0;i<strarr.count;i++)
        {
            
            NSString *str0 = strarr[i];
            
            NSArray *strArray1 = [str0 componentsSeparatedByString:@";"];
            MyLog(@"strArray1 is %@",strArray1);
            
            NSMutableArray *strbrr = [[NSMutableArray alloc]init];
            strbrr = [NSMutableArray arrayWithArray:strArray1];
            if(strbrr.count)
            {
               [strbrr removeObjectAtIndex:strbrr.count-1];
            }
            
            [self.SizeDataArray addObject:[NSString stringWithFormat:@"商品%d",i+1]];
            if(strbrr.count)
            {
                
                for(int h =0;h<strbrr.count;h++)
                {
                    NSString *ss =strbrr[h];
                    if(ss)
                    {
                        if([self.detailType isEqualToString:@"会员商品"])
                        {
                            if(h<2)
                            {
                                [self.SizeDataArray addObject:ss];
                            }
                        }else{
                            [self.SizeDataArray addObject:ss];
                        }
                        
                    }
                }
            }
        }
        
        MyLog(@"self.SizeDataArray is %@",self.SizeDataArray);
    
        
    }
    
    for(int kk =0;kk<self.SizeDataArray.count;kk++)
    {
        NSString *str = self.SizeDataArray[kk];
        if(str == nil || [str isEqualToString:@""])
        {
            [self.SizeDataArray removeObjectAtIndex:kk];
        }
    }
    
}

#pragma mark - 查询TAG表-- 数据库查找数据
- (NSArray*)FindDataForTAGDB:(NSArray *)findStr
{
   
    [_tagNameArray removeAllObjects];
    
    for(int i = 0;i<findStr.count;i++)
    {
        
        NSMutableArray *idArr = [NSMutableArray array];
        NSMutableArray *nameArr = [NSMutableArray array];
        
        if([self OpenDb])
        {
            const char *dbpath = [_databasePath UTF8String];
            sqlite3_stmt *statement;
            
            if (sqlite3_open(dbpath, &AttrcontactDB) == SQLITE_OK)
            {
                NSString *querySQL = [NSString stringWithFormat:@"SELECT id,name,phone,ico,sequence,ename from TAGDB where id=\"%@\"",findStr[i]];
                const char *query_stmt = [querySQL UTF8String];
                
                if (sqlite3_prepare_v2(AttrcontactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    
                    while (sqlite3_step(statement) == SQLITE_ROW)
                    {
                        NSString *ID = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                        NSString *name = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                        
                        
                        [idArr addObject:ID];
                        
                        if(name)
                        {
                            [_tagNameArray addObject:name];
                        }
                    }
                    
                    
                }
                
                sqlite3_close(AttrcontactDB);
            }
            
            
            
        }
    }
   
    return _tagNameArray;
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return _headView;
    }
    
    
    return 0;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.slectbtn.tag==1000)
    {
        return self.dataArr.count+1;
        
        
    }else if (self.slectbtn.tag==1001)
    {
    
        return self.SizeDataArray.count;
        
    }else{
        
        return self.commentDataArray.count;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(self.slectbtn.tag==1000)
    {
        if(indexPath.row==0)
        {
            return 40;
        }else{
            
            NSString *str = self.dataArr[indexPath.row-1];
            MyLog(@"str is %@",str);
            
            if([str isEqualToString:@"商品1"] || [str isEqualToString:@"商品2"] || [str isEqualToString:@"商品3"])
            {
                return 35;
            }else{
                return kApplicationWidth*900/600;
            }
            
        }
        
        return kApplicationWidth*900/600;
        
        
    }else if (self.slectbtn.tag==1001)
    {
        
        NSString *pubstr = self.SizeDataArray[indexPath.row];
        
        if([pubstr isEqualToString:@"商品1"] || [pubstr isEqualToString:@"商品2"] || [pubstr isEqualToString:@"商品3"])
        {
            return 50;
            
        }else{
            
            return 70;
        }

        
        
    }else  {
        
        
        TFCommentModel *cModel = [self.commentDataArray objectAtIndex:indexPath.row];
        
        if (cModel.cellType == 7)
        {
            return ((kApplicationWidth-60)/2+20)*_typeCount;
        }
        if (cModel.cellType == 1) {
           
            
            return [tableView fd_heightForCellWithIdentifier:@"ONECOMMENTCELL" cacheByIndexPath:indexPath configuration:^(OneCommentCell *cell) {
                [self configureOneCell:cell atIndexPath:indexPath];
            }];
            
        } else if (cModel.cellType == 2) {
           
            
            return [tableView fd_heightForCellWithIdentifier:@"TWOCOMMENTCELL" cacheByIndexPath:indexPath configuration:^(TwoCommentCell *cell) {
                [self configureTwoCell:cell atIndexPath:indexPath];
            }];
            
            
        } else if (cModel.cellType == 3) {
            
            return [tableView fd_heightForCellWithIdentifier:@"THREECOMMENTCELL" cacheByIndexPath:indexPath configuration:^(ThreeCommentCell *cell) {
                [self configureThreeCell:cell atIndexPath:indexPath];
            }];

        } else if (cModel.cellType == 4) {
            
            
            return [tableView fd_heightForCellWithIdentifier:@"FOURCOMMENTCELL" cacheByIndexPath:indexPath configuration:^(FourCommentCell *cell) {
                [self configureFourCell:cell atIndexPath:indexPath];
            }];
            
        } else if (cModel.cellType == 5) {
            
            return [tableView fd_heightForCellWithIdentifier:@"FIVECOMMENTCELL" cacheByIndexPath:indexPath configuration:^(FiveCommentCell *cell) {
                [self configureFiveCell:cell atIndexPath:indexPath];
            }];
            
        } else if (cModel.cellType == 6) {
            
            return [tableView fd_heightForCellWithIdentifier:@"SIXCOMMENTCELL" cacheByIndexPath:indexPath configuration:^(SixCommentCell *cell) {
                [self configureSixCell:cell atIndexPath:indexPath];
            }];
            
        }
        
        return 44+100;
    }
    
    return 40;
}

#pragma mark - 获取cell
- (OneCommentCell*)getOneCell
{
    OneCommentCell *cell = [self.MyBigtableview dequeueReusableCellWithIdentifier:@"ONECOMMENTCELL"];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OneCommentCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        //创建one");
    }
    //    //one");
    return cell;
}

- (TwoCommentCell *)getTwoCell
{
    TwoCommentCell *cell = [self.MyBigtableview dequeueReusableCellWithIdentifier:@"TWOCOMMENTCELL"];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TwoCommentCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        //创建two");
    }
    //    //two");
    return cell;
}

- (ThreeCommentCell *)getThreeCell
{
    ThreeCommentCell *cell = [self.MyBigtableview dequeueReusableCellWithIdentifier:@"THREECOMMENTCELL"];
    //    //three");
    return cell;
}

- (FourCommentCell *)getFourCell
{
    FourCommentCell *cell = [self.MyBigtableview dequeueReusableCellWithIdentifier:@"FOURCOMMENTCELL"];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FourCommentCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (FiveCommentCell *)getFiveCell
{
    FiveCommentCell *cell = [self.MyBigtableview dequeueReusableCellWithIdentifier:@"FIVECOMMENTCELL"];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FiveCommentCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (SixCommentCell *)getSixCell
{
    SixCommentCell *cell = [self.MyBigtableview dequeueReusableCellWithIdentifier:@"SIXCOMMENTCELL"];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SixCommentCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

#pragma mark - 配置cell
- (void)configureOneCell:(OneCommentCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    TFCommentModel *cModel = [self.commentDataArray objectAtIndex:indexPath.row];
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    [cell receiveDataModel:cModel];
}

- (void)configureTwoCell:(TwoCommentCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    TFCommentModel *cModel = [self.commentDataArray objectAtIndex:indexPath.row];
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    [cell receiveDataModel:cModel];
}

- (void)configureThreeCell:(ThreeCommentCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    TFCommentModel *cModel = [self.commentDataArray objectAtIndex:indexPath.row];
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    [cell receiveDataModel:cModel];
}

- (void)configureFourCell:(FourCommentCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    TFCommentModel *cModel = [self.commentDataArray objectAtIndex:indexPath.row];
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    [cell receiveDataModel:cModel];
}

- (void)configureFiveCell:(FiveCommentCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    TFCommentModel *cModel = [self.commentDataArray objectAtIndex:indexPath.row];
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    [cell receiveDataModel:cModel];
}

- (void)configureSixCell:(SixCommentCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    TFCommentModel *cModel = [self.commentDataArray objectAtIndex:indexPath.row];
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    [cell receiveDataModel:cModel];
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (self.slectbtn.tag == 1002) {
//        return 100;
//    } else {
//        return 100;
//    }
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.slectbtn.tag == 1000)
    {
        if(indexPath.row!=0)
        {
            NSString *str = self.dataArr[indexPath.row-1];
            MyLog(@"str is %@",str);
            
            if(![str isEqualToString:@"商品1"] || ![str isEqualToString:@"商品2"] || ![str isEqualToString:@"商品3"])
            {
                
                MyLog(@"ok");
                NSString *st;
                if (kDevice_Is_iPhone6Plus) {
                    st = @"!450";
                } else {
                    st = @"!382";
                }
                
                NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],self.dataArr[indexPath.row-1]]];
                
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
        }
    }
}

#pragma mark 点击商品图片缩放效果
- (void)scaleView:(NSMutableArray*)imgViewArr
{
    self.imgFullScrollView = [[FullScreenScrollView alloc] initWithPicutreArray:imgViewArr withCurrentPage:1];
    
    
    self.imgFullScrollView.backgroundColor = kBackgroundColor;
    
    CGFloat imageH =900*kApplicationWidth/600;
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, self.imgFullScrollView.frame.size.height-50, kApplicationWidth, 50)];
    footView.backgroundColor = [UIColor whiteColor];
    [self.imgFullScrollView addSubview:footView];
    
    CGFloat btnwith = ZOOM(100*3.4);
    NSArray *titleArray = @[@"加入购物车"];
    if([self.detailType isEqualToString:@"签到包邮"])
    {
        btnwith = kApplicationWidth - ZOOM(100*3.4);
        titleArray = @[@"签到专享,立即疯抢!"];
    }else if ([self.detailType isEqualToString:@"签到包邮"])
    {
        titleArray = @[@"立即购买"];
    }
    
    for (int i=0; i<titleArray.count; i++) {
        
        UIButton *imgbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        imgbtn.frame = CGRectMake((kApplicationWidth - btnwith)/2, (self.imgFullScrollView.frame.size.height-50)+(50-35)/2, btnwith, 35);
        imgbtn.backgroundColor = tarbarrossred;
        
        imgbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(57)];
        [imgbtn setTintColor:[UIColor whiteColor]];
        [imgbtn setTitle:titleArray[i] forState:UIControlStateNormal];
        [imgbtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.imgFullScrollView addSubview:imgbtn];
        
        if ([self.detailType isEqualToString:@"签到包邮"]){
            
            imgbtn.backgroundColor=tarbarrossred;
            imgbtn.tintColor=[UIColor whiteColor];
            
            [imgbtn setImage:[UIImage imageNamed:@"icon_go"] forState:UIControlStateNormal];
            
            NSDictionary *attributes1 = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(57)]};
            
            CGSize strSize = [imgbtn.titleLabel.text boundingRectWithSize:CGSizeMake(300, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes1 context:nil].size;
            

            CGFloat totalLen = strSize.width + 10 + IMAGEW(@"icon_go");
            CGFloat titleRightInset = (CGRectGetWidth(imgbtn.frame)- totalLen) / 2;
            
            [imgbtn setImageEdgeInsets:UIEdgeInsetsMake(0, CGRectGetWidth(imgbtn.frame)-titleRightInset-IMAGEW(@"icon_go"), 0, 10-strSize.width)];
            
            [imgbtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10-IMAGEW(@"icon_go"), 0, titleRightInset)];
        }

        if([self.detailType isEqualToString:@"签到包邮"] || [self.detailType isEqualToString:@"会员商品"])
        {
            imgbtn.tag = 5858;
        }else{
            imgbtn.tag = 5859;
        }
        
        //抢完了
        if(self.r_num.intValue == 0 || self.isSaleOut == YES )
        {
            imgbtn.enabled = NO;
            imgbtn.backgroundColor=RGBCOLOR_I(197, 197, 197);
            [imgbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
    
    self.imgFullScrollView.alpha = 0;
    
    [self.view addSubview:self.imgFullScrollView];
    
    
    
    [UIView animateWithDuration:0.1 animations:^{
        
        self.imgFullScrollView.center=CGPointMake(kApplicationWidth/2, kApplicationHeight/2);
        
    } completion:^(BOOL finished) {
        
        self.imgFullScrollView.alpha = 1;
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.imgFullScrollView.frame = CGRectMake(0, 0, kApplicationWidth, kApplicationHeight+kUnderStatusBarStartY);
            
        }];
    }];
    
    
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
    
    UILabel *taglable =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(tagimage.frame)+10, 0, 80, 20)];
    taglable.text = @"商品标签";
    [tagView addSubview:taglable];

    CGFloat yPoint=20;
    
    CGFloat tagViewHeigh = 0;
    
    NSArray *tagArray;
    for(int k = 0;k <3; k ++)
    {
        
        
        if(k==0)
        {
            tagArray = _tagDataArray1;
        }else if (k==1)
        {
            tagArray = _tagDataArray2;
        }else{
            tagArray = _tagDataArray3;
        }
        
        UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, yPoint, kApplicationWidth, 0)];
        [tagView addSubview:backview];
        
        UIImageView *titleview = [[UIImageView alloc]initWithFrame:CGRectMake((kApplicationWidth-100)/2, 20, 100, 30)];
        titleview.image = [UIImage imageNamed:[NSString stringWithFormat:@"商品%d",k+1]];
        [backview addSubview:titleview];
        
        
        UIButton *colorbtn;
        
        int xx =0;
        int yy =0;
        CGFloat btnwidh=(kApplicationWidth-(30+(ZOOM(50)*2)))/4;
        CGFloat heigh = 30;
        
        CGFloat titleViewYY = CGRectGetMaxY(titleview.frame);
        
        for(int j=0;j<tagArray.count;j++)
        {
            xx = j%4;
            yy = j/4;
            
            colorbtn=[[UIButton alloc]init];
            
            
            colorbtn.frame=CGRectMake(ZOOM(50)+(btnwidh+10)*xx, titleViewYY+15+(heigh+10)*yy, btnwidh, heigh);
            
            NSString *name = [self findNamefromID:tagArray[j]];
            
            [colorbtn setTitle:name forState:UIControlStateNormal];
            colorbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(46)];
            [colorbtn setTitleColor:tarbarrossred forState:UIControlStateNormal];
        
            colorbtn.tag=2000*(k+1)+j;
            colorbtn.layer.borderWidth=0.5;
            colorbtn.layer.borderColor=tarbarrossred.CGColor;
            colorbtn.tintColor=tarbarrossred;
            colorbtn.layer.cornerRadius = 5;
            colorbtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM(46)];
            
            [backview addSubview:colorbtn];
        }
        
        
        backview.frame=CGRectMake(0, yPoint, kScreenWidth, CGRectGetMaxY(colorbtn.frame));
        
        yPoint += backview.frame.size.height;
        
        tagViewHeigh += backview.frame.size.height;
        
        tagView.frame = CGRectMake(0, 5, kApplicationWidth, tagViewHeigh);
    }

    
    return tagView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(self.slectbtn.tag==1000)
    {
        ImageTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"imagecell"];
        if(!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ImageTableViewCell" owner:self options:nil] lastObject];
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        
        cell.defaultImage.center = cell.bigimage.center;
        
        
        if(indexPath.row==0)
        {
            
            cell.defaultImage.hidden = YES;
            
            UIView *headvvvv=(UIView*)[cell.contentView viewWithTag:8766];
            [headvvvv removeFromSuperview];
            
            UILabel *headview=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 40)];
            headview.backgroundColor=[UIColor whiteColor];
            if(self.dataArr.count>0)
            {
                headview.text=@"商品细节";
                headview.tag=8766;
                headview.textAlignment=NSTextAlignmentCenter;
                headview.textColor=kTextGreyColor;
                
            }
            
            [cell.contentView addSubview:headview];
            
        }else{
            
            UIView *headvvvv=(UIView*)[cell.contentView viewWithTag:8766];
            [headvvvv removeFromSuperview];
            
            if(self.dataArr.count)
            {
                
                UIView *ftview1 = (UIView*)[cell.contentView viewWithTag:55577];
                [ftview1 removeFromSuperview];
                
                UIView *ftview2 = (UIView*)[cell.contentView viewWithTag:55588];
                [ftview2 removeFromSuperview];
                
                UIView *ftview3 = (UIView*)[cell.contentView viewWithTag:55599];
                [ftview3 removeFromSuperview];

                
                NSString *rowstr = self.dataArr[indexPath.row-1];
                if([rowstr isEqualToString:@"商品1"])
                {
                    cell.defaultImage.hidden = YES;
                    
                    UIView *backview =[[UIView alloc]init];
                    backview.frame=CGRectMake(0, 0,kApplicationWidth, 40);
                    backview.backgroundColor=[UIColor whiteColor];
                    backview.tag = 55577;
                    [cell.contentView addSubview:backview];
                    
                    UIImageView *titleview = [[UIImageView alloc]initWithFrame:CGRectMake((kApplicationWidth-100)/2, 0, 100, 30)];
                    titleview.image = [UIImage imageNamed:@"商品1"];
                   
                    [backview addSubview:titleview];

                }else if ([rowstr isEqualToString:@"商品2"])
                {
                    UIView *backview =[[UIView alloc]init];
                    backview.frame=CGRectMake(0,0,kApplicationWidth, 40);
                     backview.backgroundColor=[UIColor whiteColor];
                    backview.tag = 55588;
                    [cell.contentView addSubview:backview];

                    
                    UIImageView *titleview = [[UIImageView alloc]initWithFrame:CGRectMake((kApplicationWidth-100)/2, 5, 100, 30)];
                    titleview.image = [UIImage imageNamed:@"商品2"];
                    [backview addSubview:titleview];

                }else if ([rowstr isEqualToString:@"商品3"])
                {
                    
                    UIView *backview =[[UIView alloc]init];
                    backview.frame=CGRectMake(0, 0,kApplicationWidth, 40);
                    backview.backgroundColor=[UIColor whiteColor];
                    backview.tag = 55599;
                    [cell.contentView addSubview:backview];

                    
                    UIImageView *titleview = [[UIImageView alloc]initWithFrame:CGRectMake((kApplicationWidth-100)/2, 5, 100, 30)];
                    titleview.image = [UIImage imageNamed:@"商品3"];
                    [backview addSubview:titleview];

                }else{
                    //!382
                   
                     cell.defaultImage.hidden = NO;
                    
                    NSString *st;
                    if (kDevice_Is_iPhone6Plus) {
                        st = @"!450";
                    } else {
                        st = @"!382";
                    }
                    
                    
                    
                    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],self.dataArr[indexPath.row-1],st]];
                    
                    __block float d = 0;
                    __block BOOL isDownlaod = NO;
                    
                    [cell.bigimage sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                        d = (float)receivedSize/expectedSize;
                        isDownlaod = YES;
                        
                    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        
                        cell.defaultImage.hidden = YES;
                        
                        if (image != nil && isDownlaod == YES) {
                            cell.bigimage.alpha = 0;
                            [UIView animateWithDuration:0.5 animations:^{
                                cell.bigimage.alpha = 1;
                            } completion:^(BOOL finished) {
                            }];
                        } else if (image != nil && isDownlaod == NO) {
                            
                            cell.defaultImage.hidden = YES;
                            
                            cell.bigimage.image = image;
                        }
                    }];
                    
                }
                
                
            }

                }
                
                
        
        return cell;
        
        
    }else if (self.slectbtn.tag==1001)
    {
        tagTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"tagCell"];
        if(!cell)
        {
            cell=[[tagTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"tagCell"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        if(self.SizeDataArray.count )
        {
            

            cell.title.text = @"";
            cell.content.text = @"";
            cell.title.font = [UIFont systemFontOfSize:ZOOM(50)];
            
            cell.content.clipsToBounds = YES;

            cell.content.font = [UIFont systemFontOfSize:ZOOM(50)];
            cell.content.numberOfLines = 0;
            
            MyLog(@"self.SizeDataArray=%@",self.SizeDataArray);
            
            NSString *pubstr = self.SizeDataArray[indexPath.row];
    
            if([pubstr isEqualToString:@"商品1"])
            {
                
                UIImageView *titleview = [[UIImageView alloc]initWithFrame:CGRectMake((kApplicationWidth-100)/2, 20, 100, 30)];
                titleview.image = [UIImage imageNamed:@"商品1"];
                titleview.tag = 6677;
                [cell.contentView addSubview:titleview];
                
            }else if ([pubstr isEqualToString:@"商品2"])
            {
                UIImageView *titleview = [[UIImageView alloc]initWithFrame:CGRectMake((kApplicationWidth-100)/2, 20, 100, 30)];
                titleview.image = [UIImage imageNamed:@"商品2"];
                titleview.tag = 6688;
                [cell.contentView addSubview:titleview];
            }else if ([pubstr isEqualToString:@"商品3"])
            {
                UIImageView *titleview = [[UIImageView alloc]initWithFrame:CGRectMake((kApplicationWidth-100)/2, 20, 100, 30)];
                titleview.image = [UIImage imageNamed:@"商品3"];
                titleview.tag = 6699;
                [cell.contentView addSubview:titleview];
                
            }else{
                
                NSMutableString *titletext = [[NSMutableString alloc]init];
                NSMutableString *contenttext = [[NSMutableString alloc]init];
                
                
               
                NSString *sizestr = self.SizeDataArray[indexPath.row];
                NSArray *brr = [sizestr componentsSeparatedByString:@","];
                MyLog(@"brr =%@",brr);
                
                for(int j =0;j<brr.count-1;j++)
                {
                    titletext = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",[self findNamefromID:brr[0]]]];
                    
                    
                    if(j>0)
                    {
                        NSString *str = [NSString stringWithFormat:@"%@",[self findNamefromID:brr[j]]];
                        
                        if(str !=nil || ![str isEqualToString:@"(null)"])
                        {
                            [contenttext appendString:str];
                            [contenttext appendString:@","];
                            
                        }
                    }
                }
                
                NSString *content;
                
                if(contenttext.length>0)
                {
                    content = [contenttext substringToIndex:[contenttext length]-1];
                }
                
                
                cell.content.text = [NSString stringWithFormat:@"%@  %@",titletext,content];
                cell.content.textColor = kTitleColor;


                NSMutableAttributedString *noteStr ;
                if(cell.content.text)
                {
                    noteStr = [[NSMutableAttributedString alloc]initWithString:cell.content.text];
                }
                
                [noteStr addAttribute:NSForegroundColorAttributeName value:kTextColor range:NSMakeRange(0, titletext.length)];
                [cell.content setAttributedText:noteStr];
            
                cell.content.font = [UIFont systemFontOfSize:ZOOM(45)];
            
                
            }

            
        }else if (indexPath.row == self.SizeDataArray.count+1)
        {
            UILabel *lable = (UILabel*)[cell.contentView viewWithTag:8899];
            [lable removeFromSuperview];
            
            UIView *ftview = (UIView*)[cell.contentView viewWithTag:8877];
            [ftview removeFromSuperview];
            
            cell.backgroundColor = [UIColor clearColor];
            
            UIView *footview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 0)];
            footview.tag = 8877;
            
            UIView *tagview = [self creatTagView];
            
            UILabel *titllable = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(200),10, kApplicationWidth-2*ZOOM(200), ZOOM(120))];
            titllable.backgroundColor = tarbarrossred;
            titllable.text = @"尺寸测量示意图";
            titllable.font = [UIFont systemFontOfSize:ZOOM(57)];
            titllable.textAlignment = NSTextAlignmentCenter;
            titllable.textColor = [UIColor whiteColor];
//            [footview addSubview:titllable];
            
            CGFloat imageviewY = CGRectGetMaxY(titllable.frame);
            
            UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, imageviewY+ZOOM(10), kApplicationWidth, (kApplicationWidth)*2300/1080)];
            
            [imageview sd_setImageWithURL:[NSURL URLWithString:@"https://yssj668.b0.upaiyun.com/system/shop_details.png"]];
//            [footview addSubview:imageview];
            
            footview.frame = CGRectMake(0, 0, kApplicationWidth, tagview.frame.size.height+250);
            
            [cell.contentView addSubview:footview];
            
        }
        
        return cell;
        
        
    } else if(self.slectbtn.tag == 1002){
        
        
        TFCommentModel *cModel;
        if(self.commentDataArray.count > 0)
        {
            cModel = [self.commentDataArray objectAtIndex:indexPath.row];
            
            
            if (cModel.cellType == 7)
            {
                UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
                
                if(!cell)
                {
                    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
                }
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                if(self.commentDataArray.count == 1)
                {
                    
                    UIView *backView =(UIView*)[self.view viewWithTag:55555];
                    [backView removeFromSuperview];
                    
                    [cell.contentView addSubview:[self creatBestSeller]];
                    
                }
                
                return cell;
            }
            
            
        }
        
    }
    
    
    
    return 0;
    
    
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
//    //当视图在滑动时购买按钮不能点
//    UIButton *buyBtn = (UIButton*)[self.view viewWithTag:3000];
//    buyBtn.userInteractionEnabled = NO;
    
    if(scrollView==self.MyBigtableview)
    {
        
        //让导航条渐变色
        UIImageView *headview=(UIImageView*)[self.view viewWithTag:3838];
        
        if(scrollView.contentOffset.y > 50 ){
            
            
            [_backbtn setImage:[UIImage imageNamed:@"icon_fanhui_black"] forState:UIControlStateNormal];
            
            if([self.detailType isEqualToString:@"会员商品"] || [self.detailType isEqualToString:@"签到包邮"])
            {
                _siimage.image = [UIImage imageNamed:@"icon_fenxiang_black"];
            }else{
                _siimage.image = [UIImage imageNamed:@"lianxikefu-black"];
            }
            
            
            _shopimage.image = [UIImage imageNamed:@"icon_gouwuche_black"];
            
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
            _currentStatusBarStyle = UIStatusBarStyleDefault;
            
            
            headview.image = [UIImage imageNamed:@""];
            headview.backgroundColor = [UIColor whiteColor];
            headview.alpha = scrollView.contentOffset.y/ZOOM(450*3.4);
            
            
        }else if (scrollView.contentOffset.y <= 50 && scrollView.contentOffset.y >= 0){
            
            [_backbtn setImage:[UIImage imageNamed:@"icon_fanhui"] forState:UIControlStateNormal];
            
            if([self.detailType isEqualToString:@"会员商品"] || [self.detailType isEqualToString:@"签到包邮"])
            {
                 _siimage.image = [UIImage imageNamed:@"icon_fenxiang"];
            }else{
                
                _siimage.image = [UIImage imageNamed:@"shop_lxkf-"];
            }
            

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
        CGFloat sectionHeaderHeight = 64;
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
    
    
    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    
    UIView *footview = (UIView *)[self.view viewWithTag:8181];
    footview.clipsToBounds =YES;
    footview.userInteractionEnabled=YES;
    
    //上滑隐藏footview 下滑显示
    if(translation.y>0)
    {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            footview.frame=CGRectMake(0, kApplicationHeight-50+kUnderStatusBarStartY, kApplicationWidth, 50);
            if (_promptview) {
                _promptview.frame = CGRectMake(0, kApplicationHeight-50-40+kUnderStatusBarStartY, kApplicationWidth, 40);
            }
            
        } completion:^(BOOL finished) {
            
            
        }];
        //        footview.hidden=NO;
    }else if(translation.y<0){
        
        [UIView animateWithDuration:0.3 animations:^{
            
            footview.frame=CGRectMake(0, kApplicationHeight+30, kApplicationWidth, footview.frame.size.height);
            
            if (_promptview) {
                _promptview.frame = CGRectMake(0, kApplicationHeight+30+kUnderStatusBarStartY, kApplicationWidth, 40);
            }
        } completion:^(BOOL finished) {
            
            
        }];
        
        
        //        footview.hidden=YES;
        
    }else{
        
        footview.hidden=NO;
        _promptview.hidden = NO;

    }
    
}

#pragma mark 详情 尺码 评价
-(void)butclick:(UIButton*)sender
{
    //让导航条渐变色
    UIImageView *headview=(UIImageView*)[self.view viewWithTag:3838];
    headview.backgroundColor = [UIColor whiteColor];
    headview.alpha = 1;
    
    [self.MyBigtableview registerNib:[UINib nibWithNibName:@"tagTableViewCell" bundle:nil] forCellReuseIdentifier:@"tagCell"];
    
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
    
    
    for(int i=0;i<3;i++)
    {
        UIButton *btn=(UIButton*)[self.view viewWithTag:1000+i];
        UILabel *lable=(UILabel*)[self.view viewWithTag:2000+i];
        if(i+1000==sender.tag)
        {
            [btn setTitleColor:tarbarrossred forState:UIControlStateNormal];
            btn.backgroundColor=[UIColor clearColor];
            
            if(i==0)
            {
                [self.MyBigtableview removeFooter];
                
            }else if (i==1)
            {
                [self.MyBigtableview removeFooter];
                
            }else if (i==2)
            {
                
                
                if( self.commentDataArray.count < 2)
                {
                    
                    [self.commentDataArray removeAllObjects];
                    
                    TFCommentModel *NOModel = [[TFCommentModel alloc] init];
                    NOModel.cellType = 7;
                    [self.commentDataArray addObject:NOModel];
                    
                }
                
                
//                [self.MyBigtableview addFooterWithCallback:^{
//                    
//                    
//                        _pagecount++;
//                    
//                        [self HostrequestHttp];
//                    
//                }];
                
                
            }
            
        }else{
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            lable.backgroundColor=[UIColor clearColor];
        }
        
    }
    
    self.slectbtn.selected=NO;
    sender.selected=YES;
    self.slectbtn=sender;
    
    
    
    
    //加footview
    if(self.slectbtn.tag==1000)
    {
        
        self.MyBigtableview.tableFooterView=_tableFootView;
        
    }
    else if (self.slectbtn.tag==1001)
    {
        
        _footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight-180)];
        
        self.MyBigtableview.tableFooterView=_footView;
        
    }else{
        
        _footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 70)];
        
        self.MyBigtableview.tableFooterView= _footView;
    
    }
    
    
    CGFloat temH = self.MyBigtableview.tableHeaderView.frame.size.height;
    
    self.MyBigtableview.contentOffset = CGPointMake(0, temH - 40 - 30 + 8);

    [self.MyBigtableview reloadData];
    
}

#pragma mark 分享  购物车
-(void)shopClick:(UIButton*)sender
{
    kSelfWeak;
    [self loginVerifySuccess:^{
        if([weakSelf.detailType isEqualToString:@"会员商品"] || [weakSelf.detailType isEqualToString:@"签到包邮"])
        {
            if(sender.tag==4000)
            {
                MyLog(@"联系卖家");
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                NSString* suppid = [user objectForKey:PTEID];
                [weakSelf Message:suppid];
            }
            
        }else{
            
            if(sender.tag == 4000)//分享
            {
                if(sender.selected == NO)
                {
                    NSString *currTime = [MyMD5 getCurrTimeString:@"year-month-day"];
                    [[NSUserDefaults standardUserDefaults] setObject:currTime forKey:ShareAnimationTime];
                    [_aView animationStart:NO];
                    
                    [MobClick event:SHOP_SHARE];
                    //弹出分享视图
                    [weakSelf creatShareModelView];
                }
            }else{//购物车
//                WTFCartViewController *shoppingcart =[[WTFCartViewController alloc]init];
//                shoppingcart.segmentSelect = CartSegment_ZeroType;
//                shoppingcart.CartType = Cart_NormalType;
//                [weakSelf.navigationController pushViewController:shoppingcart animated:YES];
                
                NewShoppingCartViewController *shoppingcart =[[NewShoppingCartViewController alloc]init];
                shoppingcart.ShopCart_Type = ShopCart_NormalType;
                shoppingcart.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:shoppingcart animated:YES];

            }
            
        }

    }];
}

#pragma mark 聊天
-(void)Message:(NSString*)suppid
{
    // begin 赵官林 2016.5.26（功能：联系客服）
//    [self messageWithSuppid:suppid title:nil model:_ShopModel detailType:self.detailType imageurl:_newimage];
    // end
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    suppid = [user objectForKey:PTEID];
//    suppid = @"915";
    
    EMConversation *conversation;
    
    ChatViewController *chatController;
    NSString *title = suppid;
    
    NSString *chatter = conversation.chatter;
    
    //////////////////////////////////////////以后要删除
    chatter=suppid;
    
    chatController = [[ChatViewController alloc] initWithChatter:chatter conversationType:conversation.conversationType];
    chatController.model = _ShopModel;
    chatController.delelgate = self;
    chatController.title = title;
    if(self.detailType)
    {
        chatController.detailtype = self.detailType;
        chatController.imageurl = _newimage;
        
    }else{
        chatController.detailtype = @"0元购";

    }
    
    if ([[RobotManager sharedInstance] getRobotNickWithUsername:chatter]) {
        chatController.title = [[RobotManager sharedInstance] getRobotNickWithUsername:chatter];
    }
    
    [self presentViewController:chatController animated:YES completion:^{
        
        
    }];
}

#pragma mark 加入购物车
-(void)contactClick:(UIButton*)sender
{
    
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *token = [userdefaul objectForKey:USER_TOKEN];
    
    if(token == nil)
    {
        [self loginVerifySuccess:nil];
        
        return;
    }
    
//    if(self.flag)
    
    if(sender.tag==3000)
    {
        //加入购物车");
        int cart1= (int)[ShopCarManager sharedManager].s_count ;
        
        if(cart1 >=20)
        {
            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
            [mentionview showLable:@"亲,购物车最多只能放入20件商品" Controller:self];
            
            return;
        }
        
        MyLog(@"self.SizeDataArray is %@",self.SizeDataArray);
        
        if(self.atrrListArray.count)
        {

            [self creatAttrModelView:@"加购物车"];
        
            
            CGFloat YY=0;
            
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
            
            [UIView animateWithDuration:0.1 animations:^{
                
                
                _modelview.frame=CGRectMake(0, YY, kApplicationWidth, kApplicationHeight-YY+20);
                
            } completion:^(BOOL finished) {
                
                
            }];
            
            [self presentSemiView:_modelview];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"系统繁忙,请稍后再试" Controller:self];
            
        }
        
        
    }
    else if (sender.tag==3001)
    {
        //立即购买");
      
        NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
        NSString *token = [userdefaul objectForKey:USER_TOKEN];
        
        if(token == nil)
        {
            [self loginVerifySuccess:nil];
            
            return;
        }
        
    
        if([self.typestring isEqualToString:@"兑换"])//兑换
        {
            [self inventoryHttp];
            
        }else{//购买
            
            MyLog(@"self.SizeDataArray is %@",self.SizeDataArray);
            
            if(self.atrrListArray.count)
            {
                //如果已经是会员不能购买
                BOOL result = [self nobuy];
                
                if(result == YES)
                {
                    if(self.flag.intValue > 0)
                    {
                        MyOrderViewController *myorder = [[MyOrderViewController alloc]init];
                        myorder.tag=999;
                        myorder.status1=@"0";
                        myorder.isbaoyou = YES;
                        myorder.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:myorder animated:YES];
                    }else{
                    
                        [self shareShooping];
                    }
                    
                }else{
                    
                    NavgationbarView *mentionview = [[NavgationbarView alloc]init];
                    [mentionview showLable:@"您已是至尊会员,无需重复购买" Controller:self];

                }
                
            }else{
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:@"系统繁忙,请稍后再试" Controller:self];
                
            }
            
            
            
        }

        
    }
    
    self.tag=sender.tag;
    
}

#pragma mark 如果是会员就不能再购买会员商品
- (BOOL)nobuy
{
    if([self.detailType isEqualToString:@"会员商品"])
    {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *ismember = [user objectForKey:USER_MEMBER];
        MyLog(@"ismember = %@",ismember);
        if(ismember.intValue == 2)
        {
            return NO;
        }

    }
       return YES;
}

#pragma mark - oooooooooooooooooooooo
- (void)shareShooping
{
//    [self creatModelview];
    
    [self creatAttrModelView:nil];
    
    NSUserDefaults *userdefaul =[NSUserDefaults standardUserDefaults];
    [userdefaul setObject:_ShopModel.kickback forKey:KICKBACK];
    
    
    CGFloat YY=0;
    
    if(FourAndSevenInch || FiveAndFiveInch)
    {
        YY=300;
    }else if (FourInch)
    {
        YY=180;
    }
    
    else{
        
        YY=110;
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        
        
        _modelview.frame=CGRectMake(0, YY, kApplicationWidth, kApplicationHeight-YY+20);
        
    } completion:^(BOOL finished) {
        
        
    }];
    
    [self presentSemiView:_modelview];

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
    if (self.tag==3000 || self.tag==5859)//
    {
        if([self.detailType isEqualToString:@"会员商品"])
        {
            UILabel *stocklable =(UILabel*)[_modelview viewWithTag:9875];
            MyLog(@"stocklable is %@",stocklable.text);
            if([stocklable.text isEqualToString:@"现有库存0件"])
            {
                
                [self dismissSemiModalView];
                
                [self performSelector:@selector(marknote) withObject:nil afterDelay:1];
                
                return;
            }
            
            [self dismissSemiModalView];
            
            [self performSelector:@selector(gotoorder) withObject:self afterDelay:0.5];
            
        }
        else{
            
            //0元购加购物车
            _okbutton.enabled = NO;
//            //加入购物车动画
//            
//            UIImageView *imageView=[[UIImageView alloc]init];
//            if(_modelimage.image !=nil)
//            {
//                imageView.image = _modelimage.image;
//            }else{
//                imageView.image = [UIImage imageNamed:@"16 logo"];
//            }
//            imageView.contentMode=UIViewContentModeScaleToFill;
//            imageView.frame=CGRectMake(0, 0, 20, 20);
//            imageView.layer.masksToBounds=YES;
//            imageView.userInteractionEnabled=YES;
//            imageView.hidden=NO;
//            imageView.tag=7000;
//            
//            CGPoint point=CGPointMake(40, 20);
//            imageView.center=point;
//            _layer=[[CALayer alloc]init];
//            _layer.contents=imageView.layer.contents;
//            _layer.frame=imageView.frame;
//            _layer.opacity=1;
//            _layer.masksToBounds=YES;
//            //        _layer.cornerRadius=10;
//            [_modelview.layer addSublayer:_layer];
//            
//            
//            CGFloat YY=0;
//            
//            if(FourAndSevenInch || FiveAndFiveInch)
//            {
//                YY=300;
//            }else if(FourInch){
//                YY=200;
//            }else{
//                YY=110;
//            }
//            
//            CGPoint point1=CGPointMake(0, -YY+15);
//            
//            
//            UIView *hideview=[[UIView alloc]init];
//            CGRect rect=_sharebtn.frame;
//            rect.origin.x=_sharebtn.frame.origin.x+70;
//            hideview.backgroundColor=[UIColor clearColor];
//            hideview.frame=rect;
//            [self.view addSubview:hideview];
//            
//            
//            //动画 终点 都以sel.view为参考系
//            CGPoint endpoint=[self.view convertPoint:point1 fromView:_shopcartbtn];
//            UIBezierPath *path=[UIBezierPath bezierPath];
//            
//            //动画起点
//            CGPoint startPoint=[_modelview convertPoint:point fromView:_modelimage];
//            [path moveToPoint:startPoint];
//            //贝塞尔曲线中间点
//            float sx=startPoint.x;
//            float sy=startPoint.y;
//            float ex=endpoint.x;
//            float ey=endpoint.y;
//            float x=sx+(ex-sx)/3;
//            float y=sy+(ey-sy)*0.5-200;
//            CGPoint centerPoint=CGPointMake(x,y);
//            [path addQuadCurveToPoint:endpoint controlPoint:centerPoint];
//            
//            CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
//            animation.path = path.CGPath;
//            animation.removedOnCompletion = NO;
//            animation.fillMode = kCAFillModeForwards;
//            animation.duration=0.5;
//            animation.delegate=self;
//            animation.autoreverses= NO;
//            animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//            [_layer addAnimation:animation forKey:@"buy"];
            
            [self performSelector:@selector(request:) withObject:self afterDelay:0.01];
        }

    }else{//购买
        
        
        [self dismissSemiModalView];
        
        [self performSelector:@selector(gotoorder) withObject:self afterDelay:0.5];

    }
    
}


- (void)gotoorder
{
    if([self.detailType isEqualToString:@"会员商品"])
    {
        [self MembertoAffirm];
    }else{
        [self toAffirm];
    }

}
- (void)marknote
{
    NavgationbarView *mentionview = [[NavgationbarView alloc]init];
    [mentionview showLable:@"亲,没有库存了" Controller:self];
}

- (void)gotoblack
{
    self.noviceTaskView = [[TFNoviceTaskView alloc] init];
    [self.noviceTaskView returnClick:^(NSInteger type) {

        [self performSelector:@selector(gotoshareView) withObject:self afterDelay:1];
        
    } withCloseBlock:^(NSInteger type) {
        
    }];
    [self.noviceTaskView showWithType:@"2"];

}

- (void)gotoshareView
{
    
    [self dismissSemiModalView];
    
    //获取商品链接
    [self shopRequest:nil];

}

- (void)toAffirm
{
    AdressModel *model;
    if(self.DeliverArray.count)
    {
        model=self.DeliverArray[0];
    }
    
    MyLog(@"_selectColor=%@",_selectColor);
    
    
    _ShopModel.shop_num = _numlable.text;

    [self getStockType];
    
    if([self.detailType isEqualToString:@"签到包邮"]){
        
        p_type = @"5";
        _ShopModel.def_pic = _newimage;
    }


    AffirmOrderViewController1 *affirm=[[AffirmOrderViewController1 alloc]init];
    affirm.addressmodel=model;
    affirm.affirmType=Indiana_Type;
    affirm.shopmodel=_ShopModel;
    affirm.color=_selectColor;
    affirm.size=_selectSize;

    if(p_type!=nil)
    {
        affirm.shopmodel.shop_se_price=[NSString stringWithFormat:@"%f",[_combo_price floatValue]];
        affirm.selectPrice=[NSString stringWithFormat:@"%f",[_combo_price floatValue]];
        affirm.shopmodel.shop_num=@"1";
        affirm.number=@"1";
    } else{
        affirm.number=_numlable.text;
        affirm.selectPrice=_selectPrice;
    }
    
    affirm.selectName=_selectName;
    
    MyLog(@"_selectColorID = %@ _selectSizeID=%@",_selectColorID , _selectSizeID);
    
    affirm.selectColorID=[NSString stringWithFormat:@"%@",_selectColorID];
    affirm.selectSizeID=[NSString stringWithFormat:@"%@",_selectSizeID];
    
    affirm.stocktypeArray=self.stocktypeArray;
    
    affirm.JifenshopArray=self.JifenshopArray;
    affirm.four_pic=_ShopModel.four_pic;
    
    affirm.stockType= _ShopModel.stock_type_id;
    
    affirm.packageCode=self.shop_code;
    if([self.detailType isEqualToString:@"签到包邮"]){
        
        affirm.packageCode = _Shop_Code;
    }

    affirm.shopZeroType=p_type;
    affirm.post_money=_postage;

    NSMutableArray *array = [NSMutableArray array];
    if(_ShopModel)
    {
        [array addObject:_ShopModel];
    }
    UIImageView *headimg=(UIImageView*)[_modelview viewWithTag:3579];
    affirm.headimage.image=headimg.image;
    
    UILabel *pricelable=(UILabel*)[_modelview viewWithTag:8765];
    affirm.price=pricelable.text;
    affirm.order_code=self.order_code;
    
    affirm.dataArrayCount=_SizeDataArray.count-1;
    
    if([self.typestring isEqualToString:@"兑换"])
    {
        affirm.typestring=@"兑换";
    }
    
    [self.navigationController pushViewController:affirm animated:YES];
}

- (void)MembertoAffirm
{
    MyLog(@"_ShopModel = %@",_ShopModel);
    
    AdressModel *model;
    if(self.DeliverArray.count)
    {
        model=self.DeliverArray[0];
    }
    
    _ShopModel.shop_num = _numlable.text;
    

    [self getStockType];
    
    
    AffirmOrderViewController *affirm=[[AffirmOrderViewController alloc]init];
    affirm.addressmodel=model;
    affirm.shopmodel=_ShopModel;
    affirm.color=_selectColor;
    affirm.size=_selectSize;
    affirm.affirmType=MemberType;
    
    
    affirm.shopmodel.shop_se_price=[NSString stringWithFormat:@"%f",[_combo_price floatValue]];
    affirm.selectPrice=[NSString stringWithFormat:@"%f",[_combo_price floatValue]];
    affirm.shopmodel.shop_num=@"1";
    affirm.number=@"1";
    
    if ([self.detailType isEqualToString:@"会员商品"])
    {
        affirm.number=@"1";
        affirm.shopmodel.shop_num=@"1";
        affirm.selectPrice=_selectPrice;
        if(self.selectIDarray.count)
        {
            _selectColorID = self.selectIDarray[0];
            
            if(self.selectIDarray.count>1)
            {
                _selectSizeID = self.selectIDarray[1];
            }
        }
       
        affirm.color = [self findNamefromID:_selectColorID];
        affirm.size = [self findNamefromID:_selectSizeID];
    }
    
    affirm.selectName=_selectName;
    
    affirm.selectColorID=[NSString stringWithFormat:@"%@",_selectColorID];
    affirm.selectSizeID=[NSString stringWithFormat:@"%@",_selectSizeID];
    affirm.stocktypeArray=self.stocktypeArray;
    affirm.JifenshopArray=self.JifenshopArray;
    affirm.four_pic=_ShopModel.four_pic;
    
    affirm.stockType= _ShopModel.stock_type_id;
    affirm.packageCode=self.shop_code;
    affirm.shopZeroType=p_type;
    affirm.post_money=_postage;
    
    NSMutableArray *array = [NSMutableArray array];
    if(_ShopModel)
    {
        [array addObject:_ShopModel];
    }
    UIImageView *headimg=(UIImageView*)[_modelview viewWithTag:3579];
    affirm.headimage.image=headimg.image;
    
    UILabel *pricelable=(UILabel*)[_modelview viewWithTag:8765];
    affirm.price=pricelable.text;
    affirm.order_code=self.order_code;
    
    affirm.dataArrayCount=_SizeDataArray.count-1;
    
    [self.navigationController pushViewController:affirm animated:YES];

}

-(void)getStockType
{

    NSMutableString *stockID = [[NSMutableString alloc]init];
    for(int i = 0 ;i<_colorIDarray.count;i++)
    {
        NSString *sizeID = _sizeIDarray[i];
        NSString *colorID = _colorIDarray[i];
        
        
        NSString *colorSizeID = [NSString stringWithFormat:@"%@:%@",colorID,sizeID];
        
    
        for(int j =0;j<self.stocktypeArray.count;j++)
        {
            
            ShopDetailModel *model =self.stocktypeArray [j];
            
            
            MyLog(@"%d-colorSizeID is %@",j,colorSizeID);
            MyLog(@"%d-model.color_size is %@",j,model.color_size);
            
            if([model.color_size isEqualToString:colorSizeID])
            {
                
                [stockID appendString:[NSString stringWithFormat:@"%@",model.stock_type_id]];
                [stockID appendString:@","];
            }
        }
        
        p_seq = stockID;
    }
    
    if(p_seq.length>0)
    {
        p_seq = [p_seq substringToIndex:[p_seq length] - 1];
        
    }

}

#pragma mark 查找商品库存分类id
-(void)request:(NSTimer*)time
{
    [self getStockType];
    
    //获取套餐商品库存ID
    NSMutableString *stockID = [[NSMutableString alloc]init];
    NSArray *shopstoryarr = [_ShopModel.stock_type_id componentsSeparatedByString:@","];
    
    for(int i = 0 ;i<shopstoryarr.count;i++)
    {
        for(int j =0;j<self.stocktypeArray.count;j++)
        {
            ShopDetailModel *model =self.stocktypeArray[j];
        
            if([model.stock_type_id isEqualToString:shopstoryarr[i]])
            {
                [stockID appendString:[NSString stringWithFormat:@"%@",model.stock_type_id]];
                [stockID appendString:@","];
                
                break;
            }
        }
        
        p_seq = stockID;
    }
    
    if(p_seq.length>0)
    {
        p_seq = [p_seq substringToIndex:[p_seq length] - 1];
        
    }

    //购物车弹框消失
    [self dismissSemiModalView];

    //加入购物车按钮不可点
    UIButton *buyBtn = (UIButton*)[self.view viewWithTag:3000];
    buyBtn.userInteractionEnabled = NO;

    ShopSaleModel *cartModel = [ShopCarManager isExistsWithType:ShopCarTypeSale shopCode:self.shop_code andStid:p_seq];
    
    if(cartModel)//此商品编号的库存ID已经加过一件
    {
        
        NSInteger num = cartModel.shop_num + 1;
        if(num <= 2) {
            
            [self insertToDB:@(cartModel.ID).stringValue expired:cartModel.expired num:cartModel.shop_num];
            
        }else{
            
            //加入购物车按钮可点
            buyBtn.userInteractionEnabled = YES;

            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
            [mentionview showLable:@"抱歉,数量有限,最多只能购买两件噢!" Controller:self];
        }
        
    }else{
        
        //获取购物车ID
        [self getshopCartID:nil withKickback:nil andOriginal_price:nil];
    }

    
//    NSString *shopID = [ShopCarManager isExistsWithType:ShopCarTypeSale shopCode:self.shop_code andStid:p_seq];
//    if(shopID !=Nil)//此编号的库存ID已经加过一件
//    {
//        [self insertToDB:shopID];
//    }else{
//        
//        //获取购物车ID
//        [self getshopCartID:nil withKickback:nil andOriginal_price:nil];
//    }
    

    [_layer removeFromSuperlayer];
    
    UIImageView *image=(UIImageView*)[_modelview viewWithTag:7000];
    image.image=[UIImage imageNamed:@" "];
    image=nil;
    [image removeFromSuperview];
    image.hidden=YES;

    
}
-(void)back:(UIButton*)sender
{
    [_mytimer invalidate];
    _mytimer = nil;
    if([self.stringtype isEqualToString:@"最爱足迹"]  || [self.stringtype isEqualToString:@"订单详情"])
    {
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if ([self.detailType isEqualToString:@"会员商品"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark 进入购物车界面
-(void)cartclick:(UIButton*)sender
{
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *token = [userdefaul objectForKey:USER_TOKEN];
    
    if(token == nil)
    {
        [self loginVerifySuccess:nil];
        
        return;
    }
    
    WTFCartViewController *shoppingcart =[[WTFCartViewController alloc]init];
    shoppingcart.segmentSelect = CartSegment_ZeroType;
    shoppingcart.CartType = Cart_NormalType;
    [self.navigationController pushViewController:shoppingcart animated:YES];
    

}
#pragma mark 加喜欢
-(void)likeclick:(UIButton*)sender
{
    
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *token = [userdefaul objectForKey:USER_TOKEN];
    
    if(token == nil)
    {
        [self loginVerifySuccess:nil];
        
        return;
    }
    
    
    if(self.likebtn.selected==NO)//加喜欢
    {
        [self likerequestHttp];
        
        
    }else{//取消喜欢
        
        
        [self dislikerequestHttp];
        
        
    }
    
    
}

#pragma mark 加心消失
-(void)disapper:(NSTimer*)timer
{
    UIImageView *view=(UIImageView *)[self.view viewWithTag:9999];
    
    [UIView animateWithDuration:0.5 animations:^{
        view.frame=CGRectMake((kApplicationWidth-60)/2, (kApplicationHeight-60)/2, 60, 60);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            [view removeFromSuperview];
        }];
    }];
    
}


#pragma mark scrollviewdelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    if(!decelerate){
        
        //这里写上停止时要执行的代码
        
        //当视图不滑动时购买按钮可点
        UIButton *buyBtn = (UIButton*)[self.view viewWithTag:3000];
        buyBtn.userInteractionEnabled = YES;
        
        UIView *footview = (UIView *)[self.view viewWithTag:8181];
        footview.clipsToBounds =YES;
        footview.userInteractionEnabled=YES;
        
        
        [UIView animateWithDuration:0.3 animations:^{
            
            if (_promptview) {
                _promptview.frame = CGRectMake(0, kApplicationHeight-50-40+kUnderStatusBarStartY, kApplicationWidth, 40);
            }

            footview.frame=CGRectMake(0, kApplicationHeight-50+kUnderStatusBarStartY, kApplicationWidth, 50);
            
        } completion:^(BOOL finished) {
            
            
        }];
        
        
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    //1111111111111111");
    
    UIView *footview = (UIView *)[self.view viewWithTag:8181];
    footview.clipsToBounds =YES;
    footview.userInteractionEnabled=YES;
    
    //当视图不滑动时购买按钮可点
    UIButton *buyBtn = (UIButton*)[self.view viewWithTag:3000];
    buyBtn.userInteractionEnabled = YES;
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (_promptview) {
            _promptview.frame = CGRectMake(0, kApplicationHeight-50-40+kUnderStatusBarStartY, kApplicationWidth, 40);
        }

        footview.frame=CGRectMake(0, kApplicationHeight-50+kUnderStatusBarStartY, kApplicationWidth, 50);
        
    } completion:^(BOOL finished) {
        
        
    }];
    
    
    
    if(!_tableFootView)
    {
        
        CGPoint offset = scrollView.contentOffset;
        
        CGRect bounds = scrollView.bounds;
        
        CGSize size = scrollView.contentSize;
        
        UIEdgeInsets inset = scrollView.contentInset;
        
        CGFloat currentOffset = offset.y + bounds.size.height - inset.bottom;
        
        CGFloat maximumOffset = size.height;
        
        
        CGFloat currentOffsetNew = [[NSString stringWithFormat:@"%.f",currentOffset] floatValue];
        CGFloat maximumOffsetNew = [[NSString stringWithFormat:@"%.f",maximumOffset] floatValue];
        
        //当currentOffset与maximumOffset的值相等时，说明scrollview已经滑到底部了。也可以根据这两个值的差来让他做点其他的什么事情
        
        if(currentOffsetNew > maximumOffsetNew  || currentOffsetNew == maximumOffsetNew)
            
        {
            
            //-----我要刷新数据-----");
            
            if(self.slectbtn.tag==1000)
            {
                 [self creatTableFootView];
                //            [self footViewAddChildView];
                
                self.MyBigtableview.tableFooterView= _tableFootView;
                
                int index = 0;
             
                
                for (NSDictionary *dic in self.shopStoreVC.typeIndexArr) {
                    if ([dic[@"id"] intValue] == self.currPage) {
                        index = [dic[@"index"] intValue];
                        break;
                    }
                }
                [self.shopStoreVC.slidePageScrollView scrollToPageIndex:index animated:NO];
                [self.shopStoreVC.slidePageScrollView.pageTabBar switchToPageIndex:index];
                
                [UIView animateWithDuration:0.5 animations:^{
                    
                    MyLog(@"%f",self.MyBigtableview.tableFooterView.frame.origin.y-kApplicationHeight+kUnderStatusBarStartY);
                    
                    self.MyBigtableview.contentOffset = CGPointMake(0, self.MyBigtableview.tableFooterView.frame.origin.y-kApplicationHeight+kUnderStatusBarStartY+_tableFootView.frame.size.height-40);
                    
                } completion:^(BOOL finished) {
                    
                    
                }];
                
                
            }
            
        }
        
    }
    
}



#pragma mark 联系客服
-(void)shareclick:(UIButton*)sender
{
    if([self.detailType isEqualToString:@"会员商品"] || [self.detailType isEqualToString:@"签到包邮"])
    {
        [MobClick event:SHOP_SHARE];
        
        NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
        NSString *token = [userdefaul objectForKey:USER_TOKEN];
        
        if(token == nil)
        {
            [self loginVerifySuccess:nil];
            
            return;
        }
        
        
        //弹出分享视图
        
        [self creatShareModelView];
        

    }else{
        
        NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
        NSString *token = [userdefaul objectForKey:USER_TOKEN];
        
        if(token == nil)
        {
            [self loginVerifySuccess:nil];
            
            return;
        }
        
        MyLog(@"联系卖家");
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString* suppid = [user objectForKey:PTEID];
        
        
        [self Message:suppid];

    }
    
}


- (IBAction)share:(id)sender {
    //    [[DShareManager share] shareList];
    
    NavgationbarView *mentionview=[[NavgationbarView alloc]init];
    [mentionview showLable:@"支付成功,3秒后自动分享到朋友圈" Controller:self];
    
//    NSTimer *time=[NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(share) userInfo:nil repeats:NO];
    [self performSelector:@selector(share) withObject:nil afterDelay:4];
    
}

#pragma mark 获取商品链接请求
- (void)shopRequest:(int)tag
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *realm = [user objectForKey:USER_REALM];
    NSString *token = [user objectForKey:USER_TOKEN];
    
    [DataManager sharedManager].key = _ShopModel.shop_code;
    
    NSString *url=[NSString stringWithFormat:@"%@shop/getpShopLink?version=%@&p_code=%@&realm=%@&token=%@&share=%@&getPShop=true",[NSObject baseURLStr],VERSION,_ShopModel.shop_code,realm,token,@"2"];
    
    if([self.detailType isEqualToString:@"签到包邮"])
    {
        url=[NSString stringWithFormat:@"%@shop/getpShopLink?version=%@&p_code=%@&realm=%@&token=%@&share=%@&getPShop=true&p_s=1",[NSObject baseURLStr],VERSION,_ShopModel.shop_code,realm,token,@"2"];
    }
    NSString *URL=[MyMD5 authkey:url];

    
    [MBProgressHUD showMessage:@"分享加载中，稍等哟~" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
       [MBProgressHUD hideHUDForView:self.view];
        
        _sharebtn.userInteractionEnabled = YES;
//        responseObject = [NSDictionary changeType:responseObject];
        [MBProgressHUD hideHUDForView:self.view];
        if (responseObject!=nil) {
            
            NSString *str=responseObject[@"status"];
            
            if(str.intValue==1)
            {
                
                _shareModel=[ShareShopModel alloc];
                _shareModel.shopUrl=responseObject[@"link"];
                _shareShopurl=@"";
                _shareShopurl=responseObject[@"link"];
            
                
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
                            //获取供应商编号
                            
                            NSMutableString *code ;
                            NSString *supcode  ;
                            
                            if(shopdic[@"shop_code"])
                            {
                                code = [NSMutableString stringWithString:shopdic[@"shop_code"]];
                                supcode  = [code substringWithRange:NSMakeRange(1, 3)];
                            }
                            
                            [userdefaul setObject:[NSString stringWithFormat:@"%@/%@/%@",supcode,code,shopdic[@"four_pic"]] forKey:SHOP_PIC];
                        }
                        
                        
                    }
                    
                    if(responseObject[@"link"])
                    {
                        [userdefaul setObject:[NSString stringWithFormat:@"%@",responseObject[@"link"]] forKey:QR_LINK];
                        
                        if([self.detailType isEqualToString:@"签到包邮"])
                        {
                            [userdefaul setObject:[NSString stringWithFormat:@"%@&post=true",responseObject[@"link"]] forKey:QR_LINK];
                            
                        }

                    }
                    
                    if(responseObject[@"price"])
                    {
                        [userdefaul setObject:responseObject[@"price"] forKey:SHOP_PRICE];
                    }
                    
                    
                    if([_clickbutType isEqualToString:@"立即购买"])
                    {
                        
                        
                    }else{
                    
                        if( [shopdic[@"four_pic"] isEqualToString:@"null"] || !responseObject[@"link"])
                        {
                            [MBProgressHUD hideHUDForView:self.view];
                            
                            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
                            [mentionview showLable:@"数据获取异常，稍后重试" Controller:self];
                            
                            return;
                        }

                        [self gotoshare:tag];
                        
                    }
                    
                }else{
                    NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                    [mentionview showLable:@"数据异常，操作无效" Controller:self];
                }
                
                
                
            }
            else if(str.intValue==1050)
            {
                [MBProgressHUD hideHUDForView:self.view];
                
                UIView *backview = (UIView*)[self.view viewWithTag:9797];
                [backview removeFromSuperview];
                
                
                _sharebtn.selected=NO;
                
                [_shareModelview removeFromSuperview];
                
                NSString *noteStr ;
                
                BOOL result = [self isBetweenFromHour:7 toHour:14];
                
                if( result)//早上
                {
                    noteStr = @"亲爱的，你今天上午的分享次数已经全部使用了哦,下午再来吧！接下来购物不分享也能得到现金红包哦！";
                    
                }else{
                    
                    noteStr = @"亲爱哒，今天的分享次数已经使用完了哦，明天再分享吧。接下来购物不分享也能得到现金红包哦！";
                }
                
                
                _combBoAlterView =[[UIAlertView alloc]initWithTitle:nil message:noteStr delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [_combBoAlterView show];
                
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
        
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
        
    }];
    
    
}

#pragma mark 判断某个时间是否在7~14点
- (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour
{
    NSDate *date7 = [self getCustomDateWithHour:7];
    NSDate *date14 = [self getCustomDateWithHour:14];
    
    NSDate *currentDate = [NSDate date];
    
    if ([currentDate compare:date7]==NSOrderedDescending && [currentDate compare:date14]==NSOrderedAscending)
    {
        //该时间在 %d:00-%d:00 之间！", fromHour, toHour);
        return YES;
    }
    return NO;
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
        [self loginVerifySuccess:nil];
        
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
    //    self.shopStoreVC.slidePageScrollView
    self.shopStoreVC.slidePageScrollView.pageTabBar.index = (int)self.currPage;
    [self addChildViewController:_shopStoreVC];
    [_tableFootView addSubview:self.shopStoreVC.view];
    self.shopStoreVC.slidePageScrollView.tyDelegate = self;
    
    
    //    //+++++++%d++++++++", (int)self.currPage);
    
    [self.MyBigtableview reloadData];
    
    //    UIButton *btn = (UIButton *)[self.shopStoreVC.slidePageScrollView.pageTabBar.bgScrollView viewWithTag:10000+self.currPage];
    //    [self.shopStoreVC.slidePageScrollView.pageTabBar btnClick:btn];
    
}

#pragma mark - TYSlidePageScrollViewDelegate

- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView verticalScrollViewDidScroll:(UIScrollView *)pageScrollView
{
    
    UIView *footview =(UIView*)[self.view viewWithTag:8181];
    
    CGPoint translation = [pageScrollView.panGestureRecognizer translationInView:pageScrollView.superview];
    int i=0;
    
    if(translation.x == 0 && translation.y == 0)
    {
        if (pageScrollView.contentOffset.y > - 41.5) {
            
            [UIView animateWithDuration:0.5 animations:^{
                self.MyBigtableview.contentOffset = CGPointMake(0, self.MyBigtableview.contentSize.height - SIZE.height);
                
                footview.hidden = YES;
                _promptview.hidden = YES;
            }];
        }
    }
    
    
    if(translation.x == 0 && translation.y > 0)
    {
        
        if (pageScrollView.contentOffset.y < -30)
        {
            //滑到顶部更新
        
            if(i==0)
            {
                
                [UIView animateWithDuration:1 animations:^{
                    
                    self.MyBigtableview.contentOffset = CGPointMake(0, self.MyBigtableview.tableFooterView.frame.origin.y-kApplicationHeight+kUnderStatusBarStartY);
                    
                    if (_promptview) {
                        _promptview.frame = CGRectMake(0, kApplicationHeight+30+kUnderStatusBarStartY, kApplicationWidth, 40);
                    }
                    
                } completion:^(BOOL finished) {
                    
                    footview.hidden = NO;
                    _promptview.hidden = NO;
                    
                }];
                
                i++;
                
            }
        }
    }
    

}



#pragma mark 选择分享的平台
-(void)shareClick:(UIButton*)sender
{
    if(_shareModelview)
    {
        
        UIView *backview = (UIView*)[self.view viewWithTag:9797];
        
        [UIView animateWithDuration:0.5 animations:^{
            
            backview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
            
           _shareModelview.frame=CGRectMake(0, kApplicationHeight+30, kApplicationWidth, SHAREMODELVIEW_HEIGH);
            
        } completion:^(BOOL finished) {
            
            [backview removeFromSuperview];
            [_shareModelview removeFromSuperview];
            
            //获取商品链接
            [self shopRequest:(int)sender.tag];
        }];
        
    }

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
    
    if(sharetag==9000)//微信好友
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            

            UIImage *shopimage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],shop_pic]]]];
            [MBProgressHUD hideHUDForView:self.view];
            
            if([self.detailType isEqualToString:@"签到包邮"])
            {
                [[DShareManager share] shareAppWithType:ShareTypeWeixiSession View:nil Image:shopimage WithShareType:@"qianDaocomdetail"];
            }else{
            
                [[DShareManager share] shareAppWithType:ShareTypeWeixiSession View:nil Image:shopimage WithShareType:@"comdetail"];
            }
            
        });
        
        
    }
    else if (sharetag==9001)//微信朋友圈
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
            
            UIImage *qrpicimage =[[UIImage alloc]init];
            //    直接创建二维码图像
            qrpicimage = [QRCodeGenerator qrImageForString:qrlink imageSize:165];
            
            NSData *data = UIImagePNGRepresentation(qrpicimage);
            NSString *st = [NSString stringWithFormat:@"%@/Documents/abc.png", NSHomeDirectory()];
            
            //st = %@", st);
            
            [data writeToFile:st atomically:YES];
            
            NSString *typestr;
            if([self.detailType isEqualToString:@"签到包邮"])
            {
                typestr = @"qianDaocomdetail";
                
            }else{
                
                typestr = @"comdetail";
            }

            ProduceImage *pi = [[ProduceImage alloc] init];
            UIImage *newimg = [pi getImage:shopimage withQRCodeImage:qrpicimage withText:typestr withPrice:shopprice WithTitle:nil];
            MyLog(@"newimg = %@",newimg);
            
            
            [[DShareManager share] shareAppWithType:ShareTypeWeixiTimeline View:nil Image:newimg WithShareType:@"comdetail"];
        });
        
        
        
        
    }else if (sharetag==9002)//QQ空间
    {
        [MBProgressHUD hideHUDForView:self.view];
        
        if([self.detailType isEqualToString:@"签到包邮"])
        {
            [[DShareManager share] shareAppWithType:ShareTypeQQSpace View:nil Image:nil WithShareType:@"qianDaocomdetail"];
        }else{
            [[DShareManager share] shareAppWithType:ShareTypeQQSpace View:nil Image:nil WithShareType:@"comdetail"];
        }
    }
    
    
    if(_shareModelview )
    {
        
        UIView *backview = (UIView*)[self.view viewWithTag:9797];
        
        
        [UIView animateWithDuration:0.5 animations:^{
            
            backview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
            
            _shareModelview.frame=CGRectMake(0, kApplicationHeight+30, kApplicationWidth, SHAREMODELVIEW_HEIGH);
            
        } completion:^(BOOL finished) {
            
            _sharebtn.selected=NO;
            
            [backview removeFromSuperview];
            [_shareModelview removeFromSuperview];
        }];
        
//        UIButton * shopbtn = (UIButton*)[self.view viewWithTag:4001];
//        shopbtn.selected = NO;

    }

}


- (void)disapperview:(UITapGestureRecognizer*)tap
{
//    UIButton * shopbtn = (UIButton*)[self.view viewWithTag:4001];
//    shopbtn.selected = NO;
    
    [self disapperShare];
}

- (void)disapperShare
{
    [_sharebtn becomeFirstResponder];
    
    if(_shareModelview)
    {
        
        UIView *backview = (UIView*)[self.view viewWithTag:9797];
        
        
        [UIView animateWithDuration:0.5 animations:^{
            
            backview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
            
            _shareModelview.frame=CGRectMake(0, kApplicationHeight+30, kApplicationWidth, SHAREMODELVIEW_HEIGH);
            
        } completion:^(BOOL finished) {
            
            [backview removeFromSuperview];
            [_shareModelview removeFromSuperview];
        }];
        
    }

}
#pragma mark 加购物车 购买
-(void)buttonClick:(UIButton*)sender
{
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *token = [userdefaul objectForKey:USER_TOKEN];
    
    if(token == nil)
    {
        [self loginVerifySuccess:nil];
        
        return;
    }
    
    
    if( sender.tag == 5858)//分享购买
    {
        //如果已经是会员不能购买
        BOOL result= [self nobuy];
        
        if(result == YES){
            
            if(self.atrrListArray.count)
            {
                
                [self creatAttrModelView:nil];
                
                NSUserDefaults *userdefaul =[NSUserDefaults standardUserDefaults];
                [userdefaul setObject:_ShopModel.kickback forKey:KICKBACK];
                
                
                CGFloat YY=0;
                
                if(FourAndSevenInch || FiveAndFiveInch)
                {
                    YY=300;
                }else if (FourInch)
                {
                    YY=180;
                }
                
                else{
                    
                    YY=110;
                }
                
                [UIView animateWithDuration:0.1 animations:^{
                    
                    
                    _modelview.frame=CGRectMake(0, YY, kApplicationWidth, kApplicationHeight-YY+20);
                    
                } completion:^(BOOL finished) {
                    
                    
                }];
                
                [self presentSemiView:_modelview];
                
            }else{
                
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:@"系统繁忙,请稍后再试" Controller:self];
            }
            
            
        }else{
            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
            [mentionview showLable:@"您已是至尊会员,无需重复购买" Controller:self];
        }
        
    }else{
        
        //加入购物车");
        int cart1= (int)[ShopCarManager sharedManager].s_count ;
        
        if(cart1 >=20)
        {
            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
            [mentionview showLable:@"亲,购物车最多只能放入20件商品" Controller:self];
            
            return;
        }

        if(self.atrrListArray.count)
        {
            
            [self creatAttrModelView:@"加购物车"];
            
            CGFloat YY=0;
            
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
            
            [UIView animateWithDuration:0.1 animations:^{
                
                
                _modelview.frame=CGRectMake(0, YY, kApplicationWidth, kApplicationHeight-YY+20);
                
            } completion:^(BOOL finished) {
                
                
            }];
            
            [self presentSemiView:_modelview];
            
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"系统繁忙,请稍后再试" Controller:self];
            
        }

        
    }
    
    self.tag = sender.tag;
    
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


#pragma mark H5获取邀请码
-(void)getcodeHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    
    NSString *token = [user objectForKey:USER_TOKEN];
    
    NSString *url=[NSString stringWithFormat:@"%@inviteCode/getInviteCode?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    
    NSString *URL=[MyMD5 authkey:url];
    
    //    [[Animation shareAnimation] createAnimationAt:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
//       responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            
            if(str.intValue==1)
            {
                
                self.invitCode= responseObject[@"inviteCode"];
                
                
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
        
        //网络连接失败");
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        
    }];
    
}

#pragma mark 推荐热卖
- (UIView*)creatBestSeller
{
    
    CGFloat width = (kApplicationWidth - 60)/2;
    CGFloat heigh = width;

    
    MyLog(@"%d",_typeCount);
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kApplicationWidth, heigh*_typeCount+_typeCount*20)];
    backView.tag = 55555;
    
    int xxxx=0;
    int yyyy=0;
    for(int i=0;i<_hostDataArray.count;i++)
    {
        ShopDetailModel *model = _hostDataArray[i];
        
        xxxx = i%2;
        yyyy = i/2;
        
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(20+(width+20)*xxxx, 0+(heigh+20)*yyyy, width, heigh)];
        
//        [imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.pic]]];
        
        
        NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_Upy],model.pic]];
        
        __block float d = 0;
        __block BOOL isDownlaod = NO;
        
        [imageview sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            d = (float)receivedSize/expectedSize;
            isDownlaod = YES;
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            
            if (image != nil && isDownlaod == YES) {
                imageview.alpha = 0;
                [UIView animateWithDuration:0.5 animations:^{
                    imageview.alpha = 1;
                } completion:^(BOOL finished) {
                }];
            } else if (image != nil && isDownlaod == NO) {
                
                imageview.image = image;
            }
        }];

        imageview.tag = 50000+i;
        imageview.userInteractionEnabled = YES;
        [backView addSubview:imageview];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sellerImageClick:)];
        [imageview addGestureRecognizer:tap];

    }
    
    return backView;
}

-(void)sellerImageClick:(UITapGestureRecognizer*)tap
{
    MyLog(@"tap.tag is %d",(int)tap.view.tag);
    
    ShopDetailModel *model = _hostDataArray[tap.view.tag%50000];
    NSString *shopcode = model.shop_code;
    
    //shop_code: %@", shopcode);
    
    if ([shopcode hasPrefix:@"type2"]) {
        NSArray *typeArr = [shopcode componentsSeparatedByString:@"="];
        NSString *idStr = [typeArr lastObject];
        
        NSDictionary *type2Dic = [self FindNameForTPYEDB:idStr];
        
        
        NSString *ID = type2Dic[@"id"];
        NSString *title = type2Dic[@"name"];
        
        if (ID != nil) {
        
            TFSearchViewController *svc = [[TFSearchViewController alloc] init];
            svc.parentID = ID;
            svc.shopTitle = title;
            
    //        svc.typeID = type1;
    //        svc.typeName = type_name;
            
            svc.hidesBottomBarWhenPushed=YES;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }
        
        
    } else {
        
        TFScreenViewController *screen = [[TFScreenViewController alloc]init];
        screen.muStr = shopcode;
        screen.titleText = model.shop_name;
        screen.index = 1;
        screen.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:screen animated:YES];
    }
    
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

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [MBProgressHUD hideHUDForView:self.view];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    //    //商品属性及库存分类查询
    //    [self requestShopHttp];
    
    //保存所有看过的商品信息
    //    [self AddmystepsHttp];
    
    [self isBaoyouHttpRequest];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:_currentStatusBarStyle];
    //每日流程2
//    [self dailyTaskView1];
    
    //每日流程3
//    [self dailyTaskView2];
    
    _cutdowntime = 1800;

    [self getShopCartFromDB:YES];
    
    NSString *time = [[NSUserDefaults standardUserDefaults] objectForKey:ShareAnimationTime];
    NSString *currTime = [MyMD5 getCurrTimeString:@"year-month-day"];
    if (time == nil || ![time isEqualToString:currTime]) {
        [_aView animationStart:YES];
    } else {
        [_aView animationStart:NO];
    }

}


//本地获取购物车数量
- (void)getShopCartFromDB:(BOOL)isTime
{
    int cart1= (int)[ShopCarManager sharedManager].s_count ;
    
    
    if(cart1>0)
    {
        _carBtn.markNumber = cart1;
        _pubCartcount = _carBtn.markNumber;
        
        if(cart1>0)
        {
            [self loadTime];
        }else{
            if(_isMove == YES)
            {
                _isMove = NO;
            }
            
            //关闭定时器
            [_mytimer invalidate];
            _mytimer = nil;
            _carBtn.time = @"";
//            _carBtn.markNumber = 0;
            [self dismissPromptview];

        }
        
        if (isTime) {
        
        } else {
            [self dismissPromptview];
            
            [_mytimer invalidate];
            _mytimer = nil;
        }
        
    }else{
        
        if(_isMove == YES)
        {
            _isMove = NO;
        }
        
        //关闭定时器
        [_mytimer invalidate];
        _mytimer = nil;
        _carBtn.time = @"";
        _carBtn.markNumber = 0;
        [self dismissPromptview];
        
    }
}

-(void)backdetailview:(NSNotification*)note
{
    
    [self markrequestHttp];
   
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_dailyTimer_1 invalidate];
    [_dailyTimer_2 invalidate];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
