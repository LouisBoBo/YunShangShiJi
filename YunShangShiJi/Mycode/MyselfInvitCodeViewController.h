//
//  MyselfInvitCodeViewController.h
//  YunShangShiJi
//
//  Created by hebo on 2019/7/25.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyselfInvitCodeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *codeTitle;
@property (weak, nonatomic) IBOutlet UIImageView *codeWenhao;
@property (weak, nonatomic) IBOutlet UITextView *codeTextview;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UILabel *mycodeLab;
@property (weak, nonatomic) IBOutlet UILabel *mycodeCopy;

@end

NS_ASSUME_NONNULL_END
