//
//  TFPublishDress.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2017/2/17.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TFPublishDress.h"
#import "UITextView+HDFTextView.h"
#import "TFWaterFLayout.h"

#import "TagTypesVC.h"
#import "SelectedPhotoView.h"
#import "CFImagePickerVC.h"
#import "TFPublishThemeVC.h"
#import "TFPopBackgroundView.h"

#import "SqliteManager.h"
#import "BaseModel.h"
#import "BatchUploadImages.h"

NSString *const SectionHeaderView = @"SectionHeaderView";
NSString *const HeaderView = @"HeaderView";
NSString *const FooterView = @"FooterView";
NSString *const TagView = @"TagView";


#pragma mark - -模型
@interface PublishDressModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *pics;
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, strong) NSString *typeStr;
@property (nonatomic, strong) NSString *styleTag;
@property (nonatomic, strong) NSString *brandTag;
@property (nonatomic, assign) BOOL isWX;
@property (nonatomic, assign) BOOL isQQ;
@property (nonatomic, assign) BOOL isWeiBo;
@end
@implementation PublishDressModel
@end

@interface PublishDressData : BaseModel
@property (nonatomic, assign) NSInteger status;      //结果
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *theme_id;
+ (void)httpPostPublishDressModel:(PublishDressModel *)model Success:(void(^)(id data))success;
@end
@implementation PublishDressData
+ (void)httpPostPublishDressModel:(PublishDressModel *)model Success:(void(^)(id data))success {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSArray *arr = [model.typeStr componentsSeparatedByString:@"-"];
    NSString *urlStr = [NSString stringWithFormat:@"fc/send?version=%@&token=%@&title=%@&content=%@&theme_type=2&type1=%@&type2=%@&supp_label_id=%@&style=%@",VERSION,token,model.title,model.detail,arr[0],arr[1],model.brandTag,model.styleTag];
    if (model.photos.count&&model.pics) {
       urlStr = [urlStr stringByAppendingFormat:@"&pics=%@",model.pics];
    }
    NSString *area = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ARRER];
    if (area) {
        urlStr = [urlStr stringByAppendingFormat:@"&location=%@",area];
    }
    [self getDataResponsePath:urlStr success:success];
}
@end

#pragma mark - -CFTagCell

#define kTagLeftSpace ZOOM6(15)
@interface CFTagCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *titleLabel;
- (void)setText:(NSString *)text withSelected:(BOOL)isSelected;
@end

@implementation CFTagCell
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
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kTagLeftSpace, 0, [CFTagCell cellSizeWithObj:text].width - 2*kTagLeftSpace, ZOOM6(56))];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
        _titleLabel.textColor=kSubTitleColor;
        [self.contentView addSubview:_titleLabel];
    }
    self.titleLabel.frame = CGRectMake(kTagLeftSpace, 0, [CFTagCell cellSizeWithObj:text].width - 2*kTagLeftSpace, ZOOM6(56));
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
    [self setText:text withSelected:isSelected selectedBackgroundColor:tarbarrossred selectedTextColor:[UIColor whiteColor]];
}

