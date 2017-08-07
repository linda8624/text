//
//  DemoVC10.m
//  BABaseProject
//
//  Created by 博爱 on 16/5/27.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "DemoVC10.h"
#import "DemoVC10_CollectionView.h"
#import "DemoVC10Cell.h"

@interface DemoVC10 ()

@property (nonatomic, strong) DemoVC10_CollectionView *collectionView;

@end

@implementation DemoVC10

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*! 在需要设置国际化文字的地方这样写： */
    /*!  
     NSLocalizedString（参数1，参数2） ：参数1是你在前面定义的名称，我定义的title，这里就是title，参数2可以不写，直接为nil就行！ 
     */
    self.title = NSLocalizedString(@"DemoVC10Title", nil);
   
    
    self.

    self.collectionView.hidden = NO;

}
#pragma mark - ***** setter / getter
- (DemoVC10_CollectionView *)collectionView
{
    BA_WEAKSELF;
    if (!_collectionView)
    {
        _collectionView = [[DemoVC10_CollectionView alloc] initWithFrame:CGRectZero withblock:^(UICollectionView *collection, NSIndexPath *indexPath, YSWaWaModel *dataArray) {
        }];
        
        [self.view addSubview:_collectionView];
        
        _collectionView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));

    }
    return _collectionView;
}
@end
