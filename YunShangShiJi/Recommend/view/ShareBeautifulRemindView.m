//
//  ShareBeautifulRemindView.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/8.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "ShareBeautifulRemindView.h"
#import "FullScreenScrollView.h"
#import "RecommendLikeModel.h"
#import "NavgationbarView.h"
#import "commendToastView.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "GlobalTool.h"
#import "KeyboardTool.h"
#import "AppDelegate.h"
#import "UpdatePhotosToYpy.h"
#import "SubmitLikeModel.h"
#import "ShopShareModel.h"

@implementation ShareBeautifulRemindView
{
    CGFloat invitcodeYY;                  //弹框初始y坐标
    CGFloat ShareInvitationCodeViewHeigh; //弹框的高度
    CGFloat ShareInvitationCodeViewWidth; //弹框的宽度
    
    NSString *_oldcontent;                //发布的内容
    int _delatebtntag;                    //删除图片的下标
    FullScreenScrollView *_fullScreenScrollView;
}

- (instancetype)initWithFrame:(CGRect)frame Photos:(NSMutableArray *)photos exitBtnHide:(BOOL)hide
{
    if(self = [super initWithFrame:frame])
    {
        
        [self creatTextData];
        [self creaPopview:hide];
        
        [self changePhotoView:photos Type:1];
        
        [TFStatisticsClickVM StatisticshandleDataWithClickType:@"到达左划右划发密友圈弹窗页" success:nil failure:nil];

    }
    return self;
}

#pragma mark 刷新视图
- (void)refreshView:(NSArray *)images
{
    MyLog(@"ok*************");
    [self changePhotoView:images Type:3];
}

//fromtype== 1网络获取刷新 2删除时刷新 3相册选取刷新
-(void)changePhotoView:(NSArray *)PhotoArray Type:(NSInteger)fromtype;
{
    if(PhotoArray.count)
    {
        for(UIView *vv in self.photoScrollView.subviews)
        {
            [vv  removeFromSuperview];
        }
        [self.selectShopcodes removeAllObjects];
        [self.selectPhotos removeAllObjects];
        
        if(fromtype==1 || fromtype==3)
        {
            [self.selectPhotos addObject:@"recommend_zijixuan"];
            [self.shopDictionary removeAllObjects];
        }
        
        for(int i =0 ;i<PhotoArray.count;i++)
        {
            if(fromtype==2)
            {
                [self.selectPhotos addObject:PhotoArray[i]];
                NSString *shopcode = [NSString stringWithFormat:@"%@",[self.shopDictionary objectForKey:PhotoArray[i]]];
                if(shopcode!=nil && ![shopcode isEqualToString:@"(null)"])
                {
                    [self.selectShopcodes addObject:shopcode];
                }
                
            }else if (fromtype==1)
            {
                ShopShareModel *model = PhotoArray[i];
                
                NSMutableString *code = [NSMutableString stringWithString:model.shop_code];
                NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
                
                NSMutableString *str1 = [NSMutableString stringWithString:model.show_pic];
                NSArray *arr1 = [str1 componentsSeparatedByString:@","];
                if(arr1.count)
                {
                    NSString *imageurl = [NSString stringWithFormat:@"%@/%@/%@",supcode,model.shop_code,arr1[0]];
                    
                    [self.selectPhotos addObject:imageurl];
                    [self.selectShopcodes addObject:model.shop_code];
                    [self.shopDictionary setObject:model.shop_code forKey:imageurl];
                }
                
            }else if (fromtype == 3)
            {
                ShopShareModel *model = PhotoArray[i];
                [self.selectPhotos addObject:model.show_pic];
                [self.selectShopcodes addObject:model.shop_code];
                [self.shopDictionary setObject:model.shop_code forKey:model.show_pic];
            }
        }
    }
    
    int k=0;
    for(int j=0;j<self.selectPhotos.count;j++){
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake((ZOOM6(130)+12)*j, ZOOM6(10), ZOOM6(130), ZOOM6(130))];
        if(k<self.selectPhotos.count){
            if(j == 0)
            {
                 imageview.image=[UIImage imageNamed:self.selectPhotos[k]];
            }else{
                [imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],self.selectPhotos[k]]] placeholderImage:nil];
            }
           
            imageview.layer.masksToBounds = YES;
            imageview.contentMode = UIViewContentModeScaleAspectFill;
            imageview.tag=2000+k;
            
            UIButton *deleatebtn = [[UIButton alloc]init];
            deleatebtn.tag = 3000 + k;
            k++;
            
            deleatebtn.frame = CGRectMake(CGRectGetWidth(imageview.frame)-23,3, 20, 20);
            [deleatebtn setImage:[UIImage imageNamed:@"recommend_icon_del"] forState:UIControlStateNormal];
            [deleatebtn addTarget:self action:@selector(delateimage:) forControlEvents:UIControlEventTouchUpInside];
            if(k !=1)
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
    self.photoScrollView.contentSize=CGSizeMake((ZOOM6(130)+10)*self.selectPhotos.count+10, self.photoScrollView.frame.size.height);
    [UIView commitAnimations];
}

