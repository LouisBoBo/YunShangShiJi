//
//  TFIndianaRecordSubViewController.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/5/28.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFBaseViewController.h"

typedef NS_ENUM(NSInteger, SelectType)
{
    SelectTypeMy = 1 << 0,
    SelectTypeMy_TreasureGroup = 1 << 1,
    SelectTypeOthers = 1 << 2,
    SelectTypeOthers_TreasureGrop = 1 << 3,
};
@interface TFIndianaRecordSubViewController : TFBaseViewController

@property (nonatomic, assign) SelectType selectIndex;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIScrollView *backgroundScrollView;
@property (nonatomic, strong) NSArray *titleArray;

@end
