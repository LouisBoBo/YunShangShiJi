//
//  NewPublishThemeAndDressVC.m
//  YunShangShiJi
//
//  Created by yssj on 2017/4/10.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "NewPublishThemeAndDressVC.h"
#import "TFWaterFLayout.h"
#import "TagsCell.h"
#import "SelectedPhotoView.h"
#import "CFImagePickerVC.h"
#import "SharePlatformView.h"

#import "SqliteManager.h"
#import "BatchUploadImages.h"
#import "HTTPTarbarNum.h"

NSString *const SectionReuseIdentifier1 = @"SectionReuseIdentifier1";
NSString *const SectionReuseIdentifier2 = @"SectionReuseIdentifier2";
NSString *const SectionReuseIdentifier3 = @"SectionReuseIdentifier3";
NSString *const SectionReuseIdentifier4 = @"SectionReuseIdentifier4";

NSString *const kNewIntimateCirclePicPath = @"/myq/theme/";

#pragma mark - 模型
@interface NewPublishModel : NSObject
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, assign) BOOL isWX;
@property (nonatomic, assign) BOOL isQQ;
@property (nonatomic, assign) BOOL isWeiBo;
@end
@implementation NewPublishModel

@end

#pragma mark - 头部重用
@interface NewPulishHeaderView : UICollectionReusableView
@end
@implementation NewPulishHeaderView
@end

@interface SectionOneHeaderView : UICollectionReusableView
@property (nonatomic, strong) UILabel *tagLabel;
@end
@implementation SectionOneHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, ZOOM6(20))];
        lineView.backgroundColor = RGBCOLOR_I(240, 240, 240);
        [self addSubview:lineView];
        
        [self addSubview:self.tagLabel];
        self.tagLabel.frame = CGRectMake(ZOOM6(20), lineView.bottom+ZOOM6(20), self.width, ZOOM6(80));

    }
    return self;
}
- (UILabel *)tagLabel {
    if (_tagLabel == nil) {
        _tagLabel = [[UILabel alloc] init];
        _tagLabel.textColor = kTextColor;
        _tagLabel.font = kFont6px(30);
        _tagLabel.text=@"热门标签";
    }
    return _tagLabel;
}
@end

#pragma mark - -NewPublishCollectionTagCell

#define kNewPublishTagLeftSpace ZOOM6(15)
@interface NewPublishCollectionTagCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *titleLabel;
- (void)setText:(NSString *)text withSelected:(BOOL)isSelected;
@end

@implementation NewPublishCollectionTagCell
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
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kNewPublishTagLeftSpace, 0, [NewPublishCollectionTagCell cellSizeWithObj:text].width - 2*kNewPublishTagLeftSpace, ZOOM6(56))];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
        _titleLabel.textColor=kSubTitleColor;
        [self.contentView addSubview:_titleLabel];
    }
    self.titleLabel.frame = CGRectMake(kNewPublishTagLeftSpace, 0, [NewPublishCollectionTagCell cellSizeWithObj:text].width - 2*kNewPublishTagLeftSpace, ZOOM6(56));
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
    itemSize = CGSizeMake(width + 2 * kNewPublishTagLeftSpace, ZOOM6(56));
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

#pragma mark - -NewPublishThemeAndDressVC
@interface NewPublishThemeAndDressVC ()<UITextFieldDelegate,UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    CGFloat H_photoView;
    CGFloat headerHeight;
}
@property (nonatomic, strong) UIButton *publishButton;
@property (strong, nonatomic)  UICollectionView   *collectionView;
@property (nonatomic, strong) TFWaterFLayout *layout;

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *placeLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *lineView2;
@property (nonatomic, strong) UILabel *photoLabel;
@property (nonatomic, strong) SelectedPhotoView *addSelectedPhotoView;
@property (nonatomic , strong) SharePlatformView *shareview;

@property (nonatomic, strong) NSMutableArray *hotsSource;
@property (nonatomic, strong) NSMutableArray *selectedSource;

@property (nonatomic, strong) NewPublishModel *publishModel;

@end

@implementation NewPublishThemeAndDressVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    H_photoView = (kScreen_Width - ZOOM6(20) * 2 - 3 * ZOOM6(20)) / 4;
    headerHeight = ZOOM6(120) +  H_photoView + ZOOM6(20)+ ZOOM6(10);
    
    [self setNavigationItemLeft:@""];
    [self setNavigationItem];
    
    [self getData];
    [self.view addSubview:self.collectionView];
}
- (void)getData {
    SqliteManager *manager = [SqliteManager sharedManager];
    NSArray *array = [manager getAllForCircleTagItem];
    NSArray *sortArray = [manager sortCircleTagArrayWithSequenceFromSourceArray:array];
    for (ShopTypeItem *item in sortArray) {
        if ([item.type integerValue] == 1 && [item.is_show integerValue] == 1) {
            [self.hotsSource addObject:item.name];
        }
    }
    [self reloadSectionsArray:@[@1]];

}
#pragma mark - 懒加载
- (NSMutableArray *)selectedSource {
    if (_selectedSource == nil) {
        _selectedSource = [NSMutableArray array];
    }
    return _selectedSource;
}
- (NSMutableArray *)hotsSource {
    if (_hotsSource == nil) {
        _hotsSource = [NSMutableArray array];
        
//        NSArray *hots = @[@"今天穿什么", @"闲置", @"明星八卦",
//                          @"情感", @"健身", @"星座", @"旅行", @"美食"];
        //        [_hotsSource addObjectsFromArray:hots];
    }
    return _hotsSource;
}
- (UITextField *)textField {
    if (_textField==nil) {
        _textField=[[UITextField alloc]init];
        _textField.placeholder=@"填写自定义标签(选填)";
        _textField.font=kFont6px(32);
        _textField.delegate=self;
        [_textField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}
- (UITextView *)textView {
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        _textView.font = kFont6px(30);
        //        _textView.backgroundColor = [UIColor grayColor];
        _textView.delegate = self;
        [_textView addSubview:self.placeLabel];
    }
    return _textView;
}
- (UILabel *)placeLabel {
    if (_placeLabel == nil) {
        _placeLabel = [[UILabel alloc] init];
        _placeLabel.text = @"输入你的穿搭心得吧，描述穿搭、服饰质地、场合等信息会得到更多关注哦~";
        _placeLabel.numberOfLines=2;
        _placeLabel.textColor = kNavLineColor;
        _placeLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
        //        _placeLabel.enabled = NO;
        _placeLabel.userInteractionEnabled = NO;
        _placeLabel.backgroundColor = [UIColor clearColor];
    }
    return _placeLabel;
}
- (UIView *)lineView {
    if (_lineView == nil) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, ZOOM6(20))];
        lineView.backgroundColor = RGBCOLOR_I(240, 240, 240);
        _lineView = lineView;
    }
    return _lineView;
}
- (UIView *)lineView2 {
    if (_lineView2 == nil) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, ZOOM6(20))];
        lineView.backgroundColor = RGBCOLOR_I(240, 240, 240);
        _lineView2 = lineView;
    }
    return _lineView2;
}
- (UILabel *)photoLabel {
    if (_photoLabel==nil) {
        _photoLabel = [[UILabel alloc] init];
        _photoLabel.textColor = kTextColor;
        _photoLabel.font = kFont6px(30);
        _photoLabel.text=@"添加多张搭配图";
    }
    return _photoLabel;
}
- (SelectedPhotoView *)addSelectedPhotoView {
    if (_addSelectedPhotoView == nil) {
        CGFloat minimumInteritemSpacing = ZOOM6(20);
        SelectedPhotoView *addSelectedPhotoView = [[SelectedPhotoView alloc] initWithFrame:CGRectMake(ZOOM6(20), 0, kScreen_Width - ZOOM6(20) * 2, H_photoView)];
        addSelectedPhotoView.columnCount = 4;
        addSelectedPhotoView.maxPhotoCount = 9;
        addSelectedPhotoView.minimumInteritemSpacing = minimumInteritemSpacing;
        
        addSelectedPhotoView.isFirstTag=YES;
        [addSelectedPhotoView.photoImagesData addObject:self.tagImg];
        [addSelectedPhotoView.imagesData insertObject:self.tagImg atIndex:0];
        self.publishModel.photos = [addSelectedPhotoView.photoImagesData copy];

        kWeakSelf(addSelectedPhotoView);
        kSelfWeak;
        addSelectedPhotoView.didSelectBlock = ^(NSIndexPath *currIndexPath) {
            NSLog(@"预览图片");
        };
        
        addSelectedPhotoView.addPhotoBlock = ^(NSIndexPath *currIndexPath) {
            [weakSelf.view endEditing:YES];
            CFImagePickerVC *doimg = [[CFImagePickerVC alloc] init];
            doimg.delegate = weakSelf;
            doimg.nColumnCount = 4;
            doimg.nResultType = DO_PICKER_RESULT_UIIMAGE;
            doimg.nMaxCount = weakaddSelectedPhotoView.maxPhotoCount - weakaddSelectedPhotoView.photoImagesData.count;
            UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:doimg];
            [weakSelf presentViewController:nav animated:YES completion:nil];
        };
        
        addSelectedPhotoView.deletePhotoBlock = ^(NSIndexPath *currIndexPath) {
            [weakaddSelectedPhotoView reloadPhotoCollectionViewHeight:^(CGFloat height) {
                kSelfStrong;
                //                [weakSelf setheaderHeightWithPhotoHeight:height];
                strongSelf -> H_photoView = height;
                strongSelf -> headerHeight = ZOOM6(120) +strongSelf -> H_photoView + ZOOM6(20)+ ZOOM6(10);
                weakSelf.layout.headerHeight =strongSelf -> headerHeight;
                if (weakaddSelectedPhotoView.superview != nil) {
                    //        // 更新数据
                    weakSelf.publishModel.photos = [weakaddSelectedPhotoView.photoImagesData copy];
                }
            }];
        };
        
        [addSelectedPhotoView reloadPhotoCollectionViewHeight:^(CGFloat height) {
            kSelfStrong;
//            [weakSelf setheaderHeightWithPhotoHeight:height];
            strongSelf -> H_photoView = height;
            strongSelf -> headerHeight = ZOOM6(120) + strongSelf ->H_photoView + ZOOM6(20)+ ZOOM6(10);
            weakSelf.layout.headerHeight = strongSelf -> headerHeight;
            
        }];
        _addSelectedPhotoView = addSelectedPhotoView;
    }
    
    return _addSelectedPhotoView;
}

