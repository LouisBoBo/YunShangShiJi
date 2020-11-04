//
//  TopfooterView.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/16.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TopfooterView.h"
#import "MBProgressHUD+NJ.h"
#import "GlobalTool.h"
#import "TopicTagsModel.h"
#import "TShoplistModel.h"
#import "DefaultImgManager.h"
#import "HXTagsView.h"
#define DefaultImg(size) [[DefaultImgManager sharedManager] defaultImgWithSize:(size)]
@implementation TopfooterView

- (instancetype)initWithFrame:(CGRect)frame Data:(TdetailsModel *)model;
{
    if(self = [super initWithFrame:frame])
    {
        self.DataModel = model;
        [self creatMainView];
        [self freshUI];
    }
    return self;
}

- (void)creatMainView
{
    self.footerBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.footerBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.footerBackView];
    
    [self creatContentView];
   
    [self creatTagView];
    
    if(self.DataModel.shop_list.count && self.DataModel.theme_type !=1)
    {
        [self creatShopView];
    }
    [self creadShareView];
}
//描述内容
- (void)creatContentView
{
    NSString *title =@"";
    if(self.DataModel.title.length>0)
    {
        title = [NSString stringWithFormat:@"#%@# %@",self.DataModel.title,self.DataModel.content];
    }else{
        title = [NSString stringWithFormat:@"%@",self.DataModel.content];
    }
    
    while ([title rangeOfString:@"\n\n"].length>0) {
        title = [title stringByReplacingOccurrencesOfString:@"\n\n" withString:@"\n"];
    }
    
    CGFloat labheigh =title.length>0?[self getRowHeight:title fontSize:ZOOM6(30)]:0;
    CGFloat laby = title.length>0?ZOOM6(20):0;
    self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), laby, kScreenWidth-2*ZOOM6(20), labheigh)];
    self.contentLabel.textColor = RGBCOLOR_I(62, 62, 62);
    self.contentLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
    self.contentLabel.text = title;
    self.contentLabel.numberOfLines = 0;
    [self.footerBackView addSubview:self.contentLabel];
    
    NSMutableAttributedString *mutab = [[NSMutableAttributedString alloc]initWithString:self.contentLabel.text];
    if(self.DataModel.title.length>0)
    {
        [mutab addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(0, self.DataModel.title.length+2)];
    }
    [self.contentLabel setAttributedText:mutab];

}
//标签视图
- (void)creatTagView
{
    CGFloat tagviewH = self.DataModel.tagsArray.count>0?ZOOM6(60):0;
    CGFloat tagviewY = self.DataModel.tagsArray.count>0?ZOOM6(20):0;
    
    HXTagsView *hxtagview = [[HXTagsView alloc] initWithFrame:CGRectMake(ZOOM6(20), CGRectGetMaxY(self.contentLabel.frame)+tagviewY, kScreenWidth-2*ZOOM6(20), tagviewH)];
    hxtagview.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    hxtagview.completion = ^(NSArray *selectTags,NSInteger currentIndex) {
        NSLog(@"selectTags:%@ currentIndex:%ld",selectTags, (long)currentIndex);
        TopicTagsModel *model = self.DataModel.tagsArray[currentIndex];
        if(model.supperLaber_type ==2)
        {
            if(self.customTagBlock)
            {
                self.customTagBlock(model.only_id,model.title,model.isrepeat);
            }
        }else{
            if(self.tagsBlock)
            {
                self.tagsBlock (currentIndex,self.hxtagsView.tags[currentIndex]);
            }
        }
       
    };
    [self.footerBackView addSubview:self.hxtagsView = hxtagview];
}

- (void)freshUI
{
    self.hxtagsView.tags = [self gettitleArray:self.DataModel.tagsArray];
    if(self.hxtagsView.tags.count)
    {
        self.hxtagsView.height = [HXTagsView getHeightWithTags:self.hxtagsView.tags layout:self.hxtagsView.layout tagAttribute:self.hxtagsView.tagAttribute width:kScreenWidth];
        [self.hxtagsView reloadData];
    }
}
- (NSArray *)gettitleArray:(NSArray*)tagsArray
{
    NSMutableArray *tagstitleArray = [NSMutableArray array];
    
    for(int i =0 ;i<tagsArray.count;i++)
    {
        TopicTagsModel *model = tagsArray[i];
        [tagstitleArray addObject:model.title];
    }
    
    return tagstitleArray;
}

//商品视图
- (void)creatShopView
{
//    CGFloat shopviewH = ZOOM6(210);
    CGFloat shopviewH = ZOOM6(200)*1.5+ZOOM6(70);
    CGFloat shopviewW = ZOOM6(20);
    
    self.shopview = [[UIScrollView alloc]initWithFrame:CGRectMake(ZOOM6(20),CGRectGetHeight(self.frame)- (shopviewH+ZOOM6(230))+shopviewW, kScreenWidth-2*ZOOM6(20), shopviewH)];
    self.shopview.userInteractionEnabled = YES;
    self.shopview.showsVerticalScrollIndicator = FALSE;
    self.shopview.showsHorizontalScrollIndicator = FALSE;
    [self.footerBackView addSubview:self.shopview];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(self.shopview.frame) - shopviewW, kScreenWidth, 0.5)];
    line.backgroundColor = RGBCOLOR_I(229, 229, 229);
    [self.footerBackView addSubview:line];
    
