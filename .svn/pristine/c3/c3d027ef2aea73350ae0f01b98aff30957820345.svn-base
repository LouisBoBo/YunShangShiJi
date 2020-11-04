//
//  GlobalTool.h
//  dreamer
//
//  Created by ken on 15/1/2.
//  Copyright (c) 2015年 PA. All rights reserved.
//
#import <sqlite3.h>
#import "Animation.h"
#import "ValueObserver.h"
#import "MyTabBarController.h"
#import "WTFObject.h"
#import "TFPublicClass.h"
#import "NextTaskManager.h"
//自定义tarbarview
UIImageView *Myview;
MyTabBarController *Mtarbar;

ValueObserver *gKVO;
//UIButton *selectedBtn;

//数据库
sqlite3 *AttrcontactDB;

NSString* _databasePath ;


/*
 U拍云
 upyun.bucketName=yssj-real-test
 upyun.userName=admin
 upyun.password=ys123456
 upyun.url=https://yssj-real-test.b0.upaiyun.com/
 

 环信
 API_SERVER_HOST = a1.easemob.com
 
 APPKEY = yssjsz#yssj-real-test
 
 APP_CLIENT_ID = YXA6twL54JmkEeWB3d-FLI4Ghg
 
 APP_CLIENT_SECRET = YXA6c-gBpWtOgOiGFgLZwZ9YeP72eK4
*/

#define RongCloub_Token @"rongCloubToken"
#define IsRongCloub [DataManager sharedManager].isRongCloub


#define timeOutMsg @"连接已超时，请重试"

/*****************密码错误提示**************/
#define pwdflagString1 @"您的密码错误，还有2次输入的机会"
#define pwdflagString2 @"您的密码错误，还有1次输入的机会"
#define pwdflagString3 @"输入错误的次数已达上限，请通过其他方式修改支付密码"


#pragma mark -用户信息
/* ---------------------------------------用户信息------------------------------------------ */
#define USER_WX_HEADPIC              @"USER_WX_HEADPIC"

#define USER_HEADPIC          @"headImg"
#define USER_REALM            @"realm"
#define FILE_USER             @"user.plist"
#define USER_INFO             @"userinfo"
#define SHOP_INFO             @"shop_info"
#define SHOP_INFORMATION      @"shop_infomation"
#define USER_PHONE            @"phone"
#define USER_NAME             @"name"
#define USER_ADDRESS          @"address"
#define USER_EMAIL            @"email"
#define USER_PASSWORD         @"password"
#define OTHER_PASSWORD        @"other_password"
#define USER_TOKEN            @"token"
#define USER_ARRER            @"user_arrer"
#define USER_BIRTHDAY         @"user_birthday"
#define USER_PERSON_SIGN      @"person_sign"
#define USER_UUID             @"uuid"
#define USER_IDFA             @"idfa"
#define USER_IMEI             @"imei"//本地的
#define HTTP_IMEI             @"httpimei"//服务器的
#define USER_HOBBY            @"hobby"
#define USER_ID               @"uid"
#define UNION_ID              @"union_id"
#define USER_TYPE             @"userType"
#define USER_VERSION          @"version_no"
#define USER_QUESTION         @"question"
#define USER_MEMBER           @"member"
#define USER_GetSwitch        @"getSwitch"
#define USER_LoginType        @"user_loginType"
#define USER_LoginToWeiXin    @"user_loginToWeiXin"
#define USER_CLASSIFY         @"userclassify"     //分类用户 0未分类 1A类 2B类
#define USER_V_IDENT          @"v_ident"

//0普通用户1已通过验证2会员3至尊会员入口关闭4会员到期前两个月开启5会员过期
#define SEND_HEADPIC          @"sendheadpic"
#define IS_MEMBER             @"ismember"
#define MESSAGE_CHAR          @"messageChar"

#define FAIL_TOKEN            @"failtoken"
#define LOGIN_TIME            @"login_time"
#define TYPE_DATA             @"type_data"
#define ATTR_DATA             @"attr_data"
#define BUS_DATA              @"bus_tag_data"
#define TAG_DATA              @"tag_data"
#define TYPE_TAG_DATA         @"type_tag_data"
#define SHOP_ATTR             @"shop_attr"
#define ADDRESS_ID            @"adress_id"
#define DECICETOKEN           @"deviceToken"
#define PAY_PRICE             @"pay_price"
#define PAY_MONEY             @"pay_money"
#define SHARE_TIME            @"share_time"
#define KICKBACK              @"kickback"
#define CODE_TYPE             @"code_type"
#define ORDER_TOKEN           @"orderToken"
#define SHARE_FLAG            @"flag"
#define TAGNAMEARRAY          @"tagnamearray"
#define TWOFLODNESS           @"twofoldness"