- (void)setheaderHeightWithPhotoHeight:(CGFloat)height {
    
    H_photoView = height;
    headerHeight = ZOOM6(120) + H_photoView + ZOOM6(20)+ ZOOM6(10);
    self.layout.headerHeight = headerHeight;
//    if (self.lineView.superview != nil && self.addSelectedPhotoView.superview != nil) {
//        [self.lineView setY:self.addSelectedPhotoView.bottom + ZOOM6(20)];
    if (self.addSelectedPhotoView.superview != nil) {
//        // 更新数据
        self.publishModel.photos = [self.addSelectedPhotoView.photoImagesData copy];
    }
  
//    }
}
- (NewPublishModel *)publishModel {
    if (_publishModel == nil) {
        _publishModel = [[NewPublishModel alloc] init];
    }
    return _publishModel;
}
- (UICollectionView *)collectionView {
    if (_collectionView==nil) {
        TFWaterFLayout *layout = [[TFWaterFLayout alloc] init];
        layout.minimumColumnSpacing = ZOOM6(20);
        layout.minimumInteritemSpacing = ZOOM6(20);
        layout.sectionInset = UIEdgeInsetsMake(0, ZOOM6(20), ZOOM6(20), ZOOM6(20));
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, Height_NavBar, self.view.frame.size.width, self.view.frame.size.height-Height_NavBar) collectionViewLayout:_layout=layout];
        
        [_collectionView registerClass:[TagsCell class] forCellWithReuseIdentifier:kICCellIdentifier_TagsCell];
        [_collectionView registerClass:[NewPulishHeaderView class] forSupplementaryViewOfKind:TFWaterFallSectionHeader  withReuseIdentifier:SectionReuseIdentifier1];
        [_collectionView registerClass:[SectionOneHeaderView class] forSupplementaryViewOfKind:TFWaterFallSectionHeader  withReuseIdentifier:SectionReuseIdentifier2];
        [_collectionView registerClass:[NewPulishHeaderView class] forSupplementaryViewOfKind:TFWaterFallSectionHeader  withReuseIdentifier:SectionReuseIdentifier3];
        [_collectionView registerClass:[NewPulishHeaderView class] forSupplementaryViewOfKind:TFWaterFallSectionHeader  withReuseIdentifier:SectionReuseIdentifier4];

        _collectionView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
        _collectionView.alwaysBounceVertical=YES;
        _collectionView.backgroundColor=[UIColor clearColor];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
    }
    return _collectionView;
}
#pragma mark 分享
- (SharePlatformView*)shareview
{
    if(_shareview == nil)
    {
        _shareview = [[SharePlatformView alloc]initWithFrame:CGRectMake(0, ZOOM6(60), ZOOM6(470), ZOOM6(100))];
        kSelfWeak;
        _shareview.shareFinishBlock = ^{//分享结束
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
            if (weakSelf.refreshBlock) {
                weakSelf.refreshBlock();
            }
        };
    }
    return _shareview;
}
#pragma mark - UICollectionViewDelegates for photos
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==1)
        return self.hotsSource.count;
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TagsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kICCellIdentifier_TagsCell forIndexPath:indexPath];
    
    cell.layer.borderColor=kSubTitleColor.CGColor;
    cell.layer.borderWidth=0.5f;
    
    NSString *text = self.hotsSource[indexPath.item];
    BOOL isSelected = NO;
    if ([self.selectedSource containsObject:text]) {
        isSelected = YES;
        cell.layer.borderColor=[UIColor clearColor].CGColor;
    }
