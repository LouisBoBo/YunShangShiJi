//
//  ViewController.h
//  searchView
//
//  Created by yssj on 2016/12/27.
//  Copyright © 2016年 CooFree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"

typedef NS_ENUM(NSUInteger, SearchType) {
    SearchTypeNormal = 100,
    SearchTypeScreen ,
};

@interface SearchTypeViewController : UIViewController

+ (SearchTypeViewController *)allocWithSearchType:(SearchType)searchType;
@property (nonatomic , assign) BOOL is_pushCome;
@end

@interface HotModel : BaseModel
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSString *tag_id;
@end


@interface SearchTypeModel : BaseModel
@property (nonatomic, strong) NSArray *hotTagList;
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSString *tag_id;

+ (void)httpGetSearchTypeModelSuccess:(void(^)(id data))success;
@end
