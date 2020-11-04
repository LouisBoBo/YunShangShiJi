//
//  OrderDetailTableViewCell.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/28.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"
@protocol AfterslaeDelegate <NSObject>

-(void)Addcircle:(NSInteger)index;

@end


@interface OrderDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *shopdescription;
@property (weak, nonatomic) IBOutlet UILabel *clorOrsize;
@property (weak, nonatomic) IBOutlet UILabel *shopprice;
@property (weak, nonatomic) IBOutlet UILabel *shopnumber;
@property (weak, nonatomic) IBOutlet UIImageView *headimage;
@property (weak, nonatomic) IBOutlet UIButton *clickbtn;

@property(nonatomic,assign)NSInteger row;
@property (nonatomic ,strong)id<AfterslaeDelegate>delegate;
-(void)refreshData:(OrderDetailModel*)model;
-(void)refreshData1:(OrderDetailModel*)model;

@end
