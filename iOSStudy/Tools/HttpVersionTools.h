//
//  HttpVersionTools.h
//  iOSStudy
//
//  Created by chenguandong on 15/4/2.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  网络请求成功回调
 */
typedef void (^versionSuccess)(NSArray*versionLists);
/**
 *  网络请求失败回调
 */
typedef void (^versionError)();

/**
 *  网络是否链接回调
 *
 *  @param isNetWorking YES 有网络 NO 没有网络
 */
typedef void (^versionNetWorking)(BOOL isNetWorking);


@interface HttpVersionTools : NSObject


/**
 *  得到当前服务器版本号列表
 *
 *  @return 服务器版本号列表
 */
+(void)getVersions:(versionSuccess)v_success v_error:(versionError)v_error v_netWork:(versionNetWorking)v_netWork;


/**
 *  判断版本号是否向服务器请求最新数据
 *
 *  @param url http请求地址
 *
 *  @return YES 发送请求 NO 不发送请求
 */
+(BOOL)checkHttpVersion:(NSString*)url nowVersion:(NSString*)nowVersion;


/**
 *  返回服务器当前url版本号
 *
 *  @param url http请求地址
 *
 *  @return 服务器当前url版本号
 */
+(NSString*)getNowHttpVersion:(NSString*)url;


/**
 *  得到URL本地版本号
 *
 *  @param url URL地址
 *
 *  @return !nil 本地版本号 nil 没有本地版本号
 */
+(NSString*)getLocalHttpVersion:(NSString*)url;



/**
 *  存储当前服务器返回的版本号
 *
 *  @param url     http 请求地址
 *  @param version 版本号
 */
+(void)saveNowHttpVersion:(NSString*)url version:(NSString*)version;

@end
