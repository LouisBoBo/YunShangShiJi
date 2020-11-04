//
//  BrandTextFieldView.m
//  BrandStyleView
//
//  Created by yssj on 2017/4/11.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "BrandTextFieldView.h"

#import "TFWaterFLayout.h"
#import "NSString+TFCommon.h"
#import "GlobalTool.h"

#import "SqliteManager.h"
//#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width           //(e.g. 320)
//#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height          //(e.g. 480)
//#define SN6 ([UIScreen mainScreen].bounds.size.width)/(750)
//#define ZOOM6(px) (((px)*(SN6)))


#pragma mark - -BrandCollectionTagCell

#define kBrandTagLeftSpace ZOOM6(15)
@interface BrandCollectionTagCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *titleLabel;
- (void)setText:(NSString *)text withSelected:(BOOL)isSelected;
@end

@implementation BrandCollectionTagCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 0.5f;
        self.layer.cornerRadius=3;
        self.layer.borderColor=kSubTitleColor.CGColor;
    }
    return self;
}
- (void)setText:(NSString *)text withSelected:(BOOL)isSelected selectedBackgroundColor:(UIColor *)selectedColor selectedTextColor:(UIColor *)selectedTextColor {
    if (!self.titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kBrandTagLeftSpace, 0, [BrandCollectionTagCell cellSizeWithObj:text].width - 2*kBrandTagLeftSpace, ZOOM6(56))];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
        _titleLabel.textColor=kSubTitleColor;
        [self.contentView addSubview:_titleLabel];
    }
    self.titleLabel.frame = CGRectMake(kBrandTagLeftSpace, 0, [BrandCollectionTagCell cellSizeWithObj:text].width - 2*kBrandTagLeftSpace, ZOOM6(56));
    self.titleLabel.text = text;
    if (isSelected) {
        self.titleLabel.textColor = selectedTextColor;
        self.contentView.backgroundColor = selectedColor;
    } else {
        self.titleLabel.textColor = kTextColor;
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
}
- (void)setText:(NSString *)text withSelected:(BOOL)isSelected {
    [self setText:text withSelected:isSelected selectedBackgroundColor:[UIColor colorWithRed:255/255.0 green:63/255.0 blue:139/255.0 alpha:255/255.0] selectedTextColor:[UIColor whiteColor]];
}

+(CGSize)cellSizeWithObj:(NSString *)text {
    CGSize itemSize = CGSizeZero;
    CGFloat width = [text getWidthWithFont:[UIFont systemFontOfSize:ZOOM6(28)] constrainedToSize:CGSizeMake(MAXFLOAT, ZOOM6(56))];
    if (text.length == 0) {
        itemSize = CGSizeMake(0, 0);
        return itemSize;
    }
    itemSize = CGSizeMake(width + 2 * kBrandTagLeftSpace, ZOOM6(56));
    return itemSize;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
}
- (void)prepareForReuse {
    [super prepareForReuse];
    self.titleLabel.text = @"";
}
@end

#pragma mark - -BrandTextFieldView
@interface BrandTextFieldView()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
{
    CGFloat kBS_Height;
    UILabel *emptyLabel;
}
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)NSString *selectID;
@property (nonatomic,strong)UIButton *okBtn;
@property (nonatomic,strong)UIView *contentView;
@property (strong, nonatomic)  UICollectionView   *collectionView;
@property (strong, nonatomic)  UITableView   *tableView;
@property (strong, nonatomic)  UIView   *emptyView;

@property(strong,nonatomic,readonly) NSArray * allData;
@property (nonatomic,strong)NSMutableArray *searchSuggestions;

@end

@implementation BrandTextFieldView

