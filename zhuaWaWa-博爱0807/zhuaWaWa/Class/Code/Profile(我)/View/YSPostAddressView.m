//
//  YSPostAddressView.m
//  zhuaWaWa
//
//  Created by linda on 2017/7/31.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "YSPostAddressView.h"

@interface YSPostAddressView()
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIButton *postMoeny;

@end
@implementation YSPostAddressView
-(id)init
{
    if(self == [super init]){
        self= [[[NSBundle mainBundle]loadNibNamed:@"YSPostAddressView" owner:nil options:nil] firstObject];
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}
// 确认无误按钮被点击
- (IBAction)postButtonClick:(UIButton *)sender {
    if([self.delegate respondsToSelector:@selector(postBtnClick:withAddressModel:)]){
        [self.delegate postBtnClick:self withAddressModel:self.addressModel];
    }
}
- (void)setAddressModel:(BAMyAddressModel *)addressModel
{
    _addressModel = addressModel;
    _name.text = addressModel.contact;
    _phone.text = addressModel.phone;
    _address.text = addressModel.address;
}
@end
