//
//  XHLetouHeaderView.m
//  Sparklottery
//
//  Created by linda on 16/8/22.
//  Copyright © 2016年 jkh. All rights reserved.
//

#import "XHLetouHeaderView.h"

@interface XHLetouHeaderView ()

@end
@implementation XHLetouHeaderView
-(id)init
{
    self= [[[NSBundle mainBundle]loadNibNamed:@"XHLetouHeaderView" owner:nil options:nil] firstObject];
    self.backgroundColor = [UIColor clearColor];
    return self;
}
- (IBAction)buttonClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    BALog(@"失去焦点");//关闭请求的定时器
    [self.buttonImage setImage:[UIImage imageNamed:@"direction.png"]];
    if ([self.delegate respondsToSelector:@selector(gameControlBtnTouchOut:)]) {
        [self.delegate gameControlBtnTouchOut:btn];
    }
}
- (IBAction)touchDownClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSLog(@"%ld", (long)btn.tag);
    NSInteger tag = btn.tag;
    switch (tag) {
        case 1:
            [self.buttonImage setImage:[UIImage imageNamed:@"directionUp.png"]];
            break;
        case 3:
            [self.buttonImage setImage:[UIImage imageNamed:@"directionL.png"]];
            break;
        case 4:
            [self.buttonImage setImage:[UIImage imageNamed:@"directionR.png"]];
            break;
        case 2:
            [self.buttonImage setImage:[UIImage imageNamed:@"directionD.png"]];
            break;
            
        default:
            break;
    }
    if([self.delegate respondsToSelector:@selector(gameControlBtnTouchIn:)]){
        [self.delegate gameControlBtnTouchIn:btn];
    }
}
- (IBAction)phoneImageClick:(id)sender {
        NSLog(@"摄像头被点击");
}
// 抓娃娃按钮被点击
- (IBAction)gameButtonClick:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    if([self.delegate respondsToSelector:@selector(gameControlBtnTouchIn:)]){
        [self.delegate gameControlBtnTouchIn:btn];
    }
}

@end
