//
//  IntimateCircleCell.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2017/2/15.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "IntimateCircleCell.h"
#import "UICustomCollectionView.h"
#import "UITapImageView.h"
#import "GlobalTool.h"
#import "UIView+Frame.h"
#import "IndianaMediaItemCell.h"
#import "IndianaMediaItemSingleCell.h"
#import "CommentCollectionViewCell.h"
#import "TopicCommentCollectionViewCell.h"
#import "MJPhotoBrowser.h"
#import "UITTTAttributedLabel.h"
#import "UILabel+Common.h"
#import "TagsCell.h"
#import "FollowCell.h"
#import "commentView.h"
#import "CommetReplyModel.h"
#import "HXTagCollectionViewFlowLayout.h"

#import "HXTagsView.h"
//#define kICPaddingLeftWidth ZOOM6(20)
//#define kICPaddingRightWidth ZOOM6(20)
#define kICPaddingTopHeight ZOOM6(30)
//
//#define KICContent_Width (kScreen_Width-kICPaddingLeftWidth-kICPaddingRightWidth)
//
//#define kICUserInfoHeight ZOOM6(80)
//#define KICTagsViewHeight ZOOM6(56)
#define KICLikeCommentViewHeight ZOOM6(80)
#define KICFollowViewHeight ZOOM6(270)
#define KICBottomViewHeight ZOOM6(2)

#define kICnameFont kFont6px(30)
#define kICtimeFont kFont6px(25)
#define kICcontentFont kFont6px(30)

#define kICMargin_imgVBottom 10
#define kICMargin_contentBottom 10
#define kICMargin_mediaVBottom 10
#define kICMargin_tagsBtnBottom 10

#pragma mark - 喜欢评论
@interface LikeCommmentView : UIView
@property (nonatomic, strong) UIView *horLineView, *verLineView, *bottomHorLineView;
@property (nonatomic, strong) UIView *versdLineView;
@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UIButton *commentBtn;
@property (nonatomic, strong) UIButton *del_CollectionBtn;

@property (nonatomic, copy) dispatch_block_t likeBlock;
@property (nonatomic, copy) dispatch_block_t commentBlock;
@property (nonatomic, copy) dispatch_block_t del_collectionBlock;

- (void)actionWithLikeBlock:(dispatch_block_t)likeBlock commentBlock:(dispatch_block_t)commentBlock DelcollectionBlock:(dispatch_block_t)del_collectionBlock;
- (void)setLikeBtnSelect:(BOOL)isLikeSelected commentSelected:(BOOL)isCommentSelected;

@end
@implementation LikeCommmentView
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    [self addSubview:self.horLineView];
    [self addSubview:self.bottomHorLineView];
    [self addSubview:self.verLineView];
    [self addSubview:self.versdLineView];
    [self addSubview:self.likeBtn];
    [self addSubview:self.commentBtn];
    [self addSubview:self.del_CollectionBtn];
    
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    self.horLineView.width = self.width;
    self.verLineView.height = self.height * 0.6;
    self.verLineView.centerX = self.width / 3;
    self.verLineView.centerY = self.height * 0.5;
    self.versdLineView.height = self.height * 0.6;
    self.versdLineView.centerX = (self.width/3)*2;
    self.versdLineView.centerY = self.height *0.5;
    self.likeBtn.frame = CGRectMake(0, 1, self.width /3 - 1, self.height - 1*2);
    self.commentBtn.frame = CGRectMake(self.width /3 + 1, 1, self.likeBtn.width, self.likeBtn.height);
    self.del_CollectionBtn.frame = CGRectMake((self.width/3)*2+1, 1, self.likeBtn.width, self.likeBtn.height);
    [self.bottomHorLineView setY:self.height-1];
    self.bottomHorLineView.width = self.width;
}

- (void)actionWithLikeBlock:(dispatch_block_t)likeBlock commentBlock:(dispatch_block_t)commentBlock DelcollectionBlock:(dispatch_block_t)del_collectionBlock {
    _likeBlock = likeBlock;
    _commentBlock = commentBlock;
    _del_collectionBlock = del_collectionBlock;
}
- (void)setLikeBtnSelect:(BOOL)isLikeSelected commentSelected:(BOOL)isCommentSelected {
    self.likeBtn.selected = isLikeSelected;
    self.commentBtn.selected = isCommentSelected;
}

- (UIView *)horLineView {
    if (_horLineView == nil) {
        _horLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 1)];
        _horLineView.backgroundColor = RGBCOLOR_I(240, 240, 240);
    }
    return _horLineView;
}
- (UIView *)verLineView {
    if (_verLineView == nil) {
        _verLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 0)];
        _verLineView.backgroundColor = RGBCOLOR_I(240, 240, 240);
    }
    return _verLineView;
}
- (UIView *)versdLineView
{
    if(_versdLineView == nil)
    {
        _versdLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 0)];
        _versdLineView.backgroundColor = RGBCOLOR_I(240, 240, 240);
    }
    return _versdLineView;
}
- (UIView *)bottomHorLineView {
    if (_bottomHorLineView == nil) {
        _bottomHorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 1)];
        _bottomHorLineView.backgroundColor = RGBCOLOR_I(240, 240, 240);
    }
    return _bottomHorLineView;
}

- (UIButton *)likeBtn {
    if (_likeBtn == nil) {
        _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeBtn addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_likeBtn setTitleColor:RGBCOLOR_I(62,62,62) forState:UIControlStateNormal];
        [_likeBtn setTitleColor:COLOR_ROSERED forState:UIControlStateSelected];
        _likeBtn.titleLabel.font = kFont6px(24);
        
        [_likeBtn setImage:[UIImage imageNamed:@"miyou_icon_xihuan"] forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"miyou_icon_xihuan_pre"] forState:UIControlStateSelected];
        [_likeBtn setImage:[UIImage imageNamed:@"miyou_icon_xihuan"] forState:UIControlStateHighlighted];
        [_likeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    }
    return _likeBtn;
}

