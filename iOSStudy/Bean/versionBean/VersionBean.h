//
//  VersionBean.h
//  iOSStudy
//
//  Created by chenguandong on 15/4/2.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MTLModel.h>
#import <MTLJSONAdapter.h>
@interface VersionBean : MTLModel<MTLJSONSerializing>
/**
 *  当前请求地址的URL
 */
@property(nonatomic,copy)NSString *url;

/**
 *  当前请求地址URL版本号
 */
@property(nonatomic,copy)NSString *urlVersion;

@end