//收货人信息
#define ORDER_NAEM            @"order_name"
#define ORDER_PHONE           @"order_phone"
#define ORDER_ADDRESS         @"order_adress"
#define ORDER_STATE_CITY_AREA @"state_city_area"
#define ORDER_STREET          @"order_street"
#define ORDER_CODE            @"order_code"

//商品的属性
#define USER_DATA             @"data"
#define SHUXING_ID            @"shuxing_id"
#define SELECT_PHOTO          @"select_photo"

//商品信息
#define SHOP_CODE             @"shop_code"
#define SHOP_NAME             @"shop_name"
#define SHOP_PIC              @"shop_pic"
#define SHOP_TITLE            @"shop_title"
#define SHOP_LINK             @"shop_link"
#define SHOP_PRICE            @"shop_price"
#define SHOP_QR_PIC           @"qr_pic"
#define ORDER_CODE            @"order_code"
#define QR_LINK               @"QrLink"
#define SHOP_TYPE2            @"shop_type2"
#define TIXIAN_SHARE_PIC      @"tixian_pic"
#define TIXIAN_SHARE_TITLE    @"tixian_title"
#define TIXIAN_SHARE_DISCRIPTION @"tixian_discription"
#define DISCRIPTION           @"discription"
#define SHOP_BRAND            @"shop_brand"

//o元购套餐类型
#define P_TYPE                @"1"
#define IS_SHARE_TYPE         @"duobao"
//店铺信息
#define STORE_CODE            @"store_code"
#define STORE_NAME            @"store_name"
#define MARK_STORE            @"mark_store"
#define TODAY_STORE           @"today_store"

#define PTEID                 @"pteid"
#define RedCash               @"红包抵用返现"

//签到分享类型
#define DAILY_TASK_BUQIAN        @"补签"
#define DAILY_TASK_ZERO          @"0元购"
#define DAILY_TASK_YOUHUI        @"优惠券"
#define DAILY_TASK_JIFEN         @"积分"
#define DAILY_TASK_XIANJING      @"现金"
#define DAILY_TASK_STORE         @"开店"
#define DAILY_TASK_BAOYOU        @"签到包邮"
#define DAILY_TASK_DUOBAO        @"签到夺宝"
#define DAILY_TASK_DOUBLE        @"余额翻倍"
#define DAILY_TASK_DUOBAO_BAOYOU @"签到夺宝包邮"
#define DAILY_EXTRA_BONUS        @"额外奖励"
#define DAILY_JIFEN_GOLD         @"积分升级金币"
#define DAILY_YOUHUI_GOLDCOUPONS @"优惠劵升级金券"
#define DAILY_TASK_YIDOU         @"衣豆"
#define DAILY_TASK_TIXIAN        @"提现额度"

//赚钱任务
#define TASK_ADD_SHOPCART       @"0"    //加购物车数量
#define TASK_SHARE_SHOPCOUNT    @"0"    //分享商品次数
#define TASK_LIULAN_SHOPCOUNT   @"0"    //浏览商品次数
#define TASK_LIULAN_TOPIC       @"0"    //浏览穿搭次数
#define TASK_LIULAN_LASTTIME    @"上一次浏览" //上一次浏览
#define REMIND_ORDER @"remind_order"    //订单成功提示框

#define SIGN_STRING @"signstring"
#define FIRST_SHARE @"firstshare"

#define UPDATE_VERSION @"update_version" //不更新的版本
#define UPDATE_TIME @"update_time" //时间（3天后再弹）
#define UPDATE_SHOW @"update_show" //是否选中不再提醒
#define JIZAN_POPUP @"jizan_popup" //集赞活动规则弹框
#define LUCK_POPUP  @"luck_popup"  //抽奖活动说明弹框
#define WALLET_POPUP @"wallet_popup" //钱包抽奖活动说明弹框
#define FIGHTDATAARRAY @"fightdata"//拼团选择的商品
#define RAWARD_UP   @"raward_up"   //是否勾选使用5衣豆
//购物列表商品分类
#define SELECT_INDEX             @"select_index"
//分享生活图
#define SHARE_LIFE_IMAGE         @"share_life_image"

