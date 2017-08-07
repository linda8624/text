//
//  shoppingDetailVC.h
//  Test_ghs
//
//  Created by readtv on 15/8/14.
//  Copyright (c) 2015年 ghs.net. All rights reserved.
//

#import "BABaseViewController.h"
#import "BAMyAddressModel.h"
@interface shoppingDetailVC : BABaseViewController
@property (nonatomic, strong) BAMyAddressModel *model;

@property (nonatomic, assign) BOOL isEdit;
@end
