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

#define Address_blogs @"https://raw.githubusercontent.com/chenguandong/iOSStudy/master/iOSStudyJsonData/blogs.json"
#define Adress_webs @"https://raw.githubusercontent.com/chenguandong/iOSStudy/master/iOSStudyJsonData/webs.json"
#define Adress_videos @"https://raw.githubusercontent.com/chenguandong/iOSStudy/master/iOSStudyJsonData/videos.json"
#define SharedApp ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define CD_FAVOURITE_BEAN @"FavouriteBean"
#endif
