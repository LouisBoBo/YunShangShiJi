//
//  LabelCollectionViewCell.h
//  FJWaterfallFlow
//
//  Created by ios-1 on 2016/12/26.
//  Copyright © 2016年 fujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HobbyModel.h"

@interface LabelCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectbtn;

@property (strong, nonatomic) void (^clickBlock)();
- (void)setCellData:(HobbyModel *)dataModel;
@end
