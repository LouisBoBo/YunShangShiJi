//
//  YSSJInterveneViewController.m
//  YunShangShiJi
//
//  Created by yssj on 16/3/29.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "YSSJInterveneViewController.h"
//#import "ChatListViewController.h"
#import "UITextView+HDFTextView.h"
#import "DoImagePickerController.h"
#import "TFCustomCamera.h"
#import "FullScreenScrollView.h"
#import "YSSJInterveneSucController.h"

#import "MyMD5.h"
#import "UpYun.h"

#define labelQuestionString @"问题描述"
#define questionTextString @"请您在此描述详细问题..."
#define labelPictureString @"上传图片凭证"
#define pictureLabelString @"最多上传三张，每张不超过5M，支持JPG、PNG、BMP"
#define submitBtnString @"提交申请"
#define photoRemindString @"最多选择3张图片"
const CGFloat pictureBtnWidth = 100;
const int maxImgCount = 3;

@interface YSSJInterveneViewController ()<UIActionSheetDelegate,TFCameraDelegate>
{
    UIScrollView *myScrollView;
    UIButton *pictureBtn;
    FullScreenScrollView *_fullScreenScrollView;
    UILabel *labelPicture;
    UIPlaceholderTextView *questionText;
    
    NSInteger _delatebtntag;
    BOOL _isdelate;
}
@property (nonatomic,strong) NSMutableString *images;
@property (nonatomic, strong)NSMutableArray *imgArr;
@property (nonatomic,strong)UIScrollView *photoScrollView;
@end

