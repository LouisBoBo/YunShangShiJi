//
//  TryViewController.m
//  JinZongCai
//
//  Created by JZC on 14-9-2.
//  Copyright (c) 2014年 Jacky. All rights reserved.
//

#import "CameraVC.h"
#import "GlobalTool.h"
#import "MBProgressHUD.h"
//#import "shear_ScreenView.h"


@interface CameraVC ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,UIScrollViewDelegate,UIPopoverControllerDelegate>
{
   
    UIImageView *_overlayBG;
    UIImageView *_overlayBG2;
    UIScrollView *TrymoreScrollView;
    NSMutableArray *imagearr;
    UIView *trybackview;;
    
    UIButton *backBtn;
    UIButton *shootBtn;
    UIButton *photoBtn;
    UIButton *changeBtn;
    UIImageView *changeimg;
    UIButton *OkBtn;
    
    UIImagePickerController *_imgPicker;

    UILabel *numblelable;
}

@end

@implementation CameraVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden=YES;
    imagearr=[NSMutableArray array];
    self.view.backgroundColor =[UIColor whiteColor];
    
    _overlayBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight)];
    _overlayBG.backgroundColor = [UIColor clearColor];
    _overlayBG.userInteractionEnabled = YES;
    _overlayBG.contentMode=UIViewContentModeScaleAspectFit;
    [self.view addSubview:_overlayBG];
    
    [self beforeShootControlBtns];
    
    [self takePhoto];
  
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
-(void)okclick
{
    
    __weak typeof(self) weakSelf = self;
    
    UIView *SupView = [[UIApplication sharedApplication].delegate window];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
            if (_imgPicker) {
                
                
                [_imgPicker dismissViewControllerAnimated:NO completion:^{
                    [weakSelf.navigationController popViewControllerAnimated:NO];
                    [weakSelf performSelector:@selector(SelectPhotoEnd:) withObject:imagearr afterDelay:0.5];
                }];
                
                
            }else{
                
                [weakSelf.navigationController popViewControllerAnimated:NO];
                [weakSelf performSelector:@selector(SelectPhotoEnd:) withObject:imagearr afterDelay:0.5];
            }
        
    });
    
    if(imagearr.count)
    {
        NSNotification *imagenote = [[NSNotification alloc]initWithName:@"cameraImage" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:imagenote];
    }

}

-(void)SelectPhotoEnd:(id)object{
    
    imagearr = object;
    
    if(imagearr.count)
    {
        if (_delegate) {
            [_delegate SelectPhotoEnd:self WithPhotoArray:imagearr];
        }
    }else{
        
        [self.navigationController popViewControllerAnimated:NO];
    }
    
}

-(void)offclick
{

    if (_imgPicker) {
        [_imgPicker dismissViewControllerAnimated:NO completion:^{
            [self.navigationController popViewControllerAnimated:NO];
        }];
    }else{
        [self.navigationController popViewControllerAnimated:NO];
    }

}
-(void)showtap:(UITapGestureRecognizer *)tap
{
    _overlayBG2.image=nil;
}
- (void)beforeShootControlBtns
{
    
    _overlayBG2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight-143)];
    _overlayBG2.backgroundColor = [UIColor clearColor];
    _overlayBG2.userInteractionEnabled = YES;
    _overlayBG2.contentMode=UIViewContentModeScaleAspectFit;
    [_overlayBG addSubview:_overlayBG2];
    
    UITapGestureRecognizer *showtap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showtap:)];
    [_overlayBG2 addGestureRecognizer:showtap];
    
    trybackview=[[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight-143+kUnderStatusBarStartY, kApplicationWidth,143)];
    
#pragma mark - 颜色调整
    trybackview.backgroundColor=[UIColor blackColor];
    [_overlayBG addSubview:trybackview];
    
    //关闭按钮
    backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(kApplicationWidth-58, 85, 50, 50);
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self action:@selector(offclick) forControlEvents:UIControlEventTouchUpInside];
    [trybackview addSubview:backBtn];
    
    UIImageView *im=[[UIImageView alloc]init];
    im.frame=Frame(10, 10, 30, 30);
    im.image=ImageNamed(@"close");
    [backBtn addSubview:im];
    
    //确定按钮
    OkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    OkBtn.frame = CGRectMake(kApplicationWidth-120, 85, 50, 50);
    OkBtn.backgroundColor = [UIColor clearColor];
    [OkBtn addTarget:self action:@selector(okclick) forControlEvents:UIControlEventTouchUpInside];
    [trybackview addSubview:OkBtn];
    
    
    UIImageView *im2=[[UIImageView alloc]init];
    im2.frame=im.frame;
    im2.image=[UIImage imageNamed:@"check"];
    [OkBtn addSubview:im2];
    
    //切换摄像头
    changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    changeBtn.selected=NO;
    changeBtn.alpha=0.85;
    changeBtn.frame = CGRectMake(kApplicationWidth-56, 10, 46, 46);
    