- (UIButton *)commentBtn {
    if (_commentBtn == nil) {
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentBtn addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_commentBtn setTitleColor:RGBCOLOR_I(62,62,62) forState:UIControlStateNormal];
        [_commentBtn setTitleColor:COLOR_ROSERED forState:UIControlStateSelected];
        _commentBtn.titleLabel.font = kFont6px(24);
        
        [_commentBtn setImage:[UIImage imageNamed:@"miyou_icon_pinglun-"] forState:UIControlStateNormal];
        [_commentBtn setImage:[UIImage imageNamed:@"miyou_icon_pinglun-"] forState:UIControlStateSelected];
        [_commentBtn setImage:[UIImage imageNamed:@"miyou_icon_pinglun-"] forState:UIControlStateHighlighted];
        [_commentBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    }
    return _commentBtn;
}

- (UIButton *)del_CollectionBtn
{
    if(_del_CollectionBtn == nil)
    {
        _del_CollectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_del_CollectionBtn addTarget:self action:@selector(del_collectionBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_del_CollectionBtn setTitleColor:RGBCOLOR_I(62,62,62) forState:UIControlStateNormal];
        [_del_CollectionBtn setTitleColor:COLOR_ROSERED forState:UIControlStateSelected];
        _del_CollectionBtn.titleLabel.font = kFont6px(24);
        
        [_del_CollectionBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    }
    return _del_CollectionBtn;
}

- (void)commentBtnClick:(UIButton *)sender {
    if (self.commentBlock) {
        self.commentBlock();
    }
}

- (void)likeBtnClick:(UIButton *)sender {
    if (self.likeBlock) {
        self.likeBlock();
    }
}

- (void)del_collectionBtn:(UIButton*)sender
{
    if(self.del_collectionBlock){
        self.del_collectionBlock();
    }
}
@end

#pragma mark - IntimateCircleCell
@interface IntimateCircleCell () <TTTAttributedLabelDelegate,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UITapImageView *ownerImgView;
@property (strong, nonatomic) UIImageView *userVipIco;
@property (strong, nonatomic) UIButton *nameButton;
@property (nonatomic, strong) UILabel *timeLabel;
@property (strong, nonatomic) UITTTAttributedLabel *contentLabel;
@property (strong, nonatomic) UILabel *morelabel;
@property (strong, nonatomic) UILabel *photosNumLabel;
@property (strong, nonatomic) UICustomCollectionView *mediaView;
@property (strong, nonatomic) UICustomCollectionView *tagsView;
@property (strong, nonatomic) LikeCommmentView *likeCommentView;
@property (strong, nonatomic) UICustomCollectionView *followView;
@property (strong, nonatomic) UICustomCollectionView *TCommentView;
//@property (strong, nonatomic) commentView *commentView;
@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UIView *lastbottomView;
@property (strong, nonatomic) HXTagsView *hxtagsView;

@end

@implementation IntimateCircleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!self.ownerImgView) {
            UITapImageView *imageV = [[UITapImageView alloc] initWithFrame:CGRectMake(kICPaddingLeftWidth, kICPaddingTopHeight, kICUserInfoHeight, kICUserInfoHeight)];
            imageV.layer.masksToBounds = YES;
            imageV.layer.cornerRadius = kICUserInfoHeight * 0.5;
//            imageV.backgroundColor = [UIColor redColor];
            [self.contentView addSubview:_ownerImgView = imageV];
        }
        if (!self.userVipIco) {
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_ownerImgView.frame)-ZOOM6(30), CGRectGetMaxY(_ownerImgView.frame)-ZOOM6(30), ZOOM6(30), ZOOM6(30))];
            imageV.layer.masksToBounds = YES;
            imageV.layer.cornerRadius = ZOOM6(30) * 0.5;
//            imageV.backgroundColor=DRandomColor;
            imageV.hidden=YES;
            [self.contentView addSubview:_userVipIco = imageV];
        }
        
        if (!self.nameButton) {
            UIButton *nameButton = [UIButton buttonWithType:UIButtonTypeCustom];
            nameButton.frame = CGRectMake(self.ownerImgView.right + ZOOM6(30), self.ownerImgView.top, ZOOM6(400), self.ownerImgView.height * 0.5);
            [nameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            nameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            nameButton.titleLabel.font = kICnameFont;
            [nameButton setTitle:@"" forState:UIControlStateNormal];
            [self.contentView addSubview:_nameButton = nameButton];
        }
        
        if (!self.timeLabel) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.nameButton.left, self.nameButton.bottom, self.nameButton.width, self.ownerImgView.height * 0.5)];
            label.font = kICtimeFont;
            label.text = @"";
            label.textColor = kTextColor;
            [self.contentView addSubview:_timeLabel = label];
        }
        
        if (!self.heedBtn) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(kScreen_Width - ZOOM6(180) - kICPaddingRightWidth, self.ownerImgView.bottom - ZOOM6(60), ZOOM6(180), ZOOM6(60));
            
            [button setTitle:@"+ 关注蜜友" forState:UIControlStateNormal];
            [button setTitleColor:COLOR_ROSERED forState:UIControlStateNormal];
            [button setTitleColor:kTextColor forState:UIControlStateSelected];
            button.titleLabel.font = kICnameFont;
            button.backgroundColor = [UIColor whiteColor];
            
            button.selected = NO;
            button.layer.borderColor = [COLOR_ROSERED CGColor];
            button.layer.borderWidth = 0.6f;
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = ZOOM6(4);
            
            kWeakSelf(self);
            [button handleClickEvent:UIControlEventTouchUpInside withClickBlock:^(UIButton *sender) {
                if (weakself.heedBtnClickedBlock) {
                    weakself.heedBtnClickedBlock(weakself.model, weakself.indexPath);
                }
            }];
            
            [self.contentView addSubview:_heedBtn = button];
        }
        
        if (!self.contentLabel) {
            UITTTAttributedLabel *contentLabel = [[UITTTAttributedLabel alloc] initWithFrame:CGRectMake(kICPaddingLeftWidth+kICUserInfoHeight+ZOOM6(30), kICMargin_imgVBottom + self.ownerImgView.bottom, KICContent_Width-kICUserInfoHeight-ZOOM6(30), 20)];
            contentLabel.font = kICcontentFont;
            contentLabel.textColor = [UIColor blackColor];
            contentLabel.linkAttributes = @{(__bridge NSString *)kCTUnderlineStyleAttributeName : [NSNumber numberWithBool:NO],(NSString *)kCTForegroundColorAttributeName : (__bridge id)COLOR_ROSERED.CGColor};
            contentLabel.activeLinkAttributes = @{(NSString *)kCTUnderlineStyleAttributeName : [NSNumber numberWithBool:NO],(NSString *)kCTForegroundColorAttributeName : (__bridge id)[COLOR_ROSERED CGColor]};
            
            contentLabel.delegate = self;
            contentLabel.numberOfLines = 4;

            contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
            [self.contentView addSubview:_contentLabel = contentLabel];
            
        }
        if (!self.mediaView) {
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            UICustomCollectionView *mediaView = [[UICustomCollectionView alloc] initWithFrame:CGRectMake(kICPaddingLeftWidth+kICUserInfoHeight+ZOOM6(30), self.contentLabel.bottom + kICMargin_contentBottom, KICContent_Width-kICUserInfoHeight-ZOOM6(30), 80) collectionViewLayout:layout];
            mediaView.layer.cornerRadius = 5.;
            mediaView.scrollEnabled = NO;
            [mediaView setBackgroundView:nil];
            [mediaView setBackgroundColor:[UIColor clearColor]];
            [mediaView registerClass:[IndianaMediaItemCell class] forCellWithReuseIdentifier:kCellIdentifier_IndianaMediaItem];
            [mediaView registerClass:[IndianaMediaItemSingleCell class] forCellWithReuseIdentifier:kCellIdentifier_IndianaMediaItemSingle];
            mediaView.backgroundColor = [UIColor whiteColor];
            mediaView.dataSource = self;
            mediaView.delegate = self;
            [self.contentView addSubview:_mediaView = mediaView];
        }
        if (!self.photosNumLabel) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kICPaddingLeftWidth+ZOOM6(20), self.mediaView.bottom-ZOOM6(46), kICUserInfoHeight-ZOOM6(10), ZOOM6(46))];
            label.font = kFont6px(24);
            label.text = @"";
            label.backgroundColor = kMainTitleColor;
            label.textColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.layer.cornerRadius = 3;
            label.clipsToBounds = YES;
            [self.contentView addSubview:_photosNumLabel = label];
        }
        
