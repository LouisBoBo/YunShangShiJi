//
//  ImageCollectionViewCell.h
//  FJWaterfallFlow
//
//  Created by ios-1 on 2016/12/26.
//  Copyright © 2016年 fujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HobbyModel.h"
#import "ShopShareModel.h"
@interface ImageCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *selectmark;
@property (weak, nonatomic) IBOutlet UIImageView *selectimage;

@property (strong, nonatomic) void (^clickBlock)();
- (void)setCellData:(HobbyModel *)dataModel;
- (void)setPhotoData:(ShopShareModel *)dataModel;
@end
