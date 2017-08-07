/*"chargeId":"112", [1] 充值游戏币ID
"title":"300000", [1] 游戏币
"price0":"8.00", [1] 原价
"price":"5.00", [1] 优惠价
"pic":"../pic.png" [0-1] 图标,默认从本地加载*/

#import <Foundation/Foundation.h>

@interface YSGoldModel : NSObject
@property (nonatomic, copy) NSString *chargeId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *price0;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *pic;
@end
