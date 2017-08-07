//
//  YSMyGiftView.h
//  zhuaWaWa
//
//  Created by linda on 2017/8/2.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSMyGiftView : UIView
@property (weak, nonatomic) IBOutlet UICollectionView *giftView;

@property (nonatomic, strong) NSMutableArray *giftModelArray;
@end
