//
//  TFShareRewardDetailVC.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/9/23.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFBaseViewController.h"

@interface TFShareRewardDetailVC : TFBaseViewController

@end


@interface HeadImageVM : PublicViewModel

@property (nonatomic, strong)TFCollectionViewService *headImageService;

- (void)handleDataWithSuccess:(void (^)(NSArray *haedImageArray, Response *response))success failure:(void(^)(NSError *error))failure;
@end

@interface HeadImageM : PublicModel
@property (nonatomic, copy) NSString *pic;

@end

@interface TFHeadImageServiceCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageV;
@end
