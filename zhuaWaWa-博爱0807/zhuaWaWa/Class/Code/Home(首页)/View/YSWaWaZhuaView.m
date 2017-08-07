//
//  YSWaWaZhuaView.m
//  BABaseProject
//
//  Created by linda on 2017/7/23.
//  Copyright © 2017年 博爱之家. All rights reserved.
//

#import "YSWaWaZhuaView.h"
@interface YSWaWaZhuaView ()
@end
@implementation YSWaWaZhuaView
-(id)init
{
    if(self == [super init]){
        self= [[[NSBundle mainBundle]loadNibNamed:@"YSWaWaZhuaView" owner:nil options:nil] firstObject];
        self.backgroundColor = [UIColor clearColor];
    }

    return self;
}
- (IBAction)joinGame:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if ([self.delegate respondsToSelector:@selector(joinButtonClick:)]) {
        [self.delegate joinButtonClick:btn];
    }
}

@end
