//
//  YSGameFaildView.m
//  BABaseProject
//
//  Created by linda on 2017/7/26.
//  Copyright © 2017年 博爱之家. All rights reserved.
//

#import "YSGameFaildView.h"
@interface YSGameFaildView()

//召唤外援界面
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

//去宝箱界面
@property (weak, nonatomic) IBOutlet UIButton *goMyBX;

// 删除按钮
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@end
@implementation YSGameFaildView

- (IBAction)closeButtonClick:(id)sender {
    [self hiddenView];
}
- (void)hiddenView
{
    self.hidden = YES;
    
}

@end
