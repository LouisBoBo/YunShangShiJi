//
//  PreferredMoreTableViewCell.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/4/23.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreferredMoreTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *Preferredlab;
@property (weak, nonatomic) IBOutlet UILabel *headlab;

- (void)refreshTitle:(NSString*)title;
@end
