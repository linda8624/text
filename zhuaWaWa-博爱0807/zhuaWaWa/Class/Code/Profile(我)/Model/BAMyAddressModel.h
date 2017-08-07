/*"addressId":10001, [1] 地址ID
 "contact":"王珊", [1] 联系人名称
 "phone":"18911037845", [1] 联系电话
 "address":"北京朝阳区36号606", [1] 联系人的地址
 "isDefault":1 [1]是否为默认地址 1 默认地址 0 不是默认地址*/


#import <Foundation/Foundation.h>

@interface BAMyAddressModel : NSObject

@property (nonatomic, copy) NSString *addressId;
@property (nonatomic, copy) NSString *contact;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *isDefault;

// 地址是否被选中
@property(nonatomic)BOOL isSelected;
@end
