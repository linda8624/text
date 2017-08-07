//
//  YSHomeNavView.m
//  zhuaWaWa
//
//  Created by linda on 2017/8/4.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "YSHomeNavView.h"

@implementation YSHomeNavView

-(id)init
{
    if (self == [super init]) {
        self= [[[NSBundle mainBundle]loadNibNamed:@"YSHomeNavView" owner:nil options:nil] firstObject];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
@end
