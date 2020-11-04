//
//  IndianaCell.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/6/2.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "IndianaCell.h"
#import "UICustomCollectionView.h"
#import "UITapImageView.h"
#import "GlobalTool.h"
#import "UIView+Frame.h"
#import "IndianaMediaItemCell.h"
#import "IndianaMediaItemSingleCell.h"
#import "MJPhotoBrowser.h"
#define kPaddingLeftWidth ZOOM6(30)
#define kPaddingRightWidth ZOOM6(30)
#define kPaddingTopHeight ZOOM6(30)

#define KUserInfoHeight ZOOM6(75)
#define KMoreBtnHeight ZOOM6(50)
#define KLikeBtnHeight ZOOM6(60)
#define KBottomViewHeight 10


#define KContent_Width (kScreen_Width-kPaddingLeftWidth-kPaddingRightWidth)

#define contentFont kFont6px(28)
#define nameFont [UIFont boldSystemFontOfSize:ZOOM6(30)]

#define kMargin_imgVBottom 10
#define kMargin_contentBottom 5
#define kMargin_moreBtnBottom 0
#define kMargin_mediaVBottom 10
#define kMargin_horVBottom 5
#define kMargin_likeBtnVBottom 5

CGFloat maxContentLabelHeight = 0; // 根据具体font而定

@interface IndianaCell () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>


@property (strong, nonatomic) UITapImageView *ownerImgView; // 头像
@property (nonatomic, strong) UILabel *ownerNameLab;        // 昵称
@property (strong, nonatomic) UIButton *ownerStatusBtn;     // 会员
@property (strong, nonatomic) UILabel *contentLabel, *timeLabel; // 内容/时间
@property (strong, nonatomic) UIButton *moreButton, *likeBtn, *commentBtn, *topLikeBtn;                                         // 显示全部/喜欢/评论
@property (strong, nonatomic) UICustomCollectionView *mediaView; // 图片
@property (strong, nonatomic) UIView *horLineView, *verLineView, *bottomView; // 横线

@end

@implementation IndianaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        if (!self.ownerImgView) {
            self.ownerImgView = [[UITapImageView alloc] initWithFrame:CGRectMake(kPaddingLeftWidth, kPaddingTopHeight, KUserInfoHeight, KUserInfoHeight)];
            
            self.ownerImgView.layer.masksToBounds = YES;
            self.ownerImgView.layer.cornerRadius = self.ownerImgView.frame.size.width/2;
            [self.contentView addSubview:self.ownerImgView];
            
        }
        
        if (!self.ownerNameLab) {
            self.ownerNameLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.ownerImgView.frame)+10, CGRectGetMinY(self.ownerImgView.frame), ZOOM6(200), CGRectGetHeight(self.ownerImgView.frame))];
            self.ownerNameLab.font = nameFont;
            self.ownerNameLab.text = @"";
            [self.contentView addSubview:self.ownerNameLab];
        
        }
        
        if (!self.ownerStatusBtn) {
            self.ownerStatusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.ownerStatusBtn.frame = CGRectMake(CGRectGetMaxX(self.ownerNameLab.frame)+10, CGRectGetMinY(self.ownerImgView.frame), ZOOM6(150), CGRectGetHeight(self.ownerImgView.frame));
            self.ownerStatusBtn.titleLabel.font = kFont6px(24);
            [self.ownerStatusBtn setImage:[UIImage imageNamed:@"duobao_icon_huiyuan"] forState:UIControlStateNormal];
            [self.ownerStatusBtn setImage:[UIImage imageNamed:@"duobao_icon_huiyuan"] forState:UIControlStateSelected];
            [self.ownerStatusBtn setImage:[UIImage imageNamed:@"duobao_icon_huiyuan"] forState:UIControlStateHighlighted];
            [self.ownerStatusBtn setTitle:@"至尊会员" forState:UIControlStateNormal];
            [self.ownerStatusBtn setTitleColor:COLOR_ROSERED forState:UIControlStateNormal];
            [self.contentView addSubview:self.ownerStatusBtn];
            
            [self.ownerStatusBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
            
            self.ownerStatusBtn.hidden = YES;
            
        }
        
        if (!self.timeLabel) {
            self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width-kPaddingRightWidth-ZOOM6(260), CGRectGetMinY(self.ownerImgView.frame), ZOOM6(260), CGRectGetHeight(self.ownerImgView.frame))];
            self.timeLabel.center=CGPointMake(self.frame.size.width/2, self.timeLabel.centerY);
            self.timeLabel.font = kFont6px(24);
            self.timeLabel.textColor = [UIColor colorWithRed:168/255.0 green:168/255.0 blue:168/255.0 alpha:1];
            self.timeLabel.text = @"";
            self.timeLabel.textAlignment = NSTextAlignmentRight;
            [self.contentView addSubview:self.timeLabel];
            
        }
        if (!self.topLikeBtn) {
            self.topLikeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.topLikeBtn.frame = CGRectMake(kScreen_Width/2-kPaddingRightWidth, CGRectGetMinY(self.ownerImgView.frame), KContent_Width*0.5-2, KLikeBtnHeight);
//            self.topLikeBtn.centerY=self.timeLabel.centerY;
            [self.topLikeBtn addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.topLikeBtn setTitleColor:RGBCOLOR_I(62,62,62) forState:UIControlStateNormal];
            self.topLikeBtn.titleLabel.font = kFont6px(24);

            [self.contentView addSubview:self.topLikeBtn];

            [self.topLikeBtn setImage:[UIImage imageNamed:@"duobao_icon_dianzan"] forState:UIControlStateNormal];
            [self.topLikeBtn setImage:[UIImage imageNamed:@"duobao_icon_dianzan"] forState:UIControlStateSelected];
            [self.topLikeBtn setImage:[UIImage imageNamed:@"duobao_icon_dianzan"] forState:UIControlStateHighlighted];
            [self.topLikeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];

//            [self.topLikeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
            [self.topLikeBtn setTitleEdgeInsets:UIEdgeInsetsMake(5, 5, 0, -5)];

        }

        if (!self.contentLabel) {
            self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPaddingLeftWidth, CGRectGetMaxY(self.ownerImgView.frame)+kMargin_imgVBottom, KContent_Width, ZOOM6(100))];
            self.contentLabel.font = contentFont;
            self.contentLabel.textColor = RGBCOLOR_I(22,22,22);
            self.contentLabel.text = @"";
            self.contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            self.contentLabel.numberOfLines = 0;
            
            [self.contentView addSubview:self.contentLabel];
            
            if (maxContentLabelHeight == 0) {
                maxContentLabelHeight = self.contentLabel.font.lineHeight * 3;
            }
            
