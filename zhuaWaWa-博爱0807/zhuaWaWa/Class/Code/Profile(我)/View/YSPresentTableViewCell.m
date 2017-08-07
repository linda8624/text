//
//  YSPresentTableViewCell.m
//  BABaseProject
//
//  Created by linda on 2017/7/23.
//  Copyright © 2017年 博爱之家. All rights reserved.
//

#import "YSPresentTableViewCell.h"
@interface YSPresentTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UILabel *giteType;

@end
@implementation YSPresentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setGiftModel:(YSMyGiftModel *)giftModel
{
    _giftModel = giftModel;
    
    if (giftModel.pic.length <= 0){
        _myImageView.image = [UIImage imageNamed:@"placeholderImage.png"];
    }else
        [_myImageView sd_setImageWithURL:[NSURL URLWithString:giftModel.pic] placeholderImage:[UIImage imageNamed:@"1"] options:0];
    _title.text = giftModel.cType;
    _giteType.text = giftModel.title;
}

- (IBAction)shareButtonClick:(id)sender{
    if ([self.delegate respondsToSelector:@selector(shareButtonClick:)]) {
        [self.delegate shareBtnClick:self.giftModel];
    }
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