+(CGSize)cellSizeWithObj:(NSString *)text {
    CGSize itemSize = CGSizeZero;
    CGFloat width = [text getWidthWithFont:[UIFont systemFontOfSize:ZOOM6(28)] constrainedToSize:CGSizeMake(MAXFLOAT, ZOOM6(56))];
    if (text.length == 0) {
        itemSize = CGSizeMake(0, 0);
        return itemSize;
    }
    itemSize = CGSizeMake(width + 2 * kTagLeftSpace, ZOOM6(56));
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

#pragma mark - -UICollectionReusableView
@interface tagCollectionViewHeader : UICollectionReusableView
@end
@implementation tagCollectionViewHeader
@end

@interface tagSectionHeaderView : UICollectionReusableView
@property (nonatomic,strong)UILabel *tagLabel;
@end

@implementation tagSectionHeaderView
- (UILabel *)tagLabel {
    if (_tagLabel==nil) {
        _tagLabel=[[UILabel alloc]initWithFrame:CGRectMake( kLeftSpace, 0, self.frame.size.width, self.frame.size.height)];
        _tagLabel.textColor=kMainTitleColor;
        _tagLabel.font=[UIFont systemFontOfSize:ZOOM6(32)];
    }
    return _tagLabel;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}
- (void)setUI {
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    line.backgroundColor = kTableLineColor;
    [self addSubview:line];
    
    [self addSubview:self.tagLabel];
}
@end

@interface TagSelectView : UICollectionReusableView
@property (nonatomic,strong)UILabel *tagLabel;
@property (nonatomic,copy)dispatch_block_t TagBtnClickBlock;
@end

@implementation TagSelectView

- (UILabel *)tagLabel {
    if (_tagLabel==nil) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(kLeftSpace, 0, ZOOM6(160), self.frame.size.height)];
        label.text=@"分类";
        label.textAlignment=NSTextAlignmentLeft;
        label.textColor=kMainTitleColor;
        label.font=[UIFont systemFontOfSize:ZOOM6(32)];
        [self addSubview:label];
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), ZOOM6(20), 1, self.frame.size.height-ZOOM6(40))];
        line.backgroundColor=kTableLineColor;
        [self addSubview:line];
        _tagLabel=[[UILabel alloc]initWithFrame:CGRectMake( CGRectGetMaxX(line.frame)+ZOOM6(24), 0, self.frame.size.width-CGRectGetMaxX(line.frame)-ZOOM6(24)-50, self.frame.size.height)];
        _tagLabel.text=@"请选择分类";
        _tagLabel.font=[UIFont systemFontOfSize:ZOOM6(32)];
        _tagLabel.textColor=kSubTitleColor;
       
    }
    return _tagLabel;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}
- (void)setUI {
    [self addSubview:self.tagLabel];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"help_more"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, kLeftSpace)];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    [self addSubview:btn];
    
}
- (void)btnClick {
    if (self.TagBtnClickBlock) {
        self.TagBtnClickBlock();
    }
}

@end

#pragma mark - TFPublishDress
@interface TFPublishDress ()<UITextFieldDelegate,UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,CFImagePickerVCDelegate>
{
    CGFloat H_textField;
    CGFloat H_textView;
    CGFloat H_photoView;
    CGFloat H_SectionHeaderView;
}
//@property (strong, nonatomic)  UICollectionViewFlowLayout   *flowLayout;
@property (strong, nonatomic)  UICollectionView   *collectionView;
@property (nonatomic, strong)  TFWaterFLayout *layout;

@property (nonatomic, strong) UITextField *titleText;
@property (nonatomic, strong) UIPlaceholderTextView *detail;
@property (nonatomic, strong) SelectedPhotoView *addSelectedPhotoView;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, strong) NSMutableArray *styleSourceArr;
@property (nonatomic, strong) NSMutableArray *brandsSourceArr;
@property (nonatomic, assign) NSInteger styleSelectedRow;
@property (nonatomic, assign) NSInteger brandSelectedRow;

@property (nonatomic, strong) PublishDressModel *publishModel;

@end

