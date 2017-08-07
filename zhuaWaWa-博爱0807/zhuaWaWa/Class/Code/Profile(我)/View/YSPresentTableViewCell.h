//
//  YSPresentTableViewCell.h
//  BABaseProject
//
//  Created by linda on 2017/7/23.
//  Copyright © 2017年 博爱之家. All rights reserved.
//
#import "YSMyGiftModel.h"
#import <UIKit/UIKit.h>
@class YSPresentTableViewCell;
@protocol YSPresentTableViewCellDelegate <NSObject>
- (void)shareBtnClick:(YSMyGiftModel *)giftModel;
@end
@interface YSPresentTableViewCell : UITableViewCell
@property (nonatomic, strong) YSMyGiftModel *giftModel;
@property (nonatomic, assign) id<YSPresentTableViewCellDelegate> delegate;
@end
