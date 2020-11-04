//
//  SlideRemindView.h
//  YunShangShiJi
//
//  Created by ios-1 on 16/8/24.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideRemindView : UIView
@property (nonatomic , strong) UIView *SlidePopview;
@property (nonatomic , strong) UIView *SlideBackView;
@property (nonatomic , strong) NSString *slidetype;
@property (nonatomic , strong) dispatch_block_t disapperBlock;
@property (nonatomic , strong) dispatch_block_t tapHideMindBlock;
- (instancetype)initWithFrame:(CGRect)frame Type:(NSString*)slidetype;

//弹框消失
- (void)remindViewHiden;
@end
