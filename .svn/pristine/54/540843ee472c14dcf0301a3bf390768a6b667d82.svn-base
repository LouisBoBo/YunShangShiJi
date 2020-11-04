//
//  CFCollectionView.h
//  codeTest
//
//  Created by yssj on 2017/2/9.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CFCollectionButtonViewDelegate<NSObject>

- (NSInteger)CFCollectionButtonView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
- (void)didSelectCFCollectionButtonView:(NSInteger )index;

@end

@interface CFCollectionButtonView : UIView

@property (copy, nonatomic)NSArray *arr;
@property (assign, nonatomic)NSInteger messageCount;
@property (strong, nonatomic)  UICollectionView   *collectionView;
@property (assign, nonatomic) id<CFCollectionButtonViewDelegate>            delegate;

@end
