//
//  YSShareBoxView.m
//  zhuaWaWa
//
//  Created by linda on 2017/8/5.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "YSShareBoxView.h"

@implementation YSShareBoxView

-(id)init
{
    if (self==[super init]) {
        self= [[[NSBundle mainBundle]loadNibNamed:@"YSShareBoxView" owner:nil options:nil] firstObject];
    }
    return self;
}
@end