@implementation YSSJInterveneViewController
-(NSMutableString *)images
{
    if (_images==nil) {
        _images=[[NSMutableString alloc]init];
    }
    return _images;
}
- (NSMutableArray *)imgArr
{
    if (_imgArr == nil) {
        _imgArr = [[NSMutableArray alloc] init];
    }
    return _imgArr;
}
- (NSString *)exchangeTextWihtString:(NSString *)text
{
    //    //text  %@",text);
    if ([[NSString stringWithFormat:@"%@",text] isEqualToString:@"<null>"]) {
        return @"";
    }
    
    if ([text rangeOfString:@"】"].location != NSNotFound){
        NSArray *arr = [text componentsSeparatedByString:@"】"];
        NSString *textStr;
        if (arr.count == 2) {
            textStr = [NSString stringWithFormat:@"%@%@】", arr[1], arr[0]];
        }
        return textStr;
    }
    return text;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self.images setString:@""];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"aSelected"];
    
    [self setNavigationItemLeft:@"申请平台介入"];
    [self setMainView];
}
-(void)setMainView{
    
    CGFloat myScrollViewHeight = kScreenHeight>568 ? kScreenHeight-Height_NavBar : 568;
    //%f",kScreenHeight);
    myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar)];
    myScrollView.contentSize=CGSizeMake(kScreenWidth, myScrollViewHeight);
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [myScrollView addGestureRecognizer:tap];
    [self.view addSubview:myScrollView];

    UIImageView *headimage=[[UIImageView alloc]initWithFrame:CGRectMake(ZOOM(62), ZOOM(62), ZOOM(240), ZOOM(350))];
    
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(headimage.frame.origin.x+headimage.frame.size.width+ZOOM(32),ZOOM(62), kScreenWidth, ZOOM(56))];
    UILabel *color_size=[[UILabel alloc]initWithFrame:CGRectMake(title.frame.origin.x, ZOOM(62)+title.frame.size.height+ZOOM(32), 300, 22)];
    UILabel *price=[[UILabel alloc]initWithFrame:CGRectMake(title.frame.origin.x, color_size.frame.origin.y+color_size.frame.size.height+ZOOM(32), 140, 22)];
    UILabel *number=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-ZOOM(42)-80, price.frame.origin.y, 80, 22)];
    
    title.font = [UIFont systemFontOfSize:ZOOM(46)];
    color_size.font = [UIFont systemFontOfSize:ZOOM(42)];
    price.font = [UIFont systemFontOfSize:ZOOM(46)];
    number.font = [UIFont systemFontOfSize:ZOOM(44)];
    color_size.textColor=kTextColor;
    number.textColor=kTextColor;
    
    NSURL *imgUrl;
    if (_orderModel.shop_from.intValue==-1) {
        imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!180",[NSObject baseURLStr_Upy],_orderModel.shop_pic]];
    }else
        imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@!180",[NSObject baseURLStr_Upy],[MyMD5 pictureString:_orderModel.shop_code],_orderModel.shop_pic]];
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [headimage sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d = (float)receivedSize/expectedSize;
        isDownlaod = YES;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod == YES) {
            headimage.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                headimage.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        } else if (image != nil && isDownlaod == NO) {
            headimage.image = image;
        }
    }];
    
    title.text=[self exchangeTextWihtString: _orderModel.shop_name];
    number.text=[NSString stringWithFormat:@"x%@",_orderModel.shop_num];
    color_size.text=[NSString stringWithFormat:@"颜色:%@ 尺码:%@",_orderModel.shop_color,_orderModel.shop_size];
    price.text=[NSString stringWithFormat:@"¥%.2f",_orderModel.shop_price.floatValue];

    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headimage.frame)+ZOOM(32), kScreenWidth, 1)];
    line.backgroundColor=lineGreyColor;
    
    [myScrollView addSubview:headimage];
    [myScrollView addSubview:title];
    [myScrollView addSubview:color_size];
    [myScrollView addSubview:price];
    [myScrollView addSubview:number];
    [myScrollView addSubview:line];
    
    UILabel *labelQuestion=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), CGRectGetMaxY(line.frame)+ZOOM(32), 100, 22)];
    labelQuestion.text=labelQuestionString;
    [myScrollView addSubview:labelQuestion];
    
    questionText=[[UIPlaceholderTextView alloc]initWithFrame:CGRectMake(ZOOM(62), CGRectGetMaxY(labelQuestion.frame)+ZOOM(32), kScreenWidth-ZOOM(62)*2, 100)];
    questionText.placeholder=questionTextString;
    questionText.layer.cornerRadius=3;
    questionText.layer.borderWidth=1;
    questionText.layer.borderColor=lineGreyColor.CGColor;
    [myScrollView addSubview:questionText];
    
    
    labelPicture=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), CGRectGetMaxY(questionText.frame)+ZOOM(32), 200, 22)];
    labelPicture.text=labelPictureString;
    [myScrollView addSubview:labelPicture];
    
    
    _photoScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(labelPicture.frame)+ZOOM(32), kScreenWidth, 100)];
    _photoScrollView.backgroundColor=[UIColor whiteColor];
    _photoScrollView.showsHorizontalScrollIndicator=NO;
    [myScrollView addSubview:_photoScrollView];
    
    pictureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    pictureBtn.tag=999;
    pictureBtn.frame=CGRectMake(ZOOM(62), 0, pictureBtnWidth, pictureBtnWidth);
    [pictureBtn setImage:[UIImage imageNamed:@"添加图片"] forState:UIControlStateNormal];
    pictureBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [pictureBtn addTarget:self action:@selector(pictureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_photoScrollView addSubview:pictureBtn];

    
    UILabel *pictureLabel=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), CGRectGetMaxY(_photoScrollView.frame)+ZOOM(32), kScreenWidth-ZOOM(62)*2, 50)];
    pictureLabel.text=pictureLabelString;
    pictureLabel.textColor=[UIColor lightGrayColor];
    pictureLabel.numberOfLines=2;
    [myScrollView addSubview:pictureLabel];
    
    UIButton *submitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame=CGRectMake(50, CGRectGetMaxY(pictureLabel.frame)+ZOOM(100), kScreenWidth-100, 40);
    [submitBtn setTitle:submitBtnString forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:[UIColor blackColor]];
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [myScrollView addSubview:submitBtn];
    
}
-(void)submitBtnClick
{
    if (questionText.text.length==0) {
        [MBProgressHUD showError:@"请描述详细问题"];
        return;
    }else if (self.imgArr.count==0){
        [MBProgressHUD showError:@"请上传图片凭证"];
        return;
    }
    
    
    
    if (_imgArr.count!=0) {
        [self creatUPY];
    }else
        [self httpIntervene];
    //%@",submitBtnString);

}
-(void)pictureBtnClick
{
    _isdelate = NO;
    if (_imgArr.count<maxImgCount) {
    UIActionSheet *actionsheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册获取", nil];
    [actionsheet showInView:self.view];
    }
    else{
        [MBProgressHUD showError:photoRemindString];
    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0){
        [self performSelector:@selector(choosePhotoCamera) withObject:nil afterDelay:0.5];
    }else if (buttonIndex==1)
    {
        DoImagePickerController *doimg=[[DoImagePickerController alloc]init];
        doimg.delegate=self;
        doimg.nColumnCount = 4;
        doimg.nResultType = DO_PICKER_RESULT_UIIMAGE;
        doimg.nMaxCount = maxImgCount-self.imgArr.count;
        [self.navigationController pushViewController:doimg animated:YES];
    }
}
-(void)choosePhotoCamera
{
    TFCustomCamera *tcvc = [[TFCustomCamera alloc] init];
    tcvc.maxPhotoCount = maxImgCount-(int)self.imgArr.count;
    tcvc.delegate = self;
    [self.navigationController pushViewController:tcvc animated:NO];

}
#pragma mark - TFCameraDelegate
- (void)SelectPhotoEnd:(TFCustomCamera *)Manager WithPhotoArray:(NSArray *)PhotoArray
{
    for(int i =0 ;i<PhotoArray.count;i++){
        [_imgArr addObject:PhotoArray[i]];
    }
    [self changePhotoView:PhotoArray];
    
}
#pragma mark - DoImagePickerControllerDelegate
-(void)didCancelDoImagePickerController
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)didSelectPhotosFromDoImagePickerController:(DoImagePickerController *)picker result:(NSArray *)aSelected
{
    for(int i =0 ;i<aSelected.count;i++){
        [_imgArr addObject:aSelected[i]];
    }
    [self changePhotoView:aSelected];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)changPhotoScrollView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.35];
    self.photoScrollView.contentSize=CGSizeMake((pictureBtnWidth+10)*(_imgArr.count+1)+ZOOM(62), 100);
    [self.photoScrollView scrollRectToVisible:CGRectMake((pictureBtnWidth+10)*(_imgArr.count-1)+ZOOM(62), 0, _photoScrollView.frame.size.width, _photoScrollView.frame.size.height) animated:YES];
    [UIView commitAnimations];
}
-(void)changePhotoView:(NSArray *)PhotoArray
{
    for(UIView *vv in self.photoScrollView.subviews) {
        if ([vv isKindOfClass:[UIImageView class]]) {
            [vv  removeFromSuperview];
        }
    }
    
    CGFloat _widh=pictureBtnWidth;
    for(int i=0;i<_imgArr.count;i++)
    {
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(ZOOM(62)+(_widh+10)*i, 0, _widh, _widh)];
        imageview.image=_imgArr[i];
        imageview.clipsToBounds = YES;
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        imageview.tag=2000+i;
        
        UIButton *deleatebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleatebtn.tag = 3000+i;
        deleatebtn.frame = CGRectMake(0, 0, 20, 20);
        [deleatebtn setImage:[UIImage imageNamed:@"删除图片"] forState:UIControlStateNormal];
        [deleatebtn addTarget:self action:@selector(delateimage:) forControlEvents:UIControlEventTouchUpInside];
        [imageview addSubview:deleatebtn];
        
        [self.photoScrollView addSubview:imageview];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageclick:)];
        [imageview addGestureRecognizer:tap];
        imageview.userInteractionEnabled=YES;
        
        
    }
    pictureBtn.frame=CGRectMake(ZOOM(62)+(pictureBtnWidth+10)*_imgArr.count,0, pictureBtnWidth, pictureBtnWidth);
    
    [self changPhotoScrollView];
    if(_imgArr.count<3){
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:_imgArr] forKey:@"aSelected"];
    }
}
-(void)deleteAnimation
{
    [_imgArr removeObjectAtIndex:(_delatebtntag)];
    UIImageView *imgView = [self.photoScrollView viewWithTag:(2000+_delatebtntag)];
    [imgView removeFromSuperview];
    
    for (int i=(int)_delatebtntag; i<_imgArr.count; i++) {
        UIImageView *imgView = [self.photoScrollView viewWithTag:i+2001];
        UIButton *btn = [imgView viewWithTag:3001+i];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.35];
        imgView.frame=CGRectMake(ZOOM(62)+(pictureBtnWidth+10)*i, 0, pictureBtnWidth, pictureBtnWidth);
        imgView.tag=i+2000;
        btn.tag=i+3000;
        [UIView commitAnimations];
    }
    pictureBtn.frame=CGRectMake(ZOOM(62)+(pictureBtnWidth+10)*_imgArr.count,0, pictureBtnWidth, pictureBtnWidth);
    
    [self changPhotoScrollView];

}
- (void)delateimage:(UIButton*)sender
{
    _delatebtntag = sender.tag%3000;
    
    [self deleteAnimation];
    
//    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确实要删除此张美图吗?" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
//    alter.delegate = self;
//    [alter show];
}
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if(_imgArr.count && buttonIndex!=0){
//        _isdelate=YES;
//        [self deleteAnimation];
//        
//    }else
//        _isdelate=NO;
//    
//}
-(void)imageclick:(UITapGestureRecognizer*)tap
{
    _isdelate = NO;
    if (_imgArr.count<maxImgCount) {
        UIImageView *imageview=(UIImageView*)[self.view viewWithTag:tap.view.tag];
        
        if(imageview.tag== 2000+_imgArr.count){
            UIActionSheet *actionsheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册获取", nil];
            [actionsheet showInView:self.view];
            
        } else{
            
            NSInteger image_page=imageview.tag%2000+1;
            UIView *Screenwindow = [[UIApplication sharedApplication].delegate window];
            _fullScreenScrollView = [[FullScreenScrollView alloc]initWithPicutreArray:_imgArr withCurrentPage:(int)image_page];
            _fullScreenScrollView.backgroundColor = [UIColor blackColor];
            [Screenwindow addSubview:_fullScreenScrollView];
            
        }
    } else {
        UIImageView *imageview=(UIImageView*)[self.view viewWithTag:tap.view.tag];
        
        if(imageview.tag== 2000+_imgArr.count){
            [MBProgressHUD showError:photoRemindString];
        } else{
            
            NSInteger image_page=imageview.tag%2000+1;
            UIView *Screenwindow = [[UIApplication sharedApplication].delegate window];
            _fullScreenScrollView = [[FullScreenScrollView alloc]initWithPicutreArray:_imgArr withCurrentPage:(int)image_page];
            _fullScreenScrollView.backgroundColor = [UIColor blackColor];
            [Screenwindow addSubview:_fullScreenScrollView];
        }
        
    }
    
    
}

#pragma mark - 数据处理
-(void)httpIntervene
{

    NSString *url=[NSString stringWithFormat:@"%@returnShop/intervene?version=%@&token=%@&id=%@&user_cert_msg=%@&user_certificate=%@",[NSObject baseURLStr],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN],_orderModel.ID,questionText.text,self.images];
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showHUDAddTo:self.view  animated:YES];
    //-----%@",questionText.text);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        //responseObject is %@",responseObject);
        if ([responseObject[@"status"]integerValue]==1) {
            YSSJInterveneSucController *view = [[YSSJInterveneSucController alloc]init];
            [self.navigationController pushViewController:view animated:YES];

        }else
            [MBProgressHUD showError:responseObject[@"message"]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
    }];
}

