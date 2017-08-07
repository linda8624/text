//
//  YSPostAddressView.h
//  zhuaWaWa
//
//  Created by linda on 2017/7/31.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAMyAddressModel.h"
@class YSPostAddressView;
@protocol YSPostAddressViewDelegate <NSObject>
- (void)postBtnClick:(YSPostAddressView *)postView withAddressModel:(BAMyAddressModel *)addressModel;
@end
@interface YSPostAddressView : UIView
@property (nonatomic, assign) id<YSPostAddressViewDelegate> delegate;
@property (nonatomic, strong) BAMyAddressModel *addressModel;
@end
