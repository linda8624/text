//
//  YSAddressView.m
//  zhuaWaWa
//
//  Created by linda on 2017/8/1.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "YSAddressView.h"

@implementation YSAddressView

-(id)init
{
    if(self == [super init]){
        self= [[[NSBundle mainBundle]loadNibNamed:@"YSAddressView" owner:nil options:nil] firstObject];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
@end
