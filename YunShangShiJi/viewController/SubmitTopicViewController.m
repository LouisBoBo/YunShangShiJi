//
//  SubmitTopicViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/6/12.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//






#define  CIRCLE_TITLE @"圈圈标题限定8-30个字符"
#define CIRCLE_CONTENT @"圈圈内容限定6-5000个字符"


#import "SubmitTopicViewController.h"
#import "GlobalTool.h"
#import "DoImagePickerController.h"
#import "CameraVC.h"
#import "KeyboardTool.h"
#import "FullScreenScrollView.h"
#import "UIViewController+KNSemiModal.h"
#import "KWPopoverView.h"
#import "NavgationbarView.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "LoginViewController.h"
#import "MyMD5.h"
#import "UpYun.h"
@interface SubmitTopicViewController ()<DoImagePickerControllerDelegate,CameraDelegate,KeyboardToolDelegate>
{
    //图片的高宽
    CGFloat _widh;
    
    //图片
    NSMutableArray *_imageArray;
    
    //标签数据
    NSMutableArray *_tagArray;
    
    //查找到的标签列表数据
    NSMutableArray *_allTagArray;
    
    //选择的标签
    NSString *tagLabel;
    
    //记录键盘是否移动
    BOOL _iskeyboardmove;
    CGFloat _moveHeigh;
    
    //模态视图
    UIView *_modelview;
    
    NSMutableString *_images;


    FullScreenScrollView *_fullScreenScrollView;
    
    BOOL _altet_isshow;
    
    NSInteger _delatebtntag;
    
    BOOL _isdelate;
}
@property (nonatomic, assign)int imgCount;
@property (nonatomic,strong)UITextView *message;
@property (nonatomic,strong)UIScrollView *photoScrollView;

@end
@implementation SubmitTopicViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    _tagArray=[NSMutableArray array];
    _images = [NSMutableString string];
    _allTagArray = [NSMutableArray array];
    _imageArray = [NSMutableArray array];
    
    _widh=(kApplicationWidth-70)/4;
    _iskeyboardmove=NO;
    _altet_isshow = NO;
    _isdelate = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cameraImage:) name:@"cameraImage" object:nil];
    
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
//    headview.image=[UIImage imageNamed:@"u265"];
    headview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"发表话题";
    titlelable.textColor=kMainTitleColor;
    titlelable.font = kNavTitleFontSize;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];

    _moveHeigh=self.backView.frame.size.height-50;
    
    self.addimage.frame=CGRectMake(ZOOM(58), self.addimage.frame.origin.y, _widh, _widh);
//    self.addimage.layer.borderWidth=1;
    self.addimage.layer.borderColor=kBackgroundColor.CGColor;
    
    [self.addimage addTarget:self action:@selector(addimage:) forControlEvents:UIControlEventTouchUpInside];
    
//    UITextView *textview1 = [[UITextView alloc]initWithFrame:self.titlteView.frame];
    _titlteView.delegate = self;
//    textview1.backgroundColor= kBackgroundColor;
    _titlteView.textColor = kTextColor;
    _titlteView.tintColor = [UIColor blueColor];
    _titlteView.text= @"标题,诱人的会有更多人看";
//    [self.Myscrollview addSubview:textview1];
    
    
    
//    UITextView *textview2 = [[UITextView alloc]initWithFrame:self.contentView.frame];
    _contentView.delegate = self;
    _contentView.textColor = kTextColor;
//    textview2.backgroundColor = kBackgroundColor;
    _contentView.tintColor = [UIColor blueColor];
    _contentView.text = @"内容,诱人的会有更多人看";
//    [self.Myscrollview addSubview:textview2];

//    self.titlteView = textview1;
//    self.contentView = textview2;
    
//    self.titlteView.text=@"标题,诱人的会有更多人看";
//    self.contentView.text=@"内容,诱人的会有更多人看";
    
    self.titlteView.textColor=kTextColor;
    self.contentView.textColor=kTextColor;
    
    self.titlteView.frame=CGRectMake(self.titlteView.frame.origin.x, self.titlteView.frame.origin.y, self.titlteView.frame.size.width, self.titlteView.frame.size.height);
    
    self.contentView.frame=CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.contentView.frame.size.width, self.contentView.frame.size.height);
    
    self.titlteView.font = [UIFont systemFontOfSize:ZOOM(50)];
    self.contentView.font = [UIFont systemFontOfSize:ZOOM(50)];
    
    self.titleLabel.font = [UIFont systemFontOfSize:ZOOM(50)];
    self.contentLabel.font = [UIFont systemFontOfSize:ZOOM(50)];
    
    self.titlelable.font = [UIFont systemFontOfSize:ZOOM(50)];
    self.contentlable.font = [UIFont systemFontOfSize:ZOOM(50)];
    
    KeyboardTool *tool = [KeyboardTool keyboardTool];
    tool.delegate = self;
    tool.frame=CGRectMake(0, tool.frame.origin.y, kScreenWidth, 40);
    self.titlteView.inputAccessoryView = tool;
    self.contentView.inputAccessoryView = tool;
    
    self.taglable.frame = CGRectMake(ZOOM(62), self.taglable.frame.origin.y, self.taglable.frame.size.width, self.taglable.frame.size.height);
    
    self.taglable.textColor = kTitleColor;
    self.taglable.font = [UIFont systemFontOfSize:ZOOM(50)];
    
    
    self.submitView.backgroundColor=kTitleColor;
    self.submitView.tintColor=[UIColor whiteColor];
    self.submitView.titleLabel.font = [UIFont systemFontOfSize:ZOOM(51)];
    
    //选择标签
