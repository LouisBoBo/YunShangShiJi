//
//  TFDailyTaskView.h
//  YunShangShiJi
//
//  Created by 云商 on 15/12/9.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^clickBlock)(NSInteger type);
typedef void(^closeBlock)(NSInteger type);

@interface TFDailyTaskView : UIView

@property (nonatomic, copy)clickBlock myBlock;
@property (nonatomic, copy)closeBlock closeBlock;
- (instancetype)init;

- (void)showWithType:(NSString *)type;
- (void)dismissAlert;

- (void)returnClick:(clickBlock)myBlock withCloseBlock:(closeBlock)closeBlock;

@end
