//
//  WelcomeTools.h
//  iOSStudy
//
//  Created by chenguandong on 15/4/10.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

static Reachability  *reach;
@interface WelcomeTools : NSObject

+ (instancetype)sharedInstance ;


@end
