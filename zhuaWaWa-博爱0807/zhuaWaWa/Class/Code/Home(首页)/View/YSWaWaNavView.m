//
//  YSWaWaNavView.m
//  BABaseProject
//
//  Created by linda on 2017/7/26.
//  Copyright © 2017年 博爱之家. All rights reserved.
//

#import "YSWaWaNavView.h"

@implementation YSWaWaNavView

-(id)init
{
    self= [[[NSBundle mainBundle]loadNibNamed:@"YSWaWaNavView" owner:nil options:nil] firstObject];
    self.backgroundColor = [UIColor yellowColor];
    
    return self;
}

@end
