//
//  TFTableViewService.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/8.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSInteger(^NumberOfRowsInSectionBlock)(UITableView *tableView, NSInteger section);
typedef UITableViewCell *(^CellForRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
typedef CGFloat(^HeightForRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
typedef void(^DidSelectRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
@interface TFTableViewService : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIViewController *currViewController;

@property (nonatomic, copy) NumberOfRowsInSectionBlock numberOfRowsInSectionBlock;
@property (nonatomic, copy) CellForRowAtIndexPathBlock cellForRowAtIndexPathBlock;
@property (nonatomic, copy) HeightForRowAtIndexPathBlock heightForRowAtIndexPathBlock;
@property (nonatomic, copy) DidSelectRowAtIndexPathBlock didSelectRowAtIndexPathBlock;
- (void)numberOfRowsInSectionBlock:(NumberOfRowsInSectionBlock)numberOfRowsInSectionBlock;
- (void)cellForRowAtIndexPathBlock:(CellForRowAtIndexPathBlock)cellForRowAtIndexPathBlock;
- (void)heightForRowAtIndexPathBlock:(HeightForRowAtIndexPathBlock)heightForRowAtIndexPathBlock;
- (void)didSelectRowAtIndexPathBlock:(DidSelectRowAtIndexPathBlock)didSelectRowAtIndexPathBlock;


@end
