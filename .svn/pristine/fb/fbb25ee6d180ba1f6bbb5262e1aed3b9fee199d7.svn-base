//
//  LedBrowseCollocationShopCell.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2016/10/9.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "LedBrowseCollocationShopCell.h"
#import "GlobalTool.h"
#import "UIImageView+WebCache.h"
#import "YFDPImageView.h"
#import "CollocationModel.h"
#import "DefaultImgManager.h"

#define DefaultImg(size) [[DefaultImgManager sharedManager] defaultImgWithSize:(size)]
@interface LedBrowseCollocationShopCell () <YFDPImageViewDelegate>
{
    NSArray *_shopData;
    
    void(^_block)(NSString *shopCode, NSIndexPath *currIndexPath);
}

@property (nonatomic, strong) YFDPImageView *heardImgView;
@end

@implementation LedBrowseCollocationShopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _shopData = nil;
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self addSubview:self.heardImgView];
}

#pragma mark - YFDPImageViewDelegate
- (NSInteger)numberOfTag {
    return _shopData.count;
}

- (void)tagBtn:(YFTagButton *)tagBtn tagForRowAtindex:(NSInteger)index {
    CollocationShopModel *sModel = _shopData[index];
    [tagBtn setTitle:sModel.shop_name
               price:[NSString stringWithFormat:@"¥%.1f",sModel.shop_se_price]
              origin:CGPointMake(sModel.shop_x,sModel.shop_y)
               isImg:!sModel.option_flag
               ispic:sModel.option_flag
                type:index%2];
    // 标签高亮
    if (index == 0) {
        tagBtn.isHighlight = sModel.isHighlight;
    }
}

- (void)imageView:(YFDPImageView *)imageView didSelectRowAtIndex:(NSInteger)index {
    CollocationShopModel *model = _shopData[index];
    if (_block) {
        _block(model.shop_code, self.currIndexPath);
    }
}


- (YFDPImageView *)heardImgView {
    if (nil == _heardImgView) {
        _heardImgView = [[YFDPImageView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth,kScreenWidth) isTriangle:NO isShade:YES isTitle:YES];
        _heardImgView.backgroundColor = lineGreyColor;
        _heardImgView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        _heardImgView.contentMode = UIViewContentModeScaleAspectFill;
        _heardImgView.clipsToBounds = YES;
        _heardImgView.delegate = self;
    }
    return _heardImgView;
}

#pragma mark - 赋值

#pragma mark - 更新数据
- (void)receiveDataModel:(CollocationModel *)model {
    NSString *st = kDevice_Is_iPhone6Plus?@"!450":@"!382";
    NSString *url = [NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],model.collocation_pic,st];
    [_heardImgView setImageWithURL:[NSURL URLWithString:url] placeholderImage:DefaultImg(_heardImgView.bounds.size) progress:nil completed:nil];
    
    
    if ([model.type integerValue] == 2) {
        self.heardImgView.height = kScreen_Width / 1.5;
        
        self.heardImgView.isTopics = YES;
        self.heardImgView.isTitle = NO;
        self.heardImgView.imageViewType = YFDPImageViewType_Topics;
        self.heardImgView.mainTitleLabel.text = model.collocation_name;
        self.heardImgView.subTitleLabel.text = [NSString stringWithFormat:@"【%@】", model.collocation_name2];
    } else {
        self.heardImgView.height = kScreen_Width;
        
        self.heardImgView.isTopics = NO;
        self.heardImgView.isTitle = YES;
        self.heardImgView.imageViewType = YFDPImageViewType_Nomal;
        self.heardImgView.titleLabel.text = model.collocation_name;
        
        _shopData = [model.collocation_shop copy];
        CollocationShopModel *sModel = [model.collocation_shop firstObject];
        sModel.isHighlight = model.isHighlight;
        [self.heardImgView reloadData];
    }
    [self layoutIfNeeded];
}

- (void)setShopCodeBlock:(void (^)(NSString *, NSIndexPath *))block
{
    _block = [block copy];
}

/// cell高度
+ (CGFloat)cellHeight
{
    return kScreenWidth+kZoom6pt(10);
}

+ (CGFloat)cellForTopicsHeight
{
    return kScreen_Width / 1.5 + kZoom6pt(10);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