//            self.contentLabel.backgroundColor = [UIColor orangeColor];
        }
        
        if (!self.moreButton) {
            self.moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.moreButton.frame = CGRectMake(kPaddingLeftWidth, CGRectGetMaxY(self.contentLabel.frame)+kMargin_contentBottom, ZOOM6(150), KMoreBtnHeight);
            [self.moreButton addTarget:self action:@selector(moreButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:self.moreButton];
            [self.moreButton setTitle:@"显示全部" forState:UIControlStateNormal];
            self.moreButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            self.moreButton.titleLabel.font = kFont6px(24);
            [self.moreButton setTitleColor:COLOR_ROSERED forState:UIControlStateNormal];
            
//            self.moreButton.backgroundColor = [UIColor yellowColor];
            
        }
        
        if (!self.mediaView) {
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            self.mediaView = [[UICustomCollectionView alloc] initWithFrame:CGRectMake(kPaddingLeftWidth, CGRectGetMaxY(self.moreButton.frame)+kMargin_moreBtnBottom, KContent_Width, 80) collectionViewLayout:layout];
            self.mediaView.scrollEnabled = NO;
            [self.mediaView setBackgroundView:nil];
            [self.mediaView setBackgroundColor:[UIColor clearColor]];
            
            [self.mediaView registerClass:[IndianaMediaItemCell class] forCellWithReuseIdentifier:kCellIdentifier_IndianaMediaItem];
            [self.mediaView registerClass:[IndianaMediaItemSingleCell class] forCellWithReuseIdentifier:kCellIdentifier_IndianaMediaItemSingle];
            
            self.mediaView.dataSource = self;
            self.mediaView.delegate = self;
            
            [self.contentView addSubview:self.mediaView];
            
        }
        /*
        if (!self.horLineView) {
            self.horLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.mediaView.frame)+kMargin_mediaVBottom, kScreenWidth, 1)];
            self.horLineView.backgroundColor = RGBCOLOR_I(229, 229, 299);
            [self.contentView addSubview:self.horLineView];
        }
        
        
        if (!self.likeBtn) {
            self.likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.likeBtn.frame = CGRectMake(kPaddingLeftWidth, CGRectGetMaxY(self.horLineView.frame)+kMargin_horVBottom, KContent_Width*0.5-2, KLikeBtnHeight);
            [self.likeBtn addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.likeBtn setTitleColor:RGBCOLOR_I(62,62,62) forState:UIControlStateNormal];
            self.likeBtn.titleLabel.font = kFont6px(24);
            
            [self.contentView addSubview:self.likeBtn];
            
            [self.likeBtn setImage:[UIImage imageNamed:@"duobao_icon_dianzan"] forState:UIControlStateNormal];
            [self.likeBtn setImage:[UIImage imageNamed:@"duobao_icon_dianzan"] forState:UIControlStateSelected];
            [self.likeBtn setImage:[UIImage imageNamed:@"duobao_icon_dianzan"] forState:UIControlStateHighlighted];
            [self.likeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
            
//            self.likeBtn.backgroundColor = [UIColor greenColor];
        }
        
        if (!self.commentBtn) {
            self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.commentBtn.frame = CGRectMake( kScreen_Width-kPaddingRightWidth-KContent_Width*0.5-1, CGRectGetMaxY(self.horLineView.frame)+kMargin_horVBottom, KContent_Width*0.5-1, KLikeBtnHeight);
            [self.commentBtn setTitleColor:RGBCOLOR_I(62,62,62) forState:UIControlStateNormal];
            self.commentBtn.titleLabel.font = kFont6px(24);
            [self.commentBtn addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.commentBtn setImage:[UIImage imageNamed:@"duobao_icon_pinlun"] forState:UIControlStateNormal];
            [self.commentBtn setImage:[UIImage imageNamed:@"duobao_icon_pinlun"] forState:UIControlStateSelected];
            [self.commentBtn setImage:[UIImage imageNamed:@"duobao_icon_pinlun"] forState:UIControlStateHighlighted];
            
            [self.contentView addSubview:self.commentBtn];
            [self.commentBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
            
        }
        
        if (!self.verLineView) {
            self.verLineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.likeBtn.frame)+1, CGRectGetMinY(self.likeBtn.frame), 1, CGRectGetHeight(self.likeBtn.frame))];
            self.verLineView.backgroundColor = RGBCOLOR_I(229, 229, 299);
            [self.contentView addSubview:self.verLineView];
        }
    
        if (!self.bottomView) {
            self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.likeBtn.frame)+kMargin_likeBtnVBottom, kScreen_Width, KBottomViewHeight)];
            self.bottomView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
            [self.contentView addSubview:self.bottomView];
        }
        */
    }
    return self;
}

