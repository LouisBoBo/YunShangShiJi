//
//  memberRawardTableViewCell.h
//  YunShangShiJi
//
//  Created by hebo on 2019/7/26.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsRawardModel.h"
#import "rawardsFriendsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface memberRawardTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nickname;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UILabel *rawardLab;
@property (strong, nonatomic) IBOutlet UIButton *shareBtn;
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) dispatch_block_t shareClickBlock;

- (void)refreshData:(rawardsFriendsModel*)model;
@end

NS_ASSUME_NONNULL_END
