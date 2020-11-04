//
//  TFPublishThemeVC.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2017/2/17.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TFPublishThemeVC.h"
#import "SelectedPhotoView.h"
#import "TagsCell.h"
#import "TFWaterFLayout.h"
#import "CFImagePickerVC.h"
#import "NavgationbarView.h"
#import "TFPopBackgroundView.h"
#import "BatchUploadImages.h"
#import "SqliteManager.h"
#import "AppDelegate.h"
#import "IntimateCircleModel.h"
#import "DShareManager.h"
NSString *const TFWaterFallSectionReuseIdentifier1 = @"TFWaterFallSectionReuseIdentifier1";
NSString *const TFWaterFallSectionReuseIdentifier2 = @"TFWaterFallSectionReuseIdentifier2";
NSString *const TFWaterFallSectionReuseIdentifier3 = @"TFWaterFallSectionReuseIdentifier3";
NSString *const TFWaterFallSectionReuseIdentifier4 = @"TFWaterFallSectionReuseIdentifier4";

#pragma mark - 头部重用
@interface PulishHeaderView : UICollectionReusableView
@end
@implementation PulishHeaderView
@end

#pragma mark - 标签

typedef void(^OKButtonBlock)(NSString *text);
@interface CoustomTags : UICollectionReusableView <UITextFieldDelegate>
@property (nonatomic, strong) UIImageView *tagImageView;
@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) UIView *inputView;
@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) UIButton *okButton;
@property (nonatomic, copy) OKButtonBlock okButtonBlock;
@property (nonatomic, assign) BOOL isInputView;
@end
@implementation CoustomTags
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    [self addSubview:self.tagImageView];
    [self addSubview:self.tagLabel];
    [self addSubview:self.inputView];
}
- (void)layoutSubviews {
    CGFloat y = self.isInputView? ZOOM6(20): ZOOM6(40);
    self.tagImageView.frame = CGRectMake(ZOOM6(20), y, ZOOM6(40), ZOOM6(40));
    self.tagLabel.frame = CGRectMake(self.tagImageView.right + ZOOM6(10), self.tagImageView.y, self.width - (self.tagImageView.right + ZOOM6(10)), ZOOM6(40));
    CGFloat H_inputView = self.isInputView? ZOOM6(60): 0;
    self.inputView.frame = CGRectMake(ZOOM6(20), self.tagLabel.bottom + ZOOM6(20), self.width - 2 * ZOOM6(20),H_inputView);
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString *oldText = textField.text;
    NSString *currInputText = [NSString stringWithFormat:@"%@%@", textField.text, string];
          
    if (textField == self.inputTextField) {
        if (currInputText.length>0) {
            self.okButton.selected = NO;
        }
    }
    
    if ((currInputText.length == oldText.length && range.location == 0)) { // 删除
        self.okButton.selected = YES;
    }
    
    return YES;
}


#pragma mark - Getter
- (UIImageView *)tagImageView {
    if (_tagImageView == nil) {
        _tagImageView = [[UIImageView alloc] init];
    }
    return _tagImageView;
}

- (UILabel *)tagLabel {
    if (_tagLabel == nil) {
        _tagLabel = [[UILabel alloc] init];
        _tagLabel.textColor = kTextColor;
        _tagLabel.font = kFont6px(30);
    }
    return _tagLabel;
}

- (UIView *)inputView {
    if (_inputView == nil) {
        _inputView = [[UIView alloc] init];
        
        [_inputView addSubview:self.inputTextField];
        [_inputView addSubview:self.okButton];
        
        [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(_inputView);
            make.right.equalTo(self.okButton.mas_left).offset(-ZOOM6(20));
        }];
        
        [self.okButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(_inputView);
            make.width.mas_equalTo(ZOOM6(120));
        }];
    }
    return _inputView;
}

- (UITextField *)inputTextField {
    if (_inputTextField == nil) {
        _inputTextField = [[UITextField alloc] init];
        _inputTextField.borderStyle = UITextBorderStyleNone;
        _inputTextField.layer.masksToBounds = YES;
        _inputTextField.layer.borderColor = [RGBCOLOR_I(240, 240, 240) CGColor];
        _inputTextField.layer.borderWidth = 1;
        _inputTextField.layer.cornerRadius = ZOOM6(4);
        _inputTextField.placeholder = @"请输入标签";
        _inputTextField.font = kFont6px(25);
        _inputTextField.delegate = self;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, ZOOM6(60))];
        _inputTextField.leftView = leftView;
        _inputTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _inputTextField;
}

