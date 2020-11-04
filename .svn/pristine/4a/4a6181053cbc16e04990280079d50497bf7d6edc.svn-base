//
//  AddTagsViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/4/12.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "AddTagsViewController.h"
#import "UIView+ZYTagView.h"
#import "ZYTagImageView.h"
#import "GlobalTool.h"

#import "CFImagePickerVC.h"
#import "BrandAndStyleChoseVC.h"
#import "NewPublishThemeAndDressVC.h"

@interface AddTagsViewController ()<ZYTagImageViewDelegate,CFImagePickerVCDelegate>
{
    CGFloat imageViewWidth;
    CGFloat imageViewHeight;
}
@property (nonatomic, strong) NSArray *tagInfoArray;
@property (nonatomic, strong) ZYTagImageView *imageView;
@property (nonatomic, strong) ZYTagInfo *info1;
@end

@implementation AddTagsViewController
- (void)dealloc
{
    MyLog(@"%@ release", [self class]);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self loadImagePickerVC];
//    [self performSelector:@selector(setUI) withObject:self afterDelay:1];

    [self setUI];
}
/*
- (void)loadImagePickerVC {
    CFImagePickerVC *doimg = [[CFImagePickerVC alloc] init];
    doimg.delegate = self;
    doimg.nColumnCount = 4;
    doimg.nResultType = DO_PICKER_RESULT_UIIMAGE;
    doimg.nMaxCount = 1;
    doimg.isPublish=YES;
    [self presentViewController:doimg animated:YES completion:nil];
}
*/
- (void)setUI {
    [self creatHeadView];
    [self creatMainview];
    [self creatLable];
}

//导航条
- (void)creatHeadView
{
    self.tabheadview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    [self.view addSubview:self.tabheadview];
    self.tabheadview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 60, 44);
    backbtn.centerY = View_CenterY(self.tabheadview);
    [backbtn setTitle:@"取消" forState:UIControlStateNormal];
    [backbtn setTitleColor:kMainTitleColor forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.tabheadview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, self.tabheadview.frame.size.height/2+10);
    titlelable.text=@"添加标签";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [self.tabheadview addSubview:titlelable];
    
    self.nextButtonn=[[UIButton alloc]init];
    self.nextButtonn.frame=CGRectMake(kApplicationWidth-ZOOM6(140), 23, ZOOM6(140), 40);
    self.nextButtonn.centerY = View_CenterY(self.tabheadview);
    [self.nextButtonn setTitle:@"下一步" forState:UIControlStateNormal];
    self.nextButtonn.titleLabel.font=[UIFont systemFontOfSize:16];
    [self.nextButtonn setTitleColor:RGBCOLOR_I(125, 125, 125) forState:UIControlStateNormal];
    [self.nextButtonn setTitleColor:tarbarrossred forState:UIControlStateSelected];

    self.nextButtonn.selected = YES;
    [self.nextButtonn addTarget:self action:@selector(Next) forControlEvents:UIControlEventTouchUpInside];
    [self.tabheadview addSubview:self.nextButtonn];

    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, Height_NavBar-1, kScreenWidth, 1)];
    lineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.view addSubview:lineView];
    
}
//图片下面的文字
- (void)creatLable
{
    NSArray *titleArray = @[@"点击图片可以添加标签",@"最多可添加4个标签喔"];
    CGFloat lableHeigh = ZOOM6(50);
    for(int i =0;i<titleArray.count;i++)
    {
        UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), (kScreenHeight-ZOOM6(200))+ZOOM6(50)+i*lableHeigh, kScreenWidth-2*ZOOM6(20), lableHeigh)];
        titlelab.textAlignment = NSTextAlignmentCenter;
        titlelab.text = titleArray[i];
        titlelab.tag=101+i;
        if(i == 0)
        {
            titlelab.textColor = tarbarrossred;
            titlelab.font = [UIFont systemFontOfSize:ZOOM6(28)];
        }else{
            titlelab.textColor = kMainTitleColor;
            titlelab.font = [UIFont systemFontOfSize:ZOOM6(24)];
        }
        [self.view addSubview:titlelab];
    }
}
- (void)changRemindLabel {
    UILabel *label=[self.view viewWithTag:101];
    label.text=@"点击标签可以自动移动哦~";
    UILabel *label2=[self.view viewWithTag:102];
    label2.text=@"点击图片可继续添加标签";
}
- (ZYTagImageView *)imageView {
    if (_imageView==nil) {
//        UIImage *image = [UIImage imageNamed:@"fan"];

        _imageView = [[ZYTagImageView alloc] initWithImage:self.tagImage];
        _imageView.delegate = self;
//        _imageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-ZOOM6(200));
        
        CGFloat height = kScreenHeight-Height_NavBar-ZOOM6(200);
        //根据image的比例来设置高度
        imageViewWidth = kScreenWidth;
        imageViewHeight = 0;
        imageViewHeight = _tagImage.size.height / _tagImage.size.width * imageViewWidth;
        if (imageViewHeight >= height) {
            imageViewHeight = kScreenHeight-Height_NavBar-ZOOM6(200);
            imageViewWidth = _tagImage.size.width / _tagImage.size.height * imageViewHeight;
        }
        _imageView.frame = CGRectMake((kScreenWidth-imageViewWidth)/2, (kScreenHeight-Height_NavBar-ZOOM6(200)-imageViewHeight)/2, imageViewWidth, imageViewHeight);
        
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}
#pragma mark 主要标签视图
- (void)creatMainview
{
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar-ZOOM6(200))];
    backview.backgroundColor = [UIColor blackColor];
    [self.view addSubview:backview];
    
