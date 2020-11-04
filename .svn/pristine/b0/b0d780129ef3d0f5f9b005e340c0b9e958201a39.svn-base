//
//  MyorderTableViewCell.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/21.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopDetailModel.h"
@protocol changeTitleDelegate <NSObject>

-(void)changeTitle:(NSInteger)index ;
-(void)changeTitle2:(NSInteger)index ;
-(void)changeTitle3:(NSInteger)index ;
@end

@interface MyorderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *linelable;

@property (weak, nonatomic) IBOutlet UILabel *storestatue;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *storetitle;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *payprice;
@property (weak, nonatomic) IBOutlet UILabel *buynumber;
@property (weak, nonatomic) IBOutlet UIButton *statuebtn;
@property (weak, nonatomic) IBOutlet UIButton *statuebtn2;
@property (weak, nonatomic) IBOutlet UIButton *statuebtn3;
@property (weak, nonatomic) IBOutlet UILabel *color_size;

@property(nonatomic,assign)NSInteger row;
@property(nonatomic,weak)id<changeTitleDelegate>delegate;

-(void)refreshData:(ShopDetailModel*)model;
-(void)refreshData1:(ShopDetailModel*)model;
-(void)refreshData2:(ShopDetailModel*)model;
@end