//支付成功
#define PYSUCCESS @"paysuccess"
//APP启动次数
#define NumberCount @"NumberCount"
//APP启动时间
#define NowDate @"NowDate"
//购物车结束时间
#define CARTENDDATE @"cartenddate"
//记录强制浏览蒙层弹出时间
#define BROWSEDATE  @"browsedate"
//记录超级0元购在详情页弹出的时间
#define SUPPERAEROSHOPPINGUPDATE @"superzeroshoppingupdate"
//记录超级0元购在详情页弹出次数
#define SUPPERERROSHOPPINGUPCOUNT @"suppershoppingupcount"
//记录超级0元购正常弹出次数
#define SUPPERERROSHOPPINGEVERYUPCOUNT @"suppershoppingeveryupcount"
//记录详情奖金提示弹框弹出时间
#define RAWARDPROMPT @"rawardprompt"
//记录精选推荐蒙层弹出时间
#define RECOMMENDDATE @"recommenddate"
//记录精选推荐是否勾选
#define RECOMMENDSELECT @"recommendselect"
//记录精选推荐弹出时间
#define RECOMMENDPOPDATE @"recommendpopdate"
//记录精选推荐当天浏览完时间
#define FINISHRECOMMENDPOPDATE @"finishrecommendpopdate"
//记录超级0元购弹框是否弹出
#define ZEROSHOPPINGMENTION @"zero_shopping_mention"
//记录超级0元购弹框首次在抽奖页面弹出
#define ZEROSHOPPINGLUCKMENTION @"zero_shopping_luck_mention"
//记录超级0元购弹框首次在任务页面弹出
#define ZEROSHOPPINGTASKMENTION @"zero_shopping_task_mention"
//记录超级0元购弹框首次在首页页面弹出
#define ZEROSHOPPINGHOMEMENTION @"zero_shopping_home_mention"
//记录精选推荐浏览的数据
#define RECOMMENDBROWSEDATA @"recommendbrowsedata"
//记录每日额外任务-购买任务完成时间
#define ADDITIONALFINISHDATA @"additionalfinishdata"
//记录惊喜提现任务-购买任务完成时间
#define TIXIANFINISHDATA @"tixianfinishdata"
//记录超级0元购任务-购买任务完成时间
#define SUPERZEROSHOPPINGDATE @"suppershoppingfinishdata"
//记录每日任务数提示弹框弹出的时间
#define TASKCOUNTMENTION @"taskcountmention"
//记录每日必做任务额外任务完成弹框弹出时间
#define MUSTANDEXTRATASKFINISH @"mustandextrataskfinish"
//记录提现任务完成弹框弹出时间
#define TIXIANTASKFINISH @"tixiantaskfinish"
//记录每日任务数提示弹框是否弹出
#define TASKCOUNTUPDATE @"taskcountupdate"
//记录用户H5获得奖金提示弹框是否弹出
#define H5MONEYPOPUP @"h5moneypopup"
//记录赚钱小秘密动画时间
#define SECRETDATE @"secretdate"
//记录活力值为20弹框弹出时间
#define VALITYDATE @"valitydate"
//记录每天是否第一次进入签到页面
#define FIRSTCOMING @"firstcoming"
//疯狂星期一弹框时间
#define CRAZYMonday @"crazymonday"
//引导支付弹框弹出时间
#define GUIDEORDER  @"guideorder"
//记录气泡开始时间
#define BUBBLEDATE @"bubbledate"
//记录是第几天的气泡
#define BUBBLEDAY @"bubbleday"
#define PAY_ORDERCODE     @"pay_orderCode"//夺宝支付后订单编号
#define PAY_TYPE     @"pay_type"//夺宝支付方式
#define PAY_NUM     @"pay_num"//夺宝支付后获取参与号的方式
/*手机是否开店*/
#define Phone_isOpen @"phone_isOpen"
/*消息总数量*/
#define USER_AllCount @"AllCount"
//余额翻倍开始时间
#define DOUBLE_S_TIME @"s_time"
#define DOUBLE_T_TIME @"t_time"

#define MY_HOUR   3600
#define MY_MINUTE 60
#define MY_SEC    1
#define SEC_5 5*MY_SEC


