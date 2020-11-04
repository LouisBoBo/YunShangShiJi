//
//  AddTagsViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/4/12.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTagsViewController : UIViewController

@property (nonatomic, copy) dispatch_block_t refreshBlock;
@property (nonatomic, strong) UIImage *tagImage;

@property (nonatomic , strong) UIImageView *tabheadview;        //导航条
@property (nonatomic , strong) UIView *backview;                //底视图
@property (nonatomic , strong) UIButton *nextButtonn;           //下一步

@end
