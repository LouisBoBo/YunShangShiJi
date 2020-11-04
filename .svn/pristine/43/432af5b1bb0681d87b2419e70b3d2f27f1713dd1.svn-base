//
//  TFPayStyleViewController.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/6/22.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFBaseViewController.h"
#import "ShopDetailModel.h"

typedef NS_ENUM(NSInteger, CellStyle)
{
    CellStyleFromTitle = 100, /**< 带标题cell */
    CellStyleFromPay
};

typedef NS_ENUM(NSInteger , PayType)
{
    PayTypeSingle = 100, /**< 单选模式 */
    PayTypeGroup    /**< 组合付款 */
};
@interface TFPayStyleViewController : TFBaseViewController
- (instancetype)initWithPayType:(PayType)payType price:(double)price;
/**
 *  待付款价格
 */
@property (nonatomic, assign)double price;
@property (nonatomic, assign)double SuccessViewMoney;//传给支付成功的钱


/**
 *  付款模式
 */
@property (nonatomic, assign)PayType payType;

/**
 *  来源     4:夺宝   0:普通商品  1:0元购   2:会员商品  3:活动商品    6:自己加的搭配购参数判断 5:签到里面的活动商品 7活动商品成团 8一元夺宝 9一元购买 10 1元购拼团 11购买会员卡
 */
@property (nonatomic , strong)NSString* shop_from;
@property (nonatomic , strong)NSString* p_type;
@property (nonatomic , strong)NSString* isOpen_type;//记录是否开启余额翻倍
@property (nonatomic , assign)BOOL is_group;      // 别个参团
@property (nonatomic , assign)BOOL isTM;          //是否特卖
/**
 *  订单号
 */
@property (nonatomic ,strong)NSString *order_code;
@property (nonatomic ,strong)ShopDetailModel *shopmodel;
@property (nonatomic ,strong)NSString *urlcount;
@property(nonatomic,strong)NSArray     *sortArray;
@property (nonatomic)NSInteger requestOrderDetail;

/**
 *  从哪个页面过来
 */
@property (nonatomic, copy)NSString *fromType;
@property (nonatomic, copy)NSString *unionid;
@property (nonatomic,strong)NSString *lasttime;

@property (nonatomic,assign)NSInteger is_roll;      //是否参与拼团  0否1我发起2我参与3我发起成功4机器人参与
@property (nonatomic,assign)BOOL isFashionBuy;  //你时尚我买单的订单商品   由我发起的组团订单

@end

@interface PayStyleItem : NSObject



@property (nonatomic, copy)NSString *title;
@property (nonatomic, assign)double price;
@property (nonatomic, assign)BOOL selected;
@property (nonatomic, assign)CellStyle cellStyle;
@end

typedef void(^CancelBlock)();
typedef void(^ConfirmBlock)();
@interface PopBackgroundView : UIView

@property (nonatomic, copy) CancelBlock cancelClickBlock;
@property (nonatomic, copy) ConfirmBlock confirmClickBlock;

- (void)show;
- (void)setCancelBlock:(CancelBlock)canBlock withConfirmBlock:(ConfirmBlock)conBlock;

@end
