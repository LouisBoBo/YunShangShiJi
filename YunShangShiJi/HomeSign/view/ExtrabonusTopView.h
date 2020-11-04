//
//  ExtrabonusTopView.h
//  YunShangShiJi
//
//  Created by ios-1 on 16/9/25.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExtrabonusTopView : UIView

@property(nonatomic,strong)UILabel *BrowseLabel;
@property(nonatomic,strong)UILabel *FunsLabel;
@property(nonatomic,strong)UIButton *RemindBtn;

@property(nonatomic,copy)dispatch_block_t RemindBtnBlock;

- (void)setRemindIsHidden:(BOOL)hidden;//是否隐藏

@end
