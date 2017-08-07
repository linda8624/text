/*
 
 *********************************************************************************
 *
 * 在使用BAKit的过程中如果出现bug请及时以以下任意一种方式联系我，我会及时修复bug
 *
 * QQ     : 博爱1616【137361770】
 * 微博    : 博爱1616
 * Email  : 137361770@qq.com
 * GitHub : https://github.com/boai
 * 博客园  : http://www.cnblogs.com/boai/
 * 博客    : http://boai.github.io
 
 *********************************************************************************
 
 */

#import "BANewsNetManager.h"
#import "BAURLsPath.h"
//static AFHTTPSessionManager *manger = nil;

@implementation BANewsNetManager



+ (id)postStatusWithURL:(NSString *)urlStr  withPostText:(NSDictionary *)postText success:(successBlock)success failure:(failureBlocks)failure{
    
    return [BANetManager ba_request_POSTWithUrlString:urlStr isNeedCache:YES parameters:postText successBlock:^(id response) {
        success(response);
    } failureBlock:^(NSError *error) {
        failure(error);
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}
+ (id)getStatusWithURL:(NSString *)urlStr  withPostText:(NSDictionary *)postText success:(successBlock)success failure:(failureBlocks)failure{
    
    return [BANetManager ba_request_GETWithUrlString:urlStr isNeedCache:YES parameters:postText successBlock:^(id response) {
        success(response);
        
    } failureBlock:^(NSError *error) {
        failure(error);
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

@end
