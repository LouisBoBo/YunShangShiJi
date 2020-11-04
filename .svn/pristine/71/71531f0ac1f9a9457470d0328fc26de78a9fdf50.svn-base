//
//  ProduceImage.m
//  TFTestDemo
//
//  Created by 云商 on 15/8/29.
//  Copyright (c) 2015年 云商. All rights reserved.
//

#import "ProduceImage.h"
#import "GlobalTool.h"
#import "ShareShopModel.h"
@implementation ProduceImage


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
    }
    return self;
}

- (UIImage *)getH5Image:(UIImage *)image withQRCodeImage:(UIImage *)QRImage withText:(NSString *)text
{
    CGSize size = image.size;
    CGFloat height = size.height;
    CGRect frame = CGRectMake(0, 0, size.width, height);
    
    UIView *bgView = [[UIView alloc] initWithFrame:frame];
    bgView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:bgView];
    
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    iv.image = image;
    [bgView addSubview:iv];
    
    
    CGFloat X = 0;
    CGFloat W = 0;
    
    if (text.length == 4) {
        X = 450;
        W = 180;
    } else if (text.length == 5) {
        X = 410;
        W = 200;
    }
    
    UILabel *codeview = [[UILabel alloc]initWithFrame:CGRectMake(X, size.height/2-50, W, 80)];
    codeview.backgroundColor = [UIColor clearColor];
    [bgView addSubview:codeview];
    
    
    //邀请码
    NSMutableArray *codeArray= [NSMutableArray array];
    for(int i =0; i<text.length;i++)
    {
        NSString *firststr = [text substringFromIndex:i];
        NSString *secondstr =[firststr substringToIndex:1];

        [codeArray addObject:secondstr];
    }
    
    CGFloat lablewidh = (codeview.frame.size.width-10*(text.length-1))/text.length;
    for(int i=0;i<text.length;i++)
    {
        UILabel *codelable =[[UILabel alloc]initWithFrame:CGRectMake((lablewidh+10)*i, (CGRectGetHeight(codeview.frame)-lablewidh)/2.0, lablewidh, lablewidh)];
        codelable.backgroundColor = [UIColor blackColor];
        codelable.text = codeArray[i];
        codelable.textAlignment = NSTextAlignmentCenter;
        codelable.textColor = [UIColor whiteColor];
//        codelable.font = [UIFont systemFontOfSize:lablewidh-30];
        codelable.font = [UIFont systemFontOfSize:30];
        
        codelable.layer.masksToBounds = YES;
        codelable.layer.cornerRadius = lablewidh/4.0;
        
        [codeview addSubview:codelable];
    }
    
    
    UIGraphicsBeginImageContext(CGSizeMake(size.width, height));
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    NSData *data = UIImagePNGRepresentation(newImage);
    UIImage *myImg = [UIImage imageWithData:data];
    
    return myImg;

}
- (UIImage *)getShareImage:(UIImage *)image WithBaseImg:(UIImage*)baseImg WithPrice:(NSString*)price;
{
    CGSize basesize = baseImg.size;
    CGSize qrsize = CGSizeMake(140, 110);
    
    CGFloat height = basesize.height;
    CGFloat width  = basesize.width;
    CGRect frame = CGRectMake(0, 0, width, height);
    
    UIView *bgView = [[UIView alloc] initWithFrame:frame];
    bgView.backgroundColor = [UIColor clearColor];
    [self addSubview:bgView];
    
    UIImageView *baseview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, basesize.width, basesize.height)];
    baseview.image = baseImg;
    [bgView addSubview:baseview];
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, basesize.height-qrsize.height-90, qrsize.width, qrsize.height)];
    iv.image = image;
    [baseview addSubview:iv];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(3, 25, qrsize.width-20, 30)];
    titleLab.text =@"今日特价";
    titleLab.textColor = [UIColor whiteColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(45)];
    [iv addSubview:titleLab];
    
    UILabel *priceLab = [[UILabel alloc]initWithFrame:CGRectMake(3, CGRectGetMaxY(titleLab.frame)+10, qrsize.width-20, 30)];
    priceLab.text =[NSString stringWithFormat:@"￥%@",price];
    priceLab.textColor = [UIColor whiteColor];
    priceLab.textAlignment = NSTextAlignmentCenter;
    priceLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(45)];
    [iv addSubview:priceLab];
    
    [self getBalancemutable:priceLab Text:[NSString stringWithFormat:@"%@",price] FromIndex:1];
    
    UIGraphicsBeginImageContext(CGSizeMake(basesize.width, basesize.height));
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    NSData *data = UIImagePNGRepresentation(newImage);
    UIImage *myImg = [UIImage imageWithData:data];
    
    return myImg;
    
}
- (UIImage *)getQRImage:(UIImage *)image withQRCodeImage:(UIImage *)QRImage WithzhezhaoImg:(UIImage*)zhezhaoimg WithBaseImg:(UIImage*)baseImg;
{
    CGSize basesize = baseImg.size;
    CGSize qrsize = CGSizeMake(200, 220);
    CGSize logosize = CGSizeMake(50, 50);
    
    CGFloat height = basesize.height;
    CGFloat width  = basesize.width;
    CGRect frame = CGRectMake(0, 0, width, height);
    
    UIView *bgView = [[UIView alloc] initWithFrame:frame];
    bgView.backgroundColor = [UIColor clearColor];
    [self addSubview:bgView];
    
    UIImageView *baseview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, basesize.width, basesize.height)];
    baseview.image = baseImg;
    [bgView addSubview:baseview];
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake((basesize.width-qrsize.width)/2, basesize.height-270, qrsize.width, qrsize.height)];
    iv.image = image;
    [bgView addSubview:iv];
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake((qrsize.width-logosize.width)/2, (qrsize.height-logosize.height)/2-10, logosize.width, logosize.height)];
    logo.image = QRImage;
    [iv addSubview:logo];
    
    UIImageView *zhezhao = [[UIImageView alloc] initWithFrame:CGRectMake(0, qrsize.height-28, qrsize.width, 28)];
    zhezhao.image = zhezhaoimg;
    [iv addSubview:zhezhao];
    
    UIGraphicsBeginImageContext(CGSizeMake(basesize.width, basesize.height));
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    NSData *data = UIImagePNGRepresentation(newImage);
    UIImage *myImg = [UIImage imageWithData:data];
    
    return myImg;
    
}
- (UIImage *)getImage:(UIImage *)image withQRCodeImage:(UIImage *)QRImage withText:(NSString *)text withPrice:(NSString *)price WithTitle:(NSString*)sharetitle
{
    
    CGSize size = image.size;
    CGSize QRsize = QRImage.size;
    
    CGFloat qrheigh=QRsize.height*1;
    CGFloat qrwidh=QRsize.width*1;
    
    QRsize.height=qrheigh;
    QRsize.width=qrwidh;
    

    
    CGFloat height = size.height;
    
    //后面加的
    size.width = height;
    
    CGRect frame = CGRectMake(0, 0, size.width, height);
    UIView *bgView = [[UIView alloc] initWithFrame:frame];
    bgView.backgroundColor = [UIColor clearColor];

    [self addSubview:bgView];

    NSData *imgData = UIImagePNGRepresentation(image);
    
    NSString *aPath=[NSString stringWithFormat:@"%@/Documents/shareImgae.jpg",NSHomeDirectory()];
    
    [imgData writeToFile:aPath atomically:YES];
    
    //大图
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    iv.contentMode = UIViewContentModeScaleAspectFill;
    iv.image = image;
    [bgView addSubview:iv];
    
    //制造商
    NSString *brandStr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:SHOP_BRAND]];
    CGFloat brandwith = [self getRowWidth:brandStr fontSize:50]+100;
    UILabel *brandlab = [[UILabel alloc]initWithFrame:CGRectMake((size.width - brandwith)/2, height-QRsize.height-140, brandwith, 80)];
    brandlab.clipsToBounds = YES;
    brandlab.layer.cornerRadius = CGRectGetHeight(brandlab.frame)/2;
    brandlab.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    brandlab.textAlignment = NSTextAlignmentCenter;
    brandlab.font = [UIFont systemFontOfSize:45];
    brandlab.textColor = [UIColor whiteColor];
    brandlab.hidden = (brandStr == nil || [brandStr isEqualToString:@"(null)"])?YES:NO;
    brandlab.text = brandStr;
    
    //大图下面的
    UIImageView *backview=[[UIImageView alloc]initWithFrame:CGRectMake(0, height-QRsize.height-40, size.width, QRsize.height+40)];
    backview.backgroundColor=[UIColor whiteColor];
    backview.alpha = 0.8;//0.6
    [bgView addSubview:backview];
    
    //二维码
    UIImageView *QRiv = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, QRsize.width, QRsize.height)];
    QRiv.image = QRImage;
    UIView *qrview =[[UIView alloc]initWithFrame:CGRectMake(23, 23, QRsize.width-6, QRsize.height-6)];
    qrview.backgroundColor = [UIColor whiteColor];
    [backview addSubview:qrview];
    [backview addSubview:QRiv];
    
    //第一行文字
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(QRsize.width+23,20, size.width-QRsize.width-20, QRsize.height-80)];
    label.text = text;
    label.textColor = [UIColor blackColor];
    label.numberOfLines=0;
    label.font = [UIFont systemFontOfSize:55];
    label.textAlignment = NSTextAlignmentLeft;
    [backview addSubview:label];
    
    //第二行文字
    UILabel *subheadlabel = [[UILabel alloc] initWithFrame:CGRectMake(QRsize.width+26, CGRectGetMaxY(label.frame), size.width-QRsize.width, CGRectGetHeight(label.frame))];
    subheadlabel.textColor=RGBCOLOR_I(125, 125, 125);
    subheadlabel.backgroundColor=[UIColor clearColor];
    subheadlabel.numberOfLines=1;
    subheadlabel.font = [UIFont systemFontOfSize:40];
    subheadlabel.textAlignment = NSTextAlignmentLeft;
    [backview addSubview:subheadlabel];

    //价格
    UIImageView *priceimage=[[UIImageView alloc]initWithFrame:CGRectMake(size.width-250, 0, 250, CGRectGetHeight(backview.frame))];
    priceimage.backgroundColor = tarbarrossred;
    
    UILabel *pricelable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, priceimage.frame.size.width, priceimage.frame.size.height)];
    pricelable.text=[NSString stringWithFormat:@"拼团仅售\n￥%.1f",[price floatValue]];
    pricelable.font=[UIFont systemFontOfSize:60];
    pricelable.textAlignment=NSTextAlignmentCenter;
    pricelable.textColor=[UIColor whiteColor];
    pricelable.numberOfLines = 0;
    [priceimage addSubview:pricelable];

    //如果是搭配购 没有价格 没有制造商
    if(![text isEqualToString:@"Collocationdetail"])
    {
        [backview addSubview:priceimage];
        [bgView addSubview:brandlab];
    }
    
    
    if([text isEqualToString:@"zeroindex"] || [text isEqualToString:@"comdetail"])
    {
        label.text = @"买了肯定不后悔";
        subheadlabel.text = @"长按图片识别二维码购买";
        
        NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
        NSString *sharetype = [userdefaul objectForKey:IS_SHARE_TYPE];
        NSString *p_type = [userdefaul objectForKey:P_TYPE];
        
        switch (p_type.intValue) {
                
            case 1:
                
                price = @"0";
                break;
            case 2:
                price = @"9";
                break;
            case 3:
                
                price = @"19";
                break;
            case 4:
                
                price = @"29";
                break;
            case 5:
                
                if([sharetype isEqualToString:@"baoyou"])
                {
                    label.text = @"包邮专享更划算";
                    subheadlabel.text = @"长按图片识别二维码购买";
                }else if ([sharetype isEqualToString:@"duobao"])
                {
                    label.text = @"不中奖就退款！！";
                    subheadlabel.text = @"长按图片识别二维码了解";
                }

                break;
    
            default:
                break;
        }
    }
    else if ([text isEqualToString:@"Indiandetail"])
    {
        label.text = @"不中奖就退款！！";
        subheadlabel.text = @"长按图片识别二维码了解";
    }
    else if ([text isEqualToString:@"qianDaocomdetail"])
    {
        label.text = @"包邮专享更划算";
        subheadlabel.text = @"长按图片识别二维码购买";
    }else if ([text isEqualToString:@"Collocationdetail"])
    {
        label.text = sharetitle;
        subheadlabel.text = [NSString stringWithFormat:@"%@",@"长按图片识别二维码购买"];
    }
    else{
        
        NSArray *titleArr = @[@"穿上它和我一样美",@"你穿肯定很好看"];
        int i = arc4random()%titleArr.count;
        
        if(i==0)
        {
            label.text = @"穿上它和我一样美";
            subheadlabel.text = @"长按图片识别二维码购买";
        }else if (i==1)
        {
            label.text = @"你穿肯定很好看";
            subheadlabel.text = @"长按图片识别二维码购买";
        }
    }
    
    pricelable.text=[NSString stringWithFormat:@"拼团仅售\n￥%.1f",[price floatValue]];
    
    
    
