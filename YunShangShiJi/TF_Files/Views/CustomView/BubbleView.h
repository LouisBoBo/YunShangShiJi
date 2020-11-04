//
//  BubbleView.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2017/1/7.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BubbleView : UIView
- (void)getData;
- (void)startScroll;

@property (nonatomic , strong) NSMutableArray *falseData;
@end
