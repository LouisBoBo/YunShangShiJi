//
//  CommendCollectionViewCell.h
//  TestStickHeader
//
//  Created by ios-1 on 2017/2/15.
//  Copyright © 2017年 liqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Relatedrecommended.h"
#import "XRWaterfallLayout.h"

@interface CommendCollectionViewCell : UICollectionViewCell<UICollectionViewDelegate,UICollectionViewDataSource,XRWaterfallLayoutDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *labelline;


/*************************************************************/
@property (nonatomic, strong) UICollectionView *collectionView;
//@property (nonatomic, strong) NSMutableArray<XRImage *> *images;

@property (strong, nonatomic) NSMutableArray *recommendData;     //相关推荐数据
@property (nonatomic, assign) BOOL isFresh;
@property (strong, nonatomic) void(^RelevantBlock)(NSInteger index);

- (void)refreshData:(Relatedrecommended*)model;
- (void)refreshimageData:(NSMutableArray*)imageArray isfresh:(BOOL)infresh;
@end
