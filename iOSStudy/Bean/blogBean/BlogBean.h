//
//  BlogBean.h
//  iOSStudy
//
//  Created by chenguandong on 15/2/5.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MTLModel.h>
#import <MTLJSONAdapter.h>
@interface BlogBean : MTLModel<MTLJSONSerializing>
/**
 *  博客名字
 */
@property(nonatomic,copy)NSString*name;
/**
 *  博客标题
 */
@property(nonatomic,copy)NSString*title;
/**
 *  博客描述
 */
@property(nonatomic,copy)NSString*subTitle;
/**
 *  博客图片
 */
@property(nonatomic,copy)NSString*image;
/**
 *  博客地址
 */
@property(nonatomic,copy)NSString*url;
/**
 *  博客RSS地址
 */
@property(nonatomic,copy)NSString*rssUrl;
/**
 *  博客地址
 */
@property(nonatomic,copy)NSString*date;
@end
