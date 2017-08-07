//
//  BAMoenyCell.m
//  zhuaWaWa
//
//  Created by linda on 2017/7/29.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAMoenyCell.h"
@interface BAMoenyCell()

@property (weak, nonatomic) IBOutlet UILabel *goldText;

@property (weak, nonatomic) IBOutlet UILabel *bMoney;

@property (weak, nonatomic) IBOutlet UILabel *cMoeny;

@end
@implementation BAMoenyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(YSGoldModel *)model{
    _model = model;
    self.goldText.text = model.title;
    self.bMoney.text = [NSString stringWithFormat:@"原价 :¥%@",model.price0];
    self.cMoeny.text = [NSString stringWithFormat:@"现价 :¥%@",model.price];
}

@end
