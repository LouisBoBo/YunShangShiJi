//
//  RefunddetailViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/6/24.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefunddetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *refundtitle;
@property (weak, nonatomic) IBOutlet UIScrollView *Myscrollview;
@property (weak, nonatomic) IBOutlet UILabel *selletID;
@property (weak, nonatomic) IBOutlet UILabel *sellerName;
@property (weak, nonatomic) IBOutlet UILabel *refundtype;
@property (weak, nonatomic) IBOutlet UILabel *refundstatue;
@property (weak, nonatomic) IBOutlet UILabel *refundprice;
@property (weak, nonatomic) IBOutlet UILabel *other;
@property (weak, nonatomic) IBOutlet UILabel *refunddiscription;
@property (weak, nonatomic) IBOutlet UILabel *refundcoke;
@property (weak, nonatomic) IBOutlet UILabel *refundtime;

@end
