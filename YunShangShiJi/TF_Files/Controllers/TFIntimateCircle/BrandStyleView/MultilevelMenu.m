//
//  MultilevelMenu.m
//  MultilevelMenu
//
//  Created by gitBurning on 15/3/13.
//  Copyright (c) 2015年 BR. All rights reserved.
//

#import "MultilevelMenu.h"
#import "MultilevelTableViewCell.h"
//#import "MultilevelCollectionViewCell.h"
//#import "UIImageView+WebCache.h"
#import "GlobalTool.h"

#define kCellRightLineTag 100
#define kCellHeight ZOOM6(120)
#define kImageDefaultName @"tempShop"
#define kMultilevelCollectionViewCell @"MultilevelCollectionViewCell"
#define kMultilevelCollectionHeader   @"CollectionHeader"//CollectionHeader
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
//#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface StyleCollectionCell : UICollectionViewCell
@property (strong, nonatomic) UILabel *titile;
@property (strong, nonatomic) UIView *line;
@property (strong, nonatomic) UIImageView *selectImg;

@end
@implementation StyleCollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        [self addSubview:self.titile];
        [self addSubview:self.line];
        [self addSubview:self.selectImg];
    }
    return self;
}
- (UIView *)line {
    if (_line==nil) {
        _line=[[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
    }
    return _line;
}
- (UILabel *)titile {
    if (_titile==nil) {
        _titile=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _titile.textAlignment=NSTextAlignmentCenter;
        _titile.font=[UIFont systemFontOfSize:16];
        _titile.textColor=kSubTitleColor;
    }
    return _titile;
}
- (UIImageView *)selectImg {
    if (_selectImg==nil) {
        _selectImg=[[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-ZOOM6(60), self.frame.size.height/2-ZOOM6(18), ZOOM6(38), ZOOM6(38))];
        _selectImg.image=[UIImage imageNamed:@"类目选中"];
        _selectImg.hidden=YES;
    }
    return _selectImg;
}
@end

@interface MultilevelMenu()
@property(assign,nonatomic,getter=kLeftWidth)CGFloat kLeftWidth;
@property(strong,nonatomic ) UITableView * leftTablew;
@property(strong,nonatomic ) UICollectionView * rightCollection;

@property(assign,nonatomic) BOOL isReturnLastOffset;

@end

@implementation MultilevelMenu

@synthesize kLeftWidth=kLeftWidth;

-(instancetype)initWithFrame:(CGRect)frame WithData:(NSArray *)data withSelectIndex:(void (^)(NSInteger, NSInteger, id))selectIndex
{
    self=[super initWithFrame:frame];
    if (self) {
        if (data.count==0) {
            return nil;
        }
        
        
        self.leftSelectColor     = [UIColor colorWithRed:255/255.0 green:63/255.0 blue:139/255.0 alpha:255/255.0];
        self.leftUnSelectBgColor   = [UIColor whiteColor];
        self.leftBgColor         = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        self.leftSeparatorColor  = UIColorFromRGB(0xE5E5E5);
        self.leftSelectBgColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        self.leftUnSelectColor   = kSubTitleColor;
        
        _block          = selectIndex;
        _selectIndex    = 0;
        _allData        = data;
        kLeftWidth = frame.size.width/2;
        
        /**
         左边的视图
        */
        self.leftTablew=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kLeftWidth, frame.size.height)];
        self.leftTablew.dataSource=self;
        self.leftTablew.delegate=self;
        [self.leftTablew registerNib:[UINib nibWithNibName:@"MultilevelTableViewCell" bundle:nil] forCellReuseIdentifier:@"MultilevelTableViewCell"];
        self.leftTablew.tableFooterView=[[UIView alloc] init];
        [self addSubview:self.leftTablew];
        self.leftTablew.backgroundColor=self.leftBgColor;
        if ([self.leftTablew respondsToSelector:@selector(setLayoutMargins:)]) {
            self.leftTablew.layoutMargins=UIEdgeInsetsZero;
        }
        if ([self.leftTablew respondsToSelector:@selector(setSeparatorInset:)]) {
            self.leftTablew.separatorInset=UIEdgeInsetsZero;
        }
        self.leftTablew.separatorColor=self.leftSeparatorColor;
        self.leftTablew.showsHorizontalScrollIndicator = NO;
        self.leftTablew.showsVerticalScrollIndicator = NO;
        
        
        /**
         右边的视图
         */
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        flowLayout.minimumInteritemSpacing  =0.f;//左右间隔
        flowLayout.minimumLineSpacing       =0.f;
        
        float leftMargin = 0;
        self.rightCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(kLeftWidth+leftMargin,0,frame.size.width-kLeftWidth-leftMargin*2,frame.size.height) collectionViewLayout:flowLayout];
        
        self.rightCollection.delegate   = self;
        self.rightCollection.dataSource = self;
        
        //标签cell
//        UINib *nib=[UINib nibWithNibName:kMultilevelCollectionViewCell bundle:nil];
//        [self.rightCollection registerNib: nib forCellWithReuseIdentifier:kMultilevelCollectionViewCell];
        [self.rightCollection registerClass:[StyleCollectionCell class] forCellWithReuseIdentifier:kMultilevelCollectionViewCell];
        
        //header，此处为图片
        UINib *header=[UINib nibWithNibName:kMultilevelCollectionHeader bundle:nil];
        [self.rightCollection registerNib:header forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kMultilevelCollectionHeader];
        
        [self addSubview:self.rightCollection];
        
      
        self.isReturnLastOffset = YES;
        
        self.rightCollection.backgroundColor = self.leftSelectBgColor;


        self.backgroundColor=self.leftSelectBgColor;
        
    }
    return self;
}

