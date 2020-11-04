//
//  ThreeCommentCell.m
//  YunShangShiJi
//
//  Created by 云商 on 15/8/11.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "ThreeCommentCell.h"

#import "FullScreenScrollView.h"
@interface ThreeCommentCell ()

@property (nonatomic, strong)TFCommentModel *saveModel;
@property (nonatomic, strong)FullScreenScrollView *imgFullScrollView;

@end

@implementation ThreeCommentCell

- (void)awakeFromNib {
    
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = 35*0.5;
    
    [self.addCommentView sizeToFit];
    
//     Initialization code
    self.addCommentView.layer.masksToBounds = YES;
    self.addCommentView.layer.borderColor = [RGBCOLOR_I(220,220,220) CGColor];
    self.addCommentView.layer.borderWidth = 1;
    self.addCommentView.layer.cornerRadius = 2;
}

- (void)receiveDataModel:(TFCommentModel *)model
{
    self.saveModel = model;

    self.CommentTextLabel.text = model.content;
    self.CommentTextLabel.numberOfLines = 5;
    
    NSString *addCommentStr = [NSString stringWithFormat:@"[追加评论]%@",model.commentModel.content];
    NSMutableAttributedString *maStr = [[NSMutableAttributedString alloc] initWithString:addCommentStr];
    [maStr addAttributes:@{NSForegroundColorAttributeName:COLOR_ROSERED} range:NSMakeRange(0, 6)];
    self.addCommentLabel.attributedText = maStr;
    self.addCommentLabel.numberOfLines = 5;
    
    NSURL *imgUrl;
    if ([model.user_url hasPrefix:@"http"]) {
        imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.user_url]];
    } else {
        imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!382",[NSObject baseURLStr_Upy],model.user_url]];
    }
    
//    MyLog(@"imgUrl = %@",imgUrl);
    
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [self.headImageView sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d = (float)receivedSize/expectedSize;
        isDownlaod = YES;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod == YES) {
            self.headImageView.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                self.headImageView.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        } else if (image != nil && isDownlaod == NO) {
            self.headImageView.image = image;
        }
    }];
    
    NSString *user_name = [MyMD5 replaceUnicode:model.user_name];
    if (user_name.length == 1) {
        user_name = [NSString stringWithFormat:@"%@****", user_name];
    } else if (user_name.length == 2) {
        user_name = [NSString stringWithFormat:@"%@****%@", [user_name substringToIndex:1], [user_name substringFromIndex:1]];
    }
    self.userNameLabel.text = user_name;
    
    [self.startView setScore:[model.star floatValue]];
    
    self.sizeLabel.text = [NSString stringWithFormat:@"尺码:%@",model.shop_size];
    self.colorLabel.text = [NSString stringWithFormat:@"颜色:%@",model.shop_color];
    
    //    //time = %@",model.add_date);
    NSString *timeString = [NSString stringWithFormat:@"%lf",[model.add_date doubleValue]/1000];
    self.addTimeLabel.text = [self timeInfoWithDateString:timeString];
    
    if ([model.comment_type intValue] == 1) {
        self.commentTypeLabel.text = @"好评";
    } else if ([model.comment_type intValue] == 2) {
        self.commentTypeLabel.text = @"中评";
    } else if ([model.comment_type intValue] == 3) {
        self.commentTypeLabel.text = @"差评";
    }
    
    
    if (model.picArr.count == 0) {
        self.photoView_BottomHeight.constant = 0.0f;
        self.photoView_height.constant = 0.0f;
        
    } else {
        self.photoView_BottomHeight.constant = 8.0f;
        self.photoView_height.constant = 40.f;
        //        //picArr = %@",model.picArr);
        NSMutableArray *urlArr = [NSMutableArray array];
        for (int i = 0; i<model.picArr.count; i++) {
            NSString *picUrl = [NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.picArr[i]];
            [urlArr addObject:picUrl];
        }
        
        if (urlArr.count == 1) {
            [self addTapGestureRecognizer:self.commentImageView1 with:1];
            
            [self.commentImageView1 sd_setImageWithURL:[NSURL URLWithString:urlArr[0]]];
        } else if (urlArr.count == 2) {
            [self addTapGestureRecognizer:self.commentImageView1 with:1];
            [self addTapGestureRecognizer:self.commentImageView2 with:1];
            
            [self.commentImageView1 sd_setImageWithURL:[NSURL URLWithString:urlArr[0]]];
            [self.commentImageView2 sd_setImageWithURL:[NSURL URLWithString:urlArr[1]]];
        } else if (urlArr.count == 3) {
            [self addTapGestureRecognizer:self.commentImageView1 with:1];
            [self addTapGestureRecognizer:self.commentImageView2 with:1];
            [self addTapGestureRecognizer:self.commentImageView3 with:1];
            
            [self.commentImageView1 sd_setImageWithURL:[NSURL URLWithString:urlArr[0]]];
            [self.commentImageView2 sd_setImageWithURL:[NSURL URLWithString:urlArr[1]]];
            [self.commentImageView3 sd_setImageWithURL:[NSURL URLWithString:urlArr[2]]];
        }
    }
