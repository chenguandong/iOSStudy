//
//  CoreDataUtils.h
//  iOSStudy
//
//  Created by chenguandong on 15/4/3.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataUtils : NSObject
/**
 *  检查数据是否在表中已经存在
 *
 *  @param url       http地址
 *  @param tableName 表名
 *  @param rowName   数据所在的列名
 *
 *  @return YES 存在 NO 不存在
 */
+(BOOL)dataisExist:(NSString*)url inTable:(NSString*)tableName tableRowName:(NSString*)rowName;
@end
