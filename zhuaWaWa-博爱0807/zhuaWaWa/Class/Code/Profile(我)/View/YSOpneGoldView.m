//
//  YSOpneGoldView.m
//  zhuaWaWa
//
//  Created by linda on 2017/8/3.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "YSOpneGoldView.h"

@implementation YSOpneGoldView

-(id)init
{
    if (self==[super init]) {
        self= [[[NSBundle mainBundle]loadNibNamed:@"YSOpneGoldView" owner:nil options:nil] firstObject];
        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}
@end
