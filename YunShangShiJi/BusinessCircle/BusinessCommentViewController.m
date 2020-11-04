//
//  BusinessCommentViewController.m
//  YunShangShiJi
//
//  Created by yssj on 15/10/19.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "BusinessCommentViewController.h"
#import "GlobalTool.h"
#import "StarsView.h"
#import "UITextView+HDFTextView.h"


#import "CameraVC.h"
#import "DoImagePickerController.h"
#import "TFCustomCamera.h"
#import "commentPhotoView.h"
#import "FullScreenScrollView.h"
#import "MBProgressHUD+NJ.h"

@interface BusinessCommentViewController ()<TFCameraDelegate>
{
    UIPlaceholderTextView *_commentText;
    StarsView *_starView;
}
@property (nonatomic, strong)NSMutableArray *imgArr; //照片img

@property(nonatomic,strong)UIScrollView *myScrollView;

//点击照片
@property (nonatomic, strong)FullScreenScrollView *imgFullScrollView;
@property (nonatomic, strong)commentPhotoView *photoView;


@end

@implementation BusinessCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    _imgArr = [NSMutableArray array];
    
    
    
    //点击图片放大
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imgClick:) name:@"imgClickNoti" object:nil];
    //长按删除
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imgLongPClick:) name:@"imgLongPClickNoti" object:nil];
    
    
    
    [self creatNavgationView];
    [self creatView];
}
-(void)creatNavgationView
{
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    headview.image=[UIImage imageNamed:@"导航背景"];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn addTarget:self action:@selector(leftBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
//    [backbtn setImage:[UIImage imageNamed:@"返回按钮_高亮"] forState:UIControlStateHighlighted];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, headview.frame.size.width, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text= @"全部评价";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kApplicationWidth-25-ZOOM(50), headview.frame.size.height-35, 25, 25)];
//    imageView.image = [UIImage imageNamed:@"个性签名"];
//    
//    [headview addSubview:imageView];
//    UIButton *setting=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    setting.frame=CGRectMake(kApplicationWidth-50, 25, 50, 30);
//    [setting addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
//    [headview addSubview:setting];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, headview.frame.size.height-1, kApplicationWidth, 1)];
    line.backgroundColor=lineGreyColor;
    [headview addSubview:line];
    

}
#pragma mark - 分享话题
-(void)edit:(UIButton*)sender
{
    //评论");
}
/************  获得宽度 *************/
-(CGFloat)getWidth:(NSString *)string
{
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(50)]};
    CGSize textSize = [string boundingRectWithSize:CGSizeMake(300, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    
    return textSize.width;
}
-(void)keyboardTap
{
    [_myScrollView endEditing:YES];
}
-(void)creatView
{
    _myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar)];
    _myScrollView.backgroundColor = RGBCOLOR_I(234, 234, 234);
    _myScrollView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    UITapGestureRecognizer *keyboardTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyboardTap)];
    [_myScrollView addGestureRecognizer:keyboardTap];
    
    [self.view addSubview:_myScrollView];
    
    UIView *commentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 25+ZOOM(516)+ZOOM(50)*2+ZOOM(70))];
    commentView.backgroundColor=[UIColor whiteColor];
    [_myScrollView addSubview:commentView];
    
    UILabel *commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(40), ZOOM(50), [self getWidth:@"总体评价"], 25)];
    commentLabel.text=@"总体评价";
    commentLabel.font=[UIFont systemFontOfSize:ZOOM(50)];
    [commentView addSubview:commentLabel];
    
    _starView=[[StarsView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(commentLabel.frame)+ZOOM(32), commentLabel.frame.origin.y, (commentLabel.frame.size.height+3)*5, commentLabel.frame.size.height)];
    [_starView setScore:0];
    _starView.enable=YES;
    [commentView addSubview:_starView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(commentLabel.frame)+ZOOM(50), kScreenWidth, 1)];
    line.backgroundColor = lineGreyColor;
    [commentView addSubview:line];
    
    
    _commentText = [[UIPlaceholderTextView alloc]initWithFrame:CGRectMake(ZOOM(40), CGRectGetMaxY(line.frame)+ZOOM(70), kScreenWidth-ZOOM(40)*2, ZOOM(516))];
    _commentText.placeholder=@"亲,您对这间商铺各方面觉得如何 ? 写下您宝贵的意见吧!";
    _commentText.font = [UIFont systemFontOfSize:ZOOM(50)];
    _commentText.textColor=RGBCOLOR_I(209, 209, 209);
    [commentView addSubview:_commentText];
    
    UIView *spaceView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_commentText.frame), kScreenWidth, ZOOM(100))];
    spaceView.backgroundColor = RGBCOLOR_I(234, 234, 234);
    [_myScrollView addSubview:spaceView];
    
    _photoView = [[commentPhotoView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(spaceView.frame), kScreenWidth, ZOOM(370))];
    _photoView.backgroundColor = [UIColor whiteColor];
    CGFloat photoImgWidth = _photoView.frame.size.height-ZOOM(50)*2;