//    UIImage *image = [UIImage imageNamed:@"fan"];
    
//    ZYTagImageView *imageView = [[ZYTagImageView alloc] initWithImage:image];
//    imageView.delegate = self;
//    imageView.frame = CGRectMake(0, 0, CGRectGetWidth(backview.frame), CGRectGetHeight(backview.frame));
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
//    imageView.clipsToBounds = YES;
    [backview addSubview:self.imageView];
//    self.imageView = imageView;
    
    // 添加标签
    self.info1 = [ZYTagInfo tagInfo];
    self.info1.point = CGPointMake((kScreenWidth-100)/2, (CGRectGetHeight(_imageView.frame)-40)/2);
    self.info1.title = @"这是什么品牌?";
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:7];
    [dic setValue:self.info1.title forKey:@"label_name"];
    self.info1.dic=dic;
//    self.info1.isShopTag=YES;

    
    [_imageView addTagsWithTagInfoArray:@[self.info1]];
    
//    // 清除标签 恢复标签
//    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [clearButton setTitle:@"清除标签" forState:UIControlStateNormal];
//    [clearButton setTitle:@"恢复标签" forState:UIControlStateSelected];
//    [clearButton addTarget:self action:@selector(clickClearBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [clearButton sizeToFit];
//    clearButton.zy_x = imageView.zy_x;
//    clearButton.zy_y = imageView.zy_bottom + 10;
//    [self.view addSubview:clearButton];
    
//    // 浏览模式 编辑模式
//    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [editButton setTitle:@"浏览模式" forState:UIControlStateNormal];
//    [editButton setTitle:@"编辑模式" forState:UIControlStateSelected];
//    [editButton addTarget:self action:@selector(clickEditBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [editButton sizeToFit];
//    editButton.zy_x = imageView.zy_x;
//    editButton.zy_y = clearButton.zy_bottom + 10;
//    [self.view addSubview:editButton];

}
#pragma mark - event 清除
- (void)clickClearBtn:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        self.tagInfoArray = [self.imageView getAllTagInfos];
        [self.imageView removeAllTags];
    }else{
        [self.imageView addTagsWithTagInfoArray:self.tagInfoArray];
    }
}
#pragma mark - event 编辑
- (void)clickEditBtn:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
    [self.imageView setAllTagsEditEnable:!btn.selected];
}

