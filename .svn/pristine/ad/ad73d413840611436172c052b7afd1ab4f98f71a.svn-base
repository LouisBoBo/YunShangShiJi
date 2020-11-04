//
//  TFCustomCameraViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/28.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFCustomCamera.h"
#import "GlobalTool.h"
 
#import "MBProgressHUD+NJ.h"
#import <AVFoundation/AVFoundation.h>



#import "CameraVC.h"
@interface TFCustomCamera ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong)NSMutableArray *imgArr;
@property (nonatomic, strong)UIImagePickerController *imagePikerViewController;
@property (nonatomic, strong)UIImageView *photoImgView;

@property (nonatomic, strong)UIButton *takePhotoBtn; 
@property (nonatomic, strong)UILabel *countLabel;
@property (nonatomic, strong)UIScrollView *listScrollView;
@property (nonatomic, strong)UIButton *changeBtn;


@end

@implementation TFCustomCamera

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.photoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.photoImgView.userInteractionEnabled = YES;
    self.photoImgView.backgroundColor = [UIColor clearColor];
    self.photoImgView.contentMode = UIViewContentModeScaleAspectFit; //充满
    [self.view addSubview:self.photoImgView];
    

//    //photoImgView.frame = %@",NSStringFromCGRect(self.photoImgView.frame));
    
    [self createUI];
    [self createPikerView];
    
    AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authorizationStatus == AVAuthorizationStatusRestricted
        || authorizationStatus == AVAuthorizationStatusDenied) {
        
        // 没有权限
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请在设备的\"设置-隐私-相机\"中允许访问相机。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }

}


- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (BOOL)cameraAvailable
{
    BOOL result = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    
    return result;
}

- (void)createUI
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.photoImgView.frame.size.height-140, kScreenWidth, 140)];
    bottomView.backgroundColor = COLOR_ROSERED;
    [self.photoImgView addSubview:bottomView];
    
    self.listScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    self.listScrollView.backgroundColor = RGBCOLOR_I(22,22,22);
    self.listScrollView.bounces = NO;
    self.listScrollView.pagingEnabled = YES;
    [bottomView addSubview:self.listScrollView];
    
    //拍照按钮
    self.takePhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.takePhotoBtn.frame = CGRectMake(kScreenWidth/2-30,  self.listScrollView.bottom, 60, 60);
    self.takePhotoBtn.layer.masksToBounds = YES;
    self.takePhotoBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.takePhotoBtn.layer.borderWidth = 10;
    self.takePhotoBtn.layer.cornerRadius = 30;
    [self.takePhotoBtn addTarget:self action:@selector(takePhotoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:self.takePhotoBtn];
    
    //确定按钮
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake(kScreenWidth/2+30,  self.listScrollView.bottom, (kScreenWidth/2-30)/2, bottomView.frame.size.height-self.listScrollView.frame.size.height);
    [okBtn addTarget:self action:@selector(okBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:okBtn];
    //关闭
    UIButton *canlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    canlBtn.frame = CGRectMake( okBtn.right,  self.listScrollView.bottom, okBtn.frame.size.width, okBtn.frame.size.height);
    [canlBtn addTarget:self action:@selector(calBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:canlBtn];
    
    //
    UIImageView *okIv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    okIv.center = okBtn.center;
    okIv.image = [UIImage imageNamed:@"TFCheck"];
    [bottomView addSubview:okIv];
    
    UIImageView *canlIv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    canlIv.center = canlBtn.center;
    canlIv.image = [UIImage imageNamed:@"TFClose"];
    [bottomView addSubview:canlIv];

    //显示张数
    self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,  self.listScrollView.bottom+15, 150, 30)];
    self.countLabel.text = [NSString stringWithFormat:@"已拍摄(%d/%d)",(int)self.imgArr.count,self.maxPhotoCount];
    self.countLabel.font = [UIFont systemFontOfSize:14];
    self.countLabel.textColor = [UIColor whiteColor];
    [bottomView addSubview:self.countLabel];
    
    self.changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changeBtn.frame = CGRectMake(self.photoImgView.frame.size.width-80, 30, 60, 60);
    [self.changeBtn setBackgroundImage:[UIImage imageNamed:@"TFcamera_fornt@2x"] forState:UIControlStateNormal];
    [self.changeBtn addTarget:self action:@selector(changeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.photoImgView addSubview:self.changeBtn];
    
}

- (void)createPikerView
{
    if ([self cameraAvailable] == NO) {

        [self.imagePikerViewController dismissViewControllerAnimated:NO completion:^{
            [self.navigationController popViewControllerAnimated:NO];
        }];
    } else {

        self.imagePikerViewController = [[UIImagePickerController alloc] init];
        self.imagePikerViewController.delegate = self;
        self.imagePikerViewController.allowsEditing = YES;
        self.imagePikerViewController.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.imagePikerViewController.showsCameraControls = NO;

        [self.imagePikerViewController.view addSubview:self.photoImgView];
        [self presentViewController:self.imagePikerViewController animated:NO completion:NULL];
    }
    
   
}


- (void)okBtnClick
{
    if (self.imgArr.count == 0) {
        [MBProgressHUD showError:@"请拍摄照片"];
    } else {

        if ([self.delegate respondsToSelector:@selector(SelectPhotoEnd:WithPhotoArray:)]) {
            [self.delegate SelectPhotoEnd:self WithPhotoArray:self.imgArr];
        }
        [self.imagePikerViewController dismissViewControllerAnimated:NO completion:^{
            [self.navigationController popViewControllerAnimated:NO];
        }];
    }
}

- (void)calBtnClick
{

    [self.imagePikerViewController dismissViewControllerAnimated:NO completion:^{
        [self.navigationController popViewControllerAnimated:NO];
    }];
}

- (void)takePhotoBtnClick:(UIButton *)sender
{
    if (self.imgArr.count >= self.maxPhotoCount) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"达到最大张数%d张,向上拖动删除",self.maxPhotoCount]];
    } else {
        [self.imagePikerViewController takePicture];
    }
}
//切换摄像头
- (void)changeBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected == YES) { //前置
        [UIView transitionWithView:self.imagePikerViewController.view duration:1.0 options:UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionTransitionCurlDown animations:^{
            self.imagePikerViewController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        } completion:NULL];
    } else{ //后置
        [UIView transitionWithView:self.imagePikerViewController.view duration:1.0 options:UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionTransitionCurlUp animations:^{
            [self.imagePikerViewController setCameraDevice:UIImagePickerControllerCameraDeviceRear];
        } completion:NULL];
    }
}
#pragma mrk - 刷新图片
- (void)setListScrollViewPhoto
{
    for (UIImageView *iv in self.listScrollView.subviews) {
        [iv removeFromSuperview];
    }
    
    self.listScrollView.contentSize = CGSizeMake(80*self.imgArr.count, 0);

    for (int i = 0; i<self.imgArr.count; i++) {
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(10+i*60+i*10, 10, 60, 60)];
        iv.image = self.imgArr[i];
        iv.userInteractionEnabled = YES;
        [self.listScrollView addSubview:iv];
        
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
        swipe.direction = UISwipeGestureRecognizerDirectionUp;
        swipe.numberOfTouchesRequired = 1;
        [iv addGestureRecognizer:swipe];
    }
}

