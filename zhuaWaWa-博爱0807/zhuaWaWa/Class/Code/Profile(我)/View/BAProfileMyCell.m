//
//  BAProfileMyCell.m
//  BABaseProject
//
//  Created by linda on 2017/7/23.
//  Copyright © 2017年 博爱之家. All rights reserved.
//

#import "BAProfileMyCell.h"
@interface BAProfileMyCell()

@property (weak, nonatomic) IBOutlet UIImageView *myImage;

@property (weak, nonatomic) IBOutlet UIButton *detailBtn;

@property (weak, nonatomic) IBOutlet UILabel *myTitle;

@property (weak, nonatomic) IBOutlet UIView *detailView;

@end
@implementation BAProfileMyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    
    self.myTitle.text = dict[@"title"];
    _myImage.image = [UIImage imageNamed:dict[@"image"]];
    [self.detailBtn setImage:[UIImage imageNamed:dict[@"detail"]] forState:UIControlStateNormal];
    self.detailView.hidden = YES;
        
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
