//
//  CircledetailViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/6/10.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "CircledetailViewController.h"
#import "GlobalTool.h"
#import "ForumModel.h"
#import "UIImageView+WebCache.h"
#import "PersonHomepageViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "NavgationbarView.h"
#import "MyMD5.h"

#import "TFLoginView.h"
#import "LoginViewController.h"

@interface CircledetailViewController ()
{
    NSMutableArray *_imageArray;
}
@end

@implementation CircledetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _imageArray=[NSMutableArray array];
    
    self.addcirdle.hidden=NO;
    
    //导航条
    UIView *headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
//    headview.image=[UIImage imageNamed:@"u265"];
    [self.bgview addSubview:headview];
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
    titlelable.text=@"圈子详情";
    titlelable.textColor=kMainTitleColor;
    titlelable.font = kNavTitleFontSize;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    [self creatData];
    [self creatView];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Myview.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [_imageArray removeAllObjects];
    Myview.hidden=NO;
}

-(void)creatData
{
    for(int i=0;i<self.circleArr.count;i++)
    {
        ForumModel *model=_circleArr[i];
        if(model.pic !=nil)
        {
            [_imageArray addObject:model];
        }
    }
}
-(void)creatView
{
    
//    [self.bigimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PHOTOhttp,self.circleModel.bg_pic]]];
//    [self.bigimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],self.circleModel.bg_pic]] placeholderImage:[UIImage imageNamed:@"背景图"]];
    
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!560",[NSObject baseURLStr_Upy],self.circleModel.bg_pic]];
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [self.bigimage sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"背景图.jpg"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d = (float)receivedSize/expectedSize;
        isDownlaod = YES;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod == YES) {
            self.bigimage.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                self.bigimage.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        } else if (image != nil && isDownlaod == NO) {
            self.bigimage.image = image;
        }
    }];
    
//    [self.headimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PHOTOhttp,self.circleModel.pic]]];
//    [self.headimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],self.circleModel.pic]] placeholderImage:[UIImage imageNamed:@"默认头像.jpg"]];
    
    NSURL *imgUrl2 = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!180",[NSObject baseURLStr_Upy],self.circleModel.pic]];
    __block float d2 = 0;
    __block BOOL isDownlaod2 = NO;
    [self.headimage sd_setImageWithURL:imgUrl2 placeholderImage:[UIImage imageNamed:@"默认头像.jpg"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d2 = (float)receivedSize/expectedSize;
        isDownlaod2 = YES;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod2 == YES) {
            self.headimage.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                self.headimage.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        } else if (image != nil && isDownlaod2 == NO) {
            self.headimage.image = image;
        }
    }];
    
    self.headimage.clipsToBounds=YES;
    _headimage.layer.borderWidth = 2;
    _headimage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headimage.layer.cornerRadius=self.headimage.frame.size.width/2;
    
    