-(void)imageclick:(UITapGestureRecognizer*)tap
{
    
    if (self.selectPhotos.count<10) {
        UIImageView *imageview=(UIImageView*)[self.photoScrollView viewWithTag:tap.view.tag];
        
        if(imageview.tag== 2000)
        {
            if(self.addImageBlock)
            {
                self.addImageBlock(self.selectPhotos);
            }
        }
    } else {
        UIImageView *imageview=(UIImageView*)[self.photoScrollView viewWithTag:tap.view.tag];
        
        if(imageview.tag== 2000)
        {
            [MBProgressHUD show:@"最多选择9张图片" icon:nil view:self];
            
        }
    }
}

#pragma mark 大图
- (void)creatfullScreenScrollView:(UIImageView*)imageview
{
    NSInteger image_page=imageview.tag%2000+1;
    
    UIView *Screenwindow = [[UIApplication sharedApplication].delegate window];
    
    _fullScreenScrollView = [[FullScreenScrollView alloc]initWithPicutreArray:self.selectPhotos withCurrentPage:image_page];
    
    _fullScreenScrollView.backgroundColor = [UIColor blackColor];
    
    [Screenwindow addSubview:_fullScreenScrollView];

}
#pragma mark 删除选择的图片
- (void)delateimage:(UIButton*)sender
{
    _delatebtntag = sender.tag%3000;

    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确实要删除此张美图吗?" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    alter.delegate = self;
    [alter show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex ==1)
    {
        if(self.selectPhotos.count){
            
            [self.selectPhotos removeObjectAtIndex:_delatebtntag];
            
            NSMutableArray *images = [NSMutableArray arrayWithArray:self.selectPhotos];
            [self changePhotoView:images Type:2];
        }
    }
}