//    UIImageView *photoImg = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM(40), ZOOM(50), photoImgWidth, photoImgWidth)];
    self.photoView.addImageBtn.frame = CGRectMake(0, ZOOM(50), photoImgWidth, photoImgWidth);
    [self.photoView.addImageBtn setImage:[UIImage imageNamed:@"拍照"] forState:UIControlStateNormal];
    [self.photoView.addImageBtn setBackgroundImage:nil forState:UIControlStateNormal];
    [self.photoView.addImageBtn addTarget:self action:@selector(addImageClick:) forControlEvents:UIControlEventTouchUpInside];

//    photoImg.backgroundColor = DRandomColor;
//    photoImg.image = [UIImage imageNamed:@"拍照"];
//    photoImg.contentMode=UIViewContentModeScaleAspectFit;
//    [_photoView addSubview:photoImg];
    [_myScrollView addSubview:_photoView];
    
    UIView *spaceView1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_photoView.frame), kScreenWidth, ZOOM(60))];
    spaceView1.backgroundColor = RGBCOLOR_I(234, 234, 234);
    [_myScrollView addSubview:spaceView1];
    
    
    /*
    UIView *tagView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(spaceView1.frame), kScreenWidth, ZOOM(150))];
    tagView.backgroundColor=[UIColor whiteColor];
    UITapGestureRecognizer *tagTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tagTap)];
    [tagView addGestureRecognizer:tagTap];
    UIImageView *tagImg = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM(45), ZOOM(25), ZOOM(100), ZOOM(100))];
    tagImg.backgroundColor = DRandomColor;
    [tagView addSubview:tagImg];
    UILabel *tagLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(tagImg.frame)+ZOOM(25),tagImg.frame.origin.y, kScreenWidth-ZOOM(200)*2, tagImg.frame.size.height)];
    tagLabel.text = @"标签列表";
    tagLabel.font = [UIFont systemFontOfSize:ZOOM(50)];
    [tagView addSubview:tagLabel];
    UIImageView *arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-ZOOM(42)-11, (tagView.frame.size.height-19)/2, 11, 19)];
    arrowImg.image = [UIImage imageNamed:@"更多-副本-3"];
    arrowImg.contentMode=UIViewContentModeScaleAspectFit;
    [tagView addSubview:arrowImg];
    [_myScrollView addSubview:tagView];
    */
    
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentBtn setTitle:@"发表评论" forState:UIControlStateNormal];
    [commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commentBtn.backgroundColor = [UIColor blackColor];
    commentBtn.frame = CGRectMake(ZOOM(200), CGRectGetMaxY(spaceView1.frame)+ZOOM(150), kScreenWidth-ZOOM(200)*2, ZOOM(130));
    [commentBtn addTarget:self action:@selector(commentBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_myScrollView addSubview:commentBtn];
    
    //%f   %ld",kScreenHeight,(long)_starView.num);
    _myScrollView.contentSize=CGSizeMake(kScreenWidth, 667-64);
    
}
#pragma mark - 添加图像
- (void)addImageClick:(UIButton *)sender
{
    if (self.imgArr.count == 3) {   //已经有了三张图片,不能够超过三张
        [MBProgressHUD showError:@"最多插入三张图片,您可长按删除"];
    } else {

//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//        UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [self performSelector:@selector(choosePhoto) withObject:nil afterDelay:0.5];
//
//        }];
//        UIAlertAction *photo = [UIAlertAction actionWithTitle:@"相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
//            DoImagePickerController *doimg = [[DoImagePickerController alloc] init];
//            doimg.delegate = self;
//            doimg.nColumnCount = 3; //以3列排
//            doimg.nResultType = DO_PICKER_RESULT_UIIMAGE;
//            doimg.nMaxCount = 3-self.imgArr.count;      //最大选择3张
//            [self presentViewController:doimg animated:YES completion:nil];
//        }];
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//        [alertController addAction:camera];
//        [alertController addAction:photo];
//        [alertController addAction:cancelAction];
//        [self presentViewController:alertController animated:YES completion:nil];
        
        UIActionSheet *actionsheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册获取", nil];
        [actionsheet showInView:self.view];
    }
}
-(void)tagTap
{
    //星星  %ld",(long)_starView.num);
}
-(void)commentBtnClick
{
    //发表评论");
}
- (void)leftBarButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}




