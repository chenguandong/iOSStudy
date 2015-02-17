//
//  BlogBean.m
//  iOSStudy
//
//  Created by chenguandong on 15/2/5.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "BlogBean.h"

@implementation BlogBean
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    
    
    return @{
             @"name": @"name",
             @"title": @"title",
             @"subTitle": @"subTitle",
             @"image": @"image",
             @"url": @"url",
             @"rssUrl": @"rssUrl",
             @"date": @"date"
    
             };
}
@end
