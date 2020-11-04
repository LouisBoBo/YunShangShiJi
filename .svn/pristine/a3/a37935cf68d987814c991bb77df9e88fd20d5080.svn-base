//
//  PaystyleViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/7/25.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopDetailModel.h"
#import "BuySuccessViewController.h"
@protocol payMoneyDelegate <NSObject>

-(void)returnMoney:(NSString *)payStyle :(NSString *)money;

@end

@interface PaystyleViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIAlertView* mAlert;
    NSMutableData* mData;

}

@property (nonatomic ,assign)id<payMoneyDelegate> delegate;
@property (nonatomic ,strong)NSString *order_code;                  //订单号
@property (nonatomic ,strong)ShopDetailModel *shopmodel;
@property (nonatomic ,strong)NSString *price;

@property (nonatomic , strong)NSString* p_type;
@property (nonatomic , strong)NSString* shop_from;



@property(nonatomic,strong)NSArray     *sortArray;


//订单个数
@property (nonatomic ,strong)NSString *urlcount;
@property (nonatomic)NSInteger requestOrderDetail;

/**
 *  从哪个页面过来
 */
@property (nonatomic, copy)NSString *fromType;
@property (nonatomic, copy)NSString *unionid;

@property (nonatomic,strong)NSString *lasttime;

+(BuySuccessViewController *)sharedManager;
@end