-(instancetype)initWithData:(NSArray *)data {
    self=[super init];
    if (self) {
        _allData=data;
    }
    return self;
}
- (void)okBtnClick:(UIButton *)sender {
    if (self.confirmBlock&&self.okBtn.selected) {
        self.confirmBlock(self.textField.text,self.selectID);
        [self dismiss];
    }
}
NSInteger length;//定义length来保存字数
-(void)textFieldEditChanged:(UITextField *)textField
{
    //字数限制
    NSInteger WordCount = 15;
    NSString *toBeString = textField.text;
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position)
    {
        if (toBeString.length > WordCount && textField.markedTextRange == nil)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:WordCount];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:WordCount];
                emptyLabel.text=[NSString stringWithFormat:@"直接添加品牌\"%@\"",self.textField.text];
            }
            else
            {
                textField.text = [toBeString substringWithRange:NSMakeRange(0, length)];
                emptyLabel.text=[NSString stringWithFormat:@"直接添加品牌\"%@\"",self.textField.text];
            }
        } else {
            length = toBeString.length;
        }
    }
}
/*
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (self.textField == textField){
        if ([toBeString length] > 14) {
            self.textField.text = [toBeString substringToIndex:14];
            emptyLabel.text=[NSString stringWithFormat:@"直接添加品牌\"%@\"",self.textField.text];
            return NO;
        }
    }
    return YES;
}
*/
- (void)textFieldDidChange:(UITextField *)textField {
    if (textField == self.textField) {
        self.selectID=nil;
        [self textFieldEditChanged:textField];
        
        NSString *searchText=textField.text;
        
        self.tableView.hidden=!searchText.length;
        self.okBtn.selected=searchText.length>0?YES:NO;
        if (searchText.length>0) { // 与搜索条件再搜索
            // 根据条件发送查询（这里模拟搜索）
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 搜索完毕
                // 显示建议搜索结果
                NSMutableArray *searchSuggestionsM = [NSMutableArray array];
                [self.allData enumerateObjectsUsingBlock:^(TypeTagItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([item.class_name containsString:searchText]) {
                        [searchSuggestionsM addObject:item.class_name];
                    }
                }];
                self.searchSuggestions = searchSuggestionsM;
                
                if (searchSuggestionsM.count==0) {
                    [self.contentView addSubview:self.emptyView];
                    emptyLabel.text=[NSString stringWithFormat:@"直接添加品牌\"%@\"",searchText];
                }else{
                    [self.emptyView removeFromSuperview];
                }
//            });
        }else{
            [self.emptyView removeFromSuperview];
        }
    }
}
#pragma mark UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.textField.text=self.searchSuggestions[indexPath.row];
    self.okBtn.selected=YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchSuggestions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 使用默认的搜索建议Cell
    static NSString *cellID = @"cell";
    // 创建cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.backgroundColor = [UIColor clearColor];
        // 添加分割线
        UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PYSearch.bundle/cell-content-line"]];
        line.frame=CGRectMake(0, 43, self.frame.size.width, 0.5);
        line.backgroundColor=[UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
        [cell.contentView addSubview:line];
    }
    cell.textLabel.text=self.searchSuggestions[indexPath.row];
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins=UIEdgeInsetsZero;
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset=UIEdgeInsetsZero;
    }
    
    return cell;
}
#pragma mark - UICollectionViewDelegates for photos
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _allData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BrandCollectionTagCell *cell = (BrandCollectionTagCell *)[_collectionView dequeueReusableCellWithReuseIdentifier:@"CFCollectionButtonViewCell" forIndexPath:indexPath];
//    cell.backgroundColor=DRandomColor;
    //    cell.titleLabel.text=[NSString stringWithFormat:@"%zd",indexPath.row];
    
    //    NSString *text = indexPath.section==2 ? self.styleSourceArr[indexPath.row] : self.brandsSourceArr[indexPath.row];
    
//    if (indexPath.section==2) {
//        ShopTagItem *item = self.styleSourceArr[indexPath.row];
//        [cell setText:item.tag_name withSelected:self.styleSelectedRow==indexPath.row];
//    }else if (indexPath.section==3){
//        TypeTagItem *item = self.brandsSourceArr[indexPath.row];
//        [cell setText:[NSString stringWithFormat:@"%@",item.class_name] withSelected:self.brandSelectedRow==indexPath.row];
//    }
    
    TypeTagItem *item = _allData[indexPath.row];
    [cell setText:[NSString stringWithFormat:@"%@",item.class_name] withSelected:NO];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self endEditing:YES];
    //    if ([self.delegate respondsToSelector:@selector(didSelectCFCollectionButtonView:)]) {
    //        [self.delegate didSelectCFCollectionButtonView:indexPath.row];
    //    }
    //    NSArray *arr = indexPath.section==2 ? self.styleSourceArr :self.brandsSourceArr;
//    [self endEditing:YES];
    