//    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tagclick:)];
//    [self.tagView addGestureRecognizer:tap];
//    self.tagView.userInteractionEnabled=YES;
    
    //提交
    [self.submitView addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"aSelected"];
    
    
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeatext:) name:@"touchText" object:nil];

    [self  getCircleTagArray];
}
/**
 *  获取标签数据
 */
-(void)getCircleTagArray
{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject];
    NSString* newFielPath = [documentsPath stringByAppendingPathComponent:@"circleTag.txt"];
    NSDictionary *content = [NSDictionary dictionaryWithContentsOfFile:newFielPath];
    //%@",content);
    

    for (int i=0; i<_allIdArray.count; i++) {
        NSString *string =[NSString stringWithFormat:@"%@",[content objectForKey:_allIdArray[i]] ];
        NSString *str2=[string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //%@,%@",string,str2);
        [_allTagArray addObject:str2];
    }
}
-(void)creatPopview
{

    NSArray *arr=_allTagArray;
//    arr=@[@"1",@"2",@"3",@"4",@"5",@"6"];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];

    view.tag = 8888;
    
//    _PopView.hidden=YES;
    _PopView=[[UIView alloc]initWithFrame:CGRectMake(kApplicationWidth/3, kApplicationHeight/2, kApplicationWidth-60, 50+ZOOM(100)*(arr.count/3+arr.count%3+1))];
    _PopView.clipsToBounds=YES;
    _PopView.transform = CGAffineTransformMakeScale(1, 1);
    _PopView.backgroundColor=[UIColor whiteColor];
//    _PopView.tag=8888;

    
    _PopView.center=CGPointMake(kApplicationWidth/2, kApplicationHeight/2);


    
    UIButton *canclebtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    canclebtn.frame=CGRectMake(10, 10, 80, ZOOM(100));
    [canclebtn setTitle:@"取消" forState:UIControlStateNormal];
    canclebtn.tintColor=[UIColor whiteColor];
    canclebtn.backgroundColor=[UIColor blackColor];
    [canclebtn addTarget:self action:@selector(cancleclick:) forControlEvents:UIControlEventTouchUpInside];
    canclebtn.enabled=YES;
    [_PopView addSubview:canclebtn];
    
    UIButton *okbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    okbtn.frame=CGRectMake(_PopView.frame.size.width-90, 10, 80, ZOOM(100));
    [okbtn setTitle:@"确定" forState:UIControlStateNormal];
    okbtn.tintColor=[UIColor whiteColor];
    [okbtn setBackgroundColor:tarbarrossred];
    [okbtn addTarget:self action:@selector(okclick:) forControlEvents:UIControlEventTouchUpInside];
    okbtn.enabled=YES;
    [_PopView addSubview:okbtn];

    //分割线
    UILabel *lableine=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(okbtn.frame)+10, _PopView.frame.size.width, 0.5)];
    lableine.backgroundColor=kBackgroundColor;
    [_PopView addSubview:lableine];
    
    UIView *backview=[[UIView alloc]initWithFrame:CGRectMake(0, lableine.frame.origin.y+10, _PopView.frame.size.width, ZOOM(100)*(arr.count/3+arr.count%3)+10)];
    backview.tag=100;
//    backview.backgroundColor=[UIColor redColor];
    [_PopView addSubview:backview];
    
    //标签按钮

    CGFloat widh=(_PopView.frame.size.width-40)/3;
    int k=0;
    for(int j=0;j<arr.count;j++)
    {
//        for(int i=0;i<3;i++)
//        {
            UIButton *button=[[UIButton alloc]init];
            button.frame=CGRectMake(10+(widh+10)*(j%3), 0+(ZOOM(100)+10)*(j/3), widh, ZOOM(100));
            [button setTitle:arr[k] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            
//            [button setBackgroundImage:[UIImage imageNamed:@"标签-默认"] forState:UIControlStateNormal];
//            [button setBackgroundImage:[UIImage imageNamed:@"标签-选中"] forState:UIControlStateSelected];

            button.layer.borderWidth=0.5;
            button.layer.borderColor=lineGreyColor.CGColor;
            button.tag=6000+k;
            
            [button addTarget:self action:@selector(tagbtnclick:) forControlEvents:UIControlEventTouchUpInside];
            
            [backview addSubview:button];
            k++;
//        }
    }
    [view addSubview:_PopView];

    [self.view addSubview:view   ];
}