#pragma mark 将图片上传到upyun
-(void)creatUPY
{
    
    [self.images setString:@""];
    __block int count=(int)_imgArr.count;
    UpYun *uy = [[UpYun alloc] init];
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    uy.successBlocker = ^(id data)
    {
        NSString *imgurl=[NSString stringWithFormat:@"%@",data[@"url"]];
        //imgurl--%@",imgurl);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
//            NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],imgurl]]];
//            UIImage * img = [UIImage imageWithData:data];
//            CGFloat scale = 1.0 ;
//            if(img){
//                scale = img.size.width/img.size.height;
//            }
            if(imgurl){
                [self.images appendString:imgurl];
//                [self.images appendString:@":"];
//                [self.images appendString:[NSString stringWithFormat:@"%.2f",scale]];

                count=count-1;
                if (count) {
                    [self.images appendString:@","];
                }
            }
            if(count==0){
                dispatch_async(dispatch_get_main_queue(), ^{ // 主线程刷新UI
                    [MBProgressHUD hideHUDForView:self.view];
                    [self httpIntervene];
                });
            }
        });
    };
    
    uy.failBlocker = ^(NSError * error)
    {
        [MBProgressHUD hideHUDForView:self.view];
        NSString *message = [error.userInfo objectForKey:@"message"];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"发送失败，稍后重试!" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        //%@",error);
        count=count-1;
    };

    for(int i=0;i<_imgArr.count;i++){
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage * image1 =[self compressionImage:_imgArr[i]];
            [uy uploadFile:image1 saveKey:[self getSaveKeyWith:i]];
        });
    }
    
    
}
#pragma mark - ---图片压缩
/**
 *  图片压缩
 *
 *  @param img 传入的图片
 *
 *  @return 返回压缩后的图片
 */