- (void)handleSwipes:(UISwipeGestureRecognizer *)swipe
{
    UIImageView *iv = (UIImageView *)swipe.view;
    [self.imgArr removeObject:iv.image];
     self.countLabel.text = [NSString stringWithFormat:@"已拍摄(%d/%d)",(int)self.imgArr.count,self.maxPhotoCount];
    [self setListScrollViewPhoto];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage * image = info[UIImagePickerControllerEditedImage];
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    if (self.imgArr.count<self.maxPhotoCount) {
        [self.imgArr addObject:image];
        
        //self.imgArr = %@",self.imgArr);
        self.countLabel.text = [NSString stringWithFormat:@"已拍摄(%d/%d)",(int)self.imgArr.count,self.maxPhotoCount];
        [self setListScrollViewPhoto];
    }
   
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
//    [self dismissViewControllerAnimated:YES completion:NULL];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Myview.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
}
- (NSMutableArray *)imgArr
{
    if (_imgArr == nil) {
        _imgArr = [[NSMutableArray alloc] init];
    }
    return _imgArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/**
 *  裁减图片
 *
 *  @return 裁减后的图片
 */

/**
 *
 
 我该如何降低iPhone的Objective-C图像质量/大小？
 objective-c ios uiimage uiimagepickercontroller
 我有一个应用程序，让把他/她的iPhone它的图片作为程序的背景图。UIImagePickerController让拍照和设置背景UIImageView图像返回UIImage对象。
 
 IBOutlet UIImageView *backgroundView;
 -(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    backgroundView.image = image;
    [self dismissModalViewControllerAnimated:YES];
 }

 
 1. 您可以创建一个图形上下文，绘制图像成在所需的规模，返回的图像。例如：
 
 UIGraphicsBeginImageContext(CGSizeMake(480,320));
 CGContextRef   context = UIGraphicsGetCurrentContext();
 [image drawInRect: CGRectMake(0, 0, 480, 320)];
 UIImage  *smallImage = UIGraphicsGetImageFromCurrentImageContext();
 UIGraphicsEndImageContext();
 
 2. 我知道这个问题已经解决了，只是如果（像我一样）要缩放图像保持ECT比，这段代码可能会有所帮助：
 
 -(UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)size
 {
     float width = size.width;
     float height = size.height;
 
     UIGraphicsBeginImageContext(size);
     CGRect rect = CGRectMake(0, 0, width, height);
 
     float widthRatio = image.size.width / width;
     float heightRatio = image.size.height / height;
     float divisor = widthRatio > heightRatio ? widthRatio : heightRatio;
     width = image.size.width / divisor;
     height = image.size.height / divisor;
     rect.size.width = width;
     rect.size.height = height;
     if(height < width)
     rect.origin.y = height / 3;
 
     [image drawInRect: rect];
 
     UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     return smallImage;
 }

 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
