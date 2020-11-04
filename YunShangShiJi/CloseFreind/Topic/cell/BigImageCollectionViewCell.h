//
//  BigImageCollectionViewCell.h
//  TestStickHeader
//
//  Created by ios-1 on 2017/2/15.
//  Copyright © 2017年 liqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntimateCircleModel.h"
#import "TdetailsModel.h"
#import "TShoplistModel.h"
#import "SupperLabelModel.h"
#import "TopicTagsModel.h"
@interface BigImageCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *bigImage;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIButton *gobuy;
@property (strong, nonatomic) IBOutlet UILabel *seprice;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *linelab;
@property (strong, nonatomic) IBOutlet UIImageView *mengceng;

@property (strong, nonatomic) TShoplistModel *model;
@property (strong, nonatomic) TdetailsModel *detailModel;
@property (strong, nonatomic) void(^gotoBuyBlock) (NSString* shopcode);

- (void)refreshData:(TdetailsModel*)model Index:(NSInteger)index;
@end
