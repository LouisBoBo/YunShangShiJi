//
//  RerundViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/6/19.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardTool.h"
#import "CameraVC.h"
#import "ShopDetailModel.h"
@interface RerundViewController : UIViewController<UITextViewDelegate,UITextFieldDelegate,KeyboardToolDelegate,UIActionSheetDelegate,CameraDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *addimage;
@property (weak, nonatomic) IBOutlet UIButton *submit;
@property (weak, nonatomic) IBOutlet UIScrollView *Myscrollview;
@property (weak, nonatomic) IBOutlet UITextView *mytextview;

@property (weak, nonatomic) IBOutlet UIView *photoView;

@property (nonatomic ,strong)ShopDetailModel *ordermodel;
@property (nonatomic ,strong)NSString *shop_id;
@property (nonatomic ,strong)NSString *order_code;
@property (nonatomic ,strong)NSString *orderPrice;
@property (nonatomic ,strong)NSString *titletext;
@property (nonatomic ,strong)NSArray *refundArray;
@property (nonatomic ,strong)NSArray *statueArray;

@property (nonatomic ,strong)NSString *shop_from;
@property (nonatomic , strong)NSString *Order_status;


@property(nonatomic)NSUInteger status;
@property(nonatomic)float useCoupon;
@property(nonatomic)float useIngral;
@end
