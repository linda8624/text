//
//  DemoVC10Cell.m
//  BABaseProject
//
//  Created by 博爱 on 16/5/30.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "DemoVC10Cell.h"
#import "YSWaWaModel.h"
@interface DemoVC10Cell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UIImageView *isNew;

@end
@implementation DemoVC10Cell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //[self setupSubViews];
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"l-square.png"]];
    }
    return self;
}

- (void)setupSubViews
{
    self.imageView.hidden = NO;
    self.descLabel.hidden = NO;
}
-(void)setModel:(YSWaWaModel *)model{
    
    _model = model;
    
    if (model.pic.length <= 0){
        _imageView.image = [UIImage imageNamed:@"placeholderImage.png"];
    }
    else
        [_imageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"1"] options:0];
    
    _descLabel.text = model.title;
    _money.text = model.singleConsumeGold;

   if([model.isNew isEqualToString:@"0"])self.isNew.hidden=YES;
   else self.isNew.hidden = NO;
}


@end
