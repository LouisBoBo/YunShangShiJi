//
//  MemberPayTableViewCell.h
//  YunShangShiJi
//
//  Created by hebo on 2019/2/27.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "vipDataModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MemberPayTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *discriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *cashableLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageLab1Heigh;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageLab2Heigh;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *message1Top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *message2Top;
@property (strong, nonatomic) IBOutlet UILabel *bounsLabel;
@property (strong, nonatomic) IBOutlet UILabel *markLabel;
@property (strong, nonatomic) IBOutlet UIImageView *markImg;
@property (strong, nonatomic) IBOutlet UIImageView *discriptionImg;
@property (strong, nonatomic) IBOutlet UIImageView *wenhaoImg;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *delateHeigh4;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *delateHeigh1;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *delateHeigh2;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *delateHeigh3;

@property(strong, nonatomic) void (^disblock)();
@property(strong, nonatomic) void (^wenhaoblock)();
- (void)refreshData:(NSInteger)selectIndex VipData:(vipDataModel*)model;
@end

NS_ASSUME_NONNULL_END
