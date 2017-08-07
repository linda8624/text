//
//  ZDAccountTool.m
//  06视图抽屉框架
//
//  Created by Dong on 14-7-24.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "YSAccountTool.h"
#import "BAUserModel.h"
#define kIsLoginKey @"isLogin"
#define kIsLoseIndex @"PhoneNum"
#define kTPWD @"UserPwd"

#define USERID @"UserId"
#define USERName @"UserName"
#define USERAUID @"UserAuid"


@implementation YSAccountTool

/**
 *  存储一个数据
 *
 *  @param account 需要存储的对象
 *
 *  @return 是否存储成功
 */
+ (BOOL)saveAccount:(BAUserModel *)account
{
    // 获取Doc目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 拼接完整路径 将数据保存到指定文件中
    NSString *dataPath = [docPath stringByAppendingPathComponent:@"pand.date"];
    // 存储指定account到指定路径中dataPath 
    return [NSKeyedArchiver archiveRootObject:account toFile:dataPath];
}

/**
 *  从Doc路径中取出指定保存用户信息的文件
 *
 *  @return 返回一个从Doc中取出的文件
 */
+ (BAUserModel *)account
{
    // 获取Doc目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 拼接完整路径 将从此文件中取数据
    NSString *dataPath = [docPath stringByAppendingPathComponent:@"pand.date"];
    // 读取指定路径的文件
    BAUserModel *account = [NSKeyedUnarchiver unarchiveObjectWithFile:dataPath];
    // 判断当前时间和获取的用户信息中的过期时间比较是否过期
    return account;
}

+ (BOOL)removeAccount
{
    // 获取Doc目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 拼接完整路径 将从此文件中取数据
    NSString *dataPath = [docPath stringByAppendingPathComponent:@"pand.date"];
    // 读取指定路径的文件
    NSFileManager *manager =  [NSFileManager defaultManager];
    BOOL success = [manager removeItemAtPath:dataPath error:nil];
    if (success) {
        BALog(@"注销成功");
    }else
    {
        BALog(@"注销失败");
    }
    return success;
}


+(void)savePhoneName:(NSString *)setPhoneNum
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:setPhoneNum forKey:kIsLoseIndex];
    [defaults synchronize];
}

+(void)savePwdNum:(NSString *)pwd
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:pwd forKey:kTPWD];
    [defaults synchronize];
}

/**
 *  获取沙盒的tab背景图片
 *
 */
+(NSString *)getPhoneNum
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kIsLoseIndex];
}
+(NSString *)getPWDNum
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kTPWD];
}
+(void)saveuserId:(NSString *)setUserId
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:setUserId forKey:USERID];
    [defaults synchronize];

}
+(void)saveuserAuid:(NSString *)setUserAuid
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:setUserAuid forKey:USERAUID];
    [defaults synchronize];
    
}
+(NSString *)getUserAuid
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:USERAUID];
}
+(NSString *)getUserId
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:USERID];
}
+(void)saveuserName:(NSString *)setUserName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:setUserName forKey:USERName];
    [defaults synchronize];
    
}
+(NSString *)getUserName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:USERName];
}
@end
