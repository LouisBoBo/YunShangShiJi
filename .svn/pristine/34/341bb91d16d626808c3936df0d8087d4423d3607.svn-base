//
//  HHContentCollectionView.m
//  HHHorizontalPagingView
//
//  Created by Huanhoo on 15/7/16.
//  Copyright (c) 2015年 Huanhoo. All rights reserved.
//

#import "HHContentCollectionView.h"
#import "TFShoppingViewController.h"
#import "TopicPublicModel.h"
#import "LastCommentsModel.h"
#import "LreplistModel.h"
#import "GlobalTool.h"
#import "FaceBoard.h"

#import "RemenComtCollectionViewCell.h"
#import "CommentCollectionViewCell.h"
@interface HHContentCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate,CelldidselectDelegate>

@end

@implementation HHContentCollectionView
{
     FaceBoard *faceBoard;
}
static NSString *collectionViewCellIdentifier = @"collectionViewCell";

- (void)reloadData:(NSString *)theme_id DetailModel:(TopicdetailsModel*)model PageIndex:(NSInteger)pageindex
{
    self.currPage =1;
    self.theme_id = theme_id;
    
    if(pageindex == 0)
    {
        [self newestComentData:theme_id];
    }else{
//        [self LandlordHttp:theme_id Model:model];
    }
    
}
//最新评论
- (void)newestComentData:(NSString*)theme_id
{
    [TopicPublicModel LastComments:(NSString*)theme_id Page:self.currPage Pagesize:10 Success:^(id data) {
        [self headerEndRefreshing];
        [self footerEndRefreshing];
        [self ffRefreshHeaderEndRefreshing];
        
        TopicPublicModel *model = data;
        if(model.status == 1 && model.list.count)
        {
            self.currPage ++;
            [self chareModel:model.list Type:2];
            [self reloadData];
        }else{
            [self reloadData];
        }
    }];
    
}
//只看楼主
- (void)LandlordHttp:(NSString*)theme_id Model:(TopicdetailsModel*)datamodel
{
    [self.remenComments removeAllObjects];
    [self.newestComments removeAllObjects];
    
    [TopicPublicModel LandlordComments:theme_id Theme_user_id:datamodel.post_details.user_id Page:self.currPage Pagesize:5 Success:^(id data) {
        TopicPublicModel *model = data;
        if(model.status == 1)
        {
//            self.currPage ++;
//            self.landlordPage = [model.pager[@"pageCount"] integerValue];
            model.hotlist.count?[self chareModel:model.hotlist Type:1]:nil;
            model.list.count?[self chareModel:model.list Type:2]:nil;
            [self reloadData];
        }else{
            [self reloadData];
        }
    }];
}

