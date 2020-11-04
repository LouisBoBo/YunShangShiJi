//
//  TFCircleSubViewController.h
//  YunShangShiJi
//
//  Created by 云商 on 15/11/18.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "TFBaseViewController.h"

typedef enum : NSUInteger {
    CIRCLE_STATUS_MY = 1,
    CIRCLE_STATUS_RECOMMEND = 2,
    CIRCLE_STATUS_ALL = 3,
} CIRCLE_STATUS;


@protocol TFCircleSubViewControllerDelegate <NSObject>

- (void)smileViewSelect:(CIRCLE_STATUS)status;

@end

@interface TFCircleSubViewController : TFBaseViewController

@property (nonatomic, assign) int                               currPage;
@property (nonatomic, strong) UITableView                       *tableView;
@property (nonatomic, strong) NSMutableArray                    *dataArr;
@property (nonatomic, assign) CIRCLE_STATUS                     CURR_STATUS;

@property (nonatomic, weak  ) id <TFCircleSubViewControllerDelegate> delegate;


- (void)httpGetData;


@end
