//
//  IndianaCell.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/6/2.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndianaModel.h"

#define kCellIdentifier_Indiana @"IndianaCell"

typedef void (^CommentClickedBlock) (IndianaModel *curModel, NSIndexPath *indexPath);
typedef void (^LikeBtnClickedBlock) (IndianaModel *curModel, NSIndexPath *indexPath);
typedef void (^UserBtnClickedBlock) ();
@interface IndianaCell : UITableViewCell

@property (nonatomic, strong) IndianaModel *model; // 模型
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic ,copy) CommentClickedBlock commentClickedBlock;
@property (nonatomic ,copy) LikeBtnClickedBlock likeBtnClickedBlock;
@property (nonatomic, copy) void (^moreButtonClickedBlock)(NSIndexPath *indexPath);
@property (copy, nonatomic) void (^refreshSingleCellBlock)();
@property (nonatomic, copy) UserBtnClickedBlock userBtnClickedBlock;

+ (CGFloat)cellHeightWithObj:(IndianaModel *)obj;

@end