FOUNDATION_EXPORT NSString *const YFLaunchViewDisappearTime;//进入后台时间
FOUNDATION_EXPORT NSString *const YFLaunchViewDisappear;//启动图移除通知

#define ShareAnimationTime @"ShareAnimationTime"   //分享动画时间
#define IconAnimationTime @"IconAnimationTime"     //tab动画时间
#define PushOpenTime @"PushOpenTime"               //打开推送消息的时间
#define ShareCount @"sharecount"                   //分享的次数
#define memberPriceRate [WTFObject shareWTF].myMemberPriceRate


#pragma mark - 接口

//#define HBLog(...) NSLog(__VA_ARGS__)

/*-------------------------------友盟统计----------------------------*/

//-统计页面-5个
// 小店            XiaodianPage
// 购物            GouwuPage
// 签到            QiqndaoPage
// 特卖            TemaiPage
// 我的            WodePage

//二控件点击次数
//购物里面-8个
// 搜索
#define SHOP_SOUSUO         @"shop_sousuo"
// 筛选
#define SHOP_SAIXUAN        @"shop_saixuan"
// 提交
#define SHOP_TIJIAO         @"shop_tijiao"
// 小店页面店铺分享
#define STORE_SHARE         @"store_share"
// 特卖0
#define TEMIA_0             @"temai_0"
// 特卖9，
#define TEMIA_9             @"temai_9"
// 特卖19，
#define TEMIA_19            @"temai_19"
// 特卖29
#define TEMIA_29            @"temai_29"

//签到页面-7个
// 余额
#define QIANDAO_YUER            @"qiandao_yuer"
// 积分
#define QIANDAO_JIFEN           @"qiandao_jifen"
// 卡券
#define QIANDAO_KAQUAN          @"qiandao_kaquan"
// 补签卡
#define QIANDAO_BUQIAN          @"qiandao_buqian"
// 签到说明
#define QIANDAO_SHUOMING        @"qiandao_shuoming"
// 每日任务
#define QIANDAO_RENWU           @"qiandao_renwu"
// 签到分享
#define QIANDAO_SHARE           @"qiandao_share"

// 商品页面-10个
// 普通分享，
#define SHOP_SHARE              @"shop_share"
// 购物车，
#define SHOP_GOUWUCHE           @"shop_gouwuche"
// 喜欢，
#define SHOP_XIHUAN             @"shop_xihuan"
// 加入购物车，
#define SHOP_ADDGOUWUCHE        @"shop_addgouwuche"
// 参数，
#define SHOP_CANSHU             @"shop_canshu"
// 评价，
#define SHOP_PINGJIA            @"shop_pingjia"
// 立即购买，
#define SHOP_GOUMAI             @"shop_goumai"
// 确定，
#define SHOP_QUEDING            @"shop_queding"
// 确认下单，
#define SHOP_ORDER              @"shop_order"
// 付款
#define SHOP_PAY                @"shop_pay"

/**< 强制浏览 */
//签到说明按钮
#define BrowseShop_ExplainButton      @"BrowseShop_ExplainButton"
//点击退出
#define BrowseShop_ExitButton         @"BrowseShop_ExitButton"
//

/* ---------------------------------------调用接口------------------------------------------ */

#define USER_SHARE_APP @"share/900+900-IOS(1).png"

//正式环境ip: 183.61.252.5

////////域名
#define urlHost @"http://221.228.229.90"
#define VERSION @"V1.32&channel=7"


///////图片地址
#define PHOTOhttp @"http://photo.misshoneycool.com/"
#define SHARE_UPYHTTP @"https://yssj668.b0.upaiyun.com"


#pragma mark - 字体颜色
/* ---------------------------------------字体色--------------------------------------- */

//#define kTextColor [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1.0]

/// 设置颜色 示例：UIColorHex(0x26A7E8)
#define UIColorHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/// 设置颜色与透明度 示例：UIColorHEX_Alpha(0x26A7E8, 0.5)
#define UIColorHex_Alpha(rgbValue, al) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:al]

//颜色和透明度设置
#define RGBA(r,g,b,a)   [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]


//按钮蓝色字体  （按钮、可点击文字使用）
#define kTextBlueColor  [UIColor colorWithRed:30/255.0 green:181/255.0 blue:250/255.0 alpha:200/255.0]

//按钮灰色字体  （副标题文字使用）
#define kTextGreyColor  [UIColor colorWithRed:129/255. green:129/255. blue:129/255. alpha:1.]