- (void)setModel:(IndianaModel *)model
{
//    MyLog(@"model: %@", model);
    
    _model = model;
    if (!_model) {
        return;
    }
    
    CGFloat curBottomY = kPaddingTopHeight + CGRectGetHeight(self.ownerImgView.frame)+ kMargin_imgVBottom;
    
    NSURL *imgUrl;
    if ([model.user_url hasPrefix:@"http"]) {
        imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.user_url]];
    } else {
        imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!382",[NSObject baseURLStr_Upy],model.user_url]];
    }
    __weak __typeof(self)weakSelf = self;
    [self.ownerImgView setImageWithUrl:imgUrl placeholderImage:nil tapBlock:^(id obj) {
        [weakSelf userBtnClicked];
    }];
    
    self.ownerNameLab.text = model.user_name;
    
    if ([model.isMember boolValue]) {
//        self.ownerStatusBtn.hidden = NO;
        self.ownerStatusBtn.hidden = YES;
    } else {
        self.ownerStatusBtn.hidden = YES;
    }
    
    self.timeLabel.text = [NSString getTimeStyle:TimeStrStyleArticle time:[model.add_date longLongValue]/1000];
    
    [self.contentLabel setY:curBottomY];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.text = model.content;
    
    CGFloat contentHeight = 0;
    if (model.shouldShowMoreButton) {
        self.moreButton.hidden = NO;
        if (model.isOpening) {
            contentHeight = [IndianaCell contentLabelHeightWithIndiana:model];
            [self.moreButton setTitle:@"收起" forState:UIControlStateNormal];
        } else {
            contentHeight = maxContentLabelHeight;
            [self.moreButton setTitle:@"显示全部" forState:UIControlStateNormal];
        }
        
        [self.contentLabel setHeight:contentHeight];
        [self.moreButton setY: CGRectGetMaxY(self.contentLabel.frame)+kMargin_contentBottom];
        [self.moreButton setHeight:KMoreBtnHeight];
        
        self.moreButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        
    } else {
        
        contentHeight = [IndianaCell contentLabelHeightWithIndiana:model];
        
        [self.contentLabel setHeight:contentHeight];
        [self.moreButton setHeight:0];
        self.moreButton.hidden = YES;
    }
    
    curBottomY += contentHeight+ kMargin_contentBottom + CGRectGetHeight(self.moreButton.frame) + (CGRectGetHeight(self.moreButton.frame) == 0? 0: kMargin_moreBtnBottom);
    
    [self.mediaView setY:curBottomY];
    
    CGFloat mediaHeight = 0;
    if (model.srcArray.count > 0) {
        mediaHeight = [IndianaCell contentMediaHeightWithIndiana:model];
        
        [self.mediaView setFrame:CGRectMake(kPaddingLeftWidth, curBottomY, KContent_Width, mediaHeight)];
        self.mediaView.hidden = NO;
        [self.mediaView reloadData];
    } else {
        if (self.mediaView) {
            self.mediaView.hidden = YES;
        }
    }

    [self.topLikeBtn setTitle:[NSString stringWithFormat:@"%ld", [model.click_size longValue]] forState:UIControlStateNormal];

    if (model.isClick) {
        [self.topLikeBtn setImage:[UIImage imageNamed:@"duobao_icon_dianzan_press"] forState:UIControlStateNormal];
        [self.topLikeBtn setImage:[UIImage imageNamed:@"duobao_icon_dianzan_press"] forState:UIControlStateSelected];
        [self.topLikeBtn setImage:[UIImage imageNamed:@"duobao_icon_dianzan_press"] forState:UIControlStateHighlighted];
    } else {
        [self.topLikeBtn setImage:[UIImage imageNamed:@"duobao_icon_dianzan"] forState:UIControlStateNormal];
        [self.topLikeBtn setImage:[UIImage imageNamed:@"duobao_icon_dianzan"] forState:UIControlStateSelected];
        [self.topLikeBtn setImage:[UIImage imageNamed:@"duobao_icon_dianzan"] forState:UIControlStateHighlighted];
    }
    /*
    curBottomY += mediaHeight + (mediaHeight == 0?0:kMargin_mediaVBottom);
    [self.horLineView setY:curBottomY];
    
    curBottomY += CGRectGetHeight(self.horLineView.frame) + kMargin_horVBottom;
    
    [self.likeBtn setY:curBottomY];
    [self.likeBtn setTitle:[NSString stringWithFormat:@"%ld", [model.click_size longValue]] forState:UIControlStateNormal];
    
    if (model.isClick) {
        [self.likeBtn setImage:[UIImage imageNamed:@"duobao_icon_dianzan_press"] forState:UIControlStateNormal];
        [self.likeBtn setImage:[UIImage imageNamed:@"duobao_icon_dianzan_press"] forState:UIControlStateSelected];
        [self.likeBtn setImage:[UIImage imageNamed:@"duobao_icon_dianzan_press"] forState:UIControlStateHighlighted];
    } else {
        [self.likeBtn setImage:[UIImage imageNamed:@"duobao_icon_dianzan"] forState:UIControlStateNormal];
        [self.likeBtn setImage:[UIImage imageNamed:@"duobao_icon_dianzan"] forState:UIControlStateSelected];
        [self.likeBtn setImage:[UIImage imageNamed:@"duobao_icon_dianzan"] forState:UIControlStateHighlighted];
    }
    
    [self.commentBtn setY:curBottomY];
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%ld", [model.comment_size longValue]] forState:UIControlStateNormal];
    
    [self.verLineView setY:curBottomY];
    
    curBottomY += CGRectGetHeight(self.likeBtn.frame) + kMargin_likeBtnVBottom;
    [self.bottomView setY:curBottomY];
    */
}

