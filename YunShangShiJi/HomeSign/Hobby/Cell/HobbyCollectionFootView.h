//
//  HobbyCollectionFootView.h
//  YunShangShiJi
//
//  Created by ios-1 on 2016/12/27.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardTool.h"

@interface HobbyCollectionFootView : UICollectionReusableView<UITextFieldDelegate,KeyboardToolDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titlelab;
@property (weak, nonatomic) IBOutlet UILabel *height;
@property (weak, nonatomic) IBOutlet UILabel *weight;
@property (weak, nonatomic) IBOutlet UIView *heightinput;
@property (weak, nonatomic) IBOutlet UIView *weightinput;
@property (weak, nonatomic) IBOutlet UIButton *canclebtn;
@property (weak, nonatomic) IBOutlet UIButton *okbtn;
@property (weak, nonatomic) IBOutlet UITextField *heightTextFild;
@property (weak, nonatomic) IBOutlet UITextField *weightTextFild;

@property (nonatomic , strong) void (^cancleBlock)();
@property (nonatomic , strong) void (^okBlock)();
- (void)refreshData;
@end