#pragma mark - 颜色调整
    changeBtn.backgroundColor = [UIColor blackColor];
    changeBtn.layer.cornerRadius=FrameW(changeBtn)/2;
//    [changeBtn setBackgroundImage:[UIImage imageNamed:@"camera_fornt"] forState:UIControlStateNormal];
    [changeBtn addTarget:self action:@selector(changeclick:) forControlEvents:UIControlEventTouchUpInside];
    [_overlayBG addSubview:changeBtn];
    
    changeimg=[[UIImageView alloc]init];
    changeimg.frame=CGRectMake(kApplicationWidth-53, 13, 40, 40);
    changeimg.image=ImageNamed(@"camera_fornt");
//    changeimg.layer.cornerRadius=FrameW(changeimg)/2;
    [_overlayBG addSubview:changeimg];
    
    //拍照
    
    shootBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shootBtn.frame = CGRectMake(kApplicationWidth/2-30, 80, 60, 60);
    shootBtn.backgroundColor = [UIColor whiteColor];
    //[shootBtn setBackgroundImage:[UIImage imageNamed:@"camera__excute"] forState:UIControlStateNormal];
    [shootBtn addTarget:self action:@selector(retakePhoto) forControlEvents:UIControlEventTouchUpInside];
    shootBtn.layer.cornerRadius=FrameW(shootBtn)/2;
    [trybackview addSubview:shootBtn];
    
    UIImageView *im3=[[UIImageView alloc]init];
    im3.frame=Frame(7, 7, 46, 46);
    im3.tag=41;
    im3.backgroundColor=[UIColor redColor];
    im3.layer.cornerRadius=FrameW(im3)/2;
    [shootBtn addSubview:im3];
    
    numblelable=[[UILabel alloc]initWithFrame:Frame(0, 95, FrameX(shootBtn)-10, 30)];
