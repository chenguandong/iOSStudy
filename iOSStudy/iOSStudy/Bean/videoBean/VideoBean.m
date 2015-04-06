//
//  VideoBean.m
//  iOSStudy
//
//  Created by chenguandong on 15/2/22.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "VideoBean.h"

@implementation VideoBean

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    
    [super JSONKeyPathsByPropertyKey];
    return @{
             @"videoLanguageType": @"videoLanguageType",
             };
}
@end