- (void)addBrandAndStyle:(CGPoint)tapPoint tagView:(ZYTagView *)tagView isUpdate:(BOOL)isUpdate {
    kSelfWeak;
    kWeakSelf(tagView);
    BrandAndStyleChoseVC *vc=[[BrandAndStyleChoseVC alloc]init];
    if (isUpdate) {
        if (![tagView.tagInfo.title isEqualToString:self.info1.title]) {
            vc.sectionType=tagView.tagInfo.isShopTag?Section_ShopType:Section_NormalType;
            
            if (tagView.tagInfo.isShopTag==NO) {
                vc.brandStr=tagView.tagInfo.title;
                vc.styleStr=tagView.tagInfo.detailTitle.length?tagView.tagInfo.detailTitle:@"";
                [vc.detailArr replaceObjectAtIndex:0 withObject:tagView.tagInfo.title];
                [vc.detailArr replaceObjectAtIndex:1 withObject:tagView.tagInfo.detailTitle.length?tagView.tagInfo.detailTitle:@""];
            }
        }
    }
    vc.tagMsgblock = ^(NSString *brandStr,NSString *styleStr,NSString *brandID, NSString *style, NSString *type1, NSString *type2,NSString *shop_code) {

        if(weakSelf.info1) {
            weakSelf.tagInfoArray = [weakSelf.imageView getAllTagInfos];
            [weakSelf.imageView removeAllTags];
        }
        NSString *str=brandStr.length?brandStr:@"衣蝠精选";
        if (isUpdate&&!weakSelf.info1) {
            //更新时 清除之前信息
            if (brandID) {
                [weaktagView.tagInfo.dic removeObjectForKey:@"label_name"];

                [weaktagView.tagInfo.dic setValue:[NSNumber numberWithInt:1] forKey:@"label_type"];
                [weaktagView.tagInfo.dic setValue:[NSNumber numberWithInteger:[brandID integerValue]]  forKey:@"label_id"];
            }else{
                [weaktagView.tagInfo.dic removeObjectForKey:@"label_id"];

                [weaktagView.tagInfo.dic setValue:[NSNumber numberWithInt:2] forKey:@"label_type"];
                [weaktagView.tagInfo.dic setValue:str forKey:@"label_name"];
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"publishUpdateDB"];
            }
            [weaktagView updateTitle:str];
        }else{
            ZYTagInfo *tagInfo = [ZYTagInfo tagInfo];
            tagInfo.title=str;
            tagInfo.detailTitle=styleStr;
            tagInfo.isShopTag = shop_code!=nil;
            tagInfo.point=tapPoint;
            tagInfo.dic=[weakSelf getTagInfoDictionaryWithLabel_id:brandID label_name:str style:style type1:type1 type2:type2 tapPoint:tapPoint shop_code:shop_code is_ShopTag:tagInfo.isShopTag];
            [weakSelf.imageView addTagWithTagInfo:tagInfo];
        }
        weakSelf.info1 = nil;

        weakSelf.nextButtonn.selected=YES;
        [weakSelf changRemindLabel];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - ZYTagImageViewDelegate 点击图片
- (void)tagImageView:(ZYTagImageView *)tagImageView activeTapGesture:(UITapGestureRecognizer *)tapGesture
{
    
    /******  最多只能添加4个标签  ****/
    NSArray *arr = [self.imageView getAllTagInfoDics];
    if (arr.count>=4) {
        [NavgationbarView showMessageAndHide:@"最多只能添加4个标签"];
        return;
    }
    CGPoint tapPoint = [tapGesture locationInView:tagImageView];
    [self addBrandAndStyle:tapPoint tagView:nil isUpdate:NO];

}

- (void)tagImageView:(ZYTagImageView *)tagImageView tagViewActiveTapGesture:(ZYTagView *)tagView
{
    /** 可自定义点击手势的反馈 */
    if (tagView.isEditEnabled) {
        NSLog(@"编辑模式 -- 轻触");

        CGPoint tapPoint = CGPointMake((kScreenWidth-100)/2, (CGRectGetHeight(_imageView.frame)-40)/2);
        [self addBrandAndStyle:tapPoint tagView:tagView isUpdate:YES];

    }else{
        NSLog(@"预览模式 -- 轻触");
    }
}

- (void)tagImageView:(ZYTagImageView *)tagImageView tagViewActiveLongPressGesture:(ZYTagView *)tagView
{
    /** 可自定义长按手势的反馈 */
    /*
    if (tagView.isEditEnabled) {
        NSLog(@"编辑模式 -- 长按");
        
        UIAlertController *alVC = [UIAlertController alertControllerWithTitle:@"修改标签" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.text = tagView.tagInfo.title;
        }];
        UIAlertAction *ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (((UITextField *)(alVC.textFields[0])).text.length) {
                [tagView updateTitle:((UITextField *)(alVC.textFields[0])).text];
            }
        }];
        [alVC addAction:ac];
        [self presentViewController:alVC animated:YES completion:nil];
        
    }else{
        NSLog(@"预览模式 -- 长按");
    }
    */
}
#pragma mark - ImagePickerVC Delegate
- (void)didCancelDoImagePickerController {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didSelectPhotosFromDoImagePickerController:(CFImagePickerVC *)picker result:(NSArray *)aSelected {
    self.imageView.image = aSelected[0];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 下一步
- (void)Next
{
    if(self.nextButtonn.selected)
    {
        NewPublishThemeAndDressVC *vc=[[NewPublishThemeAndDressVC alloc]init];
        vc.tagImg=self.imageView.image;
        NSMutableArray *arr = [self.imageView getAllTagInfoDics];

        //移除默认标签的信息
        if ([arr containsObject:self.info1.dic]) {
            [arr removeObject:self.info1.dic];
        }
        MyLog(@"--jsonSuppLabel %@",arr);
        vc.jsonSuppLabel=arr;
        kSelfWeak;
        vc.refreshBlock = ^{
            if (weakSelf.refreshBlock) {
                weakSelf.refreshBlock();
            }
        };
        [self.navigationController pushViewController:vc animated:YES];
    }

}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSMutableDictionary *)getTagInfoDictionaryWithLabel_id:(NSString *)brandID  label_name :(NSString *)label_name style:(NSString *)style type1:(NSString *)type1 type2:(NSString *)type2 tapPoint:(CGPoint )tapPoint shop_code:(NSString *)shop_code is_ShopTag:(BOOL)is_ShopTag{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:7];
    if (is_ShopTag) {
        [dic setValue:[NSString stringWithFormat:@"%@",shop_code]  forKey:@"shop_code"];
        [dic setValue:[NSNumber numberWithInt:1] forKey:@"label_type"];
        [dic setValue:[NSNumber numberWithInteger:[brandID integerValue]]  forKey:@"label_id"];
//        label_name=@"";
    }else {
        
        if (brandID) {
            [dic setValue:[NSNumber numberWithInt:1] forKey:@"label_type"];
            [dic setValue:[NSNumber numberWithInteger:[brandID integerValue]]  forKey:@"label_id"];
        }else{
            [dic setValue:[NSNumber numberWithInt:2] forKey:@"label_type"];
            [dic setValue:label_name forKey:@"label_name"];
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"publishUpdateDB"];
        }
        [dic setValue:[NSNumber numberWithInteger:[style integerValue]] forKey:@"style"];
        [dic setValue:[NSNumber numberWithInteger:[type1 integerValue]] forKey:@"type1"];
        [dic setValue:[NSNumber numberWithInteger:[type2 integerValue]] forKey:@"type2"];
    }

    
    CGFloat x=tapPoint.x/imageViewWidth;
    CGFloat y=tapPoint.y/imageViewHeight;
    [dic setValue:[NSString stringWithFormat:@"%f",x] forKey:@"label_x"];
    [dic setValue:[NSString stringWithFormat:@"%f",y]  forKey:@"label_y"];

    int i = tapPoint.x>kScreenWidth/2 ? 1 : 0;
    NSString *direction=[NSString stringWithFormat:@"%zd",i];
    [dic setValue:direction  forKey:@"direction"];
    
//    [dic setValue:[NSNumber numberWithInteger:tapPoint.x] forKey:@"label_x"];
//    [dic setValue:[NSNumber numberWithInteger:tapPoint.y] forKey:@"label_y"];
    return dic;
}
@end