//键盘
- (void)keyboardTool:(KeyboardTool *)keyboardTool itemClick:(KeyboardToolItemType)itemType
{
    if (itemType == KeyboardToolItemTypePrevious) { // 上一个
        //----上一个----");
    } else if (itemType == KeyboardToolItemTypeNext) { // 下一个
        //----下一个----");
    } else { // 完成
        //----完成----");
        
        if(_iskeyboardmove==YES)
        {
//             _Myscrollview.frame=CGRectMake(0, _moveHeigh, kApplicationWidth, kApplicationHeight);
            
//             _Myscrollview.contentOffset=CGPointMake(0, -20);
            _iskeyboardmove=NO;
        }
        
        if(self.titlteView.text.length<1)
        {
            self.titlteView.text=@"标题,诱人的会有更多人看";
        }

        if(self.contentView.text.length<1)
        {
            self.contentView.text=@"内容,诱人的会有更多人看";
        }

        [self.view endEditing:YES];
    }
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
- (void)cameraImage:(NSNotification*)note
{
    [MBProgressHUD showMessage:@"正在加载图片" afterDeleay:0 WithView:self.view];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    KWPopoverView *pop=[[KWPopoverView alloc]init];
    [pop dismiss1];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)addimage:(UIButton*)sender
{

    _isdelate = NO;
    
    if (_imageArray.count<10) {
        
        UIActionSheet *actionsheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册获取", nil];
        [actionsheet showInView:self.view];
        
    }  else {
        [MBProgressHUD showError:@"最多可选择10张图片"];
    }
   

}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        [self performSelector:@selector(choosePhotoCamera) withObject:nil afterDelay:0.5];

    
    }else if (buttonIndex==1)
    {
        DoImagePickerController *doimg=[[DoImagePickerController alloc]init];
        doimg.delegate=self;
        doimg.nColumnCount = 4;
        doimg.nResultType = DO_PICKER_RESULT_UIIMAGE;
        doimg.nMaxCount = 10-_imageArray.count;
        [self.navigationController pushViewController:doimg animated:YES];
    }
}
-(void)choosePhotoCamera
{
    CameraVC *camera=[[CameraVC alloc]init];
    camera.delegate=self;
    camera.MaxImageNum = 10-_imageArray.count;
    [self.navigationController pushViewController:camera animated:NO];
}

#pragma mark cameradelegate
-(void)SelectPhotoEnd:(CameraVC *)Manager WithPhotoArray:(NSArray *)PhotoArray
{
    [self changePhotoView:PhotoArray];
    [MBProgressHUD hideHUDForView:self.view];
}
-(UIScrollView *)photoScrollView
{
    if (_photoScrollView==nil) {
        _photoScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, _backView.frame.size.height)];
        _photoScrollView.showsHorizontalScrollIndicator=NO;
        [_backView addSubview:_photoScrollView];
    }
    return _photoScrollView;

}
-(void)changePhotoView:(NSArray *)PhotoArray
{
    

    if(_isdelate == YES )
    {
        for(UIView *vv in self.photoScrollView.subviews)
        {
            [vv  removeFromSuperview];
        }
        
    }else{
        
        NSData *saveMenulistDaate = [[NSUserDefaults standardUserDefaults] objectForKey:@"aSelected"];
        
        if (nil == saveMenulistDaate) {
            NSMutableArray *menulistarry = [[NSMutableArray alloc]init];
            _imageArray = menulistarry;
        } else{
            _imageArray = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:saveMenulistDaate];
        }
        
        for(int i =0 ;i<PhotoArray.count;i++)
        {
            [_imageArray addObject:PhotoArray[i]];
        }

    }
    
    
    UIImage *imagge=[UIImage imageNamed:@"拍照"];
    [_imageArray addObject:imagge];
    
    //ok");
    
    if(_imageArray.count){
        self.addimage.hidden=YES;
        for(UIView *vv in self.photoScrollView.subviews) {
            [vv  removeFromSuperview];
        }
    }else{
        self.addimage.enabled=NO;
        [_photoScrollView removeFromSuperview];
    }
    
    int k=0;
    for(int j=0;j<_imageArray.count;j++){
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(10+(_widh+12)*j, 10, _widh, _widh)];
        if(k<_imageArray.count){
            if(k == _imageArray.count-1){
                imageview.frame = CGRectMake(10+(_widh+12)*j, (10+(_widh+10)-IMGSIZEH(@"拍照"))/2,IMAGEW(@"拍照"), IMAGEH(@"拍照"));
            }
            imageview.image=_imageArray[k];
            imageview.clipsToBounds = YES;
            imageview.contentMode = UIViewContentModeScaleAspectFill;
            imageview.tag=2000+k;
            
            UIButton *deleatebtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            deleatebtn.tag = 3000 + k;
            k++;
            
            deleatebtn.frame = CGRectMake(0, 0, 20, 20);
            [deleatebtn setImage:[UIImage imageNamed:@"删除图片"] forState:UIControlStateNormal];
            [deleatebtn addTarget:self action:@selector(delateimage:) forControlEvents:UIControlEventTouchUpInside];
            if(k !=_imageArray.count)
            {
                [imageview addSubview:deleatebtn];
            }
            
            [self.photoScrollView addSubview:imageview];
            
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageclick:)];
            [imageview addGestureRecognizer:tap];
            imageview.userInteractionEnabled=YES;
        }
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    self.photoScrollView.contentSize=CGSizeMake((_widh+10)*_imageArray.count+10, _backView.frame.size.height);
    [self.photoScrollView scrollRectToVisible:CGRectMake((_widh+10)*(_imageArray.count-3)+10, 0, _photoScrollView.frame.size.width, _photoScrollView.frame.size.height) animated:YES];
    self.Myscrollview.contentSize=CGSizeMake(0, self.backView.frame.size.height+self.titlteView.frame.size.height+self.contentView.frame.size.height+self.tagView.frame.size.height+self.submitView.frame.size.height+60);
    _moveHeigh=self.backView.frame.size.height;
    [UIView commitAnimations];
    
    if(_imageArray.count){
        [_imageArray removeObjectAtIndex:_imageArray.count-1];
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:_imageArray] forKey:@"aSelected"];
    }
}