//        if (!self.tagsView) {
//            
//            HXTagCollectionViewFlowLayout *layout = [[HXTagCollectionViewFlowLayout alloc] init];
//            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//            UICustomCollectionView *tagView = [[UICustomCollectionView alloc] initWithFrame:CGRectMake(kICPaddingLeftWidth, self.mediaView.bottom + kICMargin_mediaVBottom, KICContent_Width, KICTagsViewHeight) collectionViewLayout:layout];
//            [tagView registerClass:[TagsCell class]forCellWithReuseIdentifier:kICCellIdentifier_TagsCell];
//            tagView.backgroundColor = [UIColor whiteColor];
//            tagView.dataSource = self;
//            tagView.delegate = self;
//            tagView.showsHorizontalScrollIndicator = NO;
//            tagView.bounces = NO;
//            tagView.scrollsToTop = NO;
//            [self.contentView addSubview:_tagsView = tagView];
//        }
        
        if(!self.hxtagsView)
        {
            HXTagsView *hxtagview = [[HXTagsView alloc] initWithFrame:CGRectMake(kICPaddingLeftWidth, self.mediaView.bottom + kICMargin_mediaVBottom, KICContent_Width, KICTagsViewHeight)];
            hxtagview.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            kSelfWeak;
            hxtagview.completion = ^(NSArray *selectTags,NSInteger currentIndex) {
                NSLog(@"selectTags:%@ currentIndex:%ld",selectTags, (long)currentIndex);
                if ([weakSelf.model.theme_type intValue] == 2 || [weakSelf.model.theme_type intValue] == 4) {
                    NSObject *obj = weakSelf.model.tagsArray[currentIndex];
                    if ([obj isKindOfClass:[ShopTagItem class]]) {
                        ShopTagItem *item = (ShopTagItem *)obj;
                        if (weakSelf.tagDressWithStyleClickBlock) {
                            weakSelf.tagDressWithStyleClickBlock(item, weakSelf.indexPath);
                        }
                    } else if ([obj isKindOfClass:[TypeTagItem class]]) {
                        TypeTagItem *item = (TypeTagItem *)obj;
                        if (weakSelf.tagDressWithSuppClickBlock ) {
                            weakSelf.tagDressWithSuppClickBlock(item, weakSelf.indexPath,weakSelf.model);
                        }
                    }else if ([obj isKindOfClass:[ShopTypeItem class]])
                    {
                        ShopTypeItem *item = weakSelf.model.tagsArray[currentIndex];
                        if (weakSelf.tagThemeClickBlock) {
                            weakSelf.tagThemeClickBlock(item, weakSelf.indexPath);
                        }
                    }
                    
                } else if ([weakSelf.model.theme_type intValue] == 3) {
                    ShopTypeItem *item = weakSelf.model.tagsArray[currentIndex];
                    if (weakSelf.tagThemeClickBlock) {
                        weakSelf.tagThemeClickBlock(item, weakSelf.indexPath);
                    }
                } else if ([weakSelf.model.theme_type intValue] == 1) {
                    ShopTypeItem *item = [[ShopTypeItem alloc] init];
                    item.ID = @"149";
                    if(weakSelf.model.tags.count)
                    {
                        item.ID = weakSelf.model.tags[0];
                    }
                    item.name = @"精选推荐";
                    if (weakSelf.followTagClickBlock) {
                        weakSelf.followTagClickBlock(item, weakSelf.indexPath);
                    }
                }

            };
            [self.contentView addSubview:_hxtagsView = hxtagview];
        }

        if (!self.likeCommentView) {
            LikeCommmentView *likeCommentV = [[LikeCommmentView alloc] initWithFrame:CGRectMake(0, self.hxtagsView.bottom + kICMargin_tagsBtnBottom, kScreen_Width, KICLikeCommentViewHeight)];
            [self.contentView addSubview:_likeCommentView = likeCommentV];
        }
        
        if (!self.followView) {
            
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            UICustomCollectionView *followView = [[UICustomCollectionView alloc] initWithFrame:CGRectMake(kICPaddingLeftWidth, self.likeCommentView.bottom,
                                                KICContent_Width,
                                                KICFollowViewHeight) collectionViewLayout:layout];
            [followView registerClass:[FollowCell class] forCellWithReuseIdentifier:kICCellIdentifier_FollowCell];
            followView.backgroundColor = [UIColor whiteColor];
            followView.dataSource = self;
            followView.delegate = self;
            followView.showsHorizontalScrollIndicator = NO;
            followView.bounces = NO;
            followView.scrollsToTop = NO;
            [self.contentView addSubview:_followView = followView];
            
        }
        
        if (!self.bottomView) {
            UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.followView.bottom, kScreen_Width, KICBottomViewHeight)];
            bottomView.backgroundColor = RGBCOLOR_I(240, 240, 240);
            [self.contentView addSubview:_bottomView = bottomView];
        }

        if(!self.TCommentView)
        {
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            UICustomCollectionView *commentview = [[UICustomCollectionView alloc] initWithFrame:CGRectMake(kICPaddingLeftWidth, self.bottomView.bottom + kICMargin_mediaVBottom, kScreenWidth-2*kICPaddingLeftWidth, ZOOM6(40)) collectionViewLayout:layout];
            [commentview registerClass:[TopicCommentCollectionViewCell class] forCellWithReuseIdentifier:@"COMMENTCELL"];
            commentview.backgroundColor = [UIColor whiteColor];
            commentview.dataSource = self;
            commentview.delegate = self;
            commentview.showsHorizontalScrollIndicator = NO;
            commentview.bounces = NO;
            commentview.scrollsToTop = NO;
            [self.contentView addSubview:_TCommentView = commentview];
        }
        if(!self.lastbottomView)
        {
            UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bottom-ZOOM6(20), kScreen_Width, ZOOM6(20))];
            bottomView.backgroundColor = RGBCOLOR_I(240, 240, 240);
            [self.contentView addSubview:_lastbottomView = bottomView];
        }
    }
    return self;
}

