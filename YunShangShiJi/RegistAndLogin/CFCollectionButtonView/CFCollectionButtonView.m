//
//  CFCollectionView.m
//  codeTest
//
//  Created by yssj on 2017/2/9.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "CFCollectionButtonView.h"
#import "GlobalTool.h"

@interface CFCollectionButtonViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imgView;  //图片
@property (nonatomic, strong) UILabel *titleLabel;   //标题
@property (nonatomic, strong) UILabel *contentLabel; //价格

@end
@implementation CFCollectionButtonViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-ZOOM6(90))/2, ZOOM6(30), ZOOM6(90), ZOOM6(90))];
        _imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        _imgView.clipsToBounds = YES;
        [self.contentView addSubview:_imgView];
        
//        CGFloat txteHeight = [self heightWithString:@"高" font:[UIFont systemFontOfSize:11] constrainedToWidth:100];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_imgView.frame), frame.size.width, frame.size.height-CGRectGetMaxY(_imgView.frame)-ZOOM6(10))];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithWhite:62.0/255 alpha:1.0];
        _titleLabel.font = [UIFont systemFontOfSize:ZOOM6(32)];
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingHead;
        [self.contentView addSubview:_titleLabel];
        
//        txteHeight = [NSString heightWithString:@"高" font:[UIFont systemFontOfSize:kZoom6pt(14)] constrainedToWidth:100];
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxY(_imgView.frame)-8, _imgView.frame.origin.y, 16, 16)];
        _contentLabel.layer.cornerRadius=8;
        _contentLabel.clipsToBounds=YES;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:_contentLabel];
        
        self.backgroundColor = [UIColor whiteColor];
//        _imgView.backgroundColor = [UIColor brownColor];
//        _titleLabel.backgroundColor=[UIColor brownColor];
        _contentLabel.backgroundColor=[UIColor colorWithRed:255/255.0 green:63/255.0 blue:139/255.0 alpha:255/255.0];
    }
    return self;
}
- (CGFloat)heightWithString:(NSString *)string font:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    CGSize rtSize;
    
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        rtSize = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        return ceil(rtSize.height) + 0.5;
    }
   
}

@end

@interface CFCollectionButtonView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic)  UICollectionViewFlowLayout   *flowLayout;

@end

@implementation CFCollectionButtonView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self setUI];
    }
    return self;
}
- (void)setMessageCount:(NSInteger)messageCount {
    _messageCount=messageCount;
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
}
- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout==nil) {
        //确定是水平滚动，还是垂直滚动
        _flowLayout=[[UICollectionViewFlowLayout alloc] init];
//        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
        _flowLayout.minimumLineSpacing=1;
        _flowLayout.minimumInteritemSpacing=1;
        [_flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //    flowLayout.headerReferenceSize = CGSizeMake(kScreenWidth, ZOOM(570));  //设置head大小
    }
    return _flowLayout;
}
- (UICollectionView *)collectionView {
    if (_collectionView==nil) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:self.flowLayout];
        [_collectionView registerClass:[CFCollectionButtonViewCell class] forCellWithReuseIdentifier:@"CFCollectionButtonViewCell"];
        _collectionView.backgroundColor=[UIColor clearColor];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
    }
    return _collectionView;
}
- (void)setUI {
    
    [self addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDelegates for photos
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(CFCollectionButtonView:numberOfItemsInSection:)]) {
       return [self.delegate CFCollectionButtonView:collectionView numberOfItemsInSection:section];
    }
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CFCollectionButtonViewCell *cell = (CFCollectionButtonViewCell *)[_collectionView dequeueReusableCellWithReuseIdentifier:@"CFCollectionButtonViewCell" forIndexPath:indexPath];
    cell.contentLabel.text=[NSString stringWithFormat:@"%zd",self.messageCount];
    cell.imgView.image=[UIImage imageNamed:self.arr[indexPath.row]];
    cell.titleLabel.text=[self.arr[indexPath.row] substringFromIndex:5];
    cell.contentLabel.hidden=indexPath.row!=0||!self.messageCount;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(didSelectCFCollectionButtonView:)]) {
        [self.delegate didSelectCFCollectionButtonView:indexPath.row];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
        CGFloat width = (self.frame.size.width-3)/4;
        
        return CGSizeMake(width, width);

}

@end