- (void)creatTextData
{
    self.textviewTitleArray = @[@"这是我喜欢的风格，你们觉得好看咩~",@"今天挑选的心爱款式，觉得好看就点个赞吧~",@"这几件我觉得挺不错的，大家说应该搭什么好呢~",@"看起来好时尚哦~好想试穿怎么办？",@"很用心挑出来的呢~来看看我今日的分享吧！",@"适合小公举们的漂亮美衣，太好看了~自带仙气，送给你们~ ",@"今天的上新美衣哦，上身效果一级棒！",@"推荐几款最in新品，哪款是你的菜呢？",@"这几款气质美衣，上身超显瘦！",@"分享几款流行的穿搭，让你变身街拍达人！赶紧学起来吧~",@"搭配指南，从此告别早上不知道穿什么~",@"推荐几款流行单品给你，超低价格让你穿出时尚哦~",@"大爱这些单品！希望你们也一样喜欢~"];
    int count = arc4random() % self.textviewTitleArray.count;
    _oldcontent = self.textviewTitleArray[count];
}
#pragma mark 创建主视图
- (void)creaPopview:(BOOL)hide
{
    _RemindPopview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    _RemindPopview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _RemindPopview.userInteractionEnabled = YES;
    [self addSubview:_RemindPopview];
    
    ShareInvitationCodeViewWidth = (kScreenWidth-ZOOM(40)*2);
    ShareInvitationCodeViewHeigh = ZOOM6(1035);
    invitcodeYY = (kScreenHeight - ShareInvitationCodeViewHeigh)/2-ZOOM6(20);
    
    //底视图
    _RemindBackView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(40), invitcodeYY, ShareInvitationCodeViewWidth, ShareInvitationCodeViewHeigh)];
    _RemindBackView.layer.cornerRadius = 5;
    _RemindBackView.userInteractionEnabled = YES;
    _RemindBackView.backgroundColor = [UIColor whiteColor];
    [_RemindPopview addSubview:_RemindBackView];
    
    //关闭按钮
    CGFloat btnwidth = ZOOM6(60);
    self.canclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.canclebtn.frame=CGRectMake(CGRectGetWidth(self.RemindBackView.frame)-btnwidth-ZOOM(30), ZOOM6(30), btnwidth, btnwidth);
    [self.canclebtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    self.canclebtn.imageView.contentMode=UIViewContentModeScaleAspectFill;
    [self.canclebtn addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
    [_RemindBackView addSubview:self.canclebtn];
    
    //title
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20),ZOOM6(50), CGRectGetWidth(_RemindBackView.frame)-2*ZOOM6(20), ZOOM6(40))];
    _titleLabel.text = @"分享美衣";
    _titleLabel.numberOfLines = 0;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
    _titleLabel.textColor = RGBCOLOR_I(62, 62, 62);
    [_RemindBackView addSubview:_titleLabel];

    _discriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20),CGRectGetMaxY(_titleLabel.frame), CGRectGetWidth(_RemindBackView.frame)-2*ZOOM6(20), ZOOM6(80))];
    _discriptionLabel.text = @"挑选喜欢的几款，分享到SHOW社区吧~如有好友购买，你可得20%现金奖励。";
    _discriptionLabel.numberOfLines = 0;
    _discriptionLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
    _discriptionLabel.textColor = RGBCOLOR_I(125, 125, 125);
    [_RemindBackView addSubview:_discriptionLabel];

    //分享的图片
    _shareImageView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM6(20), CGRectGetMaxY(_discriptionLabel.frame)+ZOOM6(30), CGRectGetWidth(_discriptionLabel.frame), ZOOM6(150))];
    [_shareImageView addSubview:[self creatPhotoScrollview]];
    [_RemindBackView addSubview:_shareImageView];
    
    //发表的内容
    _ContentTextView = [[UITextView alloc]initWithFrame:CGRectMake(ZOOM6(20), CGRectGetMaxY(_shareImageView.frame)+ZOOM6(50), CGRectGetWidth(_discriptionLabel.frame), ZOOM6(160))];
    _ContentTextView.layer.borderColor = RGBCOLOR_I(197, 197, 197).CGColor;
    _ContentTextView.textColor = RGBCOLOR_I(197, 197, 197);
    _ContentTextView.font = [UIFont systemFontOfSize:ZOOM6(30)];
    _ContentTextView.layer.borderWidth = 0.5;
    _ContentTextView.layer.cornerRadius = 2;
    _ContentTextView.delegate = self;
    _ContentTextView.text = _oldcontent;
    [_RemindBackView addSubview:_ContentTextView];
    
    KeyboardTool *tool = [KeyboardTool keyboardTool];
    tool.delegate = self;
    tool.frame=CGRectMake(0, tool.frame.origin.y, kScreenWidth, 40);
    _ContentTextView.inputAccessoryView = tool;
    
    //发布分享
    _submitBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _submitBtn.frame = CGRectMake(ZOOM6(20),CGRectGetMaxY(_ContentTextView.frame)+ZOOM6(80) , CGRectGetWidth(_titleLabel.frame), ZOOM6(80));
    _submitBtn.backgroundColor = tarbarrossred;
    [_submitBtn setTintColor:[UIColor whiteColor]];
    hide==NO?[_submitBtn setTitle:@"分享到SHOW社区" forState:UIControlStateNormal]:[_submitBtn setTitle:@"分享到SHOW社区" forState:UIControlStateNormal];
    
    _submitBtn.layer.cornerRadius = 5;
    [_submitBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [_RemindBackView addSubview:_submitBtn];
    
    //退出浏览
    _exitBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _exitBtn.frame = CGRectMake(ZOOM6(20),CGRectGetMaxY(_submitBtn.frame)+ZOOM6(30) , CGRectGetWidth(_titleLabel.frame), ZOOM6(80));
    [_exitBtn setTitle:@"退出浏览" forState:UIControlStateNormal];
    _exitBtn.layer.cornerRadius = 5;
    _exitBtn.layer.borderWidth = 1;
    [_exitBtn setTintColor:tarbarrossred];
    _exitBtn.layer.borderColor = tarbarrossred.CGColor;
    [_exitBtn addTarget:self action:@selector(exitClick) forControlEvents:UIControlEventTouchUpInside];
    hide!=YES?[_RemindBackView addSubview:_exitBtn]:nil;
    
    //分享的平台
    [self setShareView];
    
    _RemindBackView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    _RemindBackView.alpha = 0.5;
    
    _RemindPopview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [UIView animateWithDuration:0.5 animations:^{
        
        _RemindPopview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        
        _RemindBackView.transform = CGAffineTransformMakeScale(1, 1);
        _RemindBackView.alpha = 1;
        
    } completion:^(BOOL finish) {
        
    }];
    
}

