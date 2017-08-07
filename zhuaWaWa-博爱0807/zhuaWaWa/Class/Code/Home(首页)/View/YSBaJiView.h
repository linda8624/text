//
//  YSBaJiView.h
//  BABaseProject
//
//  Created by linda on 2017/7/26.
//  Copyright © 2017年 博爱之家. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSBaJiView;
@protocol YSBaJiViewDelegate <NSObject>
- (void)bajiGameBtnClick:(UIButton *)startBtn;
@end
@interface YSBaJiView : UIView
// 删除按钮
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

// 倒计时
@property (weak, nonatomic) IBOutlet UIButton *timeButton;

// 点击了baji按钮
@property (weak, nonatomic) IBOutlet UIButton *bajiButton;

// 需要消耗的金币
@property (weak, nonatomic) IBOutlet UILabel *gameMoney;

@property (nonatomic, assign)  id<YSBaJiViewDelegate> delegate;
- (void)hiddenView;
@end
