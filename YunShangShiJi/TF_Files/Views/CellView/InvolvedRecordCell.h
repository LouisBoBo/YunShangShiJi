//
//  InvolvedRecordCell.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/5/30.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFTableViewBaseCell.h"
#import "TreasureRecordsModel.h"

typedef NS_ENUM(NSInteger , CellType)
{
    CellType1 = 0, //yes
    CellType2,     //ing
    CellType3,     //not
    CellType4      //inv
};


@interface InvolvedRecordCell : TFTableViewBaseCell

@property (weak, nonatomic) IBOutlet UILabel *theNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;

@property (weak, nonatomic) IBOutlet UIImageView *shopimgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *personLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusImgV;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIView *statusView;
@property (weak, nonatomic) IBOutlet UILabel *winPersonLabel;
@property (weak, nonatomic) IBOutlet UILabel *winNumberLabel;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *H_statusView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *H_shopimgV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *H_theNoLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *W_statusL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *H_statusL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *S_titleL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *S_personL;

@property (nonatomic, assign) CellType type;

@property (nonatomic, strong) TreasureRecordsModel *model;
@property (nonatomic, strong) NSIndexPath *indexPath;

/****  拼团夺宝  *****/
@property (nonatomic, strong) TreasureRecordsModel *model2;
@property (nonatomic, assign) CellType type2;

@end

