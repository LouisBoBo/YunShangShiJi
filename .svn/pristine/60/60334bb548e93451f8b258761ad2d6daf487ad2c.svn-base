//
//  HotTopicCollectionViewCell.h
//  XRWaterfallLayoutDemo
//
//  Created by ios-1 on 2017/4/1.
//  Copyright © 2017年 XR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Relatedrecommended.h"
#import "IntimateCircleModel.h"
#import "TFShopModel.h"

@interface HotTopicCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *bigImage;
@property (strong, nonatomic) IBOutlet UILabel *titlelabel;
@property (strong, nonatomic) IBOutlet UIImageView *headimage;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIButton *like;
@property (strong, nonatomic) IBOutlet UIButton *selectbtn;

@property (copy,nonatomic) dispatch_block_t selectBlock;

@property (copy, nonatomic) void(^likeBlock)(NSInteger likenum);
@property (nonatomic, strong) NSURL *imageURL;

- (void)refreshData:(Relatedrecommended*)model;
- (void)refreshShareData:(BOOL)select;
- (void)refreshCircleData:(IntimateCircleModel*)model;

+ (NSString *)circiImageStr:(IntimateCircleModel *)model;
+ (NSString *)shopImageStr:(TFShopModel *)shopmodel;

@end
