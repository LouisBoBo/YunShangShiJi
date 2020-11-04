//
//  CircleTagsCell.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2017/2/22.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CircleTagsCellDidSelectedBlock)(NSInteger item);
@interface CircleTagsCell : UITableViewCell
@property (nonatomic, copy)CircleTagsCellDidSelectedBlock didSelectedBlock;

- (void)setData:(NSArray *)tags;

@end
