//
//  DBUtils.h
//  iOSStudy
//
//  Created by chenguandong on 15/2/25.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import <Foundation/Foundation.h>


#import <FMDB.h>
#import "Constants .h"

typedef void(^FMDB)(FMDatabase *db);


typedef void (^executeSqlStart)();

typedef void (^executeSqlSuccess)(BOOL isSqlSuccess);

typedef void (^executeSqlFail)(BOOL isFail);

@interface DBUtils : NSObject
/**
 *  执行数据库操作
 *
 *  @param fmdb_block 执行数据库操作回调
 */
+(void)executeSQL:(FMDB)fmdb_block;
@end