//    NSArray *labs = [subheadlabel.text componentsSeparatedByString:@"\n"];
//    NSString *titlestr1 ;
//    NSString *titlestr2 ;
//    UIFont *titlefont = [UIFont systemFontOfSize:40];
//    if(labs.count == 2)
//    {
//        titlestr1 = labs[0];
//        titlestr2 = labs[1];
//    }
    
//    //lable的行间距
//    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:subheadlabel.text];
//    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle1 setLineSpacing:15];
//    
//    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [subheadlabel.text length])];
//    [attributedString1 addAttribute:NSForegroundColorAttributeName value: RGBCOLOR_I(125, 125, 125) range:NSMakeRange(titlestr1.length+1, titlestr2.length)];
//    
//    [attributedString1 addAttribute:NSFontAttributeName value:titlefont range:NSMakeRange(titlestr1.length+1, titlestr2.length)];
//    
//    [subheadlabel setAttributedText:attributedString1];
//    [subheadlabel sizeToFit];
//
//    subheadlabel.frame = CGRectMake(subheadlabel.frame.origin.x, subheadlabel.frame.origin.y, size.width-QRsize.width-40, subheadlabel.frame.size.height);
    
    

    UIGraphicsBeginImageContext(CGSizeMake(size.width, height));
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    NSData *data = UIImagePNGRepresentation(newImage);
    UIImage *myImg = [UIImage imageWithData:data];
    
    return myImg;
}

