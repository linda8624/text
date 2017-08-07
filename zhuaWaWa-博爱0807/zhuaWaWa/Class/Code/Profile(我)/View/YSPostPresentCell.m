//
//  YSPostPresentCell.m
//  BABaseProject
//
//  Created by linda on 2017/7/23.
//  Copyright © 2017年 博爱之家. All rights reserved.
//

#import "YSPostPresentCell.h"
@interface YSPostPresentCell()

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *phone;

@property (weak, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (weak, nonatomic) IBOutlet UIButton *editButton;

@property (weak, nonatomic) IBOutlet UIImageView *selectedImage;

@end
@implementation YSPostPresentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)editButton:(id)sender {
    
    BALog(@"修改了");
    if ([self.delegate respondsToSelector:@selector(editButtonClick:withModel:)]) {
        [self.delegate editButtonClick:self withModel:self.model];
    }
}
- (IBAction)deleteButtonClick:(id)sender {
    BALog(@"删除了");
    if ([self.delegate respondsToSelector:@selector(deleteButtonClick:withModel:)]) {
        [self.delegate deleteButtonClick:self withModel:self.model];
    }
}

- (void)setModel:(BAMyAddressModel *)model{
    _model = model;
    _name.text = model.contact;
    _phone.text = model.phone;
    _address.text = model.address;
   if (model.isSelected==YES) {
    self.selectedImage.image = [UIImage imageNamed:@"selected.png"];
    }else{
        [self.selectedImage setImage:[UIImage imageNamed:@"unSelected.png"]];
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
