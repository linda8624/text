//
//  YSWaWaZhuaView.h
//  BABaseProject
//
//  Created by linda on 2017/7/23.
//  Copyright © 2017年 博爱之家. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSWaWaZhuaView;
@protocol YSWaWaZhuaViewDelegate <NSObject>
- (void)joinButtonClick:(UIButton *)btn;
@end

@interface YSWaWaZhuaView : UIView
@property (nonatomic, weak)IBOutlet UIButton *btnWaitingStatus;//显示队列状态
@property (weak, nonatomic) IBOutlet UIButton *giftButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *loveButton;
@property (nonatomic, weak) id<YSWaWaZhuaViewDelegate> delegate;
@end