//标签背景颜色
//#define kLabelColor
//用于导航栏
#define kNavLineColor   [UIColor colorWithRed:197/255.0 green:197/255.0 blue:197/255.0 alpha:1.0]
//用于内容区分割线
#define kTableLineColor   [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0]

//线条颜色
#define lineGreyColor   [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]

#define kSystemLineColor [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0]
//灰色
#define kbackgrayColor  [UIColor colorWithRed:196/255.0 green:196/255.0 blue:201/255.0 alpha:1.0]

// 随机色
#define DRandomColor    [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:arc4random_uniform(255)/255.0]

//view框的颜色
#define BodyColor [UIColor colorWithRed:87/255.0 green:195/255.0 blue:135/255.0 alpha:240/255.0].CGColor

//headview的背景色
#define headViewColor [UIColor colorWithRed:87/255.0 green:195/255.0 blue:135/255.0 alpha:240/255.0]

//tarbar字体选中色  桔黄
#define tarbarYellowcolor [UIColor colorWithRed:255/255.0 green:102/255.0 blue:0/255.0 alpha:240/255.0]

//tarbar字体选中色  玫红
#define tarbarrossred [UIColor colorWithRed:255/255.0 green:63/255.0 blue:139/255.0 alpha:255/255.0]

#define bodyrossred [UIColor colorWithRed:252/255.0 green:137/255.0 blue:184/255.0 alpha:255/255.0]

//背景主题颜色  灰色
#define kBackgroundColor [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]

//深灰色字体
#define kTextColor [UIColor colorWithRed:152/255. green:152/255. blue:152/255. alpha:1.]

//标题黑色字体  （标题、导航使用）
#define kTitleColor     [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]

//用于重要文字信息   主题字体颜色
#define kMainTitleColor     [UIColor colorWithRed:62/255.0 green:62/255.0 blue:62/255.0 alpha:1.0]

//用于普通文字信息   次级字体颜色
#define kSubTitleColor     [UIColor colorWithRed:125/255.0 green:125/255.0 blue:125/255.0 alpha:1.0]

//白色字体
#define kWiteColor  [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]


#define kGreenColor  [UIColor colorWithRed:99/255. green:205/255. blue:64/255. alpha:1.0f];
/* -----------------------------------------屏幕适配---------------------------------------- */
#pragma mark - 屏幕适配
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO) 
#define kIOSVersions [[[UIDevice currentDevice] systemVersion] floatValue] //获得iOS版本
#define kUIWindow    [[[UIApplication sharedApplication] delegate] window] //获得window

#define kUnderStatusBarStartY (kIOSVersions>=7.0 ? 20 : 0)                 //7.0以上stautsbar不占位置，内容视图的起始位置要往下20
//状态栏的高度
#define ORIGIN_Y (IOS7 ? 20 : 0)
#define kScreenSize           [[UIScreen mainScreen] bounds].size                 //(e.g. 320,480)
#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width           //(e.g. 320)
#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height          //(e.g. 480)
#define kScreenHeightIOS7  (kIOSVersions>=7.0 ? [[UIScreen mainScreen] bounds].size.height + 64 : [[UIScreen mainScreen] bounds].size.height)

#define kIOS7OffHeight (kIOSVersions>=7.0 ? 64 : 0)

#define kApplicationSize      [[UIScreen mainScreen] applicationFrame].size       //(e.g. 320,460)
#define kApplicationWidth     [[UIScreen mainScreen] applicationFrame].size.width //(e.g. 320)
#define kApplicationHeight    [[UIScreen mainScreen] applicationFrame].size.height//不包含状态bar的高度(e.g. 460)

#define kStatusBarHeight         (IS_IPHONE_X?44.0f: 20.0f)
#define kNavigationBarHeight     44
#define kNavigationheightForIOS7 (IS_IPHONE_X?88.0f: 64.0f)
#define kContentHeight           (kApplicationHeight - kNavigationBarHeight)
#define kTabBarHeight            (IS_IPHONE_X?83.0f: 49.0f)
#define kSeekTabBarHeight (kIOSVersions>=7.0 ? 0 : 49)

