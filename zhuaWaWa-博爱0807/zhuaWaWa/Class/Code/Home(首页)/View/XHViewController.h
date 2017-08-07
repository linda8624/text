//
//  XHViewController.h
//  Sparklottery
//
//  Created by linda on 16/3/16.
//  Copyright © 2016年 jkh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XHViewController,XHQuquanView;
@protocol XHViewControllerDelegate <NSObject>
- (void)startGameBtnClick:(UIButton *)startBtn;
@end
@interface XHViewController : UIView
@property (nonatomic, assign)  id<XHViewControllerDelegate> delegate;
- (void)hiddenView;

@property (weak, nonatomic) IBOutlet UIImageView *GoGameImage;

@property (weak, nonatomic) IBOutlet UIButton *GoGameBtn;

@property (weak, nonatomic) IBOutlet UIButton *startBtn;

// 没有金币界面
@property (weak, nonatomic) IBOutlet UIView *noGoldView;

@property (nonatomic, strong) NSString *stayCount;
@end
