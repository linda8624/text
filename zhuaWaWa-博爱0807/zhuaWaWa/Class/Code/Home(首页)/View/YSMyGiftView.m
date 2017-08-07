//
//  YSMyGiftView.m
//  zhuaWaWa
//
//  Created by linda on 2017/8/2.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "YSMyGiftView.h"
#import "DemoVC10Cell.h"
@interface YSMyGiftView()
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@end
@implementation YSMyGiftView
-(id)init
{
    if(self == [super init]){
        self= [[[NSBundle mainBundle]loadNibNamed:@"YSMyGiftView" owner:nil options:nil] firstObject];
        self.backgroundColor = [UIColor clearColor];
    
        UINib *cellNib=[UINib nibWithNibName:@"DemoVC10Cell" bundle:nil];
        [self.giftView registerNib:cellNib forCellWithReuseIdentifier:@"DemoVC10Cell"];
    }
    return self;
}
- (void)setGiftModelArray:(NSMutableArray *)giftModelArray{
    _giftModelArray = giftModelArray;
    [self.giftView reloadData];
}
- (IBAction)closeButton:(UIButton *)sender {
    self.hidden = YES;
}

#pragma mark - ***** UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.giftModelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DemoVC10Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DemoVC10Cell" forIndexPath:indexPath];
    
    cell.model = self.giftModelArray[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    YSWaWaModel *model = self.dataArray[indexPath.row];
//    self.indexBlock(self.collectionView, indexPath, model);
}

#pragma mark - ***** UICollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
@end