//    numblelable.text=[NSString stringWithFormat:@"已拍摄(0/%d)",_MaxImageNum];
    numblelable.textAlignment=NSTextAlignmentCenter;
    numblelable.font=[UIFont systemFontOfSize:15];
    numblelable.textColor=[UIColor whiteColor];
    [trybackview addSubview:numblelable];
    
    TrymoreScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, FrameW(trybackview), 79)];
    [trybackview addSubview:TrymoreScrollView];
    TrymoreScrollView.alpha = 0.8;
    TrymoreScrollView.backgroundColor=[UIColor blackColor];
    
    [self setScrollview];
}
-(void)setScrollview
{
    if (TrymoreScrollView) {
        for (UIView *v  in TrymoreScrollView.subviews) {
            [v removeFromSuperview];
        }
    }
    numblelable.text=[NSString stringWithFormat:@"已拍摄(%d/%d)",imagearr.count,_MaxImageNum];
    TrymoreScrollView.hidden=NO;
    TrymoreScrollView.contentSize=CGSizeMake(80*imagearr.count, FrameH(TrymoreScrollView));
   
    for (int i=0; i<imagearr.count; i++) {
        
        UIButton *btn5=[UIButton buttonWithType:UIButtonTypeCustom];
        [TrymoreScrollView addSubview:btn5];
//        [btn5 setBackgroundImage:imagearr[i] forState:UIControlStateNormal];
        btn5.backgroundColor=[UIColor clearColor];
        btn5.tag=i;
        btn5.frame=CGRectMake(i*(77)+2,2, 75,75);
        [btn5 addTarget:self action:@selector(scrollclick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *im3=[[UIImageView alloc]init];
        im3.frame=btn5.bounds;
        im3.image=imagearr[i];
        im3.backgroundColor=[UIColor clearColor];
        [btn5 addSubview:im3];
        im3.clipsToBounds=YES;
        im3.contentMode=UIViewContentModeScaleAspectFill;
        
        UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame=CGRectMake(FrameW(btn5)-20, 0, 20, 20);
        btn2.tag=50+i;
        [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn2 setTitle:@"×" forState:UIControlStateNormal];
        btn2.titleLabel.font=[UIFont systemFontOfSize:30];
        btn2.backgroundColor=[UIColor clearColor];
        [btn2 addTarget:self action:@selector(delectclick:) forControlEvents:UIControlEventTouchUpInside];
        [btn5 addSubview:btn2];
    }

}
#pragma mark- 删除房屋图
-(void)delectclick:(UIButton *)sender
{

    [imagearr removeObjectAtIndex:sender.tag-50];
    for (UIView *v in TrymoreScrollView.subviews) {
        [v removeFromSuperview];
    }
    [self setScrollview];
}
-(void)scrollclick:(UIButton *)btn
{
    _overlayBG2.image=imagearr[btn.tag];
}

//退出
- (void)backclick:(UIButton *)btn
{
    if (_imgPicker) {
        [_imgPicker dismissViewControllerAnimated:NO completion:^{
            [self.navigationController popViewControllerAnimated:NO];
        }];
    }else{
        [self.navigationController popViewControllerAnimated:NO];
    }
}
//切换摄像头
- (void)changeclick:(UIButton *)btn
{
    //翻转动画
    btn.selected=!btn.selected;
    
        CATransition *transtion = [CATransition animation];
        transtion.duration = 0.3;
        [transtion setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        [transtion setType:@"oglFlip"];
        [transtion setSubtype:kCATransitionFromLeft];
        [_imgPicker.view.layer addAnimation:transtion forKey:@"transtionKey"];
    
        [self performSelector:@selector(changtou:) withObject:btn afterDelay:0.1];
    
}
-(void)changtou:(UIButton *)btn
{
    
    if (!btn.selected) {
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
            _imgPicker.cameraDevice=UIImagePickerControllerCameraDeviceRear;
        }
        else
        {
            UIAlertView *alter=[[UIAlertView alloc]initWithTitle:nil message:@"前摄像头不可以用" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
            [alter show];
        }
    }
    else
    {
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
            
            _imgPicker.cameraDevice=UIImagePickerControllerCameraDeviceFront;//后摄像头
        }
        else
        {
            UIAlertView *alter=[[UIAlertView alloc]initWithTitle:nil message:@"后摄像头不可以用" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
            [alter show];

        }
        
    }

}

//拍照
- (void)takePhoto
{
    changeBtn.selected=NO;
    changeBtn.hidden=NO;
    changeimg.hidden=NO;
    
    if (_overlayBG.superview == self.view) {
    
        shootBtn.userInteractionEnabled=NO;
        
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您的摄像头不可用！" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
            [alert show];
            
            return;
        }
        
        
        UIImageView *img=(UIImageView *)[shootBtn viewWithTag:41];
        img.backgroundColor=[UIColor redColor];
        
        if (!_imgPicker) {
        
            _imgPicker=[[UIImagePickerController alloc]init];
            _imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            _imgPicker.showsCameraControls = NO;
            [_imgPicker.view addSubview:_overlayBG];
            
            _imgPicker.delegate = self;
            //_imgPicker.cameraDevice=UIImagePickerControllerCameraDeviceRear;//后摄像头
            //_imgPicker.cameraDevice=UIImagePickerControllerCameraDeviceFront;//前摄像头
        
        }
        [self presentViewController:_imgPicker animated:NO completion:nil];
        
        [self performSelector:@selector(zhunbei) withObject:nil afterDelay:2.5];
        
    }
    else
    {
        if (_imgPicker) {
            [_imgPicker takePicture];
            
        }
    }
}
-(void)zhunbei
{
    shootBtn.userInteractionEnabled=YES;
}
//重新拍摄
- (void)retakePhoto
{
    if(imagearr.count==_MaxImageNum)
    {
        NSString *n=[NSString stringWithFormat:@"图片已达到%d张,如想继续拍摄请删除图片！！",_MaxImageNum];
//        [PublicClss AlertViewToWindowAndHiddenWithMessage:n WithAnimation:0];
        UIAlertView *alter=[[UIAlertView alloc]initWithTitle:nil message:n delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alter show];
    
        
        return;
    }
    _overlayBG2.image=nil;
    changeBtn.hidden=NO;
    changeimg.hidden=NO;
    [self takePhoto];
}

#pragma mark - image picker delegate

- (void)dissAlert:(UIAlertView *)sender
{
    [sender dismissWithClickedButtonIndex:0 animated:YES];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImageView *img=(UIImageView *)[shootBtn viewWithTag:41];
    img.backgroundColor=[UIColor grayColor];
    changeBtn.hidden=YES;
    changeimg.hidden=YES;
    
    UIImage *originalImg = info[UIImagePickerControllerOriginalImage];
    //mmmm%@",imagearr);
    [self setScrollview];
    
    if (originalImg) {
        _overlayBG2.image = originalImg;
        shootBtn.userInteractionEnabled=NO;
       [self performSelector:@selector(changeoverkay) withObject:nil afterDelay:2];
    }
   
    [_imgPicker dismissViewControllerAnimated:NO completion:^ {
        [self tryonLayoutAfterBackFromCamera];
    }];
    
    
    UIImage *newImage = [self compressImage:originalImg toMaxFileSize:100];
    
    [imagearr addObject:newImage];

    [self setScrollview];

}
//将图片进行大小 和 质量进行压缩
- (UIImage *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    
    CGFloat compression = 1;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    
    //    //new = %ld", [imageData length]);
    
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:NO completion:^ {
        [self tryonLayoutAfterBackFromCamera];
    }];
}
-(void)changeoverkay
{
    _overlayBG2.image=nil;
    [self takePhoto];
}
- (void)tryonLayoutAfterBackFromCamera
{
    _imgPicker = nil;
    [self.view addSubview:_overlayBG];
//    _overlayBG.frame =CGRectMake(0, -50, Screen_Width, Screen_Height+70);
    //    trybackview.frame=Frame(FrameW(trybackview), FrameY(trybackview)+50, FrameW(trybackview), FrameH(trybackview));

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
