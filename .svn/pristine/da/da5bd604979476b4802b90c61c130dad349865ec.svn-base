//
//  TFSalePurchaseFirstViewController.h
//  YunShangShiJi
//
//  Created by 云商 on 15/11/27.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "TFBaseViewController.h"

typedef enum : NSUInteger {
    ChooseBuySingle = 0,
    ChooseBuyPackage,
} ChooseBuy;


@protocol SalePurchasecustomDelegate <NSObject>

- (void)salePurchaseDownRefresh:(int)index;

- (void)tableViewWithScrollViewWillBeginDragging:(UIScrollView *)scrollView index:(int)index;
- (void)tableViewWithScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate index:(int)index;
- (void)tableViewWithScrollViewWillBeginDecelerating:(UIScrollView *)scrollView index:(int)index;
- (void)tableViewWithscrollViewDidEndDecelerating:(UIScrollView *)scrollView index:(int)index;

@end


@interface TFSalePurchaseFirstViewController : TFBaseViewController

/**
 *  哪种套餐
 */
@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, weak) id <SalePurchasecustomDelegate> customDelegate;
@property (nonatomic, assign) CGFloat headHeight;
@property (nonatomic, assign) ChooseBuy myChoose;

@end