#pragma mark - 图片的手势通知
- (void)imgClick:(NSNotification *)note
{
    //轻触");
    //    //note.object = %@",note.object);
    //放大图片
    UIView *window = [[UIApplication sharedApplication].delegate window];
    self.imgFullScrollView = [[FullScreenScrollView alloc] initWithPicutreArray:self.imgArr withCurrentPage:[note.object intValue]];
    
    self.imgFullScrollView.backgroundColor = [UIColor blackColor];
    [window addSubview:self.imgFullScrollView];
}

//长按删除
- (void)imgLongPClick:(NSNotification *)note
{
    //长按");
    
    if (self.imgArr.count > [note.object intValue]) {
        [self.imgArr removeObjectAtIndex:[note.object intValue]];
    }
    
    [self.photoView receiveImageArray:self.imgArr];
    UILabel *wlabel = (UILabel *)[self.view viewWithTag:10010];
    wlabel.frame = CGRectMake(CGRectGetMaxX(self.photoView.addImageBtn.frame)+ZOOM(30), (ZOOM(100)-ZOOM(50))/2, ZOOM(350), ZOOM(50));
}
#pragma mark - 选择图像
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0) {
        //拍照");
        
        [self performSelector:@selector(choosePhoto) withObject:nil afterDelay:0.5];
        
        
    } else if (buttonIndex == 1) {
        //图库");
        DoImagePickerController *doimg = [[DoImagePickerController alloc] init];
        doimg.delegate = self;
        doimg.nColumnCount = 3; //以3列排
        doimg.nResultType = DO_PICKER_RESULT_UIIMAGE;
        doimg.nMaxCount = 3-self.imgArr.count;      //最大选择3张
        [self presentViewController:doimg animated:YES completion:nil];
    }
}
- (void)choosePhoto
{
    TFCustomCamera *tcvc = [[TFCustomCamera alloc] init];
    tcvc.maxPhotoCount = (int)(3 - self.imgArr.count);
    tcvc.delegate = self;
    [self.navigationController pushViewController:tcvc animated:NO];
    //    CameraVC *camera=[[CameraVC alloc] init];
    //    camera.delegate = self;
    //    camera.MaxImageNum = 3-self.imgArr.count;   //最多图片数量
    //    [self.navigationController pushViewController:camera animated:YES];
}

#pragma mark TFcamera Delegate
- (void)SelectPhotoEnd:(TFCustomCamera *)Manager WithPhotoArray:(NSArray *)PhotoArray
{
    //PhotoArray = %@",PhotoArray);
    for (UIImage *img in PhotoArray) {
        [self.imgArr addObject:img];
    }
    [self.photoView receiveImageArray:self.imgArr];
    UILabel *wlabel = (UILabel *)[self.view viewWithTag:10010];
    wlabel.frame = CGRectMake(CGRectGetMaxX(self.photoView.addImageBtn.frame)+ZOOM(30), (ZOOM(100)-ZOOM(50))/2, ZOOM(350), ZOOM(50));
    
}
#pragma mark - DoImagePickerControllerDelegate
- (void)didCancelDoImagePickerController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didSelectPhotosFromDoImagePickerController:(DoImagePickerController *)picker result:(NSArray *)aSelected
{
    //aSelected = %@",aSelected);
    
    for (UIImage *img in aSelected) {
        [self.imgArr addObject:img];
    }
    [self.photoView receiveImageArray:self.imgArr];
    UILabel *wlabel = (UILabel *)[self.view viewWithTag:10010];
    wlabel.frame = CGRectMake(CGRectGetMaxX(self.photoView.addImageBtn.frame)+ZOOM(30), (ZOOM(100)-ZOOM(50))/2, ZOOM(350), ZOOM(50));
    [self dismissViewControllerAnimated:YES completion:nil];
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
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
