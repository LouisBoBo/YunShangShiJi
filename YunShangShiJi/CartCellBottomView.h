//
//  CartCellBottomView.h
//  YunShangShiJi
//
//  Created by yssj on 16/6/28.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartCellBottomView : UIView

@property (strong, nonatomic)  UIView *bottomView;
@property (strong, nonatomic)  UILabel *bottomLabel;
@property (strong, nonatomic)  UIButton *bottomBtn;

@property (nonatomic, copy) dispatch_block_t bottomBtnBlock;

@end
