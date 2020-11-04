//
//  FightIndianaHeadTableViewCell.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/8/28.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopDetailModel.h"
#import "TreasureGroupsModel.h"
@interface FightIndianaHeadTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIImageView *statueImage;
@property (weak, nonatomic) IBOutlet UILabel *headTitle;
@property (weak, nonatomic) IBOutlet UILabel *detailTitle;
@property (weak, nonatomic) IBOutlet UILabel *shareTitle;
@property (weak, nonatomic) IBOutlet UIButton *weixinBtn;
@property (weak, nonatomic) IBOutlet UIButton *friendBtn;
@property (weak, nonatomic) IBOutlet UILabel *weixinLab;
@property (weak, nonatomic) IBOutlet UILabel *friendLab;
@property (weak, nonatomic) IBOutlet UILabel *bottomTitle;
@property (weak, nonatomic) IBOutlet UILabel *line;

@property (nonatomic , strong) dispatch_block_t weixinBlock;
@property (nonatomic , strong) dispatch_block_t friendBlock;
- (void)refresh:(ShopDetailModel*)model Group:(TreasureGroupsModel*)groupmodel;
@end
