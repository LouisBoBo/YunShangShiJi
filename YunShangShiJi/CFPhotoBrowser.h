//
//  CFPhotoBrowser.h
//  YunShangShiJi
//
//  Created by yssj on 2017/3/17.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJPhoto.h"


@protocol MJPhotoBrowserDelegate;
typedef void(^FootBtnClick)(NSInteger);

@interface CFPhotoBrowser : NSObject <UIScrollViewDelegate>
// 所有的图片对象
@property (nonatomic, strong) NSArray *photos;
// 当前展示的图片索引
@property (nonatomic, assign) NSUInteger currentPhotoIndex;
// 保存按钮
@property (nonatomic, assign) NSUInteger showSaveBtn;

@property (nonatomic, strong) NSArray *modelArray;

@property (nonatomic, copy)dispatch_block_t dismissBlock;
@property (nonatomic,copy) FootBtnClick footBtnClick;

// 显示
- (void)show;
- (void)show:(UIView *)view;

@end
