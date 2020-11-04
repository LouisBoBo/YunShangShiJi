//
//  CommendCollectionViewCell.m
//  TestStickHeader
//
//  Created by ios-1 on 2017/2/15.
//  Copyright © 2017年 liqi. All rights reserved.
//

#import "CommendCollectionViewCell.h"
#import "HotOutfitViewController.h"
#import "UIImageView+WebCache.h"
#import "TopicPublicModel.h"
#import "GlobalTool.h"

#import "HotTopicCollectionViewCell.h"
@implementation CommendCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headImage.image = [UIImage imageNamed:@"girl"];
    self.title.textColor = RGBCOLOR_I(62, 62, 62);
    self.title.font = [UIFont systemFontOfSize:ZOOM6(30)];
    
    self.time.textColor = RGBCOLOR_I(168, 168, 168);
    self.time.font = [UIFont systemFontOfSize:ZOOM6(24)];
    
    self.labelline.backgroundColor = RGBCOLOR_I(229, 229, 229);
}
- (void)dealloc
{
    NSLog(@"释放了");
}

- (void)refreshimageData:(NSMutableArray*)imageArray isfresh:(BOOL)infresh
{
    self.recommendData = imageArray;
    
    if(infresh)
    {
        self.collectionView.frame = CGRectMake(0, 0, kScreenWidth, self.frame.size.height);
        [self.collectionView reloadData];
        
//        [self.collectionView removeFromSuperview];
//        self.collectionView = nil;
//        [self.contentView addSubview:self.collectionView];
        
        [self AutoArc];
        
    }else{
        [self.contentView addSubview:self.collectionView];
        
    }
}

//手动删除多余的cell 清理内存
- (void)AutoArc
{
    NSArray *visiblePaths = [self.collectionView indexPathsForVisibleItems];
    if (!visiblePaths.count || visiblePaths.count < 20) {
        return;
    }
    NSIndexPath *fistindexPath=visiblePaths[0];
    NSIndexPath *lastindexPath=visiblePaths[0];
    for (int i=0;i<fistindexPath.row;i++){
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:i inSection:0];
        HotTopicCollectionViewCell *cell =(HotTopicCollectionViewCell *) [self.collectionView cellForItemAtIndexPath:indexPath];
        if(cell)
        {
            for (UIView *view in cell.subviews) {
                [view removeFromSuperview];
            }
            cell=nil;
        }
    }
    for (int i=(int)lastindexPath.item;i<self.recommendData.count;i++){
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:i inSection:0];
        HotTopicCollectionViewCell *cell =(HotTopicCollectionViewCell *) [self.collectionView cellForItemAtIndexPath:indexPath];
        if(cell)
        {
            for (UIView *view in cell.subviews) {
                [view removeFromSuperview];
            }
            cell=nil;
        }
    }
    
}

- (void)refreshData:(Relatedrecommended*)model
{
    
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
    [self.headImage sd_setImageWithURL:url];

    self.title.frame = CGRectMake(self.title.frame.origin.x, self.title.frame.origin.y, self.title.frame.size.width, [self getRowHeight:model.content fontSize:ZOOM6(30)]);
    self.title.text = [NSString stringWithFormat:@"%@",model.content];
    NSString *date = [MyMD5 timeWithTimeIntervalString:model.send_time];
    self.time.text = [NSString stringWithFormat:@"%@",date];
    
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
    
    if(height < ZOOM6(40))
    {
        return  ZOOM6(35);
    }else{
        return  ZOOM6(80);
    }
    return 0;
}
/*************************************************************/

- (UICollectionView*)collectionView
{
    if(_collectionView == nil)
    {
        //创建瀑布流布局
        XRWaterfallLayout *waterfall = [XRWaterfallLayout waterFallLayoutWithColumnCount:2];
        
        //或者一次性设置
        [waterfall setColumnSpacing:5 rowSpacing:5 sectionInset:UIEdgeInsetsMake(0, 5, 0, 5)];
        
        //设置代理，实现代理方法
        waterfall.delegate = self;
        
        /*
         //或者设置block
         [waterfall setItemHeightBlock:^CGFloat(CGFloat itemWidth, NSIndexPath *indexPath) {
         //根据图片的原始尺寸，及显示宽度，等比例缩放来计算显示高度
         XRImage *image = self.images[indexPath.item];
         return image.imageH / image.imageW * itemWidth;
         }];
         */
        //创建collectionView
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.frame.size.height) collectionViewLayout:waterfall];
        _collectionView.backgroundColor = RGBCOLOR_I(239, 239, 239);
        [_collectionView registerNib:[UINib nibWithNibName:@"HotTopicCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HotCell"];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = NO;
    }
    
    return _collectionView;
}

//根据item的宽度与indexPath计算每一个item的高度
- (CGFloat)waterfallLayout:(XRWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath {
    
    IntimateCircleModel *model = self.recommendData[indexPath.item];
    
    CGFloat itemwidth = (kScreenWidth - 15)/2;
    CGFloat imageSize = 0;
    
    if(model.theme_type.intValue == 1)
    {
        imageSize = 0.67;
    }else{
        NSString *str = model.pics;
        NSArray *imageArr = [str componentsSeparatedByString:@","];
        NSString *imagestr = @"";
        
        if(imageArr.count)
        {
            imagestr = imageArr[0];
            NSArray *arr = [imagestr componentsSeparatedByString:@":"];
            if(arr.count == 2)
            {
                imageSize = ([arr[1] floatValue]<0.56)?0.56:[arr[1] floatValue];
            }
        }
    }
    
    if(imageSize >0)
    {
        return itemwidth/imageSize +50+ZOOM6(90);
    }
    return 0;

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.recommendData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HotTopicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.bigImage.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height-50-ZOOM6(90));
    IntimateCircleModel *model = self.recommendData[indexPath.item];
    [cell refreshCircleData:model];
    
    NSString *them_id = [NSString stringWithFormat:@"%@",model.theme_id];
    kWeakSelf(cell);
    cell.likeBlock = ^(NSInteger num){
        
        if(weakcell.like.selected)//取消点赞
        {
            [TopicPublicModel DisThumbstData:1 This_id:them_id Theme_id:them_id Success:^(id data) {
                TopicPublicModel *model = data;
                if(model.status == 1)
                {
                    weakcell.like.selected = !weakcell.like.selected;
                    
                    if(num >0)
                    {
                        [weakcell.like setTitle:[NSString stringWithFormat:@"%d",(int)num-1] forState:UIControlStateNormal];
                        
                        [weakcell.like setTitleColor:RGBCOLOR_I(168, 168, 168) forState:UIControlStateNormal];
                    }
                }
            }];
        }else{//点赞
            
            [TopicPublicModel ThumbstData:1 This_id:them_id Theme_id:them_id Success:^(id data) {
                TopicPublicModel *model = data;
                if(model.status == 1)
                {
                    weakcell.like.selected = !weakcell.like.selected;
                    
                    [weakcell.like setTitle:[NSString stringWithFormat:@"%d",(int)num+1] forState:UIControlStateNormal];
                    
                    [weakcell.like setTitleColor:tarbarrossred forState:UIControlStateNormal];
                }
                
            }];
        }
    };
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.RelevantBlock)
    {
        self.RelevantBlock(indexPath.item);
    }
}

- (NSMutableArray*)recommendData
{
    if(_recommendData == nil)
    {
        _recommendData = [NSMutableArray array];
    }
    return _recommendData;
}
@end