- (UIButton *)okButton {
    if (_okButton == nil) {
        UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [okButton setTitle:@"确定" forState:UIControlStateNormal];
        [okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [okButton setTitleColor:kTextColor forState:UIControlStateSelected];
        [okButton setBackgroundImage:[UIImage imageWithColor:COLOR_ROSERED] forState:UIControlStateNormal];
        [okButton setBackgroundImage:[UIImage imageWithColor:RGBCOLOR_I(240, 240, 240)] forState:UIControlStateSelected];
        
        okButton.titleLabel.font = kFont6px(30);
        okButton.layer.masksToBounds = YES;
        okButton.layer.cornerRadius = ZOOM6(4);
        _okButton = okButton;
        [okButton handleClickEvent:UIControlEventTouchUpInside withClickBlock:^(UIButton *sender) {
            if (self.okButtonBlock && !sender.selected) {
                self.okButtonBlock(self.inputTextField.text);
            }
        }];
        _okButton.selected = YES;
    }
    return _okButton;
}

@end


@implementation ShareTagsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    [self addSubview:self.titleLabel];
    [self addSubview:self.wxButton];
    [self addSubview:self.qqButton];
    [self addSubview:self.weiboButton];
}

- (void)layoutSubviews {
    
    NSArray *array = [self isSetupWXAndQQAndWeibo];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(ZOOM6(20));
    }];
    
    [self.wxButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.titleLabel.mas_right).offset(ZOOM6(20));
        make.size.mas_equalTo(CGSizeMake([array[0] floatValue], ZOOM6(60)));
    }];
    
    [self.qqButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.wxButton.mas_right).offset(ZOOM6(30));
        make.size.mas_equalTo(CGSizeMake([array[1] floatValue], ZOOM6(60)));
    }];
    
    [self.weiboButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.qqButton.mas_right).offset(ZOOM6(30));
        make.size.mas_equalTo(CGSizeMake([array[2] floatValue], ZOOM6(60)));
    }];
}

- (NSArray *)isSetupWXAndQQAndWeibo {
    NSMutableArray *array = [NSMutableArray array];
    //判断是否有微信
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        [array addObject:@(ZOOM6(60))];
    } else {
        [array addObject:@(0)];
    }
    
    //判断是否有qq
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
        [array addObject:@(ZOOM6(60))];
    } else {
        [array addObject:@(0)];
    }
    // 微博
    [array addObject:@(ZOOM6(60))];
    
    return array;
}

- (void)setButtonBlockWithWxBlock:(ShareButtonBlock)wxBlock qqBlock:(ShareButtonBlock)qqBlock weiboBlock:(ShareButtonBlock)weiboBlock {
    self.wxBlock = wxBlock;
    self.qqBlock = qqBlock;
    self.weiboBlock = weiboBlock;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kTextColor;
        _titleLabel.font = kFont6px(30);
    }
    return _titleLabel;
}

- (UIButton *)wxButton {
    if (_wxButton == nil) {
        _wxButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_wxButton setBackgroundImage:[UIImage imageNamed:@"miyou_icon_weixin_cel_tongbu"] forState:UIControlStateSelected];
        [_wxButton setBackgroundImage:[UIImage imageNamed:@"miyou_icon_weixin_nor_tongbu"] forState:UIControlStateNormal];
        [_wxButton handleClickEvent:UIControlEventTouchUpInside withClickBlock:^(UIButton *sender) {
            sender.selected = !sender.selected;
            if (self.wxBlock) {
                self.wxBlock(sender.selected);
            }
        }];
//        if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
//            _wxButton.selected = YES;
//            _wxButton.userInteractionEnabled = NO;
//            
//        }
    }
    return _wxButton;
}

