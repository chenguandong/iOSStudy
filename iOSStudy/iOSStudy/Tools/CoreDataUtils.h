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
 *  @param tableName 表名
 *  @param predicate 查询条件
 *
 *  @return YES 存在 NO不存在
 */
+(BOOL)dataisExistTableName:(NSString*)tableName withPredicate:(NSPredicate*)predicate;


/**
 *  查询数据
 *  @param tableName 查询的表明称
 *  @param predicate NSPredicate 查询条件  nil时表示没有查询条件
 *
 *  @return NSManagedObject 集合
 */
+(NSArray*)queryDataFromTableName:(NSString*)tableName andNSPredicate:(NSPredicate*)predicate;


/**
 *  删除指定表中的数据
 
 *
 *  @param tableName      表名
 *  @param andNSPredicate 删除条件  为nil 删除所有数据
 */
+(void)deleteDateFromTableName:(NSString*)tableName andNSPredicate:(NSPredicate*)andNSPredicate;
@end
