//
//  XHViewController.m
//  Sparklottery
//
//  Created by linda on 16/3/16.
//  Copyright © 2016年 jkh. All rights reserved.
//

#import "XHViewController.h"
@interface XHViewController ()

@end

@implementation XHViewController
- (IBAction)closeButtonClick:(id)sender {
    [self hiddenView];
}
- (IBAction)startButtonClick:(id)sender {
    UIButton *btn = sender;
    if ([self.delegate respondsToSelector:@selector(startGameBtnClick:)]) {
        [self.delegate startGameBtnClick:btn];
    }
}
// 去充值界面
- (IBAction)goChongzhiButton:(id)sender {
}
- (void)hiddenView
{
    self.hidden = YES;

}

@end
