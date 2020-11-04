//
//  YFAlertView.h
//  YunShangShiJi
//
//  Created by YF on 2017/7/21.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFAlertView : UIView

@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic,copy) void (^btnBlok)(NSInteger index);
@property (nonatomic, strong) dispatch_block_t home_zeroshoppingBlock;
- (void)show;

@end