-(void)setNeedToScorllerIndex:(NSInteger)needToScorllerIndex{
    
        /**
         *  滑动到 指定行数
         */
        [self.leftTablew selectRowAtIndexPath:[NSIndexPath indexPathForRow:needToScorllerIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];

        _selectIndex=needToScorllerIndex;
        
        [self.rightCollection reloadData];

    _needToScorllerIndex=needToScorllerIndex;
}
-(void)setLeftBgColor:(UIColor *)leftBgColor{
    _leftBgColor=leftBgColor;
    self.leftTablew.backgroundColor=leftBgColor;
   
}
-(void)setLeftSelectBgColor:(UIColor *)leftSelectBgColor{
    
    _leftSelectBgColor = leftSelectBgColor;
    self.rightCollection.backgroundColor = leftSelectBgColor;
    
    self.backgroundColor=leftSelectBgColor;
}
-(void)setLeftSeparatorColor:(UIColor *)leftSeparatorColor{
    _leftSeparatorColor=leftSeparatorColor;
    self.leftTablew.separatorColor=leftSeparatorColor;
}
-(void)reloadData{
    
    [self.leftTablew reloadData];
    [self.rightCollection reloadData];
    
}
-(void)setLeftTablewCellSelected:(BOOL)selected withCell:(MultilevelTableViewCell*)cell
{
//    UILabel * line=(UILabel*)[cell viewWithTag:kCellRightLineTag];
    if (selected) {
        
//        line.backgroundColor    = cell.backgroundColor;
        cell.titile.textColor   = self.leftSelectColor;
        cell.backgroundColor    = self.leftSelectBgColor;
    }
    else{
        cell.titile.textColor   = self.leftUnSelectColor;
        cell.backgroundColor    = self.leftUnSelectBgColor;
//        line.backgroundColor    = _leftTablew.separatorColor;
    }
   

}

#pragma mark---左边的tablew 代理
#pragma mark--deleagte
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.allData.count;
   
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * Identifier=@"MultilevelTableViewCell";
    MultilevelTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
//    if (!cell) {
//        cell=[[NSBundle mainBundle] loadNibNamed:@"MultilevelTableViewCell" owner:self options:nil][0];
//        
//        UILabel * label=[[UILabel alloc] initWithFrame:CGRectMake(kLeftWidth-0.5, 0, 0.5, 44)];
//        label.backgroundColor=tableView.separatorColor;
//        [cell addSubview:label];
//        label.tag=kCellRightLineTag;
//    }
    
    cell.titile.font=[UIFont systemFontOfSize:ZOOM6(32)];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    rightMeun * title=self.allData[indexPath.row];
    
    cell.titile.text=title.meunName;
    
    
    if (indexPath.row == self.selectIndex) {
        [self setLeftTablewCellSelected:YES withCell:cell];
    }
    else{
        [self setLeftTablewCellSelected:NO withCell:cell];
    }
    

    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins=UIEdgeInsetsZero;
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset=UIEdgeInsetsZero;
    }
    
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kCellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MultilevelTableViewCell * cell=(MultilevelTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
   
    _selectIndex=indexPath.row;
    
    [self setLeftTablewCellSelected:YES withCell:cell];

    rightMeun * title = self.allData[indexPath.row];
    
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    self.isReturnLastOffset=NO;
    
    
    [self.rightCollection reloadData];

    //判断是否滑动tableView
    if (self.isRecordLastScroll) {
        [self.rightCollection scrollRectToVisible:CGRectMake(0, title.offsetScorller, self.rightCollection.frame.size.width, self.rightCollection.frame.size.height) animated:self.isRecordLastScrollAnimated];
    }
    else{
        
         [self.rightCollection scrollRectToVisible:CGRectMake(0, 0, self.rightCollection.frame.size.width, self.rightCollection.frame.size.height) animated:self.isRecordLastScrollAnimated];
    }
    

}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    MultilevelTableViewCell * cell=(MultilevelTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
//    cell.titile.textColor=self.leftUnSelectColor;
//    UILabel * line=(UILabel*)[cell viewWithTag:100];
//    line.backgroundColor=tableView.separatorColor;

    [self setLeftTablewCellSelected:NO withCell:cell];

    cell.backgroundColor=self.leftUnSelectBgColor;
}

