//
//  TFCommentModel.m
//  YunShangShiJi
//
//  Created by 云商 on 15/8/11.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFCommentModel.h"

@implementation TFCommentModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (TFAddCommentModel *)commentModel
{
    if (_commentModel == nil) {
        _commentModel = [[TFAddCommentModel alloc] init];
        if (self.comment.count) {
            NSDictionary *dic = [self.comment objectAtIndex:0];
            [_commentModel setValuesForKeysWithDictionary:dic];
            _commentModel.isComment = YES; 
        } else {
            _commentModel.isComment = NO;
        }
    }
    return _commentModel;
}

- (TFSuppCommentModel *)suppCommentModel
{
    if (_suppCommentModel == nil) {
        _suppCommentModel = [[TFSuppCommentModel alloc] init];
        if (self.suppComment.count) {
            NSDictionary *dic = [self.suppComment objectAtIndex:0];
            [_suppCommentModel setValuesForKeysWithDictionary:dic];
            _suppCommentModel.isComment = YES;
        } else {
            _suppCommentModel.isComment = NO;
        }
    }
    return _suppCommentModel;
}

- (TFSuppCommentModel *)suppEndCommentModel
{
    if (_suppEndCommentModel == nil) {
        _suppEndCommentModel = [[TFSuppCommentModel alloc] init];
        if (self.suppEndComment.count) {
            NSDictionary *dic = [self.suppEndComment objectAtIndex:0];
            [_suppEndCommentModel setValuesForKeysWithDictionary:dic];
            _suppEndCommentModel.isComment = YES;
        } else {
            _suppEndCommentModel.isComment = NO;
        }
    }
    return _suppEndCommentModel;
}

- (NSMutableArray *)picArr
{
    if (_picArr == nil) {
        _picArr = [[NSMutableArray alloc] init];
        
        if (self.pic.length!=0) {
            NSArray *picArray = [self.pic componentsSeparatedByString:@","];
            
            //picArray = %@", picArray);
            
            for (NSString *picUrl in picArray) {
                if (picUrl.length!=0) {
                    [_picArr addObject:picUrl];
                }
            }
            
            //_picArr = %@", _picArr);
        
        }
    }
    
    return _picArr;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"cellType = %d\n comment = %@\n suppComment = %@\n suppEndComment = %@\n",self.cellType ,self.comment,self.suppComment,self.suppEndComment];
}

@end
