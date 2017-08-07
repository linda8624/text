//
//  BAProfileHeadCell.m
//  博爱微信
//
//  Created by 博爱 on 2016/10/24.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "BAProfileHeadCell.h"
#import "BAUserModel.h"

@interface BAProfileHeadCell ()

@property (weak, nonatomic) IBOutlet UIImageView  *userImgView;
@property (weak, nonatomic) IBOutlet UIButton      *userName;
@property (weak, nonatomic) IBOutlet UIButton      *accountLabel;
@property (weak, nonatomic) IBOutlet UIImageView  *QRCodeImgView;

@end

@implementation BAProfileHeadCell

- (void)setModel:(BAUserModel *)model
{
    _model = model;

    _userImgView.image = [UIImage imageNamed:model.face];
    
    [_userName setTitle:model.nickName forState:UIControlStateNormal];
    
    [_accountLabel setTitle:model.gradeDesc forState:UIControlStateNormal];
}

- (void)awakeFromNib
{

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
