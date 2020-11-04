//
//  IndianaModel.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/6/2.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "IndianaModel.h"
#import "GlobalTool.h"
 
#import <UIKit/UIKit.h>
#define kPaddingLeftWidth ZOOM6(30)
#define kPaddingRightWidth ZOOM6(30)

#define contentFont kFont6px(28)

CGFloat maxContentLabelHeight;

@implementation IndianaModel
{
    CGFloat _lastContentWidth;
}

@synthesize content = _content, isClick = _isClick;
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

- (NSMutableArray *)srcArray
{
    if (!_srcArray) {
        _srcArray = [NSMutableArray array];
        
        if (self.pic.length) {
            NSArray *srcArr = [self.pic componentsSeparatedByString:@","];
            
            if (srcArr.count >= 1) {
                NSMutableArray *muArray = [NSMutableArray array];
                for (NSString *st in srcArr) {
                    NSString *stTemp = [NSString stringWithFormat:@"%@shareOrder%@", [NSObject baseURLStr_Upy], st];
                    [muArray addObject:stTemp];
                }
                
                [_srcArray addObjectsFromArray:muArray];
            }
        }
    }
    
    return _srcArray;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name:%@\nmember:%@\nmsgContent:%@\nsrc:%@\nlike:%@\ncomment:%@\n", self.user_name, self.isMember,self.content,self.pic, self.click_size, self.comment_size];
}

- (void)setContent:(NSString *)content
{
    _content = content;
}

- (NSString *)content
{
    CGFloat contentW = [UIScreen mainScreen].bounds.size.width-kPaddingLeftWidth-kPaddingRightWidth;
    
//    UILabel *Lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, contentW, MAXFLOAT)];
//    Lab.font = contentFont;
//    Lab.numberOfLines = 0;
//    Lab.text = _msgContent;
//    Lab.lineBreakMode = NSLineBreakByCharWrapping;
//    CGSize sizeThatFits = [Lab sizeThatFits:CGSizeMake(Lab.frame.size.width, MAXFLOAT)];
//    [Lab sizeToFit];
//    NSNumber *count = @((sizeThatFits.height) / Lab.font.lineHeight);
//    
//    if ([count intValue]>3) {
//        _shouldShowMoreButton = YES;
//    } else {
//        _shouldShowMoreButton = NO;
//    }
    
//    MyLog(@"msgContent: %@", _msgContent);
    
    if (contentW != _lastContentWidth) {
        
        UILabel *lab = [[UILabel alloc] init];
        lab.font = contentFont;
        lab.lineBreakMode = NSLineBreakByCharWrapping;
        lab.numberOfLines = 0;
        if (maxContentLabelHeight == 0) {
            maxContentLabelHeight = lab.font.lineHeight * 3;
        }
        
        _lastContentWidth = contentW;
        CGRect textRect = [_content boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : contentFont} context:nil];
        if (textRect.size.height > maxContentLabelHeight) {
            _shouldShowMoreButton = YES;
        } else {
            _shouldShowMoreButton = NO;
        }
    }
    
    return _content;
}

- (void)setIsOpening:(BOOL)isOpening
{
    if (!_shouldShowMoreButton) {
        _isOpening = NO;
    } else {
        _isOpening = isOpening;
    }
}


- (MyID *)myID
{
    if (!_myID) {
        _myID = [[MyID alloc] init];
        if (self._id) {
            [_myID setValuesForKeysWithDictionary:self._id];
            _myID.myNew = [self._id[@"new"] boolValue];
        }
    }
    return _myID;
}

+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

@end

@implementation MyID

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

@end
