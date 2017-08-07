/**{
 "giftId":"1001", [1] 奖品ID
 "cType":"奖品2", [1] 奖品分类
 "title":"可爱的粉色兔子", [1] 奖品名称
 "pic":"../show1.png", [1] 奖品图片链接
 "giftStatus":"302001", [1] 奖品状态
 "shareFlag":"1", [1] 奖品分享标识 1 可分享 0 不可分享
 "memo":"2017年6月18日14时24分" [0-1] 奖品获取时间
 },
 */

#import <Foundation/Foundation.h>

@interface YSMyGiftModel : NSObject
@property (nonatomic, copy) NSString *giftId;
@property (nonatomic, copy) NSString *cType;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *giftStatus;
@property (nonatomic, copy) NSString *shareFlag;
@property (nonatomic, copy) NSString *memo;
@end
