//
//  BankCardModel.h
//  YunShangShiJi
//
//  Created by 云商 on 15/7/8.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankCardModel : NSObject

@property (nonatomic ,copy)NSString *bank_name;     //银行卡名称
@property (nonatomic ,copy)NSString *bank_no;       //银行卡号
@property (nonatomic ,copy)NSString *branch_name;   //支行名称
@property (nonatomic ,copy)NSString *ID;
@property (nonatomic ,copy)NSString *identity;      //身份证号码
@property (nonatomic ,copy)NSString *name;          //用户姓名
@property (nonatomic ,copy)NSString *user_id;

@property (nonatomic, copy)NSString *e_main;
@property (nonatomic, copy)NSString *phone;         //手机号码
@property (nonatomic, copy)NSString *card_name;     //银行卡名称

@property (nonatomic, strong)NSNumber *province_id; //省id
@property (nonatomic, copy)NSString *province;      //省
@property (nonatomic, strong)NSNumber *city_id;     //市id
@property (nonatomic, strong)NSString *city;        //市
@property (nonatomic, strong)NSNumber *add_date;    //添加时间
@end
