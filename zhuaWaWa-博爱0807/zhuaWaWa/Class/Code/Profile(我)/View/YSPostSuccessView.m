//
//  YSPostSuccessView.m
//  zhuaWaWa
//
//  Created by linda on 2017/7/31.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "YSPostSuccessView.h"

@implementation YSPostSuccessView
- (IBAction)guanzhuBtnClick:(UIButton *)sender {
    
    BALog(@"点击了关注按钮");
    if ([self.delegate respondsToSelector:@selector(goGuanzhuBtnClick:)]) {
        [self.delegate goGuanzhuBtnClick:self];
    }

}

@end
