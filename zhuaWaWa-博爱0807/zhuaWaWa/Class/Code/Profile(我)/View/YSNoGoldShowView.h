//
//  YSNoGoldShowView.h
//  zhuaWaWa
//
//  Created by linda on 2017/7/31.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSNoGoldShowView;
@protocol YSNoGoldShowViewDelegate <NSObject>
- (void)goBoxBtnClick:(YSNoGoldShowView *)showView;
@end
@interface YSNoGoldShowView : UIView
@property (nonatomic, assign) id<YSNoGoldShowViewDelegate> delegate;
@end
