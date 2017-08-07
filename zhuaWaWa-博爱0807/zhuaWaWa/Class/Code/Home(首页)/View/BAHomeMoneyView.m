//
//  BAHomeMoneyView.m
//  zhuaWaWa
//
//  Created by linda on 2017/7/29.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAHomeMoneyView.h"
#import "BAHomeCollectionView.h"
@interface BAHomeMoneyView()
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (nonatomic, strong) BAHomeCollectionView *collectionView;
@end

@implementation BAHomeMoneyView

- (id)init
{
    if (self == [super init])
    {
        self = [[[NSBundle mainBundle]loadNibNamed:@"BAHomeMoneyView" owner:nil options:nil] firstObject];
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI
{
    self.backgroundColor = BAKit_Color_Translucent;
    
    [self addTopControllSubview];
}

- (void)addTopControllSubview{
 
    [self collectionView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    UIView *view = [touch view];

    if ([view isKindOfClass:[self class]])
    {
        [self removeFromSuperview];
    }
}

- (BAHomeCollectionView *)collectionView
{
    BAKit_WeakSelf
    if (!_collectionView)
    {
        _collectionView = [[BAHomeCollectionView alloc] initWithFrame:CGRectZero withblock:^(UICollectionView *collection, NSIndexPath *indexPath, id model) {
            BAKit_StrongSelf
            // 判断是否可以进入房间. model.roomId
        }];
        [self.topView addSubview:self.collectionView];

        
        _collectionView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }
    return _collectionView;
}
@end