- (UIButton *)qqButton {
    if (_qqButton == nil) {
        _qqButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_qqButton setBackgroundImage:[UIImage imageNamed:@"miyou_icon_qq_cel"] forState:UIControlStateSelected];
        [_qqButton setBackgroundImage:[UIImage imageNamed:@"miyou_icon_QQ_nor_tongbu"] forState:UIControlStateNormal];
        
        [_qqButton handleClickEvent:UIControlEventTouchUpInside withClickBlock:^(UIButton *sender) {
            sender.selected = !sender.selected;
            if (self.qqBlock) {
                self.qqBlock(sender.selected);
            }
        }];
    }
    return _qqButton;
}

-(UIButton *)weiboButton {
    if (_weiboButton == nil) {
        _weiboButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_weiboButton setBackgroundImage:[UIImage imageNamed:@"miyou_icon_weibo_cel_tongbu"] forState:UIControlStateSelected];
        [_weiboButton setBackgroundImage:[UIImage imageNamed:@"miyou_icon_weibo_nor_tongbu"] forState:UIControlStateNormal];
        
        [_weiboButton handleClickEvent:UIControlEventTouchUpInside withClickBlock:^(UIButton *sender) {
            sender.selected = !sender.selected;
            if (self.weiboBlock) {
                self.weiboBlock(sender.selected);
            }
        }];
    }
    return _weiboButton;
}

@end
#pragma mark - 模型
@interface PublishModel : NSObject
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, assign) BOOL isWX;
@property (nonatomic, assign) BOOL isQQ;
@property (nonatomic, assign) BOOL isWeiBo;
@end
@implementation PublishModel

@end

#pragma mark - 仕途控制器
@interface TFPublishThemeVC () <UICollectionViewDelegate, UICollectionViewDataSource, CFImagePickerVCDelegate, UITextViewDelegate, DShareManagerDelegate>
{
    CGFloat H_textView;
    CGFloat H_photoView;
    UITapGestureRecognizer *_tap;
}
@property (nonatomic, strong) UIButton *publishButton;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) TFWaterFLayout *layout;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) SelectedPhotoView *addSelectedPhotoView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *placeLabel;
// Data
//@property (nonatomic, copy) NSString *location;
@property (nonatomic, strong) PublishModel *publishModel;
@property (nonatomic, strong) NSMutableArray *hotsSource;
@property (nonatomic, strong) NSMutableArray *selectedSource;
@property (nonatomic, strong) NSMutableArray *customSelectedSource;
@property (nonatomic, assign) CGFloat headerHeight;
@end

@implementation TFPublishThemeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setData];
    
    [self setUI];
}
- (void)setData {
    CGFloat minimumInteritemSpacing = ZOOM6(20);
    H_textView = ZOOM6(150);
    H_photoView = (kScreen_Width - ZOOM6(20) * 2 - 3 * minimumInteritemSpacing) / 4;
    self.headerHeight = H_textView + ZOOM6(20) +  H_photoView + ZOOM6(20) + ZOOM6(20);
}

- (void)setUI {
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardFramWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHidden)];
    
    [self setNavigationItemLeft:@"发布话题"];
    
    [self setNavigationItem];
    
    [self addCollectionView];
    
    [self getData];
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
    [self reloadSectionsArray:@[@2]];
}

