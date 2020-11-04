//
//  YFDPAddShopCell.h
//  YunShangShiJi
//
//  Created by zgl on 16/6/18.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DPShopModel;

@interface YFDPAddShopCell : UITableViewCell

@property (nonatomic, copy) void(^colorSizeBlock)(NSInteger cidx, NSInteger sidx);//颜色与尺码选择（cidx：颜色，sidx：尺码）
@property (nonatomic, copy) void(^selectBlock)(BOOL select);//是否选中
@property (nonatomic, copy) void(^numberBlock)(NSInteger number);//数量

/// 更新数据
- (void)receiveDataModel:(DPShopModel *)model;
///cell高度
+ (CGFloat)cellHeightWithModel:(DPShopModel *)model;

@end