//    CGFloat circletitleY = CGRectGetMaxY(self.headimage.frame);
//    self.circletitle.frame=CGRectMake(self.circletitle.frame.origin.x, circletitleY, self.circletitle.frame.size.width, self.circletitle.frame.size.height);
    self.circletitle.text=self.circleModel.title;
    self.circletitle.font = [UIFont systemFontOfSize:ZOOM(51)];
    self.circletitle.textColor = kTitleColor;
    
    //评论
    
    CGFloat punlunImgX = CGRectGetMaxX(self.headimage.frame);
    
    self.punlunImg.userInteractionEnabled=YES;
    self.punlunImg.clipsToBounds = YES;
    self.punlunImg.frame = CGRectMake(punlunImgX + ZOOM(150), self.punlunImg.frame.origin.y, self.punlunImg.frame.size.width, self.punlunImg.frame.size.height);
    
    //评论数
    CGFloat circle_countX = CGRectGetMaxX(self.punlunImg.frame);
    self.circle_count.frame =CGRectMake(circle_countX+5, self.circle_count.frame.origin.y, ZOOM(120), self.circle_count.frame.size.height);
    self.circle_count.text=[NSString stringWithFormat:@"%@",self.n_count];
    if (_n_count==nil) {
        self.circle_count.text=[NSString stringWithFormat:@"0"];

    }
    
    CGFloat numImgX = CGRectGetMaxX(self.circle_count.frame);
    self.numImg.frame = CGRectMake(numImgX+10, self.numImg.frame.origin.y, self.numImg.frame.size.width, self.numImg.frame.size.height);
    
    //人数
    CGFloat num_countX = CGRectGetMaxX(self.numImg.frame);
    self.num_cont.frame=CGRectMake(num_countX+5, self.num_cont.frame.origin.y, ZOOM(120),self.num_cont.frame.size.height);
    self.num_cont.text=[NSString stringWithFormat:@"%@",self.u_count];
    if (_u_count==nil) {
        self.num_cont.text=[NSString stringWithFormat:@"0"];
    }
    
    //对话数
    self.duihuaNum.frame =CGRectMake(ZOOM(62), self.duihuaNum.frame.origin.y, ZOOM(200), self.duihuaNum.frame.size.height);
    
    self.duihuaNum.font = [UIFont systemFontOfSize:ZOOM(51)];
    self.duihuaNum.textColor =kTitleColor;
    
    self.dailogue.frame=CGRectMake(ZOOM(62), self.dailogue.frame.origin.y, self.dailogue.frame.size.width, self.dailogue.frame.size.height);
    
    self.dailogue.text=[NSString stringWithFormat:@"对话数:%@",self.rn_count];
    self.dailogue.textColor = kTitleColor;
    self.dailogue.font = [UIFont systemFontOfSize:ZOOM(51)];
    
    
    //圈主
    self.circleAdmin.frame = CGRectMake(ZOOM(62), self.circleAdmin.frame.origin.y, ZOOM(200), self.circleAdmin.frame.size.height);
    self.circleAdmin.font=[UIFont systemFontOfSize:ZOOM(51)];
    self.circleAdmin.textColor =kTitleColor;
    
    UIScrollView *imgScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(self.circleAdmin.frame.origin.x+_circleAdmin.frame.size.width, self.circleAdmin.frame.origin.y-15, kScreenWidth-CGRectGetMaxX(_circleAdmin.frame)-60, 50)];
    imgScrollView.showsHorizontalScrollIndicator=NO;
    imgScrollView.contentSize=CGSizeMake(60*_imageArray.count, 50);
    [self.circleview addSubview:imgScrollView];
    
    for(int i=0;i<_imageArray.count;i++)
    {
    
        ForumModel *model=_imageArray[i];
        
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(60*i, 0, 50, 50)];

//        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(self.circleAdmin.frame.origin.x+_circleAdmin.frame.size.width+60*i, self.circleAdmin.frame.origin.y-15, 50, 50)];
//        [imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PHOTOhttp,model.pic]]];
//        [imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.pic]]placeholderImage:[UIImage imageNamed:@"默认头像.jpg"]];
        
        NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!180",[NSObject baseURLStr_Upy],model.pic]];
        
        if ([model.pic hasPrefix:@"http://"]) {
            imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.pic]];
        }
        
        __block float d = 0;
        __block BOOL isDownlaod = NO;
        [imageview sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"默认头像.jpg"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            d = (float)receivedSize/expectedSize;
            isDownlaod = YES;
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image != nil && isDownlaod == YES) {
                imageview.alpha = 0;
                [UIView animateWithDuration:0.5 animations:^{
                    imageview.alpha = 1;
                } completion:^(BOOL finished) {
                }];
            } else if (image != nil && isDownlaod == NO) {
                imageview.image = image;
            }
        }];
        
        imageview.clipsToBounds=YES;
        imageview.backgroundColor=[UIColor redColor];
        imageview.layer.cornerRadius=25;
        imageview.tag=2000+i;