//    [cell setTextWithTags:text selected:isSelected];
//    [cell setText:text withSelected:isSelected selectedBackgroundColor:[UIColor whiteColor] selectedTextColor:[UIColor whiteColor]];
    [cell setText:text withSelected:isSelected selectedBackgroundColor:tarbarrossred selectedTextColor:[UIColor whiteColor] BackgroundColor:[UIColor whiteColor] TextColor:kTextColor];

    return cell;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeZero;
    NSString *text = nil;

    text = self.hotsSource[indexPath.item];
    NSString *myText = [NSString stringWithFormat:@"%@", text];
    itemSize = [TagsCell cellSizeWithObj:myText];

    return itemSize;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    
    NSString *text = self.hotsSource[indexPath.item];
    if ([self.selectedSource containsObject:text]) {
        [self.selectedSource removeObject:text];
        [self reloadSectionsArray:@[@1]];
        return;
    }
    /*
    NavgationbarView *showView = [[NavgationbarView alloc] init];
    if (self.selectedSource.count == 1) {
        [showView showLable:@"已经有1个标签了" Controller:self];
        return;
    }
    if (![self.selectedSource containsObject:text]) {
        [self.selectedSource addObject:text];
        [self reloadSectionsArray:@[@1]];
    }
    */
    if (![self.selectedSource containsObject:text]) {
        [self.selectedSource removeAllObjects];
        [self.selectedSource addObject:text];
        [self reloadSectionsArray:@[@1]];
    }
}
- (void)reloadSectionsArray:(NSArray *)sections {
    
    for (NSNumber *section in sections) {
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:section.integerValue]];
    }
    // 更新数据
    self.publishModel.tags = self.selectedSource;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger) section {
    if (section==0)
        return ZOOM6(230)+ZOOM6(40)+ZOOM6(100)+ZOOM6(20);
    else if (section==1)
        return ZOOM6(120);
    else if (section==2)
        return headerHeight;
    else if (section==3)
        return ZOOM6(140)+ZOOM6(60);
    return 0;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView= nil;
    if (kind == TFWaterFallSectionHeader) {
        if (indexPath.section == 0) {
            NewPulishHeaderView *header = [collectionView  dequeueReusableSupplementaryViewOfKind:TFWaterFallSectionHeader withReuseIdentifier:SectionReuseIdentifier1 forIndexPath:indexPath];
            header.backgroundColor = [UIColor whiteColor];
            [header addSubview:self.textView];
            self.textView.frame = CGRectMake(ZOOM6(10), ZOOM6(20), kScreen_Width - ZOOM6(10) * 2, ZOOM6(230));
            [self.placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(ZOOM6(10));
                make.top.mas_equalTo(@0);
                make.width.mas_equalTo(@(kScreen_Width - ZOOM6(20) * 2));
                make.height.mas_equalTo(ZOOM6(100));
            }];
            [header addSubview:self.lineView];
            self.lineView.frame = CGRectMake(0, self.textView.bottom + ZOOM6(20), kScreen_Width, ZOOM6(20));
            [header addSubview:self.textField];
            self.textField.frame = CGRectMake(ZOOM6(20), self.lineView.bottom, kScreen_Width-ZOOM6(40), ZOOM6(100));
            reusableView = header;
            
        } else if (indexPath.section == 1) {
            SectionOneHeaderView *header=[collectionView dequeueReusableSupplementaryViewOfKind:TFWaterFallSectionHeader withReuseIdentifier:SectionReuseIdentifier2 forIndexPath:indexPath];
            reusableView = header;
        } else if (indexPath.section == 2) {
            NewPulishHeaderView *header = [collectionView  dequeueReusableSupplementaryViewOfKind:TFWaterFallSectionHeader withReuseIdentifier:SectionReuseIdentifier3 forIndexPath:indexPath];
            header.backgroundColor = [UIColor whiteColor];
            [header addSubview:self.lineView2];
            self.lineView2.frame = CGRectMake(0, ZOOM6(20), kScreen_Width, ZOOM6(20));
            [header addSubview:self.photoLabel];
            self.photoLabel.frame=CGRectMake(ZOOM6(20), self.lineView2.bottom+ZOOM6(10), kScreen_Width-ZOOM6(40), ZOOM6(80));
            [header addSubview:self.addSelectedPhotoView];
            self.addSelectedPhotoView.frame = CGRectMake(ZOOM6(20), self.photoLabel.bottom + ZOOM6(10), kScreen_Width - ZOOM6(20) * 2, H_photoView);
            reusableView = header;
        } else if (indexPath.section == 3) {
            NewPulishHeaderView *header = [collectionView  dequeueReusableSupplementaryViewOfKind:TFWaterFallSectionHeader withReuseIdentifier:SectionReuseIdentifier4 forIndexPath:indexPath];

            [header addSubview:self.shareview];
            reusableView = header;
        }
    }
    return reusableView;
}
#pragma mark - PickerVC Delegate
- (void)didCancelDoImagePickerController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didSelectPhotosFromDoImagePickerController:(CFImagePickerVC *)picker result:(NSArray *)aSelected {
    
    [self.addSelectedPhotoView.photoImagesData addObjectsFromArray:aSelected];
    [self.addSelectedPhotoView.imagesData removeAllObjects];
    [self.addSelectedPhotoView.imagesData addObjectsFromArray:self.addSelectedPhotoView.photoImagesData];
    if (self.addSelectedPhotoView.photoImagesData.count < self.addSelectedPhotoView.maxPhotoCount) {
        [self.addSelectedPhotoView.imagesData addObject:[self.addSelectedPhotoView addImage]];
    }
    kSelfWeak;
    [self.addSelectedPhotoView reloadPhotoCollectionViewHeight:^(CGFloat height) {
        kSelfStrong;
//        [weakSelf setheaderHeightWithPhotoHeight:height];
       strongSelf -> H_photoView = height;
       strongSelf -> headerHeight = ZOOM6(120) + strongSelf -> H_photoView + ZOOM6(20)+ ZOOM6(10);
        weakSelf.layout.headerHeight = strongSelf -> headerHeight;
        if (weakSelf.addSelectedPhotoView.superview != nil) {
            weakSelf.publishModel.photos = [weakSelf.addSelectedPhotoView.photoImagesData copy];
        }
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TextView Delegate
-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        self.placeLabel.text = @"输入你的穿搭心得吧，描述穿搭、服饰质地、场合等信息会得到更多关注哦~";
    }else{
        self.placeLabel.text = @"";
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
            }
            else
            {
                textField.text = [toBeString substringWithRange:NSMakeRange(0, length)];
            }
        } else {
            length = toBeString.length;
        }
    }
}
/* //对于中文字符中  表情符号无法判断
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (self.textField == textField){
        if ([toBeString length] > 15) {
            self.textField.text = [toBeString substringToIndex:15];
            return NO;
        }
    }
    return YES;
}
*/

