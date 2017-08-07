/*"boxId":"2001", [1] 宝箱ID
"title":"倒计时宝箱", [1] 宝箱名称
"ctype":304001, [1] 宝箱类型
"pic":"../show1.png", [1] 宝箱图片链接
"remainTime":"7230000000", [1] 倒计时（毫秒） -1没有倒计时
"memo":"还有2:30分可打开宝箱", [1] 备注
"aciton":"ACTION_NO" [1] 宝箱行为*/

#import <Foundation/Foundation.h>

@interface BAMyGBox : NSObject

@property (nonatomic, copy) NSString *boxId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSNumber *ctype;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *remainTime;
@property (nonatomic, copy) NSString *memo;
@property (nonatomic, copy) NSString *aciton;

@end
