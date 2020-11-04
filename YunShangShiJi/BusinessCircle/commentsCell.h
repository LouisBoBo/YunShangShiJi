//
//  commentsCell.h
//  YunShangShiJi
//
//  Created by yssj on 15/10/15.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarsView.h"


@interface commentsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImg;          //头像
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;            //名字
@property (weak, nonatomic) IBOutlet UIButton *goodBtn;             //点赞
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;            //时间
@property (weak, nonatomic) IBOutlet StarsView *starView;    //星星
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;         //内容
@property (weak, nonatomic) IBOutlet UIImageView *contentImgOne;
@property (weak, nonatomic) IBOutlet UIImageView *contenImgTwo;
@property (weak, nonatomic) IBOutlet UIImageView *contentImgThree;

@end