- (void)addCollectionView {
    [self.view addSubview:self.collectionView];
}

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
    
    
//    [button handleClickEvent:UIControlEventTouchUpInside withClickBlock:^(UIButton *sender) {
//        
//        [self.view endEditing:YES];
//        
//        [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(publish)object:nil];
//        [self performSelector:@selector(publish)withObject:nil afterDelay:0.5f];
//    }];
    [publishButton addTarget:self action:@selector(publish:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)publish:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    
    PublishModel *model = self.publishModel;
    model.text = self.textView.text;
    
    if (model.text.length == 0 && model.photos.count == 0) {
        [nv showLable:@"还没有输入内容或添加图片哦~" Controller:self];
        return ;
    }
    if (model.text.length > 1000) {
        [nv showLable:@"最多只能输入10000个字哦~" Controller:self];
        return ;
    }
    if (!model.tags.count) {
        [nv showLable:@"还没有选择标签哦~" Controller:self];
        return ;
    }
    if (model.photos.count) {
        sender.selected=YES;
        [self uploadFileToUpYun];
    } else {
        [self httpPublish:nil];
    }
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
    
    if (customNames.count) {
        [parameter setValue:customTags forKey:@"customTags"];
    }
    if (dbId.count) {
        [parameter setValue:tags forKey:@"tags"];
    }
    
    [parameter setValue:@"3" forKey:@"theme_type"];
    
    NSString *area = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ARRER];
    if (area) {
        [parameter setValue:area forKey:@"location"];
    }
    
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:kApi parameter:parameter caches:NO cachesTimeInterval:0 token:YES success:^(id data, Response *response) {
        
        UIButton *btn=[self.navigationView viewWithTag:1000];
        btn.selected=NO;
//        MyLog(@"data: %@", data)
        
        if (response.status == 1) {
            [NavgationbarView showMessage:[NSString stringWithFormat:@"正在发布...(100%%)"]];
            
            
            [NSObject delay:0.5 completion:^{
                [self gotoShare:response.theme_id ImageArr:saveImagePaths];
                
                [NavgationbarView showMessage:[NSString stringWithFormat:@"发布成功!"]];
                [NavgationbarView dismiss];
            }];
            
            
            [NSObject delay:0.5 completion:^{
                [self.navigationController popViewControllerAnimated:YES];
                if (self.refreshBlock) {
                    self.refreshBlock();
                }
            }];
            
            [self shareView];
            
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

- (void)shareView {
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app shardk];
    DShareManager *ds = [DShareManager share];
    ds.delegate = self;
    
}

- (void)uploadFileToUpYun {
    BatchUploadImages *batchUpload = [[BatchUploadImages alloc] init];
    batchUpload.images = self.publishModel.photos;
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID];
    batchUpload.path = [NSString stringWithFormat:@"%@%@/", kIntimateCirclePicPath, userId];
    
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


#pragma mark - Collection Delegate

#pragma mark - 追加视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView= nil;
    if (kind == TFWaterFallSectionHeader) {
        if (indexPath.section == 0) {
            PulishHeaderView *header = [collectionView  dequeueReusableSupplementaryViewOfKind:TFWaterFallSectionHeader withReuseIdentifier:TFWaterFallSectionReuseIdentifier1 forIndexPath:indexPath];
            header.backgroundColor = [UIColor whiteColor];
            [header addSubview:self.textView];
            self.textView.frame = CGRectMake(ZOOM6(20), 0, kScreen_Width - ZOOM6(20) * 2, H_textView);
            [self.placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(@4);
                make.top.mas_equalTo(@5);
                make.height.mas_equalTo(ZOOM6(50));
            }];
            [header addSubview:self.addSelectedPhotoView];
            self.addSelectedPhotoView.frame = CGRectMake(ZOOM6(20), self.textView.bottom + ZOOM6(20), kScreen_Width - ZOOM6(20) * 2, H_photoView);
            [header addSubview:self.lineView];
            self.lineView.frame = CGRectMake(0, self.addSelectedPhotoView.bottom + ZOOM6(20), kScreen_Width, ZOOM6(20));
            reusableView = header;
            
        } else if (indexPath.section == 1) {
            CoustomTags *header = [collectionView  dequeueReusableSupplementaryViewOfKind:TFWaterFallSectionHeader withReuseIdentifier:TFWaterFallSectionReuseIdentifier2 forIndexPath:indexPath];
            header.isInputView = YES;
            header.tagLabel.text = [NSString stringWithFormat:@"自定义标签 (%zd/3)", [self.selectedSource count]];
            header.tagImageView.image = [UIImage imageNamed:@"miyou_icon_biaoqian"];
            header.backgroundColor = [UIColor whiteColor];
            if (self.selectedSource.count == 3 || header.inputTextField.text.length == 0) {
                header.okButton.selected = YES;
            }
            
            NavgationbarView *showView = [[NavgationbarView alloc] init];
            kWeakSelf(header);
            header.okButtonBlock = ^(NSString *text) {
                [self.view endEditing:YES];
                if (self.selectedSource.count == 3) {
                    [showView showLable:@"已经有3个标签了" Controller:self];
                    return;
                }
                if (text.length != 0) {
                    if ([self.selectedSource containsObject:text]) {
                        // 提示已经包括了
                        [showView showLable:@"您已经选过此标签" Controller:self];
                        return;
                    }
                    if ([self.hotsSource containsObject:text]) {
                        // 在热门里
                        weakheader.inputTextField.text = @"";
                        [self.selectedSource addObject:text];
                        [self reloadSectionsArray:@[@1, @2]];
                        return;
                    } else {
                        
                        NSRange range = [text rangeOfString:@","];
                        if (!(range.location == NSNotFound)) {
                            [showView showLable:@"标签不能为逗号" Controller:self];
                            return;
                        }
                        if ([text containsEmoji]) {
                            [showView showLable:@"标签不能为表情符号" Controller:self];
                            return;
                        }
                        
                        weakheader.inputTextField.text = @"";
//                        NSString *tempText = nil;
//                        if (text.length>5) {
//                            tempText = [NSString stringWithFormat:@"%@%@",[text substringToIndex:4], @"..."];
//                        } else {
//                            tempText = text;
//                        }
                        [self.selectedSource addObject:text];
                        [self reloadSectionsArray:@[@1]];
                    }
                } else {
                    // 提示重新输入
                    [showView showLable:@"请输入标签" Controller:self];
                }
            };
            
            reusableView = header;
        } else if (indexPath.section == 2) {
            CoustomTags *header = [collectionView  dequeueReusableSupplementaryViewOfKind:TFWaterFallSectionHeader withReuseIdentifier:TFWaterFallSectionReuseIdentifier3 forIndexPath:indexPath];
            header.isInputView = NO;
            header.tagLabel.text = @"热门标签";
            header.tagImageView.image = [UIImage imageNamed:@"miyou_icon_remen"];
            header.backgroundColor = [UIColor whiteColor];
            reusableView = header;
        } else if (indexPath.section == 3) {
            ShareTagsView *header = [collectionView  dequeueReusableSupplementaryViewOfKind:TFWaterFallSectionHeader withReuseIdentifier:TFWaterFallSectionReuseIdentifier4 forIndexPath:indexPath];
//            header.titleLabel.text = @"同步到";
//            [header setButtonBlockWithWxBlock:^(BOOL isSelected) {
//                self.publishModel.isWX = isSelected;
//            } qqBlock:^(BOOL isSelected) {
//                self.publishModel.isQQ = isSelected;
//            } weiboBlock:^(BOOL isSelected) {
//                self.publishModel.isWeiBo = isSelected;
//            }];
//            header.backgroundColor = [UIColor whiteColor];
//            reusableView = header;
            [header addSubview:self.shareview];
            reusableView = header;
        }
    }
    return reusableView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return [self.selectedSource count];
        case 2:
            return [self.hotsSource count];
        case 3:
            return 0;
            break;
            
        default:
            break;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TagsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kICCellIdentifier_TagsCell forIndexPath:indexPath];
    if (indexPath.section == 1) {
        
        SqliteManager *manager = [SqliteManager sharedManager];
        NSArray *array = [manager getAllForCircleTagItem];
        NSArray *sortArray = [manager sortCircleTagArrayWithSequenceFromSourceArray:array];
        NSMutableArray *dbNames = [NSMutableArray array];
        [sortArray enumerateObjectsUsingBlock:^(ShopTypeItem *item, NSUInteger idx, BOOL * _Nonnull stop) {
            [dbNames addObject:item.name];
        }];
        NSString *text = self.selectedSource[indexPath.item];
        __block NSString *tempText = text;
        
        [dbNames enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![tempText isEqualToString:obj]) {
                if (tempText.length>5) {
                    tempText = [NSString stringWithFormat:@"%@%@",[text substringToIndex:4], @"..."];
                } else {
                    tempText = text;
                }
            }
        }];
        
        [cell setText:tempText withSelected:NO];
        return cell;
    } else if (indexPath.section == 2) {
        NSString *text = self.hotsSource[indexPath.item];
        BOOL isSelected = NO;
        if ([self.selectedSource containsObject:text]) {
            isSelected = YES;
        }
        [cell setTextWithTags:text selected:isSelected];
        return cell;
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeZero;
    NSString *text = nil;
    if (indexPath.section == 1) {
//        text = self.selectedSource[indexPath.item];
        
        SqliteManager *manager = [SqliteManager sharedManager];
        NSArray *array = [manager getAllForCircleTagItem];
        NSArray *sortArray = [manager sortCircleTagArrayWithSequenceFromSourceArray:array];
        NSMutableArray *dbNames = [NSMutableArray array];
        [sortArray enumerateObjectsUsingBlock:^(ShopTypeItem *item, NSUInteger idx, BOOL * _Nonnull stop) {
            [dbNames addObject:item.name];
        }];
        NSString *text = self.selectedSource[indexPath.item];
        __block NSString *tempText = text;
        
        [dbNames enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![tempText isEqualToString:obj]) {
                if (tempText.length>5) {
                    tempText = [NSString stringWithFormat:@"%@%@",[text substringToIndex:4], @"..."];
                } else {
                    tempText = text;
                }
            }
        }];
        
        itemSize = [TagsCell cellSizeWithObj:tempText];
        return itemSize;
    } else if (indexPath.section == 2) {
        text = self.hotsSource[indexPath.item];
        NSString *myText = [NSString stringWithFormat:@"%@", text];
        itemSize = [TagsCell cellSizeWithObj:myText];
        return itemSize;
    }
    return itemSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return ZOOM6(20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return ZOOM6(20);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger) section {
    if (section == 0) {
        return self.headerHeight;
    } else if (section == 1) {
        return ZOOM6(20) + ZOOM6(40) + ZOOM6(20) + ZOOM6(60) +ZOOM6(20);
    } else if (section == 2) {
        return ZOOM6(40) + ZOOM6(40) + ZOOM6(20);
    } else if (section == 3) {
        return ZOOM6(140);
    }
    return  0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    if (indexPath.section == 1) {
        NSString *text = self.selectedSource[indexPath.item];
        
        TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] init];
        popView.title = @"是否删除该标签?";
        popView.message = text;
        popView.leftText = @"取消";
        popView.rightText = @"确定";
        popView.textAlignment = NSTextAlignmentCenter;
        [popView showCancelBlock:^{
        } withConfirmBlock:^{
            if ([self.hotsSource containsObject:text]) {
                [self.selectedSource removeObject:text];
                [self reloadSectionsArray:@[@1, @2]];
                return;
            }
            [self.selectedSource removeObject:text];
            [self reloadSectionsArray:@[@1]];
            return;
        } withNoOperationBlock:^{
        }];
    } else if (indexPath.section == 2) {
        NSString *text = self.hotsSource[indexPath.item];
        if ([self.selectedSource containsObject:text]) {
            [self.selectedSource removeObject:text];
            [self reloadSectionsArray:@[@1, @2]];
            return;
        }
        NavgationbarView *showView = [[NavgationbarView alloc] init];
        if (self.selectedSource.count == 3) {
                [showView showLable:@"已经有3个标签了" Controller:self];
            return;
        }
        if (![self.selectedSource containsObject:text]) {
            [self.selectedSource addObject:text];
            [self reloadSectionsArray:@[@1, @2]];
        }
    }
}

