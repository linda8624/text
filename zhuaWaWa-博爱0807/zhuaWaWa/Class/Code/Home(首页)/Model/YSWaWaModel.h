/**
 {
 "jid":"1797924392000000002",机器唯一标识ID
"roomId":"1002"房间编号
"roomName":"可达鸭公仔房间2",[1]房间名称
"pic":"http://sdfsfsfsf/roompic2.png",[0-1]房间图片*
"roomStatus":"300003",[1] 房间状态值*
"roomStatusDesc":"维护中",[1] 房间状态*
"singleConsumeGold ":"3000G", [1]单局消耗金币*
"newMarker":"0", [1]最新标签
*/

#import <Foundation/Foundation.h>

@interface YSWaWaModel : NSObject
@property (nonatomic, copy) NSNumber *roomId;
@property (nonatomic, copy) NSString *singleConsumeGold;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *roomStatus;
@property (nonatomic, copy) NSString *jid;
@property (nonatomic, copy) NSString *roomStatusDesc;
@property (nonatomic, copy) NSString *isNew;

@end