- (void)likeBtnClick:(UIButton *)sender
{
    if (_likeBtnClickedBlock) {
        _likeBtnClickedBlock(_model, self.indexPath);
    }
}

- (void)commentBtnClick:(UIButton *)sender
{
    if (_commentClickedBlock) {
        _commentClickedBlock(_model, self.indexPath);
    }
}

- (void)moreButtonClicked:(UIButton *)sender
{
    if (self.moreButtonClickedBlock) {
        self.moreButtonClickedBlock(self.indexPath);
    }
}

- (void)userBtnClicked{
    if (_userBtnClickedBlock) {
        _userBtnClickedBlock();
    }
}

+ (CGFloat)cellHeightWithObj:(IndianaModel *)obj
{
    CGFloat cellHeight = 0;
    
    cellHeight += kPaddingTopHeight;
    cellHeight += KUserInfoHeight + kMargin_imgVBottom;
    cellHeight += [IndianaCell contentLabelHeightWithIndiana:obj] + kMargin_contentBottom;
    
    if (obj.content.length > 0) {
        if (obj.shouldShowMoreButton) {
            cellHeight += KMoreBtnHeight + kMargin_moreBtnBottom;
        }
    }

    cellHeight += [IndianaCell contentMediaHeightWithIndiana:obj];
    /*
    cellHeight += [IndianaCell contentMediaHeightWithIndiana:obj]+ ([IndianaCell contentMediaHeightWithIndiana:obj]==0?0:kMargin_mediaVBottom);
    
    cellHeight += 1 + kMargin_horVBottom;
    cellHeight += KLikeBtnHeight + kMargin_likeBtnVBottom;

    cellHeight += KBottomViewHeight;
    */
    return cellHeight;
}

