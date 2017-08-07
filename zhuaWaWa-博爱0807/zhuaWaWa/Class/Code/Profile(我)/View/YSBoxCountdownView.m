//
//  YSBoxCountdownView.m
//  zhuaWaWa
//
//  Created by linda on 2017/8/3.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "YSBoxCountdownView.h"

@implementation YSBoxCountdownView

-(id)init
{
    if (self==[super init]) {
        self= [[[NSBundle mainBundle]loadNibNamed:@"YSBoxCountdownView" owner:nil options:nil] firstObject];
    }
    return self;
}
@end