- (void)setShareView
{
    self.shareview = [[SharePlatformView alloc]initWithFrame:CGRectMake(CGRectGetWidth(_RemindBackView.frame)-ZOOM6(470), CGRectGetHeight(_RemindBackView.frame)-ZOOM6(150), ZOOM6(470), ZOOM6(100))];
    ESWeakSelf;
    self.shareview.shareFinishBlock = ^{//分享结束
        [__weakSelf exitClick];
    };
    [_RemindBackView addSubview:self.shareview];
}
- (UIScrollView*)creatPhotoScrollview
{
    _photoScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _shareImageView.frame.size.width, _shareImageView.frame.size.height)];
    _photoScrollView.showsHorizontalScrollIndicator=NO;
    _photoScrollView.userInteractionEnabled = YES;
    [_shareImageView addSubview:_photoScrollView];

    self.addImage = [[UIButton alloc]init];
    self.addImage.frame=CGRectMake(0,ZOOM6(10), ZOOM6(130), ZOOM6(130));
    [self.addImage setImage:[UIImage imageNamed:@"recommend_zijixuan"] forState:UIControlStateNormal];
    self.addImage.clipsToBounds = YES;
    self.addImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.addImage addTarget:self action:@selector(addimage:) forControlEvents:UIControlEventTouchUpInside];
    [_photoScrollView addSubview:self.addImage];
    
    return _photoScrollView;
}

