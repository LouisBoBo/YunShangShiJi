//
//  HotTopicCollectionViewCell.m
//  XRWaterfallLayoutDemo
//
//  Created by ios-1 on 2017/4/1.
//  Copyright © 2017年 XR. All rights reserved.
//

#import "HotTopicCollectionViewCell.h"
#import "DefaultImgManager.h"
#import "GlobalTool.h"
#import "TFShopModel.h"

#define DefaultImg(size) [[DefaultImgManager sharedManager] defaultImgWithSize:(size)]
@implementation HotTopicCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    UIView *topSpace=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/2, 5)];
//    topSpace.backgroundColor=[UIColor whiteColor];
//    
//    [self.contentView addSubview:topSpace];
//    [self.contentView sendSubviewToBack:topSpace];
    
    self.headimage.frame = CGRectMake(10, self.headimage.frame.origin.y, ZOOM6(60), ZOOM6(60));
    self.headimage.layer.cornerRadius = CGRectGetWidth(self.headimage.frame)/2;
    self.headimage.clipsToBounds = YES;
    self.headimage.image = [UIImage imageNamed:@"girl"];

    self.like.frame=CGRectMake(self.like.x, self.like.frame.origin.y, self.like.width, ZOOM6(40));
    self.titlelabel.textColor = RGBCOLOR_I(62, 62, 62);
    self.titlelabel.font = [UIFont systemFontOfSize:ZOOM6(24)];
    
    self.name.textColor = RGBCOLOR_I(168, 168, 168);
    self.name.font = [UIFont systemFontOfSize:ZOOM6(22)];
    
}

- (void)setImageURL:(NSURL *)imageURL {
    
    NSString * picSize = @"";
    if (kDevice_Is_iPhone6Plus) {
        picSize = @"!280";
    } else {
        picSize = @"!280";
    }
    
    _imageURL = imageURL;
    
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [self.bigImage sd_setImageWithURL:_imageURL placeholderImage:DefaultImg(self.bigImage.bounds.size) options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d = (float)receivedSize/expectedSize;
        isDownlaod = YES;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod == YES) {
            self.bigImage.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                self.bigImage.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        } else if (image != nil && isDownlaod == NO) {
            self.bigImage.image = image;
        }
    }];

}

//邀请好友
- (void)refreshShareData:(BOOL)select
{
//    [self refreshUI:nil Content:nil HeadImage:nil Name:nil LikeStatus:NO LikeNum:0];
    
    //勾选
    self.selectbtn.selected=select;
    [self.selectbtn setImage:[UIImage imageNamed:@"wodexihao_fengge_icon_weixuanzhong"] forState:UIControlStateNormal];
    [self.selectbtn setImage:[UIImage imageNamed:@"wodexihao_fengge_icon_xuanzhong"] forState:UIControlStateSelected];
//    self.selectbtn.imageView.backgroundColor = [UIColor whiteColor];
//    self.selectbtn.imageView.clipsToBounds = YES;
//    self.selectbtn.imageView.layer.cornerRadius = self.selectbtn.imageView.frame.size.height/2;
    self.selectbtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.selectbtn addTarget:self action:@selector(selectclick:) forControlEvents:UIControlEventTouchUpInside];
}

//热门穿搭
- (void)refreshCircleData:(IntimateCircleModel*)model;
{
    NSURL *imageUrl ;

    if(model.theme_type.intValue == 1)
    {
        if(model.shop_list.count)
        {
            TFShopModel *shopmodel = model.shop_list[0];
            imageUrl = [self getShopImage:shopmodel];
        }
    }else{
        imageUrl = [self getImage:model];
    }
    NSString *title =@"";
    if(model.title.length>0)
    {
        title = [NSString stringWithFormat:@"#%@# %@",model.title,model.content];
    }else{
        title = [NSString stringWithFormat:@"%@",model.content];
    }
    NSString *nickname=model.nickname;
    if (model.nickname.length>8) {
        nickname=[nickname substringToIndex:8];
    }
    [self refreshUI:imageUrl Content:title HeadImage:model.head_pic Name:nickname LikeStatus:model.applaud_status LikeNum:[model.applaud_num integerValue]];
}

