//
//  WebBean.m
//  iOSStudy
//
//  Created by chenguandong on 15/2/17.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "WebBean.h"

@implementation WebBean

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    
    
    return @{
             @"name": @"name",
             @"title": @"title",
             @"subTitle": @"subTitle",
             @"webImage": @"webImage",
             @"webUrl": @"webUrl"
             };
}

@end
