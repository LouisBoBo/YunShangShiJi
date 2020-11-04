//
//  AffirmOrderViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/5/25.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopDetailModel.h"
#import "UPPayPlugin.h"
#import "AdressModel.h"
#import "MyCardModel.h"


@protocol sendMsgToWeChatViewDelegate <NSObject>
- (void) changeScene:(NSInteger)scene;
- (void) sendTextContent;
- (void) sendImageContent;
- (void) sendPay;
- (void) sendPay_demo;
@end

typedef enum {
    NormalType = 1,
    MemberType = 2,
    SignType = 3,//签到
    IndianaType = 4,//夺宝
    OneYuanType = 5//一元夺宝
} AffirmOrderType;

@interface AffirmOrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate,UPPayPluginDelegate>
{
    UIAlertView* mAlert;
    NSMutableData* mData;
    
}

@property (nonatomic , assign) AffirmOrderType affirmType;;
@property (nonatomic , strong) NSString *shareReductionPrice; //夺宝分享减免价格
@property (nonatomic , assign) BOOL isNewbie;                //是否新用户

//订单商品颜色，尺码，数量，价格
@property (nonatomic , strong)NSString *color;
@property (nonatomic , strong)NSString *size;
@property (nonatomic , strong)NSString *price;
@property (nonatomic , strong)NSString *number;
@property (nonatomic , assign)UIImageView *headimage;
@property (nonatomic , strong)MyCardModel *cardModel;

@property (nonatomic , strong)ShopDetailModel *shopmodel;
//订单编号
@property (nonatomic , strong)NSString *order_code;
//是购买还是积分兑换
@property (nonatomic , strong)NSString *typestring;
//是否选择的收货地址
@property (nonatomic , strong)AdressModel *addressmodel;

@property (nonatomic , strong)NSString *packageCode;    //套餐编号

@property (nonatomic , strong)NSString *stockType;     //库存id

@property (nonatomic , strong)NSString *shopZeroType;     //0元购商品类型

@property (nonatomic)NSUInteger dataArrayCount;         //用来判断是  超值单品／超值套餐

//选择商品色ID
@property (nonatomic , strong)NSString *selectColorID;
//选择商品色
@property (nonatomic , strong)NSString *selectColor;
//选择商品尺码ID
@property (nonatomic , strong)NSString *selectSizeID;
//选择商品尺码
@property (nonatomic , strong)NSString *selectSize;
//选择商品的名称
@property (nonatomic , strong)NSString *selectName;
//选择商品的价格
@property (nonatomic , strong)NSString *selectPrice;
//数据库查找的数据源(购买)
@property (nonatomic , strong)NSMutableArray *stocktypeArray;
//数据库查找的数据源(积分兑换)
@property (nonatomic , strong)NSMutableArray *JifenshopArray;
//用作分享的图片
@property (nonatomic , strong)NSString *four_pic;
@property (strong, nonatomic)  UILabel *integralLabel;
@property (strong, nonatomic)  UISwitch *integralSwitch;
@property (weak, nonatomic) IBOutlet UIView *spaceView;

//收货地址id
@property (nonatomic , strong)NSString *addressid;
@property (strong, nonatomic)  UILabel *address;
@property (strong, nonatomic)  UILabel *phone;
@property (strong, nonatomic)  UILabel *storename;
@property (strong, nonatomic)  UILabel *name;
//@property (weak, nonatomic) IBOutlet UIScrollView *Myscrollview;
@property (strong, nonatomic)  UIView *InforView;
//@property (weak, nonatomic) IBOutlet UIView *ShopView;
@property (strong, nonatomic)  UIView *OrderView;
@property (strong, nonatomic)  UITextField *Message;
@property (strong, nonatomic)  UILabel *totalprice;
//@property (weak, nonatomic) IBOutlet UILabel *totalNumber;
//@property (weak, nonatomic) IBOutlet UIView *discountView;
@property (strong, nonatomic)  UILabel *selectNumber;
@property (strong, nonatomic)  UILabel *discountMoney;
@property (weak, nonatomic) IBOutlet UILabel *integral;
@property (weak, nonatomic) IBOutlet UILabel *subIntegral;
//@property (weak, nonatomic) IBOutlet UITextField *inputIntegralBtn;
@property (strong, nonatomic)  UILabel *way;
@property (strong, nonatomic)  UILabel *wayDetail;
@property (strong, nonatomic)  UILabel *PriceTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *couponLabel;
@property (strong, nonatomic) UIImageView *addressImg;
@property (weak, nonatomic) IBOutlet UIImageView *couponImg;
@property (weak, nonatomic) IBOutlet UILabel *chaneLine;
@property (weak, nonatomic) IBOutlet UILabel *postage;

@property(nonatomic,strong) NSString *post_money;     //邮费
//订单的总价
@property(nonatomic,strong) NSString *shop_seprice;
//下单方式
@property (weak, nonatomic) NSString *ordertypestring;

#pragma mark 支付成功后自动分享
-(void)payFinished:(NSDictionary*)result;

@property (nonatomic, assign) id<sendMsgToWeChatViewDelegate,NSObject> delegate;

- (void)showAlertWait;
- (void)showAlertMessage:(NSString*)msg;
- (void)hideAlert;

- (UIView *)titleView;

@property(nonatomic, retain)NSString *mode;
@property(nonatomic, retain)NSString *tnURL;
@property(nonatomic, retain)NSString *configURL;

@property (nonatomic,strong)NSArray *shopArray;


@property (nonatomic) CGFloat totalShop_se_price;

@end
