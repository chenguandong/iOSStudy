//
//  WebBean.h
//  iOSStudy
//
//  Created by chenguandong on 15/2/17.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MTLModel.h>
#import <MTLJSONAdapter.h>
@interface WebBean : MTLModel<MTLJSONSerializing>
/**
 *  网站名字
 */
@property(nonatomic,copy)NSString*name;
/**
 *  网站标题
 */
@property(nonatomic,copy)NSString*title;
/**
 *  网站描述
 */
@property(nonatomic,copy)NSString*subTitle;
/**
 *  网站图片
 */
@property(nonatomic,copy)NSString*webImage;
/**
 *  网站地址
 */
@property(nonatomic,copy)NSString*webUrl;
@end
