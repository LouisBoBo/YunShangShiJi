//
//  MemberPayRuleTableViewCell.h
//  YunShangShiJi
//
//  Created by hebo on 2020/7/30.
//  Copyright © 2020 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "vipDataModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MemberPayRuleTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *ruleTitle;
@property (strong, nonatomic) IBOutlet UIImageView *ruleImage;
@property (strong, nonatomic) IBOutlet UILabel *marklabel1;
@property (strong, nonatomic) IBOutlet UILabel *marklabel2;
@property (strong, nonatomic) IBOutlet UILabel *marklabel3;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *markviewHeigh;
- (void)refreshData:(vipDataModel*)ruleModel Price:(NSString*)price Count:(NSString*)count;
@end

NS_ASSUME_NONNULL_END