- (UIImage *)getImage:(UIImage *)image withQRCodeImage:(UIImage *)QRImage {
    
    CGSize size = image.size;
    CGSize QRsize = QRImage.size;
    
    CGFloat qrheigh=QRsize.height*1;
    CGFloat qrwidh=QRsize.width*1;
    
    QRsize.height=qrheigh;
    QRsize.width=qrwidh;
    
    CGFloat height = size.height;
    
    UIGraphicsBeginImageContext(CGSizeMake(size.width, height));
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    NSData *data = UIImagePNGRepresentation(newImage);
    UIImage *myImg = [UIImage imageWithData:data];
    
    return myImg;
}


- (UIImage *)QRImageWithBgImg:(UIImage *)bgImg withQRCodeImage:(UIImage *)QRCodeImage withTitle:(NSString *)title WithSubTitle:(NSString*)subTitle
{
    CGSize size = bgImg.size;
    CGSize QRsize = QRCodeImage.size;
    
    CGFloat qrheigh=QRsize.height*1;
    CGFloat qrwidh=QRsize.width*1;
    
    QRsize.height=qrheigh;
    QRsize.width=qrwidh;
    
    CGFloat height = size.height;
    
    //后面加的
    size.width = height;
    
    CGRect frame = CGRectMake(0, 0, size.width, height);
    UIView *bgView = [[UIView alloc] initWithFrame:frame];
    bgView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:bgView];
    
