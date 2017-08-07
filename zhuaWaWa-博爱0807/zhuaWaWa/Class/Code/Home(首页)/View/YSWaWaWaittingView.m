//
//  YSWaWaWaittingView.m
//  BABaseProject
//
//  Created by linda on 2017/7/27.
//  Copyright © 2017年 博爱之家. All rights reserved.
//

#import "YSWaWaWaittingView.h"

@implementation YSWaWaWaittingView
-(id)init
{
    if (self == [super init]) {
        self= [[[NSBundle mainBundle]loadNibNamed:@"YSWaWaWaittingView" owner:nil options:nil] firstObject];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
@end
