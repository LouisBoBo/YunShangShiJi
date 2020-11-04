//
//  IndianaMediaItemCell.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/6/2.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalTool.h"
#import "IndianaModel.h"
#import "IntimateCircleModel.h"
#import "UIImageView+WebCache.h"

#define kCellIdentifier_IndianaMediaItem @"IndianaMediaItemCell"

#define kPaddingLeftWidth ZOOM6(30)
#define kPaddingRightWidth ZOOM6(30)

#define kICPaddingLeftWidth ZOOM6(40)
#define kICPaddingRightWidth ZOOM6(40)

#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width

#define kIndianaMediaItemCell_Width ((kScreen_Width-kPaddingLeftWidth-kPaddingRightWidth-20)/3.0)

#define kICMediaItemCell_Width ((kScreen_Width-kICPaddingLeftWidth-kICPaddingRightWidth-ZOOM6(10) * 2)/3.0)
#define kICMediaItemCell2_Width ((kScreen_Width-kICPaddingLeftWidth-kICPaddingRightWidth-ZOOM6(10) * 1)/2.0)


@interface IndianaMediaItemCell : UICollectionViewCell

@property (strong, nonatomic) IndianaModel *curMediaItem;
@property (strong, nonatomic) UIImageView *imgView;
@property (nonatomic, copy) NSString *srcUrl;

- (void)setSrcUrl:(NSString *)srcUrl withCount:(NSInteger)count;

+(CGSize)ccellSizeWithObj:(id)obj;
+(CGSize)cellSizeWithObj:(id)obj;
@end