//    //commentModel.picArr = %@",model.commentModel.picArr);
    if (model.commentModel.picArr.count == 0) {
        self.photoView2_BottomHeight.constant = 0.0f;
        self.photoView2_height.constant = 0.0f;
        
    } else {
        self.photoView2_BottomHeight.constant = 8.0f;
        self.photoView2_height.constant = 40.f;
        NSMutableArray *urlArr = [NSMutableArray array];
        for (int i = 0; i<model.commentModel.picArr.count; i++) {
            NSString *picUrl = [NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.commentModel.picArr[i]];
            [urlArr addObject:picUrl];
        }
        
        if (urlArr.count == 1) {
            [self addTapGestureRecognizer:self.addCommentImageView1 with:2];
            
            [self.addCommentImageView1 sd_setImageWithURL:[NSURL URLWithString:urlArr[0]]];
        } else if (urlArr.count == 2) {
            [self addTapGestureRecognizer:self.addCommentImageView1 with:2];
            [self addTapGestureRecognizer:self.addCommentImageView2 with:2];
            
            [self.addCommentImageView1 sd_setImageWithURL:[NSURL URLWithString:urlArr[0]]];
            [self.addCommentImageView2 sd_setImageWithURL:[NSURL URLWithString:urlArr[1]]];
        } else if (urlArr.count == 3) {
            [self addTapGestureRecognizer:self.addCommentImageView1 with:2];
            [self addTapGestureRecognizer:self.addCommentImageView2 with:2];
            [self addTapGestureRecognizer:self.addCommentImageView3 with:2];
            
            [self.addCommentImageView1 sd_setImageWithURL:[NSURL URLWithString:urlArr[0]]];
            [self.addCommentImageView2 sd_setImageWithURL:[NSURL URLWithString:urlArr[1]]];
            [self.addCommentImageView3 sd_setImageWithURL:[NSURL URLWithString:urlArr[2]]];
        }
    }
}

- (void)addTapGestureRecognizer:(UIImageView *)view with:(int)flag
{
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGR;
    if (flag == 1) {
        tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRClick:)];
    } else if (flag == 2) {
        tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRAddCommentClick:)];
    }
    [view addGestureRecognizer:tapGR];
}

- (void)tapGRClick:(UITapGestureRecognizer *)tapGR
{
    int currIndex = (int)tapGR.view.tag-500+1;
    int count = (int)self.saveModel.picArr.count;
    
    NSMutableArray *imgViewArr = [NSMutableArray array];
    
    for (int i = 0; i<count; i++) {
        if (i == 0) {
            if (self.commentImageView1.image == nil) {
                [imgViewArr addObject:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],self.saveModel.picArr[i]]];
            } else {
                [imgViewArr addObject:self.commentImageView1.image];
            }
        } else if (i == 1) {
            if (self.commentImageView2.image == nil) {
                [imgViewArr addObject:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],self.saveModel.picArr[i]]];
            } else {
                [imgViewArr addObject:self.commentImageView2.image];
            }
        } else if (i == 2) {
            if (self.commentImageView3.image == nil) {
                [imgViewArr addObject:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],self.saveModel.picArr[i]]];
            } else {
                [imgViewArr addObject:self.commentImageView3.image];
            }
        }
        
    }
    UIView *window = [[UIApplication sharedApplication].delegate window];
    
    self.imgFullScrollView = [[FullScreenScrollView alloc] initWithPicutreArray:imgViewArr withCurrentPage:currIndex];
    self.imgFullScrollView.backgroundColor = [UIColor blackColor];
    
    [window addSubview:self.imgFullScrollView];
}

- (void)tapGRAddCommentClick:(UITapGestureRecognizer *)tapGR
{
    int currIndex = (int)tapGR.view.tag-600+1;
    int count = (int)self.saveModel.commentModel.picArr.count; 
    
    NSMutableArray *imgViewArr = [NSMutableArray array];
    
    for (int i = 0; i<count; i++) {
        if (i == 0) {
            if (self.addCommentImageView1.image == nil) {
                [imgViewArr addObject:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],self.saveModel.commentModel.picArr[i]]];
            } else {
                [imgViewArr addObject:self.addCommentImageView1.image];
            }
        } else if (i == 1) {
            if (self.addCommentImageView2.image == nil) {
                [imgViewArr addObject:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],self.saveModel.commentModel.picArr[i]]];
            } else {
                [imgViewArr addObject:self.addCommentImageView2.image];
            }
        } else if (i == 2) {
            if (self.addCommentImageView3.image == nil) {
                [imgViewArr addObject:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],self.saveModel.commentModel.picArr[i]]];
            } else {
                [imgViewArr addObject:self.addCommentImageView3.image];
            }
        }
        
    }
    UIView *window = [[UIApplication sharedApplication].delegate window];
    
    self.imgFullScrollView = [[FullScreenScrollView alloc] initWithPicutreArray:imgViewArr withCurrentPage:currIndex];
    self.imgFullScrollView.backgroundColor = [UIColor blackColor];
    
    [window addSubview:self.imgFullScrollView];
}

- (NSString *)timeInfoWithDateString:(NSString *)timeString
{
    NSDate *oldDate = [NSDate dateWithTimeIntervalSince1970:[timeString longLongValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    NSString *showtimeNew = [formatter stringFromDate:oldDate];
    
    return [NSString stringWithFormat:@"%@",[showtimeNew substringToIndex:11]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
