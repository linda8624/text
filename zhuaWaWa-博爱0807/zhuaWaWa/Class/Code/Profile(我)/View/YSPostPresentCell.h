//
//  YSPostPresentCell.h
//  BABaseProject
//
//  Created by linda on 2017/7/23.
//  Copyright © 2017年 博爱之家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAMyAddressModel.h"
@class YSPostAddressView,YSPostPresentCell;
@protocol YSPostPresentCellDelegate <NSObject>
- (void)editButtonClick:(YSPostPresentCell *)posetCell withModel:(BAMyAddressModel *)model;

- (void)deleteButtonClick:(YSPostPresentCell *)posetCell withModel:(BAMyAddressModel *)model;
@end
@interface YSPostPresentCell : UITableViewCell
@property (nonatomic, strong) BAMyAddressModel *model;
@property (nonatomic, assign) id<YSPostPresentCellDelegate> delegate;
@end