//    NSData *imgData = UIImagePNGRepresentation(bgImg);
//    
//    NSString *aPath=[NSString stringWithFormat:@"%@/Documents/shareImgae.jpg",NSHomeDirectory()];
//    
//    [imgData writeToFile:aPath atomically:YES];
    
    //大图
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    iv.contentMode = UIViewContentModeScaleAspectFill;
    iv.image = bgImg;
    [bgView addSubview:iv];
    
    //大图下面的
    UIImageView *backview=[[UIImageView alloc]initWithFrame:CGRectMake(0, height-QRsize.height-40, size.width, QRsize.height+40)];
    backview.backgroundColor=[UIColor whiteColor];
    backview.alpha = 0.8;//0.6
    [bgView addSubview:backview];
    
    //二维码
    UIImageView *QRiv = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, QRsize.width, QRsize.height)];
    QRiv.image = QRCodeImage;
    
    
    UIView *qrview =[[UIView alloc]initWithFrame:CGRectMake(23, 23, QRsize.width-6, QRsize.height-6)];
    qrview.backgroundColor = [UIColor whiteColor];
    [backview addSubview:qrview];
    [backview addSubview:QRiv];
    
    //第一行文字
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(QRsize.width+23,20, size.width-QRsize.width-20, QRsize.height/2)];
    label.textColor = [UIColor blackColor];
    label.numberOfLines=0;
    label.font = [UIFont systemFontOfSize:55];
    label.textAlignment = NSTextAlignmentLeft;
    [backview addSubview:label];
    
    //第二行文字
    UILabel *subheadlabel = [[UILabel alloc] initWithFrame:CGRectMake(QRsize.width+26, 20+QRsize.height/2, size.width-QRsize.width, CGRectGetHeight(label.frame))];
    subheadlabel.textColor=RGBCOLOR_I(125, 125, 125);
    subheadlabel.backgroundColor=[UIColor clearColor];
    subheadlabel.numberOfLines=1;
    subheadlabel.font = [UIFont systemFontOfSize:40];
    subheadlabel.textAlignment = NSTextAlignmentLeft;
    [backview addSubview:subheadlabel];

    label.text = title;
    subheadlabel.text=subTitle;
    
    
    UIGraphicsBeginImageContext(CGSizeMake(size.width, height));
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    NSData *data = UIImagePNGRepresentation(newImage);
    UIImage *myImg = [UIImage imageWithData:data];
    
    return myImg;
}

-(CGFloat)getRowWidth:(NSString *)text fontSize:(CGFloat)fontSize
{
    //文字高度
    CGFloat width;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(900, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        width=rect.size.width;
        
    }
    else{
        
    }
    
    return width;
}

- (void)getBalancemutable:(UILabel*)lab Text:(NSString*)text FromIndex:(int)index
{
    NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:lab.text];
    [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(80)] range:NSMakeRange(index, text.length)];
    [lab setAttributedText:mutable];
}
@end
