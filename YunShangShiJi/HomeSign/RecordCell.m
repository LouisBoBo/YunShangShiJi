//
//  RecordCell.m
//  YunShangShiJi
//
//  Created by zgl on 16/7/27.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "RecordCell.h"
#import "GlobalTool.h"
#import "participateModel.h"
#import "ManPicModel.h"

@implementation RecordCell {
    NSMutableArray *images;
    UIImageView *moreImgView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        images = [NSMutableArray array];
        moreImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        moreImgView.image = [UIImage imageNamed:@"icon_more"];
        [self.contentView addSubview:moreImgView];
        moreImgView.hidden = YES;
        [moreImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((ZOOM6(70) + ZOOMPT(10))*5 + ZOOM(50));
            make.width.height.mas_equalTo(ZOOM6(30));
            make.centerY.equalTo(self.contentView.mas_top).offset(ZOOMPT(10) + ZOOM6(35));
        }];
        
        _sharelable = [[UILabel alloc]initWithFrame:CGRectZero];
        _sharelable.font = [UIFont systemFontOfSize:ZOOM(43)];
        _sharelable.textColor = kTextColor;
        [self.contentView addSubview:_sharelable];
        [_sharelable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-ZOOM(50));
            make.centerY.equalTo(self.contentView.mas_top).offset(ZOOMPT(10) + ZOOM6(35));
        }];
    }
    return self;
}

- (void)setData:(ManPicDataModel *)data {
    [images makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [images removeAllObjects];
    
    NSArray *array = [data.head_pic componentsSeparatedByString:@","];
    
    int count = 0;
    if(array.count <=5)
    {
        count = (int)array.count;
    }else{
        count = 5;
    }
    
    CGFloat space = ZOOMPT(10);
    for(int i = 0; i <= count-1; i++)
    {
        NSString *imgUrl = array[i];
        UIImageView *headimag = [[UIImageView alloc]initWithFrame:CGRectMake((space + ZOOM6(70))*(count - i - 1) + ZOOM(50), ZOOMPT(10), ZOOM6(70), ZOOM6(70))];
        
        if([imgUrl hasPrefix:@"http"])
        {
            [headimag sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
        }else{
            if (data.flag == 0) {
                [headimag sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],imgUrl]]];
            } else {
               [headimag sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],imgUrl]]];
            }
        }
        headimag.clipsToBounds = YES;
        headimag.layer.cornerRadius = headimag.frame.size.width/2;
        [self.contentView addSubview:headimag];
        [images addObject:headimag];
    }
    
    moreImgView.hidden = count < 5;
}

@end
