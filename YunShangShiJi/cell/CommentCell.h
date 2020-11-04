//
//  CommentCell.h
//  YunShangShiJi
//
//  Created by yssj on 15/8/5.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol clickHeadimageDelegate <NSObject>

-(void)clickHeadimage:(NSInteger)index;

@end

@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UIButton *ImgBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rowLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (weak, nonatomic) IBOutlet UILabel *line;

@property (nonatomic ,strong)id<clickHeadimageDelegate>delegate;
@end