#pragma mark - setter
- (void)setModel:(IntimateCircleModel *)model indexPath:(NSIndexPath *)indexPath {
    
    _model = model;
    _indexPath = indexPath;
    
    NSString *text = nil;
    if (model.title.length) {
        text = [NSString stringWithFormat:@"#%@#  %@", model.title, model.content];
    } else {
        text = model.content;
    }
    
    while ([text rangeOfString:@"\n"].length>0) {
        text = [text stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    }
    
    CGFloat curBottomY = kICMargin_imgVBottom + self.ownerImgView.bottom;
    [self.contentLabel setY:curBottomY];
    
    [self.contentLabel setLongString:text font:kICcontentFont withFitWidth:KICContent_Width-kICUserInfoHeight-ZOOM6(30) maxHeight:ZOOM6(80) * 2];
    [self.contentLabel addLinkToTransitInformation:@{@"value": @"xxx"} withRange:[text rangeOfString:model.title.length?[NSString stringWithFormat:@"#%@#", model.title]:@""]];

    [self setLineBreakByTruncatingLastLineMiddle];
    
    curBottomY = self.contentLabel.bottom + (model.content.length != 0 ? kICMargin_contentBottom : 0);
    [self.mediaView setY:curBottomY];
    CGFloat mediaHeight = 0;
    if (model.srcArray.count) {
        mediaHeight = [IntimateCircleCell contentMediaHeightWithCircle:model];
        self.mediaView.hidden = NO;
        [self.mediaView reloadData];
    } else {
        if (self.mediaView) {
            self.mediaView.hidden = YES;
        }
    }
//    [self.mediaView setFrame:CGRectMake(kICPaddingLeftWidth, curBottomY, KICContent_Width, mediaHeight)];
    [self.mediaView setFrame:CGRectMake(kICPaddingLeftWidth+kICUserInfoHeight+ZOOM6(30), curBottomY, KICContent_Width-kICUserInfoHeight-ZOOM6(30), mediaHeight)];
    [self.photosNumLabel setFrame: CGRectMake(kICPaddingLeftWidth+ZOOM6(20), self.mediaView.bottom-ZOOM6(46), kICUserInfoHeight-ZOOM6(10), ZOOM6(46))];

    self.photosNumLabel.hidden = model.srcArray.count<=1;
    if (model.srcArray.count>1) {
        self.photosNumLabel.text = [NSString stringWithFormat:@"%zd张",model.srcArray.count];
    }

    
    curBottomY = self.mediaView.bottom + (model.srcArray.count != 0 ? kICMargin_mediaVBottom : 0);
    [self.hxtagsView setY:curBottomY];
    CGFloat tagsHeight = 0;
    if (model.tagsArray.count) {

        self.hxtagsView.tags = [self gettitleArray:model];
        if(self.hxtagsView.tags.count)
        {
            tagsHeight = [HXTagsView getHeightWithTags:self.hxtagsView.tags layout:self.hxtagsView.layout tagAttribute:self.hxtagsView.tagAttribute width:kScreenWidth];
        }
//        self.hxtagsView.height = tagsHeight;
        [self.hxtagsView reloadData];
    }
    self.hxtagsView.height = tagsHeight;

    curBottomY = self.hxtagsView.bottom + (model.tagsArray.count != 0 ? kICMargin_tagsBtnBottom : 0);
    [self.likeCommentView setY:curBottomY];
    kWeakSelf(self);
    [self.likeCommentView actionWithLikeBlock:^{
        if (weakself.likeBtnClickedBlock) {
            weakself.likeBtnClickedBlock(weakself.model, weakself.indexPath);
        }
    } commentBlock:^{
        if (weakself.commentClickedBlock) {
            weakself.commentClickedBlock(weakself.model, weakself.indexPath);
        }
    } DelcollectionBlock:^{
        
        if (weakself.del_collectionBlock) {
            weakself.del_collectionBlock(weakself.model, weakself.indexPath);
        }

    }];
    
    curBottomY = self.likeCommentView.bottom;
    [self.followView setY:curBottomY];
    CGFloat followHeight = 0;
    if (model.followArray.count) {
        followHeight = [FollowCell cellSizeWithObj:nil].height;
        [self.followView reloadData];
        self.likeCommentView.bottomHorLineView.hidden = NO;
    } else {
        self.likeCommentView.bottomHorLineView.hidden = YES;
    }
    self.followView.height = followHeight;
    
    curBottomY = self.followView.bottom;
    [self.bottomView setY:curBottomY];
    
    
    
    curBottomY = self.bottomView.bottom+ZOOM6(20);
//    [self.TCommentView setY:curBottomY];
    if(model.commentArray.count)
    {
        int count = self.model.commentArray.count>5?5:(int)self.model.commentArray.count;
//        self.commentView.height = count*ZOOM6(40);
//        [self.commentView refreshView:self.model];
        
//        curBottomY = self.bottomView.bottom + (model.srcArray.count != 0 ? kICMargin_mediaVBottom : 0);
        
        [self.TCommentView setY:curBottomY];
        CGFloat tagsHeight = 0;
        if (model.commentArray.count) {
            tagsHeight = ZOOM6(40)*count;
            [self.TCommentView reloadData];
        }
        self.TCommentView.height = tagsHeight;

        curBottomY = self.TCommentView.bottom+ZOOM6(20);
        [self.lastbottomView setY:curBottomY];

    }else{
//        self.commentView.height = 0;
//        [self.commentView refreshView:self.model];
        
        self.TCommentView.height = 0;
        
        curBottomY = self.bottomView.bottom;
        [self.lastbottomView setY:curBottomY];
    }
    
    
    [self setOtherData];
    [self setHeedData];
}
//获取文本每一行的内容
- (void)setLineBreakByTruncatingLastLineMiddle{
    
    NSArray *separatedLines = [self getSeparatedLinesArray];
    if ( separatedLines.count <= 4 ) {
        [self.morelabel removeFromSuperview];
        self.morelabel = nil;
        return;
    }

    NSMutableString *limitedText = [NSMutableString string];
    if ( separatedLines.count >= self.contentLabel.numberOfLines ) {
        
        for (int i = 0 ; i < self.contentLabel.numberOfLines; i++) {
            if ( i == self.contentLabel.numberOfLines - 1) {
                
                NSString *lastlinetext = separatedLines[self.contentLabel.numberOfLines - 1];
                if(lastlinetext.length >10)
                {
                    NSString *laststr = [lastlinetext substringFromIndex:lastlinetext.length-10];
                    int result = [self getlongthnum:laststr];
                    int longth = 0;
                    if(result >=4)
                    {
                        if(result >= 8)
                        {
                            if (kDevice_Is_iPhone6Plus) {
                                longth = 6;
                            } else {
                                longth = 15;
                            }

                        }else{
                            if (kDevice_Is_iPhone6Plus) {
                                longth = 6;
                            } else {
                                longth = 10;
                            }
                        }
                      
                    }else{
                        if (kDevice_Is_iPhone6Plus) {
                            longth = 5;
                        } else {
                            longth = 7;
                        }
                    }
                    NSMutableString *newstr;
                    if(lastlinetext.length > longth)
                    {
                        newstr = [NSMutableString stringWithString:[lastlinetext substringToIndex:lastlinetext.length-longth]];
                    }
                    lastlinetext = [NSString stringWithFormat:@"%@...",newstr];
                    [limitedText appendString: lastlinetext];
                }
            }else{
                [limitedText appendString:separatedLines[i]];
            }
        }
        
    }else{
        [limitedText appendString: self.contentLabel.text];
    }
    
    self.contentLabel.text = limitedText;

    if(!self.morelabel)
    {
        UILabel *morelabel = [[UILabel alloc]init];
        morelabel.frame = CGRectMake(CGRectGetWidth(self.contentLabel.frame)-ZOOM6(130), CGRectGetHeight(self.contentLabel.frame)-ZOOM6(40), ZOOM6(130), ZOOM6(40));
        morelabel.text = @"查看全文";
        morelabel.font = kICcontentFont;
        morelabel.textColor = tarbarrossred;
        morelabel.textAlignment = NSTextAlignmentLeft;
        [self.contentLabel addSubview:_morelabel = morelabel];
        [self.contentLabel bringSubviewToFront:morelabel];
    }
}

//获取汉字的个数
- (int)getlongthnum:(NSString*)text
{
    int count = 0;
    int count1 =0;

    for (int i =0; i< text.length; i++)
    {
        unichar c = [text characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FA5)//是汉字
        {
            count ++;
        }
        else
        {
            count1 ++;
        }
    }
    
    return count1;
}
- (NSArray *)getSeparatedLinesArray
{
    NSString *text = [self.contentLabel text];
    UIFont   *font = kICcontentFont;
    CGRect    rect = [self.contentLabel frame];
    
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines)
    {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    return (NSArray *)linesArray;
}

- (NSArray *)gettitleArray:(IntimateCircleModel*)model
{
    NSMutableArray *tagstitleArray = [NSMutableArray array];
    
    for(int i =0 ;i<model.tagsArray.count;i++)
    {
        IntimateCircleModel *obj = model.tagsArray[i];
        NSString *name = @"";
        if ([obj isKindOfClass:[ShopTagItem class]]) {
            ShopTagItem *item = (ShopTagItem *)obj;
            name = item.tag_name;
            
        } else if ([obj isKindOfClass:[TypeTagItem class]]) {
            TypeTagItem *item = (TypeTagItem *)obj;
            name = item.class_name;
        } else if ([obj isKindOfClass:[ShopTypeItem class]])
        {
            ShopTypeItem *item = (ShopTypeItem*)obj;
            name = item.name;
        }else if ([obj isKindOfClass:[NSString class]]){
            if([obj isEqual:@"精选推荐"])
            {
                name = @"精选推荐";
            }
        }
        name.length>0?[tagstitleArray addObject:name]:nil;
    }
    
    return tagstitleArray;
}
- (void)setOtherData {
    IntimateCircleModel *model = self.model;
    NSURL *url = nil;
    if ([model.head_pic hasPrefix:@"http"]) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.head_pic]];
    } else {
        if ([model.head_pic hasPrefix:@"/"]) {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],[model.head_pic substringFromIndex:1]]];
        } else {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.head_pic]];
        }
    }
    [self.ownerImgView sd_setImageWithURL:url];
    
    self.userVipIco.hidden=model.v_ident.integerValue==0;
    self.userVipIco.image=model.v_ident.integerValue==1?[UIImage imageNamed:@"V_red"]:[UIImage imageNamed:@"V_blue"];
    
    kWeakSelf(self);
    [self.ownerImgView addTapBlock:^(id obj) {
        if (weakself.headerTitleTapBlock) {
            weakself.headerTitleTapBlock( weakself.model,weakself.indexPath);
        }
    }];
    NSString *nickname=model.nickname;
    if (model.nickname.length>8) {
        nickname=[nickname substringToIndex:8];
    }
    [self.nameButton setTitle:nickname forState:UIControlStateNormal];
    [self.nameButton handleClickEvent:UIControlEventTouchUpInside withClickBlock:^(UIButton *sender) {
        if (weakself.headerTitleTapBlock) {
            weakself.headerTitleTapBlock( weakself.model,weakself.indexPath);
        }
    }];
    NSString *locationTime = nil;
    if (model.location.length) {
        if(self.model.location.length > 8 )
        {
            model.location = [model.location stringByReplacingOccurrencesOfString:@" " withString:@""];
            model.location = [NSString stringWithFormat:@"%@...",[model.location substringToIndex:8]];
        }
        locationTime = [NSString stringWithFormat:@"%@   %@", model.location, [NSString getTimeStyle:TimeStrStyleArticle time:model.send_time/1000.0f]];
    } else {
        locationTime = [NSString stringWithFormat:@"来自喵星   %@", [NSString getTimeStyle:TimeStrStyleArticle time:model.send_time/1000.0f]];
    }
    self.timeLabel.text = locationTime;
    
    [self.likeCommentView.likeBtn setTitle:[NSString stringWithFormat:@"%zd", [model.applaud_num integerValue]] forState:UIControlStateNormal];
    [self.likeCommentView.commentBtn setTitle:[NSString stringWithFormat:@"%zd", [model.comment_count integerValue]] forState:UIControlStateNormal];
    if (model.applaud_status != 0) {
        self.likeCommentView.likeBtn.selected = YES;
    } else {
        self.likeCommentView.likeBtn.selected = NO;
    }
    
    //收藏或者是删除
    NSString *userId = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID]];
    if([userId integerValue] == [model.user_id integerValue])
    {
        [self.likeCommentView.del_CollectionBtn setImage:[UIImage imageNamed:@"miyou_icon_del01"] forState:UIControlStateNormal];
        [self.likeCommentView.del_CollectionBtn setImage:[UIImage imageNamed:@"miyou_icon_del01"] forState:UIControlStateSelected];
        [self.likeCommentView.del_CollectionBtn setImage:[UIImage imageNamed:@"miyou_icon_del01"] forState:UIControlStateHighlighted];
        [self.likeCommentView.del_CollectionBtn setTitle:@"" forState:UIControlStateNormal];
    }else{
        self.likeCommentView.del_CollectionBtn.selected = model.collection_status==1?YES:NO;
        [self.likeCommentView.del_CollectionBtn setImage:[UIImage imageNamed:@"miyou_icon_shoucang"] forState:UIControlStateNormal];
        [self.likeCommentView.del_CollectionBtn setImage:[UIImage imageNamed:@"miyou_icon_yishoucang"] forState:UIControlStateSelected];
        [self.likeCommentView.del_CollectionBtn setImage:[UIImage imageNamed:@"miyou_icon_shoucang"] forState:UIControlStateHighlighted];
        [self.likeCommentView.del_CollectionBtn setTitle:[NSString stringWithFormat:@"%zd", [model.collect_num integerValue]] forState:UIControlStateNormal];
    }
}