#pragma mark---imageCollectionView--------------------------

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    
    if (self.allData.count==0) {
        return 0;
    }
    
    rightMeun * title=self.allData[self.selectIndex];
     return   title.nextArray.count;
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    rightMeun * title=self.allData[self.selectIndex];
    if (title.nextArray.count>0) {
        
        rightMeun *sub=title.nextArray[section];
        
        if (sub.nextArray.count==0)//没有下一级
        {
            return 1;
        }
        else
            return sub.nextArray.count;
        
    }
    else{
    return title.nextArray.count;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    StyleCollectionCell *cell = (StyleCollectionCell *)[_rightCollection cellForItemAtIndexPath:indexPath];
    cell.selectImg.hidden=NO;
    
    rightMeun * title=self.allData[self.selectIndex];
    NSArray * list;
    
    
    
    rightMeun * meun;
    
    meun=title.nextArray[indexPath.section];
    
    if (meun.nextArray.count>0) {
        meun=title.nextArray[indexPath.section];
        list=meun.nextArray;
        meun=list[indexPath.row];
    }

    NSString *str = [NSString stringWithFormat:@"%@-%@",title.meunName,meun.meunName];

    void (^select)(NSInteger left,NSInteger right,id info) = self.block;
    select(title.ID.integerValue,meun.ID.integerValue,str);

//    select(self.selectIndex,indexPath.row,str);
    
//    if (self.menuSelect) {
//        self.menuSelect(self.selectIndex,indexPath.row,str);
//    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    StyleCollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:kMultilevelCollectionViewCell forIndexPath:indexPath];
    rightMeun * title=self.allData[self.selectIndex];
    NSArray * list;
    
    rightMeun * meun;
    meun=title.nextArray[indexPath.section];

    if (meun.nextArray.count>0) {
        meun=title.nextArray[indexPath.section];
        list=meun.nextArray;
        meun=list[indexPath.row];
    }
    cell.titile.font=[UIFont systemFontOfSize:ZOOM6(32)];
    cell.titile.text=meun.meunName;
    cell.backgroundColor=[UIColor clearColor];
    cell.line.backgroundColor=_leftTablew.separatorColor;

    /*
     !if you use image:
     //cell.imageView.backgroundColor=UIColorFromRGB(0xF8FCF8);
     //[cell.imageView sd_setImageWithURL:[NSURL URLWithString:meun.urlName] placeholderImage:[UIImage imageNamed:kImageDefaultName]];
     
     */
    
    return cell;
}
/*
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier;
    if ([kind isEqualToString: UICollectionElementKindSectionFooter ]){
        reuseIdentifier = @"footer";
    }else{
        reuseIdentifier = kMultilevelCollectionHeader;
    }
    
    rightMeun * category = self.allData[self.selectIndex];
    NSLog(@"category==%@",category.meunName);
    
    UICollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
    
    UIImageView * headerImg = (UIImageView *)[view viewWithTag:2];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){

        rightMeun * menu;
        menu = category.nextArray[indexPath.section];
//        [headerImg sd_setImageWithURL:[NSURL URLWithString:menu.urlName] placeholderImage:nil options:SDWebImageRefreshCached];
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        view.backgroundColor = [UIColor lightGrayColor];
    }
    
    return view;
}
*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(self.frame.size.width-kLeftWidth, kCellHeight);
}
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(0, 10, 0, 10);
//}
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    CGSize size={kScreenWidth-kLeftWidth,120};
//    return size;
//}


#pragma mark---记录滑动的坐标
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.rightCollection]) {

        
        self.isReturnLastOffset=YES;
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([scrollView isEqual:self.rightCollection]) {
        
        rightMeun * title=self.allData[self.selectIndex];
        
        title.offsetScorller=scrollView.contentOffset.y;
        self.isReturnLastOffset=NO;
        
    }

 }

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.rightCollection]) {
        
        rightMeun * title=self.allData[self.selectIndex];
        
        title.offsetScorller=scrollView.contentOffset.y;
        self.isReturnLastOffset=NO;
        
    }

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:self.rightCollection] && self.isReturnLastOffset) {
        rightMeun * title=self.allData[self.selectIndex];
        
        title.offsetScorller=scrollView.contentOffset.y;

        
    }
}



#pragma mark--Tools
-(void)performBlock:(void (^)())block afterDelay:(NSTimeInterval)delay{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

@end



@implementation rightMeun



@end