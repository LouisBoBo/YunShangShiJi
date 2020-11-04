//
//  UpdatePhotosToYpy.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/14.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "UpdatePhotosToYpy.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "UpYun.h"
@implementation UpdatePhotosToYpy

-(void)creatUPY:(NSArray*)imageArray
{
    MyLog(@"我可以");
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [self.images setString:@""];
    
    __block int count= (int)imageArray.count;
    
    UpYun *uy = [[UpYun alloc] init];
    [MBProgressHUD showMessage:@"正在玩命发帖" afterDeleay:0 WithView:window];
    
    uy.successBlocker = ^(id data)
    {
        NSString *imgurl=[NSString stringWithFormat:@"%@",data[@"url"]];

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
                
                [self.images appendString:imgurl];
                [self.images appendString:@":"];
                [self.images appendString:[NSString stringWithFormat:@"%.2f",scale]];
                [self.images appendString:@","];
                
                count=count-1;
                
                MyLog(@"count = %d",count);
            }
            
            
            if(count==0)
            {
                dispatch_async(dispatch_get_main_queue(), ^{ // 主线程刷新UI
                    
                    [MBProgressHUD hideHUDForView:window];
                    [self submitHttp];
                });
                
            }
            
            
        });
        
    };
    
    uy.failBlocker = ^(NSError * error)
    {
        [MBProgressHUD show:@"发送失败，稍后重试!" icon:nil view:window];
        count=count-1;
    };
    
    for(int i=0;i<imageArray.count;i++)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIImage * image1 =[self compressionImage:imageArray[i]];
            
            [uy uploadFile:image1 saveKey:[self getSaveKey]];
            
        });
        
    }
}

- (void)submitHttp
{
    if(self.updateSuccess)
    {
        self.updateSuccess(self.images);
    }
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

- (NSMutableString*)images
{
    if(_images == nil)
    {
        _images = [NSMutableString string];
    }
    return _images;
}
@end