//1热门评论 2最新评论
- (void)chareModel:(NSArray*)dataArray Type:(NSInteger)type
{
    for(int i =0 ;i<dataArray.count;i++)
    {
        CGFloat headHeigh =0;
        CGFloat cellHeigh =0;
        LastCommentsModel *commentModel = dataArray[i];
        
        //head
        headHeigh = [self getRowHeight:commentModel.content fontSize:ZOOM6(34)];
        
        //cell
//        int count = commentModel.replies_list.count >4?4:(int)commentModel.replies_list.count;
        for(int j =0;j<commentModel.replies_list.count;j++)
        {
            LreplistModel *replymodel = commentModel.replies_list[j];
            CGFloat H = [self getRowHeight:replymodel.content fontSize:ZOOM6(34)];
//            CGFloat H = ZOOM6(50);
            replymodel.cellheigh = H;
            cellHeigh +=H;
        }
        commentModel.replyCellHeigh = cellHeigh;
        commentModel.replyHeadHeigh = headHeigh;
        
//        type==1?[self.remenComments addObject:commentModel]:[self.newestComments addObject:commentModel];
        if(type == 1)
        {
            [self.remenComments addObject:commentModel];
        }else{
            NSString *user_id = [[NSUserDefaults standardUserDefaults]objectForKey:USER_ID];
            if(commentModel.status.intValue==0 || (commentModel.status.intValue == 1 && user_id.intValue == commentModel.user_id.intValue))
            {
                [self.newestComments addObject:commentModel];
            }
        }
    }
    
}
#pragma mark *********************CollectionView************************
+ (HHContentCollectionView *)contentCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    layout.itemSize = CGSizeMake(kScreenWidth-10, 60);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    HHContentCollectionView *collectionView = [[HHContentCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.dataSource = collectionView;
    collectionView.delegate = collectionView;
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectionViewCellIdentifier];
    
    [collectionView registerNib:[UINib nibWithNibName:@"RemenComtCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"RemenCell"];

    [collectionView registerNib:[UINib nibWithNibName:@"CommentCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CommentCell"];

     __weak HHContentCollectionView *weakCollect= collectionView;
    //下拉刷新
    [weakCollect addHeaderWithCallback:^{
        [weakCollect.remenComments removeAllObjects];
        [weakCollect.newestComments removeAllObjects];
        
        weakCollect.currPage = 1;
        [weakCollect newestComentData:weakCollect.theme_id];
    }];
    
    //上拉加载
    [weakCollect addFooterWithCallback:^{
       
        [weakCollect newestComentData:weakCollect.theme_id];
    }];

    return collectionView;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    int count = 0;
    if(self.remenComments.count)
    {
        count += self.remenComments.count+1;
        
        if(self.newestComments.count)
        {
            count += self.newestComments.count+1;
        }
        
    }else{
        if(self.newestComments.count)
        {
            count += self.newestComments.count;
        }
    }
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(self.remenComments.count)
    {
        if(indexPath.item == 0 || indexPath.item == self.remenComments.count+1)
        {
            RemenComtCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RemenCell" forIndexPath:indexPath];
            indexPath.item ==0?[cell refreshTitle:@"热门评论"]:[cell refreshTitle:@"最新评论"];
            return cell;
        }else{
            
            CommentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CommentCell" forIndexPath:indexPath];
            cell.delegate = self;
            LastCommentsModel *model ;
            if(indexPath.item < self.remenComments.count+1)
            {
                model = self.remenComments[indexPath.item-1];
            }else{
                model = self.newestComments[indexPath.item-(self.remenComments.count +1)- 1];
            }
            [cell refreshData:model Indexpath:indexPath];
            
            return cell;
            
        }
    }else{
        CommentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CommentCell" forIndexPath:indexPath];
        if(self.newestComments.count)
        {
            cell.delegate = self;
            LastCommentsModel *model = self.newestComments[indexPath.row];
            [cell refreshData:model Indexpath:indexPath];
        }
        return cell;
    }

}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.remenComments.count)
    {
        if(indexPath.item == 0 || indexPath.item == self.remenComments.count+1)
        {
            return CGSizeMake(kScreenWidth, ZOOM6(50));
        }else{
            
            LastCommentsModel *model ;
            if(indexPath.item < self.remenComments.count+1)
            {
                model = self.remenComments[indexPath.item-1];
            }else{
                model = self.newestComments[indexPath.item-(self.remenComments.count +1)- 1];
            }
            
            return CGSizeMake(kScreenWidth, 55 +model.replyCellHeigh+model.replyHeadHeigh+ZOOM6(20));
        }
    }else{
        LastCommentsModel* model = self.newestComments[indexPath.item];
        return CGSizeMake(kScreenWidth, 55 +model.replyCellHeigh+model.replyHeadHeigh+ZOOM6(20));
    }
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * receive_user_id = @"";
    if(self.remenComments.count)
    {
        if(indexPath.item == 0 || indexPath.item == self.remenComments.count+1)
        {
            
        }else{
            
            LastCommentsModel *commentmodel ;
            
            if(self.remenComments.count)
            {
                if(indexPath.item <self.remenComments.count+1)
                {
                    commentmodel = self.remenComments[indexPath.item-1];
                    receive_user_id = commentmodel.user_id;
                }else{
                    
                    commentmodel = self.newestComments[indexPath.item-2-self.remenComments.count];
                    receive_user_id = commentmodel.user_id;
                }
            }else{
                commentmodel = self.newestComments[indexPath.item];
                receive_user_id = commentmodel.user_id;
            }
            
//            if(is_reply ==YES)
//            {
//                receive_user_id = replistmodel.send_user_id;
//            }else{
//                receive_user_id = @"";
//            }
        }
    }else{
        receive_user_id = @"";
        
    }

    if(self.celldidSelectBlock)
    {
        self.celldidSelectBlock(indexPath,receive_user_id);
    }
}


#pragma mark 获取文本高度
-(CGFloat)getRowHeight:(NSString *)text fontSize:(CGFloat)fontSize
{
    //文字高度
    CGFloat height;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(kScreenWidth-2*ZOOM6(20), 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
    }
    
    if(height < ZOOM6(50))
    {
        return  ZOOM6(50);
    }else{
        return height;
    }
    return 0;
}

- (NSMutableArray*)remenComments
{
    if(_remenComments == nil)
    {
        _remenComments = [NSMutableArray array];
    }
    
    return _remenComments;
}
- (NSMutableArray*)newestComments
{
    if(_newestComments == nil)
    {
        _newestComments = [NSMutableArray array];
    }
    
    return _newestComments;
}
@end
