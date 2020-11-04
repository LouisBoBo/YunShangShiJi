//
//  MessageCenterVC.h
//  YunShangShiJi
//
//  Created by yssj on 2017/2/22.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "AXStretchableHeaderTabViewController.h"

typedef enum : NSUInteger {
    MessageCenterFromPersonCenter,
    MessageCenterFromTabbar,
} MessageCenterType;

@interface MessageCenterVC : AXStretchableHeaderTabViewController

- (instancetype)initWithType:(MessageCenterType)type;

@property (nonatomic,assign)MessageCenterType type;
@end