- (void)reloadSectionsArray:(NSArray *)sections {
    
    for (NSNumber *section in sections) {
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:section.integerValue]];
    }
    // 更新数据
    self.publishModel.tags = self.selectedSource;
}
#pragma mark - DShareManager Delegate
- (void)DShareManagerStatus:(SHARESTATE)shareStatus withType:(NSString *)type {
    
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

    [self.addSelectedPhotoView reloadPhotoCollectionViewHeight:^(CGFloat height) {
        [self setheaderHeightWithPhotoHeight:height];
    }];

    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TextView Delegate
-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        self.placeLabel.text = @"说点什么吧~";
    }else{
        self.placeLabel.text = @"";
    }
}


#pragma mark - Tools Method
- (void)keyBoardFramWillChange:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
//    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    [UIView animateWithDuration:duration delay:0.0f options:(curve << 16 | UIViewAnimationOptionBeginFromCurrentState) animations:^{
        
    } completion:nil];
    [self.view addGestureRecognizer:_tap];
}

- (void)keyBoardWillDisappear:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    [UIView animateWithDuration:duration delay:0.0f options:(curve << 16 | UIViewAnimationOptionBeginFromCurrentState) animations:^{
        
    } completion:nil];
    
    [self.view removeGestureRecognizer:_tap];
}