//        [self.circleview addSubview:imageview];
        [imgScrollView addSubview:imageview];

        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageclick:)];
        [imageview addGestureRecognizer:tap];
        imageview.userInteractionEnabled=YES;
        
        
        UILabel *namelable=[[UILabel alloc]initWithFrame:CGRectMake(imageview.frame.origin.x, imageview.frame.origin.y+imageview.frame.size.height, 50, 50)];
        namelable.text=model.nickname;
        namelable.font=[UIFont systemFontOfSize:15];
        namelable.textAlignment=NSTextAlignmentCenter;
        [imgScrollView addSubview:namelable];
    }
    
    //圈规则
    self.circleRule.frame = CGRectMake(ZOOM(62), self.circleRule.frame.origin.y, ZOOM(200), self.circleRule.frame.size.height);
    self.circleRule.font =[UIFont systemFontOfSize:ZOOM(51)];
    self.circleRule.textColor =kTitleColor;
    

    
    CGFloat height=30;
    NSDictionary *attributes = @{NSFontAttributeName :[UIFont systemFontOfSize:ZOOM(44)]};
    CGRect rect = [_circleModel.content boundingRectWithSize:CGSizeMake(kApplicationWidth-ZOOM(62)*2, MAXFLOAT)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:attributes
                                               context:nil];
    height = CGRectGetHeight(rect);
    
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), 60, kApplicationWidth-ZOOM(62)*2, height)];
    lable.text=self.circleModel.content;
    lable.font=[UIFont systemFontOfSize:ZOOM(44)];
    lable.textColor=kTextColor;
    
    [self.ruleView addSubview:lable];
    
//    self.myscrollview.contentSize=CGSizeMake(_myscrollview.frame.size.width, _myscrollview.frame.size.height+height);
}


-(void)imageclick:(UITapGestureRecognizer*)tap
{
    NSInteger index=tap.view.tag%2000;
    
    ForumModel *model=_imageArray[index];
    
    PersonHomepageViewController *person=[[PersonHomepageViewController alloc]init];
    person.userid=model.user_id;
    person.forumModel=model;
    [self.navigationController pushViewController:person animated:YES];
    
    
}
#pragma mark 网络请求————加入圈
-(void)AddcircleHttp:(NSString*)circleid
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    url=[NSString stringWithFormat:@"%@circle/add?version=%@&token=%@&circle_id=%@",[NSObject baseURLStr],VERSION,token,circleid];
    
    NSString *URL=[MyMD5 authkey:url];
//    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [MBProgressHUD hideHUDForView:self.view];
         [[Animation shareAnimation] stopAnimationAt:self.view];
        
        if (responseObject!=nil) {
//            //
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(statu.intValue==1)//请求成功
            {
                message=@"恭喜你成功加入该圈";
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
                //            message=@"加入该圈失败";
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];

        }
 
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        [MBProgressHUD hideHUDForView:self.view];
         [[Animation shareAnimation] stopAnimationAt:self.view];
      
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
        
    }];
    
    
}

#pragma mark 成为圈主
-(void)becomeQuanZhu:(NSString*)cicleID
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    url=[NSString stringWithFormat:@"%@circle/apply?version=%@&token=%@&circle_id=%@",[NSObject baseURLStr],VERSION,token,cicleID];
    
    NSString *URL=[MyMD5 authkey:url];
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        if (responseObject!=nil) {
//            //
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(statu.intValue==1)//请求成功
            {
                message=@"恭喜你申请圈主成功";
            }else{
//                message=@"申请圈主失败";
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
        
    }];
    

}
#pragma mark 跳转到登录界面
- (void)ToLogin :(NSInteger)tag
{
    LoginViewController *login=[[LoginViewController alloc]init];
    login.tag = tag;
    login.loginStatue=@"toBack";
    login.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:login animated:YES];
}

- (void)ToLoginView
{
    TFLoginView *tf = [[TFLoginView alloc] initWithHeadImage:nil contentText:nil upButtonTitle:nil downButtonTitle:nil];
    [tf show];
    
    tf.upBlock = ^() { //注册
        //上键");
        
        [self ToLogin:2000];
    };
    
    tf.downBlock = ^() {// 登录
        //下键");
        
        [self ToLogin:1000];
    };
}
- (IBAction)addToCircle:(UIButton *)sender {
    
    NSString *circleid=[NSString stringWithFormat:@"%@",self.circleModel.circle_id];
//    [self AddcircleHttp:circleid];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]==nil) {
        [self ToLoginView];
        return;
    }else{
    [self becomeQuanZhu:circleid];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)dealloc
{
    [_imageArray removeAllObjects];
}
@end