- (void)setHeedData {
    NSString *userId = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID]];
   
    if (self.model.attention_status != 0 || [userId integerValue] == [self.model.user_id integerValue]) {
        self.model.attention_status = 1;
        self.heedBtn.selected = YES;
        [self.heedBtn setTitle:@"已关注" forState:UIControlStateNormal];
        self.heedBtn.layer.borderColor = [kTextColor CGColor];
        self.heedBtn.layer.borderWidth = 1;
        self.heedBtn.layer.masksToBounds = YES;
        self.heedBtn.layer.cornerRadius = ZOOM6(4);
    } else {
        self.model.attention_status = 0;
        self.heedBtn.selected = NO;
        [self.heedBtn setTitle:@"+ 关注蜜友" forState:UIControlStateNormal];
        self.heedBtn.layer.borderColor = [COLOR_ROSERED CGColor];
        self.heedBtn.layer.borderWidth = 1;
        self.heedBtn.layer.masksToBounds = YES;
        self.heedBtn.layer.cornerRadius = ZOOM6(4);
    }
}


#pragma mark - Delegate
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTransitInformation:(NSDictionary *)components {
    NSLog(@"ok");
}

#pragma mark - collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    [collectionView.collectionViewLayout invalidateLayout];
    if (collectionView == _mediaView) {
        return 1;// self.model.srcArray.count;
    } else if (collectionView == _tagsView) {
        return self.model.tagsArray.count;
    } else if (collectionView == _followView) {
//        return self.model.followArray.count>=4?4:self.model.followArray.count;
        return self.model.followArray.count;
    } else if (collectionView == _TCommentView)
    {
        int count = self.model.commentArray.count>5?5:(int)self.model.commentArray.count;
        return count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _mediaView) {
        NSArray *srcArray = self.model.srcArray;
        IndianaMediaItemSingleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_IndianaMediaItemSingle forIndexPath:indexPath];
        cell.srcUrl = srcArray.firstObject;
        kSelfWeak;
        cell.refreshSingleCellBlock = ^(){
            if (weakSelf.refreshSingleCellBlock) {
                weakSelf.refreshSingleCellBlock();
            }
        };
        return cell;
        /*
        if (srcArray.count == 1) {
            IndianaMediaItemSingleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_IndianaMediaItemSingle forIndexPath:indexPath];
            cell.srcUrl = srcArray.firstObject;
            kSelfWeak;
            cell.refreshSingleCellBlock = ^(){
                if (weakSelf.refreshSingleCellBlock) {
                    weakSelf.refreshSingleCellBlock();
                }
            };
            return cell;
        } else {
            IndianaMediaItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_IndianaMediaItem forIndexPath:indexPath];
//            cell.srcUrl = srcArray[indexPath.item];
            [cell setSrcUrl:srcArray[indexPath.item] withCount:srcArray.count];
            return cell;
        }
        */
    } else if (collectionView == _tagsView) {
        TagsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kICCellIdentifier_TagsCell forIndexPath:indexPath];
        if ([self.model.theme_type intValue] == 3 ) {
            ShopTypeItem *item = self.model.tagsArray[indexPath.item];
            
            [cell setText:item.name withSelected:[item.type integerValue] == 1?YES : NO];
        } else if ([self.model.theme_type intValue] == 2 || [self.model.theme_type intValue] == 4) {
            NSString *name = @"";
            NSObject *obj = self.model.tagsArray[indexPath.item];
            if ([obj isKindOfClass:[ShopTagItem class]]) {
                ShopTagItem *item = (ShopTagItem *)obj;
                name = item.tag_name;
            } else if ([obj isKindOfClass:[TypeTagItem class]]) {
                TypeTagItem *item = (TypeTagItem *)obj;
                name = item.class_name;
            } else if ([obj isKindOfClass:[ShopTypeItem class]])
            {
                ShopTypeItem *item = (ShopTypeItem*)obj;
                name = item.name;
            }
            [cell setText:name withSelected:YES];
        } else if ([self.model.theme_type integerValue] == 1) {
            NSString *name = self.model.tagsArray[indexPath.item];
             [cell setText:name withSelected:YES];
        }
       
        return cell;
    } else if (collectionView == _followView) {
        FollowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kICCellIdentifier_FollowCell forIndexPath:indexPath];
        
        TFShopModel *shopModel = self.model.followArray[indexPath.item];
        
        NSMutableString *code = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",shopModel.shop_code]];
        NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
        NSString *pic = [NSString stringWithFormat:@"%@/%@/%@",supcode,shopModel.shop_code,shopModel.def_pic];
        NSString *picSize;
        if (kDevice_Is_iPhone6Plus) {
            picSize = @"!382";
        } else {
            picSize = @"!280";
        }
        //!280
        NSString *imgUrl = [NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],pic,picSize];
        NSString *price = @"";
        if([DataManager sharedManager].is_OneYuan)
        {
            price = shopModel.app_shop_group_price;
        }else{
            price = [NSString stringWithFormat:@"%@",shopModel.shop_se_price];
        }
        [cell setImageUrl:imgUrl title:shopModel.supp_label price:[NSString stringWithFormat:@"%.1f", [price floatValue]]];
        
        return cell;
    }else if (collectionView == _TCommentView)
    {
        TopicCommentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"COMMENTCELL" forIndexPath:indexPath];
        CommetReplyModel *model = self.model.commentArray[indexPath.item];
        [cell settitle:model];
        return cell;
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize itemSize = CGSizeZero;
    if (collectionView == _mediaView) {
        itemSize = [IndianaMediaItemSingleCell cellSizeWithObj:self.model];
        /*
        if (self.model.srcArray.count == 1) {
            itemSize = [IndianaMediaItemSingleCell cellSizeWithObj:self.model];
        } else {
            itemSize = [IndianaMediaItemCell cellSizeWithObj:self.model];
        }
        */
    } else if (collectionView == _tagsView) {
        NSString *name = @"";
        
        if ([self.model.theme_type intValue] == 3 ) {
            ShopTypeItem *item = self.model.tagsArray[indexPath.item];
            name = item.name;
        } else if ([self.model.theme_type intValue] == 2 || [self.model.theme_type intValue] == 4) {
            NSObject *obj = self.model.tagsArray[indexPath.item];
            if ([obj isKindOfClass:[ShopTagItem class]]) {
                ShopTagItem *item = (ShopTagItem *)obj;
                name = item.tag_name;
            } else if ([obj isKindOfClass:[TypeTagItem class]]) {
                TypeTagItem *item = (TypeTagItem *)obj;
                name = item.class_name;
            } else if ([obj isKindOfClass:[ShopTypeItem class]])
            {
                ShopTypeItem *item = (ShopTypeItem*)obj;
                name = item.name;
            }

        } else if ([self.model.theme_type integerValue] == 1) {
            name = self.model.tagsArray[indexPath.item];
        }
        itemSize = [TagsCell cellSizeWithObj:name];
        
//        HXTagCollectionViewFlowLayout *layout = (HXTagCollectionViewFlowLayout *)collectionView.collectionViewLayout;
//        CGSize maxSize = CGSizeMake(collectionView.frame.size.width - layout.sectionInset.left - layout.sectionInset.right, layout.itemSize.height);
//        
//        CGRect frame = [name boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:ZOOM6(26)]} context:nil];
//        
//        return CGSizeMake(frame.size.width + ZOOM6(50), ZOOM6(56));

    } else if (collectionView == _followView) {
        itemSize = [FollowCell cellSizeWithObj:nil];
    } else if (collectionView == _TCommentView)
    {
        itemSize = CGSizeMake(kScreenWidth-2*kICPaddingLeftWidth, ZOOM6(40));
    }
    return itemSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    UIEdgeInsets insetForSection = UIEdgeInsetsZero;
    if (collectionView == _mediaView) {
        insetForSection = UIEdgeInsetsMake(0, 0, 0, 0);
        /*
        if (self.model.srcArray.count == 1) {
            CGSize itemSize = [IndianaMediaItemSingleCell cellSizeWithObj:self.model];
            insetForSection = UIEdgeInsetsMake(0, 0, 0, KICContent_Width - itemSize.width);
        } else{
//            insetForSection = UIEdgeInsetsMake(0, 0, 0, 0);
        }
        */
    }