@implementation TFPublishDress
#pragma mark - Getter
- (PublishDressModel *)publishModel {
    if (_publishModel == nil) {
        _publishModel = [[PublishDressModel alloc] init];
    }
    return _publishModel;
}
- (NSMutableArray *)styleSourceArr {
    if (_styleSourceArr==nil) {
        _styleSourceArr=[NSMutableArray array];
//        _styleSourceArr = [NSMutableArray arrayWithObjects:@"1",@"2fsafs",@"3fsaf",@"4vxczerqw", nil];
    }
    return _styleSourceArr;
}
- (NSMutableArray *)brandsSourceArr {
    if (_brandsSourceArr==nil) {
        _brandsSourceArr=[NSMutableArray array];
//        _brandsSourceArr = [NSMutableArray arrayWithObjects:@"gap",@"banana baby",@"1",@"2fsafs",@"3fsaf",@"4vxczerqw",nil];
    }
    return _brandsSourceArr;
}
- (UIView *)lineView {
    if (_lineView == nil) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, ZOOM6(20))];
        lineView.backgroundColor = RGBCOLOR_I(240, 240, 240);
        _lineView = lineView;
    }
    return _lineView;
}
- (SelectedPhotoView *)addSelectedPhotoView {
    if (_addSelectedPhotoView == nil) {
        CGFloat minimumInteritemSpacing = ZOOM6(20);
        SelectedPhotoView *addSelectedPhotoView = [[SelectedPhotoView alloc] initWithFrame:CGRectMake(ZOOM6(20), 0, kScreen_Width - ZOOM6(20) * 2, H_photoView)];
        addSelectedPhotoView.columnCount = 4;
        addSelectedPhotoView.maxPhotoCount = 9;
        addSelectedPhotoView.minimumInteritemSpacing = minimumInteritemSpacing;
        kWeakSelf(addSelectedPhotoView);
        addSelectedPhotoView.didSelectBlock = ^(NSIndexPath *currIndexPath) {
            
        };
        
        addSelectedPhotoView.addPhotoBlock = ^(NSIndexPath *currIndexPath) {
            
            CFImagePickerVC *doimg = [[CFImagePickerVC alloc] init];
            doimg.delegate = self;
            doimg.nColumnCount = 4;
            doimg.nResultType = DO_PICKER_RESULT_UIIMAGE;
            doimg.nMaxCount = weakaddSelectedPhotoView.maxPhotoCount - weakaddSelectedPhotoView.photoImagesData.count;
            [self presentViewController:doimg animated:YES completion:nil];
        };
        
        addSelectedPhotoView.deletePhotoBlock = ^(NSIndexPath *currIndexPath) {
            [weakaddSelectedPhotoView reloadPhotoCollectionViewHeight:^(CGFloat height) {
                [self setheaderHeightWithPhotoHeight:height];
            }];
        };
        
        [addSelectedPhotoView reloadPhotoCollectionViewHeight:^(CGFloat height) {
            [self setheaderHeightWithPhotoHeight:height];
            
        }];
        _addSelectedPhotoView = addSelectedPhotoView;
    }
    
    return _addSelectedPhotoView;
}

- (void)setheaderHeightWithPhotoHeight:(CGFloat)height {
    H_photoView = height;
    self.headerHeight = H_textField + H_textView + ZOOM6(20) + H_photoView + ZOOM6(20) + ZOOM6(20);
    self.layout.headerHeight = self.headerHeight;
    if (self.lineView.superview != nil && self.addSelectedPhotoView.superview != nil) {
        [self.lineView setY:self.addSelectedPhotoView.bottom + ZOOM6(20)];
        // 更新数据
        self.publishModel.photos = [self.addSelectedPhotoView.photoImagesData copy];
    }
}
- (UITextField *)titleText {
    if (_titleText==nil) {
        _titleText=[[UITextField alloc]initWithFrame:CGRectMake(kLeftSpace, 0, kScreenWidth-kLeftSpace*2, H_textField)];
        _titleText.placeholder=@"请输入标题";
        [_titleText setValue:kNavLineColor forKeyPath:@"_placeholderLabel.textColor"];
//        _titleText.textColor=kNavLineColor;
        _titleText.font=[UIFont systemFontOfSize:ZOOM6(30)];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, H_textField, _titleText.frame.size.width, 0.5)];
        line.backgroundColor = kTableLineColor;
        _titleText.delegate=self;
        [_titleText addSubview:line];
        [_titleText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _titleText;
}
- (UIPlaceholderTextView *)detail {
    if (_detail==nil) {
        _detail=[[UIPlaceholderTextView alloc]initWithFrame:CGRectMake(ZOOM6(10), CGRectGetMaxY(self.titleText.frame)+1, kScreenWidth-ZOOM6(10)*2, H_textView)];
        _detail.placeholder=@"详细描述你的美衣、穿搭";
        _detail.delegate=self;
        _detail.font=[UIFont systemFontOfSize:ZOOM6(30)];
    }
    return _detail;
}
//- (UICollectionViewFlowLayout *)flowLayout {
//    if (_flowLayout==nil) {
//        //确定是水平滚动，还是垂直滚动
//        _flowLayout=[[UICollectionViewFlowLayout alloc] init];
//                _flowLayout.sectionInset = UIEdgeInsetsMake(0, kLeftSpace, 0, kLeftSpace);
//        _flowLayout.minimumLineSpacing=5;
//        _flowLayout.minimumInteritemSpacing=5;
//        [_flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
////        _flowLayout.headerReferenceSize = CGSizeMake(kScreenWidth, ZOOM(570));  //设置head大小
//    }
//    return _flowLayout;
//}
- (UICollectionView *)collectionView {
    if (_collectionView==nil) {
        TFWaterFLayout *layout = [[TFWaterFLayout alloc] init];
        layout.minimumColumnSpacing = ZOOM6(20);
        layout.minimumInteritemSpacing = ZOOM6(20);
        layout.sectionInset = UIEdgeInsetsMake(0, ZOOM6(20), ZOOM6(20), ZOOM6(20));
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, Height_NavBar, self.view.frame.size.width, self.view.frame.size.height-Height_NavBar) collectionViewLayout:_layout = layout];
        
        [_collectionView registerClass:[CFTagCell class] forCellWithReuseIdentifier:@"CFCollectionButtonViewCell"];
        
        [_collectionView registerClass:[tagSectionHeaderView class] forSupplementaryViewOfKind:TFWaterFallSectionHeader withReuseIdentifier:SectionHeaderView];
        [_collectionView registerClass:[tagCollectionViewHeader class] forSupplementaryViewOfKind:TFWaterFallSectionHeader withReuseIdentifier:HeaderView];
        [_collectionView registerClass:[TagSelectView class] forSupplementaryViewOfKind:TFWaterFallSectionHeader withReuseIdentifier:TagView];
