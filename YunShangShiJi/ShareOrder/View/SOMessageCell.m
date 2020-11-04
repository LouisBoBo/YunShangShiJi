//
//  SOMessageCell.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/2.
//  Copyright © 2016年 ios-1. All rights reserved.
//  评论

#import "SOMessageCell.h"
#import "GlobalTool.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface SOMessageCell ()
{
    NSString *_reuserID;
    NSString *_nickName;
    void (^_btnBlock)(NSString *reuserID, NSString *message); // 回复按钮点击回调
}
@property (nonatomic, strong) UIImageView *iconImgView; // 头像
@property (nonatomic, strong) UILabel *nickLabel; // 昵称
@property (nonatomic, strong) UILabel *timeLabel; // 发布时间
@property (nonatomic, strong) UILabel *contentLabel; // 留言内容
@property (nonatomic, strong) UIImageView *messageImg; // 回复图标
@property (nonatomic, strong) UIButton *messageBtn; // 回复按钮

@end

@implementation SOMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.iconImgView];
        [self.contentView addSubview:self.nickLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.messageImg];
        [self.contentView addSubview:self.messageBtn];
        [self.contentView addSubview:self.contentLabel];
        [self autoLayout];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark - 自动布局
- (void)autoLayout {
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kZoom6pt(10)));
        make.left.equalTo(@(kZoom6pt(15)));
        make.width.height.equalTo(@(kZoom6pt(30)));
    }];
    
    [_nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImgView.mas_right).offset(kZoom6pt(10));
        make.centerY.equalTo(_iconImgView);
        make.width.lessThanOrEqualTo(@(kZoom6pt(230)));
    }];
    
    [_messageImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(kZoom6pt(-15)));
        make.height.equalTo(@(kZoom6pt(18)));
        make.width.equalTo(@(kZoom6pt(18)));
        make.centerY.equalTo(_iconImgView);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_messageImg.mas_left).offset(kZoom6pt(-12));
        make.centerY.equalTo(_iconImgView);
    }];
    
    [_messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timeLabel);
        make.right.equalTo(_messageImg);
        make.top.bottom.equalTo(_iconImgView);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nickLabel);
        make.right.equalTo(_messageImg);
        make.bottom.equalTo(@kZoom6pt(-10));
    }];
}

#pragma mark - 点击事件
- (void)btnClick:(UIButton *)sender {
    if (_btnBlock) {
        _btnBlock(_reuserID,_nickName);
    }
}

#pragma mark - 更新数据
- (void)receiveDataModel:(ReplyModel *)model btnBlock:(void (^)(NSString *, NSString *))btnBlock{
    _btnBlock = btnBlock;
    _reuserID = model.reuser_id;
    _nickName = model.user_name;
    
    NSURL *url = nil;
    if ([model.user_url hasPrefix:@"http"]) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.user_url]];
    } else {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.user_url]];
    }
    
    [_iconImgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default"]];
    
    NSString *nick = model.to_user_name?[NSString stringWithFormat:@"%@回复%@",model.user_name,model.to_user_name]:model.user_name;
    _nickLabel.attributedText = [NSString getOneColorInLabel:nick ColorString:@"回复" Color:kTextColor fontSize:kZoom6pt(14)];
    _timeLabel.text = [NSString getTimeStyle:TimeStrStyleArticle time:model.add_date/1000];
    _contentLabel.text = model.content?:@"";
}

#pragma mark - getter方法
- (UIImageView *)iconImgView {
    if (nil == _iconImgView) {
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.clipsToBounds = YES;
        _iconImgView.layer.cornerRadius = kZoom6pt(15);
    }
    return _iconImgView;
}

- (UILabel *)nickLabel {
    if (nil == _nickLabel) {
        _nickLabel = [[UILabel alloc] init];
        _nickLabel.textColor = UIColorHex(0xFF448E);
        _nickLabel.font = [UIFont systemFontOfSize:kZoom6pt(14)];
        _nickLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nickLabel;
}

- (UILabel *)timeLabel {
    if (nil == _timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = UIColorHex(0x7D7D7D);
        _timeLabel.font = [UIFont systemFontOfSize:kZoom6pt(10)];
        _nickLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}

- (UIButton *)messageBtn {
    if (nil == _messageBtn) {
        _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_messageBtn setBackgroundColor:[UIColor clearColor]];
        [_messageBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _messageBtn;
}

- (UIImageView *)messageImg {
    if (nil == _messageImg) {
        _messageImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_huifu"]];
    }
    return _messageImg;
}

- (UILabel *)contentLabel {
    if (nil == _contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = UIColorHex(0x3E3E3E);
        _contentLabel.font = [UIFont systemFontOfSize:kZoom6pt(14)];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
