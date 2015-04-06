//
//  CoreDataUtils.m
//  iOSStudy
//
//  Created by chenguandong on 15/4/3.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "CoreDataUtils.h"
#import <CoreData/CoreData.h>
#import "Constants .h"
@implementation CoreDataUtils

/**
 *  检查数据是否在表中已经存在
 *
 *  @param url       http地址
 *  @param tableName 表名
 *  @param rowName   数据所在的列名
 *
 *  @return YES 存在 NO 不存在
 */
+(BOOL)dataisExistTableName:(NSString*)tableName withPredicate:(NSPredicate*)predicate{

    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:tableName inManagedObjectContext:SharedApp.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    if (predicate) {
        fetchRequest.predicate = predicate;
    }
    
    NSArray *fetchedObjects = [SharedApp.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    
    
    //NSPredicate *titlePredicate = [NSPredicate predicateWithFormat:@"%@ = %@",rowName, url];

    
    if (fetchedObjects.count!=0) {
       // NSLog(@"111%lu",resultArr.count);
        return YES;
    }else{
       // NSLog(@"222%lu",resultArr.count);
        return NO;
    }
    
    
}

/**
 *  查询数据
 *  @param tableName 查询的表明称
 *  @param predicate NSPredicate 查询条件  nil时表示没有查询条件
 *
 *  @return NSManagedObject 集合
 */
+(NSArray*)queryDataFromTableName:(NSString*)tableName andNSPredicate:(NSPredicate*)predicate{

    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:tableName inManagedObjectContext:SharedApp.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // NSPredicate *titlePredicate = [NSPredicate predicateWithFormat:@"url= %@", url];
    if (predicate) {
        fetchRequest.predicate = predicate;
    }
    
    NSArray *fetchedObjects = [SharedApp.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    
    return [fetchedObjects filteredArrayUsingPredicate:predicate];


}


/**
 *  删除指定表中的数据

 *
 *  @param tableName      表名
 *  @param andNSPredicate 删除条件  为nil 删除所有数据
 */
+(void)deleteDateFromTableName:(NSString*)tableName andNSPredicate:(NSPredicate*)andNSPredicate{
    //存储之前先删除原来的数据
    
    //NSPredicate *titlePredicate = [NSPredicate predicateWithFormat:@"type= %@", @"11"];
    
    NSArray* managerObjtList = [CoreDataUtils queryDataFromTableName:tableName andNSPredicate:andNSPredicate];
    
    for (NSManagedObject *obct in managerObjtList) {
        [SharedApp.managedObjectContext deleteObject:obct];
    }
    
    
    NSError *error = nil;
    if (![SharedApp.managedObjectContext save:&error]) {
        NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
        return;
    }
    
}
@end
