//
//  NetWorkTools.h
//  iOSStudy
//
//  Created by chenguandong on 15/1/31.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "Constants .h"

typedef void(^success)(AFHTTPRequestOperation *operation, id responseObject) ;
typedef void(^error)(AFHTTPRequestOperation *operation, NSError *error);
typedef void(^isNetwork) (BOOL isNetwork);

@interface NetWorkTools : NSObject



+ (instancetype)sharedInstance;

+(void)postHttp:(NSString*)httpUrl success:(success)success error:(error)error isNetworking:(isNetwork)isNetworking;

/*
 *检查网络连接注册通知
 */
+(void)checkNetworking;
@end
