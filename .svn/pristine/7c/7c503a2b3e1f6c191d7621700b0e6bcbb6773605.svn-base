//
//  LastGroupRemindView.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/8.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,recommendType){
    recommend_lastgroup = 1,
    reccomend_finish    = 2
};
@interface LastGroupRemindView : UIView

@property (nonatomic , strong) UIView *RemindPopview;
@property (nonatomic , strong) UIView *RemindBackView;
@property (nonatomic , strong) UIButton * canclebtn;
@property (nonatomic , strong) UIImageView *headImageview;
@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) UIButton *nextGroupBtn;
@property (nonatomic , strong) UIButton *myfaviourtBtn;
@property (nonatomic , assign) recommendType recommendtype;

@property (nonatomic , strong) dispatch_block_t dismissBlock;
@property (nonatomic , strong) dispatch_block_t myfaviourtBlock;
@property (nonatomic , strong) dispatch_block_t cancleBlock;

- (instancetype)initWithFrame:(CGRect)frame Type:(recommendType)type;
@end
