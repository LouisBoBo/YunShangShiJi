//
//  TwoCommentCell.h
//  YunShangShiJi
//
//  Created by 云商 on 15/8/11.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFStartScoreView.h"
#import "UIImageView+WebCache.h"
 
#import "TFCommentModel.h"

@interface TwoCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView        *headImageView;
@property (weak, nonatomic) IBOutlet UILabel            *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel            *commentTypeLabel;
@property (weak, nonatomic) IBOutlet TFStartScoreView   *startView;
@property (weak, nonatomic) IBOutlet UILabel            *addTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel            *CommentTextLabel;

@property (weak, nonatomic) IBOutlet UILabel            *colorLabel;
@property (weak, nonatomic) IBOutlet UILabel            *sizeLabel;
@property (weak, nonatomic) IBOutlet UIView             *photoView;

@property (weak, nonatomic) IBOutlet UIImageView        *commentImageView1;
@property (weak, nonatomic) IBOutlet UIImageView        *commentImageView2;
@property (weak, nonatomic) IBOutlet UIImageView        *commentImageView3;

@property (weak, nonatomic) IBOutlet UILabel            *suppCommentLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoView_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoView_BottomHeight;
@property (nonatomic, strong) UILabel *labelline;
- (void)receiveDataModel:(TFCommentModel *)model;

@end
