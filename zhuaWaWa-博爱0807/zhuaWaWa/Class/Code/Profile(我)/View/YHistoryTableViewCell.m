//
//  YHistoryTableViewCell.m
//  zhuaWaWa
//
//  Created by linda on 2017/8/3.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "YHistoryTableViewCell.h"

@implementation YHistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setGiftModel:(YSMyGiftModel *)giftModel{
    _giftModel = giftModel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