//        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:TFWaterFallSectionFooter withReuseIdentifier:FooterView];
        [_collectionView registerClass:[ShareTagsView class] forSupplementaryViewOfKind:TFWaterFallSectionHeader  withReuseIdentifier:FooterView];
       
        _collectionView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
        _collectionView.alwaysBounceVertical=YES;
        _collectionView.backgroundColor=[UIColor clearColor];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setData];
    
    [self setUI];
}

- (void)setData {
    CGFloat minimumInteritemSpacing = ZOOM6(20);
    H_textField = ZOOM6(80);
    H_textView = ZOOM6(150);
    H_photoView = (kScreen_Width - ZOOM6(20) * 2 - 3 * minimumInteritemSpacing) / 4;
    H_SectionHeaderView = ZOOM6(100);
    self.headerHeight = H_textField + H_textView + ZOOM6(20) +  H_photoView + ZOOM6(20) + ZOOM6(20);

    self.styleSelectedRow=-1;self.brandSelectedRow=-1;
    
    SqliteManager *manager = [SqliteManager sharedManager];
    self.brandsSourceArr = [[manager getAllForBrandsItem] copy];
    self.styleSourceArr = [[manager getShopTagItemForSuperId:@"2"]copy];
}
- (void)setUI {
    [self setNavigationItemLeft:@"发布穿搭"];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 63, kScreenWidth, 0.5)];
    line.backgroundColor = kNavLineColor;
    [self.navigationView addSubview:line];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(32)];
    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button setTitleColor:COLOR_ROSERED forState:UIControlStateNormal];