- (void)keyboardHidden {
    [self.view endEditing:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
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

#pragma mark - Getter
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
            NSLog(@"预览图片");
        };
        
        addSelectedPhotoView.addPhotoBlock = ^(NSIndexPath *currIndexPath) {
            [self.view endEditing:YES];
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
    self.headerHeight = H_textView + ZOOM6(20) + H_photoView + ZOOM6(20) + ZOOM6(20);
    self.layout.headerHeight = self.headerHeight;
    if (self.lineView.superview != nil && self.addSelectedPhotoView.superview != nil) {
        [self.lineView setY:self.addSelectedPhotoView.bottom + ZOOM6(20)];
        // 更新数据
        self.publishModel.photos = [self.addSelectedPhotoView.photoImagesData copy];
    }
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
        _placeLabel.text = @"说点什么吧~";
        _placeLabel.textColor = kNavLineColor;
        _placeLabel.font = kFont6px(30);
//        _placeLabel.enabled = NO;
        _placeLabel.userInteractionEnabled = NO;
        _placeLabel.backgroundColor = [UIColor clearColor];
    }
    return _placeLabel;
}


- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        TFWaterFLayout *layout = [[TFWaterFLayout alloc] init];
        layout.minimumColumnSpacing = ZOOM6(20);
        layout.minimumInteritemSpacing = ZOOM6(20);
        layout.sectionInset = UIEdgeInsetsMake(0, ZOOM6(20), 0, ZOOM6(20));
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, Height_NavBar + ZOOM6(20),
                                                                                                      kScreen_Width,
                                                                                                      kScreen_Height - (Height_NavBar + ZOOM6(20))) collectionViewLayout:_layout = layout];
        [collectionView registerClass:[TagsCell class] forCellWithReuseIdentifier:kICCellIdentifier_TagsCell];
        [collectionView registerClass:[PulishHeaderView class] forSupplementaryViewOfKind:TFWaterFallSectionHeader  withReuseIdentifier:TFWaterFallSectionReuseIdentifier1];
        [collectionView registerClass:[CoustomTags class] forSupplementaryViewOfKind:TFWaterFallSectionHeader  withReuseIdentifier:TFWaterFallSectionReuseIdentifier2];
        [collectionView registerClass:[CoustomTags class] forSupplementaryViewOfKind:TFWaterFallSectionHeader  withReuseIdentifier:TFWaterFallSectionReuseIdentifier3];
        [collectionView registerClass:[ShareTagsView class] forSupplementaryViewOfKind:TFWaterFallSectionHeader  withReuseIdentifier:TFWaterFallSectionReuseIdentifier4];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        
        collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (PublishModel *)publishModel {
    if (_publishModel == nil) {
        _publishModel = [[PublishModel alloc] init];
    }
    return _publishModel;
}