- (void)delateimage:(UIButton*)sender
{
    _delatebtntag = sender.tag%3000;
    
    MyLog(@"删除");
    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确实要删除此张美图吗?" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    alter.delegate = self;
    [alter show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        _isdelate = NO;
    }else{
        
        if(_imageArray.count){
            
            _isdelate = YES;
            
            [_imageArray removeObjectAtIndex:_delatebtntag];
            
            [self changePhotoView:_imageArray];
            [MBProgressHUD hideHUDForView:self.view];
            
            if(_imageArray.count == 0)
            {
                _isdelate = NO;

            }
        }else{
            _isdelate = NO;
        }

    }
    
}


#pragma mark DoImagePickerControllerDelegate
-(void)didCancelDoImagePickerController
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)didSelectPhotosFromDoImagePickerController:(DoImagePickerController *)picker result:(NSArray *)aSelected
{
    /*
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSData *saveMenulistDaate = [defaults objectForKey:@"aSelected"];

    
    if (nil == saveMenulistDaate) {
        
        NSMutableArray *menulistarry = [[NSMutableArray alloc]init];
            
        _imageArray = menulistarry;
            
    }
    
    else
    {
        _imageArray = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:saveMenulistDaate];
    }
    

    UIImage *imagge=[UIImage imageNamed:@"拍照"];
    for(int i=0 ;i<aSelected.count;i++)
    {
        [_imageArray addObject:aSelected[i]];
        
    }
    [_imageArray addObject:imagge];
    
    //ok");
    
    NSInteger count=0;
    if(_imageArray.count%4==0)
    {
        count=_imageArray.count/4;
    }else{
        count=_imageArray.count/4+1;
    }
    
    int k=0;
    for(int i=0;i<count;i++)
    {
        
        for(int j=0;j<4;j++)
        {
            
          UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(10+(_widh+10)*j, 10+(_widh+10)*i, _widh, _widh)];
            
            if(k<_imageArray.count)
            {
                
                MyLog(@"widh = %f heigh = %f",imageview.frame.size.width,imageview.frame.size.height);
                
                
                if(k == _imageArray.count-1)
                {
                    imageview.frame = CGRectMake(10+(_widh+10)*j, (10+(_widh+10)*(i+1)-IMGSIZEH(@"拍照"))/2,IMAGEW(@"拍照"), IMAGEH(@"拍照"));
                }

                
                imageview.image=_imageArray[k];
                
                imageview.clipsToBounds=YES;
                imageview.contentMode = UIViewContentModeScaleAspectFill;
                
                imageview.tag=2000+k;
                
                
                k++;
                
                [self.backView addSubview:imageview];
                
                UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageclick:)];
                [imageview addGestureRecognizer:tap];
                imageview.userInteractionEnabled=YES;
                
            }else{
                
            }
            
        }
    }
    
    
    self.backView.clipsToBounds=YES;
    self.titlteView.clipsToBounds=YES;
    self.contentView.clipsToBounds=YES;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];

    self.backView.frame=CGRectMake(self.backView.frame.origin.x, self.backView.frame.origin.y, kScreenWidth, (_widh+20)*count+10);
    
#if 0
    self.titlteView.frame=CGRectMake(self.titlteView.frame.origin.x, self.backView.frame.origin.y+self.backView.frame.size.height+25, self.titlteView.frame.size.width, self.titlteView.frame.size.height);
    
    
    self.titleLabel.frame = self.titlteView.frame;
    
    self.line1.frame = CGRectMake(0, CGRectGetMaxY(self.titlteView.frame), kScreenWidth, 1);
    
    self.contentView.frame=CGRectMake(self.contentView.frame.origin.x, self.titlteView.frame.origin.y+self.titlteView.frame.size.height+25, kScreenWidth, self.contentView.frame.size.height);
   
    self.contentLabel.frame = self.contentView.frame;
     self.line2.frame = CGRectMake(0, CGRectGetMaxY(self.contentView.frame), kScreenWidth, 1);

    self.tagView.frame=CGRectMake(self.tagView.frame.origin.x, self.contentView.frame.origin.y+self.contentView.frame.size.height+25, kApplicationWidth, self.tagView.frame.size.height);
    
    CGFloat line3Y =CGRectGetMaxY(self.tagView.frame);
    
    self.line3.frame = CGRectMake(0, line3Y, kApplicationWidth, 1);

    
    CGRect frame = self.submitView.frame;
    frame.origin.y = CGRectGetMaxY(self.tagView.frame)+20;
    
    self.submitView.frame = frame;
#endif
    
    self.Myscrollview.contentSize=CGSizeMake(0, self.backView.frame.size.height+self.titlteView.frame.size.height+self.contentView.frame.size.height+self.tagView.frame.size.height+self.submitView.frame.size.height+60);
    
    _moveHeigh=self.backView.frame.size.height;
    [UIView commitAnimations];

    
    if(_imageArray.count)
    {
        self.addimage.enabled=NO;
    }else{
        self.addimage.enabled=YES;
    }
    
    if(_imageArray.count)
    {
        [_imageArray removeObjectAtIndex:_imageArray.count-1];
        NSData *encodemenulist = [NSKeyedArchiver archivedDataWithRootObject:_imageArray];
        NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
        
        [defaults1 setObject:encodemenulist forKey:@"aSelected"];

    }
    */
//    UIImage *newImage = [self compressImage:image toMaxFileSize:25];
    [self changePhotoView:aSelected];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark  将图片进行大小 和 质量进行压缩
- (UIImage *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    
    //    NSData *oldImageData = UIImageJPEGRepresentation(image, 1);
    //    //old = %ld", [oldImageData length]);
    
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

-(void)imageclick:(UITapGestureRecognizer*)tap
{
    _isdelate = NO;
    
    if (_imageArray.count<10) {
        UIImageView *imageview=(UIImageView*)[self.view viewWithTag:tap.view.tag];
        
        if(imageview.tag== 2000+_imageArray.count)
        {
            UIActionSheet *actionsheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册获取", nil];
            [actionsheet showInView:self.view];
            
        } else{
            
            NSInteger image_page=imageview.tag%2000+1;
            
            UIView *Screenwindow = [[UIApplication sharedApplication].delegate window];
            
            _fullScreenScrollView = [[FullScreenScrollView alloc]initWithPicutreArray:_imageArray withCurrentPage:image_page];
            
            _fullScreenScrollView.backgroundColor = [UIColor blackColor];
            
            [Screenwindow addSubview:_fullScreenScrollView];
            
        }
    } else {
        UIImageView *imageview=(UIImageView*)[self.view viewWithTag:tap.view.tag];
        
        if(imageview.tag== 2000+_imageArray.count)
        {
            [MBProgressHUD showError:@"最多选择10张图片"];
            
        } else{
            
            NSInteger image_page=imageview.tag%2000+1;
            
            UIView *Screenwindow = [[UIApplication sharedApplication].delegate window];
            
            _fullScreenScrollView = [[FullScreenScrollView alloc]initWithPicutreArray:_imageArray withCurrentPage:image_page];
            
            _fullScreenScrollView.backgroundColor = [UIColor blackColor];
            
            [Screenwindow addSubview:_fullScreenScrollView];
            
        }
        
    }
}

#pragma mark 弹出标签视图
- (IBAction)popoverBtnClicked:(id)sender forEvent:(UIEvent *)event {
   
//    [self creatPopview];
    
    
    [UIView animateWithDuration:0.3f animations:^{
       [self creatPopview];
        
    } completion:^(BOOL finished) {
//        [self.view addSubview:_PopView];
        
    }];

    
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    if(!window) {
//        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
//    }
//    NSSet *set = event.allTouches;
//    UITouch *touch = [set anyObject];
//    CGPoint point1 = [touch locationInView:window];
//
//    [KWPopoverView showPopoverAtPoint:point1 inView:self.view withContentView:_PopView];
}



-(void)tagclick:(UIButton*)sender
{
    
//    TagViewController *tagview=[[TagViewController alloc]init];
//    [self.navigationController pushViewController:tagview animated:YES];
}

-(void)creatModelview
{
    //底视图
    _modelview=[[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight+100, kApplicationWidth, 200)];
    
    _modelview=[[UIView alloc]init];
    
    _modelview.frame=CGRectMake(0, -200, kApplicationWidth, 200);
    
    _modelview.tag=9999;
    _modelview.backgroundColor=[UIColor groupTableViewBackgroundColor];
    

    [_modelview bringSubviewToFront:self.view];
    
    UIView *backview=[[UIView alloc]initWithFrame:CGRectMake(0, 50, _modelview.frame.size.width, 150)];
    backview.backgroundColor=[UIColor redColor];
    [_modelview addSubview:backview];
    
    UIButton *okbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    okbtn.frame=CGRectMake(10, 10, 80, 40);
    [okbtn setTitle:@"确定" forState:UIControlStateNormal];
    okbtn.backgroundColor=tarbarrossred;
    [_modelview addSubview:okbtn];
    
    UIButton *canclebtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    canclebtn.frame=CGRectMake(_modelview.frame.size.width-90, 10, 80, 40);
    [canclebtn setTitle:@"取消" forState:UIControlStateNormal];
    [canclebtn setBackgroundColor:tarbarrossred];
    [_modelview addSubview:canclebtn];
    
}

#pragma mark 选择标签
-(void)tagbtnclick:(UIButton*)sender
{
    
    sender.selected=!sender.selected;
    
    NSString *zhuangxiustr;
  
//多选
    /*
    if (sender.selected == YES) {
        sender.backgroundColor = tarbarrossred;

        [_tagArray addObject:sender.titleLabel.text];
        tagLabel = [NSString stringWithFormat:@"%d",sender.tag%6000];
    }else{
        [_tagArray removeObject:sender.titleLabel.text];
        sender.backgroundColor = [UIColor whiteColor];
    }
     */
 //单选
    for (UIView *v in sender.superview.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            UIButton *button=(UIButton *)v;
            if (button==sender) {
                
                zhuangxiustr=button.titleLabel.text;
                
                button.backgroundColor=tarbarrossred;
                button.tintColor = [UIColor whiteColor];
                
                button.layer.borderWidth=0;
                sender.selected=YES;
                
                //将用户选择的标签添加到数组里
                if(button.titleLabel.text)
                {
                    [_tagArray addObject:button.titleLabel.text];
                    tagLabel = [NSString stringWithFormat:@"%d",button.tag%6000];
//                    [_tagArray addObject:[NSString stringWithFormat:@"%d",button.tag%6000]];
                }
                
                
                
            }
            else
            {
                button.backgroundColor=[UIColor whiteColor];
                
                button.layer.borderWidth=0.5;
                button.selected=NO;
                
                //如果取消选择将从数组里删除
                for(int i=0;i<_tagArray.count;i++)
                {
                    if([button.titleLabel.text isEqualToString:_tagArray[i]])
                    {
                        [_tagArray removeObjectAtIndex:i];
                    }
                }
                
            }
        }
        
    }
 

#if 0
    if(sender.selected==NO)
    {
        UIButton *button=(UIButton*)[_PopView viewWithTag:sender.tag];
        
        button.backgroundColor=tarbarrossred;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.tintColor=[UIColor whiteColor];
        button.layer.borderWidth=0;
        sender.selected=YES;
        
        //将用户选择的喜好添加到数组里
        if(button.titleLabel.text)
        {
            [_tagArray addObject:button.titleLabel.text];
        }
        
    }else{
        UIButton *button=(UIButton*)[_PopView viewWithTag:sender.tag];
        
        button.backgroundColor=[UIColor clearColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tintColor=[UIColor blackColor];
        button.layer.borderWidth=1;
        button.layer.borderColor=kbackgrayColor.CGColor;
        sender.selected=NO;
        
        //如果取消选择将从数组里删除
        for(int i=0;i<_tagArray.count;i++)
        {
            if([button.titleLabel.text isEqualToString:_tagArray[i]])
            {
                [_tagArray removeObjectAtIndex:i];
            }
        }
    }
    
#endif

}

#pragma mark 取消标签
-(void)cancleclick:(UIButton*)sender
{
    UIView *view=(UIView*)[self.view viewWithTag:8888];
    [UIView animateWithDuration:0.3f animations:^{
        _PopView.transform = CGAffineTransformMakeScale(0.05, 0.05);
        view.alpha=0;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
        
    }];

}

#pragma mark 确定标签
-(void)okclick:(UIButton*)sender
{
    UIView *view=(UIView*)[self.view viewWithTag:8888];

    [UIView animateWithDuration:0.3f animations:^{
        _PopView.transform = CGAffineTransformMakeScale(0.05, 0.05);
        view.alpha=0;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
        
    }];

    
    if(_tagArray.count)
    {
        //注册通知
        NSNotification *notification=[NSNotification notificationWithName:@"touchText" object:_tagArray];
    
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
    
    [_tagArray removeAllObjects];
    
    
}

//显示标签
-(void)changeatext:(NSNotification*)note
{
    NSArray *tagarr=note.object;
    NSMutableString *str=[NSMutableString string];
    for(int i=0;i<tagarr.count;i++)
    {
        [str appendString:tagarr[i]];
        [str appendString:@" "];
    }
    self.taglable.text=tagarr[tagarr.count-1];
    
}


#pragma mark 发表话题
-(void)submit:(UIButton*)sender
{
    if([self.titlteView.text isEqualToString:@"标题,诱人的会有更多人看"])
    {
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"标题不能为空" Controller:self];
        
        return;
    }
    
    if([self.contentView.text isEqualToString:@"内容,诱人的会有更多人看"])
    {
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"内容不能为空" Controller:self];
        
        return;
    }
//    //%lu  ==  %lu",(unsigned long)[MyMD5 asciiLengthOfString:self.titlteView.text],(unsigned long)[MyMD5 asciiLengthOfString:self.contentView.text]);

    //发表");
    
    if(self.titlteView.text==nil||[self.titlteView.text  isEqualToString: @""])
    {
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"标题不能为空" Controller:self];
        
        return;
    }else{
        
        if ([MyMD5 asciiLengthOfString:self.titlteView.text]<8)
        {
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"圈圈标题不能少于8个字符" Controller:self];
            return;
        }else if ([MyMD5 asciiLengthOfString:self.titlteView.text]>30)
        {
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"圈圈标题不能多于30个字符" Controller:self];
            return;

        }

    }
    
    if(self.contentView.text ==nil||[self.contentView.text isEqualToString:@""])
    {
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"内容不能为空" Controller:self];
        
        return;

    }else{
        
        if ([MyMD5 asciiLengthOfString:self.contentView.text]<6)
        {
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"圈圈内容不能少于6个字符" Controller:self];
            return;
        }else if ([MyMD5 asciiLengthOfString:self.contentView.text]>5000)
        {
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"圈圈内容不能多于5000个字符" Controller:self];
            return;

        }

    }
    //%@",_taglable.text);
    
    if ([_taglable.text isEqualToString:@"选择标签（必选）"]||_taglable.text == nil||_taglable.text.length==0) {
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"请选择标签" Controller:self];
        
        return;

    }
    if(_imageArray.count)
    {
        _altet_isshow = NO;
        
        [self creatUPY];
        
    }else{
        [self submitHttp];
    }
}