//    [button handleClickEvent:UIControlEventTouchUpInside withClickBlock:^(UIButton *sender) {
//        [self.view endEditing:YES];
//        
//        [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(publishDress)object:nil];
//        [self performSelector:@selector(publishDress)withObject:nil afterDelay:0.5f];
//        
//    }];
    [button addTarget:self action:@selector(publishDress:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.navigationView);
        make.right.equalTo(self.navigationView).offset(-ZOOM6(20));
        make.centerY.equalTo(self.navigationView.mas_centerY).offset(10);
        make.height.mas_equalTo(44);
    }];
    
    [self.view addSubview:self.collectionView];
}
- (void)publishDress:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    
    if (self.publishModel.title.length==0||!self.publishModel.title) {
        [NavgationbarView showMessageAndHide:@"还没有输入标题哦~"];
    }else if (self.publishModel.detail.length==0||!self.publishModel.detail) {
        [NavgationbarView showMessageAndHide:@"还没有输入描述哦~"];
    }else if (self.publishModel.photos.count==0||!self.publishModel.photos) {
        [NavgationbarView showMessageAndHide:@"还没有选择图片哦~"];
    }else if (self.publishModel.typeStr.length==0||!self.publishModel.typeStr) {
        [NavgationbarView showMessageAndHide:@"还没有选择穿搭分类哦~"];
    }else if (self.styleSelectedRow==-1) {
        [NavgationbarView showMessageAndHide:@"还没有选择穿搭风格哦~"];
    }else if (self.brandSelectedRow==-1){
        [NavgationbarView showMessageAndHide:@"还没有选择穿搭品牌哦~"];
    }else {
        sender.selected=YES;
        
        BatchUploadImages *batchUpload = [[BatchUploadImages alloc] init];
        batchUpload.images = self.publishModel.photos;
        NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID];
        batchUpload.path = [NSString stringWithFormat:@"/myq/theme/%@/",userId];
        batchUpload.filePaths = [NSString stringWithFormat:@"%.0f_", [NSDate timeIntervalSince1970WithDate] / 1000];
        
        __block NSString*str=batchUpload.path;
        [batchUpload setPrecessBlock:^(CGFloat precess) {
            [NavgationbarView showMessage:[NSString stringWithFormat:@"正在发布...(%.0f%%)", precess * 100]];
        } successBlock:^(NSArray *saveImagePaths) {
            NSMutableArray *picsArr=[NSMutableArray array];
            for (NSString *str2 in saveImagePaths) {
                NSString *picStr = [str2 substringFromIndex:str.length];
                [picsArr addObject:picStr];
            }
            self.publishModel.pics = [picsArr componentsJoinedByString:@","];
            [PublishDressData httpPostPublishDressModel:self.publishModel Success:^(id data) {
                PublishDressData *model=data;
                 sender.selected=NO;
                if (model.status==1){
                    [self gotoShare:model.theme_id]; //何波加的
                    [NavgationbarView showMessageAndHide:@"发布成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                }else
                    [NavgationbarView showMessageAndHide:[NSString stringWithFormat:@"%@",model.message]];
                
                //                        [NavgationbarView showM essageAndHide:@"发布失败，请重试"];
                [NavgationbarView dismiss];
                
                [NSObject delay:0.5 completion:^{
                    [self.navigationController popViewControllerAnimated:YES];
                    if (self.refreshBlock) {
                        self.refreshBlock();
                    }
                }];
                
                
            }];
            
        } failBlock:^(NSError *error) {
            [NavgationbarView showMessage:@"发布失败，请重试"];
            [NavgationbarView dismiss];
             sender.selected=NO;
        }];
        [batchUpload uploadFile];
        
    }
    

}

