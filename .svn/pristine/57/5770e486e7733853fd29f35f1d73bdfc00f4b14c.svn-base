//
//  HHContentCollectionView.h
//  HHHorizontalPagingView
//
//  Created by Huanhoo on 15/7/16.
//  Copyright (c) 2015年 Huanhoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicdetailsModel.h"
@interface HHContentCollectionView : UICollectionView

@property (nonatomic , assign) NSInteger pageIndex;               //当前界面
@property (nonatomic , copy)   NSString *theme_id;                //帖子ID
@property (nonatomic , assign) NSInteger currPage;                //当前页
@property (nonatomic , strong) NSMutableArray *remenComments;     //热门评论
@property (nonatomic , strong) NSMutableArray *newestComments;    //最新评论

@property (nonatomic , strong) void(^celldidSelectBlock)(NSIndexPath *indexpath,NSString *commentID);

+ (HHContentCollectionView *)contentCollectionView;
- (void)reloadData:(NSString *)theme_id DetailModel:(TopicdetailsModel*)model PageIndex:(NSInteger)pageindex;
@end