//    CGFloat imagewith = shopviewH - ZOOM6(60);
    CGFloat imagewith = ZOOM6(200);
    CGFloat imagehigh = ZOOM6(200)*1.5;
    int count = self.DataModel.shop_list.count>=20?21:(int)self.DataModel.shop_list.count;
    
    for(int i = 0; i<count;i++)
    {
        UIImageView *shopimage = [[UIImageView alloc]initWithFrame:CGRectMake((imagewith+ZOOM6(20))*i, 0, imagewith, imagehigh)];
        shopimage.clipsToBounds = YES;
        shopimage.contentMode = UIViewContentModeScaleAspectFill;
        shopimage.tag = 80000+i;
        
        if(i >= 20)
        {
            shopimage.image = [UIImage imageNamed:@"icon_morecommend"];
        }else{
            TShoplistModel *model = self.DataModel.shop_list[i];
            NSURL *imageurl = [self getShopImage:model];
            
            __block float d = 0;
            __block BOOL isDownlaod = NO;
            [shopimage sd_setImageWithURL:imageurl placeholderImage:DefaultImg(shopimage.bounds.size) options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                d = (float)receivedSize/expectedSize;
                isDownlaod = YES;
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image != nil && isDownlaod == YES) {
                    shopimage.alpha = 0;
                    [UIView animateWithDuration:0.5 animations:^{
                        shopimage.alpha = 1;
                    } completion:^(BOOL finished) {
                    }];
                } else if (image != nil && isDownlaod == NO) {
                    shopimage.image = image;
                }
            }];
            
            UIImageView *mengceng = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(shopimage.frame)-ZOOM6(60), imagewith, ZOOM6(60))];
            mengceng.image = [UIImage imageNamed:@"miyou_mengceng"];
            [shopimage addSubview:mengceng];
            
            UILabel *namelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(shopimage.frame)-ZOOM6(40), imagewith, ZOOM6(40))];
            namelabel.font = [UIFont systemFontOfSize:ZOOM6(22)];
            namelabel.textColor = [UIColor whiteColor];
            namelabel.textAlignment = NSTextAlignmentCenter;
            if(model.supp_label.length >0)
            {
                 namelabel.text = [NSString stringWithFormat:@"%@",model.supp_label];
            }
            [shopimage addSubview:namelabel];
            
            UILabel *pricelabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(shopimage.frame), CGRectGetMaxY(shopimage.frame)+ZOOM6(15), imagewith, ZOOM6(40))];
            pricelabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
            pricelabel.textColor = RGBCOLOR_I(125, 125, 125);
            pricelabel.textAlignment = NSTextAlignmentCenter;

            [self.shopview addSubview:pricelabel];
            
            if(![DataManager sharedManager].is_OneYuan)
            {
                pricelabel.text = [NSString stringWithFormat:@"￥%.1f",[model.shop_se_price floatValue]];
            }else{
                UILabel* fengqiangLabel = [[UILabel alloc]initWithFrame:CGRectMake((CGRectGetWidth(pricelabel.frame)-ZOOM6(140))/2, 0, ZOOM6(90), CGRectGetHeight(pricelabel.frame))];
                fengqiangLabel.backgroundColor = [UIColor whiteColor];
                fengqiangLabel.font = [UIFont systemFontOfSize:kZoom6pt(12)];
                fengqiangLabel.textAlignment = NSTextAlignmentCenter;
                fengqiangLabel.layer.borderColor = [UIColor redColor].CGColor;
                fengqiangLabel.layer.borderWidth = 1;
                fengqiangLabel.clipsToBounds = YES;
                fengqiangLabel.layer.cornerRadius = 5;
                fengqiangLabel.text = @"疯抢价";
                fengqiangLabel.textColor = [UIColor redColor];
                [pricelabel addSubview:fengqiangLabel];
                
                UILabel* oneyuanLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(fengqiangLabel.frame), 0, ZOOM6(50), CGRectGetHeight(fengqiangLabel.frame))];
                oneyuanLabel.backgroundColor = kWiteColor;
                oneyuanLabel.font = [UIFont systemFontOfSize:kZoom6pt(12)];
                oneyuanLabel.textAlignment = NSTextAlignmentRight;
                oneyuanLabel.text = @"1元";
                oneyuanLabel.textColor = [UIColor redColor];
                [pricelabel addSubview:oneyuanLabel];
            }
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageclick:)];
        shopimage.userInteractionEnabled = YES;
        [shopimage addGestureRecognizer:tap];
        [self.shopview addSubview:shopimage];
    }
    
    self.shopview.contentSize = CGSizeMake(imagewith*count+ZOOM6(20)*(count-1), 0);
}
//分享视图
- (void)creadShareView
{
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-ZOOM6(210), kScreenWidth, ZOOM6(20))];
    line1.backgroundColor = RGBCOLOR_I(240, 240, 240);
    [self.footerBackView addSubview:line1];
    
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20),CGRectGetMaxY(line1.frame)+ZOOM6(50), ZOOM6(140), ZOOM6(40))];
    titlelabel.text = @"分享话题";
    titlelabel.textColor = RGBCOLOR_I(62, 62, 62);
    titlelabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
    [self.footerBackView addSubview:titlelabel];
    
    //分享的平台
    NSArray *shareArray = @[@"微信群",@"QQ空间",@"微博",@"更多"];
    CGFloat buttonwith = ZOOM6(100);
    CGFloat spacewith = (CGRectGetWidth(self.frame)-2*ZOOM6(20)-CGRectGetWidth(titlelabel.frame)-ZOOM6(20)-4*buttonwith)/3;
    for(int i =0; i<shareArray.count; i++)
    {
        UIButton *shareButton = [[UIButton alloc]init];
        shareButton.frame = CGRectMake(CGRectGetMaxX(titlelabel.frame)+ZOOM6(20)+(buttonwith+spacewith)*i, CGRectGetMaxY(line1.frame)+ZOOM6(15), buttonwith, buttonwith);
        shareButton.tag = 10000+i;
        [self.footerBackView addSubview:shareButton];
        if(i == 0)
        {
            [shareButton setImage:[UIImage imageNamed:@"icon_weinxinqun"] forState:UIControlStateNormal];
        }else if (i == 1)
        {
            [shareButton setImage:[UIImage imageNamed:@"qq空间-1"] forState:UIControlStateNormal];
        }else if (i == 2)
        {
            [shareButton setImage:[UIImage imageNamed:@"微博"] forState:UIControlStateNormal];
        }else if (i == 3)
        {
            [shareButton setImage:[UIImage imageNamed:@"topic_icon_more"] forState:UIControlStateNormal];
        }
        [shareButton addTarget:self action:@selector(shareclick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *sharelab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(shareButton.frame), CGRectGetMaxY(shareButton.frame)+ZOOM6(10),CGRectGetWidth(shareButton.frame), ZOOM6(30))];
        sharelab.text = shareArray[i];
        sharelab.textAlignment = NSTextAlignmentCenter;
        sharelab.textColor = RGBCOLOR_I(168, 168, 168);
        sharelab.font = [UIFont systemFontOfSize:ZOOM6(24)];
        [self.footerBackView addSubview:sharelab];
    }
    
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.footerBackView.frame)-ZOOM6(20), kScreenWidth, ZOOM6(20))];
    line2.backgroundColor = RGBCOLOR_I(240, 240, 240);
    [self.footerBackView addSubview:line2];

}

