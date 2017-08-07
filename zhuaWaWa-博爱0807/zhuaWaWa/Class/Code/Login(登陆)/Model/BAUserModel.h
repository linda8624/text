//
//  BAUserModel.h
//  test
//
//  Created by 博爱 on 2016/11/25.
//  Copyright © 2016年 博爱. All rights reserved.
//

@interface BAUserModel : NSObject

/*！auid */
@property (nonatomic, copy  ) NSString  *auid;//201706070000000010000000003

@property (nonatomic, copy) NSString *server;//http://api1.wawazhua.com/jvvserver/
/*！电话号码 */
@property (nonatomic, copy  ) NSString  *phone;

/*！昵称 */
@property (nonatomic, copy  ) NSString  *nickName;

/*！昵称 */
@property (nonatomic, copy  ) NSString  *face;

/*！昵称 */
@property (nonatomic, copy  ) NSString  *sex;

@property (nonatomic, copy) NSString *grade;
@property (nonatomic, copy) NSString *gradeDesc;
@property (nonatomic, copy) NSString *userRemainGold;

@property (nonatomic, copy) NSString *boxRemainTime;


/*！密码 */
@property (nonatomic, copy  ) NSString  *pwd;

/*！用户识别码：唯一【登录后才有】 */
@property (nonatomic, copy  ) NSString  *userCode;

@property (nonatomic, assign) BOOL       isLogin;


@end