- (void)setNavigationItem {
    UIView *lineV = [[UIView alloc] init];
    lineV.backgroundColor = RGBCOLOR_I(240, 240, 240);
    [self.navigationView addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.bottom.equalTo(self.navigationView);
        make.height.mas_equalTo(@1);
    }];
    
    UIButton  *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    publishButton.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(32)];
    [publishButton setTitle:@"发布" forState:UIControlStateNormal];
    [publishButton setTitleColor:COLOR_ROSERED forState:UIControlStateNormal];
    publishButton.tag=1000;
    [self.navigationView addSubview:_publishButton = publishButton];
    [publishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.navigationView);
        make.right.equalTo(self.navigationView).offset(-ZOOM6(20));
        make.centerY.equalTo(self.navigationView.mas_centerY).offset(10);
        make.height.mas_equalTo(44);
    }];
    

    [publishButton addTarget:self action:@selector(publish:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 发布
- (void)publish:(UIButton *)sender {
    [self.view endEditing:YES];
    if (sender.selected) {
        return;
    }
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    
    NewPublishModel *model = self.publishModel;
    model.text = self.textView.text;
    
    if (model.text.length == 0 || model.photos.count == 0) {
        [nv showLable:@"还没有输入内容哦~" Controller:self];
        return ;
    }
    if (model.text.length > 1000) {
        [nv showLable:@"最多只能输入10000个字哦~" Controller:self];
        return ;
    }
//    if (!model.tags.count) {
//        [nv showLable:@"还没有选择标签哦~" Controller:self];
//        return ;
//    }
    if (model.photos.count) {
        sender.selected=YES;
        [self uploadFileToUpYun];
    } else {
        [self httpPublish:nil];
    }
}
- (void)uploadFileToUpYun {
    BatchUploadImages *batchUpload = [[BatchUploadImages alloc] init];
    batchUpload.images = self.publishModel.photos;
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID];
    batchUpload.path = [NSString stringWithFormat:@"%@%@/", kNewIntimateCirclePicPath, userId];
    
    batchUpload.filePaths = [NSString stringWithFormat:@"%.0f_", [NSDate timeIntervalSince1970WithDate] / 1000];
    kWeakSelf(batchUpload);
    [batchUpload setPrecessBlock:^(CGFloat precess) {
        [NavgationbarView showMessage:[NSString stringWithFormat:@"正在发布...(%.0f%%)", precess * 100]];
    } successBlock:^(NSArray *saveImagePaths) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSString *saveImage in saveImagePaths) {
            NSString *subImage = [saveImage substringFromIndex:weakbatchUpload.path.length];
            [array addObject:subImage];
        }
        
        [self httpPublish:array];
        
    } failBlock:^(NSError *error) {
        UIButton *btn=[self.navigationView viewWithTag:1000];
        btn.selected=NO;
        [NavgationbarView showMessage:@"发布失败，请重试"];
        [NavgationbarView dismiss];
    }];
    [batchUpload uploadFile];
}
#pragma mark - Http Publish

