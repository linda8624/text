//
//  YSNoGoldShowView.m
//  zhuaWaWa
//
//  Created by linda on 2017/7/31.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "YSNoGoldShowView.h"

@implementation YSNoGoldShowView
- (IBAction)goMyBoxClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(goBoxBtnClick:)]) {
        [self.delegate goBoxBtnClick:self];
    }
}

@end