- (UIImage *)compressionImage:(UIImage *)img
{
    CGSize imagesize = img.size;
    imagesize.height = imagesize.height/kImageSizeCompression;
    imagesize.width = imagesize.width/kImageSizeCompression;
    MyLog(@"imagesize =%f",imagesize.width);
    UIImage *newImg = [self imageWithImage:img scaledToSize:imagesize];
    NSData *imageData = UIImageJPEGRepresentation(newImg, kImageCompression);
    
    MyLog(@"************%lu",(unsigned long)[imageData length]);
    
    return [UIImage imageWithData:imageData];
}
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize

{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}
-(NSString * )getSaveKeyWith:(int)index{
    
    NSString *UID=[self getNumber];
    NSDate *d = [NSDate date];
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    
    return [NSString stringWithFormat:@"/returnShop/%@/%@%d%.0f%d.jpg",[formatter stringFromDate:[NSDate date]],UID,[self getSecond:d],[[NSDate date] timeIntervalSince1970],index];
    
}

#pragma mark 获取毫秒数
- (int)getSecond:(NSDate *) date{
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    NSInteger second = [comps second];
    return (int)second;
}

#pragma mark 获取UID
-(NSString*)getNumber
{
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    NSMutableString *strNum=[NSMutableString string];
    
    for (int i=0; i<token.length; i++) {
        NSString *character=[token substringWithRange:NSMakeRange(i, 1)];//循环取每个字符
        
        if ([character isEqual: @"0"]|
            [character isEqual: @"1"]|
            [character isEqual: @"2"]|
            [character isEqual: @"3"]|
            [character isEqual: @"4"]|
            [character isEqual: @"5"]|
            [character isEqual: @"6"]|
            [character isEqual: @"7"]|
            [character isEqual: @"8"]|
            [character isEqual: @"9"]) {
            
            [strNum appendString:character];//是数字的累加起来
        }
        
    }
    return strNum;
}
-(void)tapClick
{
    [self.view endEditing:YES];
}
-(void)leftBarButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightBarButtonClick{
    // begin 赵官林 2016.5.26 跳转到消息列表
    [self presentChatList];
    // end
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