- (void)refreshData:(Relatedrecommended*)model
{
    NSURL *url = nil;
    if ([model.head_pic hasPrefix:@"http"]) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.head_pic]];
    } else {
        if ([model.head_pic hasPrefix:@"/"]) {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],[model.head_pic substringFromIndex:1]]];
        } else {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.head_pic]];
        }
    }
    [self.headimage sd_setImageWithURL:url];
    
    self.titlelabel.text = [NSString stringWithFormat:@"%@",model.content];
    
    NSString *date = [MyMD5 timeWithTimeIntervalString:model.send_time];
    self.name.text = [NSString stringWithFormat:@"%@",date];
    
    [self refreshUI:nil Content:nil HeadImage:nil Name:nil LikeStatus:NO LikeNum:0];
}

- (void)refreshUI:(NSURL*)bigImage Content:(NSString*)content HeadImage:(NSString*)headimage Name:(NSString*)name LikeStatus:(BOOL)like LikeNum:(NSInteger)num
{
    self.titlelabel.frame = CGRectMake(10, CGRectGetMaxY(self.bigImage.frame), self.frame.size.width-20, 50);
    self.titlelabel.numberOfLines = 2;
    self.headimage.frame = CGRectMake(10, CGRectGetMaxY(self.titlelabel.frame), ZOOM6(60), ZOOM6(60));
    self.like.centerY=self.headimage.centerY;
    self.name.frame = CGRectMake(CGRectGetMaxX(self.headimage.frame)+5, CGRectGetMaxY(self.titlelabel.frame), self.name.frame.size.width, self.headimage.frame.size.height);

    //大图
    NSString * picSize = @"";
    if (kDevice_Is_iPhone6Plus) {
        picSize = @"!280";
    } else {
        picSize = @"!280";
    }
   
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [self.bigImage sd_setImageWithURL:bigImage placeholderImage:DefaultImg(self.bigImage.bounds.size) options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d = (float)receivedSize/expectedSize;
        isDownlaod = YES;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod == YES) {
            self.bigImage.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                self.bigImage.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        } else if (image != nil && isDownlaod == NO) {
            self.bigImage.image = image;
        }
    }];
    
    //头像
    NSURL *url = nil;
    if ([headimage hasPrefix:@"http"]) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",headimage]];
    } else {
        if ([headimage hasPrefix:@"/"]) {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],[headimage substringFromIndex:1]]];
        } else {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],headimage]];
        }
    }
    [self.headimage sd_setImageWithURL:url];
    
    
    self.titlelabel.text = [NSString stringWithFormat:@"%@",content];
    self.name.text = [NSString stringWithFormat:@"%@",name];
    
    //点赞
    self.like.imageEdgeInsets = UIEdgeInsetsMake(0,ZOOM6(10),0.0f,0);
    self.like.titleEdgeInsets = UIEdgeInsetsMake(0,ZOOM6(20),0.0f,0);
    self.like.selected=like;
    [self.like setImage:[UIImage imageNamed:@"topic_icon_xihuan"] forState:UIControlStateNormal];
    [self.like setImage:[UIImage imageNamed:@"topic_icon_xihuan_pre"] forState:UIControlStateSelected];
    [self.like setTitle:[NSString stringWithFormat:@"%d",(int)num] forState:UIControlStateNormal];
    
    self.like.selected==NO?[self.like setTitleColor:RGBCOLOR_I(168, 168, 168) forState:UIControlStateNormal]:[self.like setTitleColor:tarbarrossred forState:UIControlStateNormal];
    self.like.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.like.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(20)];
    self.like.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.like setTitleColor:RGBCOLOR_I(168, 168, 168) forState:UIControlStateNormal];
    self.like.clipsToBounds=YES;
    self.like.layer.borderColor=kbackgrayColor.CGColor;
    [self.like addTarget:self action:@selector(likeclick:) forControlEvents:UIControlEventTouchUpInside];

}
- (void)likeclick:(UIButton*)sender
{
    NSInteger num = sender.titleLabel.text.integerValue;
    if(self.likeBlock)
    {
        self.likeBlock(num);
    }
}

