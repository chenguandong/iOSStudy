//
//  FavouriteBean.h
//  iOSStudy
//
//  Created by chenguandong on 15/3/2.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FAVOURITE_TYPE) {
    BLOG_TYPE = 1,
    WEB_TYPE = 2,
    VIDEO_TYPE = 3
};

@interface FavouriteBean : NSObject
/**
 *  标题
 */
@property(nonatomic,copy)NSString *title;
/**
 *  描述
 */
@property(nonatomic,copy)NSString *subtitle;
/**
 *  图片地址
 */
@property(nonatomic,copy)NSString *image_name;
/**
 *  网络连接
 */
@property(nonatomic,copy)NSString *url;
/**
 *  类型 1 收藏博客 2 收藏网站 3 收藏视频   11,持久化博客  22,持久化网站 33,持久化视频
 */
@property(nonatomic,copy)NSString* type;
@end