#pragma mark 将图片上传到upyun
-(void)creatUPY
{
    [_images setString:@""];
    
    __block int count=(int)_imageArray.count;
    
    UpYun *uy = [[UpYun alloc] init];
    [MBProgressHUD showMessage:@"正在玩命发帖" afterDeleay:0 WithView:self.view];
    
    uy.successBlocker = ^(id data)
    {
        NSString *imgurl=[NSString stringWithFormat:@"%@",data[@"url"]];
        //imgurl--%@",imgurl);
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],imgurl]]];
            UIImage * img = [UIImage imageWithData:data];
            
            CGFloat scale = 1.0 ;
            if(img)
            {
                scale = img.size.width/img.size.height;
            }
            
            if(imgurl)
            {
                
                [_images appendString:imgurl];
                [_images appendString:@":"];
                [_images appendString:[NSString stringWithFormat:@"%.2f",scale]];
                [_images appendString:@","];
                
                count=count-1;
                
                MyLog(@"count = %d",count);
            }

        
            if(count==0)
            {
                
                dispatch_async(dispatch_get_main_queue(), ^{ // 主线程刷新UI
                    
                    [MBProgressHUD hideHUDForView:self.view];
                    [self submitHttp];
                });

            }

            
        });
    
    };
    
    uy.failBlocker = ^(NSError * error)
    {
        
        if(_altet_isshow == NO)
        {
            [MBProgressHUD hideHUDForView:self.view];
            NSString *message = [error.userInfo objectForKey:@"message"];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"发送失败，稍后重试!" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            //%@",error);
            
            _altet_isshow = YES;

        }
        
        count=count-1;
    };
    
    
    for(int i=0;i<_imageArray.count;i++)
    {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIImage * image1 =[self compressionImage:_imageArray[i]];
            
            [uy uploadFile:image1 saveKey:[self getSaveKey]];
            
            
        });

    }

}