//    else if (collectionView == _tagsView) {
//        insetForSection = UIEdgeInsetsMake(0, 0, 0, 0);
//    } else if (collectionView == _followView) {
//        insetForSection = UIEdgeInsetsMake(0, 0, 0, 0);
//    }
    return insetForSection;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (collectionView == _mediaView) {
        return ZOOM6(10);
    }
    else if (collectionView == _tagsView) {
        return ZOOM6(20);
    } else if (collectionView == _followView) {
        return ZOOM6(20);
    }
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (collectionView == _mediaView) {
        return ZOOM6(10);
    } else if (collectionView == _tagsView) {
        return ZOOM6(20);
    } else if (collectionView == _followView) {
        return ZOOM6(20);
    }
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == _mediaView) {
//        int count = (int)self.model.srcArray.count;
//        NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
//        for (int i = 0; i<count; i++) {
//            MJPhoto *photo = [[MJPhoto alloc] init];
//            photo.url = [NSURL URLWithString:self.model.srcArray[i]];
//            [photos addObject:photo];
//        }
//        
//        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
//        browser.currentPhotoIndex = indexPath.item;
//        browser.photos = photos;
//        [browser show];
        if (self.imageclickBlock) {
            self.imageclickBlock(self.model, self.indexPath);
        }
    } else if (collectionView == _tagsView) {
        if ([self.model.theme_type intValue] == 2 || [self.model.theme_type intValue] == 4) {
            NSObject *obj = self.model.tagsArray[indexPath.item];
            if ([obj isKindOfClass:[ShopTagItem class]]) {
                ShopTagItem *item = (ShopTagItem *)obj;
                if (self.tagDressWithStyleClickBlock) {
                    self.tagDressWithStyleClickBlock(item, self.indexPath);
                }
            } else if ([obj isKindOfClass:[TypeTagItem class]]) {
                TypeTagItem *item = (TypeTagItem *)obj;
                if (self.tagDressWithSuppClickBlock) {
                    
                    self.tagDressWithSuppClickBlock(item, self.indexPath,self.model);
                }
            }else if ([obj isKindOfClass:[ShopTypeItem class]])
            {
                ShopTypeItem *item = self.model.tagsArray[indexPath.item];
                if (self.tagThemeClickBlock) {
                    self.tagThemeClickBlock(item, self.indexPath);
                }
            }

        } else if ([self.model.theme_type intValue] == 3) {
            ShopTypeItem *item = self.model.tagsArray[indexPath.item];
            if (self.tagThemeClickBlock) {
                self.tagThemeClickBlock(item, self.indexPath);
            }
        } else if ([self.model.theme_type intValue] == 1) {
            ShopTypeItem *item = [[ShopTypeItem alloc] init];
            item.ID = @"149";
            item.name = @"精选推荐";
            if (self.followTagClickBlock) {
                self.followTagClickBlock(item, self.indexPath);
            }
        }
    } else if (collectionView == _followView) {
        TFShopModel *shopModel = self.model.followArray[indexPath.item];
        if (self.followClickBlock) {
            self.followClickBlock(shopModel, indexPath);
        }
    } else if (collectionView == _TCommentView)
    {
        if (self.commentclickBlock) {
            self.commentclickBlock(self.model, self.indexPath);
        }
    }
}
#pragma mark - Height
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

