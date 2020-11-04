//
//  LedBrowseCollocationShopCell.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2016/10/9.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CollocationModel;
@interface LedBrowseCollocationShopCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *currIndexPath;

/// 点击跳转
- (void)setShopCodeBlock:(void(^)(NSString *shopCode, NSIndexPath *currIndexPath))block;
/// 更新数据
- (void)receiveDataModel:(CollocationModel *)model;
/// cell高度
+ (CGFloat)cellHeight;

+ (CGFloat)cellForTopicsHeight;

@end
