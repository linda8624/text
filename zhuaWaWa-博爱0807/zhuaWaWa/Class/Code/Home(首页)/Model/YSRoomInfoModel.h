/*"jid":"122008973984738399" [1] jid
"roomId":"1002", [1] 房间ID
"pic":"http://...../xx.png", [1] 房间截图
"videoUrlA":"rtmp://pili-live-r.....", [1] 房间A路直播url
"videoUrlB":"rtmp://pili-live-r.....", [1] 房间B路直播url
"gameExpendGold":3000, [1] 单局需消耗金币
"gameDuration":"", [1] 游戏时长   毫秒数
"gameStatus":0,[1] 当前游戏状态
"gameStatusRemainDuration":-1, [1] 当前状态剩余时长   毫秒数
"waittingUserNum":3, [1] 当前排队人数
"myWaittingIndex":2, [1] 当前我的等候序号
"totalUserNum":399, [1] 当前房间总人数
"curGid":"17324322008973984738399" [1] 当前游戏gid
"curGameStartTime":"", [1] 当前游戏开始时间戳
"curGameEndTime":"", [1] 当前游戏结束时间
"curGamerAuid":"171293911228973984738399", [1] 当前玩家auid
"curGamer":"鲷鱼台", [1] 当前玩家姓名
"curGameExpendGold":3000,[1] 当前玩家需消耗金币
"curGamerHoldRemainCount":3, [1] 当前玩家霸机剩余次数
"curGamerHoldExpendGold":6000, [1] 当前玩家霸机需消耗金币
"holdWaitTime":"5000",[1] 霸机决策时长  毫秒
"nextGamerAuid":"1228973984738399", [1] 下一个玩家auid
"isCollected":0, [1] 是否已关注
"userRemainGold":30000000, [1] 我的金币余额
"boxRemainTime":3630, [1] 我的宝箱剩余打开时间
 */

#import <Foundation/Foundation.h>

@interface YSRoomInfoModel : NSObject
@property (nonatomic, copy) NSString *jid;
@property (nonatomic, copy) NSString *roomId;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *videoUrlA;
@property (nonatomic, copy) NSString *videoUrlB;
@property (nonatomic, copy) NSString *gameExpendGold;
@property (nonatomic, copy) NSString *gameDuration;
@property (nonatomic, copy) NSNumber *gameStatus;
@property (nonatomic, copy) NSString *gameStatusRemainDuration;
@property (nonatomic, copy) NSString *waittingUserNum;
@property (nonatomic, copy) NSNumber *myWaittingIndex;
@property (nonatomic, copy) NSString *totalUserNum;
@property (nonatomic, copy) NSString *curGid;
@property (nonatomic, copy) NSString *curGameStartTime;
@property (nonatomic, copy) NSString *curGameEndTime;
@property (nonatomic, copy) NSString *curGamerAuid;
@property (nonatomic, copy) NSString *curGamer;
@property (nonatomic, copy) NSString *curGameExpendGold;
@property (nonatomic, copy) NSString *curGamerHoldRemainCount;
@property (nonatomic, copy) NSString *curGamerHoldExpendGold;
@property (nonatomic, copy) NSString *holdWaitTime;
@property (nonatomic, copy) NSString *nextGamerAuid;
@property (nonatomic, copy) NSString *isCollected;
@property (nonatomic, copy) NSString *userRemainGold;
@property (nonatomic, copy) NSString *boxRemainTime;
@end
