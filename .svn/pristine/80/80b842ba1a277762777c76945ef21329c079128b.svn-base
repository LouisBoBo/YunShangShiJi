//
//  CommentCollectionViewCell.h
//  TestStickHeader
//
//  Created by ios-1 on 2017/2/15.
//  Copyright © 2017年 liqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LastCommentsModel.h"
#import "LreplistModel.h"

@protocol CelldidselectDelegate <NSObject>
- (void)didselect:(LreplistModel*)model Indexpath:(NSIndexPath*)indexPath;
- (void)fabulous:(LreplistModel*)model Indexpath:(NSIndexPath*)indexPath;
@end

@interface CommentCollectionViewCell : UICollectionViewCell<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIImageView *vipico;
@property (strong, nonatomic) IBOutlet UIImageView *headimge;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UIButton *FabulousBtn;
@property (strong, nonatomic) IBOutlet UILabel *fabulousNum;

@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) UILabel *spaceLine;
@property (nonatomic , strong) NSMutableArray *replyDataArray;
@property (nonatomic , strong) LastCommentsModel *topicModel;
@property (nonatomic , weak) id<CelldidselectDelegate>delegate;
@property (nonatomic , strong) NSIndexPath *curruntIndexPath;

@property (nonatomic , strong) void(^fabulousBlock)(NSInteger fabulousNum);
- (void)refreshData:(LastCommentsModel*)model Indexpath:(NSIndexPath*)indexPath;
@end
