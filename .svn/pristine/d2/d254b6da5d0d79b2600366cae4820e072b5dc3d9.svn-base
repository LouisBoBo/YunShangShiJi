//
//  OrderModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/22.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject
@property (nonatomic , strong)NSString *add_time;
@property (nonatomic, strong)NSString *is_kick;   //判断能否申请售后
@property (nonatomic , strong)NSString *back;
@property (nonatomic , strong)NSString *g_order_code;
@property (nonatomic , strong)NSString *ID;
@property (nonatomic , strong)NSString *lasttime;
@property (nonatomic , strong)NSString *now;
@property (nonatomic ,strong)NSString *end_time;
@property (nonatomic , strong)NSString *message;
@property (nonatomic , strong)NSString *order_code;
@property (nonatomic , strong)NSString *return_code;
@property (nonatomic , strong)NSString *order_name;
@property (nonatomic , strong)NSString *order_pic;
@property (nonatomic , strong)NSString *order_price;
@property (nonatomic , strong)NSString *shop_price;
@property (nonatomic , strong)NSString *shop_color;
@property (nonatomic , strong)NSString *shop_size;
@property (nonatomic , strong)NSString *shop_num;
@property (nonatomic , strong)NSString *shop_code;
@property (nonatomic , strong)NSString *order_shop_id;
@property (nonatomic , strong)NSString *shop_pic;
@property (nonatomic , strong)NSString *shop_name;
@property (nonatomic , strong)NSString *status;
@property (nonatomic , strong)NSString *return_type;
@property (nonatomic , strong)NSString *orderShopStatus;
@property (nonatomic , strong)NSString *store_code;
@property (nonatomic , strong)NSString *store_name;
@property (nonatomic , strong)NSString *user_id;
@property (nonatomic , strong)NSString *free;
@property (nonatomic , strong)NSString *address;
@property (nonatomic , strong)NSString *consignee;
@property (nonatomic , strong)NSString *phone;
@property (nonatomic , strong)NSString *suppid;
@property (nonatomic, strong)NSString *cause;
@property (nonatomic, strong)NSString *ck_explain;
@property (nonatomic, strong)NSString *ck_id;
@property (nonatomic, strong)NSString *ck_time;
@property (nonatomic, strong)NSString *explain;
@property (nonatomic, strong)NSString *express_id;
@property (nonatomic, strong)NSString *money;
@property (nonatomic, strong)NSString *sizecolor;
@property (nonatomic, strong)NSString *pay_time;
@property (nonatomic, strong)NSString *postcode;
@property (nonatomic, strong)NSArray *orderShops;
@property (nonatomic, strong)NSString *change;
@property (nonatomic, strong)NSString *logi_code;
@property (nonatomic, strong)NSString *logi_name;
@property (nonatomic, strong)NSString *kickBack;

@property (nonatomic, strong)NSString *bak;
@property (nonatomic, strong)NSString *postage;
@property (nonatomic, strong)NSString *shop_from;
@property (nonatomic, strong)NSString *isTM;
@property (nonatomic, strong)NSMutableArray *shopsArray;

//物流信息
@property (nonatomic , strong)NSString *codenumber;
@property (nonatomic , strong)NSString *com;
@property (nonatomic , strong)NSString *companytype;
@property (nonatomic , strong)NSString *condition;
@property (nonatomic , strong)NSString *context;
@property (nonatomic , strong)NSString *ftime;
@property (nonatomic , strong)NSString *time;
@property (nonatomic , strong)NSString *ischeck;
@property (nonatomic , strong)NSString *nu;
@property (nonatomic , strong)NSString *state;
@property (nonatomic , strong)NSString *logisstatus;
@property (nonatomic , strong)NSString *updatetime;

@property (nonatomic ,strong)NSString *supp_address;
@property (nonatomic ,strong)NSString *supp_consignee;
@property (nonatomic ,strong)NSString *supp_kb;
@property (nonatomic ,strong)NSString *supp_phone;
@property (nonatomic ,strong)NSString *supp_postcode;

@property (nonatomic,strong)NSString *pay_status;//[0未支付 1已经支付]

@property (nonatomic ,strong)NSString *shop_se_price;  //分享时加的价格
//默认图片地址
@property (nonatomic ,strong)NSString *def_pic;

/***       售后增加参数      ***/
@property (nonatomic , strong)NSString *end_explain;  //0正常完结1超时自动关闭2买家手动关闭3商家超时未处理,自动完结.4换货,买家未及时确认收货,系统自动确认5商家未及时发货,自动退款.6.平台介入完结
@property (nonatomic , strong)NSString *ys_intervene;  //平台接入 0没有介入,1申请介入,2已经介入.3卖家赢,4买家赢.5不管了

@property (nonatomic , strong)NSString *supp_sign_time;//退货,换货,供应商签收时间.拒签则为拒签时间
@property (nonatomic , strong)NSString *supp_sign_status;//退货换货,供应商拒签,0否1是.默认0
@property (nonatomic , strong)NSString *supp_refuse_msg;//供应商拒绝签收的理由
@property (nonatomic , strong)NSString *supp_certificate;//供应商凭证.图片,以,号间隔
@property (nonatomic , strong)NSString *user_certificate;//买家申请平台接入凭证,以,号间隔
@property (nonatomic , strong)NSString *user_cert_msg;//买家申请平台介入留言
@property (nonatomic , strong)NSString *user_apply_ys_time;//买家申请平台介入时间
@property (nonatomic , strong)NSString *ys_intervene_time;//平台介入时间

@property (nonatomic , strong)NSString *requestNow_time;


@property (nonatomic , strong)NSString *voucher_money;//抵用券金额
@property (nonatomic,strong)NSString *issue_status;//夺宝状态  0正常参与 1主动退款  2未满足人数退款  3中奖 4未中奖
@property (nonatomic,strong)NSString *issue_code;//期号
@property (nonatomic,strong)NSString *participation_code;//参与号
@property (nonatomic,strong)NSString *issue_endtime;//此宝结束时间



@property (nonatomic,assign)NSInteger is_free;      //是否参与免付  0否1是2参与但取消3后台取消
@property (nonatomic,assign)NSInteger is_roll;      //是否参与拼团  0否1我发起2我参与3我发起成功4机器人参与
@property (nonatomic,assign)NSString *roll_code;    //拼团编号      默认0.
@property (nonatomic,strong)NSString *whether_prize;
@end