- (void)httpPublish:(NSArray *)saveImagePaths {
    UIButton *btn=[self.navigationView viewWithTag:1000];
    btn.selected=YES;
    
    NSString *kApi = @"fc/send?";
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    NSString *pics = [saveImagePaths componentsJoinedByString:@","];
    
    NSMutableArray *dbId = [NSMutableArray array];
    NSMutableArray *dbNames = [NSMutableArray array];
    NSMutableArray *customNames = [NSMutableArray array];
    
    SqliteManager *manager = [SqliteManager sharedManager];
    NSArray *array = [manager getAllForCircleTagItem];
    NSArray *sortArray = [manager sortCircleTagArrayWithSequenceFromSourceArray:array];
    for (ShopTypeItem *item in sortArray) {
        if ([self.selectedSource containsObject:item.name] && [item.type intValue] == 1) {
            [dbId addObject:item.ID];
            [dbNames addObject:item.name];
        }
    }
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.selectedSource ];
    [tempArray removeObjectsInArray:dbNames];
    [customNames addObjectsFromArray:tempArray];
    
    NSString *tags = [dbId componentsJoinedByString:@","];
    NSString *customTags = [customNames componentsJoinedByString:@","];
    [parameter setValue:@"" forKey:@"title"];
    if (!self.publishModel.text.length) {
        self.publishModel.text = @"";
        
    }
    
    [parameter setValue:self.publishModel.text forKey:@"content"];
    if (pics.length) {
        [parameter setValue:pics forKey:@"pics"];
    }
    
