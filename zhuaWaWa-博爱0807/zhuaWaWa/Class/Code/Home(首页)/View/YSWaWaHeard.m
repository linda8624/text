//
//  YSWaWaHeard.m
//  BABaseProject
//
//  Created by linda on 2017/7/23.
//  Copyright © 2017年 博爱之家. All rights reserved.
//

#import "YSWaWaHeard.h"

@implementation YSWaWaHeard

-(id)init
{
    self= [[[NSBundle mainBundle]loadNibNamed:@"YSWaWaHeard" owner:nil options:nil] firstObject];
    self.backgroundColor = [UIColor yellowColor];
    
    return self;
}
@end
