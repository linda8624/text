//
//  YSPostSuccessView.h
//  zhuaWaWa
//
//  Created by linda on 2017/7/31.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSPostSuccessView;
@protocol YSPostSuccessViewDelegate <NSObject>
- (void)goGuanzhuBtnClick:(YSPostSuccessView *)postS;
@end
@interface YSPostSuccessView : UIView
@property (nonatomic, assign) id<YSPostSuccessViewDelegate> delegate;
@end