#pragma mark - UICollectionViewDelegates for photos
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    if ([self.delegate respondsToSelector:@selector(CFCollectionButtonView:numberOfItemsInSection:)]) {
//        return [self.delegate CFCollectionButtonView:collectionView numberOfItemsInSection:section];
//    }
    if (section==2) {
        return self.styleSourceArr.count;
    }else if (section==3) {
        return self.brandsSourceArr.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CFTagCell *cell = (CFTagCell *)[_collectionView dequeueReusableCellWithReuseIdentifier:@"CFCollectionButtonViewCell" forIndexPath:indexPath];
    cell.backgroundColor=DRandomColor;
//    cell.titleLabel.text=[NSString stringWithFormat:@"%zd",indexPath.row];
    
//    NSString *text = indexPath.section==2 ? self.styleSourceArr[indexPath.row] : self.brandsSourceArr[indexPath.row];
    
    if (indexPath.section==2) {
        ShopTagItem *item = self.styleSourceArr[indexPath.row];
        [cell setText:item.tag_name withSelected:self.styleSelectedRow==indexPath.row];
    }else if (indexPath.section==3){
        TypeTagItem *item = self.brandsSourceArr[indexPath.row];
        [cell setText:[NSString stringWithFormat:@"%@",item.class_name] withSelected:self.brandSelectedRow==indexPath.row];
    }

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([self.delegate respondsToSelector:@selector(didSelectCFCollectionButtonView:)]) {
//        [self.delegate didSelectCFCollectionButtonView:indexPath.row];
//    }
//    NSArray *arr = indexPath.section==2 ? self.styleSourceArr :self.brandsSourceArr;
    [self.view endEditing:YES];

    if (indexPath.section==2) {
        self.styleSelectedRow=indexPath.row;
        ShopTagItem *item = self.styleSourceArr[indexPath.row];
        self.publishModel.styleTag=item.ID;
    }else if (indexPath.section==3){
        self.brandSelectedRow=indexPath.row;
        TypeTagItem *item = self.brandsSourceArr[indexPath.item];
        self.publishModel.brandTag=item.ID;
    }
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];

}
- (void)reloadSectionsArray:(NSArray *)sections {
    for (NSNumber *section in sections) {
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:section.integerValue]];
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger) section {
    if (section==0) {
        return self.headerHeight;
    }else if (section==1) {
        return ZOOM6(100);
    }else if(section==2||section==3)
        return ZOOM6(80);
    else if (section==4)
        return ZOOM6(120);
    return 0;
}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForFooterInSection:(NSInteger)section {
//    return section==3 ? ZOOM6(120) : 0;
//}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    CGFloat width = floor((self.view.frame.size.width-ZOOM6(20)*6)/4);
//    return CGSizeMake(width, ZOOM6(54));
    CGSize itemSize = CGSizeZero;
    NSString *text = nil;
    if (indexPath.section == 2) {
        ShopTagItem *item = self.styleSourceArr[indexPath.item];
        text = item.tag_name;
        itemSize = [CFTagCell cellSizeWithObj:text];
        return itemSize;
    } else if (indexPath.section == 3) {
        TypeTagItem *item = self.brandsSourceArr[indexPath.item];
        text = item.class_name;
        itemSize = [CFTagCell cellSizeWithObj:text];
        return itemSize;
    }
    return itemSize;
}
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == TFWaterFallSectionHeader) {
        if (indexPath.section == 0) {
            
            tagCollectionViewHeader *header =(tagCollectionViewHeader *)[collectionView dequeueReusableSupplementaryViewOfKind:TFWaterFallSectionHeader withReuseIdentifier:HeaderView forIndexPath:indexPath];
            header.backgroundColor = [UIColor whiteColor];
            [header addSubview:self.titleText];
            [header addSubview:self.detail];
            [header addSubview:self.addSelectedPhotoView];
            self.addSelectedPhotoView.frame = CGRectMake(ZOOM6(20), self.detail.bottom + ZOOM6(20), kScreen_Width - ZOOM6(20) * 2, H_photoView);
            [header addSubview:self.lineView];
            self.lineView.frame = CGRectMake(0, self.addSelectedPhotoView.bottom + ZOOM6(20), kScreen_Width, ZOOM6(20));
            return header;
            
        }
        else  if(indexPath.section == 1) {
            TagSelectView *tagSelectView =(TagSelectView *)[collectionView dequeueReusableSupplementaryViewOfKind:TFWaterFallSectionHeader withReuseIdentifier:TagView forIndexPath:indexPath];
//            tagSelectView.backgroundColor=DRandomColor;
            kWeakSelf(tagSelectView);
            kSelfWeak;
            tagSelectView.TagBtnClickBlock = ^{
                [weakSelf.view endEditing:YES];

                TagTypesVC *vc=[TagTypesVC new];
                vc.didSelectBlock = ^(NSString *str,NSString *nameStr){
                    weaktagSelectView.tagLabel.text=nameStr;
                    weakSelf.publishModel.typeStr=str;
                };
                [weakSelf.navigationController pushViewController:vc animated:YES];
            };
            return tagSelectView;
        }else if(indexPath.section==2||indexPath.section==3) {
            tagSectionHeaderView *headerView=(tagSectionHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:TFWaterFallSectionHeader withReuseIdentifier:SectionHeaderView forIndexPath:indexPath];;
//            headerView.backgroundColor=[UIColor blueColor];
            headerView.tagLabel.text=indexPath.section==2?@"风格":@"品牌";
            return headerView;
        }else if (indexPath.section==4) {
            ShareTagsView *shareTagsView =(ShareTagsView *)[collectionView dequeueReusableSupplementaryViewOfKind:TFWaterFallSectionHeader withReuseIdentifier:FooterView forIndexPath:indexPath];
            [shareTagsView addSubview:self.shareview];
            return shareTagsView;
        }
        
    }
    else if (kind==TFWaterFallSectionFooter && indexPath.section==3 ) {
        ShareTagsView *shareTagsView =(ShareTagsView *)[collectionView dequeueReusableSupplementaryViewOfKind:TFWaterFallSectionFooter withReuseIdentifier:FooterView forIndexPath:indexPath];
//        shareTagsView.titleLabel.text = @"同步到";
//        shareTagsView.wxButton.selected=self.publishModel.isWX;
//        shareTagsView.qqButton.selected=self.publishModel.isQQ;
//        shareTagsView.weiboButton.selected=self.publishModel.isWeiBo;
//        [shareTagsView setButtonBlockWithWxBlock:^(BOOL isSelected) {
//            self.publishModel.isWX = isSelected;
//        } qqBlock:^(BOOL isSelected) {
//            self.publishModel.isQQ = isSelected;
//        } weiboBlock:^(BOOL isSelected) {
//            self.publishModel.isWeiBo = isSelected;
//        }];
//        shareTagsView.backgroundColor = [UIColor whiteColor];
////        shareTagsView.backgroundColor=DRandomColor;
//        return shareTagsView;
        
        
        [shareTagsView addSubview:self.shareview];
        return shareTagsView;
    }
    return nil;
}
- (void)textFieldDidChange:(UITextField *)textField {
    self.publishModel.title=textField.text;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.publishModel.title=textField.text;
}