// 480  568  667  736
// 是否是4英寸
#define ThreeAndFiveInch (480.0 == [UIScreen mainScreen].bounds.size.height)
#define FourInch (568.0 == [UIScreen mainScreen].bounds.size.height)
#define FourAndSevenInch (667.0 == [UIScreen mainScreen].bounds.size.height)
#define FiveAndFiveInch (736.0 == [UIScreen mainScreen].bounds.size.height)

/* -------------------------------------iphoneX适配-------------------------------------------- */
#define IS_IPHONE_X (([UIScreen mainScreen].bounds.size.height == 812 || [UIScreen mainScreen].bounds.size.height == 896) ? YES : NO)
#define Height_NavContentBar 44.0f
#define Height_StatusBar (IS_IPHONE_X?44.0f: 20.0f)
#define Height_NavBar (IS_IPHONE_X?88.0f: 64.0f)
#define Height_TabBar (IS_IPHONE_X?83.0f: 49.0f)
#define Height_ViewH   kScreenHeight - Height_NavBar - Height_TabBar
#define View_CenterY(headview) headview.frame.size.height/2+10
#pragma mark - 字体大小
/* -------------------------------------字体大小-------------------------------------------- */
#define kStatementFontSize      [UIFont systemFontOfSize:12]       //陈述字体大小
#define kNavigationItemFontSize [UIFont systemFontOfSize:15]       //NavigationItem字体大小
#define kTextFontSize           [UIFont systemFontOfSize:16]       //正文字体大小
#define kButtonFontSize         [UIFont systemFontOfSize:19]       //按钮字体大小
#define kTitleFontSize          [UIFont systemFontOfSize:20]       //NavigationBar标题字体

#define Frame(x,y,w,h)  CGRectMake(x, y, w, h)
#define FrameX(v)       v.frame.origin.x
#define FrameY(v)       v.frame.origin.y
#define FrameW(v)       v.frame.size.width
#define FrameH(v)       v.frame.size.height
#define FrameXW(v)      (v.frame.origin.x + v.frame.size.width)
#define FrameYH(v)      (v.frame.origin.y + v.frame.size.height)


/* ------------------字体图片大小坐标适配--------------------- */

//根据图片名字得到图片  ：会copy
#define ImageNamed(imageName)   [UIImage imageNamed:imageName]
#define HBfont(font) [UIFont systemFontOfSize:font]

//0.9--1---屏幕适配系数（以6plus为标准）
#define SE(w) ((([UIScreen mainScreen].bounds.size.width)/(414.0))== 1? (w):(0.8*w))

//#define SPACE(w) ((([UIScreen mainScreen].bounds.size.width)/(414.0))== 1? (w):(0.8*w))

//获取图片的宽
#define IMAGEW(imageName)  ImageNamed(imageName).size.width
//获取图片的高
#define IMAGEH(imageName)  ImageNamed(imageName).size.height
//获取图片的宽*系数
#define  IMGSIZEW(imageName)  ((([UIScreen mainScreen].bounds.size.width)/(414.0))== 1? (IMAGEW(imageName)*(1.1)):(IMAGEW(imageName)))
//获取图片的高*系数
#define  IMGSIZEH(imageName)  ((([UIScreen mainScreen].bounds.size.width)/(414.0))== 1? (IMAGEH(imageName)*(1.1)):(IMAGEH(imageName)))

#define SN ([UIScreen mainScreen].bounds.size.width)/(1080)
#define ZOOM(px) (((px)*(SN)))

#define SN6 ([UIScreen mainScreen].bounds.size.width)/(750)
#define ZOOM6(px) (((px)*(SN6)))
#define SNN ([UIScreen mainScreen].bounds.size.width)/(375)
#define kZoom6pt(pt) ((pt)*(SNN))
#define ZOOMPT(pt) ((pt)*(SNN))

#define thirtyFour [UIFont systemFontOfSize:ZOOM(34)]
#define fortySize [UIFont systemFontOfSize:ZOOM(40)]
#define fiftySize [UIFont systemFontOfSize:ZOOM(50)]
#define kLeftSpace ZOOM6(20)
#define kNavTitleFontSize [UIFont systemFontOfSize:ZOOM6(36)]
//验证码等待时间
#define kWaitTime 120
//上传又拍云图片压缩系数
#define kImageCompression 0.1f
//上传又拍云图片大小压缩系数
#define kImageSizeCompression 2.0f

/// block self
#define kSelfWeak __weak typeof(self) weakSelf = self
#define kSelfStrong __strong __typeof__(weakSelf) strongSelf = weakSelf
