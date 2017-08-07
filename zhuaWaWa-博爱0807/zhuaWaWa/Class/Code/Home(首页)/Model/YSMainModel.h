//
//  YSMainModel.h
//  BABaseProject
//
//  Created by linda on 2017/7/26.
//  Copyright © 2017年 博爱之家. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAUserModel.h"
@interface YSMainModel : NSObject
@property (nonatomic, strong) NSMutableArray *adList;
@property (nonatomic, strong) NSMutableArray *roomType;
@property (nonatomic, strong) NSMutableArray *roomList;
@property (nonatomic, strong) BAUserModel *userDic;
@end
