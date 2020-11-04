//
//  SubmitTopicViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/6/12.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubmitTopicViewController : UIViewController<UIActionSheetDelegate,UITextViewDelegate>

@property (strong, nonatomic)NSString *circle_id;
//查找到的标签列表数据
@property (strong, nonatomic)NSMutableArray *allIdArray;

@property (strong, nonatomic) UIView *PopView;

- (IBAction)popoverBtnClicked:(id)sender forEvent:(UIEvent *)event;

@property (weak, nonatomic) IBOutlet UITextView *titlteView;
@property (weak, nonatomic) IBOutlet UIButton *submitView;
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UIScrollView *Myscrollview;
@property (weak, nonatomic) IBOutlet UIButton *addimage;
@property (weak, nonatomic) IBOutlet UILabel *taglable;

@property (weak, nonatomic) IBOutlet UIView *tagView;
@property (weak, nonatomic) IBOutlet UITextView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *line1;
@property (weak, nonatomic) IBOutlet UILabel *line2;
@property (weak, nonatomic) IBOutlet UILabel *line3;
@property (weak, nonatomic) IBOutlet UILabel *titlelable;
@property (weak, nonatomic) IBOutlet UILabel *contentlable;


@property (nonatomic,assign)id delegate;

@end


@protocol submitDelegate <NSObject>

-(void)submitRefreshInfo;

@end