- (void)textViewDidChange:(UITextView *)textView {
    self.publishModel.detail=textView.text;
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    self.publishModel.detail=textView.text;
}
#pragma mark - ImagePickerVC Delegate
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

    [self.addSelectedPhotoView reloadPhotoCollectionViewHeight:^(CGFloat height) {
        [self setheaderHeightWithPhotoHeight:height];
    }];

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)leftBarButtonClick {
    
    [self.view endEditing:YES];
    
    TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] init];
    popView.title = @"是否退出发布?";
    popView.leftText = @"取消";
    popView.rightText = @"退出";
    popView.textAlignment = NSTextAlignmentCenter;
    [popView showCancelBlock:^{
        
    } withConfirmBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    } withNoOperationBlock:^{
        
    }];
}


#pragma mark 分享
- (SharePlatformView*)shareview
{
    if(_shareview == nil)
    {
        _shareview = [[SharePlatformView alloc]initWithFrame:CGRectMake(0, 0, ZOOM6(470), ZOOM6(100))];
        
        _shareview.shareFinishBlock = ^{//分享结束
            
        };
    }
    return _shareview;
}

#pragma mark 发布成功后同步到第三平台
- (void)gotoShare:(NSString*)themeid
{
    NSArray *imagearr = [self.publishModel.pics componentsSeparatedByString:@":"];
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID];
    NSString *imageurl = [NSString stringWithFormat:@"/myq/theme/%@/%@",userId,imagearr.count>0?imagearr[0]:nil];
    NSString *realm = [[NSUserDefaults standardUserDefaults]objectForKey:USER_ID];
    self.shareview.shareImage = imageurl;
    self.shareview.shareLink  = [NSString stringWithFormat:@"%@/views/topic/detail.html?theme_id=%@&realm=%@",[NSObject baseH5ShareURLStr],themeid,realm];
    self.shareview.shareTitle = self.publishModel.detail;
    //同步分享
    if(self.shareview.weiboBtn.selected || self.shareview.QQbtn.selected || self.shareview.weiboBtn.selected)
    {
        [self.shareview goshare:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
