//
//  ZDAccountTool.h
//  06视图抽屉框架
//
//  Created by Dong on 14-7-24.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BAUserModel;
@interface YSAccountTool : NSObject
@property (nonatomic, strong) NSString *maxPicNum;
/**
 *  存储一个数据
 *
 *  @param account 需要存储的对象
 *
 *  @return 是否存储成功
 */
+ (BOOL)saveAccount:(BAUserModel *)account;

/**
 *  获取一个存储账号的对象
 */
+ (BAUserModel *)account;

/** 退出当前账号 */
+ (BOOL)removeAccount;


+(void)savePhoneName:(NSString *)setPhoneNum;
+(void)savePwdNum:(NSString *)pwd;
+ (NSString *)getPhoneNum;
+ (NSString *)getPWDNum;
+(void)saveuserId:(NSString *)setUserId;
+(NSString *)getUserId;
+(void)saveuserName:(NSString *)setUserName;
+(NSString *)getUserName;
+(void)saveuserAuid:(NSString *)setUserAuid;
+(NSString *)getUserAuid;

@end
