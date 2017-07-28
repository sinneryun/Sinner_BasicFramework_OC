//
//  WDNetworkingTool.h
//  liudaliuda
//
//  Created by 同砚四驱-iOS-云 on 2017/5/5.
//  Copyright © 2017年 4WheelDrive-iOS. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface WDNetworkingTool : AFHTTPSessionManager

/** GET 请求:token＝12345678，appversion＝1.0，cfxuseruserid＝2*/
+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
/** POST 请求:token＝12345678，appversion＝1.0，cfxuseruserid＝2 */
+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;



@end
