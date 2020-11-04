//
//  YDTableViewController.h
//  YunShangShiJi
//
//  Created by yssj on 2016/12/14.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXStretchableHeaderTabViewController.h"

@interface YDTableViewController : UIViewController<AXStretchableSubViewControllerViewSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,assign)YDPageVCType type;

- (void)reloadData:(NSInteger)index;

@end
