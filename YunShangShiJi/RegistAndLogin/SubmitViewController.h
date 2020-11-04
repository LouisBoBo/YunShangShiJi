//
//  SubmitViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/11.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SubmitViewController;

@protocol SubmitViewControllerDelegate <NSObject>

- (void)submitSuccess:(SubmitViewController *)submitController;
- (void)submitFailure:(SubmitViewController *)submitController;

@end


@class SubmitBackgroundView;


@interface SubmitViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSArray *array;
@property (nonatomic, strong)NSArray *nameArray;
@property (nonatomic, strong)SubmitBackgroundView *submitBackgroundView;
@property (nonatomic, weak)id <SubmitViewControllerDelegate>delegate;
//是开店选择标签还是新手任务选择标签
@property (nonatomic ,strong)NSString *typestring;
@end