//    if (customNames.count) {
//        [parameter setValue:customTags forKey:@"customTags"];
//    }
    if (self.textField.text.length) {
        [parameter setValue:self.textField.text forKey:@"customTags"];
    }
    if (self.jsonSuppLabel.count) {
        NSString *dataString;
        if ([NSJSONSerialization isValidJSONObject:self.jsonSuppLabel]) {
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.jsonSuppLabel options:NSJSONWritingPrettyPrinted error:&error];
            if (!jsonData) {
                NSLog(@"%@",error);
            }else{
                dataString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
            }
        }
        MyLog(@"dataString : %@",[NSString stringWithFormat:@"%@",dataString]);
        [parameter setValue:[NSString stringWithFormat:@"%@",dataString] forKey:@"jsonSuppLabel"];
    }
    if (dbId.count) {
        [parameter setValue:tags forKey:@"tags"];
    }
    
    [parameter setValue:@"4" forKey:@"theme_type"];
    
    NSString *area = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ARRER];
    if (area) {
        [parameter setValue:area forKey:@"location"];
    }
    
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:kApi parameter:parameter caches:NO cachesTimeInterval:0 token:YES success:^(id data, Response *response) {
        
        UIButton *btn=[self.navigationView viewWithTag:1000];
        btn.selected=NO;
                MyLog(@"data: %@", data)
//        [manager insertCircleTagItem:@"900" Name:@"yes"];
       
        if (response.status == 1) {
            kSelfWeak;
            /********* 发布完成  更新标签数据库 ********/
            BOOL update = [[NSUserDefaults standardUserDefaults]boolForKey:@"publishUpdateDB"];

            if (update) {
                [HTTPTarbarNum httpGetCircleTagSuccess:^{
                    [weakSelf publishSuccess:response.theme_id saveImagePaths:saveImagePaths];
                    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"publishUpdateDB"];
                }];
            }else
                [self publishSuccess:response.theme_id saveImagePaths:saveImagePaths];
          
            
            /*
            [NSObject delay:0.5 completion:^{
//                [self.navigationController popToRootViewControllerAnimated:YES];
                [self dismissViewControllerAnimated:YES completion:nil];
                if (self.refreshBlock) {
                    self.refreshBlock();
                }
            }];
            */
            
//            [self shareView];
            
        } else {
            [NavgationbarView showMessage:response.message];
            [NavgationbarView dismiss];
        }
    } failure:^(NSError *error) {
        MyLog(@"error: %@", error);
        UIButton *btn=[self.navigationView viewWithTag:1000];
        btn.selected=NO;
        [NavgationbarView showMessage:[NSString stringWithFormat:@"发布失败，请重试"]];
        [NavgationbarView dismiss];
    }];
    
}
- (void)publishSuccess:(NSString *)themeID saveImagePaths:(NSArray*)saveImagePaths{
    [NavgationbarView showMessage:[NSString stringWithFormat:@"正在发布...(100%%)"]];
    
//    [NSObject delay:0.5 completion:^{
        [self gotoShare:themeID ImageArr:saveImagePaths];
        
        [NavgationbarView showMessage:[NSString stringWithFormat:@"发布成功!"]];
        [NavgationbarView dismiss];
//    }];
}

#pragma mark 发布成功后同步到第三平台
- (void)gotoShare:(NSString*)themeid ImageArr:(NSArray*)imagearr
{
    
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID];
    NSString *imageurl;
    if(imagearr.count)
    {
        NSArray *images = [imagearr[0] componentsSeparatedByString:@":"];
        imageurl = images.count>0?[NSString stringWithFormat:@"/myq/theme/%@/%@",userId,images[0]]:nil;
    }
    NSString *realm = [[NSUserDefaults standardUserDefaults]objectForKey:USER_ID];
    self.shareview.shareImage = imageurl;
    self.shareview.shareLink  = [NSString stringWithFormat:@"%@/views/topic/detail.html?theme_id=%@&realm=%@",[NSObject baseH5ShareURLStr],themeid,realm];
    self.shareview.shareTitle = self.publishModel.text;
    self.shareview.theme_id = themeid;
    //同步分享
    if(self.shareview.weixinBtn.selected || self.shareview.QQbtn.selected || self.shareview.weiboBtn.selected)
    {
        [self.shareview goshare:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
        if (self.refreshBlock) {
            self.refreshBlock();
        }
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
