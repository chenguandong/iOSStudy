//
//  BlogJsonBean.m
//  iOSStudy
//
//  Created by chenguandong on 15/4/2.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "BlogJsonBean.h"

@implementation BlogJsonBean

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    
    
    return @{
             @"version": @"version",
             @"bloglists": @"bloglists"
             };
}

@end
