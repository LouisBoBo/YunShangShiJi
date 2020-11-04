//
//  CustomCardView.m
//  CCDraggableCard-Master
//
//  Created by jzzx on 16/7/9.
//  Copyright © 2016年 China-SQP. All rights reserved.
//

#import "CustomCardView.h"
#import "GlobalTool.h"
#import "UIImageView+WebCache.h"
#import "RecommendLikeModel.h"
#import "DefaultImgManager.h"
@interface CustomCardView ()

//@property (strong, nonatomic) UIImageView *imageView;
//@property (strong, nonatomic) UIView      *headView;
//@property (strong, nonatomic) UILabel     *titleLabel;
//@property (strong, nonatomic) UILabel     *pricelabel;
//@property (strong, nonatomic) UIImageView *markImageview;

@end

#define DefaultImg(size) [[DefaultImgManager sharedManager] defaultImgWithSize:(size)]

@implementation CustomCardView

- (instancetype)init {
    if (self = [super init]) {
        [self loadComponent];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadComponent];
    }
    return self;
}

- (void)loadComponent {
    self.headView = [[UIView alloc]init];
    self.imageView = [[UIImageView alloc] init];
    self.titleLabel = [[UILabel alloc] init];
    self.pricelabel = [[UILabel alloc]init];
    self.markImageview = [[UIImageView alloc]init];
    self.supplabel  = [[UILabel alloc]init];
    
    self.headView.backgroundColor = [UIColor whiteColor];

    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.imageView.layer setMasksToBounds:YES];
    
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.textColor = RGBCOLOR_I(62, 62, 62);
    self.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(32)];
    
    self.pricelabel.textColor = RGBCOLOR_I(248, 63, 63);
    self.pricelabel.textAlignment = NSTextAlignmentRight;
    self.pricelabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
    
    self.supplabel.clipsToBounds = YES;
    self.supplabel.layer.cornerRadius = ZOOM6(54)/2;
    self.supplabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
    self.supplabel.textColor = [UIColor whiteColor];
    self.supplabel.textAlignment = NSTextAlignmentCenter;
    self.supplabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    self.supplabel.alpha = 0.8;
    
    [self addSubview:self.headView];
    [self addSubview:self.imageView];
    [self addSubview:self.markImageview];
    [self addSubview:self.supplabel];
    [self.headView addSubview:self.titleLabel];
    [self.headView addSubview:self.pricelabel];
    
    self.backgroundColor = [UIColor colorWithRed:0.951 green:0.951 blue:0.951 alpha:1.00];
    
    self.layer.masksToBounds = NO;
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    
    self.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    
    self.layer.shadowOpacity = 0.5f;
}

- (void)cc_layoutSubviews {
    
    self.headView.frame = CGRectMake(0, 0, self.frame.size.width, ZOOM6(90));
    self.titleLabel.frame = CGRectMake(10, 0, self.frame.size.width-100, ZOOM6(90));
    self.pricelabel.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame), 0, 80, ZOOM6(90));
    self.imageView.frame   = CGRectMake(0,ZOOM6(90), self.frame.size.width, self.frame.size.height - ZOOM6(90));
    self.markImageview.frame = CGRectMake((CGRectGetWidth(self.imageView.frame)-ZOOM6(140))/2, (CGRectGetHeight(self.frame))/2, ZOOM6(140), ZOOM6(140));
    
    CGFloat with = [self getRowWidth:self.supplabel.text fontSize:ZOOM6(30)]+ZOOM6(60);
    self.supplabel.frame = CGRectMake((CGRectGetWidth(self.imageView.frame)-with)/2, CGRectGetHeight(self.frame)-ZOOM6(150), with, ZOOM6(54));
}

- (void)installData:(RecommendLikeModel*)model
{
    NSString *st;
    if (kDevice_Is_iPhone6Plus) {
        st = @"!450";
    } else {
        st = @"!382";
    }
    NSMutableString *code = [NSMutableString stringWithString:model.shop_code];
    NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
    NSString *imageurl = [NSString stringWithFormat:@"%@/%@/%@",supcode,model.shop_code,model.def_pic];

    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],imageurl,st]] placeholderImage:nil];
    
//    __block float d = 0;
//    __block BOOL isDownlaod = NO;
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],imageurl,st]] placeholderImage:DefaultImg(self.imageView.bounds.size) options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        d = (float)receivedSize/expectedSize;
//        isDownlaod = YES;
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if (image != nil && isDownlaod == YES) {
//            self.imageView.alpha = 0;
//            [UIView animateWithDuration:0.5 animations:^{
//                self.imageView.alpha = 1;
//            } completion:^(BOOL finished) {
//            }];
//        } else if (image != nil && isDownlaod == NO) {
//            self.imageView.image = image;
//        }
//    }];


    self.titleLabel.text = [NSString stringWithFormat:@"%@",model.shop_name];
    self.pricelabel.text = [NSString stringWithFormat:@"￥%.1f",[model.shop_se_price floatValue]];
    if(model.supp_label.length>0)
    {
        self.supplabel.text  = [NSString stringWithFormat:@"%@",model.supp_label];
    }
    self.supplabel.hidden= self.supplabel.text.length>0?NO:YES;
    if([model.is_like isEqualToString:@"喜欢"])
    {
        self.markImageview.image = [UIImage imageNamed:@"liked"];
    }else if ([model.is_like isEqualToString:@"不喜欢"])
    {
        self.markImageview.image = [UIImage imageNamed:@"nope"];
    }
}

-(CGFloat)getRowWidth:(NSString *)text fontSize:(CGFloat)fontSize
{
    //文字高度
    CGFloat width;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame)-ZOOM6(100), ZOOM6(54)) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        width=rect.size.width;
        
    }
    else{
        
    }
    
    return width;
}

@end
