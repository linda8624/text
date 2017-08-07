//
//  YSRoomTypeModel.h
//  BABaseProject
//
//  Created by linda on 2017/7/26.
//  Copyright © 2017年 博爱之家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSRoomTypeModel : NSObject
/**
 *  分类头像
 */
@property (nonatomic, copy) NSString *typePic;

/**
 *  分类标题
 */
@property (nonatomic, copy) NSString *typeName;

/**
 *  分类ID
 */
@property (nonatomic, copy) NSString *typeID;
@end
