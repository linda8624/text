//
//  YSGameSucceedView.h
//  BABaseProject
//
//  Created by linda on 2017/7/26.
//  Copyright © 2017年 博爱之家. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSGameSucceedView : UIView

// 删除按钮
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

// 倒计时
@property (weak, nonatomic) IBOutlet UIButton *timeButton;

// 点击了分享到微信按钮
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

// 点击了关注公众号
@property (weak, nonatomic) IBOutlet UIButton *guanzhuButton;

// 赢得的礼物
@property (weak, nonatomic) IBOutlet UIImageView *giftImage;

- (void)hiddenView;

@end
