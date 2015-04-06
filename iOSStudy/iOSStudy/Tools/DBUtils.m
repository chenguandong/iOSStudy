//
//  DBUtils.m
//  iOSStudy
//
//  Created by chenguandong on 15/2/25.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "DBUtils.h"


/**
 *  博客表表名
 */
NSString *const blogsTableName = @"blogs";
/**
 *  数据库名字
 */
NSString *const DBPath = @"iOSStudy.db";

@implementation DBUtils

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^
    
    {
        sharedInstance = [[self alloc] init];
        
        [self createDB];
    });
        
        return sharedInstance;
    }


/**
 *  回去数据库地址
 *
 *  @return 数据库地址
 */
+(NSString*)getDBPath{

    return [PATH_OF_DOCUMENT stringByAppendingPathComponent:DBPath];
}


/**
 *  执行数据库操作
 *
 *  @param fmdb_block 执行数据库操作回调
 */
+(void)executeSQL:(FMDB)fmdb_block{
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[self getDBPath]];
    [queue inDatabase:fmdb_block];
}

/**
 *  创建数据库和表
 */
+(void)createDB{

    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:[self getDBPath]] == NO) {
        // create it
        FMDatabase * db = [FMDatabase databaseWithPath:[self getDBPath]];
    
        if ([db open]) {
            NSString * sql = [NSString stringWithFormat:@"CREATE TABLE '%@' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , 'title' VARCHAR(255), 'subtitle' VARCHAR(255),'image_name' VARCHAR(255)),'url' VARCHAR(255)),'type' INTEGER)",blogsTableName];
            
            if (![db tableExists:blogsTableName]) {
                BOOL res = [db executeUpdate:sql];
                if (!res) {
                    NSLog(@"error when creating db table blogs");
                } else {
                    NSLog(@"succ to creating db table blogs");
                }

            }else{
                NSLog(@"blogsTableName has ready created!");
            }
            [db close];
        } else {
            NSLog(@"error when open db");
        }
    }
}
@end
