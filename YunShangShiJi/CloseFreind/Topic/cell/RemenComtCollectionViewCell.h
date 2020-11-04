//
//  RemenComtCollectionViewCell.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/15.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RemenComtCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *line;
@property (strong, nonatomic) IBOutlet UILabel *title;

- (void)refreshTitle:(NSString*)title;
@end
