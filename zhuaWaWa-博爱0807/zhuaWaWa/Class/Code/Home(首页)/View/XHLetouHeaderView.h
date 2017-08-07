//
//  XHLetouHeaderView.h
//  Sparklottery
//
//  Created by linda on 16/8/22.
//  Copyright © 2016年 jkh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XHLetouHeaderView;
@protocol XHLetouHeaderViewDelegate <NSObject>
- (void)gameControlBtnTouchIn:(UIButton *)controlBtn;
- (void)gameControlBtnTouchOut:(UIButton *)controlBtn;

@end
@interface XHLetouHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIButton *gameImage;//抓按钮
@property (weak, nonatomic) IBOutlet UIButton *phoneImage;//切换摄像头按钮
@property (weak, nonatomic) IBOutlet UIImageView *buttonImage;

@property (weak, nonatomic) IBOutlet UIImageView *unEnableButton;

@property (nonatomic, weak) id<XHLetouHeaderViewDelegate> delegate;
@end
