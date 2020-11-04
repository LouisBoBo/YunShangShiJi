//
//  IndianPopTableViewCell.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/6/29.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndianaPopModel.h"
#import "YFStepperView.h"
@interface IndianPopTableViewCell : UITableViewCell
@property (nonatomic, strong) YFStepperView *stepperView;        //数量选择
@property (nonatomic, copy) void(^numberBlock)(NSInteger number);//数量

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;


@property (nonatomic , strong) dispatch_block_t cancleBlock;
- (void)refreshData:(IndianaPopModel*)model Max:(NSInteger)maxnumValue;
@end
