//
//  YSBoxTableViewCell.m
//  BABaseProject
//
//  Created by linda on 2017/7/27.
//  Copyright © 2017年 博爱之家. All rights reserved.
//

#import "YSBoxTableViewCell.h"
@interface YSBoxTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *boxImage;

//
@property (weak, nonatomic) IBOutlet UIView *labelView;

// 宝箱的title
@property (weak, nonatomic) IBOutlet UILabel *boxTitle;

// 宝箱的描述文字
@property (weak, nonatomic) IBOutlet UILabel *boxLable;

// 宝箱备注
@property (weak, nonatomic) IBOutlet UILabel *subTitle;

@end
@implementation YSBoxTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setMyGBox:(BAMyGBox *)myGBox{
    _myGBox = myGBox;
    [_boxImage sd_setImageWithURL:[NSURL URLWithString:myGBox.pic] placeholderImage:[UIImage imageNamed:@"1"] options:0];
    _boxTitle.text = myGBox.title;
    
}
- (void)setFrame:(CGRect)frame
{
    //修改cell的左右边距为10;
    //修改cell的Y值下移10;
    //修改cell的高度减少10;
    
    static CGFloat margin = 10;
    frame.origin.x = margin;
    frame.size.width -= 2 * frame.origin.x;
    frame.origin.y += margin;
    frame.size.height -= margin;
    
    [super setFrame:frame];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
