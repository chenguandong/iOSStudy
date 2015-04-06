//
//  HttpVersionTools.m
//  iOSStudy
//
//  Created by chenguandong on 15/4/2.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "HttpVersionTools.h"
#import "NetWorkTools.h"
#import "JsonTools.h"
#import <Mantle.h>
#import "VersionBean.h"
#import "CoreDataUtils.h"
@implementation HttpVersionTools

+(void)getVersions:(versionSuccess)v_success v_error:(versionError)v_error v_netWork:(versionNetWorking)v_netWork{
    
    
   __block NSMutableArray*versionArr = [NSMutableArray arrayWithCapacity:5];
    
    [NetWorkTools postHttp:Adress_versions success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON: %@", [operation responseString]);
        
        NSArray *dic = [JsonTools getJsonNSDictionary:[operation responseString]];
        
        //将JSON数据和Model的属性进行绑定
        
        NSArray *arr = [MTLJSONAdapter modelsOfClass:[VersionBean class] fromJSONArray:dic error:nil];
        
        versionArr = [arr copy];
        
//        for (VersionBean *vBean in versionArr) {
//            NSLog(@"version =%@",vBean.urlVersion);
//        }
        
        v_success(versionArr);
        
    } error:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        v_error();
        
    } isNetworking:^(BOOL isNetwork) {
        

        v_netWork(isNetwork);
    }];
    
    
}

/**
 *  返回服务器当前url版本号
 *
 *  @param url http请求地址
 *
 *  @return 服务器当前url版本号
 */
+(NSString*)getNowHttpVersion:(NSString*)url{
    
    NSString *versionStr ;
    for (VersionBean *vBean in SharedApp.versionLists) {
        
        
        if ([vBean.url isEqualToString:url]) {
            
            versionStr =  vBean.urlVersion;
            return versionStr;
        }else{
            versionStr = nil;
        }
    }
    NSLog(@"nowVersion = %@",versionStr);
    return versionStr;
}


/**
 *  存储当前服务器返回的版本号
 *
 *  @param url     http 请求地址
 *  @param version 版本号
 */
+(void)saveNowHttpVersion:(NSString*)url version:(NSString*)version{
    
    NSString *log ;
    
    //当数据存在事后执行更新操作
    //[CoreDataUtils dataisExist:url inTable:CD_VersionsEntity tableRowName:@"url"]
    NSPredicate *urlPredicate = [NSPredicate predicateWithFormat:@"url = %@", url];
    if (
        [CoreDataUtils dataisExistTableName:CD_VersionsEntity withPredicate:urlPredicate]
        )
        
    {
        
        
        NSPredicate *urlPredicate = [NSPredicate predicateWithFormat:@"url= %@", url];
        
        NSArray *managerList = [CoreDataUtils queryDataFromTableName:CD_VersionsEntity andNSPredicate:urlPredicate];
        
        if (managerList.count!=0) {
           NSManagedObject *updateObjt=  managerList.firstObject;
            [updateObjt setValue:url forKey:@"url"];
            [updateObjt setValue:version forKey:@"url_version"];
        }
        
        log = @"版本更新成功";
            
    }
    else
        //当数据不存在的事后执行插入操作
    {
        NSManagedObject *managerObjt =[NSEntityDescription insertNewObjectForEntityForName:CD_VersionsEntity inManagedObjectContext:SharedApp.managedObjectContext];
        
        
        [managerObjt setValue:url forKey:@"url"];
        [managerObjt setValue:version forKey:@"url_version"];;
        
        log = @"版本插入成功";
        
    }
    
    NSError *error;
    if (![SharedApp.managedObjectContext save:&error])
    {
        NSLog(@"%@: %@", log,[error localizedDescription]);
        
    }

    
}



/**
 *  判断版本号是否向服务器请求最新数据
 *
 *  @param url http请求地址
 *
 *  @return YES 发送请求 NO 不发送请求
 */
+(BOOL)checkHttpVersion:(NSString*)url nowVersion:(NSString*)nowVersion{
    
    
    
    
    if (nowVersion!=nil) {
        //从数据库拿到URL 版本号  如果没有说明第一次请求 直接发送请求
        
        if ([[self getLocalHttpVersion:url]floatValue]!=[nowVersion floatValue]) {
            
            
            
            return YES;
        }else{
            return NO;
        }
    }else{
        return YES;
    }
    

}

/**
 *  得到URL本地版本号
 *
 *  @param url URL地址
 *
 *  @return !nil 本地版本号 nil 没有本地版本号
 */
+(NSString*)getLocalHttpVersion:(NSString*)url{
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:CD_VersionsEntity inManagedObjectContext:SharedApp.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [SharedApp.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    
    NSPredicate *titlePredicate = [NSPredicate predicateWithFormat:@"url = %@", url];
    
    
    NSArray *resultArr = [fetchedObjects filteredArrayUsingPredicate:titlePredicate];
    if (resultArr.count!=0) {
        NSLog(@"111%lu",resultArr.count);
        
        NSManagedObject *objt = resultArr[0];
        
        
        return [objt valueForKey:@"url_version"];
    }else{
        NSLog(@"没有查到本地版本%lu",resultArr.count);
        return nil;
    }
    

}

@end