- (void)imageclick:(UITapGestureRecognizer*)tap
{
    int tag = tap.view.tag%80000;
    
    if(self.shopBlock)
    {
        if(tag >= 20)
        {
            self.shopBlock(tap.view.tag ,@"更多");
        }else{
            TShoplistModel *model = self.DataModel.shop_list[tag];
            self.shopBlock(tap.view.tag ,model.shop_code);
        }
    }
}
- (void)shareclick:(UIButton*)sender
{
    NSInteger tag = sender.tag-10000;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if(tag == 0 )
    {
        //判断设备是否安装微信
        if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
            [MBProgressHUD show:@"还未安装微信哦~" icon:nil view:window];
            return;
        }
    }else if (tag == 1)
    {
        //判断设备是否安装QQ
        if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]])
        {
            [MBProgressHUD show:@"还未安装QQ哦~" icon:nil view:window];
            return;
        }
    }

    if(self.shareBlock)
    {
        self.shareBlock(sender.tag-10000);
    }
}

- (void)tagClick:(UIButton*)sender
{
    NSInteger tag = sender.tag - 90000;
    if(self.tagsBlock)
    {
        self.tagsBlock (tag,sender.titleLabel.text);
    }
}

#pragma mark 获取图片
- (NSURL*)getShopImage:(TShoplistModel*)shopmodel
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

#pragma mark 获取文本高度
-(CGFloat)getRowHeight:(NSString *)text fontSize:(CGFloat)fontSize
{
    //文字高度
    CGFloat height = 0;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(kScreenWidth-2*ZOOM6(20), 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
        
    }
    
    if(height < ZOOM6(50))
    {
        return  ZOOM6(50);
    }else{
        return height;
    }
    return 0;
    
}
- (NSMutableArray*)tagsArray
{
    if(_tagsArray == nil)
    {
        _tagsArray = [NSMutableArray array];
    }
    return _tagsArray;
}
@end
