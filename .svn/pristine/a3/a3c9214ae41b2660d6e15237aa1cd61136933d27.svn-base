//
//  TwoCommentCell.m
//  YunShangShiJi
//
//  Created by 云商 on 15/8/11.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TwoCommentCell.h"
#import "FullScreenScrollView.h"
@interface TwoCommentCell ()

@property (nonatomic, strong)TFCommentModel *saveModel;
@property (nonatomic, strong)FullScreenScrollView *imgFullScrollView;

@end

@implementation TwoCommentCell

- (void)awakeFromNib {
    // Initialization code
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = 35*0.5;
    
    [self setUI];
}

- (void)setUI {
    [self.contentView addSubview:self.labelline];
}

- (void)layoutSubviews {
    self.labelline.frame = CGRectMake(0, self.frame.size.height-1, kScreenWidth, 1);
}

- (void)receiveDataModel:(TFCommentModel *)model
{
    self.saveModel = model;
//    //type = %d",model.cellType);
    self.CommentTextLabel.text = model.content;
    self.CommentTextLabel.numberOfLines = 5;
    
    NSString *commentStr = [NSString stringWithFormat:@"[卖家回复]%@",model.suppCommentModel.supp_content];
    NSMutableAttributedString *maStr = [[NSMutableAttributedString alloc] initWithString:commentStr];
    [maStr addAttributes:@{NSForegroundColorAttributeName:COLOR_ROSERED} range:NSMakeRange(0, 6)];
    self.suppCommentLabel.attributedText = maStr;
    self.suppCommentLabel.numberOfLines = 5;
    
//    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@!382",[NSObject baseURLStr_Upy],model.user_url]]];
    
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
//            [self addBtn:self.commentImageView1];
            [self addTapGestureRecognizer:self.commentImageView1];
            
            [self.commentImageView1 sd_setImageWithURL:[NSURL URLWithString:urlArr[0]]];
        } else if (urlArr.count == 2) {
            [self addTapGestureRecognizer:self.commentImageView1];
            [self addTapGestureRecognizer:self.commentImageView2];
            
            [self.commentImageView1 sd_setImageWithURL:[NSURL URLWithString:urlArr[0]]];
            [self.commentImageView2 sd_setImageWithURL:[NSURL URLWithString:urlArr[1]]];
        } else if (urlArr.count == 3) {
            [self addTapGestureRecognizer:self.commentImageView1];
            [self addTapGestureRecognizer:self.commentImageView2];
            [self addTapGestureRecognizer:self.commentImageView3];
            
            [self.commentImageView1 sd_setImageWithURL:[NSURL URLWithString:urlArr[0]]];
            [self.commentImageView2 sd_setImageWithURL:[NSURL URLWithString:urlArr[1]]];
            [self.commentImageView3 sd_setImageWithURL:[NSURL URLWithString:urlArr[2]]];
        }
        
    }
}

- (void)addTapGestureRecognizer:(UIImageView *)view
{
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRClick:)];
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

- (UILabel*)labelline
{
    if(_labelline == nil)
    {
        _labelline = [[UILabel alloc]init];
        _labelline.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _labelline;
}
@end