+ (CGFloat)contentLabelHeightWithCircle:(IntimateCircleModel *)model{
    CGFloat height = 0;
    NSString *text;
    if (model.title.length) {
        text = [NSString stringWithFormat:@"#%@#  %@", model.title, model.content];
    } else {
        text = model.content;
    }
    if (text.length > 0) {
            CGSize size = [self getSizeWithString:text Font:kICcontentFont constrainedToSize:CGSizeMake(KICContent_Width-kICUserInfoHeight-ZOOM6(30), ZOOM6(80) * 2)];
            height += size.height;
    }
    
    return height;
}
+ (CGFloat)contentMediaHeightWithCircle:(IntimateCircleModel *)model
{
    CGFloat contentMediaHeight = 0;
    NSInteger mediaCount = model.srcArray.count;

    if (mediaCount > 0) {
        contentMediaHeight = [IndianaMediaItemSingleCell cellSizeWithObj:model].height;
        /*
        if (mediaCount == 1) {
            contentMediaHeight = [IndianaMediaItemSingleCell cellSizeWithObj:model].height;
        } else {
            if (mediaCount == 2) {
                contentMediaHeight = ([IndianaMediaItemCell cellSizeWithObj:model].height);
            } else if (mediaCount == 4) {
                contentMediaHeight = ceilf((float)mediaCount/2) * ([IndianaMediaItemCell cellSizeWithObj:model].height + ZOOM6(10)) - ZOOM6(10);
            } else {
                contentMediaHeight = ceilf((float)mediaCount/3) * ([IndianaMediaItemCell cellSizeWithObj:model].height + ZOOM6(10)) - ZOOM6(10);
            }
        }
        */
    }
    return contentMediaHeight;
}


