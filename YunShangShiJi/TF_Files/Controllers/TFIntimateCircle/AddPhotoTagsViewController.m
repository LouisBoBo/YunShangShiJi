//
//  AddPhotoTagsViewController.m
//  YunShangShiJi
//
//  Created by yssj on 2017/4/10.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "AddPhotoTagsViewController.h"
#import "CFImagePickerVC.h"
#import "BrandAndStyleChoseVC.h"

@interface AddPhotoTagsViewController ()

@end

@implementation AddPhotoTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
//    [self loadImagePickerVC];
//    [self performSelector:@selector(setUI) withObject:self afterDelay:1];
    [self setNavigationItemLeftAndRight];
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
    [self setNavigationItemLeftAndRight];
}
- (void)setNavigationItemLeftAndRight{
    
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    headview.image=[UIImage imageNamed:@"导航背景"];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 80, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn addTarget:self action:@selector(leftBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    //    [backbtn setImage:[UIImage imageNamed:@"返回按钮_高亮"] forState:UIControlStateHighlighted];
    [backbtn setTitle:@"取消" forState:UIControlStateNormal];
    [backbtn setTitleColor:kMainTitleColor forState:UIControlStateNormal];
    [headview addSubview:backbtn];
    
    UIButton *setbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    setbtn.frame=CGRectMake(kScreenWidth-80, 20, 80, 44);
    setbtn.centerY = View_CenterY(headview);
    [setbtn addTarget:self action:@selector(rightBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
//    [setbtn setImage:[UIImage imageNamed:@"消息按钮_正常"] forState:UIControlStateNormal];
    //    [setbtn setImage:[UIImage imageNamed:@"消息按钮_高亮"] forState:UIControlStateHighlighted];
    [setbtn setTitle:@"下一步" forState:UIControlStateNormal];
    [setbtn setTitleColor:kMainTitleColor forState:UIControlStateNormal];
    [headview addSubview:setbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, headview.frame.size.width, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
}

#pragma mark - ImagePickerVC Delegate
- (void)didCancelDoImagePickerController {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didSelectPhotosFromDoImagePickerController:(CFImagePickerVC *)picker result:(NSArray *)aSelected {
    
//    [self.addSelectedPhotoView.photoImagesData addObjectsFromArray:aSelected];
//    [self.addSelectedPhotoView.imagesData removeAllObjects];
//    [self.addSelectedPhotoView.imagesData addObjectsFromArray:self.addSelectedPhotoView.photoImagesData];
//    if (self.addSelectedPhotoView.photoImagesData.count < self.addSelectedPhotoView.maxPhotoCount) {
//        [self.addSelectedPhotoView.imagesData addObject:[self.addSelectedPhotoView addImage]];
//    }
//    
//    [self.addSelectedPhotoView reloadPhotoCollectionViewHeight:^(CGFloat height) {
//        [self setheaderHeightWithPhotoHeight:height];
//    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)rightBarButtonClick {
    BrandAndStyleChoseVC *vc=[[BrandAndStyleChoseVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
