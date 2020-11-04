//
//  WTFAddressView.h
//  YunShangShiJi
//
//  Created by yssj on 16/6/23.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,WTFAddressType) {
    WTFAddressEmpty = 0,
    WTFAddressNormal = 1
};

@interface WTFAddressView : UIView

@property (nonatomic,strong)UILabel  *nameLabel;
@property (nonatomic,strong)UILabel *addressLabel;
@property (nonatomic,strong)UILabel *subLabel;
@property (nonatomic,strong)UIView *line;

@property (nonatomic,copy)dispatch_block_t btnViewBlock;

@property (nonatomic)WTFAddressType type;

-(void)setHiddenTopView:(BOOL)hidden;

@end
