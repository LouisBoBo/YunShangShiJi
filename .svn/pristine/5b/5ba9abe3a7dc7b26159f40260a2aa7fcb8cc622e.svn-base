//
//  SOContentView.h
//  YunShangShiJi
//
//  Created by zgl on 16/6/2.
//  Copyright © 2016年 ios-1. All rights reserved.
//  晒单分享详情主体内容

#import <UIKit/UIKit.h>
#import "SelCommentModel.h"

@protocol SOContentViewDelegate <NSObject>

/// sender:当前点击按钮 index:1.查看详情 2.点赞 3.留言
- (void)buttonClick:(UIButton *)sender index:(NSInteger)index;
/// 高度将要变化
- (void)contentViewWillChangeHeight;

@end


@interface SOContentView : UIView

@property (nonatomic, weak) id <SOContentViewDelegate> delegate; // 代理

/// 更新数据
- (void)receiveDataModel:(SOCommentModel *)model;
/// 刷新评论数
- (void)setCommentSize:(NSInteger)size;

@end