- (NSMutableArray *)hotsSource {
    if (_hotsSource == nil) {
        _hotsSource = [NSMutableArray array];
        
        NSArray *hots = @[@"今天穿什么", @"闲置", @"明星八卦",
                          @"情感", @"健身", @"星座", @"旅行", @"美食"];
//        [_hotsSource addObjectsFromArray:hots];
    }
    return _hotsSource;
}


- (NSMutableArray *)selectedSource {
    if (_selectedSource == nil) {
        _selectedSource = [NSMutableArray array];
    }
    return _selectedSource;
}

- (NSMutableArray *)customSelectedSource {
    if (_customSelectedSource) {
        _customSelectedSource = [NSMutableArray array];
    }
    return _customSelectedSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 分享
- (SharePlatformView*)shareview
{
    if(_shareview == nil)
    {
        _shareview = [[SharePlatformView alloc]initWithFrame:CGRectMake(0, ZOOM6(20), ZOOM6(470), ZOOM6(100))];
        
        _shareview.shareFinishBlock = ^{//分享结束
            
        };
    }
    return _shareview;
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
    //同步分享
    if(self.shareview.weiboBtn.selected || self.shareview.QQbtn.selected || self.shareview.weiboBtn.selected)
    {
        [self.shareview goshare:YES];
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