- (void)selectclick:(UIButton*)sender
{
//    sender.selected = !sender.selected;
    if (self.selectBlock) {
        self.selectBlock();
    }
}
+ (NSString *)circiImageStr:(IntimateCircleModel *)model{
    NSString *imageurl;

    NSString *image = @"";
    NSArray *imageArr = [model.pics componentsSeparatedByString:@","];
    NSString *imagestr = @"";
    if(imageArr.count)
    {
        imagestr = imageArr[0];
        NSArray *arr = [imagestr componentsSeparatedByString:@":"];
        if(arr.count == 2)
        {
            image = arr[0];
        }
    }
    if(image >0)
    {
//        NSString *st;
//        if (kDevice_Is_iPhone6Plus) {
//            st = @"!450";
//        } else {
//            st = @"!382";
//        }
        
        imageurl = [NSString stringWithFormat:@"/myq/theme/%@/%@",model.user_id,image];
    }
    return imageurl;
}
+ (NSString *)shopImageStr:(TFShopModel *)shopmodel {
    NSMutableString *code = [NSMutableString stringWithString:shopmodel.shop_code];
    
    NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
    MyLog(@"supcode =%@",supcode);
    
    NSString *imagestr = [NSString stringWithFormat:@"%@/%@/%@",supcode,shopmodel.shop_code,shopmodel.def_pic];
    
//    NSString *st = @"";
//    if (kDevice_Is_iPhone6Plus) {
//        st = @"!450";
//    } else {
//        st = @"!382";
//    }
    return [NSString stringWithFormat:@"%@",imagestr];
}
#pragma mark 获取图片
- (NSURL*)getShopImage:(TFShopModel*)shopmodel
{
    NSURL *imageurl;
    
    NSMutableString *code = [NSMutableString stringWithString:shopmodel.shop_code];
    
    NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
    MyLog(@"supcode =%@",supcode);
    
    NSString *imagestr = [NSString stringWithFormat:@"%@/%@/%@",supcode,shopmodel.shop_code,shopmodel.def_pic];
    
    NSString *st = @"";
    if (kDevice_Is_iPhone6Plus) {
        st = @"!450";
    } else {
        st = @"!382";
    }
    imageurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],imagestr,st]];

    return imageurl;
}
- (NSURL*)getImage:(IntimateCircleModel *)model
{
    NSURL *imageurl;
    
    NSString *image = @"";
    NSArray *imageArr = [model.pics componentsSeparatedByString:@","];
    NSString *imagestr = @"";
    if(imageArr.count)
    {
        imagestr = imageArr[0];
        NSArray *arr = [imagestr componentsSeparatedByString:@":"];
        if(arr.count == 2)
        {
            image = arr[0];
        }
    }
    if(image >0)
    {
        NSString *st;
        if (kDevice_Is_iPhone6Plus) {
            st = @"!450";
        } else {
            st = @"!382";
        }
        
        imageurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/myq/theme/%@/%@%@",[NSObject baseURLStr_Upy],model.user_id,image,st]];
    }
    return imageurl;
}

#pragma mark 获取文本高度
-(CGFloat)getRowHeight:(NSString *)text fontSize:(CGFloat)fontSize
{
    //文字高度
    CGFloat height;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(kScreenWidth-2*ZOOM6(20), 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
    }
    
    if(height < 50)
    {
        return  ZOOM6(35);
    }else{
        return  ZOOM6(80);
    }
    return 0;
}

@end