//    if (indexPath.section==2) {
//        self.styleSelectedRow=indexPath.row;
//        ShopTagItem *item = self.styleSourceArr[indexPath.row];
//        self.publishModel.styleTag=item.ID;
//    }else if (indexPath.section==3){
//        self.brandSelectedRow=indexPath.row;
//        TypeTagItem *item = self.brandsSourceArr[indexPath.item];
//        self.publishModel.brandTag=item.ID;
//    }
//    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
    TypeTagItem *item = _allData[indexPath.row];
    self.textField.text=item.class_name;
    self.selectID=item.ID;
    self.okBtn.selected=YES;
    [self okBtnClick:nil];
}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger) section {
//
//    return ZOOM6(80);
//
//}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForFooterInSection:(NSInteger)section {
//    return section==3 ? ZOOM6(120) : 0;
//}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    CGFloat width = floor((self.view.frame.size.width-ZOOM6(20)*6)/4);
    //    return CGSizeMake(width, ZOOM6(54));
    CGSize itemSize = CGSizeZero;
//    NSString *text = nil;
//    if (indexPath.section == 2) {
//        ShopTagItem *item = self.styleSourceArr[indexPath.item];
//        text = item.tag_name;
    TypeTagItem *item = _allData[indexPath.row];
        itemSize = [BrandCollectionTagCell cellSizeWithObj:[NSString stringWithFormat:@"%@",item.class_name]];
        return itemSize;
//    } else if (indexPath.section == 3) {
//        TypeTagItem *item = self.brandsSourceArr[indexPath.item];
//        text = item.class_name;
//        itemSize = [BrandCollectionTagCell cellSizeWithObj:text];
//        return itemSize;
//    }
//    return itemSize;
}
#pragma mark - 懒加载
- (UIView *)emptyView {
    if (_emptyView==nil) {
        _emptyView=[[UIView alloc]initWithFrame:CGRectMake(0, 50, self.frame.size.width, self.frame.size.height-50)];
        emptyLabel=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), 0, self.frame.size.width-ZOOM6(40), 40)];
        emptyLabel.textColor=tarbarrossred;
        emptyLabel.font=[UIFont systemFontOfSize:ZOOM6(32)];
        [_emptyView addSubview:emptyLabel];
        UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), CGRectGetMaxY(emptyLabel.frame), self.frame.size.width-ZOOM6(40), 40)];
        label2.textColor=kSubTitleColor;
        label2.text=@"没有相关品牌";
        label2.font=[UIFont systemFontOfSize:ZOOM6(32)];
        [_emptyView addSubview:label2];
    }
    return _emptyView;
}
- (UITableView *)tableView {
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 50, self.frame.size.width, self.frame.size.height-50) style:UITableViewStylePlain];
        _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.hidden=YES;
    }
    return _tableView;
}
- (UICollectionView *)collectionView {
    if (_collectionView==nil) {
        TFWaterFLayout *layout = [[TFWaterFLayout alloc] init];
        layout.minimumColumnSpacing = ZOOM6(20);
        layout.minimumInteritemSpacing = ZOOM6(20);
        layout.sectionInset = UIEdgeInsetsMake(0, ZOOM6(20), ZOOM6(20), ZOOM6(20));
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 50, self.frame.size.width, self.frame.size.height-50) collectionViewLayout:layout];
        
        [_collectionView registerClass:[BrandCollectionTagCell class] forCellWithReuseIdentifier:@"CFCollectionButtonViewCell"];
        
//        [_collectionView registerClass:[tagSectionHeaderView class] forSupplementaryViewOfKind:TFWaterFallSectionHeader withReuseIdentifier:SectionHeaderView];
//        [_collectionView registerClass:[tagCollectionViewHeader class] forSupplementaryViewOfKind:TFWaterFallSectionHeader withReuseIdentifier:HeaderView];
//        [_collectionView registerClass:[TagSelectView class] forSupplementaryViewOfKind:TFWaterFallSectionHeader withReuseIdentifier:TagView];
        //        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:TFWaterFallSectionFooter withReuseIdentifier:FooterView];
//        [_collectionView registerClass:[ShareTagsView class] forSupplementaryViewOfKind:TFWaterFallSectionHeader  withReuseIdentifier:FooterView];
        
        _collectionView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
//        _collectionView.alwaysBounceVertical=YES;
        _collectionView.backgroundColor=[UIColor clearColor];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
    }
    return _collectionView;
}
- (UITextField *)textField {
    if (_textField==nil) {
        _textField=[[UITextField alloc]initWithFrame:CGRectMake(ZOOM6(20), ZOOM6(20), self.frame.size.width-60-ZOOM6(120), 50-ZOOM6(40))];
        _textField.placeholder=@"请输入品牌";
        _textField.delegate=self;
        _textField.borderStyle=UITextBorderStyleRoundedRect;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}
- (UIButton *)okBtn {
    if (_okBtn==nil) {
        _okBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _okBtn.frame=CGRectMake(self.frame.size.width-60-ZOOM6(80), ZOOM6(20), 60, 50-ZOOM6(40));
        _okBtn.layer.cornerRadius=3;
        _okBtn.clipsToBounds=YES;
        [_okBtn setBackgroundImage:[self imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateNormal];
        [_okBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:63/255.0 blue:139/255.0 alpha:255/255.0]] forState:UIControlStateSelected];
        [_okBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_okBtn addTarget:self action:@selector(okBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okBtn;
}
- (UIView *)contentView {
    if (_contentView==nil) {
        _contentView=[[UIView alloc]initWithFrame:CGRectMake(ZOOM6(30), 0, kScreenWidth-ZOOM6(30)*2, kBS_Height)];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.masksToBounds = YES;
        _contentView.layer.cornerRadius = 5;
        _contentView.center=self.center;
    }
    return _contentView;
}

- (void)setSearchSuggestions:(NSArray<NSString *> *)searchSuggestions {
    _searchSuggestions = [searchSuggestions copy];
    
    // 刷新数据
    [self.tableView reloadData];
}
- (void)setUI {
//    kBS_Height = MAX((kScreenWidth), 64*5);
    kBS_Height=(kScreenWidth-ZOOM6(20)*2);
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    self.contentView.transform = CGAffineTransformMakeScale(0, 0);
    
    UIButton *btn=[[UIButton alloc]initWithFrame:self.frame];
    [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.okBtn];
    [self.contentView addSubview:self.collectionView];
    [self.contentView addSubview:self.tableView];
}
- (void)show {
    [self setUI];
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        self.contentView.transform = CGAffineTransformMakeScale(1, 1);
        self.contentView.alpha = 1;

    } completion:^(BOOL finished) {
        //
    }];
}
- (void)dismiss {
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alpha = 0;
        self.contentView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        self.contentView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.contentView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
