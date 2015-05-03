//
//  Constants .h
//  iOSStudy
//
//  Created by chenguandong on 15/2/3.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//


#import "AppDelegate.h"
#ifndef iOSStudy_Constants__h
#define iOSStudy_Constants__h

//1 OSchina 0 github

#define kHttpSource 0

#if kHttpSource

/****OSChina数据源地址*****/
#define Address_blogs @"https://git.oschina.net/FooKaa/helloworld/raw/master/blogs.json"
#define Adress_webs @"https://git.oschina.net/FooKaa/helloworld/raw/master/webs.json"
#define Adress_videos @"https://git.oschina.net/FooKaa/helloworld/raw/master/videos.json"

#define Adress_versions @"https://git.oschina.net/FooKaa/helloworld/raw/master/versions.json"


#else
/**
 github 数据源地址**/
 
 #define Address_blogs @"https://raw.githubusercontent.com/chenguandong/iOSStudy/CoreDataJoin/iOSStudyJsonData/blogs.json"
 #define Adress_webs @"https://raw.githubusercontent.com/chenguandong/iOSStudy/CoreDataJoin/iOSStudyJsonData/webs.json"
 #define Adress_videos @"https://raw.githubusercontent.com/chenguandong/iOSStudy/CoreDataJoin/iOSStudyJsonData/videos.json"
 
 #define Adress_versions @"https://raw.githubusercontent.com/chenguandong/iOSStudy/CoreDataJoin/iOSStudyJsonData/versions.json"

#endif


#define SharedApp ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
/**
 *  收藏的数据库表明
 */
#define CD_FAVOURITE_BEAN @"FavouriteBean"

/**
 *  http版本号数据库表明
 */
#define CD_VersionsEntity @"VersionsEntity"


static NSString *const textNameFavourite = @"收藏";
static NSString *const textNameUnFavourite = @"取消收藏";

static NSString *const TYPE_BLOG_SIMPLE_TYPE = @"1";
static NSString *const TYPE_WEB_SIMPLE_TYPE = @"2";
static NSString *const TYPE_VIDEO_SIMPLE_TYPE = @"3";

static NSString *const TYPE_BLOG_FAVOURITE_TYPE = @"11";
static NSString *const TYPE_WEB_FAVOURITE_TYPE = @"22";
static NSString *const TYPE_VIDEO_FAVOURITE_TYPE = @"33";



#endif
