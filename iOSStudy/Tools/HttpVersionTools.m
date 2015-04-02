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
@implementation HttpVersionTools

-(NSArray*)getVersions{
    
    
   __block NSMutableArray*versionArr = [NSMutableArray arrayWithCapacity:5];
    
    [NetWorkTools postHttp:Adress_versions success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON: %@", [operation responseString]);
        
        NSArray *dic = [JsonTools getJsonNSDictionary:[operation responseString]];
        
        //将JSON数据和Model的属性进行绑定
        
        NSArray *arr = [MTLJSONAdapter modelsOfClass:[VersionBean class] fromJSONArray:dic error:nil];
        
        
        
        versionArr = [arr copy];
        

        for (VersionBean *bean in arr) {
            NSLog(@"%@",bean.urlVersion);
            {
                NSManagedObject *managerObjt =[NSEntityDescription insertNewObjectForEntityForName:CD_VersionsEntity inManagedObjectContext:SharedApp.managedObjectContext];
                
                
                [managerObjt setValue:bean.url forKey:@"url"];
                [managerObjt setValue:bean.urlVersion forKey:@"url_version"];
                
                NSError *error;
                if (![SharedApp.managedObjectContext save:&error])
                {
                    NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
                }
                
            }
        }
        
        
        
        
    } error:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        
    } isNetworking:^(BOOL isNetwork) {
        
        

    }];
    
    
    return versionArr;
}
@end
