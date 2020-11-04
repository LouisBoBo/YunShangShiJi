//
//  IntimateCircleCell.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2017/2/15.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntimateCircleModel.h"
#import "TFShopModel.h"
#import "SqliteManager.h"

typedef void (^CommentClickedBlock) (IntimateCircleModel *curModel, NSIndexPath *indexPath);
typedef void (^LikeBtnClickedBlock) (IntimateCircleModel *curModel, NSIndexPath *indexPath);
typedef void (^DelCollectionBlock)  (IntimateCircleModel *curModel,
    NSIndexPath *indexPath);
typedef void (^HeedBtnClickedBlock) (IntimateCircleModel *curModel, NSIndexPath *indexPath);
typedef void (^HeaderTitleTapBlock) (IntimateCircleModel *curModel, NSIndexPath *indexPath);
typedef void (^CommentclickBlock) (IntimateCircleModel *curModel, NSIndexPath *indexPath);
typedef void (^ImageClickBlock) (IntimateCircleModel *curModel, NSIndexPath *indexPath);

typedef void (^FollowClickBlock) (TFShopModel *shopModel, NSIndexPath *indexPath);
typedef void (^FollowTagsClickBlock) (ShopTypeItem *item, NSIndexPath *indexPath);

typedef void (^TagClickWithThemeBlock) (ShopTypeItem *item, NSIndexPath *indexPath);
typedef void (^TagClickWithDressStyleBlock) (ShopTagItem *item, NSIndexPath *indexPath );
typedef void (^TagClickWithDressSuppThemeBlock) (TypeTagItem *item, NSIndexPath *indexPath,IntimateCircleModel *curModel);

@interface IntimateCircleCell : UITableViewCell
@property (nonatomic, strong) IntimateCircleModel *model; // 模型
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (strong, nonatomic) UIButton *heedBtn;

@property (nonatomic ,copy) CommentClickedBlock commentClickedBlock;
@property (nonatomic ,copy) LikeBtnClickedBlock likeBtnClickedBlock;
@property (nonatomic ,copy) DelCollectionBlock  del_collectionBlock;
@property (nonatomic ,copy) HeedBtnClickedBlock heedBtnClickedBlock;
@property (nonatomic ,copy) HeaderTitleTapBlock headerTitleTapBlock;
@property (nonatomic ,copy) FollowClickBlock followClickBlock;
@property (nonatomic ,copy) FollowTagsClickBlock followTagClickBlock;
@property (nonatomic ,copy) CommentclickBlock commentclickBlock;
@property (nonatomic ,copy) ImageClickBlock imageclickBlock;
@property (nonatomic ,copy) TagClickWithThemeBlock tagThemeClickBlock;
@property (nonatomic ,copy) TagClickWithDressStyleBlock tagDressWithStyleClickBlock;
@property (nonatomic ,copy) TagClickWithDressSuppThemeBlock tagDressWithSuppClickBlock;
@property (copy, nonatomic) void (^refreshSingleCellBlock)();

- (void)setModel:(IntimateCircleModel *)model indexPath:(NSIndexPath *)indexPath;

+ (CGFloat)cellHeightWithObj:(IntimateCircleModel *)obj;
@end