-(NSString * )getSaveKey {
    
    NSString *UID=[self getNumber];
    NSDate *d = [NSDate date];
    float a = ([d timeIntervalSince1970]-(int)[d timeIntervalSince1970]);
    int inta = a *100000;
    //%d",inta);
    return [NSString stringWithFormat:@"%@%@%d%.0d.jpg",@"circle_news/",UID,[self getSecond:d],inta];
    
}

#pragma mark 获取毫秒数
- (int)getSecond:(NSDate *) date{
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    int second = [comps second];
    return second;
    
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
            
            strNum=[strNum stringByAppendingString:character];//是数字的累加起来
        }
        
    }
    return strNum;
}

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
    
    MyLog(@"************%d",[imageData length]);
    
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

#pragma mark - 发帖
/**
 *  发帖
 */
-(void)submitHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];

       
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    NSString *tag;
    if(_tagArray.count)
    {
        tag=_tagArray[0];
    }
    NSString *url;
    url=[NSString stringWithFormat:@"%@circleNews/insert?version=%@&token=%@&circle_id=%@&title=%@&content=%@&pic_list=%@&tag=%@",[NSObject baseURLStr],VERSION,token,self.circle_id,self.titlteView.text,self.contentView.text,_images,tagLabel];
    
    NSString *URL=[MyMD5 authkey:url];
    [MBProgressHUD showMessage:@"正在玩命发帖" afterDeleay:0 WithView:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(statu.intValue==1)//请求成功
            {
                message=@"恭喜你发帖成功";
                
                NSNotification *submitSuccess = [[NSNotification alloc]initWithName:@"submitSuccess" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:submitSuccess];
            }
            else if(statu.intValue == 10030){//没登录状态
                
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud removeObjectForKey:USER_TOKEN];
                
                LoginViewController *login=[[LoginViewController alloc]init];
                
                login.tag=1000;
                login.loginStatue = @"10030";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
                
            }

            else{
                
                if(statu.intValue==100)
                {
                    message=[NSString stringWithFormat:@"Sorry,检测到敏感词%@",responseObject[@"word"][0]];
                    
                }else{
                    message=@"Sorry,发帖失败";
                    
                }
                
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
            
            if(statu.intValue == 1)
            {
                [NSTimer weakTimerWithTimeInterval:1.5 target:self selector:@selector(pop) userInfo:nil repeats:NO];
                
            }

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
        
    }];


}
-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.message=textView;
    return YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if(textView==self.titlteView)
    {
        [self.titleLabel removeFromSuperview];
        if([self.titlteView.text isEqualToString:@"标题,诱人的会有更多人看"])
        {
            self.titlteView.text=@"";
        }
    }else{
        [self.contentLabel removeFromSuperview];
        if([self.contentView.text isEqualToString:@"内容,诱人的会有更多人看"])
        {
            self.contentView.text=@"";
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if(_iskeyboardmove==NO)
        {
//           _Myscrollview.frame=CGRectMake(0, -_moveHeigh, kApplicationWidth, kApplicationHeight);
            
//            _Myscrollview.contentOffset=CGPointMake(0, self.backView.frame.size.height-20);
        }
    } completion:^(BOOL finished) {
        
        _iskeyboardmove=YES;
    }];

}

