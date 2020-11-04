//
//  ShareToFriendsView.m
//  TMQRCode
//
//  Created by yssj on 16/7/25.
//  Copyright © 2016年 CFJ. All rights reserved.
//

#import "ShareToFriendsView.h"

#import "UIImage+CFQRcode.h"
#import "GlobalTool.h"
#import "DShareManager.h"
#import "AppDelegate.h"
#import "ShareToFriendsModel.h"


@interface ShareToFriendsView()
@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UIScrollView *myScro;
@property (strong, nonatomic) NSString *ShareString;
@end

typedef NS_ENUM(NSInteger,BtnTag) {
    BtnTag_WX=100,
    BtnTag_QQ,
    BtnTag_Save
};

@implementation ShareToFriendsView

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    _myScro=[[UIScrollView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar)];
    _myScro.contentSize=CGSizeMake(kScreenWidth, kScreenHeight>=568?kScreenHeight-Height_NavBar:568-Height_NavBar);
    [self.view addSubview:_myScro];
    
    [self setNavigationItemLeft:@"邀请有礼"];

    [self httpModel];
}
-(void)httpModel{
    kSelfWeak;
    [self loadFailBtnBlock:^{
        [weakSelf httpModel];
    }];
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    [ShareToFriendsModel getModelWithToken:[TFPublicClass getTokenFromLocal] success:^(id data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ShareToFriendsModel *model=data;
        if (model.status == 1) {
            _ShareString=model.data.link;
            [weakSelf initSubView];
        }else
            [self loadingDataBackgroundView:weakSelf.view img:[UIImage imageNamed:@"哭脸"] text:@"亲,没网了"];
    }];
}
-(void)initSubView{
    __weak typeof (self) weakSelf = self;
    NSString *aPath=[NSString stringWithFormat:@"%@/Documents/headImgae%@.png",NSHomeDirectory(),[[NSUserDefaults standardUserDefaults] objectForKey:USER_ID]];
    UIImage *imgFromUrl=[[UIImage alloc] initWithContentsOfFile:aPath];
    
    [UIImage qrImageWithString:_ShareString size:CGRectGetWidth(self.imgView.frame)*0.29 CenterImageType:CenterImgType_Circle iconImage:imgFromUrl scale:0.3  completion:^(UIImage *image) {
        
        // 给二维码图片添加背景图片
        [UIImage qrIamge:image addBgImage:[UIImage imageNamed:@"邀请好友_背景"] bgImageSize:(int) CGRectGetHeight(self.imgView.frame) completion:^(UIImage *image) {
            weakSelf.imgView.image = image;
        }];
        
    }];
    
    CGFloat left=ZOOM(100); CGFloat bottomSpace=ZOOM(100);
    CGFloat BtnWidth=(self.view.frame.size.width-left*2)/3;
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        [self.myScro addSubview:[self setBtnFrame:CGRectMake(left , self.myScro.contentSize.height-bottomSpace-BtnWidth, BtnWidth, BtnWidth)withTag:BtnTag_WX]];
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]])
    {
        [self.myScro addSubview:[self setBtnFrame:CGRectMake(BtnWidth+left , self.myScro.contentSize.height-bottomSpace-BtnWidth, BtnWidth, BtnWidth)withTag:BtnTag_QQ]];
    }
    [self.myScro addSubview:[self setBtnFrame:CGRectMake(BtnWidth*2+left , self.myScro.contentSize.height-bottomSpace-BtnWidth, BtnWidth, BtnWidth)withTag:BtnTag_Save]];
}
-(UIButton *)setBtnFrame:(CGRect)frame withTag:(NSInteger)tag{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    btn.tag=tag;
//    btn.backgroundColor=DRandomColor;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 2, btn.frame.size.width, ZOOM(150))];
    img.contentMode=UIViewContentModeScaleAspectFit;
    [btn addSubview:img];
    UILabel *BtnTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, img.frame.size.height, frame.size.width, 30)];
    BtnTitle.font=[UIFont systemFontOfSize:ZOOM(44)];
    BtnTitle.textAlignment=NSTextAlignmentCenter;
    [btn addSubview:BtnTitle];
    
    switch (tag) {
        case BtnTag_WX:
            BtnTitle.text=@"朋友圈";
            [img setImage:[UIImage imageNamed:@"邀请好友_朋友圈"]];
            break;
        case BtnTag_QQ:
            BtnTitle.text=@"QQ";
            [img setImage:[UIImage imageNamed:@"邀请好友_QQ"]];
            break;
        case BtnTag_Save:
            BtnTitle.text=@"保存图片";
            [img setImage:[UIImage imageNamed:@"邀请好友_保存图片"] ];
            break;
        default:
            break;
    }
    return btn;
}
-(UIImageView *)imgView{
    if (_imgView==nil) {
        _imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0 , self.view.frame.size.width, self.view.frame.size.width*1250/1080)];
        _imgView.contentMode=UIViewContentModeScaleAspectFit;
        [self.myScro addSubview:_imgView];
    }
    return _imgView;
}
-(void)btnClick:(UIButton *)Sender{
    switch (Sender.tag) {
        case BtnTag_WX:{
            AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
            [app shardk];
            [[DShareManager share] shareAppWithType:ShareTypeWeixiTimeline View:nil Image:self.imgView.image WithShareType:@"ShareToFriends"];
            kSelfWeak;
            [DShareManager share].ShareSuccessBlock = ^{
                [MBProgressHUD showSuccess:@"分享成功" toView:weakSelf.view];
            };
            [DShareManager share].ShareFailBlock = ^{
                [MBProgressHUD showError:@"分享失败" toView:weakSelf.view];
            };
        }
            break;
        case BtnTag_QQ:{
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",_ShareString] forKey:QR_LINK];
            AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
            [app shardk];
            [[DShareManager share] shareAppWithType:ShareTypeQQSpace View:nil Image:[UIImage imageNamed:@"邀请好友_QQ空间"] WithShareType:@"ShareToFriends"];
            kSelfWeak;
            [DShareManager share].ShareSuccessBlock = ^{
                [MBProgressHUD showSuccess:@"分享成功" toView:weakSelf.view];
            };
            [DShareManager share].ShareFailBlock = ^{
                [MBProgressHUD showError:@"分享失败" toView:weakSelf.view];
            };
        }
            break;
        case BtnTag_Save:
            UIImageWriteToSavedPhotosAlbum(self.imgView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            break;
        default:
            break;
    }
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error != NULL) {
        UIAlertView *photoSave = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [photoSave show];
        [photoSave dismissWithClickedButtonIndex:0 animated:YES];
        photoSave = nil;
    }else {
//        UIAlertView *photoSave = [[UIAlertView alloc] initWithTitle:@"保存成功" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
//        [photoSave show];
//        [photoSave dismissWithClickedButtonIndex:0 animated:YES];
//        photoSave = nil;
        [MBProgressHUD showSuccess:@"保存成功" toView:self.view];

    }
}

@end
