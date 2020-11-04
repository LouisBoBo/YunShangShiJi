//
//  TagImageCollectionViewCell.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/4/14.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TdetailsModel.h"
#import "ZYTagImageView.h"
#import "SupperLabelModel.h"
#import "TopicTagsModel.h"
@interface TagImageCollectionViewCell : UICollectionViewCell<ZYTagImageViewDelegate>
@property (strong, nonatomic) TdetailsModel *detailModel;          //标签数据
@property (nonatomic , strong) ZYTagImageView *tagImageView;       //标签大图

@property (nonatomic , strong) void(^tagsBlock)(NSString *ID ,NSString *title,NSInteger labeltype ,NSString *shop_code);       //标签
- (void)refreshData:(TdetailsModel*)model;
@end