#pragma mark 发布分享
- (void)submitClick
{
    if(self.selectPhotos.count == 1)
    {
        [MBProgressHUD show:@"你还没有选择美衣图片哦~" icon:nil view:self];
        return;
    }
    
    //地区
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *arrea=[user objectForKey:USER_ARRER];
    
    //图片
    [self.selectPhotos removeObjectAtIndex:0];
    NSString *pics = [self.selectPhotos componentsJoinedByString:@","];
    //商品编号
    NSString *shopcodes = [self.selectShopcodes componentsJoinedByString:@","];
    [SubmitLikeModel SubmitShopLikeTitle:@"" Content:_ContentTextView.text Pics:nil Tags:@"" Location:arrea Theme_type:1 Shopcodes:shopcodes Success:^(id data) {
        SubmitLikeModel *model = data;
        if(model.status == 1)//发布成功
        {
            self.themeid = model.theme_id;
        
            [DataManager sharedManager].isSubmitSuccess = YES;
            [[UIApplication sharedApplication] setStatusBarHidden:FALSE];
            Mtarbar.selectedIndex = 2;
            [NavgationbarView showMessageAndHide:@"发布成功"];
            
            if(self.shareview.weixinBtn.selected || self.shareview.weiboBtn.selected || self.shareview.QQbtn.selected)
            {
                [NSObject delay:1.5 completion:^{
                    [self gotoShare:nil];
                }];
            }else{
                [self exitClick];
            }
        
        }else{
            [MBProgressHUD show:@"发布失败" icon:nil view:self];
        }
    }];
}
#pragma mark 退出浏览
- (void)exitClick
{
    [self remindViewHiden];
    if(self.exitBlock)
    {
        self.exitBlock();
    }
}

#pragma mark 发布成功后同步到第三平台
- (void)gotoShare:(NSString*)shopLink
{
    NSString *realm = [[NSUserDefaults standardUserDefaults]objectForKey:USER_ID];
    self.shareview.shareImage = self.selectPhotos[0];
    
    NSString *new_url  = [NSString stringWithFormat:@"%@/views/topic/detail.html?theme_id=%@&realm=%@",[NSObject baseH5ShareURLStr],self.themeid,realm];
    new_url=[new_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    self.shareview.shareLink = new_url;
    self.shareview.shareTitle = self.ContentTextView.text;
    self.shareview.theme_id = self.themeid;
    //同步分享
    [self.shareview goshare:YES];
}
#pragma mark 添加图片
- (void)addimage:(UIButton*)sender
{
    if(self.addImageBlock)
    {
        self.addImageBlock(self.selectPhotos);
    }
}
#pragma mark 关闭弹框
- (void)cancleClick
{
    if(self.cancleBlock)
    {
        self.cancleBlock();
    }
    [self remindViewHiden];
}

#pragma mark 弹框消失
- (void)remindViewHiden
{
    [UIView animateWithDuration:0.5 animations:^{
        
        _RemindPopview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
        _RemindBackView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        _RemindBackView.alpha = 0;
        
    } completion:^(BOOL finish) {
        
        [self removeFromSuperview];
    }];
    
    [TFStatisticsClickVM StatisticshandleDataWithClickType:@"跳出左划右划发密友圈弹窗页" success:nil failure:nil];
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
        
        [self endEditing:YES];
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.textColor = RGBCOLOR_I(62, 62, 62);
    if([textView.text isEqualToString:_oldcontent])
    {
        textView.text = @"";
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([MyMD5 asciiLengthOfString:textView.text]>800){
    
        [MBProgressHUD show:@"最多只能写八百字哦~" icon:nil view:self];
    }
    
    if(textView.text.length==0)
    {
        textView.textColor = RGBCOLOR_I(197, 197, 197);
        textView.text = _oldcontent;
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

- (NSMutableArray*)selectImages
{
    if(_selectImages == nil)
    {
        _selectImages = [NSMutableArray array];
    }
    return _selectImages;
}
- (NSMutableArray*)selectPhotos
{
    if(_selectPhotos == nil)
    {
        _selectPhotos = [NSMutableArray array];
    }
    return _selectPhotos;
}
- (NSMutableArray*)selectShopcodes
{
    if(_selectShopcodes == nil)
    {
        _selectShopcodes = [NSMutableArray array];
    }
    return _selectShopcodes;
}
- (NSMutableDictionary*)shopDictionary
{
    if(_shopDictionary == nil)
    {
        _shopDictionary = [NSMutableDictionary dictionary];
    }
    return _shopDictionary;
}
@end
