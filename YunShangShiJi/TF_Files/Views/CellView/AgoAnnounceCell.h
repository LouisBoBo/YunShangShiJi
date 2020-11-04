//
//  AgoAnnounceCell.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/5/30.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFTableViewBaseCell.h"
#import "TreasureRecordsModel.h"
@interface AgoAnnounceCell : TFTableViewBaseCell


@property (weak, nonatomic) IBOutlet UILabel *theNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;

@property (weak, nonatomic) IBOutlet UIImageView *shopimgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *personLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *H_theNoLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *H_shopimgV;


@property (nonatomic, strong) TreasureRecordsModel *model;
@property (nonatomic, strong) NSIndexPath *indexPath;

/*******  拼团夺宝  *******/
@property (nonatomic, strong) TreasureRecordsModel *model2;

@end