#pragma mark - keyboard
- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    CGPoint rootViewPoint = [[self.message superview] convertPoint:self.message.frame.origin toView:self.view];
    //%f  %f",self.message.frame.origin.y,rootViewPoint.y);
    
    CGFloat height =rootViewPoint.y -keyboardFrame.origin.y;
    
    if (height>0)
    {
        [UIView animateWithDuration:animationDuration
                         animations:^{
                             _Myscrollview.frame=CGRectMake(0,_Myscrollview.frame.origin.y-height-64, kApplicationWidth, _Myscrollview.frame.size.height);
                             
                         }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         _Myscrollview.frame=CGRectMake(0, 64, kApplicationWidth, _Myscrollview.frame.size.height);
                     }];
}
- (void)pop
{
    if ([_delegate respondsToSelector:@selector(submitRefreshInfo)]) {
        [_delegate submitRefreshInfo];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
//    if(textView==self.titlteView)
//    {
//        if(self.titlteView.text==nil)
//        {
//            self.titlteView.text=@"标题,诱人的会有更多人看";
//        }
//    }else{
//        if(self.contentView.text==nil)
//        {
//            self.contentView.text=@"内容,诱人的会有更多人看";
//        }
//    }

    [self judgeLengthOfTextView];
}
-(void)judgeLengthOfTextView
{
    
    if ([MyMD5 asciiLengthOfString:self.titlteView.text]<8)
    {
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"圈圈标题不能少于8个字符" Controller:self];
        return;
    }else if ([MyMD5 asciiLengthOfString:self.titlteView.text]>30)
    {
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"圈圈标题不能多于30个字符" Controller:self];
        return;
        
    }

    if ([MyMD5 asciiLengthOfString:self.contentView.text]<6)
    {
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"圈圈内容不能少于6个字符" Controller:self];
        return;
    }else if ([MyMD5 asciiLengthOfString:self.contentView.text]>5000)
    {
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"圈圈内容不能多于5000个字符" Controller:self];
        return;
        
    }

    
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
