//
//  JsonTools.m
//  iOSStudy
//
//  Created by chenguandong on 15/2/5.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "JsonTools.h"

@implementation JsonTools



+(id)getJsonNSDictionary:(NSString *)jsonString{
    NSData *data =  [ jsonString  dataUsingEncoding:NSUTF8StringEncoding];
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    id JsonObjectAll = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    
    return JsonObjectAll;
}

@end
