//
//  YFDPCell.h
//  YunShangShiJi
//
//  Created by zgl on 16/6/16.
//  Copyright © 2016年 ios-1. All rights reserved.
//  搭配Cell

#import <UIKit/UIKit.h>

@class CollocationModel;

@interface YFDPCell : UITableViewCell

/// 点击跳转
- (void)setShopCodeBlock:(void(^)(NSString *shopCode))block;
/// 更新数据
- (void)receiveDataModel:(CollocationModel *)model ISCollocation:(BOOL)iscollocation;
/// cell高度
+ (CGFloat)cellHeight;

+ (CGFloat)cellForTopicsHeight;

@property (nonatomic , assign) BOOL iscollocation;
@end
