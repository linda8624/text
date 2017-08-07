//
//  BAUserModel.m
//  test
//
//  Created by 博爱 on 2016/11/25.
//  Copyright © 2016年 博爱. All rights reserved.
//

#import "BAUserModel.h"
@implementation BAUserModel

/**
 *  归档一个数据到文件中会调用
 *
 *  @param encoder 告诉系统如何归档
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    unsigned int count = 0;
    // 1. 获取指定类中所有的数学
    Ivar *vars = class_copyIvarList([self class], &count);
    // 2.遍历取出每一个属性
    for (int i = 0; i < count; i++) {
        Ivar var = vars[i];
        // 根据属性取出属性的名称
        const char * varName = ivar_getName(var);
        // 将属性名称转换为OC字符串
        NSString *name = [NSString stringWithUTF8String:varName];
        // 根据属性名称利用KVC取出对应的值
        id value = [self valueForKeyPath:name];
        // 归档
        [encoder encodeObject:value forKey:name];
    }
    
}

/**
 *  解档一个数据时候会调用
 *
 *  @param decoder 需要解档的数据
 *
 *  @return 返回一个解好的数据类型
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        unsigned int count = 0;
        // 1.获取指定类中所有的属性   Ivar运行时成员变量
        Ivar * vars = class_copyIvarList([self class], &count);
        // 2.遍历取出每一个属性
        for (int i = 0; i < count; i++) {
            Ivar var = vars[i];
            // 根据属性取出属性的名称
            const char * varName = ivar_getName(var);
            // 将属性名称转换为OC字符串
            NSString *name = [NSString stringWithUTF8String:varName];
            // 根据属性的值解归档对象
            id value = [decoder decodeObjectForKey:name];
            // 设置对象属性的值
            [self setValue:value forKeyPath:name];
        }
    }
    return self;
}

@end