+ (CGFloat)contentLabelHeightWithIndiana:(IndianaModel *)model{
    CGFloat height = 0;
    if (model.content.length > 0) {
        if (model.shouldShowMoreButton) {
            if (model.isOpening) {
                CGSize size = [IndianaCell getSizeWithString:model.content Font:contentFont constrainedToSize:CGSizeMake(KContent_Width, MAXFLOAT)];
                height += size.height;
            } else {
                
                height += maxContentLabelHeight;
            }
            
        } else {
            CGSize size = [self getSizeWithString:model.content Font:contentFont constrainedToSize:CGSizeMake(KContent_Width, MAXFLOAT)];
            height += size.height;
        }
        
    }
    return height;
}


+ (CGSize)getSizeWithString:(NSString *)string Font:(UIFont *)font constrainedToSize:(CGSize)size{
    CGSize resultSize = CGSizeZero;
    if (string.length <= 0) {
        return resultSize;
    }
    resultSize = [string boundingRectWithSize:size
                                    options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)
                                 attributes:@{NSFontAttributeName: font}
                                    context:nil].size;
    resultSize = CGSizeMake(MIN(size.width, ceilf(resultSize.width)), MIN(size.height, ceilf(resultSize.height)));
    return resultSize;
}

+ (CGFloat)contentMediaHeightWithIndiana:(IndianaModel *)model
{
    CGFloat contentMediaHeight = 0;
    NSInteger mediaCount = model.srcArray.count;
    
    if (mediaCount > 0) {
        contentMediaHeight = (mediaCount == 1)?[IndianaMediaItemSingleCell ccellSizeWithObj:model].height:ceilf((float)mediaCount/3)*([IndianaMediaItemCell ccellSizeWithObj:model].height+10.0) - 10.0;
    }
    
    return contentMediaHeight;
}

#pragma mark Collection M
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.model.srcArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    NSArray *srcArray = self.model.srcArray;
    if (srcArray.count == 1) {
        IndianaMediaItemSingleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_IndianaMediaItemSingle forIndexPath:indexPath];
        cell.srcUrl = srcArray.firstObject;
        cell.refreshSingleCellBlock = ^(){
            if (_refreshSingleCellBlock) {
                _refreshSingleCellBlock();
            }
        };
        return cell;
    } else {
        IndianaMediaItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_IndianaMediaItem forIndexPath:indexPath];
        cell.srcUrl = srcArray[indexPath.item];
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize itemSize = CGSizeZero;
    if (collectionView == _mediaView) {
        if (self.model.srcArray.count == 1) {
            itemSize = [IndianaMediaItemSingleCell ccellSizeWithObj:self.model];
        } else {
            itemSize = [IndianaMediaItemCell ccellSizeWithObj:self.model];
        }
    }
    
    return itemSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    UIEdgeInsets insetForSection = UIEdgeInsetsZero;
    if (collectionView == _mediaView) {
        if (self.model.srcArray.count == 1) {
            CGSize itemSize = [IndianaMediaItemSingleCell ccellSizeWithObj:self.model];
            insetForSection = UIEdgeInsetsMake(0, 0, 0, KContent_Width - itemSize.width);
        } else{
            insetForSection = UIEdgeInsetsMake(0, 0, 0, 0);
        }
    }
    return insetForSection;
}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    if (collectionView == _mediaView) {
//        if (self.model.srcArray.count == 1) {
//            return 0;
//        } else{
//            return 10;
//        }
//    }
//    return 0;
//}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (collectionView == _mediaView) {
        return 10;
    }
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    int count = (int)self.model.srcArray.count;
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:self.model.srcArray[i]];
        [photos addObject:photo];
    }
    
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = indexPath.item;
    browser.photos = photos;
    [browser show];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