+ (CGFloat)cellHeightWithObj:(IntimateCircleModel *)obj {
    CGFloat heigth = 0;
    heigth = kICUserInfoHeight + kICPaddingTopHeight + kICMargin_imgVBottom;
    if (obj.content.length||obj.title.length) {
        heigth += [self contentLabelHeightWithCircle:obj] + kICMargin_contentBottom;
    }
    
    if (obj.srcArray.count) {
        heigth += [self contentMediaHeightWithCircle:obj] + kICMargin_mediaVBottom;
    }
    if (obj.tagsArray.count) {
        
        NSArray *titles = [self gettitleArray:obj];
        CGFloat tagsHeight = 0;
        if(titles.count)
        {
            tagsHeight = [HXTagsView getHeightWithTags:titles layout:nil tagAttribute:nil width:kScreenWidth];
        }
        heigth += (tagsHeight + kICMargin_tagsBtnBottom);
    }
    if (obj.commentArray.count){
        int count = obj.commentArray.count>5?5:(int)obj.commentArray.count;
        heigth += count*ZOOM6(40) +ZOOM6(20)*2;
    }
    
    heigth += KICLikeCommentViewHeight ;
    
    if (obj.followArray.count) {
        heigth += KICFollowViewHeight ;
    }
    heigth += KICBottomViewHeight+ZOOM6(20);
    return heigth;
}

+ (NSArray *)gettitleArray:(IntimateCircleModel*)model
{
    NSMutableArray *tagstitleArray = [NSMutableArray array];
    
    for(int i =0 ;i<model.tagsArray.count;i++)
    {
        IntimateCircleModel *obj = model.tagsArray[i];
        NSString *name = @"";
        if ([obj isKindOfClass:[ShopTagItem class]]) {
            ShopTagItem *item = (ShopTagItem *)obj;
            name = item.tag_name;
            
        } else if ([obj isKindOfClass:[TypeTagItem class]]) {
            TypeTagItem *item = (TypeTagItem *)obj;
            name = item.class_name;
        } else if ([obj isKindOfClass:[ShopTypeItem class]])
        {
            ShopTypeItem *item = (ShopTypeItem*)obj;
            name = item.name;
        }else if ([obj isKindOfClass:[NSString class]]){
            if([obj isEqual:@"精选推荐"])
            {
                name = @"精选推荐";
            }
        }
        name.length>0?[tagstitleArray addObject:name]:nil;
    }
    
    return tagstitleArray;
}

@end
