
//
//  YSBaJiView.m
//  BABaseProject
//
//  Created by linda on 2017/7/26.
//  Copyright © 2017年 博爱之家. All rights reserved.
//

#import "YSBaJiView.h"

@implementation YSBaJiView

- (void)hiddenView
{
    self.hidden = YES;
    
}
- (IBAction)closeButtonClick:(id)sender {
    [self hiddenView];
}
- (IBAction)bajiButtonClcik:(id)sender {
    //点击了baji按钮,走我开始baji
    UIButton *btn = sender;
    if ([self.delegate respondsToSelector:@selector(bajiGameBtnClick:)]) {
        [self.delegate bajiGameBtnClick:btn];
    }
}

@end
