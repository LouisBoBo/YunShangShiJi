//
//  GroupBuysCell.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2016/11/25.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFTableViewBaseCell.h"
#import "TFGroupBuyVM.h"

typedef void (^PushClickedBlock) (TFGroupBuyShop *curModel, NSIndexPath *indexPath);

@interface GroupBuysCell : TFTableViewBaseCell
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) PushClickedBlock block;

- (void)setData:(TFGroupBuyShop *)model;

- (CGFloat)cellHeight;

@end
