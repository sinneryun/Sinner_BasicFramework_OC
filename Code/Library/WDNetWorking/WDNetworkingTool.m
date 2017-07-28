//
//  WDNetworkingTool.m
//  liudaliuda
//
//  Created by 同砚四驱-iOS-云 on 2017/5/5.
//  Copyright © 2017年 4WheelDrive-iOS. All rights reserved.
//

#import "WDNetworkingTool.h"



/// 枚举，列出请求的方式，还可以继续添加
typedef enum: NSInteger{
    GET,
    POST
} WSNetworkingRequestMethod;


@protocol WSNetworkingToolsProxy <NSObject>
/// 这个方法实际是AFN中GET,POST调用的方法 －dataTaskWithHTTPMethod
@optional
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method URLString:(NSString *)URLString parameters:(id)parameters uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

@end

@interface WDNetworkingTool()<WSNetworkingToolsProxy>

@end

@implementation WDNetworkingTool

#pragma mark - 网络工具的类方法
+(instancetype)sharedTools{
    static WDNetworkingTool *sharedTools;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedTools = [[self alloc] initWithBaseURL:nil];
        //设置网络请求超时时间
        sharedTools.requestSerializer.timeoutInterval = 30;
        sharedTools.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/octet-stream",@"text/json",@"application/json",@"text/plain",@"text/html",nil];
        [sharedTools.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        //        [sharedTools.requestSerializer setValue:@"iOS"  forHTTPHeaderField:@"platform"];
        //        [sharedTools.requestSerializer setValue:@"1.0"  forHTTPHeaderField:@"appversion"];
    });
    return sharedTools;
}

//#pragma mark - (code)封装的对象方法，把AFN方法封装为 自己的 －request（参数1，参数2，参数3，参数4）方法使用在项目中
- (void)requestWithMethod:(WSNetworkingRequestMethod)method urlString:(NSString *)urlString parameters:(id)parameters finished:(void (^)(id, NSError *,NSURLSessionDataTask *))finished{
    NSString *methodName = (method == GET) ? @"GET" : @"POST";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    
    //    [SVProgressHUD show];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    
    
    
    //1.创建网络状态监测管理者
    AFNetworkReachabilityManager *mangerStatus = [AFNetworkReachabilityManager sharedManager];
    //开启监听，记得开启，不然不走block
    [mangerStatus startMonitoring];
    //2.监听改变
    [mangerStatus setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /*
         AFNetworkReachabilityStatusUnknown = -1,
         AFNetworkReachabilityStatusNotReachable = 0,
         AFNetworkReachabilityStatusReachableViaWWAN = 1,
         AFNetworkReachabilityStatusReachableViaWiFi = 2,
         */
        //        if ((status == -1) || (status == 0)) {
        //            [WSCommonTool presentAlertViewWithTitle:@"温馨提示" message:@"当前无网络" confirmTitle:@"确定" handler:nil];
        //            return;
        //        }
    }];
    
    
    
    // 这样把success和failure，成功和失败封装到一个finished方法中
    [[self dataTaskWithHTTPMethod:methodName URLString:urlString parameters:parameters uploadProgress:nil downloadProgress:nil success:^(NSURLSessionDataTask *task, id result) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //        [SVProgressHUD dismiss];
        finished(result, nil,task);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = response.statusCode;
        
        //        NSDictionary *allHeaders = response.allHeaderFields;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [SVProgressHUD dismiss];
        
        
        //        if (statusCode == 401) {
        
        
        
        //        }else{
        
        //            [NSObject requestFailureWithStatusCode:statusCode];
        
        //        }
        finished(nil, error,task);
    }] resume];
}
#pragma mark - (code)GET 请求:token＝12345678，appversion＝1.0，cfxuseruserid＝2
+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure{
    WDNetworkingTool *manager = [WDNetworkingTool sharedTools];
    
    
    
    
//    TXLoginUserAcount *model = [TXLoginUserTool account];
//    TXLog(@"%@",model.ID);
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *token = [user objectForKey:@"token"];
//    
//    
//    [manager.requestSerializer setValue:model.account forHTTPHeaderField:@"account"];
//    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    
    
    
    
    [manager requestWithMethod:GET urlString:URLString parameters:parameters finished:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        
        if (error) {
            if (failure) {
                failure(task, error);
            }
        } else {
            if (success) {
                success(task, responseObject);
            }
        }
    }];
}

#pragma mark - (code)GET 请求:token＝12345678，appversion＝1.0，cfxuseruserid＝2
+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    WDNetworkingTool *manager = [WDNetworkingTool sharedTools];
    
//    TXLoginUserAcount *model = [TXLoginUserTool account];
//    TXLog(@"%@",model.ID);
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *token = [user objectForKey:@"token"];
//    
//    
//    
//    [manager.requestSerializer setValue:model.account forHTTPHeaderField:@"account"];
//    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    
    
    
    
    [manager requestWithMethod:POST urlString:URLString parameters:parameters finished:^(id responseObject, NSError *error, NSURLSessionDataTask *task) {
        if (error) {
            if (failure) {
                failure(task, error);
            }
        } else {
            if (success) {
                success(task, responseObject);
            }
        }
    }];
}


@end
