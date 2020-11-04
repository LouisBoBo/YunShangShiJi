//
//  EvaluateViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/6/4.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopDetailModel.h"
@interface EvaluateViewController : UIViewController<UITextFieldDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIView *footview;
@property (weak, nonatomic) IBOutlet UIButton *commitbtn;
@property (weak, nonatomic) IBOutlet UIImageView *headimage;
@property (weak, nonatomic) IBOutlet UILabel *shopname;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UITextField *comfild;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIButton *addimgbtn;
@property (weak, nonatomic) IBOutlet UIScrollView *Myscrollview;

@property (weak, nonatomic) IBOutlet UILabel *startlable;
@property (nonatomic,strong)UIButton *selectbtn;
@property (nonatomic,strong)NSString *order_shopid;
@property (nonatomic,strong)NSString *suppid;


@property (weak, nonatomic) IBOutlet UILabel *shopcolor_size;
@property (weak, nonatomic) IBOutlet UILabel *shopprice;

//记录评价选中的按钮
@property (nonatomic,strong)UIButton *selectbtn1;
@property (nonatomic,strong)UIButton *selectbtn2;
@property (nonatomic,strong)UIButton *selectbtn3;
@property (nonatomic,strong)UIButton *selectbtn4;

@property (nonatomic,strong)ShopDetailModel *Ordermodel;
@end
